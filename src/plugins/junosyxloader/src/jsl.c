/*
  jsl.c - read Convert sysex bulk copy from Juno-1/Juno-2 and
  send it the emulator.

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.







  (extracted from Juno 2 sercice notes) 
  the structure of a SYX block is : 
  F0 41 37 00 23 20 01 00      BULK DUMP (BLD)
  repeated 16 times {
    <4 tones> 64 bytes each in 4-bit nibbles right justified, least
  significant nibble sent first. 
    F7 
  }

  a Tone is :

        msb                                       lsb
  byte |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0  |

    0  | DCO AFTER DEPTH       | VCF KEY FOLLOW        |
    1  | VCF AFTER DEPTH       | VCA AFTER DEPTH       |
    2  | ENV KEY FOLLOW        | DCO BENDER RANGE      |
    3  | *** | DCO LFO MOD DEPTH                       |
    4  | b00 | DCO ENV MOD DEPTH                       |
    5  | b01 | DCO PULSE PW/PWM DEPTH                  |
    6  | b02 | DCO PWM RATE                            |
    7  | b03 | VCF CUTOFF FREQ                         |
    8  | b04 | VCF RESONANCE                           |
    9  | b05 | VCF ENV MODE DEPTH                      |
   10  | b06 | VCF FLO MODE DEPTH                      |
   11  | b07 | VCA LEVEL                               |
   12  | b08 | LFO RATE                                |
   13  | b09 | LFO DELAY                               |
   14  | b10 | ENV T1                                  |
   15  | b11 | ENV L1                                  |
   16  | b12 | ENV T2                                  |
   17  | b13 | ENV L2                                  |
   18  | b14 | ENV T3                                  |
   19  | b15 | ENV L3                                  |
   20  | b16 | ENV T4                                  |
   21  | b17 | *** | TONE NAME - 1                     |
   22  | b18 | *** | TONE NAME - 2                     |
   23  | b19 | *** | TONE NAME - 3                     |
   24  | b20 | *** | TONE NAME - 4                     |
   25  | b21 | *** | TONE NAME - 5                     |
   26  | b22 | *** | TONE NAME - 6                     |
   27  | c 1   c 0 | TONE NAME - 7                     |
   28  | c 3   c 2 | TONE NAME - 8                     |
   29  | c 5   c 4 | TONE NAME - 9                     |
   30  | c 7   c 6 | TONE NAME -10                     |
   31  |                      0 (dummy)                |




 */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#include <csdl.h>

#define MAX_FICNAME  1024
#define TONE_SIZE 64
#define BUFSIZE 0x10A0

static char ficbuf[BUFSIZE + 1];
static char savebuf[TONE_SIZE + 1];

static unsigned char ficname[MAX_FICNAME + 1];
static int curTone = 0 ;


#define READ_BYTE(count) (ficbuf[count]) | (ficbuf[count + 1])<<4
#define READ_BYTE_TONEBUF(count) (savebuf[count]) | (savebuf[count + 1])<<4
#define WRITE_BYTE_TONEBUF(count,val) savebuf[count] = (val & 0xF); savebuf[count + 1] = ((val & 0xF0) >>4);
#define WRITE_BYTE(count,val) ficbuf[count] = (val & 0xF); ficbuf[count + 1] = ((val & 0xF0) >>4);


/* Read parameters structure */
typedef struct {
  OPDS h;
  MYFLT *out;              /* out value        */
  STRINGDAT *ficname;      /* SYX filename     */
  MYFLT*tone;              /* tone number      */
  STRINGDAT *paramname;    /* param name       */
} getjuparm_t ;

typedef struct {
  OPDS h;
  STRINGDAT *out;         /* out value         */
  STRINGDAT *ficname;     /* SYX filename      */
  MYFLT *tone;            /* tone number       */
  MYFLT *group;           /*  getname : 0 : Preset, 1 : Memory, 2 : Cartridge (for P/M/C prefix)  */
                          /*  copypaste :   0: copy, 1: paste                                     */
} getjuname_t ;

typedef struct {
  OPDS h;
  MYFLT *out;              /* out value        */
  STRINGDAT *ficname;      /* SYX filename     */
  MYFLT*tone;              /* tone number      */
  STRINGDAT *paramname;    /* param name       */
  MYFLT*newval;            /* new param value  */
} setjuparm_t ;

typedef struct {
  OPDS h;
  MYFLT *out;              /* out value        */
  STRINGDAT *ficname;      /* SYX filename     */
  MYFLT *tone;             /* tone number      */
  STRINGDAT *tonename;     /* tone name        */
} setjuname_t ;

typedef struct {
  OPDS h;
  MYFLT *out;              /* out value        */
  STRINGDAT *ficname;      /* SYX filename     */
} verifsyx_t ;





