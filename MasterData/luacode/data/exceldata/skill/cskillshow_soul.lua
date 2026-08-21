-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/skill/cskillshow_soul.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cskillshow_soul = {}
cskillshow_soul.Data = {
[21] = {id = 21, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[22] = {id = 22, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[23] = {id = 23, nameTextID = 302746, exDiscribeTextID = 302754, typeTextID = 303094, 
attr = {}
}
, 
[24] = {id = 24, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[31] = {id = 31, nameTextID = 302748, exDiscribeTextID = 302778, typeTextID = 303094, 
attr = {}
}
, 
[32] = {id = 32, nameTextID = 302747, exDiscribeTextID = 302808, typeTextID = 303094, 
attr = {}
}
, 
[33] = {id = 33, nameTextID = 302745, exDiscribeTextID = 302784, typeTextID = 303094, 
attr = {}
}
, 
[34] = {id = 34, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[41] = {id = 41, nameTextID = 302747, exDiscribeTextID = 302803, typeTextID = 303094, 
attr = {}
}
, 
[42] = {id = 42, nameTextID = 302748, exDiscribeTextID = 302773, typeTextID = 303094, 
attr = {}
}
, 
[43] = {id = 43, nameTextID = 302746, exDiscribeTextID = 302753, typeTextID = 303094, 
attr = {}
}
, 
[44] = {id = 44, nameTextID = 302745, exDiscribeTextID = 302794, typeTextID = 303094, 
attr = {}
}
, 
[51] = {id = 51, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[52] = {id = 52, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[53] = {id = 53, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[54] = {id = 54, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[61] = {id = 61, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[62] = {id = 62, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[63] = {id = 63, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[64] = {id = 64, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[71] = {id = 71, nameTextID = 302748, exDiscribeTextID = 302777, typeTextID = 303094, 
attr = {}
}
, 
[72] = {id = 72, nameTextID = 302747, exDiscribeTextID = 302807, typeTextID = 303094, 
attr = {}
}
, 
[73] = {id = 73, nameTextID = 302745, exDiscribeTextID = 302783, typeTextID = 303094, 
attr = {}
}
, 
[74] = {id = 74, nameTextID = 302746, exDiscribeTextID = 302757, typeTextID = 303094, 
attr = {}
}
, 
[81] = {id = 81, nameTextID = 302746, exDiscribeTextID = 302752, typeTextID = 303094, 
attr = {}
}
, 
[82] = {id = 82, nameTextID = 302748, exDiscribeTextID = 302769, typeTextID = 303094, 
attr = {}
}
, 
[83] = {id = 83, nameTextID = 302747, exDiscribeTextID = 302799, typeTextID = 303094, 
attr = {}
}
, 
[84] = {id = 84, nameTextID = 302745, exDiscribeTextID = 302790, typeTextID = 303094, 
attr = {}
}
, 
[91] = {id = 91, nameTextID = 302747, exDiscribeTextID = 302803, typeTextID = 303094, 
attr = {}
}
, 
[92] = {id = 92, nameTextID = 302748, exDiscribeTextID = 302773, typeTextID = 303094, 
attr = {}
}
, 
[93] = {id = 93, nameTextID = 302746, exDiscribeTextID = 302753, typeTextID = 303094, 
attr = {}
}
, 
[94] = {id = 94, nameTextID = 302745, exDiscribeTextID = 302794, typeTextID = 303094, 
attr = {}
}
, 
[101] = {id = 101, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[102] = {id = 102, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[103] = {id = 103, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[104] = {id = 104, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[111] = {id = 111, nameTextID = 302746, exDiscribeTextID = 302752, typeTextID = 303094, 
attr = {}
}
, 
[112] = {id = 112, nameTextID = 302747, exDiscribeTextID = 302799, typeTextID = 303094, 
attr = {}
}
, 
[113] = {id = 113, nameTextID = 302748, exDiscribeTextID = 302769, typeTextID = 303094, 
attr = {}
}
, 
[114] = {id = 114, nameTextID = 302745, exDiscribeTextID = 302790, typeTextID = 303094, 
attr = {}
}
, 
[121] = {id = 121, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[122] = {id = 122, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[123] = {id = 123, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[124] = {id = 124, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[131] = {id = 131, nameTextID = 302747, exDiscribeTextID = 302802, typeTextID = 303094, 
attr = {}
}
, 
[132] = {id = 132, nameTextID = 302748, exDiscribeTextID = 302772, typeTextID = 303094, 
attr = {}
}
, 
[133] = {id = 133, nameTextID = 302745, exDiscribeTextID = 302793, typeTextID = 303094, 
attr = {}
}
, 
[134] = {id = 134, nameTextID = 302746, exDiscribeTextID = 302765, typeTextID = 303094, 
attr = {}
}
, 
[141] = {id = 141, nameTextID = 302747, exDiscribeTextID = 302800, typeTextID = 303094, 
attr = {}
}
, 
[142] = {id = 142, nameTextID = 302748, exDiscribeTextID = 302770, typeTextID = 303094, 
attr = {}
}
, 
[143] = {id = 143, nameTextID = 302745, exDiscribeTextID = 302791, typeTextID = 303094, 
attr = {}
}
, 
[144] = {id = 144, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[151] = {id = 151, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[152] = {id = 152, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[153] = {id = 153, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[154] = {id = 154, nameTextID = 302746, exDiscribeTextID = 302760, typeTextID = 303094, 
attr = {}
}
, 
[161] = {id = 161, nameTextID = 302747, exDiscribeTextID = 302808, typeTextID = 303094, 
attr = {}
}
, 
[162] = {id = 162, nameTextID = 302748, exDiscribeTextID = 302778, typeTextID = 303094, 
attr = {}
}
, 
[163] = {id = 163, nameTextID = 302745, exDiscribeTextID = 302784, typeTextID = 303094, 
attr = {}
}
, 
[164] = {id = 164, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[171] = {id = 171, nameTextID = 302748, exDiscribeTextID = 302780, typeTextID = 303094, 
attr = {}
}
, 
[172] = {id = 172, nameTextID = 302747, exDiscribeTextID = 302810, typeTextID = 303094, 
attr = {}
}
, 
[173] = {id = 173, nameTextID = 302745, exDiscribeTextID = 302786, typeTextID = 303094, 
attr = {}
}
, 
[174] = {id = 174, nameTextID = 302746, exDiscribeTextID = 302761, typeTextID = 303094, 
attr = {}
}
, 
[181] = {id = 181, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[182] = {id = 182, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[183] = {id = 183, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[184] = {id = 184, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[191] = {id = 191, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[192] = {id = 192, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[193] = {id = 193, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[194] = {id = 194, nameTextID = 302746, exDiscribeTextID = 302754, typeTextID = 303094, 
attr = {}
}
, 
[201] = {id = 201, nameTextID = 302748, exDiscribeTextID = 302777, typeTextID = 303094, 
attr = {}
}
, 
[202] = {id = 202, nameTextID = 302747, exDiscribeTextID = 302807, typeTextID = 303094, 
attr = {}
}
, 
[203] = {id = 203, nameTextID = 302745, exDiscribeTextID = 302783, typeTextID = 303094, 
attr = {}
}
, 
[204] = {id = 204, nameTextID = 302746, exDiscribeTextID = 302757, typeTextID = 303094, 
attr = {}
}
, 
[211] = {id = 211, nameTextID = 302748, exDiscribeTextID = 302777, typeTextID = 303094, 
attr = {}
}
, 
[212] = {id = 212, nameTextID = 302747, exDiscribeTextID = 302807, typeTextID = 303094, 
attr = {}
}
, 
[213] = {id = 213, nameTextID = 302745, exDiscribeTextID = 302783, typeTextID = 303094, 
attr = {}
}
, 
[214] = {id = 214, nameTextID = 302746, exDiscribeTextID = 302757, typeTextID = 303094, 
attr = {}
}
, 
[221] = {id = 221, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[222] = {id = 222, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[223] = {id = 223, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[224] = {id = 224, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[231] = {id = 231, nameTextID = 302746, exDiscribeTextID = 302752, typeTextID = 303094, 
attr = {}
}
, 
[232] = {id = 232, nameTextID = 302747, exDiscribeTextID = 302799, typeTextID = 303094, 
attr = {}
}
, 
[233] = {id = 233, nameTextID = 302748, exDiscribeTextID = 302769, typeTextID = 303094, 
attr = {}
}
, 
[234] = {id = 234, nameTextID = 302745, exDiscribeTextID = 302790, typeTextID = 303094, 
attr = {}
}
, 
[241] = {id = 241, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[242] = {id = 242, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[243] = {id = 243, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[244] = {id = 244, nameTextID = 302746, exDiscribeTextID = 302754, typeTextID = 303094, 
attr = {}
}
, 
[251] = {id = 251, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[252] = {id = 252, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[253] = {id = 253, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[254] = {id = 254, nameTextID = 302746, exDiscribeTextID = 302762, typeTextID = 303094, 
attr = {}
}
, 
[261] = {id = 261, nameTextID = 302747, exDiscribeTextID = 302800, typeTextID = 303094, 
attr = {}
}
, 
[262] = {id = 262, nameTextID = 302748, exDiscribeTextID = 302770, typeTextID = 303094, 
attr = {}
}
, 
[263] = {id = 263, nameTextID = 302745, exDiscribeTextID = 302791, typeTextID = 303094, 
attr = {}
}
, 
[264] = {id = 264, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[271] = {id = 271, nameTextID = 302746, exDiscribeTextID = 302750, typeTextID = 303094, 
attr = {}
}
, 
[272] = {id = 272, nameTextID = 302747, exDiscribeTextID = 302797, typeTextID = 303094, 
attr = {}
}
, 
[273] = {id = 273, nameTextID = 302748, exDiscribeTextID = 302767, typeTextID = 303094, 
attr = {}
}
, 
[274] = {id = 274, nameTextID = 302745, exDiscribeTextID = 302788, typeTextID = 303094, 
attr = {}
}
, 
[281] = {id = 281, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[282] = {id = 282, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[283] = {id = 283, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[284] = {id = 284, nameTextID = 302746, exDiscribeTextID = 302762, typeTextID = 303094, 
attr = {}
}
, 
[291] = {id = 291, nameTextID = 302747, exDiscribeTextID = 302802, typeTextID = 303094, 
attr = {}
}
, 
[292] = {id = 292, nameTextID = 302748, exDiscribeTextID = 302772, typeTextID = 303094, 
attr = {}
}
, 
[293] = {id = 293, nameTextID = 302745, exDiscribeTextID = 302793, typeTextID = 303094, 
attr = {}
}
, 
[294] = {id = 294, nameTextID = 302746, exDiscribeTextID = 302765, typeTextID = 303094, 
attr = {}
}
, 
[301] = {id = 301, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[302] = {id = 302, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[303] = {id = 303, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[304] = {id = 304, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[321] = {id = 321, nameTextID = 302747, exDiscribeTextID = 302800, typeTextID = 303094, 
attr = {}
}
, 
[322] = {id = 322, nameTextID = 302748, exDiscribeTextID = 302770, typeTextID = 303094, 
attr = {}
}
, 
[323] = {id = 323, nameTextID = 302745, exDiscribeTextID = 302791, typeTextID = 303094, 
attr = {}
}
, 
[324] = {id = 324, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[331] = {id = 331, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[332] = {id = 332, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[333] = {id = 333, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[334] = {id = 334, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[341] = {id = 341, nameTextID = 302747, exDiscribeTextID = 302801, typeTextID = 303094, 
attr = {}
}
, 
[342] = {id = 342, nameTextID = 302748, exDiscribeTextID = 302771, typeTextID = 303094, 
attr = {}
}
, 
[343] = {id = 343, nameTextID = 302745, exDiscribeTextID = 302792, typeTextID = 303094, 
attr = {}
}
, 
[344] = {id = 344, nameTextID = 302746, exDiscribeTextID = 302764, typeTextID = 303094, 
attr = {}
}
, 
[351] = {id = 351, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[352] = {id = 352, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[353] = {id = 353, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[354] = {id = 354, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[361] = {id = 361, nameTextID = 302747, exDiscribeTextID = 302803, typeTextID = 303094, 
attr = {}
}
, 
[362] = {id = 362, nameTextID = 302748, exDiscribeTextID = 302773, typeTextID = 303094, 
attr = {}
}
, 
[363] = {id = 363, nameTextID = 302745, exDiscribeTextID = 302794, typeTextID = 303094, 
attr = {}
}
, 
[364] = {id = 364, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[381] = {id = 381, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[382] = {id = 382, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[383] = {id = 383, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[384] = {id = 384, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[391] = {id = 391, nameTextID = 302747, exDiscribeTextID = 302808, typeTextID = 303094, 
attr = {}
}
, 
[392] = {id = 392, nameTextID = 302748, exDiscribeTextID = 302778, typeTextID = 303094, 
attr = {}
}
, 
[393] = {id = 393, nameTextID = 302745, exDiscribeTextID = 302784, typeTextID = 303094, 
attr = {}
}
, 
[394] = {id = 394, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[401] = {id = 401, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[402] = {id = 402, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[403] = {id = 403, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[404] = {id = 404, nameTextID = 302746, exDiscribeTextID = 302760, typeTextID = 303094, 
attr = {}
}
, 
[411] = {id = 411, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[412] = {id = 412, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[413] = {id = 413, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[414] = {id = 414, nameTextID = 302746, exDiscribeTextID = 302762, typeTextID = 303094, 
attr = {}
}
, 
[421] = {id = 421, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[422] = {id = 422, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[423] = {id = 423, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[424] = {id = 424, nameTextID = 302746, exDiscribeTextID = 302762, typeTextID = 303094, 
attr = {}
}
, 
[431] = {id = 431, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[432] = {id = 432, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[433] = {id = 433, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[434] = {id = 434, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[441] = {id = 441, nameTextID = 302747, exDiscribeTextID = 302803, typeTextID = 303094, 
attr = {}
}
, 
[442] = {id = 442, nameTextID = 302748, exDiscribeTextID = 302773, typeTextID = 303094, 
attr = {}
}
, 
[443] = {id = 443, nameTextID = 302745, exDiscribeTextID = 302794, typeTextID = 303094, 
attr = {}
}
, 
[444] = {id = 444, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[451] = {id = 451, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[452] = {id = 452, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[453] = {id = 453, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[454] = {id = 454, nameTextID = 302746, exDiscribeTextID = 302760, typeTextID = 303094, 
attr = {}
}
, 
[461] = {id = 461, nameTextID = 302748, exDiscribeTextID = 302778, typeTextID = 303094, 
attr = {}
}
, 
[462] = {id = 462, nameTextID = 302747, exDiscribeTextID = 302808, typeTextID = 303094, 
attr = {}
}
, 
[463] = {id = 463, nameTextID = 302745, exDiscribeTextID = 302784, typeTextID = 303094, 
attr = {}
}
, 
[464] = {id = 464, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[471] = {id = 471, nameTextID = 302747, exDiscribeTextID = 302801, typeTextID = 303094, 
attr = {}
}
, 
[472] = {id = 472, nameTextID = 302748, exDiscribeTextID = 302771, typeTextID = 303094, 
attr = {}
}
, 
[473] = {id = 473, nameTextID = 302745, exDiscribeTextID = 302792, typeTextID = 303094, 
attr = {}
}
, 
[474] = {id = 474, nameTextID = 302746, exDiscribeTextID = 302764, typeTextID = 303094, 
attr = {}
}
, 
[481] = {id = 481, nameTextID = 302748, exDiscribeTextID = 302779, typeTextID = 303094, 
attr = {}
}
, 
[482] = {id = 482, nameTextID = 302747, exDiscribeTextID = 302809, typeTextID = 303094, 
attr = {}
}
, 
[483] = {id = 483, nameTextID = 302745, exDiscribeTextID = 302785, typeTextID = 303094, 
attr = {}
}
, 
[484] = {id = 484, nameTextID = 302746, exDiscribeTextID = 302759, typeTextID = 303094, 
attr = {}
}
, 
[491] = {id = 491, nameTextID = 302746, exDiscribeTextID = 302750, typeTextID = 303094, 
attr = {}
}
, 
[492] = {id = 492, nameTextID = 302748, exDiscribeTextID = 302767, typeTextID = 303094, 
attr = {}
}
, 
[493] = {id = 493, nameTextID = 302747, exDiscribeTextID = 302797, typeTextID = 303094, 
attr = {}
}
, 
[494] = {id = 494, nameTextID = 302745, exDiscribeTextID = 302788, typeTextID = 303094, 
attr = {}
}
, 
[501] = {id = 501, nameTextID = 302748, exDiscribeTextID = 302780, typeTextID = 303094, 
attr = {}
}
, 
[502] = {id = 502, nameTextID = 302747, exDiscribeTextID = 302810, typeTextID = 303094, 
attr = {}
}
, 
[503] = {id = 503, nameTextID = 302745, exDiscribeTextID = 302786, typeTextID = 303094, 
attr = {}
}
, 
[504] = {id = 504, nameTextID = 302746, exDiscribeTextID = 302761, typeTextID = 303094, 
attr = {}
}
, 
[511] = {id = 511, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[512] = {id = 512, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[513] = {id = 513, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[514] = {id = 514, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[521] = {id = 521, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[522] = {id = 522, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[523] = {id = 523, nameTextID = 302746, exDiscribeTextID = 302754, typeTextID = 303094, 
attr = {}
}
, 
[524] = {id = 524, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[531] = {id = 531, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[532] = {id = 532, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[533] = {id = 533, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[534] = {id = 534, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[541] = {id = 541, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[542] = {id = 542, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[543] = {id = 543, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[544] = {id = 544, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[551] = {id = 551, nameTextID = 302747, exDiscribeTextID = 302801, typeTextID = 303094, 
attr = {}
}
, 
[552] = {id = 552, nameTextID = 302748, exDiscribeTextID = 302771, typeTextID = 303094, 
attr = {}
}
, 
[553] = {id = 553, nameTextID = 302745, exDiscribeTextID = 302792, typeTextID = 303094, 
attr = {}
}
, 
[554] = {id = 554, nameTextID = 302746, exDiscribeTextID = 302764, typeTextID = 303094, 
attr = {}
}
, 
[561] = {id = 561, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[562] = {id = 562, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[563] = {id = 563, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[564] = {id = 564, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[571] = {id = 571, nameTextID = 302746, exDiscribeTextID = 302749, typeTextID = 303094, 
attr = {}
}
, 
[572] = {id = 572, nameTextID = 302747, exDiscribeTextID = 302796, typeTextID = 303094, 
attr = {}
}
, 
[573] = {id = 573, nameTextID = 302748, exDiscribeTextID = 302766, typeTextID = 303094, 
attr = {}
}
, 
[574] = {id = 574, nameTextID = 302745, exDiscribeTextID = 302787, typeTextID = 303094, 
attr = {}
}
, 
[581] = {id = 581, nameTextID = 302747, exDiscribeTextID = 302800, typeTextID = 303094, 
attr = {}
}
, 
[582] = {id = 582, nameTextID = 302748, exDiscribeTextID = 302770, typeTextID = 303094, 
attr = {}
}
, 
[583] = {id = 583, nameTextID = 302745, exDiscribeTextID = 302791, typeTextID = 303094, 
attr = {}
}
, 
[584] = {id = 584, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[591] = {id = 591, nameTextID = 302746, exDiscribeTextID = 302751, typeTextID = 303094, 
attr = {}
}
, 
[592] = {id = 592, nameTextID = 302747, exDiscribeTextID = 302798, typeTextID = 303094, 
attr = {}
}
, 
[593] = {id = 593, nameTextID = 302748, exDiscribeTextID = 302768, typeTextID = 303094, 
attr = {}
}
, 
[594] = {id = 594, nameTextID = 302745, exDiscribeTextID = 302789, typeTextID = 303094, 
attr = {}
}
, 
[601] = {id = 601, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[602] = {id = 602, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[603] = {id = 603, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[604] = {id = 604, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[611] = {id = 611, nameTextID = 302748, exDiscribeTextID = 302779, typeTextID = 303094, 
attr = {}
}
, 
[612] = {id = 612, nameTextID = 302747, exDiscribeTextID = 302809, typeTextID = 303094, 
attr = {}
}
, 
[613] = {id = 613, nameTextID = 302745, exDiscribeTextID = 302785, typeTextID = 303094, 
attr = {}
}
, 
[614] = {id = 614, nameTextID = 302746, exDiscribeTextID = 302759, typeTextID = 303094, 
attr = {}
}
, 
[621] = {id = 621, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[622] = {id = 622, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[623] = {id = 623, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[624] = {id = 624, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[631] = {id = 631, nameTextID = 302746, exDiscribeTextID = 302752, typeTextID = 303094, 
attr = {}
}
, 
[632] = {id = 632, nameTextID = 302748, exDiscribeTextID = 302769, typeTextID = 303094, 
attr = {}
}
, 
[633] = {id = 633, nameTextID = 302747, exDiscribeTextID = 302799, typeTextID = 303094, 
attr = {}
}
, 
[634] = {id = 634, nameTextID = 302745, exDiscribeTextID = 302790, typeTextID = 303094, 
attr = {}
}
, 
[641] = {id = 641, nameTextID = 302747, exDiscribeTextID = 302800, typeTextID = 303094, 
attr = {}
}
, 
[642] = {id = 642, nameTextID = 302748, exDiscribeTextID = 302770, typeTextID = 303094, 
attr = {}
}
, 
[643] = {id = 643, nameTextID = 302745, exDiscribeTextID = 302791, typeTextID = 303094, 
attr = {}
}
, 
[644] = {id = 644, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[651] = {id = 651, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[652] = {id = 652, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[653] = {id = 653, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[654] = {id = 654, nameTextID = 302746, exDiscribeTextID = 302755, typeTextID = 303094, 
attr = {}
}
, 
[661] = {id = 661, nameTextID = 302746, exDiscribeTextID = 302750, typeTextID = 303094, 
attr = {}
}
, 
[662] = {id = 662, nameTextID = 302748, exDiscribeTextID = 302767, typeTextID = 303094, 
attr = {}
}
, 
[663] = {id = 663, nameTextID = 302747, exDiscribeTextID = 302797, typeTextID = 303094, 
attr = {}
}
, 
[664] = {id = 664, nameTextID = 302745, exDiscribeTextID = 302788, typeTextID = 303094, 
attr = {}
}
, 
[671] = {id = 671, nameTextID = 302748, exDiscribeTextID = 302778, typeTextID = 303094, 
attr = {}
}
, 
[672] = {id = 672, nameTextID = 302747, exDiscribeTextID = 302808, typeTextID = 303094, 
attr = {}
}
, 
[673] = {id = 673, nameTextID = 302745, exDiscribeTextID = 302784, typeTextID = 303094, 
attr = {}
}
, 
[674] = {id = 674, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[681] = {id = 681, nameTextID = 302748, exDiscribeTextID = 302773, typeTextID = 303094, 
attr = {}
}
, 
[682] = {id = 682, nameTextID = 302745, exDiscribeTextID = 302794, typeTextID = 303094, 
attr = {}
}
, 
[683] = {id = 683, nameTextID = 302747, exDiscribeTextID = 302803, typeTextID = 303094, 
attr = {}
}
, 
[684] = {id = 684, nameTextID = 302746, exDiscribeTextID = 302753, typeTextID = 303094, 
attr = {}
}
, 
[691] = {id = 691, nameTextID = 302747, exDiscribeTextID = 302805, typeTextID = 303094, 
attr = {}
}
, 
[692] = {id = 692, nameTextID = 302748, exDiscribeTextID = 302775, typeTextID = 303094, 
attr = {}
}
, 
[693] = {id = 693, nameTextID = 302745, exDiscribeTextID = 302781, typeTextID = 303094, 
attr = {}
}
, 
[694] = {id = 694, nameTextID = 302746, exDiscribeTextID = 302762, typeTextID = 303094, 
attr = {}
}
, 
[701] = {id = 701, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[702] = {id = 702, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[703] = {id = 703, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[704] = {id = 704, nameTextID = 302746, exDiscribeTextID = 302763, typeTextID = 303094, 
attr = {}
}
, 
[711] = {id = 711, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[712] = {id = 712, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[713] = {id = 713, nameTextID = 302746, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[714] = {id = 714, nameTextID = 302745, exDiscribeTextID = 302754, typeTextID = 303094, 
attr = {}
}
, 
[721] = {id = 721, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[722] = {id = 722, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[723] = {id = 723, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[724] = {id = 724, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[731] = {id = 731, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[732] = {id = 732, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[733] = {id = 733, nameTextID = 302746, exDiscribeTextID = 302754, typeTextID = 303094, 
attr = {}
}
, 
[734] = {id = 734, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[741] = {id = 741, nameTextID = 302748, exDiscribeTextID = 302778, typeTextID = 303094, 
attr = {}
}
, 
[742] = {id = 742, nameTextID = 302747, exDiscribeTextID = 302808, typeTextID = 303094, 
attr = {}
}
, 
[743] = {id = 743, nameTextID = 302745, exDiscribeTextID = 302784, typeTextID = 303094, 
attr = {}
}
, 
[744] = {id = 744, nameTextID = 302746, exDiscribeTextID = 302758, typeTextID = 303094, 
attr = {}
}
, 
[751] = {id = 751, nameTextID = 302748, exDiscribeTextID = 302777, typeTextID = 303094, 
attr = {}
}
, 
[752] = {id = 752, nameTextID = 302747, exDiscribeTextID = 302807, typeTextID = 303094, 
attr = {}
}
, 
[753] = {id = 753, nameTextID = 302745, exDiscribeTextID = 302783, typeTextID = 303094, 
attr = {}
}
, 
[754] = {id = 754, nameTextID = 302746, exDiscribeTextID = 302757, typeTextID = 303094, 
attr = {}
}
, 
[761] = {id = 761, nameTextID = 302747, exDiscribeTextID = 302804, typeTextID = 303094, 
attr = {}
}
, 
[762] = {id = 762, nameTextID = 302748, exDiscribeTextID = 302774, typeTextID = 303094, 
attr = {}
}
, 
[763] = {id = 763, nameTextID = 302746, exDiscribeTextID = 302754, typeTextID = 303094, 
attr = {}
}
, 
[764] = {id = 764, nameTextID = 302745, exDiscribeTextID = 302795, typeTextID = 303094, 
attr = {}
}
, 
[1021] = {id = 1021, nameTextID = 302747, exDiscribeTextID = 302806, typeTextID = 303094, 
attr = {}
}
, 
[1022] = {id = 1022, nameTextID = 302748, exDiscribeTextID = 302776, typeTextID = 303094, 
attr = {}
}
, 
[1023] = {id = 1023, nameTextID = 302746, exDiscribeTextID = 302756, typeTextID = 303094, 
attr = {}
}
, 
[1024] = {id = 1024, nameTextID = 302745, exDiscribeTextID = 302782, typeTextID = 303094, 
attr = {}
}
, 
[300601] = {id = 300601, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"5.5"}
}
, 
[300602] = {id = 300602, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"6"}
}
, 
[300603] = {id = 300603, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"6.5"}
}
, 
[300604] = {id = 300604, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"7"}
}
, 
[300605] = {id = 300605, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"7.5"}
}
, 
[300606] = {id = 300606, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"8"}
}
, 
[300607] = {id = 300607, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"8.5"}
}
, 
[300608] = {id = 300608, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"9"}
}
, 
[300609] = {id = 300609, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"9.5"}
}
, 
[300610] = {id = 300610, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"10"}
}
, 
[300801] = {id = 300801, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"11"}
}
, 
[300802] = {id = 300802, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"12"}
}
, 
[300803] = {id = 300803, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"13"}
}
, 
[300804] = {id = 300804, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"14"}
}
, 
[300805] = {id = 300805, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"15"}
}
, 
[300806] = {id = 300806, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"16"}
}
, 
[300807] = {id = 300807, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"17"}
}
, 
[300808] = {id = 300808, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"18"}
}
, 
[300809] = {id = 300809, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"19"}
}
, 
[300810] = {id = 300810, nameTextID = -1, exDiscribeTextID = 303255, typeTextID = -1, 
attr = {"20"}
}
, 
[301001] = {id = 301001, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"2.75"}
}
, 
[301002] = {id = 301002, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"3"}
}
, 
[301003] = {id = 301003, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"3.25"}
}
, 
[301004] = {id = 301004, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"3.5"}
}
, 
[301005] = {id = 301005, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"3.75"}
}
, 
[301006] = {id = 301006, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"4"}
}
, 
[301007] = {id = 301007, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"4.25"}
}
, 
[301008] = {id = 301008, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"4.5"}
}
, 
[301009] = {id = 301009, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"4.75"}
}
, 
[301010] = {id = 301010, nameTextID = -1, exDiscribeTextID = 303256, typeTextID = -1, 
attr = {"5"}
}
, 
[301101] = {id = 301101, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"11"}
}
, 
[301102] = {id = 301102, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"12"}
}
, 
[301103] = {id = 301103, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"13"}
}
, 
[301104] = {id = 301104, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"14"}
}
, 
[301105] = {id = 301105, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"15"}
}
, 
[301106] = {id = 301106, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"16"}
}
, 
[301107] = {id = 301107, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"17"}
}
, 
[301108] = {id = 301108, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"18"}
}
, 
[301109] = {id = 301109, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"19"}
}
, 
[301110] = {id = 301110, nameTextID = -1, exDiscribeTextID = 303359, typeTextID = -1, 
attr = {"20"}
}
, 
[301201] = {id = 301201, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"5.5", "5.5"}
}
, 
[301202] = {id = 301202, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"6", "6"}
}
, 
[301203] = {id = 301203, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"6.5", "6.5"}
}
, 
[301204] = {id = 301204, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"7", "7"}
}
, 
[301205] = {id = 301205, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"7.5", "7.5"}
}
, 
[301206] = {id = 301206, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"8", "8"}
}
, 
[301207] = {id = 301207, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"8.5", "8.5"}
}
, 
[301208] = {id = 301208, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"9", "9"}
}
, 
[301209] = {id = 301209, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"9.5", "9.5"}
}
, 
[301210] = {id = 301210, nameTextID = -1, exDiscribeTextID = 303672, typeTextID = -1, 
attr = {"10", "10"}
}
, 
[301301] = {id = 301301, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"2.75", "110"}
}
, 
[301302] = {id = 301302, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"3", "120"}
}
, 
[301303] = {id = 301303, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"3.25", "130"}
}
, 
[301304] = {id = 301304, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"3.5", "140"}
}
, 
[301305] = {id = 301305, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"3.75", "150"}
}
, 
[301306] = {id = 301306, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"4", "160"}
}
, 
[301307] = {id = 301307, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"4.25", "170"}
}
, 
[301308] = {id = 301308, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"4.5", "180"}
}
, 
[301309] = {id = 301309, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"4.75", "190"}
}
, 
[301310] = {id = 301310, nameTextID = -1, exDiscribeTextID = 303257, typeTextID = -1, 
attr = {"5", "200"}
}
, 
[301701] = {id = 301701, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"11"}
}
, 
[301702] = {id = 301702, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"12"}
}
, 
[301703] = {id = 301703, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"13"}
}
, 
[301704] = {id = 301704, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"14"}
}
, 
[301705] = {id = 301705, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"15"}
}
, 
[301706] = {id = 301706, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"16"}
}
, 
[301707] = {id = 301707, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"17"}
}
, 
[301708] = {id = 301708, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"18"}
}
, 
[301709] = {id = 301709, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"19"}
}
, 
[301710] = {id = 301710, nameTextID = -1, exDiscribeTextID = 303358, typeTextID = -1, 
attr = {"20"}
}
, 
[302301] = {id = 302301, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.1"}
}
, 
[302302] = {id = 302302, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.2"}
}
, 
[302303] = {id = 302303, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.3"}
}
, 
[302304] = {id = 302304, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.4"}
}
, 
[302305] = {id = 302305, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.5"}
}
, 
[302306] = {id = 302306, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.6"}
}
, 
[302307] = {id = 302307, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.7"}
}
, 
[302308] = {id = 302308, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.8"}
}
, 
[302309] = {id = 302309, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"1.9"}
}
, 
[302310] = {id = 302310, nameTextID = -1, exDiscribeTextID = 303430, typeTextID = -1, 
attr = {"2"}
}
, 
[302501] = {id = 302501, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"22"}
}
, 
[302502] = {id = 302502, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"24"}
}
, 
[302503] = {id = 302503, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"26"}
}
, 
[302504] = {id = 302504, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"28"}
}
, 
[302505] = {id = 302505, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"30"}
}
, 
[302506] = {id = 302506, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"32"}
}
, 
[302507] = {id = 302507, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"34"}
}
, 
[302508] = {id = 302508, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"36"}
}
, 
[302509] = {id = 302509, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"38"}
}
, 
[302510] = {id = 302510, nameTextID = -1, exDiscribeTextID = 303432, typeTextID = -1, 
attr = {"40"}
}
, 
[302901] = {id = 302901, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"22"}
}
, 
[302902] = {id = 302902, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"24"}
}
, 
[302903] = {id = 302903, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"26"}
}
, 
[302904] = {id = 302904, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"28"}
}
, 
[302905] = {id = 302905, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"30"}
}
, 
[302906] = {id = 302906, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"32"}
}
, 
[302907] = {id = 302907, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"34"}
}
, 
[302908] = {id = 302908, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"36"}
}
, 
[302909] = {id = 302909, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"38"}
}
, 
[302910] = {id = 302910, nameTextID = -1, exDiscribeTextID = 303261, typeTextID = -1, 
attr = {"40"}
}
, 
[303001] = {id = 303001, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"11"}
}
, 
[303002] = {id = 303002, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"12"}
}
, 
[303003] = {id = 303003, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"13"}
}
, 
[303004] = {id = 303004, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"14"}
}
, 
[303005] = {id = 303005, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"15"}
}
, 
[303006] = {id = 303006, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"16"}
}
, 
[303007] = {id = 303007, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"17"}
}
, 
[303008] = {id = 303008, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"18"}
}
, 
[303009] = {id = 303009, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"19"}
}
, 
[303010] = {id = 303010, nameTextID = -1, exDiscribeTextID = 303362, typeTextID = -1, 
attr = {"20"}
}
, 
[303301] = {id = 303301, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"21"}
}
, 
[303302] = {id = 303302, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"22"}
}
, 
[303303] = {id = 303303, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"23"}
}
, 
[303304] = {id = 303304, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"24"}
}
, 
[303305] = {id = 303305, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"25"}
}
, 
[303306] = {id = 303306, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"26"}
}
, 
[303307] = {id = 303307, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"27"}
}
, 
[303308] = {id = 303308, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"28"}
}
, 
[303309] = {id = 303309, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"29"}
}
, 
[303310] = {id = 303310, nameTextID = -1, exDiscribeTextID = 303360, typeTextID = -1, 
attr = {"30"}
}
, 
[303401] = {id = 303401, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.1"}
}
, 
[303402] = {id = 303402, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.2"}
}
, 
[303403] = {id = 303403, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.3"}
}
, 
[303404] = {id = 303404, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.4"}
}
, 
[303405] = {id = 303405, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.5"}
}
, 
[303406] = {id = 303406, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.6"}
}
, 
[303407] = {id = 303407, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.7"}
}
, 
[303408] = {id = 303408, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.8"}
}
, 
[303409] = {id = 303409, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"1.9"}
}
, 
[303410] = {id = 303410, nameTextID = -1, exDiscribeTextID = 303332, typeTextID = -1, 
attr = {"2"}
}
, 
[303501] = {id = 303501, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"11"}
}
, 
[303502] = {id = 303502, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"12"}
}
, 
[303503] = {id = 303503, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"13"}
}
, 
[303504] = {id = 303504, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"14"}
}
, 
[303505] = {id = 303505, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"15"}
}
, 
[303506] = {id = 303506, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"16"}
}
, 
[303507] = {id = 303507, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"17"}
}
, 
[303508] = {id = 303508, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"18"}
}
, 
[303509] = {id = 303509, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"19"}
}
, 
[303510] = {id = 303510, nameTextID = -1, exDiscribeTextID = 303689, typeTextID = -1, 
attr = {"20"}
}
, 
[303801] = {id = 303801, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"11"}
}
, 
[303802] = {id = 303802, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"12"}
}
, 
[303803] = {id = 303803, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"13"}
}
, 
[303804] = {id = 303804, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"14"}
}
, 
[303805] = {id = 303805, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"15"}
}
, 
[303806] = {id = 303806, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"16"}
}
, 
[303807] = {id = 303807, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"17"}
}
, 
[303808] = {id = 303808, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"18"}
}
, 
[303809] = {id = 303809, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"19"}
}
, 
[303810] = {id = 303810, nameTextID = -1, exDiscribeTextID = 303391, typeTextID = -1, 
attr = {"20"}
}
, 
[303901] = {id = 303901, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"22"}
}
, 
[303902] = {id = 303902, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"24"}
}
, 
[303903] = {id = 303903, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"26"}
}
, 
[303904] = {id = 303904, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"28"}
}
, 
[303905] = {id = 303905, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"30"}
}
, 
[303906] = {id = 303906, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"32"}
}
, 
[303907] = {id = 303907, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"34"}
}
, 
[303908] = {id = 303908, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"36"}
}
, 
[303909] = {id = 303909, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"38"}
}
, 
[303910] = {id = 303910, nameTextID = -1, exDiscribeTextID = 303469, typeTextID = -1, 
attr = {"40"}
}
, 
[304101] = {id = 304101, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"2.75"}
}
, 
[304102] = {id = 304102, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"3"}
}
, 
[304103] = {id = 304103, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"3.25"}
}
, 
[304104] = {id = 304104, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"3.5"}
}
, 
[304105] = {id = 304105, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"3.75"}
}
, 
[304106] = {id = 304106, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"4"}
}
, 
[304107] = {id = 304107, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"4.25"}
}
, 
[304108] = {id = 304108, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"4.5"}
}
, 
[304109] = {id = 304109, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"4.75"}
}
, 
[304110] = {id = 304110, nameTextID = -1, exDiscribeTextID = 303258, typeTextID = -1, 
attr = {"5"}
}
, 
[304201] = {id = 304201, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"22"}
}
, 
[304202] = {id = 304202, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"24"}
}
, 
[304203] = {id = 304203, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"26"}
}
, 
[304204] = {id = 304204, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"28"}
}
, 
[304205] = {id = 304205, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"30"}
}
, 
[304206] = {id = 304206, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"32"}
}
, 
[304207] = {id = 304207, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"34"}
}
, 
[304208] = {id = 304208, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"36"}
}
, 
[304209] = {id = 304209, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"38"}
}
, 
[304210] = {id = 304210, nameTextID = -1, exDiscribeTextID = 303393, typeTextID = -1, 
attr = {"40"}
}
, 
[304301] = {id = 304301, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"5.5"}
}
, 
[304302] = {id = 304302, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"6"}
}
, 
[304303] = {id = 304303, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"6.5"}
}
, 
[304304] = {id = 304304, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"7"}
}
, 
[304305] = {id = 304305, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"7.5"}
}
, 
[304306] = {id = 304306, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"8"}
}
, 
[304307] = {id = 304307, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"8.5"}
}
, 
[304308] = {id = 304308, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"9"}
}
, 
[304309] = {id = 304309, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"9.5"}
}
, 
[304310] = {id = 304310, nameTextID = -1, exDiscribeTextID = 303333, typeTextID = -1, 
attr = {"10"}
}
, 
[304701] = {id = 304701, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"1.65"}
}
, 
[304702] = {id = 304702, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"1.8"}
}
, 
[304703] = {id = 304703, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"1.95"}
}
, 
[304704] = {id = 304704, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"2.1"}
}
, 
[304705] = {id = 304705, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"2.25"}
}
, 
[304706] = {id = 304706, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"2.4"}
}
, 
[304707] = {id = 304707, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"2.55"}
}
, 
[304708] = {id = 304708, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"2.7"}
}
, 
[304709] = {id = 304709, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"2.85"}
}
, 
[304710] = {id = 304710, nameTextID = -1, exDiscribeTextID = 303395, typeTextID = -1, 
attr = {"3"}
}
, 
[304801] = {id = 304801, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"38.5"}
}
, 
[304802] = {id = 304802, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"42"}
}
, 
[304803] = {id = 304803, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"45.5"}
}
, 
[304804] = {id = 304804, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"49"}
}
, 
[304805] = {id = 304805, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"52.5"}
}
, 
[304806] = {id = 304806, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"56"}
}
, 
[304807] = {id = 304807, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"59.5"}
}
, 
[304808] = {id = 304808, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"63"}
}
, 
[304809] = {id = 304809, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"66.5"}
}
, 
[304810] = {id = 304810, nameTextID = -1, exDiscribeTextID = 303259, typeTextID = -1, 
attr = {"70"}
}
, 
[305101] = {id = 305101, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"11"}
}
, 
[305102] = {id = 305102, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"12"}
}
, 
[305103] = {id = 305103, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"13"}
}
, 
[305104] = {id = 305104, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"14"}
}
, 
[305105] = {id = 305105, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"15"}
}
, 
[305106] = {id = 305106, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"16"}
}
, 
[305107] = {id = 305107, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"17"}
}
, 
[305108] = {id = 305108, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"18"}
}
, 
[305109] = {id = 305109, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"19"}
}
, 
[305110] = {id = 305110, nameTextID = -1, exDiscribeTextID = 303762, typeTextID = -1, 
attr = {"20"}
}
, 
[305301] = {id = 305301, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"22"}
}
, 
[305302] = {id = 305302, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"24"}
}
, 
[305303] = {id = 305303, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"26"}
}
, 
[305304] = {id = 305304, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"28"}
}
, 
[305305] = {id = 305305, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"30"}
}
, 
[305306] = {id = 305306, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"32"}
}
, 
[305307] = {id = 305307, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"34"}
}
, 
[305308] = {id = 305308, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"36"}
}
, 
[305309] = {id = 305309, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"38"}
}
, 
[305310] = {id = 305310, nameTextID = -1, exDiscribeTextID = 303485, typeTextID = -1, 
attr = {"40"}
}
, 
[305501] = {id = 305501, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"21"}
}
, 
[305502] = {id = 305502, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"22"}
}
, 
[305503] = {id = 305503, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"23"}
}
, 
[305504] = {id = 305504, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"24"}
}
, 
[305505] = {id = 305505, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"25"}
}
, 
[305506] = {id = 305506, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"26"}
}
, 
[305507] = {id = 305507, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"27"}
}
, 
[305508] = {id = 305508, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"28"}
}
, 
[305509] = {id = 305509, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"29"}
}
, 
[305510] = {id = 305510, nameTextID = -1, exDiscribeTextID = 303434, typeTextID = -1, 
attr = {"30"}
}
, 
[305601] = {id = 305601, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.1"}
}
, 
[305602] = {id = 305602, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.2"}
}
, 
[305603] = {id = 305603, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.3"}
}
, 
[305604] = {id = 305604, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.4"}
}
, 
[305605] = {id = 305605, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.5"}
}
, 
[305606] = {id = 305606, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.6"}
}
, 
[305607] = {id = 305607, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.7"}
}
, 
[305608] = {id = 305608, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.8"}
}
, 
[305609] = {id = 305609, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"1.9"}
}
, 
[305610] = {id = 305610, nameTextID = -1, exDiscribeTextID = 303330, typeTextID = -1, 
attr = {"2"}
}
, 
[305901] = {id = 305901, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"11"}
}
, 
[305902] = {id = 305902, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"12"}
}
, 
[305903] = {id = 305903, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"13"}
}
, 
[305904] = {id = 305904, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"14"}
}
, 
[305905] = {id = 305905, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"15"}
}
, 
[305906] = {id = 305906, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"16"}
}
, 
[305907] = {id = 305907, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"17"}
}
, 
[305908] = {id = 305908, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"18"}
}
, 
[305909] = {id = 305909, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"19"}
}
, 
[305910] = {id = 305910, nameTextID = -1, exDiscribeTextID = 303361, typeTextID = -1, 
attr = {"20"}
}
, 
[306301] = {id = 306301, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"55"}
}
, 
[306302] = {id = 306302, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"60"}
}
, 
[306303] = {id = 306303, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"65"}
}
, 
[306304] = {id = 306304, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"70"}
}
, 
[306305] = {id = 306305, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"75"}
}
, 
[306306] = {id = 306306, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"80"}
}
, 
[306307] = {id = 306307, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"85"}
}
, 
[306308] = {id = 306308, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"90"}
}
, 
[306309] = {id = 306309, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"95"}
}
, 
[306310] = {id = 306310, nameTextID = -1, exDiscribeTextID = 303392, typeTextID = -1, 
attr = {"100"}
}
, 
[306401] = {id = 306401, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"5.5"}
}
, 
[306402] = {id = 306402, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"6"}
}
, 
[306403] = {id = 306403, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"6.5"}
}
, 
[306404] = {id = 306404, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"7"}
}
, 
[306405] = {id = 306405, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"7.5"}
}
, 
[306406] = {id = 306406, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"8"}
}
, 
[306407] = {id = 306407, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"8.5"}
}
, 
[306408] = {id = 306408, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"9"}
}
, 
[306409] = {id = 306409, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = -1, 
attr = {"9.5"}
}
, 
[306410] = {id = 306410, nameTextID = -1, exDiscribeTextID = 303462, typeTextID = 303094, 
attr = {"10"}
}
, 
[306501] = {id = 306501, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"6"}
}
, 
[306502] = {id = 306502, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"7"}
}
, 
[306503] = {id = 306503, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"8"}
}
, 
[306504] = {id = 306504, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"9"}
}
, 
[306505] = {id = 306505, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"10"}
}
, 
[306506] = {id = 306506, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"11"}
}
, 
[306507] = {id = 306507, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"12"}
}
, 
[306508] = {id = 306508, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"13"}
}
, 
[306509] = {id = 306509, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"14"}
}
, 
[306510] = {id = 306510, nameTextID = -1, exDiscribeTextID = 303433, typeTextID = -1, 
attr = {"15"}
}
, 
[306601] = {id = 306601, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"27.5"}
}
, 
[306602] = {id = 306602, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"30"}
}
, 
[306603] = {id = 306603, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"32.5"}
}
, 
[306604] = {id = 306604, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"35"}
}
, 
[306605] = {id = 306605, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"37.5"}
}
, 
[306606] = {id = 306606, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"40"}
}
, 
[306607] = {id = 306607, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"42.5"}
}
, 
[306608] = {id = 306608, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"45"}
}
, 
[306609] = {id = 306609, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"47.5"}
}
, 
[306610] = {id = 306610, nameTextID = -1, exDiscribeTextID = 303579, typeTextID = -1, 
attr = {"50"}
}
, 
[306901] = {id = 306901, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"11"}
}
, 
[306902] = {id = 306902, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"12"}
}
, 
[306903] = {id = 306903, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"13"}
}
, 
[306904] = {id = 306904, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"14"}
}
, 
[306905] = {id = 306905, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"15"}
}
, 
[306906] = {id = 306906, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"16"}
}
, 
[306907] = {id = 306907, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"17"}
}
, 
[306908] = {id = 306908, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"18"}
}
, 
[306909] = {id = 306909, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"19"}
}
, 
[306910] = {id = 306910, nameTextID = -1, exDiscribeTextID = 303394, typeTextID = -1, 
attr = {"20"}
}
, 
[307001] = {id = 307001, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"11"}
}
, 
[307002] = {id = 307002, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"12"}
}
, 
[307003] = {id = 307003, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"13"}
}
, 
[307004] = {id = 307004, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"14"}
}
, 
[307005] = {id = 307005, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"15"}
}
, 
[307006] = {id = 307006, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"16"}
}
, 
[307007] = {id = 307007, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"17"}
}
, 
[307008] = {id = 307008, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"18"}
}
, 
[307009] = {id = 307009, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"19"}
}
, 
[307010] = {id = 307010, nameTextID = -1, exDiscribeTextID = 303331, typeTextID = -1, 
attr = {"20"}
}
, 
[307101] = {id = 307101, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"11", "550"}
}
, 
[307102] = {id = 307102, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"12", "600"}
}
, 
[307103] = {id = 307103, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"13", "650"}
}
, 
[307104] = {id = 307104, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"14", "700"}
}
, 
[307105] = {id = 307105, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"15", "750"}
}
, 
[307106] = {id = 307106, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"16", "800"}
}
, 
[307107] = {id = 307107, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"17", "850"}
}
, 
[307108] = {id = 307108, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"18", "900"}
}
, 
[307109] = {id = 307109, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"19", "950"}
}
, 
[307110] = {id = 307110, nameTextID = -1, exDiscribeTextID = 303544, typeTextID = -1, 
attr = {"20", "1000"}
}
, 
[307201] = {id = 307201, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"22"}
}
, 
[307202] = {id = 307202, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"24"}
}
, 
[307203] = {id = 307203, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"26"}
}
, 
[307204] = {id = 307204, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"28"}
}
, 
[307205] = {id = 307205, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"30"}
}
, 
[307206] = {id = 307206, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"32"}
}
, 
[307207] = {id = 307207, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"34"}
}
, 
[307208] = {id = 307208, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"36"}
}
, 
[307209] = {id = 307209, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"38"}
}
, 
[307210] = {id = 307210, nameTextID = -1, exDiscribeTextID = 303431, typeTextID = -1, 
attr = {"40"}
}
, 
[307901] = {id = 307901, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"5.5"}
}
, 
[307902] = {id = 307902, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"6"}
}
, 
[307903] = {id = 307903, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"6.5"}
}
, 
[307904] = {id = 307904, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"7"}
}
, 
[307905] = {id = 307905, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"7.5"}
}
, 
[307906] = {id = 307906, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"8"}
}
, 
[307907] = {id = 307907, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"8.5"}
}
, 
[307908] = {id = 307908, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"9"}
}
, 
[307909] = {id = 307909, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"9.5"}
}
, 
[307910] = {id = 307910, nameTextID = -1, exDiscribeTextID = 303484, typeTextID = -1, 
attr = {"10"}
}
, 
[308001] = {id = 308001, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"5.5"}
}
, 
[308002] = {id = 308002, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"6"}
}
, 
[308003] = {id = 308003, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"6.5"}
}
, 
[308004] = {id = 308004, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"7"}
}
, 
[308005] = {id = 308005, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"7.5"}
}
, 
[308006] = {id = 308006, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"8"}
}
, 
[308007] = {id = 308007, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"8.5"}
}
, 
[308008] = {id = 308008, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"9"}
}
, 
[308009] = {id = 308009, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"9.5"}
}
, 
[308010] = {id = 308010, nameTextID = -1, exDiscribeTextID = 303747, typeTextID = -1, 
attr = {"10"}
}
, 
[308101] = {id = 308101, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"55"}
}
, 
[308102] = {id = 308102, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"60"}
}
, 
[308103] = {id = 308103, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"65"}
}
, 
[308104] = {id = 308104, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"70"}
}
, 
[308105] = {id = 308105, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"75"}
}
, 
[308106] = {id = 308106, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"80"}
}
, 
[308107] = {id = 308107, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"85"}
}
, 
[308108] = {id = 308108, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"90"}
}
, 
[308109] = {id = 308109, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"95"}
}
, 
[308110] = {id = 308110, nameTextID = -1, exDiscribeTextID = 303580, typeTextID = -1, 
attr = {"100"}
}
, 
[308201] = {id = 308201, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"55"}
}
, 
[308202] = {id = 308202, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"60"}
}
, 
[308203] = {id = 308203, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"65"}
}
, 
[308204] = {id = 308204, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"70"}
}
, 
[308205] = {id = 308205, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"75"}
}
, 
[308206] = {id = 308206, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"80"}
}
, 
[308207] = {id = 308207, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"85"}
}
, 
[308208] = {id = 308208, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"90"}
}
, 
[308209] = {id = 308209, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"95"}
}
, 
[308210] = {id = 308210, nameTextID = -1, exDiscribeTextID = 303814, typeTextID = -1, 
attr = {"100"}
}
, 
[308301] = {id = 308301, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"55"}
}
, 
[308302] = {id = 308302, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"60"}
}
, 
[308303] = {id = 308303, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"65"}
}
, 
[308304] = {id = 308304, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"70"}
}
, 
[308305] = {id = 308305, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"75"}
}
, 
[308306] = {id = 308306, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"80"}
}
, 
[308307] = {id = 308307, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"85"}
}
, 
[308308] = {id = 308308, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"90"}
}
, 
[308309] = {id = 308309, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"95"}
}
, 
[308310] = {id = 308310, nameTextID = -1, exDiscribeTextID = 303681, typeTextID = -1, 
attr = {"100"}
}
, 
[308401] = {id = 308401, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"22"}
}
, 
[308402] = {id = 308402, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"24"}
}
, 
[308403] = {id = 308403, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"26"}
}
, 
[308404] = {id = 308404, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"28"}
}
, 
[308405] = {id = 308405, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"30"}
}
, 
[308406] = {id = 308406, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"32"}
}
, 
[308407] = {id = 308407, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"34"}
}
, 
[308408] = {id = 308408, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"36"}
}
, 
[308409] = {id = 308409, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"38"}
}
, 
[308410] = {id = 308410, nameTextID = -1, exDiscribeTextID = 303558, typeTextID = -1, 
attr = {"40"}
}
, 
[308501] = {id = 308501, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"11"}
}
, 
[308502] = {id = 308502, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"12"}
}
, 
[308503] = {id = 308503, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"13"}
}
, 
[308504] = {id = 308504, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"14"}
}
, 
[308505] = {id = 308505, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"15"}
}
, 
[308506] = {id = 308506, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"16"}
}
, 
[308507] = {id = 308507, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"17"}
}
, 
[308508] = {id = 308508, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"18"}
}
, 
[308509] = {id = 308509, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"19"}
}
, 
[308510] = {id = 308510, nameTextID = -1, exDiscribeTextID = 303551, typeTextID = -1, 
attr = {"20"}
}
, 
[308801] = {id = 308801, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"5.5"}
}
, 
[308802] = {id = 308802, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"6"}
}
, 
[308803] = {id = 308803, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"6.5"}
}
, 
[308804] = {id = 308804, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"7"}
}
, 
[308805] = {id = 308805, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"7.5"}
}
, 
[308806] = {id = 308806, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"8"}
}
, 
[308807] = {id = 308807, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"8.5"}
}
, 
[308808] = {id = 308808, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"9"}
}
, 
[308809] = {id = 308809, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"9.5"}
}
, 
[308810] = {id = 308810, nameTextID = -1, exDiscribeTextID = 303679, typeTextID = -1, 
attr = {"10"}
}
, 
[308901] = {id = 308901, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"38.5"}
}
, 
[308902] = {id = 308902, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"42"}
}
, 
[308903] = {id = 308903, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"45.5"}
}
, 
[308904] = {id = 308904, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"49"}
}
, 
[308905] = {id = 308905, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"52.5"}
}
, 
[308906] = {id = 308906, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"56"}
}
, 
[308907] = {id = 308907, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"59.5"}
}
, 
[308908] = {id = 308908, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"63"}
}
, 
[308909] = {id = 308909, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"66.5"}
}
, 
[308910] = {id = 308910, nameTextID = -1, exDiscribeTextID = 303470, typeTextID = -1, 
attr = {"70"}
}
, 
[309001] = {id = 309001, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"27.5", "27.5"}
}
, 
[309002] = {id = 309002, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"30", "30"}
}
, 
[309003] = {id = 309003, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"32.5", "32.5"}
}
, 
[309004] = {id = 309004, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"35", "35"}
}
, 
[309005] = {id = 309005, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"37.5", "37.5"}
}
, 
[309006] = {id = 309006, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"40", "40"}
}
, 
[309007] = {id = 309007, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"42.5", "42.5"}
}
, 
[309008] = {id = 309008, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"45", "45"}
}
, 
[309009] = {id = 309009, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"47.5", "47.5"}
}
, 
[309010] = {id = 309010, nameTextID = -1, exDiscribeTextID = 303494, typeTextID = -1, 
attr = {"50", "50"}
}
, 
[309101] = {id = 309101, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"33"}
}
, 
[309102] = {id = 309102, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"36"}
}
, 
[309103] = {id = 309103, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"39"}
}
, 
[309104] = {id = 309104, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"42"}
}
, 
[309105] = {id = 309105, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"45"}
}
, 
[309106] = {id = 309106, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"48"}
}
, 
[309107] = {id = 309107, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"51"}
}
, 
[309108] = {id = 309108, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"54"}
}
, 
[309109] = {id = 309109, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"57"}
}
, 
[309110] = {id = 309110, nameTextID = -1, exDiscribeTextID = 303477, typeTextID = -1, 
attr = {"60"}
}
, 
[309201] = {id = 309201, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"1.65"}
}
, 
[309202] = {id = 309202, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"1.8"}
}
, 
[309203] = {id = 309203, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"1.95"}
}
, 
[309204] = {id = 309204, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"2.1"}
}
, 
[309205] = {id = 309205, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"2.25"}
}
, 
[309206] = {id = 309206, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"2.4"}
}
, 
[309207] = {id = 309207, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"2.55"}
}
, 
[309208] = {id = 309208, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"2.7"}
}
, 
[309209] = {id = 309209, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"2.85"}
}
, 
[309210] = {id = 309210, nameTextID = -1, exDiscribeTextID = 303486, typeTextID = -1, 
attr = {"3"}
}
, 
[309301] = {id = 309301, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"21"}
}
, 
[309302] = {id = 309302, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"22"}
}
, 
[309303] = {id = 309303, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"23"}
}
, 
[309304] = {id = 309304, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"24"}
}
, 
[309305] = {id = 309305, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"25"}
}
, 
[309306] = {id = 309306, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"26"}
}
, 
[309307] = {id = 309307, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"27"}
}
, 
[309308] = {id = 309308, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"28"}
}
, 
[309309] = {id = 309309, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"29"}
}
, 
[309310] = {id = 309310, nameTextID = -1, exDiscribeTextID = 303835, typeTextID = -1, 
attr = {"30"}
}
, 
[309401] = {id = 309401, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"11"}
}
, 
[309402] = {id = 309402, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"12"}
}
, 
[309403] = {id = 309403, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"13"}
}
, 
[309404] = {id = 309404, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"14"}
}
, 
[309405] = {id = 309405, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"15"}
}
, 
[309406] = {id = 309406, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"16"}
}
, 
[309407] = {id = 309407, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"17"}
}
, 
[309408] = {id = 309408, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"18"}
}
, 
[309409] = {id = 309409, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"19"}
}
, 
[309410] = {id = 309410, nameTextID = -1, exDiscribeTextID = 303565, typeTextID = -1, 
attr = {"20"}
}
, 
[309501] = {id = 309501, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"5.5", "5.5"}
}
, 
[309502] = {id = 309502, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"6", "6"}
}
, 
[309503] = {id = 309503, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"6.5", "6.5"}
}
, 
[309504] = {id = 309504, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"7", "7"}
}
, 
[309505] = {id = 309505, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"7.5", "7.5"}
}
, 
[309506] = {id = 309506, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"8", "8"}
}
, 
[309507] = {id = 309507, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"8.5", "8.5"}
}
, 
[309508] = {id = 309508, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"9", "9"}
}
, 
[309509] = {id = 309509, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"9.5", "9.5"}
}
, 
[309510] = {id = 309510, nameTextID = -1, exDiscribeTextID = 303680, typeTextID = -1, 
attr = {"10", "10"}
}
, 
[309701] = {id = 309701, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"27.5"}
}
, 
[309702] = {id = 309702, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"30"}
}
, 
[309703] = {id = 309703, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"32.5"}
}
, 
[309704] = {id = 309704, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"35"}
}
, 
[309705] = {id = 309705, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"37.5"}
}
, 
[309706] = {id = 309706, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"40"}
}
, 
[309707] = {id = 309707, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"42.5"}
}
, 
[309708] = {id = 309708, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"45"}
}
, 
[309709] = {id = 309709, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"47.5"}
}
, 
[309710] = {id = 309710, nameTextID = -1, exDiscribeTextID = 303587, typeTextID = -1, 
attr = {"50"}
}
, 
[309801] = {id = 309801, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"5.5"}
}
, 
[309802] = {id = 309802, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"6"}
}
, 
[309803] = {id = 309803, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"6.5"}
}
, 
[309804] = {id = 309804, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"7"}
}
, 
[309805] = {id = 309805, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"7.5"}
}
, 
[309806] = {id = 309806, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"8"}
}
, 
[309807] = {id = 309807, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"8.5"}
}
, 
[309808] = {id = 309808, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"9"}
}
, 
[309809] = {id = 309809, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"9.5"}
}
, 
[309810] = {id = 309810, nameTextID = -1, exDiscribeTextID = 303754, typeTextID = -1, 
attr = {"10"}
}
, 
[309901] = {id = 309901, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"11"}
}
, 
[309902] = {id = 309902, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"12"}
}
, 
[309903] = {id = 309903, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"13"}
}
, 
[309904] = {id = 309904, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"14"}
}
, 
[309905] = {id = 309905, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"15"}
}
, 
[309906] = {id = 309906, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"16"}
}
, 
[309907] = {id = 309907, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"17"}
}
, 
[309908] = {id = 309908, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"18"}
}
, 
[309909] = {id = 309909, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"19"}
}
, 
[309910] = {id = 309910, nameTextID = -1, exDiscribeTextID = 303461, typeTextID = -1, 
attr = {"20"}
}
, 
[310001] = {id = 310001, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"38.5"}
}
, 
[310002] = {id = 310002, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"42"}
}
, 
[310003] = {id = 310003, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"45.5"}
}
, 
[310004] = {id = 310004, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"49"}
}
, 
[310005] = {id = 310005, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"52.5"}
}
, 
[310006] = {id = 310006, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"56"}
}
, 
[310007] = {id = 310007, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"59.5"}
}
, 
[310008] = {id = 310008, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"63"}
}
, 
[310009] = {id = 310009, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"66.5"}
}
, 
[310010] = {id = 310010, nameTextID = -1, exDiscribeTextID = 303763, typeTextID = -1, 
attr = {"70"}
}
, 
[310101] = {id = 310101, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"27.5"}
}
, 
[310102] = {id = 310102, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"30"}
}
, 
[310103] = {id = 310103, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"32.5"}
}
, 
[310104] = {id = 310104, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"35"}
}
, 
[310105] = {id = 310105, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"37.5"}
}
, 
[310106] = {id = 310106, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"40"}
}
, 
[310107] = {id = 310107, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"42.5"}
}
, 
[310108] = {id = 310108, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"45"}
}
, 
[310109] = {id = 310109, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"47.5"}
}
, 
[310110] = {id = 310110, nameTextID = -1, exDiscribeTextID = 303578, typeTextID = -1, 
attr = {"50"}
}
, 
[310201] = {id = 310201, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"5.5"}
}
, 
[310202] = {id = 310202, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"6"}
}
, 
[310203] = {id = 310203, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"6.5"}
}
, 
[310204] = {id = 310204, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"7"}
}
, 
[310205] = {id = 310205, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"7.5"}
}
, 
[310206] = {id = 310206, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"8"}
}
, 
[310207] = {id = 310207, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"8.5"}
}
, 
[310208] = {id = 310208, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"9"}
}
, 
[310209] = {id = 310209, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"9.5"}
}
, 
[310210] = {id = 310210, nameTextID = -1, exDiscribeTextID = 303501, typeTextID = -1, 
attr = {"10"}
}
, 
[310301] = {id = 310301, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"5.5", "2.75"}
}
, 
[310302] = {id = 310302, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"6", "3"}
}
, 
[310303] = {id = 310303, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"6.5", "3.25"}
}
, 
[310304] = {id = 310304, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"7", "3.5"}
}
, 
[310305] = {id = 310305, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"7.5", "3.75"}
}
, 
[310306] = {id = 310306, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"8", "4"}
}
, 
[310307] = {id = 310307, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"8.5", "4.25"}
}
, 
[310308] = {id = 310308, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"9", "4.5"}
}
, 
[310309] = {id = 310309, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"9.5", "4.75"}
}
, 
[310310] = {id = 310310, nameTextID = -1, exDiscribeTextID = 303493, typeTextID = -1, 
attr = {"10", "5"}
}
, 
[310401] = {id = 310401, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"11"}
}
, 
[310402] = {id = 310402, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"12"}
}
, 
[310403] = {id = 310403, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"13"}
}
, 
[310404] = {id = 310404, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"14"}
}
, 
[310405] = {id = 310405, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"15"}
}
, 
[310406] = {id = 310406, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"16"}
}
, 
[310407] = {id = 310407, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"17"}
}
, 
[310408] = {id = 310408, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"18"}
}
, 
[310409] = {id = 310409, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"19"}
}
, 
[310410] = {id = 310410, nameTextID = -1, exDiscribeTextID = 303696, typeTextID = -1, 
attr = {"20"}
}
, 
[310501] = {id = 310501, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"8.25"}
}
, 
[310502] = {id = 310502, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"9"}
}
, 
[310503] = {id = 310503, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"9.75"}
}
, 
[310504] = {id = 310504, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"10.5"}
}
, 
[310505] = {id = 310505, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"11.25"}
}
, 
[310506] = {id = 310506, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"12"}
}
, 
[310507] = {id = 310507, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"12.75"}
}
, 
[310508] = {id = 310508, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"13.5"}
}
, 
[310509] = {id = 310509, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"14.25"}
}
, 
[310510] = {id = 310510, nameTextID = -1, exDiscribeTextID = 303766, typeTextID = -1, 
attr = {"15"}
}
, 
[310601] = {id = 310601, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"11"}
}
, 
[310602] = {id = 310602, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"12"}
}
, 
[310603] = {id = 310603, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"13"}
}
, 
[310604] = {id = 310604, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"14"}
}
, 
[310605] = {id = 310605, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"15"}
}
, 
[310606] = {id = 310606, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"16"}
}
, 
[310607] = {id = 310607, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"17"}
}
, 
[310608] = {id = 310608, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"18"}
}
, 
[310609] = {id = 310609, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"19"}
}
, 
[310610] = {id = 310610, nameTextID = -1, exDiscribeTextID = 303765, typeTextID = -1, 
attr = {"20"}
}
, 
[310701] = {id = 310701, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"22"}
}
, 
[310702] = {id = 310702, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"24"}
}
, 
[310703] = {id = 310703, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"26"}
}
, 
[310704] = {id = 310704, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"28"}
}
, 
[310705] = {id = 310705, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"30"}
}
, 
[310706] = {id = 310706, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"32"}
}
, 
[310707] = {id = 310707, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"34"}
}
, 
[310708] = {id = 310708, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"36"}
}
, 
[310709] = {id = 310709, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"38"}
}
, 
[310710] = {id = 310710, nameTextID = -1, exDiscribeTextID = 303767, typeTextID = -1, 
attr = {"40"}
}
, 
[310801] = {id = 310801, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"5.5"}
}
, 
[310802] = {id = 310802, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"6"}
}
, 
[310803] = {id = 310803, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"6.5"}
}
, 
[310804] = {id = 310804, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"7"}
}
, 
[310805] = {id = 310805, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"7.5"}
}
, 
[310806] = {id = 310806, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"8"}
}
, 
[310807] = {id = 310807, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"8.5"}
}
, 
[310808] = {id = 310808, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"9"}
}
, 
[310809] = {id = 310809, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"9.5"}
}
, 
[310810] = {id = 310810, nameTextID = -1, exDiscribeTextID = 303711, typeTextID = -1, 
attr = {"10"}
}
, 
[310901] = {id = 310901, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"11"}
}
, 
[310902] = {id = 310902, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"12"}
}
, 
[310903] = {id = 310903, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"13"}
}
, 
[310904] = {id = 310904, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"14"}
}
, 
[310905] = {id = 310905, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"15"}
}
, 
[310906] = {id = 310906, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"16"}
}
, 
[310907] = {id = 310907, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"17"}
}
, 
[310908] = {id = 310908, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"18"}
}
, 
[310909] = {id = 310909, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"19"}
}
, 
[310910] = {id = 310910, nameTextID = -1, exDiscribeTextID = 303746, typeTextID = -1, 
attr = {"20"}
}
, 
[311101] = {id = 311101, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"11", "11"}
}
, 
[311102] = {id = 311102, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"12", "12"}
}
, 
[311103] = {id = 311103, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"13", "13"}
}
, 
[311104] = {id = 311104, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"14", "14"}
}
, 
[311105] = {id = 311105, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"15", "15"}
}
, 
[311106] = {id = 311106, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"16", "16"}
}
, 
[311107] = {id = 311107, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"17", "17"}
}
, 
[311108] = {id = 311108, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"18", "18"}
}
, 
[311109] = {id = 311109, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"19", "19"}
}
, 
[311110] = {id = 311110, nameTextID = -1, exDiscribeTextID = 303718, typeTextID = -1, 
attr = {"20", "20"}
}
, 
[311201] = {id = 311201, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"16.5"}
}
, 
[311202] = {id = 311202, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"18"}
}
, 
[311203] = {id = 311203, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"19.5"}
}
, 
[311204] = {id = 311204, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"21"}
}
, 
[311205] = {id = 311205, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"22.5"}
}
, 
[311206] = {id = 311206, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"24"}
}
, 
[311207] = {id = 311207, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"25.5"}
}
, 
[311208] = {id = 311208, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"27"}
}
, 
[311209] = {id = 311209, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"28.5"}
}
, 
[311210] = {id = 311210, nameTextID = -1, exDiscribeTextID = 303688, typeTextID = -1, 
attr = {"30"}
}
, 
[311301] = {id = 311301, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"11", "550", "11"}
}
, 
[311302] = {id = 311302, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"12", "600", "12"}
}
, 
[311303] = {id = 311303, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"13", "650", "13"}
}
, 
[311304] = {id = 311304, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"14", "700", "14"}
}
, 
[311305] = {id = 311305, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"15", "750", "15"}
}
, 
[311306] = {id = 311306, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"16", "800", "16"}
}
, 
[311307] = {id = 311307, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"17", "850", "17"}
}
, 
[311308] = {id = 311308, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"18", "900", "18"}
}
, 
[311309] = {id = 311309, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"19", "950", "19"}
}
, 
[311310] = {id = 311310, nameTextID = -1, exDiscribeTextID = 303710, typeTextID = -1, 
attr = {"20", "1000", "20"}
}
, 
[311501] = {id = 311501, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"11", "22"}
}
, 
[311502] = {id = 311502, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"12", "24"}
}
, 
[311503] = {id = 311503, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"13", "26"}
}
, 
[311504] = {id = 311504, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"14", "28"}
}
, 
[311505] = {id = 311505, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"15", "30"}
}
, 
[311506] = {id = 311506, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"16", "32"}
}
, 
[311507] = {id = 311507, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"17", "34"}
}
, 
[311508] = {id = 311508, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"18", "36"}
}
, 
[311509] = {id = 311509, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"19", "38"}
}
, 
[311510] = {id = 311510, nameTextID = -1, exDiscribeTextID = 303739, typeTextID = -1, 
attr = {"20", "40"}
}
, 
[311601] = {id = 311601, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"11"}
}
, 
[311602] = {id = 311602, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"12"}
}
, 
[311603] = {id = 311603, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"13"}
}
, 
[311604] = {id = 311604, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"14"}
}
, 
[311605] = {id = 311605, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"15"}
}
, 
[311606] = {id = 311606, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"16"}
}
, 
[311607] = {id = 311607, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"17"}
}
, 
[311608] = {id = 311608, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"18"}
}
, 
[311609] = {id = 311609, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"19"}
}
, 
[311610] = {id = 311610, nameTextID = -1, exDiscribeTextID = 303828, typeTextID = -1, 
attr = {"20"}
}
, 
[311701] = {id = 311701, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"11"}
}
, 
[311702] = {id = 311702, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"12"}
}
, 
[311703] = {id = 311703, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"13"}
}
, 
[311704] = {id = 311704, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"14"}
}
, 
[311705] = {id = 311705, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"15"}
}
, 
[311706] = {id = 311706, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"16"}
}
, 
[311707] = {id = 311707, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"17"}
}
, 
[311708] = {id = 311708, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"18"}
}
, 
[311709] = {id = 311709, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"19"}
}
, 
[311710] = {id = 311710, nameTextID = -1, exDiscribeTextID = 303786, typeTextID = -1, 
attr = {"20"}
}
, 
[311801] = {id = 311801, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"22"}
}
, 
[311802] = {id = 311802, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"24"}
}
, 
[311803] = {id = 311803, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"26"}
}
, 
[311804] = {id = 311804, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"28"}
}
, 
[311805] = {id = 311805, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"30"}
}
, 
[311806] = {id = 311806, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"32"}
}
, 
[311807] = {id = 311807, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"34"}
}
, 
[311808] = {id = 311808, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"36"}
}
, 
[311809] = {id = 311809, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"38"}
}
, 
[311810] = {id = 311810, nameTextID = -1, exDiscribeTextID = 303842, typeTextID = -1, 
attr = {"40"}
}
, 
[311901] = {id = 311901, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"5.5"}
}
, 
[311902] = {id = 311902, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"6"}
}
, 
[311903] = {id = 311903, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"6.5"}
}
, 
[311904] = {id = 311904, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"7"}
}
, 
[311905] = {id = 311905, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"7.5"}
}
, 
[311906] = {id = 311906, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"8"}
}
, 
[311907] = {id = 311907, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"8.5"}
}
, 
[311908] = {id = 311908, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"9"}
}
, 
[311909] = {id = 311909, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"9.5"}
}
, 
[311910] = {id = 311910, nameTextID = -1, exDiscribeTextID = 303761, typeTextID = -1, 
attr = {"10"}
}
, 
[312001] = {id = 312001, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"22"}
}
, 
[312002] = {id = 312002, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"24"}
}
, 
[312003] = {id = 312003, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"26"}
}
, 
[312004] = {id = 312004, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"28"}
}
, 
[312005] = {id = 312005, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"30"}
}
, 
[312006] = {id = 312006, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"32"}
}
, 
[312007] = {id = 312007, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"34"}
}
, 
[312008] = {id = 312008, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"36"}
}
, 
[312009] = {id = 312009, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"38"}
}
, 
[312010] = {id = 312010, nameTextID = -1, exDiscribeTextID = 303703, typeTextID = -1, 
attr = {"40"}
}
, 
[312101] = {id = 312101, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"11"}
}
, 
[312102] = {id = 312102, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"12"}
}
, 
[312103] = {id = 312103, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"13"}
}
, 
[312104] = {id = 312104, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"14"}
}
, 
[312105] = {id = 312105, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"15"}
}
, 
[312106] = {id = 312106, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"16"}
}
, 
[312107] = {id = 312107, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"17"}
}
, 
[312108] = {id = 312108, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"18"}
}
, 
[312109] = {id = 312109, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"19"}
}
, 
[312110] = {id = 312110, nameTextID = -1, exDiscribeTextID = 303800, typeTextID = -1, 
attr = {"20"}
}
, 
[312201] = {id = 312201, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"1.65"}
}
, 
[312202] = {id = 312202, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"1.8"}
}
, 
[312203] = {id = 312203, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"1.95"}
}
, 
[312204] = {id = 312204, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"2.1"}
}
, 
[312205] = {id = 312205, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"2.25"}
}
, 
[312206] = {id = 312206, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"2.4"}
}
, 
[312207] = {id = 312207, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"2.55"}
}
, 
[312208] = {id = 312208, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"2.7"}
}
, 
[312209] = {id = 312209, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"2.85"}
}
, 
[312210] = {id = 312210, nameTextID = -1, exDiscribeTextID = 303793, typeTextID = -1, 
attr = {"3"}
}
, 
[312301] = {id = 312301, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"1"}
}
, 
[312302] = {id = 312302, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"2"}
}
, 
[312303] = {id = 312303, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"3"}
}
, 
[312304] = {id = 312304, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"4"}
}
, 
[312305] = {id = 312305, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"5"}
}
, 
[312306] = {id = 312306, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"6"}
}
, 
[312307] = {id = 312307, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"7"}
}
, 
[312308] = {id = 312308, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"8"}
}
, 
[312309] = {id = 312309, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"9"}
}
, 
[312310] = {id = 312310, nameTextID = -1, exDiscribeTextID = 303807, typeTextID = -1, 
attr = {"10"}
}
, 
[312401] = {id = 312401, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"5.5"}
}
, 
[312402] = {id = 312402, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"6"}
}
, 
[312403] = {id = 312403, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"6.5"}
}
, 
[312404] = {id = 312404, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"7"}
}
, 
[312405] = {id = 312405, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"7.5"}
}
, 
[312406] = {id = 312406, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"8"}
}
, 
[312407] = {id = 312407, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"8.5"}
}
, 
[312408] = {id = 312408, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"9"}
}
, 
[312409] = {id = 312409, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"9.5"}
}
, 
[312410] = {id = 312410, nameTextID = -1, exDiscribeTextID = 303821, typeTextID = -1, 
attr = {"10"}
}
, 
[312601] = {id = 312601, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"11"}
}
, 
[312602] = {id = 312602, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"12"}
}
, 
[312603] = {id = 312603, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"13"}
}
, 
[312604] = {id = 312604, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"14"}
}
, 
[312605] = {id = 312605, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"15"}
}
, 
[312606] = {id = 312606, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"16"}
}
, 
[312607] = {id = 312607, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"17"}
}
, 
[312608] = {id = 312608, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"18"}
}
, 
[312609] = {id = 312609, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"19"}
}
, 
[312610] = {id = 312610, nameTextID = -1, exDiscribeTextID = 303849, typeTextID = -1, 
attr = {"20"}
}
, 
[313001] = {id = 313001, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"1.65"}
}
, 
[313002] = {id = 313002, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"1.8"}
}
, 
[313003] = {id = 313003, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"1.95"}
}
, 
[313004] = {id = 313004, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"2.1"}
}
, 
[313005] = {id = 313005, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"2.25"}
}
, 
[313006] = {id = 313006, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"2.4"}
}
, 
[313007] = {id = 313007, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"2.55"}
}
, 
[313008] = {id = 313008, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"2.7"}
}
, 
[313009] = {id = 313009, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"2.85"}
}
, 
[313010] = {id = 313010, nameTextID = -1, exDiscribeTextID = 303863, typeTextID = -1, 
attr = {"3"}
}
, 
[400101] = {id = 400101, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"32"}
}
, 
[400102] = {id = 400102, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"32"}
}
, 
[400103] = {id = 400103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[400104] = {id = 400104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"145"}
}
, 
[400105] = {id = 400105, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"129"}
}
, 
[400106] = {id = 400106, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"129"}
}
, 
[400107] = {id = 400107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[400108] = {id = 400108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"583"}
}
, 
[400201] = {id = 400201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[400202] = {id = 400202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[400203] = {id = 400203, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[400204] = {id = 400204, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[400205] = {id = 400205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[400206] = {id = 400206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[400207] = {id = 400207, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[400208] = {id = 400208, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[400301] = {id = 400301, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"32"}
}
, 
[400302] = {id = 400302, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"32"}
}
, 
[400303] = {id = 400303, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"680"}
}
, 
[400304] = {id = 400304, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"137"}
}
, 
[400305] = {id = 400305, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"129"}
}
, 
[400306] = {id = 400306, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"129"}
}
, 
[400307] = {id = 400307, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2721"}
}
, 
[400308] = {id = 400308, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"550"}
}
, 
[400401] = {id = 400401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"24"}
}
, 
[400402] = {id = 400402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"24"}
}
, 
[400403] = {id = 400403, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"91"}
}
, 
[400404] = {id = 400404, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"459"}
}
, 
[400405] = {id = 400405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"97"}
}
, 
[400406] = {id = 400406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"97"}
}
, 
[400407] = {id = 400407, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"367"}
}
, 
[400408] = {id = 400408, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1836"}
}
, 
[400501] = {id = 400501, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[400502] = {id = 400502, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[400503] = {id = 400503, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[400504] = {id = 400504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[400505] = {id = 400505, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[400506] = {id = 400506, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[400507] = {id = 400507, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[400508] = {id = 400508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[400601] = {id = 400601, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[400602] = {id = 400602, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[400603] = {id = 400603, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[400604] = {id = 400604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[400605] = {id = 400605, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[400606] = {id = 400606, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[400607] = {id = 400607, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[400608] = {id = 400608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[400701] = {id = 400701, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"30"}
}
, 
[400702] = {id = 400702, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"30"}
}
, 
[400703] = {id = 400703, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"642"}
}
, 
[400704] = {id = 400704, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"130"}
}
, 
[400705] = {id = 400705, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"122"}
}
, 
[400706] = {id = 400706, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"122"}
}
, 
[400707] = {id = 400707, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2570"}
}
, 
[400708] = {id = 400708, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"520"}
}
, 
[400801] = {id = 400801, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"72"}
}
, 
[400802] = {id = 400802, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"72"}
}
, 
[400803] = {id = 400803, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"72"}
}
, 
[400804] = {id = 400804, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1080"}
}
, 
[400805] = {id = 400805, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"288"}
}
, 
[400806] = {id = 400806, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"288"}
}
, 
[400807] = {id = 400807, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"288"}
}
, 
[400808] = {id = 400808, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"4320"}
}
, 
[400901] = {id = 400901, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"24"}
}
, 
[400902] = {id = 400902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"24"}
}
, 
[400903] = {id = 400903, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"91"}
}
, 
[400904] = {id = 400904, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"459"}
}
, 
[400905] = {id = 400905, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"97"}
}
, 
[400906] = {id = 400906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"97"}
}
, 
[400907] = {id = 400907, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"367"}
}
, 
[400908] = {id = 400908, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1836"}
}
, 
[401001] = {id = 401001, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[401002] = {id = 401002, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[401003] = {id = 401003, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[401004] = {id = 401004, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[401005] = {id = 401005, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[401006] = {id = 401006, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[401007] = {id = 401007, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[401008] = {id = 401008, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[401101] = {id = 401101, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"72"}
}
, 
[401102] = {id = 401102, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"72"}
}
, 
[401103] = {id = 401103, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"72"}
}
, 
[401104] = {id = 401104, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1080"}
}
, 
[401105] = {id = 401105, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"288"}
}
, 
[401106] = {id = 401106, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"288"}
}
, 
[401107] = {id = 401107, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"288"}
}
, 
[401108] = {id = 401108, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"4320"}
}
, 
[401201] = {id = 401201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[401202] = {id = 401202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[401203] = {id = 401203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[401204] = {id = 401204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[401205] = {id = 401205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[401206] = {id = 401206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[401207] = {id = 401207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[401208] = {id = 401208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[401301] = {id = 401301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"21"}
}
, 
[401302] = {id = 401302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"21"}
}
, 
[401303] = {id = 401303, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"432"}
}
, 
[401304] = {id = 401304, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"180"}
}
, 
[401305] = {id = 401305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"86"}
}
, 
[401306] = {id = 401306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"86"}
}
, 
[401307] = {id = 401307, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1728"}
}
, 
[401308] = {id = 401308, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"720"}
}
, 
[401401] = {id = 401401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"19"}
}
, 
[401402] = {id = 401402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"19"}
}
, 
[401403] = {id = 401403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"388"}
}
, 
[401404] = {id = 401404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[401405] = {id = 401405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"77"}
}
, 
[401406] = {id = 401406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"77"}
}
, 
[401407] = {id = 401407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1555"}
}
, 
[401408] = {id = 401408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[401501] = {id = 401501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[401502] = {id = 401502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[401503] = {id = 401503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[401504] = {id = 401504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"145"}
}
, 
[401505] = {id = 401505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[401506] = {id = 401506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[401507] = {id = 401507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[401508] = {id = 401508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"583"}
}
, 
[401601] = {id = 401601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"32"}
}
, 
[401602] = {id = 401602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"32"}
}
, 
[401603] = {id = 401603, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"680"}
}
, 
[401604] = {id = 401604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"137"}
}
, 
[401605] = {id = 401605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"129"}
}
, 
[401606] = {id = 401606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"129"}
}
, 
[401607] = {id = 401607, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2721"}
}
, 
[401608] = {id = 401608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"550"}
}
, 
[401701] = {id = 401701, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[401702] = {id = 401702, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[401703] = {id = 401703, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[401704] = {id = 401704, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[401705] = {id = 401705, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[401706] = {id = 401706, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[401707] = {id = 401707, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[401708] = {id = 401708, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[401801] = {id = 401801, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[401802] = {id = 401802, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[401803] = {id = 401803, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[401804] = {id = 401804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[401805] = {id = 401805, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[401806] = {id = 401806, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[401807] = {id = 401807, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[401808] = {id = 401808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[401901] = {id = 401901, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[401902] = {id = 401902, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[401903] = {id = 401903, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[401904] = {id = 401904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[401905] = {id = 401905, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[401906] = {id = 401906, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[401907] = {id = 401907, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[401908] = {id = 401908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[402001] = {id = 402001, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"30"}
}
, 
[402002] = {id = 402002, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"30"}
}
, 
[402003] = {id = 402003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"642"}
}
, 
[402004] = {id = 402004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"130"}
}
, 
[402005] = {id = 402005, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"122"}
}
, 
[402006] = {id = 402006, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"122"}
}
, 
[402007] = {id = 402007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2570"}
}
, 
[402008] = {id = 402008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"520"}
}
, 
[402101] = {id = 402101, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"30"}
}
, 
[402102] = {id = 402102, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"30"}
}
, 
[402103] = {id = 402103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"642"}
}
, 
[402104] = {id = 402104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"130"}
}
, 
[402105] = {id = 402105, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"122"}
}
, 
[402106] = {id = 402106, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"122"}
}
, 
[402107] = {id = 402107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2570"}
}
, 
[402108] = {id = 402108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"520"}
}
, 
[402201] = {id = 402201, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[402202] = {id = 402202, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[402203] = {id = 402203, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[402204] = {id = 402204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[402205] = {id = 402205, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[402206] = {id = 402206, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[402207] = {id = 402207, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[402208] = {id = 402208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[402301] = {id = 402301, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"72"}
}
, 
[402302] = {id = 402302, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"72"}
}
, 
[402303] = {id = 402303, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"72"}
}
, 
[402304] = {id = 402304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1080"}
}
, 
[402305] = {id = 402305, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"288"}
}
, 
[402306] = {id = 402306, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"288"}
}
, 
[402307] = {id = 402307, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"288"}
}
, 
[402308] = {id = 402308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"4320"}
}
, 
[402401] = {id = 402401, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[402402] = {id = 402402, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[402403] = {id = 402403, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[402404] = {id = 402404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[402405] = {id = 402405, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[402406] = {id = 402406, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[402407] = {id = 402407, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[402408] = {id = 402408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[402501] = {id = 402501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[402502] = {id = 402502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[402503] = {id = 402503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[402504] = {id = 402504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[402505] = {id = 402505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[402506] = {id = 402506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[402507] = {id = 402507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[402508] = {id = 402508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"615"}
}
, 
[402601] = {id = 402601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"19"}
}
, 
[402602] = {id = 402602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"19"}
}
, 
[402603] = {id = 402603, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"388"}
}
, 
[402604] = {id = 402604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[402605] = {id = 402605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"77"}
}
, 
[402606] = {id = 402606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"77"}
}
, 
[402607] = {id = 402607, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1555"}
}
, 
[402608] = {id = 402608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[402701] = {id = 402701, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"64"}
}
, 
[402702] = {id = 402702, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"64"}
}
, 
[402703] = {id = 402703, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"64"}
}
, 
[402704] = {id = 402704, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"972"}
}
, 
[402705] = {id = 402705, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"259"}
}
, 
[402706] = {id = 402706, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"259"}
}
, 
[402707] = {id = 402707, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"259"}
}
, 
[402708] = {id = 402708, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3888"}
}
, 
[402801] = {id = 402801, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[402802] = {id = 402802, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[402803] = {id = 402803, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[402804] = {id = 402804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[402805] = {id = 402805, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[402806] = {id = 402806, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[402807] = {id = 402807, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[402808] = {id = 402808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"615"}
}
, 
[402901] = {id = 402901, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"21"}
}
, 
[402902] = {id = 402902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"21"}
}
, 
[402903] = {id = 402903, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"432"}
}
, 
[402904] = {id = 402904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"180"}
}
, 
[402905] = {id = 402905, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"86"}
}
, 
[402906] = {id = 402906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"86"}
}
, 
[402907] = {id = 402907, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1728"}
}
, 
[402908] = {id = 402908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"720"}
}
, 
[403001] = {id = 403001, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[403002] = {id = 403002, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[403003] = {id = 403003, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[403004] = {id = 403004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[403005] = {id = 403005, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[403006] = {id = 403006, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[403007] = {id = 403007, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[403008] = {id = 403008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[403201] = {id = 403201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"19"}
}
, 
[403202] = {id = 403202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"19"}
}
, 
[403203] = {id = 403203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"388"}
}
, 
[403204] = {id = 403204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[403205] = {id = 403205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"77"}
}
, 
[403206] = {id = 403206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"77"}
}
, 
[403207] = {id = 403207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1555"}
}
, 
[403208] = {id = 403208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[403301] = {id = 403301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[403302] = {id = 403302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[403303] = {id = 403303, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[403304] = {id = 403304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[403305] = {id = 403305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[403306] = {id = 403306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[403307] = {id = 403307, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[403308] = {id = 403308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[403401] = {id = 403401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"20"}
}
, 
[403402] = {id = 403402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"20"}
}
, 
[403403] = {id = 403403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"410"}
}
, 
[403404] = {id = 403404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"171"}
}
, 
[403405] = {id = 403405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"81"}
}
, 
[403406] = {id = 403406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"81"}
}
, 
[403407] = {id = 403407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1641"}
}
, 
[403408] = {id = 403408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"684"}
}
, 
[403501] = {id = 403501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[403502] = {id = 403502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[403503] = {id = 403503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[403504] = {id = 403504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[403505] = {id = 403505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[403506] = {id = 403506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[403507] = {id = 403507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[403508] = {id = 403508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[403601] = {id = 403601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"24"}
}
, 
[403602] = {id = 403602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"24"}
}
, 
[403603] = {id = 403603, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"459"}
}
, 
[403604] = {id = 403604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"137"}
}
, 
[403605] = {id = 403605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"97"}
}
, 
[403606] = {id = 403606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"97"}
}
, 
[403607] = {id = 403607, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1836"}
}
, 
[403608] = {id = 403608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"550"}
}
, 
[403801] = {id = 403801, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[403802] = {id = 403802, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[403803] = {id = 403803, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[403804] = {id = 403804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[403805] = {id = 403805, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[403806] = {id = 403806, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[403807] = {id = 403807, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[403808] = {id = 403808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[403901] = {id = 403901, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"32"}
}
, 
[403902] = {id = 403902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"32"}
}
, 
[403903] = {id = 403903, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"680"}
}
, 
[403904] = {id = 403904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"137"}
}
, 
[403905] = {id = 403905, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"129"}
}
, 
[403906] = {id = 403906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"129"}
}
, 
[403907] = {id = 403907, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2721"}
}
, 
[403908] = {id = 403908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"550"}
}
, 
[404001] = {id = 404001, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[404002] = {id = 404002, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[404003] = {id = 404003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[404004] = {id = 404004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"145"}
}
, 
[404005] = {id = 404005, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[404006] = {id = 404006, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[404007] = {id = 404007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[404008] = {id = 404008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"583"}
}
, 
[404101] = {id = 404101, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[404102] = {id = 404102, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[404103] = {id = 404103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[404104] = {id = 404104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[404105] = {id = 404105, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[404106] = {id = 404106, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[404107] = {id = 404107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[404108] = {id = 404108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"615"}
}
, 
[404201] = {id = 404201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[404202] = {id = 404202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[404203] = {id = 404203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[404204] = {id = 404204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[404205] = {id = 404205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[404206] = {id = 404206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[404207] = {id = 404207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[404208] = {id = 404208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"615"}
}
, 
[404301] = {id = 404301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[404302] = {id = 404302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[404303] = {id = 404303, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[404304] = {id = 404304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[404305] = {id = 404305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[404306] = {id = 404306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[404307] = {id = 404307, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[404308] = {id = 404308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[404401] = {id = 404401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"24"}
}
, 
[404402] = {id = 404402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"24"}
}
, 
[404403] = {id = 404403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"459"}
}
, 
[404404] = {id = 404404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"137"}
}
, 
[404405] = {id = 404405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"97"}
}
, 
[404406] = {id = 404406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"97"}
}
, 
[404407] = {id = 404407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1836"}
}
, 
[404408] = {id = 404408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"550"}
}
, 
[404501] = {id = 404501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[404502] = {id = 404502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[404503] = {id = 404503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[404504] = {id = 404504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"145"}
}
, 
[404505] = {id = 404505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[404506] = {id = 404506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[404507] = {id = 404507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[404508] = {id = 404508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"583"}
}
, 
[404601] = {id = 404601, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"32"}
}
, 
[404602] = {id = 404602, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"32"}
}
, 
[404603] = {id = 404603, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"680"}
}
, 
[404604] = {id = 404604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"137"}
}
, 
[404605] = {id = 404605, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"129"}
}
, 
[404606] = {id = 404606, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"129"}
}
, 
[404607] = {id = 404607, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2721"}
}
, 
[404608] = {id = 404608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"550"}
}
, 
[404701] = {id = 404701, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"20"}
}
, 
[404702] = {id = 404702, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"20"}
}
, 
[404703] = {id = 404703, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"410"}
}
, 
[404704] = {id = 404704, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"171"}
}
, 
[404705] = {id = 404705, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"81"}
}
, 
[404706] = {id = 404706, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"81"}
}
, 
[404707] = {id = 404707, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1641"}
}
, 
[404708] = {id = 404708, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"684"}
}
, 
[404801] = {id = 404801, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"34"}
}
, 
[404802] = {id = 404802, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"34"}
}
, 
[404803] = {id = 404803, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"718"}
}
, 
[404804] = {id = 404804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"145"}
}
, 
[404805] = {id = 404805, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"136"}
}
, 
[404806] = {id = 404806, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"136"}
}
, 
[404807] = {id = 404807, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2872"}
}
, 
[404808] = {id = 404808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"580"}
}
, 
[404901] = {id = 404901, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"64"}
}
, 
[404902] = {id = 404902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"64"}
}
, 
[404903] = {id = 404903, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"64"}
}
, 
[404904] = {id = 404904, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"972"}
}
, 
[404905] = {id = 404905, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"259"}
}
, 
[404906] = {id = 404906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"259"}
}
, 
[404907] = {id = 404907, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"259"}
}
, 
[404908] = {id = 404908, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3888"}
}
, 
[405001] = {id = 405001, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[405002] = {id = 405002, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[405003] = {id = 405003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[405004] = {id = 405004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[405005] = {id = 405005, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[405006] = {id = 405006, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[405007] = {id = 405007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[405008] = {id = 405008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[405101] = {id = 405101, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[405102] = {id = 405102, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[405103] = {id = 405103, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[405104] = {id = 405104, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[405105] = {id = 405105, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[405106] = {id = 405106, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[405107] = {id = 405107, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[405108] = {id = 405108, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[405201] = {id = 405201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[405202] = {id = 405202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[405203] = {id = 405203, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[405204] = {id = 405204, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[405205] = {id = 405205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[405206] = {id = 405206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[405207] = {id = 405207, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[405208] = {id = 405208, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[405301] = {id = 405301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[405302] = {id = 405302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[405303] = {id = 405303, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[405304] = {id = 405304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[405305] = {id = 405305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[405306] = {id = 405306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[405307] = {id = 405307, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[405308] = {id = 405308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[405401] = {id = 405401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[405402] = {id = 405402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[405403] = {id = 405403, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[405404] = {id = 405404, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[405405] = {id = 405405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[405406] = {id = 405406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[405407] = {id = 405407, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[405408] = {id = 405408, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[405501] = {id = 405501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"20"}
}
, 
[405502] = {id = 405502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"20"}
}
, 
[405503] = {id = 405503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"410"}
}
, 
[405504] = {id = 405504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"171"}
}
, 
[405505] = {id = 405505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"81"}
}
, 
[405506] = {id = 405506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"81"}
}
, 
[405507] = {id = 405507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1641"}
}
, 
[405508] = {id = 405508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"684"}
}
, 
[405601] = {id = 405601, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[405602] = {id = 405602, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[405603] = {id = 405603, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[405604] = {id = 405604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[405605] = {id = 405605, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[405606] = {id = 405606, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[405607] = {id = 405607, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[405608] = {id = 405608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[405701] = {id = 405701, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"61"}
}
, 
[405702] = {id = 405702, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"61"}
}
, 
[405703] = {id = 405703, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"61"}
}
, 
[405704] = {id = 405704, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"918"}
}
, 
[405705] = {id = 405705, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"244"}
}
, 
[405706] = {id = 405706, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"244"}
}
, 
[405707] = {id = 405707, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"244"}
}
, 
[405708] = {id = 405708, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3672"}
}
, 
[405801] = {id = 405801, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"19"}
}
, 
[405802] = {id = 405802, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"19"}
}
, 
[405803] = {id = 405803, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"388"}
}
, 
[405804] = {id = 405804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[405805] = {id = 405805, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"77"}
}
, 
[405806] = {id = 405806, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"77"}
}
, 
[405807] = {id = 405807, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1555"}
}
, 
[405808] = {id = 405808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[405901] = {id = 405901, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"68"}
}
, 
[405902] = {id = 405902, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"68"}
}
, 
[405903] = {id = 405903, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"68"}
}
, 
[405904] = {id = 405904, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1026"}
}
, 
[405905] = {id = 405905, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"273"}
}
, 
[405906] = {id = 405906, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"273"}
}
, 
[405907] = {id = 405907, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"273"}
}
, 
[405908] = {id = 405908, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"4104"}
}
, 
[406001] = {id = 406001, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[406002] = {id = 406002, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[406003] = {id = 406003, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[406004] = {id = 406004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[406005] = {id = 406005, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[406006] = {id = 406006, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[406007] = {id = 406007, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[406008] = {id = 406008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[406101] = {id = 406101, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"34"}
}
, 
[406102] = {id = 406102, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"34"}
}
, 
[406103] = {id = 406103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"718"}
}
, 
[406104] = {id = 406104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"145"}
}
, 
[406105] = {id = 406105, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"136"}
}
, 
[406106] = {id = 406106, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"136"}
}
, 
[406107] = {id = 406107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2872"}
}
, 
[406108] = {id = 406108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"580"}
}
, 
[406201] = {id = 406201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[406202] = {id = 406202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[406203] = {id = 406203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[406204] = {id = 406204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[406205] = {id = 406205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[406206] = {id = 406206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[406207] = {id = 406207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[406208] = {id = 406208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[406301] = {id = 406301, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"72"}
}
, 
[406302] = {id = 406302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"72"}
}
, 
[406303] = {id = 406303, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"72"}
}
, 
[406304] = {id = 406304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1080"}
}
, 
[406305] = {id = 406305, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"288"}
}
, 
[406306] = {id = 406306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"288"}
}
, 
[406307] = {id = 406307, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"288"}
}
, 
[406308] = {id = 406308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"4320"}
}
, 
[406401] = {id = 406401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"19"}
}
, 
[406402] = {id = 406402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"19"}
}
, 
[406403] = {id = 406403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"388"}
}
, 
[406404] = {id = 406404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[406405] = {id = 406405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"77"}
}
, 
[406406] = {id = 406406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"77"}
}
, 
[406407] = {id = 406407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1555"}
}
, 
[406408] = {id = 406408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[406501] = {id = 406501, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[406502] = {id = 406502, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[406503] = {id = 406503, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[406504] = {id = 406504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"102"}
}
, 
[406505] = {id = 406505, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[406506] = {id = 406506, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[406507] = {id = 406507, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[406508] = {id = 406508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"410"}
}
, 
[406601] = {id = 406601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[406602] = {id = 406602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[406603] = {id = 406603, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[406604] = {id = 406604, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[406605] = {id = 406605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[406606] = {id = 406606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[406607] = {id = 406607, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[406608] = {id = 406608, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[406701] = {id = 406701, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[406702] = {id = 406702, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[406703] = {id = 406703, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[406704] = {id = 406704, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[406705] = {id = 406705, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[406706] = {id = 406706, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[406707] = {id = 406707, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[406708] = {id = 406708, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[406801] = {id = 406801, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"24"}
}
, 
[406802] = {id = 406802, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"459"}
}
, 
[406803] = {id = 406803, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"24"}
}
, 
[406804] = {id = 406804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"91"}
}
, 
[406805] = {id = 406805, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"97"}
}
, 
[406806] = {id = 406806, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1836"}
}
, 
[406807] = {id = 406807, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"97"}
}
, 
[406808] = {id = 406808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"367"}
}
, 
[406901] = {id = 406901, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"27"}
}
, 
[406902] = {id = 406902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"27"}
}
, 
[406903] = {id = 406903, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"513"}
}
, 
[406904] = {id = 406904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[406905] = {id = 406905, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"108"}
}
, 
[406906] = {id = 406906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"108"}
}
, 
[406907] = {id = 406907, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2052"}
}
, 
[406908] = {id = 406908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"615"}
}
, 
[407001] = {id = 407001, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[407002] = {id = 407002, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[407003] = {id = 407003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[407004] = {id = 407004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[407005] = {id = 407005, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[407006] = {id = 407006, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[407007] = {id = 407007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[407008] = {id = 407008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[407101] = {id = 407101, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[407102] = {id = 407102, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[407103] = {id = 407103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[407104] = {id = 407104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[407105] = {id = 407105, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[407106] = {id = 407106, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[407107] = {id = 407107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[407108] = {id = 407108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[407201] = {id = 407201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[407202] = {id = 407202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[407203] = {id = 407203, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[407204] = {id = 407204, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[407205] = {id = 407205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[407206] = {id = 407206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[407207] = {id = 407207, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[407208] = {id = 407208, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[407301] = {id = 407301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[407302] = {id = 407302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[407303] = {id = 407303, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[407304] = {id = 407304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[407305] = {id = 407305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[407306] = {id = 407306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[407307] = {id = 407307, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[407308] = {id = 407308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[407401] = {id = 407401, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"32"}
}
, 
[407402] = {id = 407402, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"32"}
}
, 
[407403] = {id = 407403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"680"}
}
, 
[407404] = {id = 407404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"137"}
}
, 
[407405] = {id = 407405, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"129"}
}
, 
[407406] = {id = 407406, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"129"}
}
, 
[407407] = {id = 407407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2721"}
}
, 
[407408] = {id = 407408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"550"}
}
, 
[407501] = {id = 407501, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"30"}
}
, 
[407502] = {id = 407502, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"30"}
}
, 
[407503] = {id = 407503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"642"}
}
, 
[407504] = {id = 407504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"130"}
}
, 
[407505] = {id = 407505, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"122"}
}
, 
[407506] = {id = 407506, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"122"}
}
, 
[407507] = {id = 407507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2570"}
}
, 
[407508] = {id = 407508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"520"}
}
, 
[407601] = {id = 407601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[407602] = {id = 407602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[407603] = {id = 407603, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[407604] = {id = 407604, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[407605] = {id = 407605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[407606] = {id = 407606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[407607] = {id = 407607, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[407608] = {id = 407608, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[407801] = {id = 407801, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"30"}
}
, 
[407802] = {id = 407802, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"30"}
}
, 
[407803] = {id = 407803, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"642"}
}
, 
[407804] = {id = 407804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"130"}
}
, 
[407805] = {id = 407805, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"122"}
}
, 
[407806] = {id = 407806, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"122"}
}
, 
[407807] = {id = 407807, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2570"}
}
, 
[407808] = {id = 407808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"520"}
}
, 
[407901] = {id = 407901, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"72"}
}
, 
[407902] = {id = 407902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"72"}
}
, 
[407903] = {id = 407903, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"72"}
}
, 
[407904] = {id = 407904, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1080"}
}
, 
[407905] = {id = 407905, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"288"}
}
, 
[407906] = {id = 407906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"288"}
}
, 
[407907] = {id = 407907, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"288"}
}
, 
[407908] = {id = 407908, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"4320"}
}
, 
[408001] = {id = 408001, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[408002] = {id = 408002, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[408003] = {id = 408003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[408004] = {id = 408004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[408005] = {id = 408005, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[408006] = {id = 408006, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[408007] = {id = 408007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[408008] = {id = 408008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[408101] = {id = 408101, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[408102] = {id = 408102, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[408103] = {id = 408103, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[408104] = {id = 408104, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[408105] = {id = 408105, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[408106] = {id = 408106, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[408107] = {id = 408107, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[408108] = {id = 408108, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[408201] = {id = 408201, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[408202] = {id = 408202, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[408203] = {id = 408203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[408204] = {id = 408204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[408205] = {id = 408205, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[408206] = {id = 408206, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[408207] = {id = 408207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[408208] = {id = 408208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[408301] = {id = 408301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[408302] = {id = 408302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[408303] = {id = 408303, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[408304] = {id = 408304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[408305] = {id = 408305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[408306] = {id = 408306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[408307] = {id = 408307, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[408308] = {id = 408308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[408401] = {id = 408401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"21"}
}
, 
[408402] = {id = 408402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"21"}
}
, 
[408403] = {id = 408403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"432"}
}
, 
[408404] = {id = 408404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"180"}
}
, 
[408405] = {id = 408405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"86"}
}
, 
[408406] = {id = 408406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"86"}
}
, 
[408407] = {id = 408407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1728"}
}
, 
[408408] = {id = 408408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"720"}
}
, 
[408501] = {id = 408501, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[408502] = {id = 408502, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[408503] = {id = 408503, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[408504] = {id = 408504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[408505] = {id = 408505, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[408506] = {id = 408506, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[408507] = {id = 408507, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[408508] = {id = 408508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[408601] = {id = 408601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"20"}
}
, 
[408602] = {id = 408602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"20"}
}
, 
[408603] = {id = 408603, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"410"}
}
, 
[408604] = {id = 408604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"171"}
}
, 
[408605] = {id = 408605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"81"}
}
, 
[408606] = {id = 408606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"81"}
}
, 
[408607] = {id = 408607, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1641"}
}
, 
[408608] = {id = 408608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"684"}
}
, 
[408801] = {id = 408801, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[408802] = {id = 408802, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[408803] = {id = 408803, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[408804] = {id = 408804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[408805] = {id = 408805, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[408806] = {id = 408806, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[408807] = {id = 408807, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[408808] = {id = 408808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[408901] = {id = 408901, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[408902] = {id = 408902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[408903] = {id = 408903, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[408904] = {id = 408904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[408905] = {id = 408905, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[408906] = {id = 408906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[408907] = {id = 408907, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[408908] = {id = 408908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[409001] = {id = 409001, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"34"}
}
, 
[409002] = {id = 409002, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"34"}
}
, 
[409003] = {id = 409003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"718"}
}
, 
[409004] = {id = 409004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"145"}
}
, 
[409005] = {id = 409005, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"136"}
}
, 
[409006] = {id = 409006, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"136"}
}
, 
[409007] = {id = 409007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2872"}
}
, 
[409008] = {id = 409008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"580"}
}
, 
[409101] = {id = 409101, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[409102] = {id = 409102, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[409103] = {id = 409103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[409104] = {id = 409104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[409105] = {id = 409105, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[409106] = {id = 409106, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[409107] = {id = 409107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[409108] = {id = 409108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[409201] = {id = 409201, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[409202] = {id = 409202, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[409203] = {id = 409203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[409204] = {id = 409204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[409205] = {id = 409205, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[409206] = {id = 409206, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[409207] = {id = 409207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[409208] = {id = 409208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[409301] = {id = 409301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[409302] = {id = 409302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[409303] = {id = 409303, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[409304] = {id = 409304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[409305] = {id = 409305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[409306] = {id = 409306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[409307] = {id = 409307, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[409308] = {id = 409308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[409401] = {id = 409401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[409402] = {id = 409402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[409403] = {id = 409403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[409404] = {id = 409404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[409405] = {id = 409405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[409406] = {id = 409406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[409407] = {id = 409407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[409408] = {id = 409408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[409501] = {id = 409501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[409502] = {id = 409502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[409503] = {id = 409503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[409504] = {id = 409504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[409505] = {id = 409505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[409506] = {id = 409506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[409507] = {id = 409507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[409508] = {id = 409508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[409701] = {id = 409701, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[409702] = {id = 409702, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[409703] = {id = 409703, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[409704] = {id = 409704, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[409705] = {id = 409705, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[409706] = {id = 409706, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[409707] = {id = 409707, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[409708] = {id = 409708, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[409801] = {id = 409801, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[409802] = {id = 409802, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[409803] = {id = 409803, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[409804] = {id = 409804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[409805] = {id = 409805, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[409806] = {id = 409806, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[409807] = {id = 409807, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[409808] = {id = 409808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[409901] = {id = 409901, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[409902] = {id = 409902, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[409903] = {id = 409903, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[409904] = {id = 409904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[409905] = {id = 409905, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[409906] = {id = 409906, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[409907] = {id = 409907, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[409908] = {id = 409908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[410001] = {id = 410001, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410002] = {id = 410002, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410003] = {id = 410003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410004] = {id = 410004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[410005] = {id = 410005, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410006] = {id = 410006, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410007] = {id = 410007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410008] = {id = 410008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[410101] = {id = 410101, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410102] = {id = 410102, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410103] = {id = 410103, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[410104] = {id = 410104, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410105] = {id = 410105, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410106] = {id = 410106, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410107] = {id = 410107, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[410108] = {id = 410108, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410201] = {id = 410201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410202] = {id = 410202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410203] = {id = 410203, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[410204] = {id = 410204, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410205] = {id = 410205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410206] = {id = 410206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410207] = {id = 410207, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[410208] = {id = 410208, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410301] = {id = 410301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[410302] = {id = 410302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[410303] = {id = 410303, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[410304] = {id = 410304, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[410305] = {id = 410305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[410306] = {id = 410306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[410307] = {id = 410307, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[410308] = {id = 410308, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[410401] = {id = 410401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410402] = {id = 410402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410403] = {id = 410403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410404] = {id = 410404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[410405] = {id = 410405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410406] = {id = 410406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410407] = {id = 410407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410408] = {id = 410408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[410501] = {id = 410501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410502] = {id = 410502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410503] = {id = 410503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410504] = {id = 410504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[410505] = {id = 410505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410506] = {id = 410506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410507] = {id = 410507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410508] = {id = 410508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[410601] = {id = 410601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410602] = {id = 410602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410603] = {id = 410603, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410604] = {id = 410604, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[410605] = {id = 410605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410606] = {id = 410606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410607] = {id = 410607, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410608] = {id = 410608, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[410701] = {id = 410701, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[410702] = {id = 410702, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[410703] = {id = 410703, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[410704] = {id = 410704, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[410705] = {id = 410705, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[410706] = {id = 410706, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[410707] = {id = 410707, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[410708] = {id = 410708, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[410801] = {id = 410801, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410802] = {id = 410802, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410803] = {id = 410803, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410804] = {id = 410804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[410805] = {id = 410805, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410806] = {id = 410806, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410807] = {id = 410807, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410808] = {id = 410808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[410901] = {id = 410901, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[410902] = {id = 410902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[410903] = {id = 410903, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[410904] = {id = 410904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[410905] = {id = 410905, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[410906] = {id = 410906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[410907] = {id = 410907, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[410908] = {id = 410908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[411001] = {id = 411001, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[411002] = {id = 411002, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[411003] = {id = 411003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[411004] = {id = 411004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[411005] = {id = 411005, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[411006] = {id = 411006, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[411007] = {id = 411007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[411008] = {id = 411008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[411101] = {id = 411101, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[411102] = {id = 411102, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[411103] = {id = 411103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[411104] = {id = 411104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[411105] = {id = 411105, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[411106] = {id = 411106, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[411107] = {id = 411107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[411108] = {id = 411108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[411201] = {id = 411201, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[411202] = {id = 411202, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[411203] = {id = 411203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[411204] = {id = 411204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[411205] = {id = 411205, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[411206] = {id = 411206, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[411207] = {id = 411207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[411208] = {id = 411208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[411301] = {id = 411301, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[411302] = {id = 411302, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[411303] = {id = 411303, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[411304] = {id = 411304, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[411305] = {id = 411305, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[411306] = {id = 411306, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[411307] = {id = 411307, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[411308] = {id = 411308, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[411501] = {id = 411501, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"21"}
}
, 
[411502] = {id = 411502, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"21"}
}
, 
[411503] = {id = 411503, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"432"}
}
, 
[411504] = {id = 411504, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"180"}
}
, 
[411505] = {id = 411505, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"86"}
}
, 
[411506] = {id = 411506, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"86"}
}
, 
[411507] = {id = 411507, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1728"}
}
, 
[411508] = {id = 411508, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"720"}
}
, 
[411601] = {id = 411601, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"72"}
}
, 
[411602] = {id = 411602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"72"}
}
, 
[411603] = {id = 411603, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"72"}
}
, 
[411604] = {id = 411604, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1080"}
}
, 
[411605] = {id = 411605, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"288"}
}
, 
[411606] = {id = 411606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"288"}
}
, 
[411607] = {id = 411607, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"288"}
}
, 
[411608] = {id = 411608, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"4320"}
}
, 
[411701] = {id = 411701, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[411702] = {id = 411702, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[411703] = {id = 411703, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[411704] = {id = 411704, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[411705] = {id = 411705, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[411706] = {id = 411706, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[411707] = {id = 411707, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[411708] = {id = 411708, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[411801] = {id = 411801, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[411802] = {id = 411802, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[411803] = {id = 411803, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[411804] = {id = 411804, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[411805] = {id = 411805, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[411806] = {id = 411806, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[411807] = {id = 411807, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[411808] = {id = 411808, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[411901] = {id = 411901, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[411902] = {id = 411902, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[411903] = {id = 411903, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[411904] = {id = 411904, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"162"}
}
, 
[411905] = {id = 411905, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[411906] = {id = 411906, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[411907] = {id = 411907, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[411908] = {id = 411908, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"648"}
}
, 
[412001] = {id = 412001, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[412002] = {id = 412002, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[412003] = {id = 412003, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[412004] = {id = 412004, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[412005] = {id = 412005, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[412006] = {id = 412006, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[412007] = {id = 412007, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[412008] = {id = 412008, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[412101] = {id = 412101, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[412102] = {id = 412102, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[412103] = {id = 412103, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[412104] = {id = 412104, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[412105] = {id = 412105, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[412106] = {id = 412106, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[412107] = {id = 412107, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[412108] = {id = 412108, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[412201] = {id = 412201, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[412202] = {id = 412202, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[412203] = {id = 412203, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[412204] = {id = 412204, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[412205] = {id = 412205, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[412206] = {id = 412206, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[412207] = {id = 412207, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[412208] = {id = 412208, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[412301] = {id = 412301, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[412302] = {id = 412302, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[412303] = {id = 412303, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[412304] = {id = 412304, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[412305] = {id = 412305, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[412306] = {id = 412306, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[412307] = {id = 412307, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[412308] = {id = 412308, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[412401] = {id = 412401, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"25"}
}
, 
[412402] = {id = 412402, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"25"}
}
, 
[412403] = {id = 412403, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"486"}
}
, 
[412404] = {id = 412404, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"97"}
}
, 
[412405] = {id = 412405, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"103"}
}
, 
[412406] = {id = 412406, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"103"}
}
, 
[412407] = {id = 412407, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"1944"}
}
, 
[412408] = {id = 412408, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"388"}
}
, 
[412601] = {id = 412601, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"28"}
}
, 
[412602] = {id = 412602, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"28"}
}
, 
[412603] = {id = 412603, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"108"}
}
, 
[412604] = {id = 412604, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"540"}
}
, 
[412605] = {id = 412605, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"115"}
}
, 
[412606] = {id = 412606, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"115"}
}
, 
[412607] = {id = 412607, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"432"}
}
, 
[412608] = {id = 412608, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"2160"}
}
, 
[413001] = {id = 413001, nameTextID = 303040, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"36"}
}
, 
[413002] = {id = 413002, nameTextID = 303039, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"36"}
}
, 
[413003] = {id = 413003, nameTextID = 303037, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"756"}
}
, 
[413004] = {id = 413004, nameTextID = 303038, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"153"}
}
, 
[413005] = {id = 413005, nameTextID = 303044, exDiscribeTextID = 303046, typeTextID = 303094, 
attr = {"144"}
}
, 
[413006] = {id = 413006, nameTextID = 303043, exDiscribeTextID = 303045, typeTextID = 303094, 
attr = {"144"}
}
, 
[413007] = {id = 413007, nameTextID = 303041, exDiscribeTextID = 303048, typeTextID = 303094, 
attr = {"3024"}
}
, 
[413008] = {id = 413008, nameTextID = 303042, exDiscribeTextID = 303047, typeTextID = 303094, 
attr = {"612"}
}
, 
[500101] = {id = 500101, nameTextID = 301141, exDiscribeTextID = 301368, typeTextID = 302931, 
attr = {}
}
, 
[500102] = {id = 500102, nameTextID = 301141, exDiscribeTextID = 301371, typeTextID = 303095, 
attr = {}
}
, 
[500201] = {id = 500201, nameTextID = 301144, exDiscribeTextID = 301570, typeTextID = 303095, 
attr = {}
}
, 
[500202] = {id = 500202, nameTextID = 301144, exDiscribeTextID = 301377, typeTextID = 303095, 
attr = {}
}
, 
[500301] = {id = 500301, nameTextID = 302215, exDiscribeTextID = 303116, typeTextID = 303095, 
attr = {}
}
, 
[500302] = {id = 500302, nameTextID = 302215, exDiscribeTextID = 303117, typeTextID = 303095, 
attr = {}
}
, 
[500401] = {id = 500401, nameTextID = 301147, exDiscribeTextID = 301881, typeTextID = 303095, 
attr = {}
}
, 
[500402] = {id = 500402, nameTextID = 301147, exDiscribeTextID = 301882, typeTextID = 303095, 
attr = {}
}
, 
[500501] = {id = 500501, nameTextID = 301149, exDiscribeTextID = 301260, typeTextID = 303095, 
attr = {}
}
, 
[500504] = {id = 500504, nameTextID = 301149, exDiscribeTextID = 301260, typeTextID = 303095, 
attr = {}
}
, 
[500601] = {id = 500601, nameTextID = 302074, exDiscribeTextID = 302086, typeTextID = 303095, 
attr = {"5"}
}
, 
[500602] = {id = 500602, nameTextID = 302074, exDiscribeTextID = 302086, typeTextID = 303095, 
attr = {"10"}
}
, 
[500603] = {id = 500603, nameTextID = 302076, exDiscribeTextID = 302088, typeTextID = 303095, 
attr = {}
}
, 
[500604] = {id = 500604, nameTextID = 302077, exDiscribeTextID = 302089, typeTextID = 303095, 
attr = {}
}
, 
[500605] = {id = 500605, nameTextID = 302078, exDiscribeTextID = 302090, typeTextID = 303095, 
attr = {}
}
, 
[500606] = {id = 500606, nameTextID = 302079, exDiscribeTextID = 302091, typeTextID = 303095, 
attr = {}
}
, 
[500701] = {id = 500701, nameTextID = 301150, exDiscribeTextID = 301879, typeTextID = 303095, 
attr = {}
}
, 
[500702] = {id = 500702, nameTextID = 301145, exDiscribeTextID = 301861, typeTextID = 303095, 
attr = {}
}
, 
[500703] = {id = 500703, nameTextID = 301146, exDiscribeTextID = 301868, typeTextID = 303095, 
attr = {}
}
, 
[500704] = {id = 500704, nameTextID = 301150, exDiscribeTextID = 301878, typeTextID = 303095, 
attr = {}
}
, 
[500705] = {id = 500705, nameTextID = 301145, exDiscribeTextID = 301860, typeTextID = 303095, 
attr = {}
}
, 
[500706] = {id = 500706, nameTextID = 301146, exDiscribeTextID = 301866, typeTextID = 303095, 
attr = {}
}
, 
[500801] = {id = 500801, nameTextID = 301152, exDiscribeTextID = 303020, typeTextID = 303095, 
attr = {}
}
, 
[500802] = {id = 500802, nameTextID = 301152, exDiscribeTextID = 303021, typeTextID = 303095, 
attr = {}
}
, 
[500901] = {id = 500901, nameTextID = 301154, exDiscribeTextID = 301881, typeTextID = 303095, 
attr = {}
}
, 
[500902] = {id = 500902, nameTextID = 301154, exDiscribeTextID = 301882, typeTextID = 303095, 
attr = {}
}
, 
[501001] = {id = 501001, nameTextID = 301157, exDiscribeTextID = 301597, typeTextID = 303095, 
attr = {}
}
, 
[501002] = {id = 501002, nameTextID = 301157, exDiscribeTextID = 301413, typeTextID = 303095, 
attr = {}
}
, 
[501101] = {id = 501101, nameTextID = 301158, exDiscribeTextID = 301417, typeTextID = 303095, 
attr = {}
}
, 
[501102] = {id = 501102, nameTextID = 301158, exDiscribeTextID = 301602, typeTextID = 303095, 
attr = {}
}
, 
[501201] = {id = 501201, nameTextID = 303024, exDiscribeTextID = 303022, typeTextID = 303095, 
attr = {}
}
, 
[501202] = {id = 501202, nameTextID = 303024, exDiscribeTextID = 303023, typeTextID = 303095, 
attr = {}
}
, 
[501301] = {id = 501301, nameTextID = 301161, exDiscribeTextID = 303118, typeTextID = 303095, 
attr = {}
}
, 
[501302] = {id = 501302, nameTextID = 301161, exDiscribeTextID = 303119, typeTextID = 303095, 
attr = {}
}
, 
[501401] = {id = 501401, nameTextID = 301164, exDiscribeTextID = 301426, typeTextID = 303095, 
attr = {}
}
, 
[501402] = {id = 501402, nameTextID = 301164, exDiscribeTextID = 301429, typeTextID = 303095, 
attr = {}
}
, 
[501501] = {id = 501501, nameTextID = 301165, exDiscribeTextID = 301432, typeTextID = 303095, 
attr = {}
}
, 
[501502] = {id = 501502, nameTextID = 301165, exDiscribeTextID = 301435, typeTextID = 303095, 
attr = {}
}
, 
[501601] = {id = 501601, nameTextID = 303120, exDiscribeTextID = 303121, typeTextID = 303095, 
attr = {}
}
, 
[501602] = {id = 501602, nameTextID = 303120, exDiscribeTextID = 303122, typeTextID = 303095, 
attr = {}
}
, 
[501701] = {id = 501701, nameTextID = 301167, exDiscribeTextID = 303123, typeTextID = 303095, 
attr = {}
}
, 
[501702] = {id = 501702, nameTextID = 301167, exDiscribeTextID = 303124, typeTextID = 303095, 
attr = {}
}
, 
[501801] = {id = 501801, nameTextID = 301170, exDiscribeTextID = 301622, typeTextID = 303095, 
attr = {}
}
, 
[501802] = {id = 501802, nameTextID = 301170, exDiscribeTextID = 301450, typeTextID = 303095, 
attr = {}
}
, 
[501901] = {id = 501901, nameTextID = 301173, exDiscribeTextID = 303025, typeTextID = 303095, 
attr = {}
}
, 
[501902] = {id = 501902, nameTextID = 301173, exDiscribeTextID = 303026, typeTextID = 303095, 
attr = {}
}
, 
[502001] = {id = 502001, nameTextID = 301150, exDiscribeTextID = 301879, typeTextID = 303095, 
attr = {}
}
, 
[502002] = {id = 502002, nameTextID = 301145, exDiscribeTextID = 301861, typeTextID = 303095, 
attr = {}
}
, 
[502003] = {id = 502003, nameTextID = 301146, exDiscribeTextID = 301868, typeTextID = 303095, 
attr = {}
}
, 
[502004] = {id = 502004, nameTextID = 301150, exDiscribeTextID = 301878, typeTextID = 303095, 
attr = {}
}
, 
[502005] = {id = 502005, nameTextID = 301145, exDiscribeTextID = 301860, typeTextID = 303095, 
attr = {}
}
, 
[502006] = {id = 502006, nameTextID = 301146, exDiscribeTextID = 301866, typeTextID = 303095, 
attr = {}
}
, 
[502101] = {id = 502101, nameTextID = 301174, exDiscribeTextID = 301462, typeTextID = 303095, 
attr = {}
}
, 
[502102] = {id = 502102, nameTextID = 301143, exDiscribeTextID = 301855, typeTextID = 303095, 
attr = {}
}
, 
[502103] = {id = 502103, nameTextID = 301146, exDiscribeTextID = 301868, typeTextID = 303095, 
attr = {}
}
, 
[502104] = {id = 502104, nameTextID = 301174, exDiscribeTextID = 301464, typeTextID = 303095, 
attr = {}
}
, 
[502105] = {id = 502105, nameTextID = 301143, exDiscribeTextID = 301854, typeTextID = 303095, 
attr = {}
}
, 
[502106] = {id = 502106, nameTextID = 301146, exDiscribeTextID = 301866, typeTextID = 303095, 
attr = {}
}
, 
[502201] = {id = 502201, nameTextID = 301175, exDiscribeTextID = 303160, typeTextID = 303095, 
attr = {}
}
, 
[502202] = {id = 502202, nameTextID = 301175, exDiscribeTextID = 303161, typeTextID = 303095, 
attr = {}
}
, 
[502301] = {id = 502301, nameTextID = 303228, exDiscribeTextID = 303226, typeTextID = 303095, 
attr = {}
}
, 
[502302] = {id = 502302, nameTextID = 303228, exDiscribeTextID = 303227, typeTextID = 303095, 
attr = {}
}
, 
[502401] = {id = 502401, nameTextID = 301178, exDiscribeTextID = 301478, typeTextID = 303095, 
attr = {}
}
, 
[502402] = {id = 502402, nameTextID = 301178, exDiscribeTextID = 301479, typeTextID = 303095, 
attr = {}
}
, 
[502501] = {id = 502501, nameTextID = 303239, exDiscribeTextID = 303240, typeTextID = 303095, 
attr = {}
}
, 
[502502] = {id = 502502, nameTextID = 303239, exDiscribeTextID = 303241, typeTextID = 303095, 
attr = {}
}
, 
[502601] = {id = 502601, nameTextID = 301180, exDiscribeTextID = 301482, typeTextID = 303095, 
attr = {}
}
, 
[502602] = {id = 502602, nameTextID = 301146, exDiscribeTextID = 301867, typeTextID = 303095, 
attr = {}
}
, 
[502603] = {id = 502603, nameTextID = 301145, exDiscribeTextID = 301862, typeTextID = 303095, 
attr = {}
}
, 
[502604] = {id = 502604, nameTextID = 301180, exDiscribeTextID = 301484, typeTextID = 303095, 
attr = {}
}
, 
[502605] = {id = 502605, nameTextID = 301146, exDiscribeTextID = 301866, typeTextID = 303095, 
attr = {}
}
, 
[502606] = {id = 502606, nameTextID = 301145, exDiscribeTextID = 301860, typeTextID = 303095, 
attr = {}
}
, 
[502701] = {id = 502701, nameTextID = 301181, exDiscribeTextID = 301648, typeTextID = 303095, 
attr = {}
}
, 
[502702] = {id = 502702, nameTextID = 301181, exDiscribeTextID = 301488, typeTextID = 303095, 
attr = {}
}
, 
[502801] = {id = 502801, nameTextID = 301182, exDiscribeTextID = 301490, typeTextID = 303095, 
attr = {}
}
, 
[502802] = {id = 502802, nameTextID = 301182, exDiscribeTextID = 301492, typeTextID = 303095, 
attr = {}
}
, 
[502901] = {id = 502901, nameTextID = 301185, exDiscribeTextID = 303142, typeTextID = 303095, 
attr = {}
}
, 
[502902] = {id = 502902, nameTextID = 301185, exDiscribeTextID = 303143, typeTextID = 303095, 
attr = {}
}
, 
[503001] = {id = 503001, nameTextID = 301188, exDiscribeTextID = 301499, typeTextID = 303095, 
attr = {}
}
, 
[503002] = {id = 503002, nameTextID = 301188, exDiscribeTextID = 301501, typeTextID = 303095, 
attr = {}
}
, 
[503201] = {id = 503201, nameTextID = 301190, exDiscribeTextID = 301655, typeTextID = 303095, 
attr = {}
}
, 
[503202] = {id = 503202, nameTextID = 301190, exDiscribeTextID = 301504, typeTextID = 303095, 
attr = {}
}
, 
[503301] = {id = 503301, nameTextID = 301192, exDiscribeTextID = 301658, typeTextID = 303095, 
attr = {}
}
, 
[503302] = {id = 503302, nameTextID = 301192, exDiscribeTextID = 301509, typeTextID = 303095, 
attr = {}
}
, 
[503401] = {id = 503401, nameTextID = 301195, exDiscribeTextID = 302004, typeTextID = 303095, 
attr = {}
}
, 
[503402] = {id = 503402, nameTextID = 301195, exDiscribeTextID = 302003, typeTextID = 303095, 
attr = {}
}
, 
[503501] = {id = 503501, nameTextID = 301197, exDiscribeTextID = 301922, typeTextID = 303095, 
attr = {}
}
, 
[503502] = {id = 503502, nameTextID = 301197, exDiscribeTextID = 301925, typeTextID = 303095, 
attr = {}
}
, 
[503601] = {id = 503601, nameTextID = 303027, exDiscribeTextID = 303028, typeTextID = 303095, 
attr = {}
}
, 
[503602] = {id = 503602, nameTextID = 303027, exDiscribeTextID = 303029, typeTextID = 303095, 
attr = {}
}
, 
[503801] = {id = 503801, nameTextID = 303174, exDiscribeTextID = 303175, typeTextID = 303095, 
attr = {}
}
, 
[503802] = {id = 503802, nameTextID = 303174, exDiscribeTextID = 303176, typeTextID = 303095, 
attr = {}
}
, 
[503901] = {id = 503901, nameTextID = 301145, exDiscribeTextID = 301863, typeTextID = 303095, 
attr = {}
}
, 
[503902] = {id = 503902, nameTextID = 301143, exDiscribeTextID = 301855, typeTextID = 303095, 
attr = {}
}
, 
[503903] = {id = 503903, nameTextID = 301146, exDiscribeTextID = 301868, typeTextID = 303095, 
attr = {}
}
, 
[503904] = {id = 503904, nameTextID = 301145, exDiscribeTextID = 301860, typeTextID = 303095, 
attr = {}
}
, 
[503905] = {id = 503905, nameTextID = 301143, exDiscribeTextID = 301854, typeTextID = 303095, 
attr = {}
}
, 
[503906] = {id = 503906, nameTextID = 301146, exDiscribeTextID = 301866, typeTextID = 303095, 
attr = {}
}
, 
[503907] = {id = 503907, nameTextID = 303467, exDiscribeTextID = 303468, typeTextID = 303095, 
attr = {"3", "50"}
}
, 
[503908] = {id = 503908, nameTextID = 303467, exDiscribeTextID = 303468, typeTextID = 303095, 
attr = {"5", "100"}
}
, 
[504101] = {id = 504101, nameTextID = 301208, exDiscribeTextID = 301935, typeTextID = 303095, 
attr = {}
}
, 
[504102] = {id = 504102, nameTextID = 301208, exDiscribeTextID = 301937, typeTextID = 303095, 
attr = {}
}
, 
[504201] = {id = 504201, nameTextID = 301209, exDiscribeTextID = 303166, typeTextID = 303095, 
attr = {}
}
, 
[504202] = {id = 504202, nameTextID = 301209, exDiscribeTextID = 303167, typeTextID = 303095, 
attr = {}
}
, 
[504301] = {id = 504301, nameTextID = 301211, exDiscribeTextID = 301663, typeTextID = 303095, 
attr = {}
}
, 
[504302] = {id = 504302, nameTextID = 301211, exDiscribeTextID = 301528, typeTextID = 303095, 
attr = {}
}
, 
[504401] = {id = 504401, nameTextID = 301145, exDiscribeTextID = 301862, typeTextID = 303095, 
attr = {}
}
, 
[504402] = {id = 504402, nameTextID = 301150, exDiscribeTextID = 301946, typeTextID = 303095, 
attr = {}
}
, 
[504403] = {id = 504403, nameTextID = 301202, exDiscribeTextID = 301874, typeTextID = 303095, 
attr = {}
}
, 
[504404] = {id = 504404, nameTextID = 301145, exDiscribeTextID = 301860, typeTextID = 303095, 
attr = {}
}
, 
[504405] = {id = 504405, nameTextID = 301150, exDiscribeTextID = 301878, typeTextID = 303095, 
attr = {}
}
, 
[504406] = {id = 504406, nameTextID = 301148, exDiscribeTextID = 301872, typeTextID = 303095, 
attr = {}
}
, 
[504501] = {id = 504501, nameTextID = 303236, exDiscribeTextID = 303237, typeTextID = 303095, 
attr = {}
}
, 
[504502] = {id = 504502, nameTextID = 303236, exDiscribeTextID = 303238, typeTextID = 303095, 
attr = {}
}
, 
[504505] = {id = 504505, nameTextID = 301145, exDiscribeTextID = 301860, typeTextID = 303095, 
attr = {}
}
, 
[504506] = {id = 504506, nameTextID = 301143, exDiscribeTextID = 301854, typeTextID = 303095, 
attr = {}
}
, 
[504701] = {id = 504701, nameTextID = 301215, exDiscribeTextID = 303125, typeTextID = 303095, 
attr = {}
}
, 
[504702] = {id = 504702, nameTextID = 301215, exDiscribeTextID = 303126, typeTextID = 303095, 
attr = {}
}
, 
[504801] = {id = 504801, nameTextID = 301216, exDiscribeTextID = 301669, typeTextID = 303095, 
attr = {}
}
, 
[504802] = {id = 504802, nameTextID = 301216, exDiscribeTextID = 301536, typeTextID = 303095, 
attr = {}
}
, 
[504901] = {id = 504901, nameTextID = 303030, exDiscribeTextID = 303031, typeTextID = 303095, 
attr = {}
}
, 
[504902] = {id = 504902, nameTextID = 303030, exDiscribeTextID = 303032, typeTextID = 303095, 
attr = {}
}
, 
[505001] = {id = 505001, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505002] = {id = 505002, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505003] = {id = 505003, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505004] = {id = 505004, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505005] = {id = 505005, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505006] = {id = 505006, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505007] = {id = 505007, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505101] = {id = 505101, nameTextID = 301220, exDiscribeTextID = 301916, typeTextID = 303095, 
attr = {}
}
, 
[505102] = {id = 505102, nameTextID = 301220, exDiscribeTextID = 301913, typeTextID = 303095, 
attr = {}
}
, 
[505201] = {id = 505201, nameTextID = 301223, exDiscribeTextID = 301949, typeTextID = 303095, 
attr = {}
}
, 
[505202] = {id = 505202, nameTextID = 301223, exDiscribeTextID = 301948, typeTextID = 303095, 
attr = {}
}
, 
[505301] = {id = 505301, nameTextID = 301224, exDiscribeTextID = 303289, typeTextID = 303095, 
attr = {}
}
, 
[505302] = {id = 505302, nameTextID = 301224, exDiscribeTextID = 303290, typeTextID = 303095, 
attr = {}
}
, 
[505401] = {id = 505401, nameTextID = 301227, exDiscribeTextID = 301553, typeTextID = 303095, 
attr = {}
}
, 
[505402] = {id = 505402, nameTextID = 301228, exDiscribeTextID = 301952, typeTextID = 303095, 
attr = {}
}
, 
[505403] = {id = 505403, nameTextID = 301143, exDiscribeTextID = 301856, typeTextID = 303095, 
attr = {}
}
, 
[505404] = {id = 505404, nameTextID = 301227, exDiscribeTextID = 301555, typeTextID = 303095, 
attr = {}
}
, 
[505405] = {id = 505405, nameTextID = 301228, exDiscribeTextID = 301953, typeTextID = 303095, 
attr = {}
}
, 
[505406] = {id = 505406, nameTextID = 301143, exDiscribeTextID = 301854, typeTextID = 303095, 
attr = {}
}
, 
[505501] = {id = 505501, nameTextID = 303127, exDiscribeTextID = 303128, typeTextID = 303095, 
attr = {}
}
, 
[505502] = {id = 505502, nameTextID = 303127, exDiscribeTextID = 303129, typeTextID = 303095, 
attr = {}
}
, 
[505601] = {id = 505601, nameTextID = 301231, exDiscribeTextID = 303033, typeTextID = 303095, 
attr = {}
}
, 
[505602] = {id = 505602, nameTextID = 301231, exDiscribeTextID = 303034, typeTextID = 303095, 
attr = {}
}
, 
[505701] = {id = 505701, nameTextID = 302122, exDiscribeTextID = 302390, typeTextID = 303095, 
attr = {}
}
, 
[505702] = {id = 505702, nameTextID = 302125, exDiscribeTextID = 302131, typeTextID = 303095, 
attr = {}
}
, 
[505801] = {id = 505801, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505802] = {id = 505802, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505803] = {id = 505803, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505804] = {id = 505804, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505805] = {id = 505805, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505806] = {id = 505806, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505807] = {id = 505807, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[505901] = {id = 505901, nameTextID = 301232, exDiscribeTextID = 301890, typeTextID = 303095, 
attr = {}
}
, 
[505902] = {id = 505902, nameTextID = 301232, exDiscribeTextID = 301892, typeTextID = 303095, 
attr = {}
}
, 
[506001] = {id = 506001, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506002] = {id = 506002, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506003] = {id = 506003, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506004] = {id = 506004, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506005] = {id = 506005, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506006] = {id = 506006, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506007] = {id = 506007, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506101] = {id = 506101, nameTextID = 302262, exDiscribeTextID = 302264, typeTextID = 303095, 
attr = {}
}
, 
[506102] = {id = 506102, nameTextID = 302262, exDiscribeTextID = 302265, typeTextID = 303095, 
attr = {}
}
, 
[506201] = {id = 506201, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506202] = {id = 506202, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506203] = {id = 506203, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506204] = {id = 506204, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506205] = {id = 506205, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506206] = {id = 506206, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506207] = {id = 506207, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506301] = {id = 506301, nameTextID = 302915, exDiscribeTextID = 303168, typeTextID = 303095, 
attr = {}
}
, 
[506302] = {id = 506302, nameTextID = 302915, exDiscribeTextID = 303169, typeTextID = 303095, 
attr = {}
}
, 
[506401] = {id = 506401, nameTextID = 302340, exDiscribeTextID = 302341, typeTextID = 303095, 
attr = {}
}
, 
[506402] = {id = 506402, nameTextID = 302340, exDiscribeTextID = 302343, typeTextID = 303095, 
attr = {}
}
, 
[506403] = {id = 506403, nameTextID = 302295, exDiscribeTextID = 302298, typeTextID = 303095, 
attr = {}
}
, 
[506404] = {id = 506404, nameTextID = 302296, exDiscribeTextID = 302299, typeTextID = 303095, 
attr = {}
}
, 
[506405] = {id = 506405, nameTextID = 302295, exDiscribeTextID = 302301, typeTextID = 303095, 
attr = {}
}
, 
[506406] = {id = 506406, nameTextID = 302296, exDiscribeTextID = 302302, typeTextID = 303095, 
attr = {}
}
, 
[506407] = {id = 506407, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506501] = {id = 506501, nameTextID = 301234, exDiscribeTextID = 301561, typeTextID = 303095, 
attr = {}
}
, 
[506502] = {id = 506502, nameTextID = 301234, exDiscribeTextID = 301563, typeTextID = 303095, 
attr = {}
}
, 
[506601] = {id = 506601, nameTextID = 303445, exDiscribeTextID = 303446, typeTextID = 303095, 
attr = {}
}
, 
[506602] = {id = 506602, nameTextID = 303445, exDiscribeTextID = 303447, typeTextID = 303095, 
attr = {"60"}
}
, 
[506603] = {id = 506603, nameTextID = 302296, exDiscribeTextID = 302299, typeTextID = 303095, 
attr = {}
}
, 
[506604] = {id = 506604, nameTextID = 302294, exDiscribeTextID = 302300, typeTextID = 303095, 
attr = {}
}
, 
[506605] = {id = 506605, nameTextID = 302295, exDiscribeTextID = 302301, typeTextID = 303095, 
attr = {}
}
, 
[506606] = {id = 506606, nameTextID = 302296, exDiscribeTextID = 302302, typeTextID = 303095, 
attr = {}
}
, 
[506607] = {id = 506607, nameTextID = 301219, exDiscribeTextID = 301219, typeTextID = 303095, 
attr = {}
}
, 
[506701] = {id = 506701, nameTextID = 303439, exDiscribeTextID = 303440, typeTextID = 303095, 
attr = {"15", "20"}
}
, 
[506702] = {id = 506702, nameTextID = 303439, exDiscribeTextID = 303440, typeTextID = 303095, 
attr = {"30", "40"}
}
, 
[506703] = {id = 506703, nameTextID = 301145, exDiscribeTextID = 301862, typeTextID = 303095, 
attr = {}
}
, 
[506704] = {id = 506704, nameTextID = 302722, exDiscribeTextID = 302725, typeTextID = 303095, 
attr = {}
}
, 
[506705] = {id = 506705, nameTextID = 301143, exDiscribeTextID = 301854, typeTextID = 303095, 
attr = {}
}
, 
[506706] = {id = 506706, nameTextID = 301145, exDiscribeTextID = 301860, typeTextID = 303095, 
attr = {}
}
, 
[506801] = {id = 506801, nameTextID = 302731, exDiscribeTextID = 302736, typeTextID = 303095, 
attr = {}
}
, 
[506802] = {id = 506802, nameTextID = 302732, exDiscribeTextID = 302734, typeTextID = 303095, 
attr = {}
}
, 
[506803] = {id = 506803, nameTextID = 302733, exDiscribeTextID = 302735, typeTextID = 303095, 
attr = {}
}
, 
[506804] = {id = 506804, nameTextID = 302731, exDiscribeTextID = 302739, typeTextID = 303095, 
attr = {}
}
, 
[506805] = {id = 506805, nameTextID = 302732, exDiscribeTextID = 302737, typeTextID = 303095, 
attr = {}
}
, 
[506806] = {id = 506806, nameTextID = 302733, exDiscribeTextID = 302738, typeTextID = 303095, 
attr = {}
}
, 
[506901] = {id = 506901, nameTextID = 301236, exDiscribeTextID = 301886, typeTextID = 303095, 
attr = {}
}
, 
[506902] = {id = 506902, nameTextID = 301236, exDiscribeTextID = 301888, typeTextID = 303095, 
attr = {}
}
, 
[507001] = {id = 507001, nameTextID = 302359, exDiscribeTextID = 303035, typeTextID = 303095, 
attr = {}
}
, 
[507002] = {id = 507002, nameTextID = 302359, exDiscribeTextID = 303036, typeTextID = 303095, 
attr = {}
}
, 
[507101] = {id = 507101, nameTextID = 303266, exDiscribeTextID = 303267, typeTextID = 303095, 
attr = {}
}
, 
[507102] = {id = 507102, nameTextID = 303266, exDiscribeTextID = 303268, typeTextID = 303095, 
attr = {}
}
, 
[507201] = {id = 507201, nameTextID = 303233, exDiscribeTextID = 303234, typeTextID = 303095, 
attr = {}
}
, 
[507202] = {id = 507202, nameTextID = 303233, exDiscribeTextID = 303235, typeTextID = 303095, 
attr = {}
}
, 
[507301] = {id = 507301, nameTextID = 302321, exDiscribeTextID = 302326, typeTextID = 303095, 
attr = {}
}
, 
[507302] = {id = 507302, nameTextID = 302321, exDiscribeTextID = 302325, typeTextID = 303095, 
attr = {}
}
, 
[507401] = {id = 507401, nameTextID = 303130, exDiscribeTextID = 303131, typeTextID = 303095, 
attr = {}
}
, 
[507402] = {id = 507402, nameTextID = 303130, exDiscribeTextID = 303132, typeTextID = 303095, 
attr = {}
}
, 
[507501] = {id = 507501, nameTextID = 303133, exDiscribeTextID = 303134, typeTextID = 303095, 
attr = {}
}
, 
[507502] = {id = 507502, nameTextID = 303133, exDiscribeTextID = 303135, typeTextID = 303095, 
attr = {}
}
, 
[507601] = {id = 507601, nameTextID = 302211, exDiscribeTextID = 302212, typeTextID = 303095, 
attr = {}
}
, 
[507602] = {id = 507602, nameTextID = 302211, exDiscribeTextID = 302213, typeTextID = 303095, 
attr = {}
}
, 
[507801] = {id = 507801, nameTextID = 303276, exDiscribeTextID = 303277, typeTextID = 303095, 
attr = {}
}
, 
[507802] = {id = 507802, nameTextID = 303276, exDiscribeTextID = 303278, typeTextID = 303095, 
attr = {}
}
, 
[507901] = {id = 507901, nameTextID = 303283, exDiscribeTextID = 303284, typeTextID = 303095, 
attr = {}
}
, 
[507902] = {id = 507902, nameTextID = 303283, exDiscribeTextID = 303285, typeTextID = 303095, 
attr = {}
}
, 
[508001] = {id = 508001, nameTextID = 303400, exDiscribeTextID = 303401, typeTextID = 303095, 
attr = {"50"}
}
, 
[508002] = {id = 508002, nameTextID = 303400, exDiscribeTextID = 303401, typeTextID = 303095, 
attr = {"100"}
}
, 
[508101] = {id = 508101, nameTextID = 303248, exDiscribeTextID = 303249, typeTextID = 303095, 
attr = {"30"}
}
, 
[508102] = {id = 508102, nameTextID = 303248, exDiscribeTextID = 303249, typeTextID = 303095, 
attr = {"50"}
}
, 
[508201] = {id = 508201, nameTextID = 303812, exDiscribeTextID = 303813, typeTextID = 303095, 
attr = {"10"}
}
, 
[508202] = {id = 508202, nameTextID = 303812, exDiscribeTextID = 303813, typeTextID = 303095, 
attr = {"20"}
}
, 
[508301] = {id = 508301, nameTextID = 303350, exDiscribeTextID = 303351, typeTextID = 303095, 
attr = {"30"}
}
, 
[508302] = {id = 508302, nameTextID = 303350, exDiscribeTextID = 303351, typeTextID = 303095, 
attr = {"50"}
}
, 
[508401] = {id = 508401, nameTextID = 303556, exDiscribeTextID = 303557, typeTextID = 303095, 
attr = {"50"}
}
, 
[508402] = {id = 508402, nameTextID = 303556, exDiscribeTextID = 303557, typeTextID = 303095, 
attr = {"100"}
}
, 
[508501] = {id = 508501, nameTextID = 303549, exDiscribeTextID = 303550, typeTextID = 303095, 
attr = {"8", "8"}
}
, 
[508502] = {id = 508502, nameTextID = 303549, exDiscribeTextID = 303550, typeTextID = 303095, 
attr = {"16", "16"}
}
, 
[508601] = {id = 508601, nameTextID = 303452, exDiscribeTextID = 303453, typeTextID = 303095, 
attr = {}
}
, 
[508602] = {id = 508602, nameTextID = 303452, exDiscribeTextID = 303454, typeTextID = 303095, 
attr = {"30"}
}
, 
[508801] = {id = 508801, nameTextID = 303677, exDiscribeTextID = 303678, typeTextID = 303095, 
attr = {"8"}
}
, 
[508802] = {id = 508802, nameTextID = 303677, exDiscribeTextID = 303678, typeTextID = 303095, 
attr = {"4"}
}
, 
[508901] = {id = 508901, nameTextID = 303342, exDiscribeTextID = 303343, typeTextID = 303095, 
attr = {"5", "25"}
}
, 
[508902] = {id = 508902, nameTextID = 303342, exDiscribeTextID = 303343, typeTextID = 303095, 
attr = {"10", "50"}
}
, 
[509001] = {id = 509001, nameTextID = 303344, exDiscribeTextID = 303345, typeTextID = 303095, 
attr = {"20"}
}
, 
[509002] = {id = 509002, nameTextID = 303344, exDiscribeTextID = 303345, typeTextID = 303095, 
attr = {"40"}
}
, 
[509101] = {id = 509101, nameTextID = 303475, exDiscribeTextID = 303476, typeTextID = 303095, 
attr = {"25"}
}
, 
[509102] = {id = 509102, nameTextID = 303475, exDiscribeTextID = 303476, typeTextID = 303095, 
attr = {"50"}
}
, 
[509201] = {id = 509201, nameTextID = 303482, exDiscribeTextID = 303483, typeTextID = 303095, 
attr = {"50"}
}
, 
[509202] = {id = 509202, nameTextID = 303482, exDiscribeTextID = 303483, typeTextID = 303095, 
attr = {"75"}
}
, 
[509301] = {id = 509301, nameTextID = 303833, exDiscribeTextID = 303834, typeTextID = 303095, 
attr = {"50"}
}
, 
[509302] = {id = 509302, nameTextID = 303833, exDiscribeTextID = 303834, typeTextID = 303095, 
attr = {"100"}
}
, 
[509401] = {id = 509401, nameTextID = 303563, exDiscribeTextID = 303564, typeTextID = 303095, 
attr = {"25"}
}
, 
[509402] = {id = 509402, nameTextID = 303563, exDiscribeTextID = 303564, typeTextID = 303095, 
attr = {"50"}
}
, 
[509501] = {id = 509501, nameTextID = 303356, exDiscribeTextID = 303357, typeTextID = 303095, 
attr = {"3"}
}
, 
[509502] = {id = 509502, nameTextID = 303356, exDiscribeTextID = 303357, typeTextID = 303095, 
attr = {"1"}
}
, 
[509701] = {id = 509701, nameTextID = 303585, exDiscribeTextID = 303586, typeTextID = 303095, 
attr = {"25", "25"}
}
, 
[509702] = {id = 509702, nameTextID = 303585, exDiscribeTextID = 303586, typeTextID = 303095, 
attr = {"50", "50"}
}
, 
[509801] = {id = 509801, nameTextID = 303752, exDiscribeTextID = 303753, typeTextID = 303095, 
attr = {"4"}
}
, 
[509802] = {id = 509802, nameTextID = 303752, exDiscribeTextID = 303753, typeTextID = 303095, 
attr = {"2"}
}
, 
[509901] = {id = 509901, nameTextID = 303459, exDiscribeTextID = 303460, typeTextID = 303095, 
attr = {"10"}
}
, 
[509902] = {id = 509902, nameTextID = 303459, exDiscribeTextID = 303460, typeTextID = 303095, 
attr = {"15"}
}
, 
[510001] = {id = 510001, nameTextID = 303408, exDiscribeTextID = 303409, typeTextID = 303095, 
attr = {"1"}
}
, 
[510002] = {id = 510002, nameTextID = 303408, exDiscribeTextID = 303409, typeTextID = 303095, 
attr = {"2"}
}
, 
[510101] = {id = 510101, nameTextID = 303576, exDiscribeTextID = 303577, typeTextID = 303095, 
attr = {"20"}
}
, 
[510102] = {id = 510102, nameTextID = 303576, exDiscribeTextID = 303577, typeTextID = 303095, 
attr = {"10"}
}
, 
[510201] = {id = 510201, nameTextID = 303499, exDiscribeTextID = 303500, typeTextID = 303095, 
attr = {"1"}
}
, 
[510202] = {id = 510202, nameTextID = 303499, exDiscribeTextID = 303500, typeTextID = 303095, 
attr = {"2"}
}
, 
[510301] = {id = 510301, nameTextID = 303491, exDiscribeTextID = 303492, typeTextID = 303095, 
attr = {"5"}
}
, 
[510302] = {id = 510302, nameTextID = 303491, exDiscribeTextID = 303492, typeTextID = 303095, 
attr = {"10"}
}
, 
[510401] = {id = 510401, nameTextID = 303694, exDiscribeTextID = 303695, typeTextID = 303095, 
attr = {"15", "15"}
}
, 
[510402] = {id = 510402, nameTextID = 303694, exDiscribeTextID = 303695, typeTextID = 303095, 
attr = {"30", "30"}
}
, 
[510501] = {id = 510501, nameTextID = 303772, exDiscribeTextID = 303773, typeTextID = 303095, 
attr = {"20"}
}
, 
[510502] = {id = 510502, nameTextID = 303772, exDiscribeTextID = 303773, typeTextID = 303095, 
attr = {"30"}
}
, 
[510601] = {id = 510601, nameTextID = 303414, exDiscribeTextID = 303415, typeTextID = 303095, 
attr = {"4", "5"}
}
, 
[510602] = {id = 510602, nameTextID = 303414, exDiscribeTextID = 303415, typeTextID = 303095, 
attr = {"5", "5"}
}
, 
[510701] = {id = 510701, nameTextID = 303778, exDiscribeTextID = 303779, typeTextID = 303095, 
attr = {"5", "25", "3", "15"}
}
, 
[510702] = {id = 510702, nameTextID = 303778, exDiscribeTextID = 303779, typeTextID = 303095, 
attr = {"10", "50", "6", "30"}
}
, 
[510703] = {id = 510703, nameTextID = 303778, exDiscribeTextID = 303779, typeTextID = 303095, 
attr = {"5", "25", "3", "15"}
}
, 
[510704] = {id = 510704, nameTextID = 303778, exDiscribeTextID = 303779, typeTextID = 303095, 
attr = {"10", "50", "6", "30"}
}
, 
[510801] = {id = 510801, nameTextID = 303373, exDiscribeTextID = 303374, typeTextID = 303095, 
attr = {"10", "30"}
}
, 
[510802] = {id = 510802, nameTextID = 303373, exDiscribeTextID = 303374, typeTextID = 303095, 
attr = {"10", "60"}
}
, 
[510901] = {id = 510901, nameTextID = 303744, exDiscribeTextID = 303745, typeTextID = 303095, 
attr = {"3", "5"}
}
, 
[510902] = {id = 510902, nameTextID = 303744, exDiscribeTextID = 303745, typeTextID = 303095, 
attr = {"6", "10"}
}
, 
[511001] = {id = 511001, nameTextID = 303367, exDiscribeTextID = 303368, typeTextID = 303095, 
attr = {"8"}
}
, 
[511002] = {id = 511002, nameTextID = 303367, exDiscribeTextID = 303368, typeTextID = 303095, 
attr = {"5"}
}
, 
[511101] = {id = 511101, nameTextID = 303716, exDiscribeTextID = 303717, typeTextID = 303095, 
attr = {"15", "15"}
}
, 
[511102] = {id = 511102, nameTextID = 303716, exDiscribeTextID = 303717, typeTextID = 303095, 
attr = {"30", "30"}
}
, 
[511201] = {id = 511201, nameTextID = 303686, exDiscribeTextID = 303687, typeTextID = 303095, 
attr = {"25"}
}
, 
[511202] = {id = 511202, nameTextID = 303686, exDiscribeTextID = 303687, typeTextID = 303095, 
attr = {"50"}
}
, 
[511301] = {id = 511301, nameTextID = 303708, exDiscribeTextID = 303709, typeTextID = 303095, 
attr = {"20", "15"}
}
, 
[511302] = {id = 511302, nameTextID = 303708, exDiscribeTextID = 303709, typeTextID = 303095, 
attr = {"40", "30"}
}
, 
[511501] = {id = 511501, nameTextID = 303737, exDiscribeTextID = 303738, typeTextID = 303095, 
attr = {"8", "5"}
}
, 
[511502] = {id = 511502, nameTextID = 303737, exDiscribeTextID = 303738, typeTextID = 303095, 
attr = {"16", "10"}
}
, 
[511601] = {id = 511601, nameTextID = 303826, exDiscribeTextID = 303827, typeTextID = 303095, 
attr = {"10"}
}
, 
[511602] = {id = 511602, nameTextID = 303826, exDiscribeTextID = 303827, typeTextID = 303095, 
attr = {"20"}
}
, 
[511701] = {id = 511701, nameTextID = 303784, exDiscribeTextID = 303785, typeTextID = 303095, 
attr = {"5"}
}
, 
[511702] = {id = 511702, nameTextID = 303784, exDiscribeTextID = 303785, typeTextID = 303095, 
attr = {"10"}
}
, 
[511801] = {id = 511801, nameTextID = 303840, exDiscribeTextID = 303841, typeTextID = 303095, 
attr = {"2000"}
}
, 
[511802] = {id = 511802, nameTextID = 303840, exDiscribeTextID = 303841, typeTextID = 303095, 
attr = {"4000"}
}
, 
[511901] = {id = 511901, nameTextID = 303759, exDiscribeTextID = 303760, typeTextID = 303095, 
attr = {"4"}
}
, 
[511902] = {id = 511902, nameTextID = 303759, exDiscribeTextID = 303760, typeTextID = 303095, 
attr = {"8"}
}
, 
[512001] = {id = 512001, nameTextID = 303701, exDiscribeTextID = 303702, typeTextID = 303095, 
attr = {"40"}
}
, 
[512002] = {id = 512002, nameTextID = 303701, exDiscribeTextID = 303702, typeTextID = 303095, 
attr = {"80"}
}
, 
[512101] = {id = 512101, nameTextID = 303798, exDiscribeTextID = 303799, typeTextID = 303095, 
attr = {"25"}
}
, 
[512102] = {id = 512102, nameTextID = 303798, exDiscribeTextID = 303799, typeTextID = 303095, 
attr = {"50"}
}
, 
[512201] = {id = 512201, nameTextID = 303791, exDiscribeTextID = 303792, typeTextID = 303095, 
attr = {"15"}
}
, 
[512202] = {id = 512202, nameTextID = 303791, exDiscribeTextID = 303792, typeTextID = 303095, 
attr = {"30"}
}
, 
[512301] = {id = 512301, nameTextID = 303805, exDiscribeTextID = 303806, typeTextID = 303095, 
attr = {"10"}
}
, 
[512302] = {id = 512302, nameTextID = 303805, exDiscribeTextID = 303806, typeTextID = 303095, 
attr = {"20"}
}
, 
[512401] = {id = 512401, nameTextID = 303819, exDiscribeTextID = 303820, typeTextID = 303095, 
attr = {"5", "20"}
}
, 
[512402] = {id = 512402, nameTextID = 303819, exDiscribeTextID = 303820, typeTextID = 303095, 
attr = {"10", "40"}
}
, 
[512601] = {id = 512601, nameTextID = 303847, exDiscribeTextID = 303848, typeTextID = 303095, 
attr = {"30"}
}
, 
[512602] = {id = 512602, nameTextID = 303847, exDiscribeTextID = 303848, typeTextID = 303095, 
attr = {"60"}
}
, 
[513001] = {id = 513001, nameTextID = 303861, exDiscribeTextID = 303862, typeTextID = 303095, 
attr = {"10", "50"}
}
, 
[513002] = {id = 513002, nameTextID = 303861, exDiscribeTextID = 303862, typeTextID = 303095, 
attr = {"20", "100"}
}
}
cskillshow_soul.AllIds = {21, 22, 23, 24, 31, 32, 33, 34, 41, 42, 43, 44, 51, 52, 53, 54, 61, 62, 63, 64, 71, 72, 73, 74, 81, 82, 83, 84, 91, 92, 93, 94, 101, 102, 103, 104, 111, 112, 113, 114, 121, 122, 123, 124, 131, 132, 133, 134, 141, 142, 143, 144, 151, 152, 153, 154, 161, 162, 163, 164, 171, 172, 173, 174, 181, 182, 183, 184, 191, 192, 193, 194, 201, 202, 203, 204, 211, 212, 213, 214, 221, 222, 223, 224, 231, 232, 233, 234, 241, 242, 243, 244, 251, 252, 253, 254, 261, 262, 263, 264, 271, 272, 273, 274, 281, 282, 283, 284, 291, 292, 293, 294, 301, 302, 303, 304, 321, 322, 323, 324, 331, 332, 333, 334, 341, 342, 343, 344, 351, 352, 353, 354, 361, 362, 363, 364, 381, 382, 383, 384, 391, 392, 393, 394, 401, 402, 403, 404, 411, 412, 413, 414, 421, 422, 423, 424, 431, 432, 433, 434, 441, 442, 443, 444, 451, 452, 453, 454, 461, 462, 463, 464, 471, 472, 473, 474, 481, 482, 483, 484, 491, 492, 493, 494, 501, 502, 503, 504, 511, 512, 513, 514, 521, 522, 523, 524, 531, 532, 533, 534, 541, 542, 543, 544, 551, 552, 553, 554, 561, 562, 563, 564, 571, 572, 573, 574, 581, 582, 583, 584, 591, 592, 593, 594, 601, 602, 603, 604, 611, 612, 613, 614, 621, 622, 623, 624, 631, 632, 633, 634, 641, 642, 643, 644, 651, 652, 653, 654, 661, 662, 663, 664, 671, 672, 673, 674, 681, 682, 683, 684, 691, 692, 693, 694, 701, 702, 703, 704, 711, 712, 713, 714, 721, 722, 723, 724, 731, 732, 733, 734, 741, 742, 743, 744, 751, 752, 753, 754, 761, 762, 763, 764, 1021, 1022, 1023, 1024, 300601, 300602, 300603, 300604, 300605, 300606, 300607, 300608, 300609, 300610, 300801, 300802, 300803, 300804, 300805, 300806, 300807, 300808, 300809, 300810, 301001, 301002, 301003, 301004, 301005, 301006, 301007, 301008, 301009, 301010, 301101, 301102, 301103, 301104, 301105, 301106, 301107, 301108, 301109, 301110, 301201, 301202, 301203, 301204, 301205, 301206, 301207, 301208, 301209, 301210, 301301, 301302, 301303, 301304, 301305, 301306, 301307, 301308, 301309, 301310, 301701, 301702, 301703, 301704, 301705, 301706, 301707, 301708, 301709, 301710, 302301, 302302, 302303, 302304, 302305, 302306, 302307, 302308, 302309, 302310, 302501, 302502, 302503, 302504, 302505, 302506, 302507, 302508, 302509, 302510, 302901, 302902, 302903, 302904, 302905, 302906, 302907, 302908, 302909, 302910, 303001, 303002, 303003, 303004, 303005, 303006, 303007, 303008, 303009, 303010, 303301, 303302, 303303, 303304, 303305, 303306, 303307, 303308, 303309, 303310, 303401, 303402, 303403, 303404, 303405, 303406, 303407, 303408, 303409, 303410, 303501, 303502, 303503, 303504, 303505, 303506, 303507, 303508, 303509, 303510, 303801, 303802, 303803, 303804, 303805, 303806, 303807, 303808, 303809, 303810, 303901, 303902, 303903, 303904, 303905, 303906, 303907, 303908, 303909, 303910, 304101, 304102, 304103, 304104, 304105, 304106, 304107, 304108, 304109, 304110, 304201, 304202, 304203, 304204, 304205, 304206, 304207, 304208, 304209, 304210, 304301, 304302, 304303, 304304, 304305, 304306, 304307, 304308, 304309, 304310, 304701, 304702, 304703, 304704, 304705, 304706, 304707, 304708, 304709, 304710, 304801, 304802, 304803, 304804, 304805, 304806, 304807, 304808, 304809, 304810, 305101, 305102, 305103, 305104, 305105, 305106, 305107, 305108, 305109, 305110, 305301, 305302, 305303, 305304, 305305, 305306, 305307, 305308, 305309, 305310, 305501, 305502, 305503, 305504, 305505, 305506, 305507, 305508, 305509, 305510, 305601, 305602, 305603, 305604, 305605, 305606, 305607, 305608, 305609, 305610, 305901, 305902, 305903, 305904, 305905, 305906, 305907, 305908, 305909, 305910, 306301, 306302, 306303, 306304, 306305, 306306, 306307, 306308, 306309, 306310, 306401, 306402, 306403, 306404, 306405, 306406, 306407, 306408, 306409, 306410, 306501, 306502, 306503, 306504, 306505, 306506, 306507, 306508, 306509, 306510, 306601, 306602, 306603, 306604, 306605, 306606, 306607, 306608, 306609, 306610, 306901, 306902, 306903, 306904, 306905, 306906, 306907, 306908, 306909, 306910, 307001, 307002, 307003, 307004, 307005, 307006, 307007, 307008, 307009, 307010, 307101, 307102, 307103, 307104, 307105, 307106, 307107, 307108, 307109, 307110, 307201, 307202, 307203, 307204, 307205, 307206, 307207, 307208, 307209, 307210, 307901, 307902, 307903, 307904, 307905, 307906, 307907, 307908, 307909, 307910, 308001, 308002, 308003, 308004, 308005, 308006, 308007, 308008, 308009, 308010, 308101, 308102, 308103, 308104, 308105, 308106, 308107, 308108, 308109, 308110, 308201, 308202, 308203, 308204, 308205, 308206, 308207, 308208, 308209, 308210, 308301, 308302, 308303, 308304, 308305, 308306, 308307, 308308, 308309, 308310, 308401, 308402, 308403, 308404, 308405, 308406, 308407, 308408, 308409, 308410, 308501, 308502, 308503, 308504, 308505, 308506, 308507, 308508, 308509, 308510, 308801, 308802, 308803, 308804, 308805, 308806, 308807, 308808, 308809, 308810, 308901, 308902, 308903, 308904, 308905, 308906, 308907, 308908, 308909, 308910, 309001, 309002, 309003, 309004, 309005, 309006, 309007, 309008, 309009, 309010, 309101, 309102, 309103, 309104, 309105, 309106, 309107, 309108, 309109, 309110, 309201, 309202, 309203, 309204, 309205, 309206, 309207, 309208, 309209, 309210, 309301, 309302, 309303, 309304, 309305, 309306, 309307, 309308, 309309, 309310, 309401, 309402, 309403, 309404, 309405, 309406, 309407, 309408, 309409, 309410, 309501, 309502, 309503, 309504, 309505, 309506, 309507, 309508, 309509, 309510, 309701, 309702, 309703, 309704, 309705, 309706, 309707, 309708, 309709, 309710, 309801, 309802, 309803, 309804, 309805, 309806, 309807, 309808, 309809, 309810, 309901, 309902, 309903, 309904, 309905, 309906, 309907, 309908, 309909, 309910, 310001, 310002, 310003, 310004, 310005, 310006, 310007, 310008, 310009, 310010, 310101, 310102, 310103, 310104, 310105, 310106, 310107, 310108, 310109, 310110, 310201, 310202, 310203, 310204, 310205, 310206, 310207, 310208, 310209, 310210, 310301, 310302, 310303, 310304, 310305, 310306, 310307, 310308, 310309, 310310, 310401, 310402, 310403, 310404, 310405, 310406, 310407, 310408, 310409, 310410, 310501, 310502, 310503, 310504, 310505, 310506, 310507, 310508, 310509, 310510, 310601, 310602, 310603, 310604, 310605, 310606, 310607, 310608, 310609, 310610, 310701, 310702, 310703, 310704, 310705, 310706, 310707, 310708, 310709, 310710, 310801, 310802, 310803, 310804, 310805, 310806, 310807, 310808, 310809, 310810, 310901, 310902, 310903, 310904, 310905, 310906, 310907, 310908, 310909, 310910, 311101, 311102, 311103, 311104, 311105, 311106, 311107, 311108, 311109, 311110, 311201, 311202, 311203, 311204, 311205, 311206, 311207, 311208, 311209, 311210, 311301, 311302, 311303, 311304, 311305, 311306, 311307, 311308, 311309, 311310, 311501, 311502, 311503, 311504, 311505, 311506, 311507, 311508, 311509, 311510, 311601, 311602, 311603, 311604, 311605, 311606, 311607, 311608, 311609, 311610, 311701, 311702, 311703, 311704, 311705, 311706, 311707, 311708, 311709, 311710, 311801, 311802, 311803, 311804, 311805, 311806, 311807, 311808, 311809, 311810, 311901, 311902, 311903, 311904, 311905, 311906, 311907, 311908, 311909, 311910, 312001, 312002, 312003, 312004, 312005, 312006, 312007, 312008, 312009, 312010, 312101, 312102, 312103, 312104, 312105, 312106, 312107, 312108, 312109, 312110, 312201, 312202, 312203, 312204, 312205, 312206, 312207, 312208, 312209, 312210, 312301, 312302, 312303, 312304, 312305, 312306, 312307, 312308, 312309, 312310, 312401, 312402, 312403, 312404, 312405, 312406, 312407, 312408, 312409, 312410, 312601, 312602, 312603, 312604, 312605, 312606, 312607, 312608, 312609, 312610, 313001, 313002, 313003, 313004, 313005, 313006, 313007, 313008, 313009, 313010, 400101, 400102, 400103, 400104, 400105, 400106, 400107, 400108, 400201, 400202, 400203, 400204, 400205, 400206, 400207, 400208, 400301, 400302, 400303, 400304, 400305, 400306, 400307, 400308, 400401, 400402, 400403, 400404, 400405, 400406, 400407, 400408, 400501, 400502, 400503, 400504, 400505, 400506, 400507, 400508, 400601, 400602, 400603, 400604, 400605, 400606, 400607, 400608, 400701, 400702, 400703, 400704, 400705, 400706, 400707, 400708, 400801, 400802, 400803, 400804, 400805, 400806, 400807, 400808, 400901, 400902, 400903, 400904, 400905, 400906, 400907, 400908, 401001, 401002, 401003, 401004, 401005, 401006, 401007, 401008, 401101, 401102, 401103, 401104, 401105, 401106, 401107, 401108, 401201, 401202, 401203, 401204, 401205, 401206, 401207, 401208, 401301, 401302, 401303, 401304, 401305, 401306, 401307, 401308, 401401, 401402, 401403, 401404, 401405, 401406, 401407, 401408, 401501, 401502, 401503, 401504, 401505, 401506, 401507, 401508, 401601, 401602, 401603, 401604, 401605, 401606, 401607, 401608, 401701, 401702, 401703, 401704, 401705, 401706, 401707, 401708, 401801, 401802, 401803, 401804, 401805, 401806, 401807, 401808, 401901, 401902, 401903, 401904, 401905, 401906, 401907, 401908, 402001, 402002, 402003, 402004, 402005, 402006, 402007, 402008, 402101, 402102, 402103, 402104, 402105, 402106, 402107, 402108, 402201, 402202, 402203, 402204, 402205, 402206, 402207, 402208, 402301, 402302, 402303, 402304, 402305, 402306, 402307, 402308, 402401, 402402, 402403, 402404, 402405, 402406, 402407, 402408, 402501, 402502, 402503, 402504, 402505, 402506, 402507, 402508, 402601, 402602, 402603, 402604, 402605, 402606, 402607, 402608, 402701, 402702, 402703, 402704, 402705, 402706, 402707, 402708, 402801, 402802, 402803, 402804, 402805, 402806, 402807, 402808, 402901, 402902, 402903, 402904, 402905, 402906, 402907, 402908, 403001, 403002, 403003, 403004, 403005, 403006, 403007, 403008, 403201, 403202, 403203, 403204, 403205, 403206, 403207, 403208, 403301, 403302, 403303, 403304, 403305, 403306, 403307, 403308, 403401, 403402, 403403, 403404, 403405, 403406, 403407, 403408, 403501, 403502, 403503, 403504, 403505, 403506, 403507, 403508, 403601, 403602, 403603, 403604, 403605, 403606, 403607, 403608, 403801, 403802, 403803, 403804, 403805, 403806, 403807, 403808, 403901, 403902, 403903, 403904, 403905, 403906, 403907, 403908, 404001, 404002, 404003, 404004, 404005, 404006, 404007, 404008, 404101, 404102, 404103, 404104, 404105, 404106, 404107, 404108, 404201, 404202, 404203, 404204, 404205, 404206, 404207, 404208, 404301, 404302, 404303, 404304, 404305, 404306, 404307, 404308, 404401, 404402, 404403, 404404, 404405, 404406, 404407, 404408, 404501, 404502, 404503, 404504, 404505, 404506, 404507, 404508, 404601, 404602, 404603, 404604, 404605, 404606, 404607, 404608, 404701, 404702, 404703, 404704, 404705, 404706, 404707, 404708, 404801, 404802, 404803, 404804, 404805, 404806, 404807, 404808, 404901, 404902, 404903, 404904, 404905, 404906, 404907, 404908, 405001, 405002, 405003, 405004, 405005, 405006, 405007, 405008, 405101, 405102, 405103, 405104, 405105, 405106, 405107, 405108, 405201, 405202, 405203, 405204, 405205, 405206, 405207, 405208, 405301, 405302, 405303, 405304, 405305, 405306, 405307, 405308, 405401, 405402, 405403, 405404, 405405, 405406, 405407, 405408, 405501, 405502, 405503, 405504, 405505, 405506, 405507, 405508, 405601, 405602, 405603, 405604, 405605, 405606, 405607, 405608, 405701, 405702, 405703, 405704, 405705, 405706, 405707, 405708, 405801, 405802, 405803, 405804, 405805, 405806, 405807, 405808, 405901, 405902, 405903, 405904, 405905, 405906, 405907, 405908, 406001, 406002, 406003, 406004, 406005, 406006, 406007, 406008, 406101, 406102, 406103, 406104, 406105, 406106, 406107, 406108, 406201, 406202, 406203, 406204, 406205, 406206, 406207, 406208, 406301, 406302, 406303, 406304, 406305, 406306, 406307, 406308, 406401, 406402, 406403, 406404, 406405, 406406, 406407, 406408, 406501, 406502, 406503, 406504, 406505, 406506, 406507, 406508, 406601, 406602, 406603, 406604, 406605, 406606, 406607, 406608, 406701, 406702, 406703, 406704, 406705, 406706, 406707, 406708, 406801, 406802, 406803, 406804, 406805, 406806, 406807, 406808, 406901, 406902, 406903, 406904, 406905, 406906, 406907, 406908, 407001, 407002, 407003, 407004, 407005, 407006, 407007, 407008, 407101, 407102, 407103, 407104, 407105, 407106, 407107, 407108, 407201, 407202, 407203, 407204, 407205, 407206, 407207, 407208, 407301, 407302, 407303, 407304, 407305, 407306, 407307, 407308, 407401, 407402, 407403, 407404, 407405, 407406, 407407, 407408, 407501, 407502, 407503, 407504, 407505, 407506, 407507, 407508, 407601, 407602, 407603, 407604, 407605, 407606, 407607, 407608, 407801, 407802, 407803, 407804, 407805, 407806, 407807, 407808, 407901, 407902, 407903, 407904, 407905, 407906, 407907, 407908, 408001, 408002, 408003, 408004, 408005, 408006, 408007, 408008, 408101, 408102, 408103, 408104, 408105, 408106, 408107, 408108, 408201, 408202, 408203, 408204, 408205, 408206, 408207, 408208, 408301, 408302, 408303, 408304, 408305, 408306, 408307, 408308, 408401, 408402, 408403, 408404, 408405, 408406, 408407, 408408, 408501, 408502, 408503, 408504, 408505, 408506, 408507, 408508, 408601, 408602, 408603, 408604, 408605, 408606, 408607, 408608, 408801, 408802, 408803, 408804, 408805, 408806, 408807, 408808, 408901, 408902, 408903, 408904, 408905, 408906, 408907, 408908, 409001, 409002, 409003, 409004, 409005, 409006, 409007, 409008, 409101, 409102, 409103, 409104, 409105, 409106, 409107, 409108, 409201, 409202, 409203, 409204, 409205, 409206, 409207, 409208, 409301, 409302, 409303, 409304, 409305, 409306, 409307, 409308, 409401, 409402, 409403, 409404, 409405, 409406, 409407, 409408, 409501, 409502, 409503, 409504, 409505, 409506, 409507, 409508, 409701, 409702, 409703, 409704, 409705, 409706, 409707, 409708, 409801, 409802, 409803, 409804, 409805, 409806, 409807, 409808, 409901, 409902, 409903, 409904, 409905, 409906, 409907, 409908, 410001, 410002, 410003, 410004, 410005, 410006, 410007, 410008, 410101, 410102, 410103, 410104, 410105, 410106, 410107, 410108, 410201, 410202, 410203, 410204, 410205, 410206, 410207, 410208, 410301, 410302, 410303, 410304, 410305, 410306, 410307, 410308, 410401, 410402, 410403, 410404, 410405, 410406, 410407, 410408, 410501, 410502, 410503, 410504, 410505, 410506, 410507, 410508, 410601, 410602, 410603, 410604, 410605, 410606, 410607, 410608, 410701, 410702, 410703, 410704, 410705, 410706, 410707, 410708, 410801, 410802, 410803, 410804, 410805, 410806, 410807, 410808, 410901, 410902, 410903, 410904, 410905, 410906, 410907, 410908, 411001, 411002, 411003, 411004, 411005, 411006, 411007, 411008, 411101, 411102, 411103, 411104, 411105, 411106, 411107, 411108, 411201, 411202, 411203, 411204, 411205, 411206, 411207, 411208, 411301, 411302, 411303, 411304, 411305, 411306, 411307, 411308, 411501, 411502, 411503, 411504, 411505, 411506, 411507, 411508, 411601, 411602, 411603, 411604, 411605, 411606, 411607, 411608, 411701, 411702, 411703, 411704, 411705, 411706, 411707, 411708, 411801, 411802, 411803, 411804, 411805, 411806, 411807, 411808, 411901, 411902, 411903, 411904, 411905, 411906, 411907, 411908, 412001, 412002, 412003, 412004, 412005, 412006, 412007, 412008, 412101, 412102, 412103, 412104, 412105, 412106, 412107, 412108, 412201, 412202, 412203, 412204, 412205, 412206, 412207, 412208, 412301, 412302, 412303, 412304, 412305, 412306, 412307, 412308, 412401, 412402, 412403, 412404, 412405, 412406, 412407, 412408, 412601, 412602, 412603, 412604, 412605, 412606, 412607, 412608, 413001, 413002, 413003, 413004, 413005, 413006, 413007, 413008, 500101, 500102, 500201, 500202, 500301, 500302, 500401, 500402, 500501, 500504, 500601, 500602, 500603, 500604, 500605, 500606, 500701, 500702, 500703, 500704, 500705, 500706, 500801, 500802, 500901, 500902, 501001, 501002, 501101, 501102, 501201, 501202, 501301, 501302, 501401, 501402, 501501, 501502, 501601, 501602, 501701, 501702, 501801, 501802, 501901, 501902, 502001, 502002, 502003, 502004, 502005, 502006, 502101, 502102, 502103, 502104, 502105, 502106, 502201, 502202, 502301, 502302, 502401, 502402, 502501, 502502, 502601, 502602, 502603, 502604, 502605, 502606, 502701, 502702, 502801, 502802, 502901, 502902, 503001, 503002, 503201, 503202, 503301, 503302, 503401, 503402, 503501, 503502, 503601, 503602, 503801, 503802, 503901, 503902, 503903, 503904, 503905, 503906, 503907, 503908, 504101, 504102, 504201, 504202, 504301, 504302, 504401, 504402, 504403, 504404, 504405, 504406, 504501, 504502, 504505, 504506, 504701, 504702, 504801, 504802, 504901, 504902, 505001, 505002, 505003, 505004, 505005, 505006, 505007, 505101, 505102, 505201, 505202, 505301, 505302, 505401, 505402, 505403, 505404, 505405, 505406, 505501, 505502, 505601, 505602, 505701, 505702, 505801, 505802, 505803, 505804, 505805, 505806, 505807, 505901, 505902, 506001, 506002, 506003, 506004, 506005, 506006, 506007, 506101, 506102, 506201, 506202, 506203, 506204, 506205, 506206, 506207, 506301, 506302, 506401, 506402, 506403, 506404, 506405, 506406, 506407, 506501, 506502, 506601, 506602, 506603, 506604, 506605, 506606, 506607, 506701, 506702, 506703, 506704, 506705, 506706, 506801, 506802, 506803, 506804, 506805, 506806, 506901, 506902, 507001, 507002, 507101, 507102, 507201, 507202, 507301, 507302, 507401, 507402, 507501, 507502, 507601, 507602, 507801, 507802, 507901, 507902, 508001, 508002, 508101, 508102, 508201, 508202, 508301, 508302, 508401, 508402, 508501, 508502, 508601, 508602, 508801, 508802, 508901, 508902, 509001, 509002, 509101, 509102, 509201, 509202, 509301, 509302, 509401, 509402, 509501, 509502, 509701, 509702, 509801, 509802, 509901, 509902, 510001, 510002, 510101, 510102, 510201, 510202, 510301, 510302, 510401, 510402, 510501, 510502, 510601, 510602, 510701, 510702, 510703, 510704, 510801, 510802, 510901, 510902, 511001, 511002, 511101, 511102, 511201, 511202, 511301, 511302, 511501, 511502, 511601, 511602, 511701, 511702, 511801, 511802, 511901, 511902, 512001, 512002, 512101, 512102, 512201, 512202, 512301, 512302, 512401, 512402, 512601, 512602, 513001, 513002}
return cskillshow_soul

