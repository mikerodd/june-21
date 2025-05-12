
/* bounds(0, 0, 0, 0)
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
 */
 
<Cabbage>  
bounds(0, 0, 0, 0)
form caption("June-21 v{VERSION}"), size(800, 580), colour(26,26,26), pluginId("June") bundle("./imgs", "./presets","./libjsl.so", "libjsl.dll","libjsl.dylib")

keyboard bounds(14, 456, 588, 122)  



image bounds(0, 0, 800, 450) file("imgs/background.svg") 
image bounds(50, 4, 300, 45) file("imgs/june-21.png")




#define rsliderstyle outlineColour(255, 0, 0, 255) markerColour(255, 0, 0, 255) trackerColour(255, 0, 0, 255)
#define vsliderstyle  trackerColour(255, 0, 0, 255)



rslider bounds(8, 102, 44, 44), range(0, 127, 0, 1, 1),  channel("lforate"),  $rsliderstyle 
rslider bounds(56, 102, 44, 44), range(0, 127, 0, 1, 1),  channel("lfodely"),  $rsliderstyle 
rslider bounds(188, 102, 44, 44), range(0, 127, 0, 1, 1), channel("dcolfo") ,  $rsliderstyle 
rslider bounds(236, 102, 44, 44), range(0, 127, 0, 1, 1), , channel("dcoenvd"), $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(310, 240, 44, 44) range(0, 127, 0, 1, 1) channel("pwpwm")   $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(358, 240, 44, 44) range(0, 127, 0, 1, 1) channel("pwmrate")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(488, 240, 44, 44) range(0, 127, 0, 1, 1) channel("vcffreq")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(536, 240, 44, 44) range(0, 127, 0, 1, 1) channel("vcfreso")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(632, 240, 44, 44) range(0, 127, 0, 1, 1) channel("vcfenvd") $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(308, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envt1")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(404, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envt2")  $rsliderstyle 
rslider bounds(500, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envt3")  $rsliderstyle 
rslider bounds(596, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envt4")  $rsliderstyle 
rslider bounds(236, 380, 44, 44) range(0, 127, 0, 1, 1) channel("crsrate")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(584, 240, 44, 44) range(0, 127, 0, 1, 1) channel("vcflfo")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(742, 240, 44, 44) range(0, 15, 0, 1, 1) channel("vcfkybd")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(644, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envkybd")  $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(8, 378, 44, 44) range(0, 127, 0, 1, 1) channel("vcalevl") $rsliderstyle 
rslider bounds(356, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envl1") $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)
rslider bounds(452, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envl2") $rsliderstyle 
rslider bounds(548, 380, 44, 44) range(0, 127, 0, 1, 1) channel("envl3") $rsliderstyle 

rslider bounds(0, 0, 47, 31) range(0.2, 1, 0.5, 1, 0.01) channel("lid") $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255) text("light") visible(0)
rslider bounds(740, 380, 44, 44) range(0, 12, 0, 1, 1) channel("dcobnd") $rsliderstyle markerColour(255, 0, 0, 255) outlineColour(255, 0, 0, 255)





vslider bounds(152, 96, 25, 66) range(0, 3, 0, 1, 1) channel("dcorng")   $vsliderstyle  
vslider bounds(82, 200, 25, 104) range(0, 5, 0, 1, 1) channel("sawtooth") $vsliderstyle  
vslider bounds(32, 200, 25, 66) range(0, 3, 0, 1, 1) channel("pulse") $vsliderstyle  
vslider bounds(152, 200, 25, 104) range(0, 5, 0, 1, 1) channel("sub") $vsliderstyle  
vslider bounds(312, 94, 25, 66) range(0, 3, 0, 1, 1) channel("dcoenv") $vsliderstyle  
vslider bounds(200, 210, 30, 65) range(0, 3, 0, 1, 1) channel("sublevl") $vsliderstyle  
vslider bounds(250, 210, 30, 67) range(0, 3, 0, 1, 1) channel("noislvl") $vsliderstyle  
vslider bounds(84, 368, 31, 66) range(0, 3, 0, 1, 1) channel("vcaenv") $vsliderstyle  
vslider bounds(200, 380, 31, 44) range(0, 1, 0, 1, 1) channel("chorus") $vsliderstyle  
vslider bounds(708, 228, 25, 66) range(0, 3, 0, 1, 1) channel("vcfenv") $vsliderstyle  
vslider bounds(426, 240, 32, 65) range(0, 3, 0, 1, 1) channel("hpffreq") $vsliderstyle  

button bounds(406, 82, 86, 20) colour:0(118, 118, 118, 255) colour:1(255, 0, 0, 255) radioGroup("1") text("PRESET", "PRESET") channel("grpPreset") value(1) fontColour:1(0, 0, 0, 255)
button bounds(406, 106, 86, 20) colour:0(118, 118, 118, 255) colour:1(255, 0, 0, 255) radioGroup("1") text("MEMORY", "MEMORY") channel("grpMemory") fontColour:1(0, 0, 0, 255)
button bounds(406, 130, 86, 20) colour:0(118, 118, 118, 255) colour:1(255, 0, 0, 255) radioGroup("1") text("USERCART", "USERCART") channel("grpCartridge")  identChannel("CartName") fontColour:1(0, 0, 0, 255) 





label bounds(194, 186, 40, 12), text("SUB"), 
label bounds(242, 184, 50, 12) ,text("NOISE"), 
label bounds(416, 226, 50, 12) text("HPF") 
label bounds(136, 78, 50, 12), text("RANGE")
label bounds(284, 78, 60, 12), text("ENV MODE")

label bounds(700, 198, 40, 12) text("ENV")
label bounds(62, 322, 50, 16) text("VCA")
label bounds(200, 322, 80, 16) text("CHORUS")
label bounds(16, 58, 80, 16) text("LFO")
label bounds(8, 78, 49, 12) text("RATE")
label bounds(54, 78, 50, 12) text("DELAY")
label bounds(196, 58, 80, 16) text("DCO")
label bounds(190, 78, 40, 12) text("LFO")
label bounds(236, 78, 40, 12) text("ENV")
label bounds(24, 184, 42, 12) text("PULSE")
label bounds(74, 170, 40, 12) text("SAW")
label bounds(74, 184, 40, 12) text("TOOTH")
label bounds(144, 184, 40, 12) text("SUB")
label bounds(190, 196, 50, 12) text("LEVEL")
label bounds(242, 196, 50, 12) text("LEVEL")
label bounds(314, 222, 40, 12) text("PWM")
label bounds(356, 212, 40, 12) text("PWM")
label bounds(356, 222, 40, 13) text("RATE")
label bounds(562, 180, 80, 16) text("VCF")
label bounds(486, 222, 50, 12) text("FREQ")
label bounds(536, 222, 50, 12) text("RES")
label bounds(588, 222, 40, 12) text("LFO")
label bounds(632, 222, 40, 12) text("ENV")
label bounds(694, 210, 50, 12) text("MODE")
label bounds(746, 210, 40, 12) text("KEY")
label bounds(742, 222, 50, 12) text("FOLLOW")
label bounds(10, 360, 40, 12) text("LEVEL")
label bounds(80, 340, 40, 12) text("ENV")
label bounds(74, 352, 50, 12) text("MODE")
label bounds(240, 362, 40, 12) text("RATE")
label bounds(464, 322, 80, 16) text("ENV")
label bounds(310, 362, 40, 12) text("T1")
label bounds(358, 362, 40, 12) text("L1")
label bounds(406, 362, 40, 12) text("T2")
label bounds(454, 362, 40, 12) text("L2")
label bounds(502, 362, 40, 12) text("T3")
label bounds(550, 362, 40, 12) text("L3")
label bounds(598, 362, 40, 12) text("T4")
label bounds(644, 352, 40, 12) text("KEY")
label bounds(640, 362, 50, 12) text("FOLLOW")



groupbox bounds(496, 4, 297, 49),  outlineColour(160, 160, 160, 0) {
image     file("imgs/panel.png") bounds(0, 0, 295, 47)
image     file("imgs/backlcd.png") alpha(0) bounds(0, 2, 295, 47) identChannel("backled") alpha(0.2)
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(3, 11, 18, 27) identChannel("pos0")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(21, 11, 18, 27) identChannel("pos1")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(39, 11, 18, 27) identChannel("pos2")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(58, 11, 18, 27) identChannel("pos3")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(76, 11, 18, 27) identChannel("pos4")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(94, 11, 18, 27) identChannel("pos5")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(112, 11, 18, 27) identChannel("pos6")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(131, 11, 18, 27) identChannel("pos7")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(149, 11, 18, 27) identChannel("pos8")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(167, 11, 18, 27) identChannel("pos9")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(185, 11, 18, 27) identChannel("pos10")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(203, 11, 18, 27) identChannel("pos11")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(222, 11, 18, 27) identChannel("pos12")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(240, 11, 18, 27) identChannel("pos13")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(258, 11, 18, 27) identChannel("pos14")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(276, 11, 18, 27) identChannel("pos15")
image     file("imgs/lcdcharsv3.png") alpha(0.7) bounds(3, 37, 20, 5) identChannel("underline") crop(0,25, 40, 10) visible(0) 

image     file("imgs/alpha.png") bounds(0, 0, 295, 47) identChannel("light") alpha(0.35)
}



groupbox bounds(496, 86, 305, 90),  outlineColour(160, 160, 160, 0) colour(35, 35, 35, 0) {
button bounds(4, 19, 31, 17)  colour:0(118, 118, 118, 255) text("1", "1") colour:1(255, 0, 0, 255) channel("btb1") radioGroup("btbank") value(1)
button bounds(41, 19, 31, 17)  colour:0(118, 118, 118, 255) text("2", "2") colour:1(255, 0, 0, 255) channel("btb2") radioGroup("btbank") 
button bounds(78, 19, 31, 17) colour:0(118, 118, 118, 255) text("3", "3") colour:1(255, 0, 0, 255) channel("btb3") radioGroup("btbank") 
button bounds(115, 19, 31, 17) colour:0(118, 118, 118, 255) text("4", "4") colour:1(255, 0, 0, 255) channel("btb4") radioGroup("btbank") 
button bounds(153, 19, 31, 17) colour:0(118, 118, 118, 255) text("5", "5") colour:1(255, 0, 0, 255) channel("btb5") radioGroup("btbank") 
button bounds(189, 19, 31, 17) colour:0(118, 118, 118, 255) text("6", "6") colour:1(255, 0, 0, 255) channel("btb6") radioGroup("btbank") 
button bounds(226, 19, 31, 17) colour:0(118, 118, 118, 255) text("7", "7") colour:1(255, 0, 0, 255) channel("btb7") radioGroup("btbank") 
button bounds(264, 19, 31, 17) colour:0(118, 118, 118, 255) text("8", "8") colour:1(255, 0, 0, 255) channel("btb8") radioGroup("btbank") 

button bounds(4, 64, 31, 17)  colour:0(118, 118, 118, 255) text("1", "1") colour:1(255, 0, 0, 255) channel("btn1") radioGroup("btnumber")  value(1)
button bounds(41, 64, 31, 17)  colour:0(118, 118, 118, 255) text("2", "2") colour:1(255, 0, 0, 255) channel("btn2") radioGroup("btnumber") 
button bounds(78, 64, 31, 17) colour:0(118, 118, 118, 255) text("3", "3") colour:1(255, 0, 0, 255) channel("btn3") radioGroup("btnumber") 
button bounds(115, 64, 31, 17) colour:0(118, 118, 118, 255) text("4", "4") colour:1(255, 0, 0, 255) channel("btn4") radioGroup("btnumber") 
button bounds(153, 64, 31, 17) colour:0(118, 118, 118, 255) text("5", "5") colour:1(255, 0, 0, 255) channel("btn5") radioGroup("btnumber") 
button bounds(189, 64, 31, 17) colour:0(118, 118, 118, 255) text("6", "6") colour:1(255, 0, 0, 255) channel("btn6") radioGroup("btnumber") 
button bounds(226, 64, 31, 17) colour:0(118, 118, 118, 255) text("7", "7") colour:1(255, 0, 0, 255) channel("btn7") radioGroup("btnumber") 
button bounds(264, 64, 31, 17) colour:0(118, 118, 118, 255) text("8", "8") colour:1(255, 0, 0, 255) channel("btn8") radioGroup("btnumber") 

button bounds(205, 10, 72, 1) colour:0(255, 0, 0, 255)  colour:1(255, 0, 0, 255) radioGroup("666") 
button bounds(10, 10, 72, 1) colour:0(255, 0, 0, 255) colour:1(255, 0, 0, 255) radioGroup("666") 
button bounds(205, 53, 72, 1) colour:0(255, 0, 0, 255)  colour:1(255, 0, 0, 255) radioGroup("666") 
button bounds(10, 53, 72, 1) colour:0(255, 0, 0, 255) colour:1(255, 0, 0, 255) radioGroup("666")  

label bounds(74, 3, 142, 11) text("BANK") fontColour(255, 0, 0, 255) 
label bounds(74, 46, 142, 11) text("NUMBER") fontColour(255, 0, 0, 255) 

}


image bounds(286, 92, 25, 16)  file("imgs/adsrn.png")
image bounds(286, 108, 25, 16) file("imgs/adsri.png")
image bounds(286, 126, 25, 16) file("imgs/adsrn.png")
image bounds(286, 142, 25, 16) file("imgs/adsri.png")


image bounds(8, 196, 25, 16) file("imgs/sq_3.png")
image bounds(8, 214, 25, 16) file("imgs/sq_2.png")
image bounds(8, 232, 25, 16) file("imgs/sq_1.png")
label bounds(7, 250, 28, 12) text("OFF")

image bounds(62, 196, 25, 16) file("imgs/tri_5.png")
image bounds(62, 214, 25, 16) file("imgs/tri_4.png")
image bounds(62, 232, 25, 16) file("imgs/tri_3.png")
image bounds(62, 250, 25, 16) file("imgs/tri_2.png")
image bounds(62, 268, 25, 16) file("imgs/tri_1.png")
label bounds(62, 286, 28, 12) text("OFF")

image bounds(116, 196, 40, 16) file("imgs/sub6.png")
image bounds(116, 214, 40, 16) file("imgs/sub5.png")
image bounds(116, 232, 40, 16) file("imgs/sub4.png")
image bounds(116, 250, 40, 16) file("imgs/sub3.png")
image bounds(116, 268, 40, 16) file("imgs/sub2.png")
image bounds(116, 286, 40, 16) file("imgs/sub1.png")

label bounds(176, 380, 28, 12) text("ON") align("right")
label bounds(176, 406, 28, 12) text("OFF") align("right")

image bounds(62, 366, 25, 16) file("imgs/adsrn.png")
image bounds(62, 382, 25, 16) file("imgs/gaten.png")
image bounds(62, 398, 25, 16) file("imgs/adsrn.png")
image bounds(62, 414, 25, 16) file("imgs/gaten.png")


image bounds(684, 226, 25, 16) file("imgs/adsrn.png")
image bounds(684, 242, 25, 16) file("imgs/adsri.png")
image bounds(684, 258, 25, 16) file("imgs/adsrn.png")
label bounds(680, 274, 28, 12) text("dyn") align("right")




label bounds(134, 96, 20, 12) text("32") align("right")
label bounds(134, 112, 20, 12) text("16") align("right")
label bounds(134, 128, 20, 12) text("8") align("right")
label bounds(134, 144, 20, 12) text("4") align("right")

label bounds(184, 210, 20, 12) text("3") align("right")
label bounds(184, 226, 20, 12) text("2") align("right")
label bounds(184, 242, 20, 12) text("1") align("right")
label bounds(184, 258, 20, 12) text("0") align("right")

label bounds(234, 210, 20, 12) text("3") align("right")
label bounds(234, 226, 20, 12) text("2") align("right")
label bounds(234, 242, 20, 12) text("1") align("right")
label bounds(234, 258, 20, 12) text("0") align("right")

label bounds(410, 240, 20, 12) text("3") align("right")
label bounds(410, 256, 20, 12) text("2") align("right")
label bounds(410, 272, 20, 12) text("1") align("right")
label bounds(410, 288, 20, 12) text("0") align("right")

filebutton bounds(406, 154, 86, 20)  populate("*.SYX") text("Open File...", "Open File..") channel("openFile") colour:0(118, 118, 118, 255)

image bounds(718, 266, 20, 46)  file("imgs/dyn-link2.png")
image bounds(322, 132, 20, 46)  file("imgs/dyn-link2.png")
image bounds(98, 406, 20, 46)  file("imgs/dyn-link2.png")


label bounds(254, 162, 70, 12) text("DYNAMICS") align("right")
label bounds(650, 296, 70, 12) text("DYNAMICS") align("right")
label bounds(30, 436, 70, 12) text("DYNAMICS") align("right")






button bounds(406, 56, 45, 20) text("Copy", "Copy") channel("btcopy") identChannel("btcopyident") colour:0(118, 118, 118, 255) colour:1(118, 118, 118, 255)
button bounds(450, 56, 42, 20) text("Paste", "Paste") channel("btpaste") identChannel("btpasteident") colour:0(118, 118, 118, 255) colour:1(120, 120, 120, 255)

groupbox bounds(496, 50, 300, 32), outlineColour(160, 160, 160, 0) colour(35, 35, 35, 0)   {
hslider bounds(26, 8, 253, 20) range(0, 63, 0, 1, 1) channel("letter")  identChannel("letterident")
button bounds(4, 8, 20, 20) text("<", "<") channel("left") latched(0)
button bounds(280, 8, 20, 20) text(">", ">") channel("right") latched(0)

}
 
button bounds(408, 12, 82, 34) text("Panic !", "Panic !", "") colour:0(255, 0, 0, 255) channel("btpanic") colour:1(255, 0, 0, 255) latched(0)

label bounds(732, 352, 60, 12) text("BENDER")
label bounds(742, 364, 40, 12) text("RANGE")


combobox bounds(726, 476, 71, 16) text("6 (juno)", "8", "16", "32") channel("maxvoice")
label bounds(674, 478, 52, 12) text("# voices") align("right")
label bounds(684, 496, 42, 12) text("used:") align("right")



label bounds(726, 496, 31, 12) identChannel("voicecount") text("0")
label bounds(652, 512, 75, 12) text("sample rate:") align("right")
label bounds(726, 512, 60, 12) identChannel("samplerate")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --opcode-lib=/home/michel/Bureau/libjsl.so   
; OSX: libjsl.dylib; Windows: libjsl.dll
;--use-system-sr
</CsOptions>
<CsInstruments>
; groupbox bounds(494, 52, 300, 29) ,  outlineColour(160, 160, 160, 0) colour(35, 35, 35, 0) 

; Initialize the global variables. 
; no need for that : provided by Cabbage (to be verified)
;sr=44100
;kr=441
;ksmps = 10
nchnls = 2
0dbfs = 1



// ---------------------------------------------------------------------------------------------------------------
// Global variables
// ---------------------------------------------------------------------------------------------------------------


maxalloc 100, 1 // Only one MIDI listener

// Values of lfo amplitude in % of frequency when applied to DCO from 0-127 for "DCO LFO"
// NB : I  interpolated those values from my 30 years old Juno-2, results weren't stable between measures...
gilfovals[] fillarray 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.001567, 0.003348, 0.005130, 
                      0.006911, 0.008692, 0.010473, 0.012254, 0.014036, 0.015817, 0.017598, 0.019379, 
                      0.021160, 0.022942, 0.024723, 0.026504, 0.028285, 0.029891, 0.031496, 0.033101, 
                      0.034707, 0.036312, 0.037918, 0.039523, 0.041128, 0.042734, 0.044339, 0.045998, 
                      0.047657, 0.049316, 0.050975, 0.052634, 0.054292, 0.055951, 0.057610, 0.059269, 
                      0.060928, 0.062511, 0.064093, 0.065675, 0.067258, 0.068840, 0.070423, 0.072005, 
                      0.073588, 0.075170, 0.076753, 0.078404, 0.080055, 0.081706, 0.083358, 0.085009, 
                      0.086660, 0.088311, 0.089963, 0.091614, 0.093265, 0.095941, 0.098616, 0.101292, 
                      0.103968, 0.106643, 0.109319, 0.111994, 0.114670, 0.117346, 0.120021, 0.123462, 
                      0.126902, 0.130342, 0.133782, 0.137222, 0.140662, 0.144102, 0.147542, 0.150982, 
                      0.154422, 0.157786, 0.161150, 0.164513, 0.167877, 0.171241, 0.174604, 0.177968, 
                      0.181332, 0.184695, 0.188059, 0.192952, 0.197844, 0.202737, 0.207629, 0.212522, 
                      0.217415, 0.222307, 0.227200, 0.232092, 0.236985, 0.244003, 0.251021, 0.258038, 
                      0.265056, 0.272074, 0.279092, 0.286110, 0.293127, 0.300145, 0.307163, 0.313822, 
                      0.320480, 0.327139, 0.333797, 0.340456, 0.347114, 0.353773, 0.360431, 0.367090, 
                      0.373748, 0.381480, 0.389212, 0.396944, 0.404676, 0.412408, 0.420140, 0.427872
                      
// Values of lfo delay in sec from 0-127 "LFO DLY"
// approximate formula used:  exp([LDO DLY]/14.2-3)/10
// NB : I  extrapolated those values from my 30 years old Juno-2, results weren't stable between measures...
gilfodels[] fillarray 0       , 0.064100, 0.059200, 0.054300, 0.049400, 0.044500, 0.039600, 0.034700, 
                      0.029800, 0.024900, 0.020000, 0.018300, 0.016600, 0.014900, 0.013200, 0.011500, 
                      0.009800, 0.008100, 0.006400, 0.004700, 0.003000, 0.007500, 0.012000, 0.016500, 
                      0.021000, 0.025500, 0.030000, 0.034500, 0.039000, 0.043500, 0.048000, 0.053200, 
                      0.058400, 0.063600, 0.068800, 0.074000, 0.079200, 0.084400, 0.089600, 0.094800, 
                      0.100000, 0.104600, 0.109200, 0.113800, 0.118400, 0.123000, 0.127600, 0.132200, 
                      0.136800, 0.141400, 0.146000, 0.161000, 0.176000, 0.191000, 0.206000, 0.221000, 
                      0.236000, 0.251000, 0.266000, 0.281000, 0.296000, 0.368500, 0.441000, 0.513500, 
                      0.586000, 0.658500, 0.731000, 0.803500, 0.876000, 0.948500, 1.021000, 1.036400, 
                      1.051800, 1.067200, 1.082600, 1.098000, 1.113400, 1.128800, 1.144200, 1.159600, 
                      1.175000, 1.289800, 1.404600, 1.519400, 1.634200, 1.749000, 1.863800, 1.978600, 
                      2.093400, 2.208200, 2.323000, 2.538500, 2.754000, 2.969500, 3.185000, 3.400500, 
                      3.616000, 3.831500, 4.047000, 4.262500, 4.478000, 5.092500, 5.707000, 6.321500, 
                      6.936000, 7.550500, 8.165000, 8.779500, 9.394000, 10.008500, 10.623000, 11.799300, 
                      12.975600, 14.151900, 15.328200, 16.504500, 17.680800, 18.857100, 20.033400, 21.209700, 
                      22.386000, 23.986286, 25.586571, 27.186857, 28.787143, 30.387429, 31.987714, 33.588000

// Primary LFO rate
gilforate[] fillarray 0.000411, 0.003560, 0.006709, 0.009858, 0.013007, 0.016156, 0.019305, 0.022454, 
                      0.025603, 0.028752, 0.031901, 0.035050, 0.038199, 0.041348, 0.044497, 0.047646, 
                      0.050795, 0.053944, 0.057093, 0.060242, 0.063391, 0.069015, 0.074639, 0.080263, 
                      0.085887, 0.091511, 0.097135, 0.102760, 0.108384, 0.114008, 0.119632, 0.131495, 
                      0.143358, 0.155222, 0.167085, 0.178948, 0.190812, 0.202675, 0.214539, 0.226402, 
                      0.238265, 0.258837, 0.279409, 0.299981, 0.320553, 0.341125, 0.361697, 0.382268, 
                      0.402840, 0.423412, 0.443984, 0.488356, 0.532728, 0.577100, 0.621473, 0.665845, 
                      0.710217, 0.754589, 0.798961, 0.843333, 0.887705, 0.964156, 1.040606, 1.117057, 
                      1.193507, 1.269958, 1.346408, 1.422858, 1.499309, 1.575759, 1.652210, 1.808662, 
                      1.965113, 2.121565, 2.278017, 2.434468, 2.590920, 2.747372, 2.903824, 3.060275, 
                      3.216727, 3.504346, 3.791965, 4.079584, 4.367203, 4.654822, 4.942441, 5.230060, 
                      5.517679, 5.805298, 6.092917, 6.706867, 7.320817, 7.934767, 8.548717, 9.162666, 
                      9.776616, 10.390566, 11.004516, 11.618466, 12.232416, 13.054164, 13.875912, 14.697660, 
                      15.519409, 16.341157, 17.162905, 17.984653, 18.806401, 19.628150, 20.449898, 23.069631, 
                      25.689364, 28.309098, 30.928831, 33.548564, 36.168297, 38.788031, 41.407764, 44.027497, 
                      46.647230, 49.266964, 51.886697, 54.506430, 57.126163, 59.745897, 62.365630, 64.985363
                      

// Rates for 
gipwmrate[] fillarray 0.000000, 0.002994, 0.005988, 0.008982, 0.011976, 0.014970, 0.017964, 0.020958, 
                      0.023952, 0.026946, 0.029940, 0.032223, 0.034506, 0.036789, 0.039072, 0.041355, 
                      0.043638, 0.045921, 0.048204, 0.050487, 0.052770, 0.056668, 0.060565, 0.064462, 
                      0.068360, 0.072257, 0.076154, 0.080051, 0.083949, 0.087846, 0.091743, 0.098255, 
                      0.104767, 0.111279, 0.117791, 0.124303, 0.130815, 0.137327, 0.143839, 0.150351, 
                      0.156863, 0.168424, 0.179986, 0.191548, 0.203109, 0.214671, 0.226233, 0.237795, 
                      0.249356, 0.260918, 0.272480, 0.298329, 0.324178, 0.350028, 0.375877, 0.401727, 
                      0.427576, 0.453425, 0.479275, 0.505124, 0.530973, 0.561608, 0.592243, 0.622878, 
                      0.653512, 0.684147, 0.714782, 0.745416, 0.776051, 0.806686, 0.837321, 0.906650, 
                      0.975979, 1.045308, 1.114637, 1.183966, 1.253296, 1.322625, 1.391954, 1.461283, 
                      1.530612, 1.645408, 1.760204, 1.875000, 1.989796, 2.104592, 2.219388, 2.334184, 
                      2.448980, 2.563776, 2.678571, 2.828571, 2.978571, 3.128571, 3.278571, 3.428571, 
                      3.686810, 3.945048, 4.203287, 4.461525, 4.719764, 5.009744, 5.299725, 5.589705, 
                      5.879685, 6.169666, 6.497294, 6.824923, 7.152551, 7.480179, 7.807808, 8.272163, 
                      8.736519, 9.200874, 9.665229, 10.129585, 10.593940, 11.058296, 11.522651, 11.987006, 
                      12.451362, 13.591026, 14.730690, 15.870354, 17.010017, 18.149681, 19.289345, 20.429009





gienvt1[] fillarray     0.004187, 0.004487, 0.004809, 0.005154, 0.005524, 0.005921, 0.006346, 0.006801, 0.007289, 0.007812, 
                        0.008373, 0.008974, 0.009618, 0.010309, 0.011049, 0.011842, 0.012691, 0.013602, 0.014579, 0.015625, 
                        0.016746, 0.017948, 0.019237, 0.020617, 0.022097, 0.023683, 0.025383, 0.027205, 0.029157, 0.031250, 
                        0.033493, 0.035897, 0.038473, 0.041235, 0.044194, 0.047366, 0.050766, 0.054409, 0.058315, 0.062500, 
                        0.066986, 0.071794, 0.076947, 0.082469, 0.088388, 0.094732, 0.101532, 0.108819, 0.116629, 0.125000, 
                        0.133972, 0.143587, 0.153893, 0.164938, 0.176777, 0.189465, 0.203063, 0.217638, 0.233258, 0.250000, 
                        0.267943, 0.287175, 0.307786, 0.329877, 0.353553, 0.378929, 0.406126, 0.435275, 0.466516, 0.500000, 
                        0.535887, 0.574349, 0.615572, 0.659754, 0.707107, 0.757858, 0.812252, 0.870551, 0.933033, 1.000000, 
                        1.071773, 1.148698, 1.231144, 1.319508, 1.414214, 1.515717, 1.624505, 1.741101, 1.866066, 2.000000, 
                        2.143547, 2.297397, 2.462289, 2.639016, 2.828427, 3.031433, 3.249010, 3.482202, 3.732132, 4.000000, 
                        4.287094, 4.594793, 4.924578, 5.278032, 5.656854, 6.062866, 6.498019, 6.964405, 7.464264, 8.000000, 
                        8.574188, 9.189587, 9.849155, 10.556063, 11.313709, 12.125733, 12.996038, 13.928809, 14.928528, 16.000000, 
                        17.148375, 18.379174, 19.698311, 21.112127, 22.627417, 24.251465, 25.992077, 26.992077

// env T3
gienvt3[] fillarray     0.090000, 0.097000, 0.104000, 0.111000, 0.118000, 0.125000, 0.132000, 0.139000, 
                        0.146000, 0.153000, 0.160000, 0.164000, 0.168000, 0.172000, 0.176000, 0.180000, 
                        0.184000, 0.188000, 0.192000, 0.196000, 0.200000, 0.205000, 0.210000, 0.215000, 
                        0.220000, 0.225000, 0.230000, 0.235000, 0.240000, 0.245000, 0.250000, 0.258000, 
                        0.266000, 0.274000, 0.282000, 0.290000, 0.298000, 0.306000, 0.314000, 0.322000, 
                        0.330000, 0.348000, 0.366000, 0.384000, 0.402000, 0.420000, 0.438000, 0.456000, 
                        0.474000, 0.492000, 0.510000, 0.539000, 0.568000, 0.597000, 0.626000, 0.655000, 
                        0.684000, 0.713000, 0.742000, 0.771000, 0.800000, 0.858000, 0.916000, 0.974000, 
                        1.032000, 1.090000, 1.148000, 1.206000, 1.264000, 1.322000, 1.380000, 1.545000, 
                        1.710000, 1.875000, 2.040000, 2.205000, 2.370000, 2.535000, 2.700000, 2.865000, 
                        3.030000, 3.595000, 4.160000, 4.725000, 5.290000, 5.855000, 6.420000, 6.985000, 
                        7.550000, 8.115000, 8.680000, 9.224000, 9.768000, 10.312000, 10.856000, 11.400000, 
                        11.864000, 12.328000, 12.792000, 13.256000, 13.720000, 14.447500, 15.175000, 15.902500, 
                        16.630000, 17.357500, 18.085000, 18.812500, 19.540000, 20.267500, 20.995000, 22.048500, 
                        23.102000, 24.155500, 25.209000, 26.262500, 27.316000, 28.369500, 29.423000, 30.476500, 
                        31.530000, 32.394286, 33.258571, 34.122857, 34.987143, 35.851429, 36.715714, 37.580000



// ent T4 values 0-127 
gienvt4[] fillarray     0.007000, 0.009300, 0.011600, 0.013900, 0.016200, 0.018500, 0.020800, 0.023100, //7
                        0.025400, 0.027700, 0.030000, 0.034400, 0.038800, 0.043200, 0.047600, 0.052000, //15
                        0.056400, 0.060800, 0.065200, 0.069600, 0.074000, 0.083100, 0.092200, 0.101300, //
                        0.110400, 0.119500, 0.128600, 0.137700, 0.146800, 0.155900, 0.165000, 0.184100, //31
                        0.203200, 0.222300, 0.241400, 0.260500, 0.279600, 0.298700, 0.317800, 0.336900, 
                        0.356000, 0.394400, 0.432800, 0.471200, 0.509600, 0.548000, 0.586400, 0.624800, 
                        0.663200, 0.701600, 0.740000, 0.808000, 0.876000, 0.944000, 1.012000, 1.080000, 
                        1.148000, 1.216000, 1.284000, 1.352000, 1.420000, 1.541000, 1.662000, 1.783000,  // 63
                        1.904000, 2.025000, 2.146000, 2.267000, 2.388000, 2.509000, 2.630000, 2.887000, 
                        3.144000, 3.401000, 3.658000, 3.915000, 4.172000, 4.429000, 4.686000, 4.943000, 
                        5.200000, 5.520000, 5.840000, 6.160000, 6.480000, 6.800000, 7.120000, 7.440000, 
                        7.760000, 8.080000, 8.400000, 8.909000, 9.418000, 9.927000, 10.436000, 10.945000, 
                        11.454000, 11.963000, 12.472000, 12.981000, 13.490000, 14.243000, 14.996000, 15.749000, 
                        16.502000, 17.255000, 18.008000, 18.761000, 19.514000, 20.267000, 21.020000, 22.101000, 
                        23.182000, 24.263000, 25.344000, 26.425000, 27.506000, 28.587000, 29.668000, 30.749000, 
                        31.830000, 32.902857, 33.975714, 35.048571, 36.121429, 37.194286, 38.267143, 39.340000



gidcoenv[] = array(1)

gicrsrate[] fillarray  0, 0.004839651931 ,0.005965252815 ,0.007090853698 ,0.008216454581 ,0.009342055464 ,0.01046765635 ,0.01159325723 ,0.01271885811 ,
                       0.013844459 ,0.01497005988 ,0.01609566076 ,0.01722126165 ,0.01834686253 ,0.01947246341 ,0.0205980643 ,0.02172366518 ,
                       0.02284926606 ,0.02397486695 ,0.02510046783 ,0.02622606871 ,0.02809986472 ,0.02997366073 ,0.03184745673 ,0.03372125274 ,
                       0.03559504874 ,0.03746884475 ,0.03934264076 ,0.04121643676 ,0.04309023277 ,0.04496402878 ,0.04868455277 ,0.05240507676 ,
                       0.05612560075 ,0.05984612474 ,0.06356664874 ,0.06728717273 ,0.07100769672 ,0.07472822071 ,0.0784487447 ,0.08216926869 ,
                       0.08742943077 ,0.09268959285 ,0.09794975493 ,0.103209917 ,0.1084700791 ,0.1137302412 ,0.1189904032 ,0.1242505653 ,
                       0.1295107274 ,0.1347708895 ,0.1452746159 ,0.1557783423 ,0.1662820687 ,0.1767857951 ,0.1872895215 ,0.1977932479 ,
                       0.2082969743 ,0.2188007007 ,0.2293044271 ,0.2398081535 ,0.2577736469 ,0.2757391402 ,0.2937046336 ,0.311670127 ,
                       0.3296356204 ,0.3476011137 ,0.3655666071 ,0.3835321005 ,0.4014975939 ,0.4194630872 ,0.4552168562 ,0.4909706252 ,
                       0.5267243942 ,0.5624781631 ,0.5982319321 ,0.6339857011 ,0.6697394701 ,0.7054932391 ,0.741247008 ,0.777000777 ,
                       0.8356643357 ,0.8943278943 ,0.952991453 ,1.011655012 ,1.07031857 ,1.128982129 ,1.187645688 ,1.246309246 ,
                       1.304972805 ,1.363636364 ,1.441941779 ,1.520247195 ,1.59855261 ,1.676858026 ,1.755163441 ,1.833468857 ,
                       1.911774272 ,1.990079688 ,2.068385103 ,2.146690519 ,2.355053194 ,2.56341587 ,2.771778545 ,2.980141221 ,
                       3.188503896 ,3.396866572 ,3.605229247 ,3.813591923 ,4.021954598 ,4.230317274 ,4.530177113 ,4.830036952 ,
                       5.12989679 ,5.429756629 ,5.729616468 ,6.029476307 ,6.329336146 ,6.629195985 ,6.929055824 ,7.228915663 ,
                       7.66141489 ,8.093914118 ,8.526413346 ,8.958912573 ,9.391411801 ,9.823911029 ,10.25641026 

gidynVcaRes[] fillarray 0,0.187 ,0.1928888889 ,0.1987777778 ,0.2046666667 ,0.2105555556 ,0.2164444444 ,0.2223333333 ,0.2282222222 ,
                        0.2341111111 ,0.24 ,0.2443 ,0.2486 ,0.2529 ,0.2572 ,0.2615 ,0.2658 ,
                        0.2701 ,0.2744 ,0.2787 ,0.283 ,0.2883 ,0.2936 ,0.2989 ,0.3042 ,
                        0.3095 ,0.3148 ,0.3201 ,0.3254 ,0.3307 ,0.336 ,0.3413 ,0.3466 ,
                        0.3519 ,0.3572 ,0.3625 ,0.3678 ,0.3731 ,0.3784 ,0.3837 ,0.389 ,
                        0.3943 ,0.3996 ,0.4049 ,0.4102 ,0.4155 ,0.4208 ,0.4261 ,0.4314 ,
                        0.4367 ,0.442 ,0.4476 ,0.4532 ,0.4588 ,0.4644 ,0.47 ,0.4756 ,
                        0.4812 ,0.4868 ,0.4924 ,0.498 ,0.504 ,0.51 ,0.516 ,0.522 ,
                        0.528 ,0.534 ,0.54 ,0.546 ,0.552 ,0.558 ,0.5647 ,0.5714 ,
                        0.5781 ,0.5848 ,0.5915 ,0.5982 ,0.6049 ,0.6116 ,0.6183 ,0.625 ,
                        0.6318 ,0.6386 ,0.6454 ,0.6522 ,0.659 ,0.6658 ,0.6726 ,0.6794 ,
                        0.6862 ,0.693 ,0.7004 ,0.7078 ,0.7152 ,0.7226 ,0.73 ,0.7374 ,
                        0.7448 ,0.7522 ,0.7596 ,0.767 ,0.7744 ,0.7818 ,0.7892 ,0.7966 ,
                        0.804 ,0.8114 ,0.8188 ,0.8262 ,0.8336 ,0.841 ,0.8474 ,0.8538 ,
                        0.8602 ,0.8666 ,0.873 ,0.8794 ,0.8858 ,0.8922 ,0.8986 ,0.905 ,
                        0.9185714286 ,0.9321428571 ,0.9457142857 ,0.9592857143 ,0.9728571429 ,0.9864285714 ,1

gichars[] fillarray 63,  62,  0, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,  0,  0,  0,  0,  0,  0,  0,
                     0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
                    20, 21, 22, 23, 24, 25,  0,  0,  0,  0,  0,  0, 26, 27, 28, 29, 30, 31, 32, 33,
                    34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,  0,  0


givcfenvdl[] fillarray 0,	0.232,	0.328,	0.392,	0.468,	0.564,	0.62,	0.712,	0.772,	0.792,	0.852,	0.9,	0.924,	0.976,	1,	1
givcfenvdu[] fillarray 0, 0.012, 0.044, 0.06, 0.0888, 0.12, 0.16, 0.208, 0.272, 0.332, 0.4, 0.48, 0.56, 0.728, 0.964,1


gkpitchb = 0           // Pitchbend
gkvibrat = 0           // vibrato
gkmaxvoices = 6
gkvoices[] fillarray -1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000, 
                     -1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000,
                     -1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000,
                     -1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000
gkmidinotes[]   fillarray -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 
                          -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 
                          -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,                           
                          -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1

gkeycount = 0         // count of key pressed
gaLFO = 0             // LFO 

gSBankPreset = "./presets/FACTORYA.SYX"
gSBankMemory = "./presets/FACTORYB.SYX"
gScurcart = "./presets/USERCART.SYX"
gScharju = "ABCDEFGHIJKLMNOPKRSTUVWXYZabcdefghijklmnopkrstuvwxyz0123456789 -"  // letters ordered as in Juno's
giAmp = 1                                                                      // amplitude per oscilators
gkCopy = 1                                                                     // copy mode Copy at init
gicurprog = 0                                                                  // current program, 0 at init
gScurbank = gSBankPreset                                                       // current bank, preset at init
giNameInput = 0                                                                // Name input mode indicator
gicurletter = 0                                                                // current edited letter
gSName = "             "                                                       // current tone name
gSbufname = "             "                                                     // current tone name in buffer




// ----------------------------------------------------------------------------------------------------------------
;returns the name of a file path
// ----------------------------------------------------------------------------------------------------------------
opcode FilNam, S, S
    Spath  xin
    ipos   strrindex Spath, "/"	;look for the rightmost '/'
    Snam   strsub    Spath, ipos+1	;extract the substring 
       xout      Snam
endop
  

// ----------------------------------------------------------------------------------------------------------------
;Author: Iain McCurdy (2012)
;http://iainmccurdy.org/csound.html
// ----------------------------------------------------------------------------------------------------------------
opcode	StChorus,aa,aakkakk
	ainL,ainR,krate,kdepth,aoffset,kwidth,kmix	xin			;READ IN INPUT ARGUMENTS
	ilfoshape	ftgentmp	0, 0, 131072, 19, 1, 0.5, 0,  0.5	;POSITIVE DOMAIN ONLY SINE WAVE
	kporttime	linseg	0,0.001,0.02					;RAMPING UP PORTAMENTO VARIABLE
	kChoDepth	portk	kdepth*0.01, kporttime				;SMOOTH VARIABLE CHANGES WITH PORTK
	aChoDepth	interp	kChoDepth					;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE
	amodL 		osciliktp 	krate, ilfoshape, 0			;LEFT CHANNEL LFO
	amodR 		osciliktp 	krate, ilfoshape, kwidth*0.5		;THE PHASE OF THE RIGHT CHANNEL LFO IS ADJUSTABLE
	amodL		=		(amodL*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (LEFT CHANNEL)
	amodR		=		(amodR*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (RIGHT CHANNEL)
	aChoL		vdelay	ainL, amodL*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (LEFT CHANNEL) 
	aChoR		vdelay	ainR, amodR*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (RIGHT CHANNEL)
	aoutL		ntrpol 	ainL*0.6, aChoL*0.6, kmix			;MIX DRY AND WET SIGNAL (LEFT CHANNEL)
	aoutR		ntrpol 	ainR*0.6, aChoR*0.6, kmix			;MIX DRY AND WET SIGNAL (RIGHT CHANNEL)
			xout	aoutL * 2 ,aoutR * 2					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop




// ----------------------------------------------------------------------------------------------------------------
// Load an array from a file, first number in file is the number of records in the file
// ----------------------------------------------------------------------------------------------------------------
opcode loadarray, i[],S
    Sfilename xin
    iLen2 = 3
    iLen init 0
            
    iOut2[] init 1
    
    fini Sfilename, 0,1 , iLen

    if (iLen != 0) then 
        iOut[] init iLen
    endif 
    //printf_i "file %s, array len : %d \n",1, Sfilename, iLen
    iRng = 0
    getdata:
        iTmp init 0
        fini Sfilename, 0,1 , iTmp
        iOut[iRng] = iTmp
    loop_lt iRng, 1, iLen, getdata
    ficlose Sfilename 
    
    xout iOut
endop


// ----------------------------------------------------------------------------------------------------------------
// Display LCD characters, use channel "lid" and identChannels pos[1-16] 
// ----------------------------------------------------------------------------------------------------------------
opcode dispLCD, i, S
    Sdisp xin

    
    iIdent = 0
    label3:
        ideb strchar Sdisp , iIdent
        SPos sprintf "pos%d",iIdent 
        SChar  strsub Sdisp, iIdent, iIdent + 1
        icropx = ((ideb -45) % 20) * 40
        icropy = int((ideb -45)/ 20) * 60
        SLetter sprintf "crop(%d, %d, 40, 60)", icropx, icropy
        chnset SLetter,SPos
    loop_le iIdent, 1, strlen(Sdisp), label3
    xout 0

endop

// ----------------------------------------------------------------------------------------------------------------
// Begin of Synth
// ----------------------------------------------------------------------------------------------------------------
opcode June21,a,kkk
    kcps,kvel,kmidinote xin

    kimdead init 0     ; will be 1 if I need to die (quietly with no click...)
  

// ----------------------------------------------------------------------------------------------------------------
// Gets
// ----------------------------------------------------------------------------------------------------------------
kPulse          chnget "pulse"
kSawtooth       chnget "sawtooth"
kSawtooth       = kSawtooth
kSub            chnget "sub"
kSub             = kSub
ktmpSubLvl         chnget "sublevl" 
kpwpwm          chnget "pwpwm"
kNoisLvl        chnget "noislvl"
kNoisLvl         = kNoisLvl
kPwmRate        chnget "pwmrate"
kDcoRng         chnget "dcorng"
kDcoLfo         chnget "dcolfo"
kDcoEnvd        chnget "dcoenvd"
kDcoEnv         chnget "dcoenv"    
kDcoEnv = 3 - kDcoEnv   // slide upside down
kHpfFreq        chnget "hpffreq" 
kVcfFreq        chnget "vcffreq" 
kVcfReso        chnget "vcfreso" 
kVcfEnvd        chnget "vcfenvd" 
kVcfEnv         chnget "vcfenv" 
kVcfEnv = 3 - kVcfEnv   // slide upside down
kVcfKybd        chnget "vcfkybd"
kVcfLfo         chnget "vcflfo" 
/* iVcaEnvd        chnget "vcaenvd"  */
kVcaEnv         chnget "vcaenv" 
kVcaEnv = 3 - kVcaEnv   // slide upside down
iEnvT1          chnget "envt1"
iEnvT2          chnget "envt2"
iEnvT3          chnget "envt3"
iEnvT4          chnget "envt4"
iEnvL1          chnget "envl1"
iEnvL2          chnget "envl2"
iEnvL3          chnget "envl3"
kDcoBnd         chnget "dcobnd"

gkPostAmp      chnget "vcalevl"
giPreset       chnget "grpPreset"
giMemory       chnget "grpMemory"
giCartridge    chnget "grpCartridge"


// ----------------------------------------------------------------------------------------------------------------
// ENV Block 
// ----------------------------------------------------------------------------------------------------------------
//kres expon ia, idur, ib
    if (iEnvL1 > iEnvL2) then 
        kEnv  transegr      0, gienvt1[iEnvT1],  0, 
                       iEnvL1, gienvt1[iEnvT2],  0, 
                       iEnvL2, gienvt3[iEnvT3], -2,
                       iEnvL3, gienvt4[iEnvT4], -4,
                       0
                       
    else
        kEnv transegr     0, gienvt1[iEnvT1*iEnvL1/127],  0,
                     iEnvL1, gienvt1[iEnvT2]           ,  0,
                     iEnvL2, gienvt4[iEnvT3]           , -4,
                     iEnvL3, gienvt4[iEnvT4]           , -4,
                     0
        
    endif 
kEnvL = kEnv / 127
kEnvVCF = kEnv
kEnvG  transegr     0, 0.0001, -4,
                    1,0.05,-4,
                    0
kEnvGS  transegr     0, 0.0001, 0,
                    1,0.3,0,
                    0


// ----------------------------------------------------------------------------------------------------------------
// LFO PW Block
// ----------------------------------------------------------------------------------------------------------------
if (kPwmRate != 0) then
    kLfoPw          lfo kpwpwm/2, gipwmrate[kPwmRate], 1                        // Rate for LFO PWM
    kLfoPw          = kLfoPw - kpwpwm/2
else 
    kLfoPw = kpwpwm                                                     // Basicely No LFO PWM
endif 



// ----------------------------------------------------------------------------------------------------------------
// DCO Block
// ----------------------------------------------------------------------------------------------------------------
kbnd = gkpitchb * kDcoBnd / (12 * 64)

// Note
kNote           =  kcps * (8  / (2^(kDcoRng + 2)))                        // Base note calculation : note * dcoRng correction 
kNotecps         = kcps * (8  / (2^(kDcoRng + 2)))
kNote           = (kNotecps  +  gaLFO * (kNotecps * (gilfovals[kDcoLfo] + gkvibrat/1500) / 2)) * powoftwo(kbnd)   // note + lfo oscilation
    
if (kDcoEnv == 0) then    // Norm 
    kNote = kNote + (kNotecps/130.9) * gidcoenv[128 * round(kEnvVCF) +  kDcoEnvd] 
elseif (kDcoEnv == 1) then // Inv : 
    kNote = kNote - (kNotecps/(130.9 * 8)) * gidcoenv[128 * round(kEnvVCF) +  kDcoEnvd] 
elseif (kDcoEnv == 2) then // D-Norm 
    kNote = kNote + (kNotecps/130.9) * gidcoenv[128 * round(kEnvVCF) +  kDcoEnvd]  * (kvel / 127)
elseif (kDcoEnv == 3) then // D-Inv 
    kNote = kNote - (kNotecps/(130.9* 8)) * gidcoenv[128 * round(kEnvVCF) +  kDcoEnvd]  * (kvel / 127)
endif



; -- Square part
if (kPulse == 0) then 
    aOsc1 = 0
else
    if (kPulse == 1) then
        aTmp  vco2  giAmp , kNote, 10, 0, 0  // Square 
        aTmp = - aTmp
    elseif (kPulse == 2) then 
        aTmp   vco2  giAmp, kNote, 2, 0.75
        aTmp = - aTmp
    elseif (kPulse == 3) then
        aTmp   vco2  giAmp, kNote ,2,  0.5 - (kLfoPw)*0.49/127  
        aTmp = - aTmp    // move amplitude to signal up according to pw  -  kLfoPw/127
    endif 
    aOsc1 = aTmp
endif 



; -- Sawtooth part
if (kSawtooth == 0) then 
    aOsc2  = 0
else
    aSaw1 vco2  giAmp, kNote ,0
    
    if (kSawtooth == 1) then
        aTmp           =  - aSaw1   
        
    elseif (kSawtooth  == 2) then
        aSquare1x2      vco2  1,kNote * 2, 10     // note * 2  
        aTmp           = (- aSaw1 + giAmp)  * (- aSquare1x2  + 1) / 4

    elseif (kSawtooth == 3) then
        asquarepwm      vco2  1, kNote * 2, 2 ,  0.5 - (kLfoPw)*0.49/127  
        aTmp           = (- aSaw1 + giAmp) * (- asquarepwm + 1) / 2   // saw03
    
    elseif (kSawtooth == 4) then
        asquare         vco2  1, kNote * 8, 10, 0.5, 0.5  // Gate for Sawtooth waves 
        aTmp           = (- aSaw1 + giAmp) * (- asquare  + 1)   // saw04

    elseif (kSawtooth == 5) then
        aSquared2       vco2  1, kNote*2,10     // note / 2  
        asquared8       vco2  1, kNote* 8, 10, 0.5, 0.5  // note / 8
        aSquare1x201    =   (- aSquared2     + 1) / 2    // Gate for Sawtooth waves 
        aSquare201      =   (asquared8 + 1) / 2    // Gate for Sawtooth waves 
        aTmp           = (-aSaw1 + 1) * (aSquare201) * aSquare1x201       // saw04
    endif 
    aOsc2 = aTmp
    
endif

; -- Sub part
if (ktmpSubLvl == 0) then 
    kSubLevel = 0
else
    kSubLevel = (2^(ktmpSubLvl)) / 8
endif


if (kSubLevel != 0) then 
    if (kSub == 0) then 
        aTmp   vco2  giAmp , kNote/2,10
        aTmp = -aTmp * kSubLevel

    elseif (kSub == 1) then
        aTmp vco2  giAmp, kNote/2 ,2,0.75
        aTmp = - aTmp * kSubLevel

    elseif (kSub == 2) then
        aSub1 vco2  1, kNote*2 ,10
        aSub2 vco2  1, kNote/2 ,10
        aTmp =   ((- aSub2 + 1) * (- aSub1 + 1) / 2 ) * kSubLevel 

    elseif (kSub == 3) then
        aSub1 vco2  giAmp, kNote*4 ,10
        aSub2 vco2  1, kNote/2 ,10
        aTmp =  ((- aSub2 + 1) * (- aSub1 + 1) / 2 )  * kSubLevel

    elseif (kSub == 4) then
        aTmp   vco2, giAmp , kNote/4,10
        aTmp = - aTmp * kSubLevel

    elseif (kSub == 5) then
        aTmp vco2   giAmp , kNote/4 ,2,0.75
        aTmp = - aTmp * kSubLevel
    endif 
    aOsc3 = aTmp
else 
   aOsc3 = 0
endif 

; -- Noise part
aOsc4   noise  kNoisLvl / 6, -0.9

; Output VCO Block
aOutVcoblock =  aOsc1 * .2 + aOsc2 * .2 + aOsc3 * .2 + aOsc4 * .2


//aTmpOut = aOutVcoblock    
//goto theend


// ----------------------------------------------------------------------------------------------------------------
// HPF Block
// ----------------------------------------------------------------------------------------------------------------
if (kHpfFreq == 0) then
    aOutHPFBlock        pareq aOutVcoblock,106, 2, 0.7071067812
elseif (kHpfFreq == 1) then
    aOutHPFBlock        = aOutVcoblock    
elseif (kHpfFreq == 2) then
    aOutHPFBlock        mvchpf aOutVcoblock,124
elseif (kHpfFreq == 3) then
    aOutHPFBlock        mvchpf aOutVcoblock ,220
endif


//aTmpOut = aOutHPFBlock        
//goto theend


// ----------------------------------------------------------------------------------------------------------------
// VCF Block
// ----------------------------------------------------------------------------------------------------------------
//  kx = <cutoff Freq> + <lfo impact> + <env impact (with or without dynamics> + + correction
//  <key follow impact>  : a ration of the frequency

if (kVcfEnv == 0) then       // Normal
    kx1 = (kVcfFreq + (  gaLFO * kVcfLfo / 4  + kEnvVCF * kVcfEnvd / 127)) / 12   - 3.2 
elseif (kVcfEnv == 1) then   // Inverted
    kx1 = (kVcfFreq - ( gaLFO * kVcfLfo / 4 + kEnvVCF * kVcfEnvd / 127)) / 12   - 3.2 
elseif (kVcfEnv == 2) then   // D-Norm
    kx1 = (kVcfFreq + ( gaLFO * kVcfLfo / 4 +  (kvel / 127) * kEnvVCF * kVcfEnvd / 127)) / 12   - 3.2 
elseif (kVcfEnv == 3) then   // dyn
    kx1 = (kVcfFreq + ( gaLFO * kVcfLfo / 4  + (kvel / 220) *  kVcfEnvd )) / 12   - 3.2 
endif

if kcps > 261.63 then        // Keyboard impact curves are not the same between lower than C4 and upper than C4 (C4 is the pivot)
    kx2 = (givcfenvdu[kVcfKybd] * (kcps - 261.63) + 261.63)/261.63
else 
    kx2 = (givcfenvdl[kVcfKybd] * (kcps - 261.63) + 261.63)/261.63
endif 

kcutoff = 100 * powoftwo( kx1) * kx2 


if kcutoff < 20 then
    kcutoff= 20
endif
if kcutoff> 10000 then
   kcutoff = 10000
endif

atmp moogvcf aOutHPFBlock        , kcutoff , 0
aOutVCFBlock reson atmp ,1.25 * kcutoff, kcutoff* 8  / kVcfReso, 2



//aTmpOut = aOutVCFBlock        
//goto theend

// ----------------------------------------------------------------------------------------------------------------
// VCA Block
// ----------------------------------------------------------------------------------------------------------------
aOutVCABlock init 0

if (kVcaEnv == 0) then
    aEnv interp	kEnvL	
elseif (kVcaEnv == 1) then
    aEnv interp	kEnvG
elseif (kVcaEnv  == 2) then 
    aEnv interp	kEnvL * gidynVcaRes[kvel]
elseif (kVcaEnv == 3) then 
    aEnv interp	kEnvG * gidynVcaRes[kvel]
endif
aOutVCABlock = aOutVCFBlock * aEnv 

/*  NOT ready for that yet : generate a lot of clicks
// if i'm in release mode and another or my note is played, or i've already beed told i'm dead
 krel release 
if (((krel == 1) && (gkmidinotes[kmidinote] != -1)) || (kimdead != 0))  then 
    aEnvG interp kEnvGS
    //aOutVCABlock   =  aOutVCABlock   * aEnvG
    kimdead = 1 
endif  
*/
//aTmpOut = aOutVCABlock 
//goto theend





// ----------------------------------------------------------------------------------------------------------------
// Output
// ----------------------------------------------------------------------------------------------------------------
xout	aOutVCABlock* gkPostAmp / 127 


theend:      

//xout  aTmpOut * gkPostAmp * 1.2 /127
endop



// ----------------------------------------------------------------------------------------------------------------
// Dummy instrument
// ----------------------------------------------------------------------------------------------------------------
instr	1	// Dummy (to capture Cabbage Midi)
    // Nothing ...
endin 

    
        
        

instr EFFECT


    // ----------------------------------------------------------------------------------------------------------------
    // LFO block
    // ----------------------------------------------------------------------------------------------------------------
    kLfoRate        chnget "lforate"  
    kLfoDely        chnget "lfodely"  

    if (kLfoDely > 10) then 
        ktmp = 1 
    else 
        ktmp = 0 
    endif 
    if (gkeycount == 0) then 
        reinit lforeinit     // LFO delay is restarted when no note are pressed
    endif
    lforeinit:
    if kLfoDely = 0 then
        kLfoAmp = 1
    else 
        kLfoAmp            linseg 0,gilfodels[i(kLfoDely)] , 0,i(ktmp) ,1 // Delay for LFO1 
    endif
    rireturn 
    gaLFO            lfo kLfoAmp, gilforate[kLfoRate], 1                                // Rate for LFO 


    // ----------------------------------------------------------------------------------------------------------------
    // Chorus block
    // ----------------------------------------------------------------------------------------------------------------
    asuml chnget "tochorus"
    denorm asuml
    
    kchorus     chnget "chorus"
    kCrsRate    chnget "crsrate"
    aoffset = 0

    if (kchorus == 1) then 
        aoffset = 0
        aoutChorusL,aoutChorusR 	StChorus	asuml ,asuml , gicrsrate[kCrsRate], 0.2	, aoffset, 0.5, 0.5
        aL dcblock2 aoutChorusL
        aR dcblock2 aoutChorusR
	    outs aL, aR
    else
	    outs asuml , asuml
    endif 

    chnclear "tochorus"
endin 
                        
                                                                                                      
// ----------------------------------------------------------------------------------------------------------------
// Midi listener (inspired/copied from Iain McCurdy
// ----------------------------------------------------------------------------------------------------------------
instr	100	// Midi Listener
    ichan  = 0 
    insno = 200                                           ; The main instrument
    kvoice = -1000
	kstatus, kchan, kdata1, kdata2  midiin				;READ IN MIDI  kdata1 : note, kdata2 : velo
	
	
//	printks "voices :%3d %3d %3d %3d %3d %3d\n",1, gkvoices[0], gkvoices[1], gkvoices[2], gkvoices[3], gkvoices[4], gkvoices[5]
	kmaxvoice chnget "maxvoice" 

	if (kmaxvoice == 1) then
	    gkmaxvoices = 6 
	else 
	    gkmaxvoices  = powoftwo(kmaxvoice + 1)
    endif 
	
	if (kchan == ichan || ichan == 0) then			    ;IF A MESSAGE ON THE CORRECT CHANNEL HAS BEEN RECEIVED (OR ON ANY CHANNEL IF CHANNEL WAS DEFINED AS ZERO)
        if (kstatus == 144) then						;IF MIDI MESSAGE IS A NOTE...
	        if (kdata2 > 0) then						;IF VELOCITY IS MORE THAN ZERO, I.E. NOT A NOTE OFF
                kdx = 0                                 ; Get an available voice (if any) 
                gkeycount = gkeycount + 1               ; add a note to keycount
                loop1:
                    if (gkvoices[kdx] == - kdata1) then ; is a voice with the same note available ? 
                        kvoice = kdx
                        goto endloop
                    endif 
                loop_lt kdx, 1, gkmaxvoices, loop1
                if (kdx != gkmaxvoices)  goto endloop
                kdx = 0                                 ; Get an available voice (if any) 
                loop2:
                    if (gkvoices[kdx] < 0) then
                        kvoice = kdx
                        goto endloop
                    endif 
                loop_lt kdx, 1, gkmaxvoices, loop2
                endloop:
	            if (kvoice != -1000)  then                  ; Can we play this note ? 
  	                gkvoices[kvoice] = kdata1
	                gkmidinotes[kdata1] = kvoice 
	                ktmp = kvoice
	 	            event "i",insno +(kdata1 * 0.001), 0, -1, cpsmidinn(kdata1), kdata2,kdata1	;TRIGGER INSTRUMENT WITH A HELD NOTE. NOTE NUMBER TRANSMITTED AS p4, VELOCITY AS p5
                    /* reinit emitnote
                    emitnote:
                        kHandle  nstance insno +(i(kdata1) * 0.001), 0, -1, cpsmidinn(i(kdata1)), i(kdata2)
                    rireturn   */
	
                endif
	        else								        ;OTHERWISE (I.E. MUST BE A NOTE OFF / ZERO VELOCITY)
                gkeycount = gkeycount - 1               
                kvoice  = gkmidinotes[kdata1] 
	            if (kvoice != -1000) then 
	                kbranch = 4
	                gkvoices[kvoice] = - gkvoices[kvoice]
                    gkmidinotes[kdata1] = - 1 
	                turnoff2	insno + (kdata1 * 0.001), 4, 1			;TURN OFF INSTRUMENT WITH THIS SPECIFIC FRACTIONAL NOTE NUMBER
	
                endif 
	        endif								
	    elseif kstatus==128 then					    ;IF MESSAGE USES A 'NOTE OFF' STATUS BYTE (128)
            gkeycount = gkeycount - 1               
	        turnoff2	insno+(kdata1*0.001),4,1	    ;TURN OFF INSTRUMENT WITH THIS SPECIFIC FRACTIONAL NOTE NUMBER
            kvoice  = gkmidinotes[kdata1] 
	        if (kvoice != -1) then 
	            gkvoices[kvoice] = - gkvoices[kvoice]
                gkmidinotes[kdata1] = - 1 
            endif 
        elseif (kstatus == 224) then                    ; Pitch bend
            gkpitchb = (kdata2 & 127) - 64
        elseif ((kstatus == 176) && (kdata1 == 1))  then                       ; vibrato
            gkvibrat = kdata2
	    endif								;END OF CONDITIONAL BRANCH
	
	endif								;END OF CONDITIONAL BRANCH

    kactive	active	insno  		;...check number of active midi notes 
    SIdent sprintfk "text(%d)", kactive
    chnset SIdent, "voicecount"

endin 

// ----------------------------------------------------------------------------------------------------------------
// One note 
// ----------------------------------------------------------------------------------------------------------------
instr	200	// Main instrument
    asuml June21, p4, p5,p6
    chnmix asuml, "tochorus"
endin

                                                              

// ----------------------------------------------------------------------------------------------------------------
// Update GUI
// ----------------------------------------------------------------------------------------------------------------
instr updateGUI

 
    ktrig changed chnget:k("btb1"), chnget:k("btb2"), chnget:k("btb3"), chnget:k("btb4") , chnget:k("btb5"), chnget:k("btb6"), chnget:k("btb7"), chnget:k("btb8") , chnget:k("btn1"), chnget:k("btn2"), chnget:k("btn3"), chnget:k("btn4") , chnget:k("btn5"), chnget:k("btn6"), chnget:k("btn7"), chnget:k("btn8"), chnget:k("grpPreset"), chnget:k("grpMemory"), chnget:k("grpCartridge")
    
    if ktrig == 1  then 
        event "i", 1002, 0, 0           // Tone changed
    endif
  
 
    if changed:k(chnget:S("openFile")) == 1 then
        event "i", 1004, 0, 0          // Open a cartridge (.SYX file)
    endif
    
    ktrig  changed  chnget:k("btcopy")  
    if ktrig == 1 then
        event "i",1005, 0, 0           // Copy the current tone in the buffer
    endif 

    ktrig  changed  chnget:k("btpaste")  
    if ktrig == 1 then
        event "i",1006, 0, 0           // Paste the buffer in the current tone 
    endif 
        
    ktrig changed  chnget:k("left"), chnget:k("right")
    if ktrig == 1 then
        event "i",1007, 0, 0           // Change name of the current tone (into the buffer) 
    endif 

    ktrig changed chnget:k("letter") 
    if ktrig == 1 then
        event "i",1008, 0, 0, 200      // Change name of the current tone (into the buffer)  200 => modify letter in name 
    endif 
            
    ktrig changed chnget:k("btpanic")
    if ktrig == 1 then
        turnoff2 200,0,0
    endif 
    
endin


// ----------------------------------------------------------------------------------------------------------------
// Open File 
// ----------------------------------------------------------------------------------------------------------------
instr 1004  // open a cartridge (.SYX file)

    STmp  chnget "openFile"
    if (strcmp(STmp,gScurcart) != 0) then 
        gScurcart = STmp
        chnset  1 ,  "grpCartridge"
        STmp FilNam gScurcart 
        ipos strindex STmp ,"."
        Stmp2 sprintf "text(%s, %s)" , strsub(STmp,0,ipos), strsub(STmp,0,ipos)
        chnset Stmp2, "CartName"
        a1 subinstr 1002
    endif
    
endin    


    
instr 1002 // Tone changed
    iIdent = 1
    gicurprog = 0
    iBank = 0 
    kblink = 0

    iTmp chnget "grpPreset"
    if (iTmp == 1) then
        gScurbank =  gSBankPreset  
        iBank = 0
    endif 
    iTmp chnget "grpMemory"
    if (iTmp == 1) then
        gScurbank = gSBankMemory  
        iBank = 1
    endif 
    iTmp chnget "grpCartridge"
    if ((iTmp == 1) && strlen(gScurcart) != 0) then
        gScurbank = gScurcart
        iBank = 2
    endif 
    
            
    labelb1:
        Sbt sprintf "btb%d",iIdent 
        ideb  chnget Sbt 
        if (ideb == 1) then 
            gicurprog = (iIdent - 1)  * 8 - 1
        endif
    loop_le iIdent, 1, 8, labelb1
    iIdent = 1
    labelb2:
        Sbt sprintfk "btn%d",iIdent 
        ideb  chnget Sbt 
        if (ideb == 1) then 
            gicurprog = gicurprog + iIdent 
        endif
    loop_le iIdent, 1, 8, labelb2
    
    
    gSName getjuname gScurbank,gicurprog  ,iBank  ; use of plugin to get the tone name from the midi bulk dump from synth
                                    
    iLid3 dispLCD gSName
   
    iParm  getjuparm gScurbank, gicurprog, "dcoaftr"
    chnset iParm, "dcoaftr"
    iParm  getjuparm gScurbank, gicurprog, "dcobnd"
    chnset iParm, "dcobnd"
    iParm  getjuparm gScurbank, gicurprog, "vcfkybd"
    chnset iParm, "vcfkybd"
    iParm  getjuparm gScurbank, gicurprog, "vcfaftr"
    chnset iParm, "vcfaftr"
    iParm  getjuparm gScurbank, gicurprog, "vcaaftr"
    chnset iParm, "vcaaftr"
    iParm  getjuparm gScurbank, gicurprog, "envkybd"
    chnset iParm, "envkybd"
    iParm  getjuparm gScurbank, gicurprog, "dcobnd"
    chnset iParm, "dcobnd"
    iParm  getjuparm gScurbank, gicurprog, "dcolfo"
    chnset iParm, "dcolfo"
    iParm  getjuparm gScurbank, gicurprog, "chorus" 
    chnset iParm, "chorus"
    iParm  getjuparm gScurbank, gicurprog, "dcoenvd"
    chnset iParm, "dcoenvd"
    iParm  getjuparm gScurbank, gicurprog, "pwpwm"
    chnset iParm, "pwpwm"
    iParm  getjuparm gScurbank, gicurprog, "pwmrate"
    chnset iParm, "pwmrate"
    iParm  getjuparm gScurbank, gicurprog, "dcoenv"
    iParm  = 3 - iParm     // in order to have the slide "upside down"
    chnset iParm, "dcoenv"
    iParm  getjuparm gScurbank, gicurprog, "vcffreq"
    chnset iParm, "vcffreq"
    iParm  getjuparm gScurbank, gicurprog, "vcfreso"
    chnset iParm, "vcfreso"
    iParm  getjuparm gScurbank, gicurprog, "vcfenv"
    iParm  = 3 - iParm     // in order to have the slide "upside down"
    chnset iParm, "vcfenv"
    iParm  getjuparm gScurbank, gicurprog, "vcfenvd"
    chnset iParm, "vcfenvd"
    iParm  getjuparm gScurbank, gicurprog, "vcflfo"
    chnset iParm, "vcflfo"
    iParm  getjuparm gScurbank, gicurprog, "vcaenv"
    iParm  = 3 - iParm     // in order to have the slide "upside down"
    chnset iParm, "vcaenv"
    iParm  getjuparm gScurbank, gicurprog, "vcalevl"
    chnset iParm, "vcalevl"
    iParm  getjuparm gScurbank, gicurprog, "lforate"
    chnset iParm, "lforate"
    iParm  getjuparm gScurbank, gicurprog, "lfodely"
    chnset iParm, "lfodely"
    iParm  getjuparm gScurbank, gicurprog, "sub"
    chnset iParm, "sub"
    iParm  getjuparm gScurbank, gicurprog, "envt1"
    chnset iParm, "envt1"
    iParm  getjuparm gScurbank, gicurprog, "envl1"
    chnset iParm, "envl1"
    iParm  getjuparm gScurbank, gicurprog, "envt2"
    chnset iParm, "envt2"
    iParm  getjuparm gScurbank, gicurprog, "sawtooth"
    chnset iParm, "sawtooth"
    iParm  getjuparm gScurbank, gicurprog, "envl2"
    chnset iParm, "envl2"
    iParm  getjuparm gScurbank, gicurprog, "envt3"
    chnset iParm, "envt3"
    iParm  getjuparm gScurbank, gicurprog, "pulse"
    chnset iParm, "pulse"
    iParm  getjuparm gScurbank, gicurprog, "envl3"
    chnset iParm, "envl3"
    iParm  getjuparm gScurbank, gicurprog, "envt4"
    chnset iParm, "envt4"
    iParm  getjuparm gScurbank, gicurprog, "hpffreq"
    chnset iParm, "hpffreq"
    iParm  getjuparm gScurbank, gicurprog, "dcorng"
    chnset iParm, "dcorng"
    iParm  getjuparm gScurbank, gicurprog, "sublevl"
    chnset iParm, "sublevl"
    iParm  getjuparm gScurbank, gicurprog, "noislvl"
    chnset iParm, "noislvl"
    iParm  getjuparm gScurbank, gicurprog, "crsrate"
    chnset iParm, "crsrate"
    
    gicurletter  = 0
    event_i "i",1007, 0, 0
    
end2:    
endin 

// ----------------------------------------------------------------------------------------------------------------
// Copy the current tone into the buffer
// ----------------------------------------------------------------------------------------------------------------
instr 1005 // Copy the current tone in the buffer
    ; we're in copy mode 
     //printf_i "copy mode cart:%s, proc:%d\n", 1, gScurbank, gicurprog
     iParm  setjuparm gScurbank, gicurprog, "vcalevl", 10

    iParm  chnget "lforate"  
    iParm2  setjuparm gScurbank, gicurprog, "lforate", iParm
    iParm  chnget "lfodely"  
    //printf_i "lfodely : %d\n",1, iParm
    iParm2  setjuparm gScurbank, gicurprog, "lfodely", iParm
    iParm  chnget "pulse"
    iParm2  setjuparm gScurbank, gicurprog, "pulse", iParm
    iParm  chnget "sawtooth"
    iParm2  setjuparm gScurbank, gicurprog, "sawtooth", iParm
    iParm chnget "sub"
    iParm2  setjuparm gScurbank, gicurprog, "sub", iParm
    iParm chnget "sublevl" 
    iParm2  setjuparm gScurbank, gicurprog, "sublevl", iParm
    iParm chnget "pwpwm"
    iParm2  setjuparm gScurbank, gicurprog, "pwpwm", iParm
    iParm chnget "noislvl"
    iParm2  setjuparm gScurbank, gicurprog, "noislvl", iParm
    iParm chnget "pwmrate"
    iParm2  setjuparm gScurbank, gicurprog, "pwmrate", iParm
    iParm chnget "dcorng"
    iParm2  setjuparm gScurbank, gicurprog, "dcorng", iParm
    iParm chnget "dcolfo"
    iParm2  setjuparm gScurbank, gicurprog, "dcolfo", iParm
    iParm chnget "dcobnd"
    iParm2  setjuparm gScurbank, gicurprog, "dcobnd", iParm
    iParm chnget "dcoenvd"
    iParm2  setjuparm gScurbank, gicurprog, "dcoenvd", iParm
    iParm chnget "dcoenv"    
    iParm = 3 - iParm // slide upside down
    iParm2  setjuparm gScurbank, gicurprog, "dcoenv", iParm
    iParm chnget "hpffreq" 
    iParm2  setjuparm gScurbank, gicurprog, "hpffreq", iParm
    iParm chnget "vcffreq" 
    iParm2  setjuparm gScurbank, gicurprog, "vcffreq", iParm
    iParm chnget "vcfreso" 
    iParm2  setjuparm gScurbank, gicurprog, "vcfreso", iParm
    iParm chnget "vcfenvd" 
    iParm2  setjuparm gScurbank, gicurprog, "vcfenvd", iParm
    iParm chnget "vcfenv" 
    iParm  = 3 - iParm // slide upside down
    iParm2  setjuparm gScurbank, gicurprog, "vcfenv", iParm
    iParm chnget "vcfkybd"
    iParm2  setjuparm gScurbank, gicurprog, "vcfkybd", iParm
    iParm chnget "vcflfo" 
    iParm2  setjuparm gScurbank, gicurprog, "vcflfo", iParm
/*    iParm chnget "vcaenvd" 
    iParm2  setjuparm gScurbank, gicurprog, "vcaenvd", iParm*/
    iParm chnget "vcaenv" 
    iParm  = 3 - iParm // slide upside down
    iParm2  setjuparm gScurbank, gicurprog, "vcaenv", iParm
    iParm chnget "envt1"
    iParm2  setjuparm gScurbank, gicurprog, "envt1", iParm
    iParm chnget "envt2"
    iParm2  setjuparm gScurbank, gicurprog, "envt2", iParm
    iParm chnget "envt3"
    iParm2  setjuparm gScurbank, gicurprog, "envt3", iParm
    iParm chnget "envt4"
    iParm2  setjuparm gScurbank, gicurprog, "envt4", iParm
    iParm chnget "envl1"
    iParm2  setjuparm gScurbank, gicurprog, "envl1", iParm
    iParm chnget "envl2"
    iParm2  setjuparm gScurbank, gicurprog, "envl2", iParm
    iParm chnget "envl3"
    iParm2  setjuparm gScurbank, gicurprog, "envl3", iParm
    iParm chnget "chorus"
    iParm2  setjuparm gScurbank, gicurprog, "chorus", iParm
    iParm chnget "crsrate"
    iParm2  setjuparm gScurbank, gicurprog, "crsrate", iParm
    iParm chnget "vcalevl"
    iParm2  setjuparm gScurbank, gicurprog, "vcalevl", iParm
    
    Stmp strsub gSName, 6
    gSbufname strcpy Stmp
         
    gkCopy = 0

endin 

// ----------------------------------------------------------------------------------------------------------------
// Paste the buffer into the current tone 
// ----------------------------------------------------------------------------------------------------------------
instr 1006   // Paste the buffer in the current tone 
    if ((strcmp(gScurbank,gSBankPreset) != 0) && (strcmp(gScurbank,gSBankMemory) != 0)) then        
        
          ; this is the cartridge, let's go ! 
        //printf_i "paste mode cart:%s, proc:%d\n", 1, gScurbank, gicurprog
        Stmp strsub gSName, 6
        //printf_i "call jupaste bank:'%s', prog:%d, name:'%s'\n", 1, gScurbank, gicurprog, gSbufname
        
        iTmp jupaste gScurbank, gicurprog, gSbufname
        //printf_i "return %d\n", 1, iTmp
        gkCopy = 1
        event_i "i", 1002, 0, 0

        
    endif
endin

instr 1007   // Change name of the current tone (into the buffer) 
 // bounds(3, 37, 20, 5)  underline
// gicurletter = 0  // current edited letter
 
  
    iTmp chnget "left"
    if ((iTmp == 1) && (gicurletter > 0))  then 
        gicurletter = gicurletter - 1
    endif 
    iTmp chnget "right"
    if ((iTmp == 1) && (gicurletter < 11))  then 
        gicurletter = gicurletter + 1
    endif 
    

    if ((gicurletter == 0) || (gicurletter == 11)) then 
        Stmp sprintf "visible(0) bounds(%d, 37, 20, 5)",3 + 18 * (gicurletter + 5)
        chnset Stmp , "underline"
        chnset "visible(0)", "letterident"
    else
        Stmp sprintf "visible(1) bounds(%d, 37, 20, 5)",3 + 18 * (gicurletter + 5)
        chnset Stmp , "underline"
        chnset "visible(1)", "letterident"
    endif   
    
    event_i "i",1008, 0, 0,100           // change name of the current tone (into the buffer) 

endin

instr 1008 // Change name of the current tone (into the buffer)  200 => modify letter in name 

    islival chnget  "letter"
    
    Sslival strsub gScharju, islival, islival + 1
    SChar  strsub gSName, gicurletter + 5, gicurletter + 6
    // printf_i "letter from slider : %s, letter in name : %s\n",1, Sslival, SChar

    if (p4  == 100) then
        // put slider to letter
        ichr strchar gSName, gicurletter + 5

        //printf_i "p4 : %d\n",1,p4
        if (ichr == 32) then 
            icar = 1  
        else 
            icar = ichr - 45;
        endif 
        //printf_i "curletter : %d  chr:%d (%s) target : %d %d\n", 1, gicurletter, ichr, SChar, icar, gichars[icar]
        chnset gichars[icar], "letter"
    elseif ((p4 == 200) && (strcmp(Sslival,SChar) != 0)) && (gicurletter > 0) && (gicurletter < 16) then 
    
        printf_i "p4 : %d\n",1,p4
        Stmp strsub gSName, 0, gicurletter + 5
        Stmp2 strcat Stmp, Sslival 
        Stmp strsub gSName, gicurletter + 6
        if (strlen(Stmp) == 0) then 
            gSName  = Stmp2
        else 
            gSName  strcat, Stmp2, Stmp
        endif 
        printf_i "p4 : %d  => '%s' end : '%s' '%s'\n",1,p4, gSName, Stmp2, Stmp
        islival dispLCD gSName
    endif
          
endin

instr 3   // init data 

    gidcoenv[] loadarray "dat/gidcoenv.dat"

    SIdent sprintfk "text(%d Hz)", sr
    chnset SIdent, "samplerate"
endin 

  
</CsInstruments>
<CsScore>
; run everything for ever ...
i 100 0 z             
i "EFFECT" 0 z        
i "updateGUI"  0 z 
; ... extect init data !
i 3 0 0 


f0 z

</CsScore>
</CsoundSynthesizer>