#define NB_PARMS 37
const char *t_parms[NB_PARMS + 1] =
  {"PresetName",
   "dcoaftr",  "vcfkybd",  "vcfaftr",  "vcaaftr",
   "envkybd",  "dcobnd",   "dcolfo",   "chorus",
   "dcoenvd", "pwpwm","pwmrate","dcoenv",
   "vcffreq", "vcfreso","vcfenv","vcfenvd",
   "vcflfo", "vcaenv","vcalevl","lforate",
   "lfodely","sub","envt1","envl1",
   "envt2","sawtooth","envl2","envt3",
   "pulse","envl3","envt4","hpffreq",
   "dcorng","sublevl","noislvl","crsrate"
  };
const int t_offset[NB_PARMS + 1] =
  {42,
    0,  0,  2,  2,
    4,  4,  6,  8,
    8, 10, 12, 10,
   14, 16, 14, 18,
   20, 18, 22, 24,
   26, 22, 28, 30,
   32, 28, 34, 36,
   34, 38, 40, 38,
   42, 46, 50, 54
  };


const int t_chars[] =
  { 63,  62,  0, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,  0,  0,  0,  0,  0,  0,  0,
     0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
    20, 21, 22, 23, 24, 25,  0,  0,  0,  0,  0,  0, 26, 27, 28, 29, 30, 31, 32, 33,
    34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,  0,  0
  };







MYFLT get_offset( MYFLT tone,char* parmname) {
  int offset, poff, i;

  if (tone < -1 || tone > 64)  return 0;
  offset = tone;

  for (i = 0; i < NB_PARMS; i++) {
    /*   printf("tab: <%s>\n",t_parms[i]);*/
    if (strcmp(parmname, t_parms[i]) == 0) break;
  }
  poff = t_offset[i];
  if (tone == -1) return poff ;
  else return 64 * offset + (int)((offset) / 4 + 1 ) * 9 + (int)(offset / 4)  + poff  ;
}


void savebank(char* pficname) {
  FILE *fp1;
  int ret = 0 ;
  if (strlen(pficname) > MAX_FICNAME) {
    return;
  }
  
  if ((fp1 = fopen(pficname, "wb")) == NULL) return ;
  strcpy(ficname,pficname);
  ret =  fwrite(ficbuf, 1, BUFSIZE, fp1);  /* 4256*/
  fclose(fp1) ;

}

void loadbank(char* pficname) {
  FILE *fp1;
  int ret = 0 ;
  if (strlen(pficname) > MAX_FICNAME) {
    return;
  }
  
  /* is it the current bank ?*/
  if (strcmp(ficname, pficname) != 0) {
    if ((fp1 = fopen(pficname, "rb")) == NULL) return ;
    /*     printf("reading file \n");*/
    strcpy(ficname,pficname);
    ret =  fread(ficbuf, 1, BUFSIZE, fp1);  /* 4256*/
    /* printf("bytes read:  %d\n",ret); */
    fclose(fp1) ;
  }
}




#define TEST_HEADER( a, p )   if ((ficbuf[count] & 0xFF) != a) {*p->out = 0; return NOTOK;} else count++; 


/* sets name in the internal tone buffer */
int int_setjuname(int tone, char* name) {
  char tablechars[64] = "ABCDEFGHIJKLMNOPKRSTUVWXYZabcdefghijklmnopkrstuvwxyz0123456789 -";
  char pname[11] = "          ";
  int offset, offsettone ;
  
  int idx;
  unsigned int value, preval, newval;
  unsigned int car;
    

  offset = get_offset(tone,"PresetName") ; /* + 42; */
  /* printf("offset : %d\n",offset); */



  for (idx = 0; idx < 10; idx++) {

    preval = READ_BYTE(offset) ;
    if (name[idx] == 32) car = 1 ; else car = name[idx] - 45;
    if (((car > 80) || (car < 0)) && (car != 32)) {
      return 0;
    }

    value = (preval & 0b11000000) + t_chars[car];
    WRITE_BYTE(offset, value );
    offset += 2; 
  }
  return 1;

}



int verifsyx(CSOUND *csound, verifsyx_t* p) {
  int count = 0, i, j;
  loadbank(p->ficname->data);
  
  *p->out =1; 
  for (j=0; j < 16; j++) {
    TEST_HEADER(0xF0 , p) ;
    TEST_HEADER(0x41, p) ;
    TEST_HEADER(0x37, p) ;
    TEST_HEADER(0x00, p) ;
    TEST_HEADER(0x23, p) ;
    TEST_HEADER(0x20, p) ;
    TEST_HEADER(0x01, p) ;
    TEST_HEADER(0x00, p) ;

    for (i =0; i < 4; i++) {
      count += 63 ;
      TEST_HEADER(0x00, p) ;
    }
    TEST_HEADER(0x00, p) ;
    TEST_HEADER(0xF7, p) ;
    
  }
    
  return OK  ;

}





