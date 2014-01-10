string = "71,AMD ATHLON 4,Pentium 3,AMD:\
77,AMD ATHLON 64,Pentium 4,AMD:\
220,AMD ATHLON 64 (TF-20),Green Planet,AMD:\
86,AMD ATHLON 64 X2,Dual Core,AMD:\
153,AMD ATHLON II X2,Dual Core,AMD:\
157,AMD ATHLON II X3,Quad Core,AMD:\
154,AMD ATHLON II X4,Quad Core,AMD:\
212,AMD ATHLON NEO,Pentium M,AMD:\
69,AMD ATHLON XP,Pentium 3,AMD:\
70,AMD ATHLON XP-M,Pentium 3,AMD:\
208,AMD C-50,Dual Core,AMD:\
224,AMD C-60,Dual Core,AMD:\
66,AMD DURON,Pre Pentium 3,AMD:\
225,AMD FUSION,Dual Core,AMD:\
68,AMD K6,Pre Pentium 3,AMD:\
91,AMD PHENOM II,Quad Core,AMD:\
155,AMD PHENOM X3,Quad Core,AMD:\
152,AMD PHENOM X4,Quad Core,AMD:\
110,AMD SEMPRON (DUAL CORE ERA),Green Planet,AMD:\
109,AMD SEMPRON (P4 ERA),Pentium 4,AMD:\
214,AMD SEMPRON (PENTIUM M ERA),Pentium M,AMD:\
78,AMD TURION 64,Pentium M,AMD:\
87,AMD TURION 64 X2,Dual Core,AMD:\
89,AMD TURION II,Dual Core,AMD:\
223,AMD TURION NEO,Dual Core,AMD:\
211,AMD V120,Green Planet,AMD:\
213,AMD V140,Green Planet,AMD:\
217,AMD VISION A10,Quad Core,AMD:\
57,AMD VISION A4,Green Planet,AMD:\
58,AMD VISION A6,Dual Core,AMD:\
59,AMD VISION A8,Quad Core,AMD:\
56,AMD VISION E SERIES,Green Planet,AMD:\
139,EXYNOS 5 DUAL,Other,Other:\
82,INTEL ATOM,Pentium M,Intel:\
97,INTEL CELERON (PENTIUM 4 ERA),Pentium 4,Intel:\
96,INTEL CELERON (PENTIUM III ERA),Pentium 3,Intel:\
98,INTEL CELERON (POST PENTIUM M),Green Planet,Intel:\
151,INTEL CELERON D,Pentium M,Intel:\
76,INTEL CELERON M,Pentium M,Intel:\
84,INTEL CORE 2 DUO,Dual Core,Intel:\
85,INTEL CORE 2 EXTREME,Quad Core,Intel:\
93,INTEL CORE 2 QUAD,Quad Core,Intel:\
92,INTEL CORE 2 SOLO,Green Planet,Intel:\
83,INTEL CORE DUO,Dual Core,Intel:\
60,INTEL CORE I3,I Series ,Intel:\
61,INTEL CORE I5,I Series ,Intel:\
62,INTEL CORE I7,I Series ,Intel:\
80,INTEL CORE SOLO,Pentium M,Intel:\
94,INTEL PENTIUM (ORIGINAL),Pre Pentium 3,Intel:\
99,INTEL PENTIUM (POST PENTIUM M),Dual Core,Intel:\
74,INTEL PENTIUM 4,Pentium 4,Intel:\
150,INTEL PENTIUM D,Pentium M,Intel:\
90,INTEL PENTIUM DUAL-CORE,Dual Core,Intel:\
64,INTEL PENTIUM II,Pre Pentium 3,Intel:\
63,INTEL PENTIUM III,Pentium 3,Intel:\
75,INTEL PENTIUM M,Pentium M,Intel:\
65,INTEL PENTIUM MMX,Pre Pentium 3,Intel:\
226,INTEL PRE-PENTIUM,Pre Pentium 3,Intel:\
158,INTEL XEON,Green Planet,Intel:\
140,POWERPC G3,Other,Other:\
141,POWERPC G4,Other,Other:\
142,POWERPC G5,Other,Other:\
72,TRANSMETA CRUSOE,Other,Other:\
73,VIA C3,Pre Pentium 3,Other:\
67,VIA C7,Pre Pentium 3,Other";
array = string.split(':');
newArray = new Array();

array.forEach(function(el){
	newArray.push(el.split(','));
});