int emptysyx(CSOUND *csound, verifsyx_t* p) {
  int count = 0, i, j;
  
  *p->out =1; 
  for (j=0; j < 16; j++) {
    /* printf("count : %X\n",count); */
    ficbuf[count] = 0xF0; count++; 
    ficbuf[count] = 0x41; count++; 
    ficbuf[count] = 0x37; count++; 
    ficbuf[count] = 0x00; count++; 
    ficbuf[count] = 0x23; count++; 
    ficbuf[count] = 0x20; count++; 
    ficbuf[count] = 0x01; count++; 
    ficbuf[count] = 0x00; count++; 
    ficbuf[count] = j*4; count++; 

    for (i =0; i < 4; i++) {
      memset(&ficbuf[count],0, 63 * sizeof(ficbuf[count])) ;
      count += 63 ;
      ficbuf[count] = 0x00; count++;
      int_setjuname(j*4 + i,"J-21 Empty");
      
    }
    ficbuf[count] = 0xF7; count++; 
    
  }
  savebank(p->ficname->data);
  return OK  ;

}


int dump_char(char* mybuf, int l) {
  char mychars[16] = { '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' };
  int idx;

  for (idx  = 0 ; idx < l; idx++ ) {
    printf("%c%c ", mychars[((mybuf[idx] & 0xF0) >> 4)], mychars[((mybuf[idx] & 0x0F) )]);
  }
  


}

int initjubuf(CSOUND *csound) {
  printf("Delete internal buffer\n");
  memset(savebuf,TONE_SIZE,sizeof(char));
  return OK;

}

int jupaste(CSOUND *csound, getjuparm_t* p) {
  int offset;
  loadbank(p->ficname->data);

  /* printf("in jupaste\n"); */
  
  /* past mode */
  /*  printf("paste to %s, offset %d\n",p->ficname->data, offset);*/
  offset = get_offset(*p->tone,"dcoaftr") ; /* first parameter */
  memcpy(&(ficbuf[offset]), savebuf, TONE_SIZE);
  
  int_setjuname(*p->tone, p->paramname->data);
  savebank(p->ficname->data);
  
    /* dump_char(&(ficbuf[offset]),TONE_SIZE); */

}



int getjuname(CSOUND *csound, getjuname_t* p) {

  char tablechars[64] = "ABCDEFGHIJKLMNOPKRSTUVWXYZabcdefghijklmnopkrstuvwxyz0123456789 -";
  char pname[11]="          ";
  int offset ;
  int toneb10;
  unsigned int value;
  loadbank(p->ficname->data);
  offset = get_offset(*p->tone,"PresetName") ; /* + 42; */
  toneb10 = *p->tone;

    

  /* byte 21 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[0] = tablechars[value&0b00111111];
      
  /* byte 22 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[1] = tablechars[value&0b00111111];
  
  /* byte 23 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[2] = tablechars[value&0b00111111];
      
  /* byte 24 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[3] = tablechars[value&0b00111111];
      
  /* byte 25 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[4] = tablechars[value&0b00111111];
      
  /* byte 26 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[5] = tablechars[value&0b00111111];
  
  /* byte 27 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[6] = tablechars[value&0b00111111];
      
  /* byte 28 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[7] = tablechars[value&0b00111111];
      
  /* byte 29 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[8] = tablechars[value&0b00111111];
  
  /* byte 30 */
  value = READ_BYTE(offset) ;
  offset +=2;
  pname[9] = tablechars[value&0b00111111];

  if (*p->group == 0) {
    sprintf(p->out->data,"P-%d%d  ",toneb10/8 + 1, toneb10 % 8 + 1 ) ;
  } else if  (*p->group == 1) {
    sprintf(p->out->data,"M-%d%d  ",toneb10/8 + 1, toneb10 % 8 + 1 ) ;
  } else if  (*p->group == 2) {
    sprintf(p->out->data,"C-%d%d  ",toneb10/8 + 1, toneb10 % 8 + 1 ) ;
  }
    

  if (p->out->size < strlen(pname)) {
    strcat(p->out->data,"X") ;
  }
  else {
    strcat(p->out->data,pname);
  }

  return OK;
}


int setjuname(CSOUND *csound, setjuname_t* p) {

  char tablechars[64] = "ABCDEFGHIJKLMNOPKRSTUVWXYZabcdefghijklmnopkrstuvwxyz0123456789 -";
  char pname[11] = "          ";
  int offset ;
  int idx;
  unsigned int value, preval, newval;
  unsigned int car;
    
  if (strlen(p->tonename->data) > 16) {
    *p->out = -1;
    return NOTOK;
  }

  strcpy(pname, p->tonename->data);
  

  loadbank(p->ficname->data);
  if (int_setjuname(*p->tone, pname) )
    return OK;
  else
    return NOTOK;
    
}



#define TEST01(p) if ((*p->newval > 1) || (*p->newval < 0)) {*p->out = -1; return NOTOK; }
#define TEST03(p) if ((*p->newval > 3) || (*p->newval < 0)) {*p->out = -1; return NOTOK; }
#define TEST05(p) if ((*p->newval > 5) || (*p->newval < 0)) {*p->out = -1; return NOTOK; }
#define TEST015(p) if ((*p->newval > 15) || (*p->newval < 0)) {*p->out = -1; return NOTOK; }
#define TEST0127(p) if ((*p->newval > 127) || (*p->newval < 0)) {*p->out = -1; return NOTOK; }


int setjuparm(CSOUND *csound, setjuparm_t* p) {
  int offset= 0, toneb10 = 0, offsettone = 0 ;
    unsigned int value, b[22], c[7],preval, newval;
  
  loadbank(p->ficname->data);
  offset = get_offset(*p->tone, p->paramname->data);
  offsettone = get_offset(-1, p->paramname->data);
  newval = (int) (*p->newval);
  printf(" file : <%s>, tone : %d, param: <%s> offset  :%d  offsettone:%d  newval ==> %d\n",
	 p->ficname->data, (int)*p->tone, p->paramname->data,offset,offsettone,newval);

  /* byte 0 */
  if (strcmp(p->paramname->data,"dcoaftr") == 0) {
    TEST015 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0xF) + (newval<<4);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"vcfkybd") == 0) {
    TEST015 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0xF0) + (newval);
    /*    printf("preval : %X  preval & F0:%X, newval:%d, postval : %X\n", preval, (preval & 0xF0),newval, value);*/
    WRITE_BYTE_TONEBUF(offsettone, value )
    
  }


  /* byte 1 */
  if (strcmp(p->paramname->data,"vcfaftr") == 0) {
    TEST015 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0xF) + (newval<<4);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"vcaaftr") == 0) {
    TEST015 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0xF0) + (newval);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 2 */
  if (strcmp(p->paramname->data,"envkybd") == 0) {
    TEST015 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0xF) + (newval<<4);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"dcobnd") == 0) {
    TEST015 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0xF0) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 3 */
  if (strcmp(p->paramname->data,"dcolfo") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 4 */
  if (strcmp(p->paramname->data,"chorus") == 0) {
    TEST01 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + (newval << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"dcoenvd") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 5 */
  if (strcmp(p->paramname->data,"pwpwm") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"dcoenv") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2 ;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 6 */
  if (strcmp(p->paramname->data,"pwmrate") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
    
  }

  /* byte 7 */
  if (strcmp(p->paramname->data,"vcffreq") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"vcfenv") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 8 */
  if (strcmp(p->paramname->data,"vcfreso") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
    
  }

  /* byte 9 */
  if (strcmp(p->paramname->data,"vcfenvd") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value ) ;
    
  }
  if (strcmp(p->paramname->data,"vcaenv") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 10 */
  if (strcmp(p->paramname->data,"vcflfo") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 11 */
  if (strcmp(p->paramname->data,"vcalevl") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"sub") == 0) {
    TEST05 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 4) << 5);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 12 */
  if (strcmp(p->paramname->data,"lforate") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 13 */
  if (strcmp(p->paramname->data,"lfodely") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 14 */
  if (strcmp(p->paramname->data,"envt1") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"sawtooth") == 0) {
    TEST05 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 4) << 5);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 15 */
  if (strcmp(p->paramname->data,"envl1") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 16 */
  if (strcmp(p->paramname->data,"envt2") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 17 */
  if (strcmp(p->paramname->data,"envl2") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"pulse") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 18 */
  if (strcmp(p->paramname->data,"envt3") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 19 */
  if (strcmp(p->paramname->data,"envl3") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  if (strcmp(p->paramname->data,"hpffreq") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 20 */
  if (strcmp(p->paramname->data,"envt4") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b10000000) + newval;
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  /* byte 21 */
  if (strcmp(p->paramname->data,"dcorng") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 22: nothing begins there.. */

  /* byte 23*/
  if (strcmp(p->paramname->data,"sublevl") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 24: nothing begins there.. */
  
  /* byte 25 */
  if (strcmp(p->paramname->data,"noislvl") == 0) {
    TEST03 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b01111111) + ((newval & 1) << 7);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }

  /* byte 27 */
  if (strcmp(p->paramname->data,"crsrate") == 0) {
    TEST0127 ( p )
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b00111111) + ((newval & 1) << 6) + ((newval & 2) << 6);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b00111111) + ((newval & 4) << 4) + ((newval & 8) << 4);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b00111111) + ((newval & 16) << 2) + ((newval & 32) << 2);
    WRITE_BYTE_TONEBUF(offsettone, value )
    offset +=2;
    offsettone += 2 ;
    preval = READ_BYTE_TONEBUF(offsettone) ;
    value = (preval & 0b00111111) + (newval & 64) + (newval & 128);
    WRITE_BYTE_TONEBUF(offsettone, value )
  }
  
  dump_char(savebuf,TONE_SIZE);
  return OK; 
}



int getjuparm(CSOUND *csound, getjuparm_t* p) {
  int offset, toneb10 ;
  unsigned int value, b[22 + 1], c[7 + 1];
  
  
  loadbank(p->ficname->data);
  offset = get_offset(*p->tone, p->paramname->data);

  /* byte 0 */
  if (strcmp(p->paramname->data,"dcoaftr") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = (value&0xF0)>>4 ;
  }
  if (strcmp(p->paramname->data,"vcfkybd") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0xF ;
  }
  
  
  /* byte 1 */
  if (strcmp(p->paramname->data,"vcfaftr") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = (value&0xF0)>>4 ;
  }
  if (strcmp(p->paramname->data,"vcaaftr") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0xF ;
  }

  /* byte 2 */
  if (strcmp(p->paramname->data,"envkybd") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = (value&0xF0)>>4;
  }
  if (strcmp(p->paramname->data,"dcobnd") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0xF;
  }
  
  /* byte 3 */
  if (strcmp(p->paramname->data,"dcolfo") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  
  /* byte 4 */
  if (strcmp(p->paramname->data,"chorus") == 0) {
    value = READ_BYTE(offset) ;
    b[0] = (value&0b10000000)>>7;
    *p->out =b[0] ;
  }
  if (strcmp(p->paramname->data,"dcoenvd") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111  ; 
  }
  
  /* byte 5 */
  if (strcmp(p->paramname->data,"pwpwm") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  if (strcmp(p->paramname->data,"dcoenv") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[1] = (value&0b10000000)>>6;
    value = READ_BYTE(offset) ;
    b[2] = (value&0b10000000)>>7;
    *p->out = (b[1]|b[2]) ;
  }
  
  /* byte 6 */
  if (strcmp(p->paramname->data,"pwmrate") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }

  /* byte 7 */
  if (strcmp(p->paramname->data,"vcffreq") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  if (strcmp(p->paramname->data,"vcfenv") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[3] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[4] = (value&0b10000000)>>7 ;
    *p->out = (b[3]|b[4]) ;
  }

  /* byte 8 */
  if (strcmp(p->paramname->data,"vcfreso") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111;
  }

  /* byte 9 */
  if (strcmp(p->paramname->data,"vcfenvd") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  if (strcmp(p->paramname->data,"vcaenv") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[5] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[6] = (value&0b10000000)>>7 ;
    *p->out = (b[5]|b[6]) ;
  }

  /* byte 10 */
  if (strcmp(p->paramname->data,"vcflfo") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  
  /* byte 11 */
  if (strcmp(p->paramname->data,"vcalevl") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  if (strcmp(p->paramname->data,"sub") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[7] = (value&0b10000000)>>5 ;
    value = READ_BYTE(offset) ;
    offset +=2;
    b[8] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[9] = (value&0b10000000)>>7 ;
    *p->out = (b[7]|b[8]|b[9]) ;
  }
  
  /* byte 12 */
  if (strcmp(p->paramname->data,"lforate") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  
  /* byte 13 */
  if (strcmp(p->paramname->data,"lfodely") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }

  /* byte 14 */
  if (strcmp(p->paramname->data,"envt1") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  if (strcmp(p->paramname->data,"sawtooth") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[10] = (value&0b10000000)>>5 ;
    value = READ_BYTE(offset) ;
    offset +=2;
    b[11] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[12] = (value&0b10000000)>>7 ;
    *p->out = (b[10]|b[11]|b[12]) ;
  }
  
  /* byte 15 */
  if (strcmp(p->paramname->data,"envl1") == 0) {
    value = READ_BYTE(offset) ;
    *p->out =value&0b01111111 ; 
  }

  /* byte 16 */
  if (strcmp(p->paramname->data,"envt2") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }

  /* byte 17 */
  if (strcmp(p->paramname->data,"envl2") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  if (strcmp(p->paramname->data,"pulse") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[13] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    offset +=2;
    b[14] = (value&0b10000000)>>7 ;
    *p->out = (b[13]|b[14]) ;
  }
  
  /* byte 18 */
  if (strcmp(p->paramname->data,"envt3") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }

  /* byte 19 */
  if (strcmp(p->paramname->data,"envl3") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  if (strcmp(p->paramname->data,"hpffreq") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[15] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[16] = (value&0b10000000)>>7 ;
    *p->out = (b[15]|b[16]) ;
  }
  
  /* byte 20 */
  if (strcmp(p->paramname->data,"envt4") == 0) {
    value = READ_BYTE(offset) ;
    *p->out = value&0b01111111 ;
  }
  
  /* byte 21 */
  if (strcmp(p->paramname->data,"dcorng") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[17] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[18] = (value&0b10000000)>>7 ;
    *p->out = (b[17]|b[18]) ;
  }
  
  /* byte 22  : nothing begins there.. */

  /* byte 23 */
  if (strcmp(p->paramname->data,"sublevl") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[19] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[20] = (value&0b10000000)>>7 ;
    *p->out = (b[19]|b[20]) ;
  }

  /* byte 25 */
  if (strcmp(p->paramname->data,"noislvl") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    b[21] = (value&0b10000000)>>6 ;
    value = READ_BYTE(offset) ;
    b[22] = (value&0b10000000)>>7 ; 
    *p->out = (b[21]|b[22]) ; 
  }

  /* byte 26  : nothing begins there.. */

  /* byte 27 */
  if (strcmp(p->paramname->data,"crsrate") == 0) {
    value = READ_BYTE(offset) ;
    offset +=2;
    c[0] = (value&0b10000000)>>6 ;
    c[1] = (value&0b01000000)>>6 ;
    value = READ_BYTE(offset) ;
    offset +=2;
    c[3] = (value&0b10000000)>>4 ;
    c[2] = (value&0b01000000)>>4 ;
    value = READ_BYTE(offset) ;
    offset +=2;
    c[5] = (value&0b10000000)>>2 ;
    c[4] = (value&0b01000000)>>2 ;
    value = READ_BYTE(offset) ;
    c[7] = (value&0b10000000) ;
    c[6] = (value&0b01000000) ;
    *p->out = (c[0]|c[1]|c[2]|c[3]|c[4]|c[5]|c[6]|c[7]) ;
  }

  return OK ;   

}
  


#ifdef EXE_MODE
void out_getjuname(getjuname_t* name) {
  printf("  ficname:'%s' /   tone:%d  /   group:%d  ",
	 name->ficname->data, (int)*name->tone, (int)*name->group);
  printf("=> out:'%s'\n",(char*)name->out->data);
}



void out_getjuparm(getjuparm_t* parm) {
  printf("  ficname:'%s' /   tone:%d  /   paramname:'%s'  ",
	 parm->ficname->data, (int)*parm->tone, parm->paramname->data);
  printf("=> out:%d\n",(int)*parm->out);
}

void out_setjuparm(setjuparm_t* parm) {
  printf("  ficname:'%s' /   tone:%d  /   paramname:'%s'  / newvalue: %d  ",
	 parm->ficname->data, (int)*parm->tone, parm->paramname->data,(int)*parm->newval);
  printf("=> out:%d\n",(int)*parm->out);
}


void dump_tone (char* bank, int mytone) {
  getjuparm_t parm;
  getjuname_t name;
  MYFLT tone = 0, group = 0;
  STRINGDAT ficname, paramname,outname;
  char buf1[100] ;
  char buf2[100] ;
  char buf3[100] ;
  int idx,idx2;
  MYFLT out = 0;
  ficname.data = buf1;
  ficname.size = 100;
  paramname.data = buf2;
  paramname.size = 100;
  outname.data = buf3;
  outname.size = 100;
  strcpy(buf1, bank);
  tone = mytone;
  
  parm.out = &out;
  parm.ficname = &ficname;
  parm.tone = &tone;
  parm.paramname = &paramname;
  
  name.out = &outname;
  name.ficname = &ficname;
  name.tone = &tone;
  name.group = &group;
  
  getjuname((CSOUND*)NULL,&name);
  printf("**** Tone Name : %s\n",name.out->data);

  
  
  for (idx = 1 ; idx < NB_PARMS; idx ++) {
    strcpy(buf2,t_parms[idx]);
    getjuparm((CSOUND*)NULL,&parm);
    out_getjuparm(&parm);
  }

}

void dump_banka() {
  int idx;
  for (idx = 0; idx < 64; idx++)  {
    dump_tone("FACTORYA.SYX",idx);
  }
}

/*

typedef struct {
  OPDS h;
  MYFLT *out;             
  STRINGDAT *ficname;     
  MYFLT *tone;            
  STRINGDAT *tonename;    
} setjuname_t ;

*/
int test_syx(char* bank) {
  verifsyx_t test; 
  MYFLT out = 0; 
  STRINGDAT ficname;
  static char buf1[100] ;
  ficname.data = buf1;
  ficname.size = 100;
  strcpy(buf1, bank);

  test.out = &out;
  test.ficname = &ficname;

  verifsyx((CSOUND*) NULL, &test);

  if (*test.out != OK) printf("%s : OK\n",bank); else printf("%s : problem !",bank);
  return (int)*test.out;

}


int new_syx(char* bank) {
  verifsyx_t test; 
  MYFLT out = 0; 
  STRINGDAT ficname;
  static char buf1[100] ;
  ficname.data = buf1;
  ficname.size = 100;
  strcpy(buf1, bank);

  test.out = &out;
  test.ficname = &ficname;

  emptysyx((CSOUND*) NULL, &test);

  if (*test.out != OK) printf("%s : OK\n",bank); else printf("%s : problem !",bank);
  return (int)*test.out;

}


int set_name(char* bank, int mytone, char* newname) {
  setjuname_t name;
  MYFLT tone = 0; MYFLT out = 0 ;
  STRINGDAT ficname, tonename;
  static char buf1[100] ;
  static char buf2[100] ;
  ficname.data = buf1;
  ficname.size = 100;
  tonename.data = buf2;
  tonename.size =100;
    
  strcpy(buf1, bank);
  tone = mytone;
  strcpy(buf2,newname);

  name.out = &out;
  name.ficname = &ficname;
  name.tone = &tone;
  name.tonename = &tonename;

  setjuname((CSOUND*) NULL, &name);
  //  out_getjuname(&name);

  return (int)*name.out;
  

}

int test_copypaste(char* destbank, int desttone,char * destname ) {
  getjuparm_t parm;
  MYFLT tone = 0, out = 0;
  STRINGDAT ficname, tonename;
  static char buf1[100] ;
  static char buf2[100] ;
  ficname.data = buf1;
  ficname.size = 100;
  tonename.data = buf2;
  tonename.size = 100;
    
  parm.out = &out;
  parm.ficname = &ficname;
  parm.tone = &tone;
  parm.paramname = &tonename;
 


  /* paste  */
  strcpy(buf1, destbank);
  strcpy(buf2, destname);
  tone = desttone ; 
  jupaste((CSOUND*) NULL, &parm);
  


  return (int)*parm.out;
  
}





char* get_name(char* bank, int mytone, int mygroup) {
  getjuname_t name;
  MYFLT tone = 0, group = 0;
  STRINGDAT ficname, out;
  static char buf1[100] ;
  static char buf2[100] ;
  ficname.data = buf1;
  ficname.size = 100;
  out.data = buf2;
  out.size =100;
    
  strcpy(buf1, bank);
  tone = mytone;
  group = mygroup;

  name.out = &out;
  name.ficname = &ficname;
  name.tone = &tone;
  name.group = &group;

  getjuname((CSOUND*) NULL, &name);
  out_getjuname(&name);

  return name.out->data;
  
}
int get_parm(char* bank, int mytone, char* pname) {
  getjuparm_t parm;
  MYFLT tone = 0, group = 0;
  STRINGDAT ficname, paramname;
  char buf1[100] ;
  char buf2[100] ;
  int idx,idx2;
  MYFLT out = 0;
  ficname.data = buf1;
  ficname.size = 100;
  paramname.data = buf2;
  paramname.size = 100;
  strcpy(buf1, bank);
  tone = mytone;
  
  parm.out = &out;
  parm.ficname = &ficname;
  parm.tone = &tone;
  parm.paramname = &paramname;
  
  
  strcpy(buf2,pname);
  getjuparm((CSOUND*)NULL,&parm);
  out_getjuparm(&parm);

  return (int)(out);

}




void set_parm(char* bank, int mytone, char* pname, int value) {
  setjuparm_t parm;
  MYFLT tone = 0 ; 
  STRINGDAT ficname, paramname ;
  MYFLT out = 0, newval = 0;
  char buf1[100] ;
  char buf2[100] ;
  int idx,idx2;
  ficname.data = buf1;
  ficname.size = 100;
  paramname.data = buf2;
  paramname.size = 100;
  strcpy(buf1, bank);
  tone = mytone;
  newval = value;

  parm.out = &out;
  parm.ficname = &ficname;
  parm.tone = &tone;
  parm.paramname = &paramname;
  parm.newval  = &newval;

  
  strcpy(buf2,pname);
  
  setjuparm((CSOUND*)NULL, &parm);
  out_setjuparm(&parm);
  

}

#define ASSERT(a) if (!(a)) { printf("Error !\n") ; exit(1);}




int test_parm(char* bank, int tone, char* parm, int newvalue ) {
  int before, after, new; 
  before = get_parm(bank, tone, parm);
  set_parm(bank, tone, parm, newvalue);
  ASSERT(get_parm("FACTORYA.SYX",0,parm) == newvalue)  ;
  

}


int test_name(char* bank, int tone, int group, char* newname ) {
  char old[16 + 1], new[16 + 1] ;

  strcpy(old,get_name(bank, tone, group));
  set_name(bank, tone, newname);
  strcpy(new,get_name(bank,tone,group));
  printf("old:'%s'  new:'%s'\n",old, new);

  ASSERT(!strcmp(&(new[6]), newname) ) ;
  
  

}

void main (int argc, char* argv) {
  int before, after, new;
  char parm[100]; 
  /*  dump_banka(); 
  
  test_parm("FACTORYA.SYX",0,"vcfkybd",13);
  test_parm("FACTORYA.SYX",0,"dcoaftr",12);
  test_parm("FACTORYA.SYX",0,"vcfkybd",10);
  test_parm("FACTORYA.SYX",0,"vcfaftr",2);
  test_parm("FACTORYA.SYX",0,"vcaaftr",9);
  test_parm("FACTORYA.SYX",0,"envkybd",2);
  test_parm("FACTORYA.SYX",0,"dcobnd",15);
  test_parm("FACTORYA.SYX",0,"dcolfo",65);
  test_parm("FACTORYA.SYX",0,"chorus",0);
  test_parm("FACTORYA.SYX",0,"dcoenvd",123);
  test_parm("FACTORYA.SYX",0,"chorus",1);
  test_parm("FACTORYA.SYX",0,"pwpwm",3);
  test_parm("FACTORYA.SYX",0,"dcoenv",3);
  test_parm("FACTORYA.SYX",0,"pwpwm",5);
  test_parm("FACTORYA.SYX",0,"pwmrate",122);
  test_parm("FACTORYA.SYX",0,"vcffreq",111);
  test_parm("FACTORYA.SYX",0,"vcfenv",1);
  test_parm("FACTORYA.SYX",0,"vcffreq",12);
  test_parm("FACTORYA.SYX",0,"vcfreso",56);
  test_parm("FACTORYA.SYX",0,"vcaenv",1);
  test_parm("FACTORYA.SYX",0,"vcflfo",34);
  test_parm("FACTORYA.SYX",0,"vcalevl",55);
  test_parm("FACTORYA.SYX",0,"sub",5);
  test_parm("FACTORYA.SYX",0,"lforate",114);
  test_parm("FACTORYA.SYX",0,"lfodely",99);
  test_parm("FACTORYA.SYX",0,"envt1",123);
  test_parm("FACTORYA.SYX",0,"envt2",13);
  test_parm("FACTORYA.SYX",0,"envt3",14);
  test_parm("FACTORYA.SYX",0,"envt4",15);
  test_parm("FACTORYA.SYX",0,"sawtooth",2);
  test_parm("FACTORYA.SYX",0,"envl1",2);
  test_parm("FACTORYA.SYX",0,"envl2",15);
  test_parm("FACTORYA.SYX",0,"envl3",3);
  test_parm("FACTORYA.SYX",0,"pulse",2);
  test_parm("FACTORYA.SYX",0,"hpffreq",2);
  test_parm("FACTORYA.SYX",0,"dcorng",1);
  test_parm("FACTORYA.SYX",0,"sublevl",3);
  test_parm("FACTORYA.SYX",0,"noislvl",1);
  test_parm("FACTORYA.SYX",0,"crsrate",127);
  test_name("FACTORYA.SYX",0,0,"J-21 Empty"); 

  test_syx("FACTORYA.SYX");
  
  */  
  new_syx("TEST.SYX");

  strcpy(parm, "lfodely"); before = 99;
  set_parm("FACTORYA.SYX",0,"lfodely",before);
  test_copypaste("TEST.SYX",0,"TEST1    ");
  after = get_parm("TEST.SYX", 0, parm) ;
  printf ("%s from cartridge: %d, was: %d \n",parm, after, before);
  new_syx("USERCART.SYX");
  
  
  
}



#else
static OENTRY localops[] =
  {
   { "getjuparm", sizeof(getjuparm_t), 0, 1, "i", "SiS",
     (SUBR) getjuparm, (SUBR) getjuparm, NULL },
   { "jupaste", sizeof(getjuparm_t), 0, 1, "i", "SiS",
     (SUBR) jupaste, (SUBR) jupaste, NULL },
   { "setjuparm", sizeof(setjuparm_t), 0, 1, "i", "SiSi",
     (SUBR) setjuparm, (SUBR) setjuparm, NULL },
   { "getjuname", sizeof(getjuname_t), 0, 1, "S", "Sii",
     (SUBR) getjuname, (SUBR) getjuname, NULL },
   { "initjubuf", 0, 0, 1, "i", "",
     (SUBR) initjubuf, (SUBR) initjubuf, NULL },
   
  };

LINKAGE
#endif
