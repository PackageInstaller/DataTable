-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/skill/cskillshow_common.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cskillshow_common = {}
cskillshow_common.Data = {
[21] = {id = 21, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[22] = {id = 22, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[23] = {id = 23, nameTextID = 302746, exDiscribeTextID = 302754}
, 
[24] = {id = 24, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[31] = {id = 31, nameTextID = 302748, exDiscribeTextID = 302778}
, 
[32] = {id = 32, nameTextID = 302747, exDiscribeTextID = 302808}
, 
[33] = {id = 33, nameTextID = 302745, exDiscribeTextID = 302784}
, 
[34] = {id = 34, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[41] = {id = 41, nameTextID = 302747, exDiscribeTextID = 302803}
, 
[42] = {id = 42, nameTextID = 302748, exDiscribeTextID = 302773}
, 
[43] = {id = 43, nameTextID = 302746, exDiscribeTextID = 302753}
, 
[44] = {id = 44, nameTextID = 302745, exDiscribeTextID = 302794}
, 
[51] = {id = 51, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[52] = {id = 52, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[53] = {id = 53, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[54] = {id = 54, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[61] = {id = 61, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[62] = {id = 62, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[63] = {id = 63, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[64] = {id = 64, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[71] = {id = 71, nameTextID = 302748, exDiscribeTextID = 302777}
, 
[72] = {id = 72, nameTextID = 302747, exDiscribeTextID = 302807}
, 
[73] = {id = 73, nameTextID = 302745, exDiscribeTextID = 302783}
, 
[74] = {id = 74, nameTextID = 302746, exDiscribeTextID = 302757}
, 
[81] = {id = 81, nameTextID = 302746, exDiscribeTextID = 302752}
, 
[82] = {id = 82, nameTextID = 302748, exDiscribeTextID = 302769}
, 
[83] = {id = 83, nameTextID = 302747, exDiscribeTextID = 302799}
, 
[84] = {id = 84, nameTextID = 302745, exDiscribeTextID = 302790}
, 
[91] = {id = 91, nameTextID = 302747, exDiscribeTextID = 302803}
, 
[92] = {id = 92, nameTextID = 302748, exDiscribeTextID = 302773}
, 
[93] = {id = 93, nameTextID = 302746, exDiscribeTextID = 302753}
, 
[94] = {id = 94, nameTextID = 302745, exDiscribeTextID = 302794}
, 
[101] = {id = 101, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[102] = {id = 102, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[103] = {id = 103, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[104] = {id = 104, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[111] = {id = 111, nameTextID = 302746, exDiscribeTextID = 302752}
, 
[112] = {id = 112, nameTextID = 302747, exDiscribeTextID = 302799}
, 
[113] = {id = 113, nameTextID = 302748, exDiscribeTextID = 302769}
, 
[114] = {id = 114, nameTextID = 302745, exDiscribeTextID = 302790}
, 
[121] = {id = 121, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[122] = {id = 122, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[123] = {id = 123, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[124] = {id = 124, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[131] = {id = 131, nameTextID = 302747, exDiscribeTextID = 302802}
, 
[132] = {id = 132, nameTextID = 302748, exDiscribeTextID = 302772}
, 
[133] = {id = 133, nameTextID = 302745, exDiscribeTextID = 302793}
, 
[134] = {id = 134, nameTextID = 302746, exDiscribeTextID = 302765}
, 
[141] = {id = 141, nameTextID = 302747, exDiscribeTextID = 302800}
, 
[142] = {id = 142, nameTextID = 302748, exDiscribeTextID = 302770}
, 
[143] = {id = 143, nameTextID = 302745, exDiscribeTextID = 302791}
, 
[144] = {id = 144, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[151] = {id = 151, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[152] = {id = 152, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[153] = {id = 153, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[154] = {id = 154, nameTextID = 302746, exDiscribeTextID = 302760}
, 
[161] = {id = 161, nameTextID = 302747, exDiscribeTextID = 302808}
, 
[162] = {id = 162, nameTextID = 302748, exDiscribeTextID = 302778}
, 
[163] = {id = 163, nameTextID = 302745, exDiscribeTextID = 302784}
, 
[164] = {id = 164, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[171] = {id = 171, nameTextID = 302748, exDiscribeTextID = 302780}
, 
[172] = {id = 172, nameTextID = 302747, exDiscribeTextID = 302810}
, 
[173] = {id = 173, nameTextID = 302745, exDiscribeTextID = 302786}
, 
[174] = {id = 174, nameTextID = 302746, exDiscribeTextID = 302761}
, 
[181] = {id = 181, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[182] = {id = 182, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[183] = {id = 183, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[184] = {id = 184, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[191] = {id = 191, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[192] = {id = 192, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[193] = {id = 193, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[194] = {id = 194, nameTextID = 302746, exDiscribeTextID = 302754}
, 
[201] = {id = 201, nameTextID = 302748, exDiscribeTextID = 302777}
, 
[202] = {id = 202, nameTextID = 302747, exDiscribeTextID = 302807}
, 
[203] = {id = 203, nameTextID = 302745, exDiscribeTextID = 302783}
, 
[204] = {id = 204, nameTextID = 302746, exDiscribeTextID = 302757}
, 
[211] = {id = 211, nameTextID = 302748, exDiscribeTextID = 302777}
, 
[212] = {id = 212, nameTextID = 302747, exDiscribeTextID = 302807}
, 
[213] = {id = 213, nameTextID = 302745, exDiscribeTextID = 302783}
, 
[214] = {id = 214, nameTextID = 302746, exDiscribeTextID = 302757}
, 
[221] = {id = 221, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[222] = {id = 222, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[223] = {id = 223, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[224] = {id = 224, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[231] = {id = 231, nameTextID = 302746, exDiscribeTextID = 302752}
, 
[232] = {id = 232, nameTextID = 302747, exDiscribeTextID = 302799}
, 
[233] = {id = 233, nameTextID = 302748, exDiscribeTextID = 302769}
, 
[234] = {id = 234, nameTextID = 302745, exDiscribeTextID = 302790}
, 
[241] = {id = 241, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[242] = {id = 242, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[243] = {id = 243, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[244] = {id = 244, nameTextID = 302746, exDiscribeTextID = 302754}
, 
[251] = {id = 251, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[252] = {id = 252, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[253] = {id = 253, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[254] = {id = 254, nameTextID = 302746, exDiscribeTextID = 302762}
, 
[261] = {id = 261, nameTextID = 302747, exDiscribeTextID = 302800}
, 
[262] = {id = 262, nameTextID = 302748, exDiscribeTextID = 302770}
, 
[263] = {id = 263, nameTextID = 302745, exDiscribeTextID = 302791}
, 
[264] = {id = 264, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[271] = {id = 271, nameTextID = 302746, exDiscribeTextID = 302750}
, 
[272] = {id = 272, nameTextID = 302747, exDiscribeTextID = 302797}
, 
[273] = {id = 273, nameTextID = 302748, exDiscribeTextID = 302767}
, 
[274] = {id = 274, nameTextID = 302745, exDiscribeTextID = 302788}
, 
[281] = {id = 281, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[282] = {id = 282, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[283] = {id = 283, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[284] = {id = 284, nameTextID = 302746, exDiscribeTextID = 302762}
, 
[291] = {id = 291, nameTextID = 302747, exDiscribeTextID = 302802}
, 
[292] = {id = 292, nameTextID = 302748, exDiscribeTextID = 302772}
, 
[293] = {id = 293, nameTextID = 302745, exDiscribeTextID = 302793}
, 
[294] = {id = 294, nameTextID = 302746, exDiscribeTextID = 302765}
, 
[301] = {id = 301, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[302] = {id = 302, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[303] = {id = 303, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[304] = {id = 304, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[321] = {id = 321, nameTextID = 302747, exDiscribeTextID = 302800}
, 
[322] = {id = 322, nameTextID = 302748, exDiscribeTextID = 302770}
, 
[323] = {id = 323, nameTextID = 302745, exDiscribeTextID = 302791}
, 
[324] = {id = 324, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[331] = {id = 331, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[332] = {id = 332, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[333] = {id = 333, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[334] = {id = 334, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[341] = {id = 341, nameTextID = 302747, exDiscribeTextID = 302801}
, 
[342] = {id = 342, nameTextID = 302748, exDiscribeTextID = 302771}
, 
[343] = {id = 343, nameTextID = 302745, exDiscribeTextID = 302792}
, 
[344] = {id = 344, nameTextID = 302746, exDiscribeTextID = 302764}
, 
[351] = {id = 351, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[352] = {id = 352, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[353] = {id = 353, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[354] = {id = 354, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[361] = {id = 361, nameTextID = 302747, exDiscribeTextID = 302803}
, 
[362] = {id = 362, nameTextID = 302748, exDiscribeTextID = 302773}
, 
[363] = {id = 363, nameTextID = 302745, exDiscribeTextID = 302794}
, 
[364] = {id = 364, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[381] = {id = 381, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[382] = {id = 382, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[383] = {id = 383, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[384] = {id = 384, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[391] = {id = 391, nameTextID = 302747, exDiscribeTextID = 302808}
, 
[392] = {id = 392, nameTextID = 302748, exDiscribeTextID = 302778}
, 
[393] = {id = 393, nameTextID = 302745, exDiscribeTextID = 302784}
, 
[394] = {id = 394, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[401] = {id = 401, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[402] = {id = 402, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[403] = {id = 403, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[404] = {id = 404, nameTextID = 302746, exDiscribeTextID = 302760}
, 
[411] = {id = 411, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[412] = {id = 412, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[413] = {id = 413, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[414] = {id = 414, nameTextID = 302746, exDiscribeTextID = 302762}
, 
[421] = {id = 421, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[422] = {id = 422, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[423] = {id = 423, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[424] = {id = 424, nameTextID = 302746, exDiscribeTextID = 302762}
, 
[431] = {id = 431, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[432] = {id = 432, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[433] = {id = 433, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[434] = {id = 434, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[441] = {id = 441, nameTextID = 302747, exDiscribeTextID = 302803}
, 
[442] = {id = 442, nameTextID = 302748, exDiscribeTextID = 302773}
, 
[443] = {id = 443, nameTextID = 302745, exDiscribeTextID = 302794}
, 
[444] = {id = 444, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[451] = {id = 451, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[452] = {id = 452, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[453] = {id = 453, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[454] = {id = 454, nameTextID = 302746, exDiscribeTextID = 302760}
, 
[461] = {id = 461, nameTextID = 302748, exDiscribeTextID = 302778}
, 
[462] = {id = 462, nameTextID = 302747, exDiscribeTextID = 302808}
, 
[463] = {id = 463, nameTextID = 302745, exDiscribeTextID = 302784}
, 
[464] = {id = 464, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[471] = {id = 471, nameTextID = 302747, exDiscribeTextID = 302801}
, 
[472] = {id = 472, nameTextID = 302748, exDiscribeTextID = 302771}
, 
[473] = {id = 473, nameTextID = 302745, exDiscribeTextID = 302792}
, 
[474] = {id = 474, nameTextID = 302746, exDiscribeTextID = 302764}
, 
[481] = {id = 481, nameTextID = 302748, exDiscribeTextID = 302779}
, 
[482] = {id = 482, nameTextID = 302747, exDiscribeTextID = 302809}
, 
[483] = {id = 483, nameTextID = 302745, exDiscribeTextID = 302785}
, 
[484] = {id = 484, nameTextID = 302746, exDiscribeTextID = 302759}
, 
[491] = {id = 491, nameTextID = 302746, exDiscribeTextID = 302750}
, 
[492] = {id = 492, nameTextID = 302748, exDiscribeTextID = 302767}
, 
[493] = {id = 493, nameTextID = 302747, exDiscribeTextID = 302797}
, 
[494] = {id = 494, nameTextID = 302745, exDiscribeTextID = 302788}
, 
[501] = {id = 501, nameTextID = 302748, exDiscribeTextID = 302780}
, 
[502] = {id = 502, nameTextID = 302747, exDiscribeTextID = 302810}
, 
[503] = {id = 503, nameTextID = 302745, exDiscribeTextID = 302786}
, 
[504] = {id = 504, nameTextID = 302746, exDiscribeTextID = 302761}
, 
[511] = {id = 511, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[512] = {id = 512, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[513] = {id = 513, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[514] = {id = 514, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[521] = {id = 521, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[522] = {id = 522, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[523] = {id = 523, nameTextID = 302746, exDiscribeTextID = 302754}
, 
[524] = {id = 524, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[531] = {id = 531, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[532] = {id = 532, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[533] = {id = 533, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[534] = {id = 534, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[541] = {id = 541, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[542] = {id = 542, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[543] = {id = 543, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[544] = {id = 544, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[551] = {id = 551, nameTextID = 302747, exDiscribeTextID = 302801}
, 
[552] = {id = 552, nameTextID = 302748, exDiscribeTextID = 302771}
, 
[553] = {id = 553, nameTextID = 302745, exDiscribeTextID = 302792}
, 
[554] = {id = 554, nameTextID = 302746, exDiscribeTextID = 302764}
, 
[561] = {id = 561, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[562] = {id = 562, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[563] = {id = 563, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[564] = {id = 564, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[571] = {id = 571, nameTextID = 302746, exDiscribeTextID = 302749}
, 
[572] = {id = 572, nameTextID = 302747, exDiscribeTextID = 302796}
, 
[573] = {id = 573, nameTextID = 302748, exDiscribeTextID = 302766}
, 
[574] = {id = 574, nameTextID = 302745, exDiscribeTextID = 302787}
, 
[581] = {id = 581, nameTextID = 302747, exDiscribeTextID = 302800}
, 
[582] = {id = 582, nameTextID = 302748, exDiscribeTextID = 302770}
, 
[583] = {id = 583, nameTextID = 302745, exDiscribeTextID = 302791}
, 
[584] = {id = 584, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[591] = {id = 591, nameTextID = 302746, exDiscribeTextID = 302751}
, 
[592] = {id = 592, nameTextID = 302747, exDiscribeTextID = 302798}
, 
[593] = {id = 593, nameTextID = 302748, exDiscribeTextID = 302768}
, 
[594] = {id = 594, nameTextID = 302745, exDiscribeTextID = 302789}
, 
[601] = {id = 601, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[602] = {id = 602, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[603] = {id = 603, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[604] = {id = 604, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[611] = {id = 611, nameTextID = 302748, exDiscribeTextID = 302779}
, 
[612] = {id = 612, nameTextID = 302747, exDiscribeTextID = 302809}
, 
[613] = {id = 613, nameTextID = 302745, exDiscribeTextID = 302785}
, 
[614] = {id = 614, nameTextID = 302746, exDiscribeTextID = 302759}
, 
[621] = {id = 621, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[622] = {id = 622, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[623] = {id = 623, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[624] = {id = 624, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[631] = {id = 631, nameTextID = 302746, exDiscribeTextID = 302752}
, 
[632] = {id = 632, nameTextID = 302748, exDiscribeTextID = 302769}
, 
[633] = {id = 633, nameTextID = 302747, exDiscribeTextID = 302799}
, 
[634] = {id = 634, nameTextID = 302745, exDiscribeTextID = 302790}
, 
[641] = {id = 641, nameTextID = 302747, exDiscribeTextID = 302800}
, 
[642] = {id = 642, nameTextID = 302748, exDiscribeTextID = 302770}
, 
[643] = {id = 643, nameTextID = 302745, exDiscribeTextID = 302791}
, 
[644] = {id = 644, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[651] = {id = 651, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[652] = {id = 652, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[653] = {id = 653, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[654] = {id = 654, nameTextID = 302746, exDiscribeTextID = 302755}
, 
[661] = {id = 661, nameTextID = 302746, exDiscribeTextID = 302750}
, 
[662] = {id = 662, nameTextID = 302748, exDiscribeTextID = 302767}
, 
[663] = {id = 663, nameTextID = 302747, exDiscribeTextID = 302797}
, 
[664] = {id = 664, nameTextID = 302745, exDiscribeTextID = 302788}
, 
[671] = {id = 671, nameTextID = 302748, exDiscribeTextID = 302778}
, 
[672] = {id = 672, nameTextID = 302747, exDiscribeTextID = 302808}
, 
[673] = {id = 673, nameTextID = 302745, exDiscribeTextID = 302784}
, 
[674] = {id = 674, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[681] = {id = 681, nameTextID = 302748, exDiscribeTextID = 302773}
, 
[682] = {id = 682, nameTextID = 302745, exDiscribeTextID = 302794}
, 
[683] = {id = 683, nameTextID = 302747, exDiscribeTextID = 302803}
, 
[684] = {id = 684, nameTextID = 302746, exDiscribeTextID = 302753}
, 
[691] = {id = 691, nameTextID = 302747, exDiscribeTextID = 302805}
, 
[692] = {id = 692, nameTextID = 302748, exDiscribeTextID = 302775}
, 
[693] = {id = 693, nameTextID = 302745, exDiscribeTextID = 302781}
, 
[694] = {id = 694, nameTextID = 302746, exDiscribeTextID = 302762}
, 
[701] = {id = 701, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[702] = {id = 702, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[703] = {id = 703, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[704] = {id = 704, nameTextID = 302746, exDiscribeTextID = 302763}
, 
[711] = {id = 711, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[712] = {id = 712, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[713] = {id = 713, nameTextID = 302746, exDiscribeTextID = 302795}
, 
[714] = {id = 714, nameTextID = 302745, exDiscribeTextID = 302754}
, 
[721] = {id = 721, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[722] = {id = 722, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[723] = {id = 723, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[724] = {id = 724, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[731] = {id = 731, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[732] = {id = 732, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[733] = {id = 733, nameTextID = 302746, exDiscribeTextID = 302754}
, 
[734] = {id = 734, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[741] = {id = 741, nameTextID = 302748, exDiscribeTextID = 302778}
, 
[742] = {id = 742, nameTextID = 302747, exDiscribeTextID = 302808}
, 
[743] = {id = 743, nameTextID = 302745, exDiscribeTextID = 302784}
, 
[744] = {id = 744, nameTextID = 302746, exDiscribeTextID = 302758}
, 
[751] = {id = 751, nameTextID = 302748, exDiscribeTextID = 302777}
, 
[752] = {id = 752, nameTextID = 302747, exDiscribeTextID = 302807}
, 
[753] = {id = 753, nameTextID = 302745, exDiscribeTextID = 302783}
, 
[754] = {id = 754, nameTextID = 302746, exDiscribeTextID = 302757}
, 
[761] = {id = 761, nameTextID = 302747, exDiscribeTextID = 302804}
, 
[762] = {id = 762, nameTextID = 302748, exDiscribeTextID = 302774}
, 
[763] = {id = 763, nameTextID = 302746, exDiscribeTextID = 302754}
, 
[764] = {id = 764, nameTextID = 302745, exDiscribeTextID = 302795}
, 
[1021] = {id = 1021, nameTextID = 302747, exDiscribeTextID = 302806}
, 
[1022] = {id = 1022, nameTextID = 302748, exDiscribeTextID = 302776}
, 
[1023] = {id = 1023, nameTextID = 302746, exDiscribeTextID = 302756}
, 
[1024] = {id = 1024, nameTextID = 302745, exDiscribeTextID = 302782}
, 
[20001] = {id = 20001, nameTextID = 301679, exDiscribeTextID = 301721}
, 
[20002] = {id = 20002, nameTextID = 301679, exDiscribeTextID = 301722}
, 
[20003] = {id = 20003, nameTextID = 301679, exDiscribeTextID = 301723}
, 
[20004] = {id = 20004, nameTextID = 301679, exDiscribeTextID = 301724}
, 
[20005] = {id = 20005, nameTextID = 301680, exDiscribeTextID = 301725}
, 
[20006] = {id = 20006, nameTextID = 301680, exDiscribeTextID = 301726}
, 
[20007] = {id = 20007, nameTextID = 301680, exDiscribeTextID = 301727}
, 
[20008] = {id = 20008, nameTextID = 301680, exDiscribeTextID = 301728}
, 
[20009] = {id = 20009, nameTextID = 301681, exDiscribeTextID = 301729}
, 
[20010] = {id = 20010, nameTextID = 301682, exDiscribeTextID = 301730}
, 
[20011] = {id = 20011, nameTextID = 301682, exDiscribeTextID = 301731}
, 
[20012] = {id = 20012, nameTextID = 301682, exDiscribeTextID = 301732}
, 
[20013] = {id = 20013, nameTextID = 301682, exDiscribeTextID = 301733}
, 
[20014] = {id = 20014, nameTextID = 301683, exDiscribeTextID = 301734}
, 
[20015] = {id = 20015, nameTextID = 301683, exDiscribeTextID = 301735}
, 
[20016] = {id = 20016, nameTextID = 301683, exDiscribeTextID = 301736}
, 
[20017] = {id = 20017, nameTextID = 301683, exDiscribeTextID = 301737}
, 
[20018] = {id = 20018, nameTextID = 301684, exDiscribeTextID = 301738}
, 
[20019] = {id = 20019, nameTextID = 301684, exDiscribeTextID = 301739}
, 
[20020] = {id = 20020, nameTextID = 301684, exDiscribeTextID = 301740}
, 
[20021] = {id = 20021, nameTextID = 301684, exDiscribeTextID = 301741}
, 
[20022] = {id = 20022, nameTextID = 301685, exDiscribeTextID = 301742}
, 
[20023] = {id = 20023, nameTextID = 301685, exDiscribeTextID = 301743}
, 
[20024] = {id = 20024, nameTextID = 301685, exDiscribeTextID = 301744}
, 
[20025] = {id = 20025, nameTextID = 301685, exDiscribeTextID = 301745}
, 
[20026] = {id = 20026, nameTextID = 301686, exDiscribeTextID = 301746}
, 
[20027] = {id = 20027, nameTextID = 301686, exDiscribeTextID = 301747}
, 
[20028] = {id = 20028, nameTextID = 301686, exDiscribeTextID = 301748}
, 
[20029] = {id = 20029, nameTextID = 301686, exDiscribeTextID = 301749}
, 
[20030] = {id = 20030, nameTextID = 301687, exDiscribeTextID = 301750}
, 
[20031] = {id = 20031, nameTextID = 301687, exDiscribeTextID = 301751}
, 
[20032] = {id = 20032, nameTextID = 301687, exDiscribeTextID = 301752}
, 
[20033] = {id = 20033, nameTextID = 301687, exDiscribeTextID = 301753}
, 
[20034] = {id = 20034, nameTextID = 301688, exDiscribeTextID = 301754}
, 
[20035] = {id = 20035, nameTextID = 301688, exDiscribeTextID = 301755}
, 
[20036] = {id = 20036, nameTextID = 301688, exDiscribeTextID = 301756}
, 
[20037] = {id = 20037, nameTextID = 301688, exDiscribeTextID = 301757}
, 
[20038] = {id = 20038, nameTextID = 301689, exDiscribeTextID = 301758}
, 
[20039] = {id = 20039, nameTextID = 301690, exDiscribeTextID = 301790}
, 
[20040] = {id = 20040, nameTextID = 301691, exDiscribeTextID = 301791}
, 
[20041] = {id = 20041, nameTextID = 301692, exDiscribeTextID = 301792}
, 
[20042] = {id = 20042, nameTextID = 301693, exDiscribeTextID = 301793}
, 
[20043] = {id = 20043, nameTextID = 301694, exDiscribeTextID = 301794}
, 
[20044] = {id = 20044, nameTextID = 301695, exDiscribeTextID = 301764}
, 
[20045] = {id = 20045, nameTextID = 301696, exDiscribeTextID = 301795}
, 
[20046] = {id = 20046, nameTextID = 301697, exDiscribeTextID = 301766}
, 
[20047] = {id = 20047, nameTextID = 301698, exDiscribeTextID = 301796}
, 
[20048] = {id = 20048, nameTextID = 301699, exDiscribeTextID = 301797}
, 
[20049] = {id = 20049, nameTextID = 301700, exDiscribeTextID = 301798}
, 
[20050] = {id = 20050, nameTextID = 301701, exDiscribeTextID = 301799}
, 
[20051] = {id = 20051, nameTextID = 301702, exDiscribeTextID = 301800}
, 
[20052] = {id = 20052, nameTextID = 301703, exDiscribeTextID = 301801}
, 
[20055] = {id = 20055, nameTextID = 301704, exDiscribeTextID = 301802}
, 
[20056] = {id = 20056, nameTextID = 301705, exDiscribeTextID = 301774}
, 
[20057] = {id = 20057, nameTextID = 301706, exDiscribeTextID = 301775}
, 
[20058] = {id = 20058, nameTextID = 301707, exDiscribeTextID = 301803}
, 
[20059] = {id = 20059, nameTextID = 301708, exDiscribeTextID = 301804}
, 
[20060] = {id = 20060, nameTextID = 301709, exDiscribeTextID = 301805}
, 
[20061] = {id = 20061, nameTextID = 301710, exDiscribeTextID = 301806}
, 
[20062] = {id = 20062, nameTextID = 301711, exDiscribeTextID = 301807}
, 
[20063] = {id = 20063, nameTextID = 301712, exDiscribeTextID = 301781}
, 
[20064] = {id = 20064, nameTextID = 301713, exDiscribeTextID = 301782}
, 
[20065] = {id = 20065, nameTextID = 301714, exDiscribeTextID = 301783}
, 
[20066] = {id = 20066, nameTextID = 301715, exDiscribeTextID = 301784}
, 
[20075] = {id = 20075, nameTextID = 301716, exDiscribeTextID = 301808}
, 
[20076] = {id = 20076, nameTextID = 301717, exDiscribeTextID = 301809}
, 
[20077] = {id = 20077, nameTextID = 301718, exDiscribeTextID = 301810}
, 
[20078] = {id = 20078, nameTextID = 301719, exDiscribeTextID = 301811}
, 
[20079] = {id = 20079, nameTextID = 301720, exDiscribeTextID = 301812}
, 
[20083] = {id = 20083, nameTextID = 303164, exDiscribeTextID = 303165}
, 
[31001] = {id = 31001, nameTextID = 303502, exDiscribeTextID = 303523}
, 
[31002] = {id = 31002, nameTextID = 303503, exDiscribeTextID = 303524}
, 
[31003] = {id = 31003, nameTextID = 303504, exDiscribeTextID = 303525}
, 
[32001] = {id = 32001, nameTextID = 303505, exDiscribeTextID = 303526}
, 
[32002] = {id = 32002, nameTextID = 303506, exDiscribeTextID = 303527}
, 
[32003] = {id = 32003, nameTextID = 303507, exDiscribeTextID = 303528}
, 
[33001] = {id = 33001, nameTextID = 303508, exDiscribeTextID = 303529}
, 
[33002] = {id = 33002, nameTextID = 303509, exDiscribeTextID = 303530}
, 
[33003] = {id = 33003, nameTextID = 303510, exDiscribeTextID = 303531}
, 
[34001] = {id = 34001, nameTextID = 303511, exDiscribeTextID = 303532}
, 
[34002] = {id = 34002, nameTextID = 303512, exDiscribeTextID = 303533}
, 
[34003] = {id = 34003, nameTextID = 303513, exDiscribeTextID = 303534}
, 
[35001] = {id = 35001, nameTextID = 303514, exDiscribeTextID = 303535}
, 
[35002] = {id = 35002, nameTextID = 303515, exDiscribeTextID = 303536}
, 
[35003] = {id = 35003, nameTextID = 303516, exDiscribeTextID = 303537}
, 
[36001] = {id = 36001, nameTextID = 303517, exDiscribeTextID = 303538}
, 
[36002] = {id = 36002, nameTextID = 303518, exDiscribeTextID = 303539}
, 
[36003] = {id = 36003, nameTextID = 303519, exDiscribeTextID = 303540}
, 
[37001] = {id = 37001, nameTextID = 303520, exDiscribeTextID = 303541}
, 
[37002] = {id = 37002, nameTextID = 303521, exDiscribeTextID = 303542}
, 
[37003] = {id = 37003, nameTextID = 303522, exDiscribeTextID = 303543}
, 
[201007] = {id = 201007, nameTextID = 300001, exDiscribeTextID = 300202}
, 
[201008] = {id = 201008, nameTextID = 300002, exDiscribeTextID = 300203}
, 
[201009] = {id = 201009, nameTextID = 300003, exDiscribeTextID = 300204}
, 
[201010] = {id = 201010, nameTextID = 300004, exDiscribeTextID = 300205}
, 
[201011] = {id = 201011, nameTextID = 300005, exDiscribeTextID = 300206}
, 
[201012] = {id = 201012, nameTextID = 300006, exDiscribeTextID = 300207}
, 
[201013] = {id = 201013, nameTextID = 300007, exDiscribeTextID = 300208}
, 
[201014] = {id = 201014, nameTextID = 300008, exDiscribeTextID = 300209}
, 
[201015] = {id = 201015, nameTextID = 300009, exDiscribeTextID = 300210}
, 
[201016] = {id = 201016, nameTextID = 300010, exDiscribeTextID = 300211}
, 
[201017] = {id = 201017, nameTextID = 300011, exDiscribeTextID = 300212}
, 
[201018] = {id = 201018, nameTextID = 300012, exDiscribeTextID = 300213}
, 
[201019] = {id = 201019, nameTextID = 300013, exDiscribeTextID = 300214}
, 
[201020] = {id = 201020, nameTextID = 300014, exDiscribeTextID = 300215}
, 
[201021] = {id = 201021, nameTextID = 300015, exDiscribeTextID = 300216}
, 
[201022] = {id = 201022, nameTextID = 300016, exDiscribeTextID = 300217}
, 
[201023] = {id = 201023, nameTextID = 300017, exDiscribeTextID = 300218}
, 
[201024] = {id = 201024, nameTextID = 300018, exDiscribeTextID = 300219}
, 
[201025] = {id = 201025, nameTextID = 300019, exDiscribeTextID = 300220}
, 
[201026] = {id = 201026, nameTextID = 300020, exDiscribeTextID = 300221}
, 
[201027] = {id = 201027, nameTextID = 300021, exDiscribeTextID = 300222}
, 
[201028] = {id = 201028, nameTextID = 300022, exDiscribeTextID = 300223}
, 
[201029] = {id = 201029, nameTextID = 300023, exDiscribeTextID = 300224}
, 
[201030] = {id = 201030, nameTextID = 300024, exDiscribeTextID = 300225}
, 
[201031] = {id = 201031, nameTextID = 300025, exDiscribeTextID = 300226}
, 
[201032] = {id = 201032, nameTextID = 300026, exDiscribeTextID = 300227}
, 
[201033] = {id = 201033, nameTextID = 300027, exDiscribeTextID = 300228}
, 
[201034] = {id = 201034, nameTextID = 300028, exDiscribeTextID = 300229}
, 
[201035] = {id = 201035, nameTextID = 300029, exDiscribeTextID = 300230}
, 
[201036] = {id = 201036, nameTextID = 300030, exDiscribeTextID = 300231}
, 
[201037] = {id = 201037, nameTextID = 300031, exDiscribeTextID = 300232}
, 
[201038] = {id = 201038, nameTextID = 300032, exDiscribeTextID = 300233}
, 
[201039] = {id = 201039, nameTextID = 300033, exDiscribeTextID = 300234}
, 
[201040] = {id = 201040, nameTextID = 300034, exDiscribeTextID = 300235}
, 
[201041] = {id = 201041, nameTextID = 300035, exDiscribeTextID = 300236}
, 
[201042] = {id = 201042, nameTextID = 300036, exDiscribeTextID = 300237}
, 
[201043] = {id = 201043, nameTextID = 300037, exDiscribeTextID = 300238}
, 
[201044] = {id = 201044, nameTextID = 300038, exDiscribeTextID = 300239}
, 
[201045] = {id = 201045, nameTextID = 300039, exDiscribeTextID = 300240}
, 
[201046] = {id = 201046, nameTextID = 300040, exDiscribeTextID = 300241}
, 
[201047] = {id = 201047, nameTextID = 300041, exDiscribeTextID = 300242}
, 
[201048] = {id = 201048, nameTextID = 300042, exDiscribeTextID = 300243}
, 
[201049] = {id = 201049, nameTextID = 300043, exDiscribeTextID = 300244}
, 
[201050] = {id = 201050, nameTextID = 300044, exDiscribeTextID = 300245}
, 
[201051] = {id = 201051, nameTextID = 300045, exDiscribeTextID = 300246}
, 
[201052] = {id = 201052, nameTextID = 300046, exDiscribeTextID = 300247}
, 
[201053] = {id = 201053, nameTextID = 300047, exDiscribeTextID = 300248}
, 
[201054] = {id = 201054, nameTextID = 300048, exDiscribeTextID = 300249}
, 
[201055] = {id = 201055, nameTextID = 300049, exDiscribeTextID = 300250}
, 
[201056] = {id = 201056, nameTextID = 300050, exDiscribeTextID = 300251}
, 
[201057] = {id = 201057, nameTextID = 300051, exDiscribeTextID = 300252}
, 
[201058] = {id = 201058, nameTextID = 300052, exDiscribeTextID = 300253}
, 
[201059] = {id = 201059, nameTextID = 300053, exDiscribeTextID = 300254}
, 
[201060] = {id = 201060, nameTextID = 300054, exDiscribeTextID = 300255}
, 
[201061] = {id = 201061, nameTextID = 300055, exDiscribeTextID = 300256}
, 
[201062] = {id = 201062, nameTextID = 300056, exDiscribeTextID = 300257}
, 
[201063] = {id = 201063, nameTextID = 300057, exDiscribeTextID = 300258}
, 
[201064] = {id = 201064, nameTextID = 300058, exDiscribeTextID = 300259}
, 
[201065] = {id = 201065, nameTextID = 300059, exDiscribeTextID = 300260}
, 
[201066] = {id = 201066, nameTextID = 300060, exDiscribeTextID = 300261}
, 
[201067] = {id = 201067, nameTextID = 300061, exDiscribeTextID = 300262}
, 
[201068] = {id = 201068, nameTextID = 300062, exDiscribeTextID = 300263}
, 
[201069] = {id = 201069, nameTextID = 300063, exDiscribeTextID = 300264}
, 
[201070] = {id = 201070, nameTextID = 300064, exDiscribeTextID = 300265}
, 
[201071] = {id = 201071, nameTextID = 300065, exDiscribeTextID = 300266}
, 
[201072] = {id = 201072, nameTextID = 300066, exDiscribeTextID = 300267}
, 
[201073] = {id = 201073, nameTextID = 300067, exDiscribeTextID = 300268}
, 
[201074] = {id = 201074, nameTextID = 300068, exDiscribeTextID = 300269}
, 
[201075] = {id = 201075, nameTextID = 300069, exDiscribeTextID = 300270}
, 
[201076] = {id = 201076, nameTextID = 300070, exDiscribeTextID = 300271}
, 
[201077] = {id = 201077, nameTextID = 300071, exDiscribeTextID = 300272}
, 
[201078] = {id = 201078, nameTextID = 300072, exDiscribeTextID = 300273}
, 
[201079] = {id = 201079, nameTextID = 300073, exDiscribeTextID = 300274}
, 
[201080] = {id = 201080, nameTextID = 300074, exDiscribeTextID = 300275}
, 
[201081] = {id = 201081, nameTextID = 300075, exDiscribeTextID = 300276}
, 
[201082] = {id = 201082, nameTextID = 300076, exDiscribeTextID = 300277}
, 
[201083] = {id = 201083, nameTextID = 300077, exDiscribeTextID = 300278}
, 
[201084] = {id = 201084, nameTextID = 300078, exDiscribeTextID = 300279}
, 
[201085] = {id = 201085, nameTextID = 300079, exDiscribeTextID = 300280}
, 
[201086] = {id = 201086, nameTextID = 300080, exDiscribeTextID = 300281}
, 
[201088] = {id = 201088, nameTextID = 300081, exDiscribeTextID = 300282}
, 
[201089] = {id = 201089, nameTextID = 300082, exDiscribeTextID = 300283}
, 
[201090] = {id = 201090, nameTextID = 300083, exDiscribeTextID = 300284}
, 
[201092] = {id = 201092, nameTextID = 300084, exDiscribeTextID = 300285}
, 
[201093] = {id = 201093, nameTextID = 300085, exDiscribeTextID = 300286}
, 
[201094] = {id = 201094, nameTextID = 300086, exDiscribeTextID = 300287}
, 
[201095] = {id = 201095, nameTextID = 303155, exDiscribeTextID = 302150}
, 
[201096] = {id = 201096, nameTextID = 303157, exDiscribeTextID = 302151}
, 
[201097] = {id = 201097, nameTextID = 300087, exDiscribeTextID = 300288}
, 
[201098] = {id = 201098, nameTextID = 300088, exDiscribeTextID = 300289}
, 
[201099] = {id = 201099, nameTextID = 300089, exDiscribeTextID = 300290}
, 
[201100] = {id = 201100, nameTextID = 300090, exDiscribeTextID = 300291}
, 
[201101] = {id = 201101, nameTextID = 300091, exDiscribeTextID = 300292}
, 
[201102] = {id = 201102, nameTextID = 300092, exDiscribeTextID = 300293}
, 
[201103] = {id = 201103, nameTextID = 300093, exDiscribeTextID = 300294}
, 
[201104] = {id = 201104, nameTextID = 300094, exDiscribeTextID = 300295}
, 
[201105] = {id = 201105, nameTextID = 300095, exDiscribeTextID = 300296}
, 
[201106] = {id = 201106, nameTextID = 300096, exDiscribeTextID = 300297}
, 
[201107] = {id = 201107, nameTextID = 300097, exDiscribeTextID = 300298}
, 
[201108] = {id = 201108, nameTextID = 300098, exDiscribeTextID = 300299}
, 
[201109] = {id = 201109, nameTextID = 300099, exDiscribeTextID = 300300}
, 
[201110] = {id = 201110, nameTextID = 300100, exDiscribeTextID = 300301}
, 
[201111] = {id = 201111, nameTextID = 300101, exDiscribeTextID = 300302}
, 
[201112] = {id = 201112, nameTextID = 300102, exDiscribeTextID = 300303}
, 
[201113] = {id = 201113, nameTextID = 302152, exDiscribeTextID = 302152}
, 
[201114] = {id = 201114, nameTextID = 303156, exDiscribeTextID = 302152}
, 
[201116] = {id = 201116, nameTextID = 303155, exDiscribeTextID = 302150}
, 
[201117] = {id = 201117, nameTextID = 303155, exDiscribeTextID = 302150}
, 
[201118] = {id = 201118, nameTextID = 300103, exDiscribeTextID = 300304}
, 
[201119] = {id = 201119, nameTextID = 300104, exDiscribeTextID = 300305}
, 
[201120] = {id = 201120, nameTextID = 300105, exDiscribeTextID = 300306}
, 
[201121] = {id = 201121, nameTextID = 303154, exDiscribeTextID = 302153}
, 
[201122] = {id = 201122, nameTextID = 303154, exDiscribeTextID = 302154}
, 
[201123] = {id = 201123, nameTextID = 300106, exDiscribeTextID = 300307}
, 
[201124] = {id = 201124, nameTextID = 300107, exDiscribeTextID = 300308}
, 
[201125] = {id = 201125, nameTextID = 303153, exDiscribeTextID = 302155}
, 
[201126] = {id = 201126, nameTextID = 300108, exDiscribeTextID = 300309}
, 
[201127] = {id = 201127, nameTextID = 303152, exDiscribeTextID = 302156}
, 
[201128] = {id = 201128, nameTextID = 300109, exDiscribeTextID = 300310}
, 
[201129] = {id = 201129, nameTextID = 300110, exDiscribeTextID = 300311}
, 
[201130] = {id = 201130, nameTextID = 300110, exDiscribeTextID = 300312}
, 
[201131] = {id = 201131, nameTextID = 300112, exDiscribeTextID = 300313}
, 
[201132] = {id = 201132, nameTextID = 300113, exDiscribeTextID = 300314}
, 
[201133] = {id = 201133, nameTextID = 300114, exDiscribeTextID = 300315}
, 
[201134] = {id = 201134, nameTextID = 300115, exDiscribeTextID = 300316}
, 
[201135] = {id = 201135, nameTextID = 300116, exDiscribeTextID = 300317}
, 
[201136] = {id = 201136, nameTextID = 300117, exDiscribeTextID = 300318}
, 
[201137] = {id = 201137, nameTextID = 300118, exDiscribeTextID = 300319}
, 
[201138] = {id = 201138, nameTextID = 300119, exDiscribeTextID = 300320}
, 
[201139] = {id = 201139, nameTextID = 300120, exDiscribeTextID = 300321}
, 
[201140] = {id = 201140, nameTextID = 300121, exDiscribeTextID = 300322}
, 
[201141] = {id = 201141, nameTextID = 300122, exDiscribeTextID = 300323}
, 
[201142] = {id = 201142, nameTextID = 300123, exDiscribeTextID = 300324}
, 
[201143] = {id = 201143, nameTextID = 303144, exDiscribeTextID = 302141}
, 
[201144] = {id = 201144, nameTextID = 303144, exDiscribeTextID = 302142}
, 
[201145] = {id = 201145, nameTextID = 300124, exDiscribeTextID = 300325}
, 
[201146] = {id = 201146, nameTextID = 300125, exDiscribeTextID = 300326}
, 
[201147] = {id = 201147, nameTextID = 300126, exDiscribeTextID = 300327}
, 
[201148] = {id = 201148, nameTextID = 300127, exDiscribeTextID = 300328}
, 
[201149] = {id = 201149, nameTextID = 300127, exDiscribeTextID = 302145}
, 
[201150] = {id = 201150, nameTextID = 300128, exDiscribeTextID = 300329}
, 
[201151] = {id = 201151, nameTextID = 300129, exDiscribeTextID = 300330}
, 
[201152] = {id = 201152, nameTextID = 302157, exDiscribeTextID = 302157}
, 
[201153] = {id = 201153, nameTextID = 302158, exDiscribeTextID = 302158}
, 
[201154] = {id = 201154, nameTextID = 302159, exDiscribeTextID = 302159}
, 
[201155] = {id = 201155, nameTextID = 302160, exDiscribeTextID = 302160}
, 
[201156] = {id = 201156, nameTextID = 302161, exDiscribeTextID = 302161}
, 
[201157] = {id = 201157, nameTextID = 302162, exDiscribeTextID = 302162}
, 
[201159] = {id = 201159, nameTextID = 300130, exDiscribeTextID = 300331}
, 
[201160] = {id = 201160, nameTextID = 300131, exDiscribeTextID = 300332}
, 
[201161] = {id = 201161, nameTextID = 300132, exDiscribeTextID = 300333}
, 
[201162] = {id = 201162, nameTextID = 300133, exDiscribeTextID = 300334}
, 
[201164] = {id = 201164, nameTextID = 302163, exDiscribeTextID = 302163}
, 
[201203] = {id = 201203, nameTextID = 300122, exDiscribeTextID = 302143}
, 
[201204] = {id = 201204, nameTextID = 303144, exDiscribeTextID = 302140}
, 
[201205] = {id = 201205, nameTextID = 300128, exDiscribeTextID = 302146}
, 
[201206] = {id = 201206, nameTextID = 300126, exDiscribeTextID = 300327}
, 
[201209] = {id = 201209, nameTextID = 302152, exDiscribeTextID = 302152}
, 
[201210] = {id = 201210, nameTextID = 300071, exDiscribeTextID = 300071}
, 
[201211] = {id = 201211, nameTextID = 300125, exDiscribeTextID = 300125}
, 
[201212] = {id = 201212, nameTextID = 300127, exDiscribeTextID = 302144}
, 
[201213] = {id = 201213, nameTextID = 303145, exDiscribeTextID = 302139}
, 
[201214] = {id = 201214, nameTextID = 300160, exDiscribeTextID = 300160}
, 
[201215] = {id = 201215, nameTextID = 302024, exDiscribeTextID = 302025}
, 
[201216] = {id = 201216, nameTextID = 300134, exDiscribeTextID = 300335}
, 
[201217] = {id = 201217, nameTextID = 300135, exDiscribeTextID = 300336}
, 
[201218] = {id = 201218, nameTextID = 300136, exDiscribeTextID = 300337}
, 
[201219] = {id = 201219, nameTextID = 300137, exDiscribeTextID = 300338}
, 
[201220] = {id = 201220, nameTextID = 300313, exDiscribeTextID = 300313}
, 
[201221] = {id = 201221, nameTextID = 300138, exDiscribeTextID = 300339}
, 
[201222] = {id = 201222, nameTextID = 300139, exDiscribeTextID = 300340}
, 
[201223] = {id = 201223, nameTextID = 300140, exDiscribeTextID = 300341}
, 
[201224] = {id = 201224, nameTextID = 300016, exDiscribeTextID = 300016}
, 
[201225] = {id = 201225, nameTextID = 300141, exDiscribeTextID = 300342}
, 
[201226] = {id = 201226, nameTextID = 300142, exDiscribeTextID = 300343}
, 
[201227] = {id = 201227, nameTextID = 300143, exDiscribeTextID = 300344}
, 
[201228] = {id = 201228, nameTextID = 300144, exDiscribeTextID = 300345}
, 
[201229] = {id = 201229, nameTextID = 300145, exDiscribeTextID = 300346}
, 
[201231] = {id = 201231, nameTextID = 300146, exDiscribeTextID = 300347}
, 
[201232] = {id = 201232, nameTextID = 300146, exDiscribeTextID = 300146}
, 
[201233] = {id = 201233, nameTextID = 300147, exDiscribeTextID = 300348}
, 
[201234] = {id = 201234, nameTextID = 300148, exDiscribeTextID = 300349}
, 
[201235] = {id = 201235, nameTextID = 300149, exDiscribeTextID = 300350}
, 
[201236] = {id = 201236, nameTextID = 300150, exDiscribeTextID = 300351}
, 
[201237] = {id = 201237, nameTextID = 300151, exDiscribeTextID = 300352}
, 
[201238] = {id = 201238, nameTextID = 300152, exDiscribeTextID = 300353}
, 
[201239] = {id = 201239, nameTextID = 300153, exDiscribeTextID = 300354}
, 
[201240] = {id = 201240, nameTextID = 300154, exDiscribeTextID = 300355}
, 
[201241] = {id = 201241, nameTextID = 300155, exDiscribeTextID = 300356}
, 
[201242] = {id = 201242, nameTextID = 300156, exDiscribeTextID = 300357}
, 
[201243] = {id = 201243, nameTextID = 300157, exDiscribeTextID = 300358}
, 
[201244] = {id = 201244, nameTextID = 300158, exDiscribeTextID = 300359}
, 
[201245] = {id = 201245, nameTextID = 300159, exDiscribeTextID = 300360}
, 
[201246] = {id = 201246, nameTextID = 300160, exDiscribeTextID = 300361}
, 
[201247] = {id = 201247, nameTextID = 300161, exDiscribeTextID = 300362}
, 
[201248] = {id = 201248, nameTextID = 300162, exDiscribeTextID = 300363}
, 
[201249] = {id = 201249, nameTextID = 300163, exDiscribeTextID = 300364}
, 
[201250] = {id = 201250, nameTextID = 300164, exDiscribeTextID = 300365}
, 
[201251] = {id = 201251, nameTextID = 300165, exDiscribeTextID = 300366}
, 
[201252] = {id = 201252, nameTextID = 300166, exDiscribeTextID = 300367}
, 
[201253] = {id = 201253, nameTextID = 300167, exDiscribeTextID = 300368}
, 
[201254] = {id = 201254, nameTextID = 300002, exDiscribeTextID = 300002}
, 
[201256] = {id = 201256, nameTextID = 300032, exDiscribeTextID = 300032}
, 
[201257] = {id = 201257, nameTextID = 300033, exDiscribeTextID = 300033}
, 
[201258] = {id = 201258, nameTextID = 300034, exDiscribeTextID = 300034}
, 
[201259] = {id = 201259, nameTextID = 300036, exDiscribeTextID = 300036}
, 
[201260] = {id = 201260, nameTextID = 300006, exDiscribeTextID = 300006}
, 
[201261] = {id = 201261, nameTextID = 300041, exDiscribeTextID = 300041}
, 
[201262] = {id = 201262, nameTextID = 300008, exDiscribeTextID = 300008}
, 
[201264] = {id = 201264, nameTextID = 300034, exDiscribeTextID = 300034}
, 
[201265] = {id = 201265, nameTextID = 302165, exDiscribeTextID = 302165}
, 
[201267] = {id = 201267, nameTextID = 303869, exDiscribeTextID = 303889}
, 
[201268] = {id = 201268, nameTextID = 303870, exDiscribeTextID = 303890}
, 
[201269] = {id = 201269, nameTextID = 303871, exDiscribeTextID = 303891}
, 
[201270] = {id = 201270, nameTextID = 303872, exDiscribeTextID = 303892}
, 
[201271] = {id = 201271, nameTextID = 303873, exDiscribeTextID = 303893}
, 
[201272] = {id = 201272, nameTextID = 300133, exDiscribeTextID = 300133}
, 
[201273] = {id = 201273, nameTextID = 300168, exDiscribeTextID = 300369}
, 
[201274] = {id = 201274, nameTextID = 300169, exDiscribeTextID = 300370}
, 
[201275] = {id = 201275, nameTextID = 300170, exDiscribeTextID = 300371}
, 
[201276] = {id = 201276, nameTextID = 300171, exDiscribeTextID = 300372}
, 
[201277] = {id = 201277, nameTextID = 300172, exDiscribeTextID = 300373}
, 
[201278] = {id = 201278, nameTextID = 300173, exDiscribeTextID = 300374}
, 
[201279] = {id = 201279, nameTextID = 300174, exDiscribeTextID = 300375}
, 
[201280] = {id = 201280, nameTextID = 300175, exDiscribeTextID = 300376}
, 
[201281] = {id = 201281, nameTextID = 300176, exDiscribeTextID = 300377}
, 
[201282] = {id = 201282, nameTextID = 300177, exDiscribeTextID = 300378}
, 
[201283] = {id = 201283, nameTextID = 300178, exDiscribeTextID = 300379}
, 
[201284] = {id = 201284, nameTextID = 300179, exDiscribeTextID = 300380}
, 
[201285] = {id = 201285, nameTextID = 300180, exDiscribeTextID = 300381}
, 
[201286] = {id = 201286, nameTextID = 300181, exDiscribeTextID = 300382}
, 
[201287] = {id = 201287, nameTextID = 300182, exDiscribeTextID = 300383}
, 
[201288] = {id = 201288, nameTextID = 300183, exDiscribeTextID = 300384}
, 
[201290] = {id = 201290, nameTextID = 303864, exDiscribeTextID = 303884}
, 
[201291] = {id = 201291, nameTextID = 300131, exDiscribeTextID = 300131}
, 
[201292] = {id = 201292, nameTextID = 303151, exDiscribeTextID = 302139}
, 
[201293] = {id = 201293, nameTextID = 300138, exDiscribeTextID = 300138}
, 
[201294] = {id = 201294, nameTextID = 303150, exDiscribeTextID = 302136}
, 
[201295] = {id = 201295, nameTextID = 302168, exDiscribeTextID = 302168}
, 
[201296] = {id = 201296, nameTextID = 300020, exDiscribeTextID = 300020}
, 
[201297] = {id = 201297, nameTextID = 300025, exDiscribeTextID = 300025}
, 
[201300] = {id = 201300, nameTextID = 300032, exDiscribeTextID = 300032}
, 
[201301] = {id = 201301, nameTextID = 300033, exDiscribeTextID = 300033}
, 
[201302] = {id = 201302, nameTextID = 300034, exDiscribeTextID = 300034}
, 
[201303] = {id = 201303, nameTextID = 300036, exDiscribeTextID = 300036}
, 
[201304] = {id = 201304, nameTextID = 300137, exDiscribeTextID = 300032}
, 
[201305] = {id = 201305, nameTextID = 300133, exDiscribeTextID = 300133}
, 
[201306] = {id = 201306, nameTextID = 300131, exDiscribeTextID = 300131}
, 
[201307] = {id = 201307, nameTextID = 303146, exDiscribeTextID = 302136}
, 
[201308] = {id = 201308, nameTextID = 300184, exDiscribeTextID = 300385}
, 
[201309] = {id = 201309, nameTextID = 300185, exDiscribeTextID = 300386}
, 
[201310] = {id = 201310, nameTextID = 300186, exDiscribeTextID = 300387}
, 
[201311] = {id = 201311, nameTextID = 300187, exDiscribeTextID = 300388}
, 
[201312] = {id = 201312, nameTextID = 300188, exDiscribeTextID = 300389}
, 
[201313] = {id = 201313, nameTextID = 300189, exDiscribeTextID = 300390}
, 
[201314] = {id = 201314, nameTextID = 300190, exDiscribeTextID = 300391}
, 
[201315] = {id = 201315, nameTextID = 300191, exDiscribeTextID = 300392}
, 
[201316] = {id = 201316, nameTextID = 300192, exDiscribeTextID = 300393}
, 
[201317] = {id = 201317, nameTextID = 300193, exDiscribeTextID = 300394}
, 
[201318] = {id = 201318, nameTextID = 300194, exDiscribeTextID = 300395}
, 
[201319] = {id = 201319, nameTextID = 300195, exDiscribeTextID = 300396}
, 
[201320] = {id = 201320, nameTextID = 303149, exDiscribeTextID = 302139}
, 
[201321] = {id = 201321, nameTextID = 300196, exDiscribeTextID = 300397}
, 
[201322] = {id = 201322, nameTextID = 300197, exDiscribeTextID = 300398}
, 
[201323] = {id = 201323, nameTextID = 300198, exDiscribeTextID = 300399}
, 
[201324] = {id = 201324, nameTextID = 300199, exDiscribeTextID = 300400}
, 
[201325] = {id = 201325, nameTextID = 300200, exDiscribeTextID = 300401}
, 
[201326] = {id = 201326, nameTextID = 300201, exDiscribeTextID = 300402}
, 
[201331] = {id = 201331, nameTextID = 302913, exDiscribeTextID = 302134}
, 
[201333] = {id = 201333, nameTextID = 300111, exDiscribeTextID = 302135}
, 
[201334] = {id = 201334, nameTextID = 300199, exDiscribeTextID = 300199}
, 
[201336] = {id = 201336, nameTextID = 303148, exDiscribeTextID = 302143}
, 
[201337] = {id = 201337, nameTextID = 303148, exDiscribeTextID = 302143}
, 
[201365] = {id = 201365, nameTextID = 300449, exDiscribeTextID = 300449}
, 
[201368] = {id = 201368, nameTextID = 302166, exDiscribeTextID = 302166}
, 
[201369] = {id = 201369, nameTextID = 302167, exDiscribeTextID = 302167}
, 
[201373] = {id = 201373, nameTextID = 302709, exDiscribeTextID = 302137}
, 
[201374] = {id = 201374, nameTextID = 302709, exDiscribeTextID = 302138}
, 
[201376] = {id = 201376, nameTextID = 300449, exDiscribeTextID = 300449}
, 
[201384] = {id = 201384, nameTextID = 301176, exDiscribeTextID = 301176}
, 
[201385] = {id = 201385, nameTextID = 301176, exDiscribeTextID = 301176}
, 
[201388] = {id = 201388, nameTextID = 300148, exDiscribeTextID = 302149}
, 
[201389] = {id = 201389, nameTextID = 300157, exDiscribeTextID = 300157}
, 
[201391] = {id = 201391, nameTextID = 300130, exDiscribeTextID = 300130}
, 
[201392] = {id = 201392, nameTextID = 302231, exDiscribeTextID = 302235}
, 
[201393] = {id = 201393, nameTextID = 302232, exDiscribeTextID = 302236}
, 
[201394] = {id = 201394, nameTextID = 302233, exDiscribeTextID = 302237}
, 
[201395] = {id = 201395, nameTextID = 302234, exDiscribeTextID = 302238}
, 
[201396] = {id = 201396, nameTextID = 302234, exDiscribeTextID = 302239}
, 
[201397] = {id = 201397, nameTextID = 302234, exDiscribeTextID = 302240}
, 
[201398] = {id = 201398, nameTextID = 302234, exDiscribeTextID = 302241}
, 
[201399] = {id = 201399, nameTextID = 302234, exDiscribeTextID = 302242}
, 
[201400] = {id = 201400, nameTextID = 302563, exDiscribeTextID = 302606}
, 
[201401] = {id = 201401, nameTextID = 302564, exDiscribeTextID = 302607}
, 
[201402] = {id = 201402, nameTextID = 302565, exDiscribeTextID = 302608}
, 
[201403] = {id = 201403, nameTextID = 302566, exDiscribeTextID = 302609}
, 
[201404] = {id = 201404, nameTextID = 302667, exDiscribeTextID = 302681}
, 
[201405] = {id = 201405, nameTextID = 302669, exDiscribeTextID = 302683}
, 
[201412] = {id = 201412, nameTextID = 302658, exDiscribeTextID = 302663}
, 
[201413] = {id = 201413, nameTextID = 302657, exDiscribeTextID = 302662}
, 
[201415] = {id = 201415, nameTextID = 302659, exDiscribeTextID = 302664}
, 
[201416] = {id = 201416, nameTextID = 302695, exDiscribeTextID = 302697}
, 
[201417] = {id = 201417, nameTextID = 302696, exDiscribeTextID = 302698}
, 
[201418] = {id = 201418, nameTextID = 302699, exDiscribeTextID = 302701}
, 
[201419] = {id = 201419, nameTextID = 302700, exDiscribeTextID = 302702}
, 
[201420] = {id = 201420, nameTextID = 302703, exDiscribeTextID = 302706}
, 
[201421] = {id = 201421, nameTextID = 302704, exDiscribeTextID = 302707}
, 
[201422] = {id = 201422, nameTextID = 302705, exDiscribeTextID = 302708}
, 
[201423] = {id = 201423, nameTextID = 302567, exDiscribeTextID = 302610}
, 
[201424] = {id = 201424, nameTextID = 302568, exDiscribeTextID = 302611}
, 
[201425] = {id = 201425, nameTextID = 302569, exDiscribeTextID = 302612}
, 
[201426] = {id = 201426, nameTextID = 302570, exDiscribeTextID = 302613}
, 
[201427] = {id = 201427, nameTextID = 302571, exDiscribeTextID = 302614}
, 
[201428] = {id = 201428, nameTextID = 302572, exDiscribeTextID = 302615}
, 
[201429] = {id = 201429, nameTextID = 302555, exDiscribeTextID = 302556}
, 
[201430] = {id = 201430, nameTextID = 302557, exDiscribeTextID = 302558}
, 
[201432] = {id = 201432, nameTextID = 302559, exDiscribeTextID = 302560}
, 
[201433] = {id = 201433, nameTextID = 302561, exDiscribeTextID = 302562}
, 
[201435] = {id = 201435, nameTextID = 302679, exDiscribeTextID = 302693}
, 
[201436] = {id = 201436, nameTextID = 302680, exDiscribeTextID = 302694}
, 
[201437] = {id = 201437, nameTextID = 302678, exDiscribeTextID = 302692}
, 
[201439] = {id = 201439, nameTextID = 302675, exDiscribeTextID = 302689}
, 
[201441] = {id = 201441, nameTextID = 302676, exDiscribeTextID = 302690}
, 
[201443] = {id = 201443, nameTextID = 302677, exDiscribeTextID = 302691}
, 
[201444] = {id = 201444, nameTextID = 302545, exDiscribeTextID = 302546}
, 
[201445] = {id = 201445, nameTextID = 302547, exDiscribeTextID = 302548}
, 
[201446] = {id = 201446, nameTextID = 302549, exDiscribeTextID = 302550}
, 
[201447] = {id = 201447, nameTextID = 302551, exDiscribeTextID = 302552}
, 
[201449] = {id = 201449, nameTextID = 302553, exDiscribeTextID = 302554}
, 
[201450] = {id = 201450, nameTextID = 302408, exDiscribeTextID = 302471}
, 
[201451] = {id = 201451, nameTextID = 302409, exDiscribeTextID = 302472}
, 
[201452] = {id = 201452, nameTextID = 302410, exDiscribeTextID = 302473}
, 
[201453] = {id = 201453, nameTextID = 302411, exDiscribeTextID = 302474}
, 
[201454] = {id = 201454, nameTextID = 302412, exDiscribeTextID = 302475}
, 
[201455] = {id = 201455, nameTextID = 302413, exDiscribeTextID = 302476}
, 
[201456] = {id = 201456, nameTextID = 302414, exDiscribeTextID = 302477}
, 
[201457] = {id = 201457, nameTextID = 302415, exDiscribeTextID = 302478}
, 
[201458] = {id = 201458, nameTextID = 302416, exDiscribeTextID = 302479}
, 
[201459] = {id = 201459, nameTextID = 302417, exDiscribeTextID = 302480}
, 
[201460] = {id = 201460, nameTextID = 302418, exDiscribeTextID = 302481}
, 
[201461] = {id = 201461, nameTextID = 302419, exDiscribeTextID = 302482}
, 
[201462] = {id = 201462, nameTextID = 302420, exDiscribeTextID = 302483}
, 
[201463] = {id = 201463, nameTextID = 302421, exDiscribeTextID = 302484}
, 
[201464] = {id = 201464, nameTextID = 302422, exDiscribeTextID = 302485}
, 
[201465] = {id = 201465, nameTextID = 302423, exDiscribeTextID = 302486}
, 
[201466] = {id = 201466, nameTextID = 302424, exDiscribeTextID = 302487}
, 
[201467] = {id = 201467, nameTextID = 302425, exDiscribeTextID = 302488}
, 
[201468] = {id = 201468, nameTextID = 302426, exDiscribeTextID = 302489}
, 
[201469] = {id = 201469, nameTextID = 302427, exDiscribeTextID = 302490}
, 
[201470] = {id = 201470, nameTextID = 302428, exDiscribeTextID = 302491}
, 
[201471] = {id = 201471, nameTextID = 302429, exDiscribeTextID = 302492}
, 
[201472] = {id = 201472, nameTextID = 302430, exDiscribeTextID = 302493}
, 
[201473] = {id = 201473, nameTextID = 302573, exDiscribeTextID = 302616}
, 
[201474] = {id = 201474, nameTextID = 302574, exDiscribeTextID = 302617}
, 
[201476] = {id = 201476, nameTextID = 302517, exDiscribeTextID = 302518}
, 
[201477] = {id = 201477, nameTextID = 302519, exDiscribeTextID = 302520}
, 
[201479] = {id = 201479, nameTextID = 302521, exDiscribeTextID = 302522}
, 
[201480] = {id = 201480, nameTextID = 302523, exDiscribeTextID = 302524}
, 
[201486] = {id = 201486, nameTextID = 303147, exDiscribeTextID = 302383}
, 
[201487] = {id = 201487, nameTextID = 302525, exDiscribeTextID = 302526}
, 
[201489] = {id = 201489, nameTextID = 302527, exDiscribeTextID = 302528}
, 
[201490] = {id = 201490, nameTextID = 302649, exDiscribeTextID = 302652}
, 
[201491] = {id = 201491, nameTextID = 302650, exDiscribeTextID = 302653}
, 
[201492] = {id = 201492, nameTextID = 302651, exDiscribeTextID = 302654}
, 
[201493] = {id = 201493, nameTextID = 302529, exDiscribeTextID = 302530}
, 
[201494] = {id = 201494, nameTextID = 302531, exDiscribeTextID = 302532}
, 
[201495] = {id = 201495, nameTextID = 302531, exDiscribeTextID = 302534}
, 
[201497] = {id = 201497, nameTextID = 302535, exDiscribeTextID = 302536}
, 
[201505] = {id = 201505, nameTextID = 302575, exDiscribeTextID = 302618}
, 
[201506] = {id = 201506, nameTextID = 302576, exDiscribeTextID = 302619}
, 
[201507] = {id = 201507, nameTextID = 302577, exDiscribeTextID = 302620}
, 
[201508] = {id = 201508, nameTextID = 302578, exDiscribeTextID = 302621}
, 
[201509] = {id = 201509, nameTextID = 302579, exDiscribeTextID = 302622}
, 
[201510] = {id = 201510, nameTextID = 302580, exDiscribeTextID = 302623}
, 
[201511] = {id = 201511, nameTextID = 302581, exDiscribeTextID = 302624}
, 
[201512] = {id = 201512, nameTextID = 302582, exDiscribeTextID = 302625}
, 
[201513] = {id = 201513, nameTextID = 302583, exDiscribeTextID = 302626}
, 
[201514] = {id = 201514, nameTextID = 302584, exDiscribeTextID = 302627}
, 
[201515] = {id = 201515, nameTextID = 302585, exDiscribeTextID = 302628}
, 
[201516] = {id = 201516, nameTextID = 302586, exDiscribeTextID = 302629}
, 
[201519] = {id = 201519, nameTextID = 302587, exDiscribeTextID = 302630}
, 
[201520] = {id = 201520, nameTextID = 302588, exDiscribeTextID = 302631}
, 
[201522] = {id = 201522, nameTextID = 302670, exDiscribeTextID = 302684}
, 
[201523] = {id = 201523, nameTextID = 302672, exDiscribeTextID = 302686}
, 
[201524] = {id = 201524, nameTextID = 302671, exDiscribeTextID = 302685}
, 
[201525] = {id = 201525, nameTextID = 302589, exDiscribeTextID = 302632}
, 
[201526] = {id = 201526, nameTextID = 302590, exDiscribeTextID = 302633}
, 
[201527] = {id = 201527, nameTextID = 302591, exDiscribeTextID = 302634}
, 
[201528] = {id = 201528, nameTextID = 302592, exDiscribeTextID = 302635}
, 
[201529] = {id = 201529, nameTextID = 302593, exDiscribeTextID = 302636}
, 
[201530] = {id = 201530, nameTextID = 302594, exDiscribeTextID = 302637}
, 
[201531] = {id = 201531, nameTextID = 302595, exDiscribeTextID = 302638}
, 
[201532] = {id = 201532, nameTextID = 302596, exDiscribeTextID = 302639}
, 
[201533] = {id = 201533, nameTextID = 302597, exDiscribeTextID = 302640}
, 
[201534] = {id = 201534, nameTextID = 302598, exDiscribeTextID = 302641}
, 
[201535] = {id = 201535, nameTextID = 302599, exDiscribeTextID = 302642}
, 
[201536] = {id = 201536, nameTextID = 302600, exDiscribeTextID = 302643}
, 
[201538] = {id = 201538, nameTextID = 302655, exDiscribeTextID = 302656}
, 
[201539] = {id = 201539, nameTextID = 302447, exDiscribeTextID = 302510}
, 
[201540] = {id = 201540, nameTextID = 302448, exDiscribeTextID = 302511}
, 
[201541] = {id = 201541, nameTextID = 302449, exDiscribeTextID = 302512}
, 
[201542] = {id = 201542, nameTextID = 302450, exDiscribeTextID = 302513}
, 
[201543] = {id = 201543, nameTextID = 302451, exDiscribeTextID = 302514}
, 
[201544] = {id = 201544, nameTextID = 302452, exDiscribeTextID = 302515}
, 
[201545] = {id = 201545, nameTextID = 302537, exDiscribeTextID = 302538}
, 
[201546] = {id = 201546, nameTextID = 302539, exDiscribeTextID = 302540}
, 
[201548] = {id = 201548, nameTextID = 302541, exDiscribeTextID = 302542}
, 
[201549] = {id = 201549, nameTextID = 302543, exDiscribeTextID = 302544}
, 
[201550] = {id = 201550, nameTextID = 302431, exDiscribeTextID = 302494}
, 
[201551] = {id = 201551, nameTextID = 302432, exDiscribeTextID = 302495}
, 
[201552] = {id = 201552, nameTextID = 302433, exDiscribeTextID = 302496}
, 
[201553] = {id = 201553, nameTextID = 302434, exDiscribeTextID = 302497}
, 
[201554] = {id = 201554, nameTextID = 302435, exDiscribeTextID = 302498}
, 
[201555] = {id = 201555, nameTextID = 302436, exDiscribeTextID = 302499}
, 
[201556] = {id = 201556, nameTextID = 302437, exDiscribeTextID = 302500}
, 
[201557] = {id = 201557, nameTextID = 302438, exDiscribeTextID = 302501}
, 
[201558] = {id = 201558, nameTextID = 302439, exDiscribeTextID = 302502}
, 
[201559] = {id = 201559, nameTextID = 302440, exDiscribeTextID = 302503}
, 
[201561] = {id = 201561, nameTextID = 302601, exDiscribeTextID = 302644}
, 
[201562] = {id = 201562, nameTextID = 302602, exDiscribeTextID = 302645}
, 
[201563] = {id = 201563, nameTextID = 302603, exDiscribeTextID = 302646}
, 
[201564] = {id = 201564, nameTextID = 302604, exDiscribeTextID = 302647}
, 
[201565] = {id = 201565, nameTextID = 302605, exDiscribeTextID = 302648}
, 
[201566] = {id = 201566, nameTextID = 302391, exDiscribeTextID = 302453}
, 
[201567] = {id = 201567, nameTextID = 302392, exDiscribeTextID = 302454}
, 
[201568] = {id = 201568, nameTextID = 302393, exDiscribeTextID = 302455}
, 
[201569] = {id = 201569, nameTextID = 302394, exDiscribeTextID = 302456}
, 
[201570] = {id = 201570, nameTextID = 302395, exDiscribeTextID = 302457}
, 
[201571] = {id = 201571, nameTextID = 302396, exDiscribeTextID = 302458}
, 
[201572] = {id = 201572, nameTextID = 302397, exDiscribeTextID = 302459}
, 
[201573] = {id = 201573, nameTextID = 302398, exDiscribeTextID = 302460}
, 
[201574] = {id = 201574, nameTextID = 302399, exDiscribeTextID = 302461}
, 
[201575] = {id = 201575, nameTextID = 302400, exDiscribeTextID = 302462}
, 
[201576] = {id = 201576, nameTextID = 302401, exDiscribeTextID = 302463}
, 
[201577] = {id = 201577, nameTextID = 302402, exDiscribeTextID = 302464}
, 
[201578] = {id = 201578, nameTextID = 302403, exDiscribeTextID = 302465}
, 
[201579] = {id = 201579, nameTextID = 302404, exDiscribeTextID = 302466}
, 
[201580] = {id = 201580, nameTextID = 302405, exDiscribeTextID = 302467}
, 
[201581] = {id = 201581, nameTextID = 302406, exDiscribeTextID = 302468}
, 
[201582] = {id = 201582, nameTextID = 302407, exDiscribeTextID = 302469}
, 
[201583] = {id = 201583, nameTextID = 302516, exDiscribeTextID = 302470}
, 
[201588] = {id = 201588, nameTextID = 302441, exDiscribeTextID = 302504}
, 
[201589] = {id = 201589, nameTextID = 302442, exDiscribeTextID = 302505}
, 
[201590] = {id = 201590, nameTextID = 302443, exDiscribeTextID = 302506}
, 
[201591] = {id = 201591, nameTextID = 302444, exDiscribeTextID = 302507}
, 
[201593] = {id = 201593, nameTextID = 302668, exDiscribeTextID = 302682}
, 
[201594] = {id = 201594, nameTextID = 302445, exDiscribeTextID = 302508}
, 
[201597] = {id = 201597, nameTextID = 302673, exDiscribeTextID = 302687}
, 
[201598] = {id = 201598, nameTextID = 302674, exDiscribeTextID = 302688}
, 
[201604] = {id = 201604, nameTextID = 302446, exDiscribeTextID = 302509}
, 
[201641] = {id = 201641, nameTextID = 302938, exDiscribeTextID = 302939}
, 
[201646] = {id = 201646, nameTextID = 303177, exDiscribeTextID = 303191}
, 
[201648] = {id = 201648, nameTextID = 303180, exDiscribeTextID = 303194}
, 
[201649] = {id = 201649, nameTextID = 303181, exDiscribeTextID = 303195}
, 
[201650] = {id = 201650, nameTextID = 303178, exDiscribeTextID = 303192}
, 
[201651] = {id = 201651, nameTextID = 303179, exDiscribeTextID = 303193}
, 
[201652] = {id = 201652, nameTextID = 303182, exDiscribeTextID = 303196}
, 
[201653] = {id = 201653, nameTextID = 303183, exDiscribeTextID = 303197}
, 
[201654] = {id = 201654, nameTextID = 303184, exDiscribeTextID = 303198}
, 
[201655] = {id = 201655, nameTextID = 303185, exDiscribeTextID = 303199}
, 
[201656] = {id = 201656, nameTextID = 303186, exDiscribeTextID = 303200}
, 
[201657] = {id = 201657, nameTextID = 303187, exDiscribeTextID = 303201}
, 
[201658] = {id = 201658, nameTextID = 303188, exDiscribeTextID = 303202}
, 
[201659] = {id = 201659, nameTextID = 303189, exDiscribeTextID = 303203}
, 
[201660] = {id = 201660, nameTextID = 303190, exDiscribeTextID = 303204}
, 
[201663] = {id = 201663, nameTextID = 300012, exDiscribeTextID = 300213}
, 
[201666] = {id = 201666, nameTextID = 303206, exDiscribeTextID = 303215}
, 
[201667] = {id = 201667, nameTextID = 303207, exDiscribeTextID = 303216}
, 
[201668] = {id = 201668, nameTextID = 303208, exDiscribeTextID = 303217}
, 
[201669] = {id = 201669, nameTextID = 303209, exDiscribeTextID = 303218}
, 
[201670] = {id = 201670, nameTextID = 303210, exDiscribeTextID = 303219}
, 
[201671] = {id = 201671, nameTextID = 303211, exDiscribeTextID = 303220}
, 
[201672] = {id = 201672, nameTextID = 303212, exDiscribeTextID = 303221}
, 
[201673] = {id = 201673, nameTextID = 303213, exDiscribeTextID = 303222}
, 
[201674] = {id = 201674, nameTextID = 303214, exDiscribeTextID = 303223}
, 
[201685] = {id = 201685, nameTextID = 303291, exDiscribeTextID = 303292}
, 
[201686] = {id = 201686, nameTextID = 303293, exDiscribeTextID = 303294}
, 
[201687] = {id = 201687, nameTextID = 303295, exDiscribeTextID = 303296}
, 
[201688] = {id = 201688, nameTextID = 303297, exDiscribeTextID = 303298}
, 
[201689] = {id = 201689, nameTextID = 303299, exDiscribeTextID = 303300}
, 
[201690] = {id = 201690, nameTextID = 303301, exDiscribeTextID = 303302}
, 
[201691] = {id = 201691, nameTextID = 303303, exDiscribeTextID = 303304}
, 
[201692] = {id = 201692, nameTextID = 303305, exDiscribeTextID = 303306}
, 
[201693] = {id = 201693, nameTextID = 303307, exDiscribeTextID = 303308}
, 
[201694] = {id = 201694, nameTextID = 303309, exDiscribeTextID = 303310}
, 
[201695] = {id = 201695, nameTextID = 303311, exDiscribeTextID = 303312}
, 
[201696] = {id = 201696, nameTextID = 303313, exDiscribeTextID = 303314}
, 
[201697] = {id = 201697, nameTextID = 303315, exDiscribeTextID = 303316}
, 
[201698] = {id = 201698, nameTextID = 303317, exDiscribeTextID = 303318}
, 
[201699] = {id = 201699, nameTextID = 303319, exDiscribeTextID = 303320}
, 
[201700] = {id = 201700, nameTextID = 303321, exDiscribeTextID = 303322}
, 
[201701] = {id = 201701, nameTextID = 303323, exDiscribeTextID = 303324}
, 
[201707] = {id = 201707, nameTextID = 303383, exDiscribeTextID = 303384}
, 
[201708] = {id = 201708, nameTextID = 303389, exDiscribeTextID = 303390}
, 
[201711] = {id = 201711, nameTextID = 303387, exDiscribeTextID = 303388}
, 
[201714] = {id = 201714, nameTextID = 303385, exDiscribeTextID = 303386}
, 
[201717] = {id = 201717, nameTextID = 303402, exDiscribeTextID = 303403}
, 
[201718] = {id = 201718, nameTextID = 303375, exDiscribeTextID = 303376}
, 
[201719] = {id = 201719, nameTextID = 303377, exDiscribeTextID = 303378}
, 
[201721] = {id = 201721, nameTextID = 303379, exDiscribeTextID = 303380}
, 
[201722] = {id = 201722, nameTextID = 303381, exDiscribeTextID = 303382}
, 
[201733] = {id = 201733, nameTextID = 303416, exDiscribeTextID = 303417}
, 
[201734] = {id = 201734, nameTextID = 303418, exDiscribeTextID = 303419}
, 
[201735] = {id = 201735, nameTextID = 303420, exDiscribeTextID = 303421}
, 
[201736] = {id = 201736, nameTextID = 303422, exDiscribeTextID = 303423}
, 
[201737] = {id = 201737, nameTextID = 303424, exDiscribeTextID = 303425}
, 
[201738] = {id = 201738, nameTextID = 303426, exDiscribeTextID = 303427}
, 
[201739] = {id = 201739, nameTextID = 303428, exDiscribeTextID = 303429}
, 
[201740] = {id = 201740, nameTextID = 303638, exDiscribeTextID = 303644}
, 
[201741] = {id = 201741, nameTextID = 303639, exDiscribeTextID = 303645}
, 
[201750] = {id = 201750, nameTextID = 303640, exDiscribeTextID = 303646}
, 
[201751] = {id = 201751, nameTextID = 303641, exDiscribeTextID = 303647}
, 
[201754] = {id = 201754, nameTextID = 303642, exDiscribeTextID = 303648}
, 
[201755] = {id = 201755, nameTextID = 303643, exDiscribeTextID = 303649}
, 
[201756] = {id = 201756, nameTextID = 303626, exDiscribeTextID = 303632}
, 
[201757] = {id = 201757, nameTextID = 303627, exDiscribeTextID = 303633}
, 
[201758] = {id = 201758, nameTextID = 303628, exDiscribeTextID = 303634}
, 
[201759] = {id = 201759, nameTextID = 303629, exDiscribeTextID = 303635}
, 
[201760] = {id = 201760, nameTextID = 303630, exDiscribeTextID = 303636}
, 
[201761] = {id = 201761, nameTextID = 303631, exDiscribeTextID = 303637}
, 
[201762] = {id = 201762, nameTextID = 303608, exDiscribeTextID = 303612}
, 
[201763] = {id = 201763, nameTextID = 303609, exDiscribeTextID = 303613}
, 
[201764] = {id = 201764, nameTextID = 303610, exDiscribeTextID = 303614}
, 
[201765] = {id = 201765, nameTextID = 303611, exDiscribeTextID = 303615}
, 
[201766] = {id = 201766, nameTextID = 303609, exDiscribeTextID = 303613}
, 
[201767] = {id = 201767, nameTextID = 303611, exDiscribeTextID = 303615}
, 
[201768] = {id = 201768, nameTextID = 303616, exDiscribeTextID = 303620}
, 
[201769] = {id = 201769, nameTextID = 303617, exDiscribeTextID = 303621}
, 
[201770] = {id = 201770, nameTextID = 303618, exDiscribeTextID = 303622}
, 
[201771] = {id = 201771, nameTextID = 303619, exDiscribeTextID = 303623}
, 
[201780] = {id = 201780, nameTextID = 303658, exDiscribeTextID = 303662}
, 
[201781] = {id = 201781, nameTextID = 303659, exDiscribeTextID = 303663}
, 
[201782] = {id = 201782, nameTextID = 303660, exDiscribeTextID = 303664}
, 
[201783] = {id = 201783, nameTextID = 303879, exDiscribeTextID = 303899}
, 
[201784] = {id = 201784, nameTextID = 303880, exDiscribeTextID = 303900}
, 
[201785] = {id = 201785, nameTextID = 303659, exDiscribeTextID = 303663}
, 
[201786] = {id = 201786, nameTextID = 303661, exDiscribeTextID = 303665}
, 
[201787] = {id = 201787, nameTextID = 303666, exDiscribeTextID = 303667}
, 
[201788] = {id = 201788, nameTextID = 303668, exDiscribeTextID = 303670}
, 
[201789] = {id = 201789, nameTextID = 303669, exDiscribeTextID = 303671}
, 
[201790] = {id = 201790, nameTextID = 303650, exDiscribeTextID = 303653}
, 
[201791] = {id = 201791, nameTextID = 303651, exDiscribeTextID = 303654}
, 
[201792] = {id = 201792, nameTextID = 303652, exDiscribeTextID = 303655}
, 
[201794] = {id = 201794, nameTextID = 303566, exDiscribeTextID = 303566}
, 
[201795] = {id = 201795, nameTextID = 303567, exDiscribeTextID = 303567}
, 
[201796] = {id = 201796, nameTextID = 303568, exDiscribeTextID = 303568}
, 
[201797] = {id = 201797, nameTextID = 303569, exDiscribeTextID = 303569}
, 
[201798] = {id = 201798, nameTextID = 303570, exDiscribeTextID = 303570}
, 
[201799] = {id = 201799, nameTextID = 303571, exDiscribeTextID = 303571}
, 
[201808] = {id = 201808, nameTextID = 303588, exDiscribeTextID = 303595}
, 
[201809] = {id = 201809, nameTextID = 303589, exDiscribeTextID = 303596}
, 
[201810] = {id = 201810, nameTextID = 303590, exDiscribeTextID = 303597}
, 
[201812] = {id = 201812, nameTextID = 303591, exDiscribeTextID = 303598}
, 
[201815] = {id = 201815, nameTextID = 303588, exDiscribeTextID = 303595}
, 
[201816] = {id = 201816, nameTextID = 303589, exDiscribeTextID = 303596}
, 
[201817] = {id = 201817, nameTextID = 303590, exDiscribeTextID = 303597}
, 
[201819] = {id = 201819, nameTextID = 303591, exDiscribeTextID = 303598}
, 
[201821] = {id = 201821, nameTextID = 303592, exDiscribeTextID = 303599}
, 
[201822] = {id = 201822, nameTextID = 303593, exDiscribeTextID = 303600}
, 
[201823] = {id = 201823, nameTextID = 303594, exDiscribeTextID = 303601}
, 
[201849] = {id = 201849, nameTextID = 303656, exDiscribeTextID = 303657}
, 
[201851] = {id = 201851, nameTextID = 303602, exDiscribeTextID = 303604}
, 
[201852] = {id = 201852, nameTextID = 303603, exDiscribeTextID = 303605}
, 
[201853] = {id = 201853, nameTextID = 303606, exDiscribeTextID = 303607}
, 
[201860] = {id = 201860, nameTextID = 303719, exDiscribeTextID = 303726}
, 
[201861] = {id = 201861, nameTextID = 303720, exDiscribeTextID = 303727}
, 
[201862] = {id = 201862, nameTextID = 303721, exDiscribeTextID = 303728}
, 
[201863] = {id = 201863, nameTextID = 303722, exDiscribeTextID = 303729}
, 
[201864] = {id = 201864, nameTextID = 303723, exDiscribeTextID = 303730}
, 
[201866] = {id = 201866, nameTextID = 303724, exDiscribeTextID = 303731}
, 
[201867] = {id = 201867, nameTextID = 303725, exDiscribeTextID = 303732}
, 
[300601] = {id = 300601, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300602] = {id = 300602, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300603] = {id = 300603, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300604] = {id = 300604, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300605] = {id = 300605, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300606] = {id = 300606, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300607] = {id = 300607, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300608] = {id = 300608, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300609] = {id = 300609, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300610] = {id = 300610, nameTextID = -1, exDiscribeTextID = 303484}
, 
[300801] = {id = 300801, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300802] = {id = 300802, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300803] = {id = 300803, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300804] = {id = 300804, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300805] = {id = 300805, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300806] = {id = 300806, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300807] = {id = 300807, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300808] = {id = 300808, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300809] = {id = 300809, nameTextID = -1, exDiscribeTextID = 303255}
, 
[300810] = {id = 300810, nameTextID = -1, exDiscribeTextID = 303255}
, 
[301001] = {id = 301001, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301002] = {id = 301002, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301003] = {id = 301003, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301004] = {id = 301004, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301005] = {id = 301005, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301006] = {id = 301006, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301007] = {id = 301007, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301008] = {id = 301008, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301009] = {id = 301009, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301010] = {id = 301010, nameTextID = -1, exDiscribeTextID = 303256}
, 
[301101] = {id = 301101, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301102] = {id = 301102, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301103] = {id = 301103, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301104] = {id = 301104, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301105] = {id = 301105, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301106] = {id = 301106, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301107] = {id = 301107, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301108] = {id = 301108, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301109] = {id = 301109, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301110] = {id = 301110, nameTextID = -1, exDiscribeTextID = 303359}
, 
[301201] = {id = 301201, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301202] = {id = 301202, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301203] = {id = 301203, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301204] = {id = 301204, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301205] = {id = 301205, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301206] = {id = 301206, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301207] = {id = 301207, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301208] = {id = 301208, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301209] = {id = 301209, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301210] = {id = 301210, nameTextID = -1, exDiscribeTextID = 303672}
, 
[301301] = {id = 301301, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301302] = {id = 301302, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301303] = {id = 301303, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301304] = {id = 301304, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301305] = {id = 301305, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301306] = {id = 301306, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301307] = {id = 301307, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301308] = {id = 301308, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301309] = {id = 301309, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301310] = {id = 301310, nameTextID = -1, exDiscribeTextID = 303257}
, 
[301701] = {id = 301701, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301702] = {id = 301702, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301703] = {id = 301703, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301704] = {id = 301704, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301705] = {id = 301705, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301706] = {id = 301706, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301707] = {id = 301707, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301708] = {id = 301708, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301709] = {id = 301709, nameTextID = -1, exDiscribeTextID = 303358}
, 
[301710] = {id = 301710, nameTextID = -1, exDiscribeTextID = 303358}
, 
[302301] = {id = 302301, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302302] = {id = 302302, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302303] = {id = 302303, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302304] = {id = 302304, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302305] = {id = 302305, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302306] = {id = 302306, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302307] = {id = 302307, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302308] = {id = 302308, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302309] = {id = 302309, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302310] = {id = 302310, nameTextID = -1, exDiscribeTextID = 303430}
, 
[302501] = {id = 302501, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302502] = {id = 302502, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302503] = {id = 302503, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302504] = {id = 302504, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302505] = {id = 302505, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302506] = {id = 302506, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302507] = {id = 302507, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302508] = {id = 302508, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302509] = {id = 302509, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302510] = {id = 302510, nameTextID = -1, exDiscribeTextID = 303432}
, 
[302901] = {id = 302901, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302902] = {id = 302902, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302903] = {id = 302903, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302904] = {id = 302904, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302905] = {id = 302905, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302906] = {id = 302906, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302907] = {id = 302907, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302908] = {id = 302908, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302909] = {id = 302909, nameTextID = -1, exDiscribeTextID = 303261}
, 
[302910] = {id = 302910, nameTextID = -1, exDiscribeTextID = 303261}
, 
[303001] = {id = 303001, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303002] = {id = 303002, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303003] = {id = 303003, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303004] = {id = 303004, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303005] = {id = 303005, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303006] = {id = 303006, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303007] = {id = 303007, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303008] = {id = 303008, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303009] = {id = 303009, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303010] = {id = 303010, nameTextID = -1, exDiscribeTextID = 303362}
, 
[303301] = {id = 303301, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303302] = {id = 303302, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303303] = {id = 303303, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303304] = {id = 303304, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303305] = {id = 303305, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303306] = {id = 303306, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303307] = {id = 303307, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303308] = {id = 303308, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303309] = {id = 303309, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303310] = {id = 303310, nameTextID = -1, exDiscribeTextID = 303360}
, 
[303401] = {id = 303401, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303402] = {id = 303402, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303403] = {id = 303403, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303404] = {id = 303404, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303405] = {id = 303405, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303406] = {id = 303406, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303407] = {id = 303407, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303408] = {id = 303408, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303409] = {id = 303409, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303410] = {id = 303410, nameTextID = -1, exDiscribeTextID = 303332}
, 
[303501] = {id = 303501, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303502] = {id = 303502, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303503] = {id = 303503, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303504] = {id = 303504, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303505] = {id = 303505, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303506] = {id = 303506, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303507] = {id = 303507, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303508] = {id = 303508, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303509] = {id = 303509, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303510] = {id = 303510, nameTextID = -1, exDiscribeTextID = 303689}
, 
[303801] = {id = 303801, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303802] = {id = 303802, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303803] = {id = 303803, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303804] = {id = 303804, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303805] = {id = 303805, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303806] = {id = 303806, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303807] = {id = 303807, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303808] = {id = 303808, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303809] = {id = 303809, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303810] = {id = 303810, nameTextID = -1, exDiscribeTextID = 303391}
, 
[303901] = {id = 303901, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303902] = {id = 303902, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303903] = {id = 303903, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303904] = {id = 303904, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303905] = {id = 303905, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303906] = {id = 303906, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303907] = {id = 303907, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303908] = {id = 303908, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303909] = {id = 303909, nameTextID = -1, exDiscribeTextID = 303469}
, 
[303910] = {id = 303910, nameTextID = -1, exDiscribeTextID = 303469}
, 
[304101] = {id = 304101, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304102] = {id = 304102, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304103] = {id = 304103, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304104] = {id = 304104, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304105] = {id = 304105, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304106] = {id = 304106, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304107] = {id = 304107, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304108] = {id = 304108, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304109] = {id = 304109, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304110] = {id = 304110, nameTextID = -1, exDiscribeTextID = 303258}
, 
[304201] = {id = 304201, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304202] = {id = 304202, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304203] = {id = 304203, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304204] = {id = 304204, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304205] = {id = 304205, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304206] = {id = 304206, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304207] = {id = 304207, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304208] = {id = 304208, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304209] = {id = 304209, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304210] = {id = 304210, nameTextID = -1, exDiscribeTextID = 303393}
, 
[304301] = {id = 304301, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304302] = {id = 304302, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304303] = {id = 304303, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304304] = {id = 304304, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304305] = {id = 304305, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304306] = {id = 304306, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304307] = {id = 304307, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304308] = {id = 304308, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304309] = {id = 304309, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304310] = {id = 304310, nameTextID = -1, exDiscribeTextID = 303333}
, 
[304701] = {id = 304701, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304702] = {id = 304702, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304703] = {id = 304703, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304704] = {id = 304704, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304705] = {id = 304705, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304706] = {id = 304706, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304707] = {id = 304707, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304708] = {id = 304708, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304709] = {id = 304709, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304710] = {id = 304710, nameTextID = -1, exDiscribeTextID = 303395}
, 
[304801] = {id = 304801, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304802] = {id = 304802, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304803] = {id = 304803, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304804] = {id = 304804, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304805] = {id = 304805, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304806] = {id = 304806, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304807] = {id = 304807, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304808] = {id = 304808, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304809] = {id = 304809, nameTextID = -1, exDiscribeTextID = 303259}
, 
[304810] = {id = 304810, nameTextID = -1, exDiscribeTextID = 303259}
, 
[305101] = {id = 305101, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305102] = {id = 305102, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305103] = {id = 305103, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305104] = {id = 305104, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305105] = {id = 305105, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305106] = {id = 305106, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305107] = {id = 305107, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305108] = {id = 305108, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305109] = {id = 305109, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305110] = {id = 305110, nameTextID = -1, exDiscribeTextID = 303762}
, 
[305301] = {id = 305301, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305302] = {id = 305302, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305303] = {id = 305303, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305304] = {id = 305304, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305305] = {id = 305305, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305306] = {id = 305306, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305307] = {id = 305307, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305308] = {id = 305308, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305309] = {id = 305309, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305310] = {id = 305310, nameTextID = -1, exDiscribeTextID = 303485}
, 
[305501] = {id = 305501, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305502] = {id = 305502, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305503] = {id = 305503, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305504] = {id = 305504, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305505] = {id = 305505, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305506] = {id = 305506, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305507] = {id = 305507, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305508] = {id = 305508, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305509] = {id = 305509, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305510] = {id = 305510, nameTextID = -1, exDiscribeTextID = 303434}
, 
[305601] = {id = 305601, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305602] = {id = 305602, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305603] = {id = 305603, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305604] = {id = 305604, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305605] = {id = 305605, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305606] = {id = 305606, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305607] = {id = 305607, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305608] = {id = 305608, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305609] = {id = 305609, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305610] = {id = 305610, nameTextID = -1, exDiscribeTextID = 303330}
, 
[305901] = {id = 305901, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305902] = {id = 305902, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305903] = {id = 305903, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305904] = {id = 305904, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305905] = {id = 305905, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305906] = {id = 305906, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305907] = {id = 305907, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305908] = {id = 305908, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305909] = {id = 305909, nameTextID = -1, exDiscribeTextID = 303361}
, 
[305910] = {id = 305910, nameTextID = -1, exDiscribeTextID = 303361}
, 
[306301] = {id = 306301, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306302] = {id = 306302, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306303] = {id = 306303, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306304] = {id = 306304, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306305] = {id = 306305, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306306] = {id = 306306, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306307] = {id = 306307, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306308] = {id = 306308, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306309] = {id = 306309, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306310] = {id = 306310, nameTextID = -1, exDiscribeTextID = 303392}
, 
[306401] = {id = 306401, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306402] = {id = 306402, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306403] = {id = 306403, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306404] = {id = 306404, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306405] = {id = 306405, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306406] = {id = 306406, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306407] = {id = 306407, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306408] = {id = 306408, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306409] = {id = 306409, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306410] = {id = 306410, nameTextID = -1, exDiscribeTextID = 303462}
, 
[306501] = {id = 306501, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306502] = {id = 306502, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306503] = {id = 306503, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306504] = {id = 306504, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306505] = {id = 306505, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306506] = {id = 306506, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306507] = {id = 306507, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306508] = {id = 306508, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306509] = {id = 306509, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306510] = {id = 306510, nameTextID = -1, exDiscribeTextID = 303433}
, 
[306601] = {id = 306601, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306602] = {id = 306602, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306603] = {id = 306603, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306604] = {id = 306604, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306605] = {id = 306605, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306606] = {id = 306606, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306607] = {id = 306607, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306608] = {id = 306608, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306609] = {id = 306609, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306610] = {id = 306610, nameTextID = -1, exDiscribeTextID = 303579}
, 
[306901] = {id = 306901, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306902] = {id = 306902, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306903] = {id = 306903, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306904] = {id = 306904, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306905] = {id = 306905, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306906] = {id = 306906, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306907] = {id = 306907, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306908] = {id = 306908, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306909] = {id = 306909, nameTextID = -1, exDiscribeTextID = 303394}
, 
[306910] = {id = 306910, nameTextID = -1, exDiscribeTextID = 303394}
, 
[307001] = {id = 307001, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307002] = {id = 307002, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307003] = {id = 307003, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307004] = {id = 307004, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307005] = {id = 307005, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307006] = {id = 307006, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307007] = {id = 307007, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307008] = {id = 307008, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307009] = {id = 307009, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307010] = {id = 307010, nameTextID = -1, exDiscribeTextID = 303331}
, 
[307101] = {id = 307101, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307102] = {id = 307102, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307103] = {id = 307103, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307104] = {id = 307104, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307105] = {id = 307105, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307106] = {id = 307106, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307107] = {id = 307107, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307108] = {id = 307108, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307109] = {id = 307109, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307110] = {id = 307110, nameTextID = -1, exDiscribeTextID = 303544}
, 
[307201] = {id = 307201, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307202] = {id = 307202, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307203] = {id = 307203, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307204] = {id = 307204, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307205] = {id = 307205, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307206] = {id = 307206, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307207] = {id = 307207, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307208] = {id = 307208, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307209] = {id = 307209, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307210] = {id = 307210, nameTextID = -1, exDiscribeTextID = 303431}
, 
[307901] = {id = 307901, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307902] = {id = 307902, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307903] = {id = 307903, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307904] = {id = 307904, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307905] = {id = 307905, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307906] = {id = 307906, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307907] = {id = 307907, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307908] = {id = 307908, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307909] = {id = 307909, nameTextID = -1, exDiscribeTextID = 303484}
, 
[307910] = {id = 307910, nameTextID = -1, exDiscribeTextID = 303484}
, 
[308001] = {id = 308001, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308002] = {id = 308002, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308003] = {id = 308003, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308004] = {id = 308004, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308005] = {id = 308005, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308006] = {id = 308006, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308007] = {id = 308007, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308008] = {id = 308008, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308009] = {id = 308009, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308010] = {id = 308010, nameTextID = -1, exDiscribeTextID = 303747}
, 
[308101] = {id = 308101, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308102] = {id = 308102, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308103] = {id = 308103, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308104] = {id = 308104, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308105] = {id = 308105, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308106] = {id = 308106, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308107] = {id = 308107, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308108] = {id = 308108, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308109] = {id = 308109, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308110] = {id = 308110, nameTextID = -1, exDiscribeTextID = 303580}
, 
[308201] = {id = 308201, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308202] = {id = 308202, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308203] = {id = 308203, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308204] = {id = 308204, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308205] = {id = 308205, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308206] = {id = 308206, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308207] = {id = 308207, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308208] = {id = 308208, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308209] = {id = 308209, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308210] = {id = 308210, nameTextID = -1, exDiscribeTextID = 303814}
, 
[308301] = {id = 308301, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308302] = {id = 308302, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308303] = {id = 308303, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308304] = {id = 308304, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308305] = {id = 308305, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308306] = {id = 308306, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308307] = {id = 308307, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308308] = {id = 308308, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308309] = {id = 308309, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308310] = {id = 308310, nameTextID = -1, exDiscribeTextID = 303681}
, 
[308401] = {id = 308401, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308402] = {id = 308402, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308403] = {id = 308403, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308404] = {id = 308404, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308405] = {id = 308405, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308406] = {id = 308406, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308407] = {id = 308407, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308408] = {id = 308408, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308409] = {id = 308409, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308410] = {id = 308410, nameTextID = -1, exDiscribeTextID = 303558}
, 
[308501] = {id = 308501, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308502] = {id = 308502, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308503] = {id = 308503, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308504] = {id = 308504, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308505] = {id = 308505, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308506] = {id = 308506, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308507] = {id = 308507, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308508] = {id = 308508, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308509] = {id = 308509, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308510] = {id = 308510, nameTextID = -1, exDiscribeTextID = 303551}
, 
[308801] = {id = 308801, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308802] = {id = 308802, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308803] = {id = 308803, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308804] = {id = 308804, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308805] = {id = 308805, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308806] = {id = 308806, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308807] = {id = 308807, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308808] = {id = 308808, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308809] = {id = 308809, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308810] = {id = 308810, nameTextID = -1, exDiscribeTextID = 303679}
, 
[308901] = {id = 308901, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308902] = {id = 308902, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308903] = {id = 308903, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308904] = {id = 308904, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308905] = {id = 308905, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308906] = {id = 308906, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308907] = {id = 308907, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308908] = {id = 308908, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308909] = {id = 308909, nameTextID = -1, exDiscribeTextID = 303470}
, 
[308910] = {id = 308910, nameTextID = -1, exDiscribeTextID = 303470}
, 
[309001] = {id = 309001, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309002] = {id = 309002, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309003] = {id = 309003, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309004] = {id = 309004, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309005] = {id = 309005, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309006] = {id = 309006, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309007] = {id = 309007, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309008] = {id = 309008, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309009] = {id = 309009, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309010] = {id = 309010, nameTextID = -1, exDiscribeTextID = 303494}
, 
[309101] = {id = 309101, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309102] = {id = 309102, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309103] = {id = 309103, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309104] = {id = 309104, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309105] = {id = 309105, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309106] = {id = 309106, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309107] = {id = 309107, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309108] = {id = 309108, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309109] = {id = 309109, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309110] = {id = 309110, nameTextID = -1, exDiscribeTextID = 303477}
, 
[309201] = {id = 309201, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309202] = {id = 309202, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309203] = {id = 309203, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309204] = {id = 309204, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309205] = {id = 309205, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309206] = {id = 309206, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309207] = {id = 309207, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309208] = {id = 309208, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309209] = {id = 309209, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309210] = {id = 309210, nameTextID = -1, exDiscribeTextID = 303486}
, 
[309301] = {id = 309301, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309302] = {id = 309302, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309303] = {id = 309303, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309304] = {id = 309304, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309305] = {id = 309305, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309306] = {id = 309306, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309307] = {id = 309307, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309308] = {id = 309308, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309309] = {id = 309309, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309310] = {id = 309310, nameTextID = -1, exDiscribeTextID = 303835}
, 
[309401] = {id = 309401, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309402] = {id = 309402, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309403] = {id = 309403, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309404] = {id = 309404, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309405] = {id = 309405, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309406] = {id = 309406, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309407] = {id = 309407, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309408] = {id = 309408, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309409] = {id = 309409, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309410] = {id = 309410, nameTextID = -1, exDiscribeTextID = 303565}
, 
[309501] = {id = 309501, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309502] = {id = 309502, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309503] = {id = 309503, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309504] = {id = 309504, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309505] = {id = 309505, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309506] = {id = 309506, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309507] = {id = 309507, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309508] = {id = 309508, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309509] = {id = 309509, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309510] = {id = 309510, nameTextID = -1, exDiscribeTextID = 303680}
, 
[309701] = {id = 309701, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309702] = {id = 309702, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309703] = {id = 309703, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309704] = {id = 309704, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309705] = {id = 309705, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309706] = {id = 309706, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309707] = {id = 309707, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309708] = {id = 309708, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309709] = {id = 309709, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309710] = {id = 309710, nameTextID = -1, exDiscribeTextID = 303587}
, 
[309801] = {id = 309801, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309802] = {id = 309802, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309803] = {id = 309803, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309804] = {id = 309804, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309805] = {id = 309805, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309806] = {id = 309806, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309807] = {id = 309807, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309808] = {id = 309808, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309809] = {id = 309809, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309810] = {id = 309810, nameTextID = -1, exDiscribeTextID = 303754}
, 
[309901] = {id = 309901, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309902] = {id = 309902, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309903] = {id = 309903, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309904] = {id = 309904, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309905] = {id = 309905, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309906] = {id = 309906, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309907] = {id = 309907, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309908] = {id = 309908, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309909] = {id = 309909, nameTextID = -1, exDiscribeTextID = 303461}
, 
[309910] = {id = 309910, nameTextID = -1, exDiscribeTextID = 303461}
, 
[310001] = {id = 310001, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310002] = {id = 310002, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310003] = {id = 310003, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310004] = {id = 310004, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310005] = {id = 310005, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310006] = {id = 310006, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310007] = {id = 310007, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310008] = {id = 310008, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310009] = {id = 310009, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310010] = {id = 310010, nameTextID = -1, exDiscribeTextID = 303763}
, 
[310101] = {id = 310101, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310102] = {id = 310102, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310103] = {id = 310103, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310104] = {id = 310104, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310105] = {id = 310105, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310106] = {id = 310106, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310107] = {id = 310107, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310108] = {id = 310108, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310109] = {id = 310109, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310110] = {id = 310110, nameTextID = -1, exDiscribeTextID = 303578}
, 
[310201] = {id = 310201, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310202] = {id = 310202, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310203] = {id = 310203, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310204] = {id = 310204, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310205] = {id = 310205, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310206] = {id = 310206, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310207] = {id = 310207, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310208] = {id = 310208, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310209] = {id = 310209, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310210] = {id = 310210, nameTextID = -1, exDiscribeTextID = 303501}
, 
[310301] = {id = 310301, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310302] = {id = 310302, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310303] = {id = 310303, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310304] = {id = 310304, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310305] = {id = 310305, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310306] = {id = 310306, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310307] = {id = 310307, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310308] = {id = 310308, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310309] = {id = 310309, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310310] = {id = 310310, nameTextID = -1, exDiscribeTextID = 303493}
, 
[310401] = {id = 310401, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310402] = {id = 310402, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310403] = {id = 310403, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310404] = {id = 310404, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310405] = {id = 310405, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310406] = {id = 310406, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310407] = {id = 310407, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310408] = {id = 310408, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310409] = {id = 310409, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310410] = {id = 310410, nameTextID = -1, exDiscribeTextID = 303696}
, 
[310501] = {id = 310501, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310502] = {id = 310502, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310503] = {id = 310503, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310504] = {id = 310504, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310505] = {id = 310505, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310506] = {id = 310506, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310507] = {id = 310507, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310508] = {id = 310508, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310509] = {id = 310509, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310510] = {id = 310510, nameTextID = -1, exDiscribeTextID = 303766}
, 
[310601] = {id = 310601, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310602] = {id = 310602, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310603] = {id = 310603, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310604] = {id = 310604, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310605] = {id = 310605, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310606] = {id = 310606, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310607] = {id = 310607, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310608] = {id = 310608, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310609] = {id = 310609, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310610] = {id = 310610, nameTextID = -1, exDiscribeTextID = 303765}
, 
[310701] = {id = 310701, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310702] = {id = 310702, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310703] = {id = 310703, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310704] = {id = 310704, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310705] = {id = 310705, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310706] = {id = 310706, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310707] = {id = 310707, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310708] = {id = 310708, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310709] = {id = 310709, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310710] = {id = 310710, nameTextID = -1, exDiscribeTextID = 303767}
, 
[310801] = {id = 310801, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310802] = {id = 310802, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310803] = {id = 310803, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310804] = {id = 310804, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310805] = {id = 310805, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310806] = {id = 310806, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310807] = {id = 310807, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310808] = {id = 310808, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310809] = {id = 310809, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310810] = {id = 310810, nameTextID = -1, exDiscribeTextID = 303711}
, 
[310901] = {id = 310901, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310902] = {id = 310902, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310903] = {id = 310903, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310904] = {id = 310904, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310905] = {id = 310905, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310906] = {id = 310906, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310907] = {id = 310907, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310908] = {id = 310908, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310909] = {id = 310909, nameTextID = -1, exDiscribeTextID = 303746}
, 
[310910] = {id = 310910, nameTextID = -1, exDiscribeTextID = 303746}
, 
[311101] = {id = 311101, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311102] = {id = 311102, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311103] = {id = 311103, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311104] = {id = 311104, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311105] = {id = 311105, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311106] = {id = 311106, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311107] = {id = 311107, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311108] = {id = 311108, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311109] = {id = 311109, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311110] = {id = 311110, nameTextID = -1, exDiscribeTextID = 303718}
, 
[311201] = {id = 311201, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311202] = {id = 311202, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311203] = {id = 311203, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311204] = {id = 311204, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311205] = {id = 311205, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311206] = {id = 311206, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311207] = {id = 311207, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311208] = {id = 311208, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311209] = {id = 311209, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311210] = {id = 311210, nameTextID = -1, exDiscribeTextID = 303688}
, 
[311301] = {id = 311301, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311302] = {id = 311302, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311303] = {id = 311303, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311304] = {id = 311304, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311305] = {id = 311305, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311306] = {id = 311306, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311307] = {id = 311307, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311308] = {id = 311308, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311309] = {id = 311309, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311310] = {id = 311310, nameTextID = -1, exDiscribeTextID = 303710}
, 
[311501] = {id = 311501, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311502] = {id = 311502, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311503] = {id = 311503, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311504] = {id = 311504, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311505] = {id = 311505, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311506] = {id = 311506, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311507] = {id = 311507, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311508] = {id = 311508, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311509] = {id = 311509, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311510] = {id = 311510, nameTextID = -1, exDiscribeTextID = 303739}
, 
[311601] = {id = 311601, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311602] = {id = 311602, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311603] = {id = 311603, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311604] = {id = 311604, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311605] = {id = 311605, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311606] = {id = 311606, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311607] = {id = 311607, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311608] = {id = 311608, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311609] = {id = 311609, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311610] = {id = 311610, nameTextID = -1, exDiscribeTextID = 303828}
, 
[311701] = {id = 311701, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311702] = {id = 311702, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311703] = {id = 311703, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311704] = {id = 311704, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311705] = {id = 311705, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311706] = {id = 311706, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311707] = {id = 311707, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311708] = {id = 311708, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311709] = {id = 311709, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311710] = {id = 311710, nameTextID = -1, exDiscribeTextID = 303786}
, 
[311801] = {id = 311801, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311802] = {id = 311802, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311803] = {id = 311803, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311804] = {id = 311804, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311805] = {id = 311805, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311806] = {id = 311806, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311807] = {id = 311807, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311808] = {id = 311808, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311809] = {id = 311809, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311810] = {id = 311810, nameTextID = -1, exDiscribeTextID = 303842}
, 
[311901] = {id = 311901, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311902] = {id = 311902, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311903] = {id = 311903, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311904] = {id = 311904, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311905] = {id = 311905, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311906] = {id = 311906, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311907] = {id = 311907, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311908] = {id = 311908, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311909] = {id = 311909, nameTextID = -1, exDiscribeTextID = 303761}
, 
[311910] = {id = 311910, nameTextID = -1, exDiscribeTextID = 303761}
, 
[312001] = {id = 312001, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312002] = {id = 312002, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312003] = {id = 312003, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312004] = {id = 312004, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312005] = {id = 312005, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312006] = {id = 312006, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312007] = {id = 312007, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312008] = {id = 312008, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312009] = {id = 312009, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312010] = {id = 312010, nameTextID = -1, exDiscribeTextID = 303703}
, 
[312101] = {id = 312101, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312102] = {id = 312102, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312103] = {id = 312103, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312104] = {id = 312104, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312105] = {id = 312105, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312106] = {id = 312106, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312107] = {id = 312107, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312108] = {id = 312108, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312109] = {id = 312109, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312110] = {id = 312110, nameTextID = -1, exDiscribeTextID = 303800}
, 
[312201] = {id = 312201, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312202] = {id = 312202, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312203] = {id = 312203, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312204] = {id = 312204, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312205] = {id = 312205, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312206] = {id = 312206, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312207] = {id = 312207, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312208] = {id = 312208, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312209] = {id = 312209, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312210] = {id = 312210, nameTextID = -1, exDiscribeTextID = 303793}
, 
[312301] = {id = 312301, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312302] = {id = 312302, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312303] = {id = 312303, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312304] = {id = 312304, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312305] = {id = 312305, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312306] = {id = 312306, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312307] = {id = 312307, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312308] = {id = 312308, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312309] = {id = 312309, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312310] = {id = 312310, nameTextID = -1, exDiscribeTextID = 303807}
, 
[312401] = {id = 312401, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312402] = {id = 312402, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312403] = {id = 312403, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312404] = {id = 312404, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312405] = {id = 312405, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312406] = {id = 312406, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312407] = {id = 312407, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312408] = {id = 312408, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312409] = {id = 312409, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312410] = {id = 312410, nameTextID = -1, exDiscribeTextID = 303821}
, 
[312601] = {id = 312601, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312602] = {id = 312602, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312603] = {id = 312603, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312604] = {id = 312604, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312605] = {id = 312605, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312606] = {id = 312606, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312607] = {id = 312607, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312608] = {id = 312608, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312609] = {id = 312609, nameTextID = -1, exDiscribeTextID = 303849}
, 
[312610] = {id = 312610, nameTextID = -1, exDiscribeTextID = 303849}
, 
[313001] = {id = 313001, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313002] = {id = 313002, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313003] = {id = 313003, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313004] = {id = 313004, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313005] = {id = 313005, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313006] = {id = 313006, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313007] = {id = 313007, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313008] = {id = 313008, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313009] = {id = 313009, nameTextID = -1, exDiscribeTextID = 303863}
, 
[313010] = {id = 313010, nameTextID = -1, exDiscribeTextID = 303863}
, 
[400101] = {id = 400101, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400102] = {id = 400102, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400103] = {id = 400103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400104] = {id = 400104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400105] = {id = 400105, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400106] = {id = 400106, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400107] = {id = 400107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400108] = {id = 400108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400201] = {id = 400201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400202] = {id = 400202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400203] = {id = 400203, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400204] = {id = 400204, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400205] = {id = 400205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400206] = {id = 400206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400207] = {id = 400207, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400208] = {id = 400208, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400301] = {id = 400301, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400302] = {id = 400302, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400303] = {id = 400303, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400304] = {id = 400304, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400305] = {id = 400305, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400306] = {id = 400306, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400307] = {id = 400307, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400308] = {id = 400308, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400401] = {id = 400401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400402] = {id = 400402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400403] = {id = 400403, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400404] = {id = 400404, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400405] = {id = 400405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400406] = {id = 400406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400407] = {id = 400407, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400408] = {id = 400408, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400501] = {id = 400501, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400502] = {id = 400502, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400503] = {id = 400503, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400504] = {id = 400504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400505] = {id = 400505, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400506] = {id = 400506, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400507] = {id = 400507, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400508] = {id = 400508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400601] = {id = 400601, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400602] = {id = 400602, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400603] = {id = 400603, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400604] = {id = 400604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400605] = {id = 400605, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400606] = {id = 400606, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400607] = {id = 400607, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400608] = {id = 400608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400701] = {id = 400701, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400702] = {id = 400702, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400703] = {id = 400703, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400704] = {id = 400704, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400705] = {id = 400705, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400706] = {id = 400706, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400707] = {id = 400707, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400708] = {id = 400708, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400801] = {id = 400801, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400802] = {id = 400802, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400803] = {id = 400803, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400804] = {id = 400804, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400805] = {id = 400805, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400806] = {id = 400806, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400807] = {id = 400807, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400808] = {id = 400808, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[400901] = {id = 400901, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[400902] = {id = 400902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[400903] = {id = 400903, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[400904] = {id = 400904, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[400905] = {id = 400905, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[400906] = {id = 400906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[400907] = {id = 400907, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[400908] = {id = 400908, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401001] = {id = 401001, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401002] = {id = 401002, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401003] = {id = 401003, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401004] = {id = 401004, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401005] = {id = 401005, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401006] = {id = 401006, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401007] = {id = 401007, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401008] = {id = 401008, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401101] = {id = 401101, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401102] = {id = 401102, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401103] = {id = 401103, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401104] = {id = 401104, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401105] = {id = 401105, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401106] = {id = 401106, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401107] = {id = 401107, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401108] = {id = 401108, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401201] = {id = 401201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401202] = {id = 401202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401203] = {id = 401203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401204] = {id = 401204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401205] = {id = 401205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401206] = {id = 401206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401207] = {id = 401207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401208] = {id = 401208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401301] = {id = 401301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401302] = {id = 401302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401303] = {id = 401303, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401304] = {id = 401304, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401305] = {id = 401305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401306] = {id = 401306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401307] = {id = 401307, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401308] = {id = 401308, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401401] = {id = 401401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401402] = {id = 401402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401403] = {id = 401403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401404] = {id = 401404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401405] = {id = 401405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401406] = {id = 401406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401407] = {id = 401407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401408] = {id = 401408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401501] = {id = 401501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401502] = {id = 401502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401503] = {id = 401503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401504] = {id = 401504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401505] = {id = 401505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401506] = {id = 401506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401507] = {id = 401507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401508] = {id = 401508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401601] = {id = 401601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401602] = {id = 401602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401603] = {id = 401603, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401604] = {id = 401604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401605] = {id = 401605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401606] = {id = 401606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401607] = {id = 401607, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401608] = {id = 401608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401701] = {id = 401701, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401702] = {id = 401702, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401703] = {id = 401703, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401704] = {id = 401704, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401705] = {id = 401705, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401706] = {id = 401706, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401707] = {id = 401707, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401708] = {id = 401708, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401801] = {id = 401801, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401802] = {id = 401802, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401803] = {id = 401803, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401804] = {id = 401804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401805] = {id = 401805, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401806] = {id = 401806, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401807] = {id = 401807, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401808] = {id = 401808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[401901] = {id = 401901, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[401902] = {id = 401902, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[401903] = {id = 401903, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[401904] = {id = 401904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[401905] = {id = 401905, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[401906] = {id = 401906, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[401907] = {id = 401907, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[401908] = {id = 401908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402001] = {id = 402001, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402002] = {id = 402002, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402003] = {id = 402003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402004] = {id = 402004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402005] = {id = 402005, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402006] = {id = 402006, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402007] = {id = 402007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402008] = {id = 402008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402101] = {id = 402101, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402102] = {id = 402102, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402103] = {id = 402103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402104] = {id = 402104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402105] = {id = 402105, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402106] = {id = 402106, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402107] = {id = 402107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402108] = {id = 402108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402201] = {id = 402201, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402202] = {id = 402202, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402203] = {id = 402203, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402204] = {id = 402204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402205] = {id = 402205, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402206] = {id = 402206, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402207] = {id = 402207, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402208] = {id = 402208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402301] = {id = 402301, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402302] = {id = 402302, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402303] = {id = 402303, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402304] = {id = 402304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402305] = {id = 402305, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402306] = {id = 402306, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402307] = {id = 402307, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402308] = {id = 402308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402401] = {id = 402401, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402402] = {id = 402402, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402403] = {id = 402403, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402404] = {id = 402404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402405] = {id = 402405, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402406] = {id = 402406, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402407] = {id = 402407, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402408] = {id = 402408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402501] = {id = 402501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402502] = {id = 402502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402503] = {id = 402503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402504] = {id = 402504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402505] = {id = 402505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402506] = {id = 402506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402507] = {id = 402507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402508] = {id = 402508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402601] = {id = 402601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402602] = {id = 402602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402603] = {id = 402603, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402604] = {id = 402604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402605] = {id = 402605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402606] = {id = 402606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402607] = {id = 402607, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402608] = {id = 402608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402701] = {id = 402701, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402702] = {id = 402702, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402703] = {id = 402703, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402704] = {id = 402704, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402705] = {id = 402705, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402706] = {id = 402706, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402707] = {id = 402707, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402708] = {id = 402708, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402801] = {id = 402801, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402802] = {id = 402802, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402803] = {id = 402803, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402804] = {id = 402804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402805] = {id = 402805, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402806] = {id = 402806, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402807] = {id = 402807, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402808] = {id = 402808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[402901] = {id = 402901, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[402902] = {id = 402902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[402903] = {id = 402903, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[402904] = {id = 402904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[402905] = {id = 402905, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[402906] = {id = 402906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[402907] = {id = 402907, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[402908] = {id = 402908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403001] = {id = 403001, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403002] = {id = 403002, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403003] = {id = 403003, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403004] = {id = 403004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403005] = {id = 403005, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403006] = {id = 403006, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403007] = {id = 403007, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403008] = {id = 403008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403201] = {id = 403201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403202] = {id = 403202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403203] = {id = 403203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403204] = {id = 403204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403205] = {id = 403205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403206] = {id = 403206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403207] = {id = 403207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403208] = {id = 403208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403301] = {id = 403301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403302] = {id = 403302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403303] = {id = 403303, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403304] = {id = 403304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403305] = {id = 403305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403306] = {id = 403306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403307] = {id = 403307, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403308] = {id = 403308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403401] = {id = 403401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403402] = {id = 403402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403403] = {id = 403403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403404] = {id = 403404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403405] = {id = 403405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403406] = {id = 403406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403407] = {id = 403407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403408] = {id = 403408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403501] = {id = 403501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403502] = {id = 403502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403503] = {id = 403503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403504] = {id = 403504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403505] = {id = 403505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403506] = {id = 403506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403507] = {id = 403507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403508] = {id = 403508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403601] = {id = 403601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403602] = {id = 403602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403603] = {id = 403603, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403604] = {id = 403604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403605] = {id = 403605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403606] = {id = 403606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403607] = {id = 403607, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403608] = {id = 403608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403801] = {id = 403801, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403802] = {id = 403802, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403803] = {id = 403803, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403804] = {id = 403804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403805] = {id = 403805, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403806] = {id = 403806, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403807] = {id = 403807, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403808] = {id = 403808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[403901] = {id = 403901, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[403902] = {id = 403902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[403903] = {id = 403903, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[403904] = {id = 403904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[403905] = {id = 403905, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[403906] = {id = 403906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[403907] = {id = 403907, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[403908] = {id = 403908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404001] = {id = 404001, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404002] = {id = 404002, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404003] = {id = 404003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404004] = {id = 404004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404005] = {id = 404005, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404006] = {id = 404006, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404007] = {id = 404007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404008] = {id = 404008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404101] = {id = 404101, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404102] = {id = 404102, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404103] = {id = 404103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404104] = {id = 404104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404105] = {id = 404105, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404106] = {id = 404106, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404107] = {id = 404107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404108] = {id = 404108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404201] = {id = 404201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404202] = {id = 404202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404203] = {id = 404203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404204] = {id = 404204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404205] = {id = 404205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404206] = {id = 404206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404207] = {id = 404207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404208] = {id = 404208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404301] = {id = 404301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404302] = {id = 404302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404303] = {id = 404303, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404304] = {id = 404304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404305] = {id = 404305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404306] = {id = 404306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404307] = {id = 404307, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404308] = {id = 404308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404401] = {id = 404401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404402] = {id = 404402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404403] = {id = 404403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404404] = {id = 404404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404405] = {id = 404405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404406] = {id = 404406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404407] = {id = 404407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404408] = {id = 404408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404501] = {id = 404501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404502] = {id = 404502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404503] = {id = 404503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404504] = {id = 404504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404505] = {id = 404505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404506] = {id = 404506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404507] = {id = 404507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404508] = {id = 404508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404601] = {id = 404601, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404602] = {id = 404602, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404603] = {id = 404603, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404604] = {id = 404604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404605] = {id = 404605, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404606] = {id = 404606, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404607] = {id = 404607, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404608] = {id = 404608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404701] = {id = 404701, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404702] = {id = 404702, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404703] = {id = 404703, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404704] = {id = 404704, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404705] = {id = 404705, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404706] = {id = 404706, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404707] = {id = 404707, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404708] = {id = 404708, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404801] = {id = 404801, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404802] = {id = 404802, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404803] = {id = 404803, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404804] = {id = 404804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404805] = {id = 404805, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404806] = {id = 404806, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404807] = {id = 404807, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[404808] = {id = 404808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404901] = {id = 404901, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[404902] = {id = 404902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[404903] = {id = 404903, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[404904] = {id = 404904, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[404905] = {id = 404905, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[404906] = {id = 404906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[404907] = {id = 404907, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[404908] = {id = 404908, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405001] = {id = 405001, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405002] = {id = 405002, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405003] = {id = 405003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405004] = {id = 405004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405005] = {id = 405005, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405006] = {id = 405006, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405007] = {id = 405007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405008] = {id = 405008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405101] = {id = 405101, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405102] = {id = 405102, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405103] = {id = 405103, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405104] = {id = 405104, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405105] = {id = 405105, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405106] = {id = 405106, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405107] = {id = 405107, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405108] = {id = 405108, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405201] = {id = 405201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405202] = {id = 405202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405203] = {id = 405203, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405204] = {id = 405204, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405205] = {id = 405205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405206] = {id = 405206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405207] = {id = 405207, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405208] = {id = 405208, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405301] = {id = 405301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405302] = {id = 405302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405303] = {id = 405303, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405304] = {id = 405304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405305] = {id = 405305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405306] = {id = 405306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405307] = {id = 405307, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405308] = {id = 405308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405401] = {id = 405401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405402] = {id = 405402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405403] = {id = 405403, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405404] = {id = 405404, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405405] = {id = 405405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405406] = {id = 405406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405407] = {id = 405407, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405408] = {id = 405408, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405501] = {id = 405501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405502] = {id = 405502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405503] = {id = 405503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405504] = {id = 405504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405505] = {id = 405505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405506] = {id = 405506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405507] = {id = 405507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405508] = {id = 405508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405601] = {id = 405601, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405602] = {id = 405602, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405603] = {id = 405603, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405604] = {id = 405604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405605] = {id = 405605, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405606] = {id = 405606, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405607] = {id = 405607, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405608] = {id = 405608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405701] = {id = 405701, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405702] = {id = 405702, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405703] = {id = 405703, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405704] = {id = 405704, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405705] = {id = 405705, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405706] = {id = 405706, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405707] = {id = 405707, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405708] = {id = 405708, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405801] = {id = 405801, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405802] = {id = 405802, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405803] = {id = 405803, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405804] = {id = 405804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405805] = {id = 405805, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405806] = {id = 405806, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405807] = {id = 405807, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[405808] = {id = 405808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405901] = {id = 405901, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[405902] = {id = 405902, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[405903] = {id = 405903, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[405904] = {id = 405904, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[405905] = {id = 405905, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[405906] = {id = 405906, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[405907] = {id = 405907, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[405908] = {id = 405908, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406001] = {id = 406001, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406002] = {id = 406002, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406003] = {id = 406003, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406004] = {id = 406004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406005] = {id = 406005, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406006] = {id = 406006, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406007] = {id = 406007, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406008] = {id = 406008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406101] = {id = 406101, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406102] = {id = 406102, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406103] = {id = 406103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406104] = {id = 406104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406105] = {id = 406105, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406106] = {id = 406106, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406107] = {id = 406107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406108] = {id = 406108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406201] = {id = 406201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406202] = {id = 406202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406203] = {id = 406203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406204] = {id = 406204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406205] = {id = 406205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406206] = {id = 406206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406207] = {id = 406207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406208] = {id = 406208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406301] = {id = 406301, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406302] = {id = 406302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406303] = {id = 406303, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406304] = {id = 406304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406305] = {id = 406305, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406306] = {id = 406306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406307] = {id = 406307, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406308] = {id = 406308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406401] = {id = 406401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406402] = {id = 406402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406403] = {id = 406403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406404] = {id = 406404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406405] = {id = 406405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406406] = {id = 406406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406407] = {id = 406407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406408] = {id = 406408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406501] = {id = 406501, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406502] = {id = 406502, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406503] = {id = 406503, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406504] = {id = 406504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406505] = {id = 406505, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406506] = {id = 406506, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406507] = {id = 406507, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406508] = {id = 406508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406601] = {id = 406601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406602] = {id = 406602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406603] = {id = 406603, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406604] = {id = 406604, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406605] = {id = 406605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406606] = {id = 406606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406607] = {id = 406607, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406608] = {id = 406608, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406701] = {id = 406701, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406702] = {id = 406702, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406703] = {id = 406703, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406704] = {id = 406704, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406705] = {id = 406705, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406706] = {id = 406706, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406707] = {id = 406707, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406708] = {id = 406708, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406801] = {id = 406801, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406802] = {id = 406802, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406803] = {id = 406803, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406804] = {id = 406804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406805] = {id = 406805, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406806] = {id = 406806, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406807] = {id = 406807, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406808] = {id = 406808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[406901] = {id = 406901, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[406902] = {id = 406902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[406903] = {id = 406903, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[406904] = {id = 406904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[406905] = {id = 406905, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[406906] = {id = 406906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[406907] = {id = 406907, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[406908] = {id = 406908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407001] = {id = 407001, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407002] = {id = 407002, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407003] = {id = 407003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407004] = {id = 407004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407005] = {id = 407005, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407006] = {id = 407006, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407007] = {id = 407007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407008] = {id = 407008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407101] = {id = 407101, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407102] = {id = 407102, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407103] = {id = 407103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407104] = {id = 407104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407105] = {id = 407105, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407106] = {id = 407106, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407107] = {id = 407107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407108] = {id = 407108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407201] = {id = 407201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407202] = {id = 407202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407203] = {id = 407203, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407204] = {id = 407204, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407205] = {id = 407205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407206] = {id = 407206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407207] = {id = 407207, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407208] = {id = 407208, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407301] = {id = 407301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407302] = {id = 407302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407303] = {id = 407303, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407304] = {id = 407304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407305] = {id = 407305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407306] = {id = 407306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407307] = {id = 407307, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407308] = {id = 407308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407401] = {id = 407401, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407402] = {id = 407402, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407403] = {id = 407403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407404] = {id = 407404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407405] = {id = 407405, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407406] = {id = 407406, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407407] = {id = 407407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407408] = {id = 407408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407501] = {id = 407501, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407502] = {id = 407502, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407503] = {id = 407503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407504] = {id = 407504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407505] = {id = 407505, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407506] = {id = 407506, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407507] = {id = 407507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407508] = {id = 407508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407601] = {id = 407601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407602] = {id = 407602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407603] = {id = 407603, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407604] = {id = 407604, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407605] = {id = 407605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407606] = {id = 407606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407607] = {id = 407607, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407608] = {id = 407608, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407801] = {id = 407801, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407802] = {id = 407802, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407803] = {id = 407803, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407804] = {id = 407804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407805] = {id = 407805, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407806] = {id = 407806, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407807] = {id = 407807, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[407808] = {id = 407808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407901] = {id = 407901, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[407902] = {id = 407902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[407903] = {id = 407903, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[407904] = {id = 407904, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[407905] = {id = 407905, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[407906] = {id = 407906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[407907] = {id = 407907, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[407908] = {id = 407908, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408001] = {id = 408001, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408002] = {id = 408002, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408003] = {id = 408003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408004] = {id = 408004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408005] = {id = 408005, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408006] = {id = 408006, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408007] = {id = 408007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408008] = {id = 408008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408101] = {id = 408101, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408102] = {id = 408102, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408103] = {id = 408103, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408104] = {id = 408104, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408105] = {id = 408105, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408106] = {id = 408106, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408107] = {id = 408107, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408108] = {id = 408108, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408201] = {id = 408201, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408202] = {id = 408202, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408203] = {id = 408203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408204] = {id = 408204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408205] = {id = 408205, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408206] = {id = 408206, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408207] = {id = 408207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408208] = {id = 408208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408301] = {id = 408301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408302] = {id = 408302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408303] = {id = 408303, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408304] = {id = 408304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408305] = {id = 408305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408306] = {id = 408306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408307] = {id = 408307, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408308] = {id = 408308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408401] = {id = 408401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408402] = {id = 408402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408403] = {id = 408403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408404] = {id = 408404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408405] = {id = 408405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408406] = {id = 408406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408407] = {id = 408407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408408] = {id = 408408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408501] = {id = 408501, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408502] = {id = 408502, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408503] = {id = 408503, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408504] = {id = 408504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408505] = {id = 408505, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408506] = {id = 408506, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408507] = {id = 408507, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408508] = {id = 408508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408601] = {id = 408601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408602] = {id = 408602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408603] = {id = 408603, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408604] = {id = 408604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408605] = {id = 408605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408606] = {id = 408606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408607] = {id = 408607, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408608] = {id = 408608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408801] = {id = 408801, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408802] = {id = 408802, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408803] = {id = 408803, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408804] = {id = 408804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408805] = {id = 408805, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408806] = {id = 408806, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408807] = {id = 408807, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408808] = {id = 408808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[408901] = {id = 408901, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[408902] = {id = 408902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[408903] = {id = 408903, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[408904] = {id = 408904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[408905] = {id = 408905, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[408906] = {id = 408906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[408907] = {id = 408907, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[408908] = {id = 408908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409001] = {id = 409001, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409002] = {id = 409002, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409003] = {id = 409003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409004] = {id = 409004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409005] = {id = 409005, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409006] = {id = 409006, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409007] = {id = 409007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409008] = {id = 409008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409101] = {id = 409101, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409102] = {id = 409102, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409103] = {id = 409103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409104] = {id = 409104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409105] = {id = 409105, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409106] = {id = 409106, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409107] = {id = 409107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409108] = {id = 409108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409201] = {id = 409201, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409202] = {id = 409202, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409203] = {id = 409203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409204] = {id = 409204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409205] = {id = 409205, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409206] = {id = 409206, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409207] = {id = 409207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409208] = {id = 409208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409301] = {id = 409301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409302] = {id = 409302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409303] = {id = 409303, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409304] = {id = 409304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409305] = {id = 409305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409306] = {id = 409306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409307] = {id = 409307, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409308] = {id = 409308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409401] = {id = 409401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409402] = {id = 409402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409403] = {id = 409403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409404] = {id = 409404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409405] = {id = 409405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409406] = {id = 409406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409407] = {id = 409407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409408] = {id = 409408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409501] = {id = 409501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409502] = {id = 409502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409503] = {id = 409503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409504] = {id = 409504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409505] = {id = 409505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409506] = {id = 409506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409507] = {id = 409507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409508] = {id = 409508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409701] = {id = 409701, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409702] = {id = 409702, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409703] = {id = 409703, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409704] = {id = 409704, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409705] = {id = 409705, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409706] = {id = 409706, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409707] = {id = 409707, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409708] = {id = 409708, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409801] = {id = 409801, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409802] = {id = 409802, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409803] = {id = 409803, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409804] = {id = 409804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409805] = {id = 409805, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409806] = {id = 409806, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409807] = {id = 409807, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409808] = {id = 409808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[409901] = {id = 409901, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[409902] = {id = 409902, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[409903] = {id = 409903, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[409904] = {id = 409904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[409905] = {id = 409905, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[409906] = {id = 409906, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[409907] = {id = 409907, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[409908] = {id = 409908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410001] = {id = 410001, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410002] = {id = 410002, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410003] = {id = 410003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410004] = {id = 410004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410005] = {id = 410005, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410006] = {id = 410006, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410007] = {id = 410007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410008] = {id = 410008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410101] = {id = 410101, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410102] = {id = 410102, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410103] = {id = 410103, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410104] = {id = 410104, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410105] = {id = 410105, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410106] = {id = 410106, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410107] = {id = 410107, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410108] = {id = 410108, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410201] = {id = 410201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410202] = {id = 410202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410203] = {id = 410203, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410204] = {id = 410204, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410205] = {id = 410205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410206] = {id = 410206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410207] = {id = 410207, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410208] = {id = 410208, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410301] = {id = 410301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410302] = {id = 410302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410303] = {id = 410303, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410304] = {id = 410304, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410305] = {id = 410305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410306] = {id = 410306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410307] = {id = 410307, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410308] = {id = 410308, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410401] = {id = 410401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410402] = {id = 410402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410403] = {id = 410403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410404] = {id = 410404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410405] = {id = 410405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410406] = {id = 410406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410407] = {id = 410407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410408] = {id = 410408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410501] = {id = 410501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410502] = {id = 410502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410503] = {id = 410503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410504] = {id = 410504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410505] = {id = 410505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410506] = {id = 410506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410507] = {id = 410507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410508] = {id = 410508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410601] = {id = 410601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410602] = {id = 410602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410603] = {id = 410603, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410604] = {id = 410604, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410605] = {id = 410605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410606] = {id = 410606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410607] = {id = 410607, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410608] = {id = 410608, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410701] = {id = 410701, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410702] = {id = 410702, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410703] = {id = 410703, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410704] = {id = 410704, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410705] = {id = 410705, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410706] = {id = 410706, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410707] = {id = 410707, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410708] = {id = 410708, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410801] = {id = 410801, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410802] = {id = 410802, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410803] = {id = 410803, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410804] = {id = 410804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410805] = {id = 410805, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410806] = {id = 410806, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410807] = {id = 410807, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410808] = {id = 410808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[410901] = {id = 410901, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[410902] = {id = 410902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[410903] = {id = 410903, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[410904] = {id = 410904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[410905] = {id = 410905, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[410906] = {id = 410906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[410907] = {id = 410907, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[410908] = {id = 410908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411001] = {id = 411001, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411002] = {id = 411002, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411003] = {id = 411003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411004] = {id = 411004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411005] = {id = 411005, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411006] = {id = 411006, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411007] = {id = 411007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411008] = {id = 411008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411101] = {id = 411101, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411102] = {id = 411102, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411103] = {id = 411103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411104] = {id = 411104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411105] = {id = 411105, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411106] = {id = 411106, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411107] = {id = 411107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411108] = {id = 411108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411201] = {id = 411201, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411202] = {id = 411202, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411203] = {id = 411203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411204] = {id = 411204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411205] = {id = 411205, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411206] = {id = 411206, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411207] = {id = 411207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411208] = {id = 411208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411301] = {id = 411301, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411302] = {id = 411302, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411303] = {id = 411303, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411304] = {id = 411304, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411305] = {id = 411305, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411306] = {id = 411306, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411307] = {id = 411307, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411308] = {id = 411308, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411501] = {id = 411501, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411502] = {id = 411502, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411503] = {id = 411503, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411504] = {id = 411504, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411505] = {id = 411505, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411506] = {id = 411506, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411507] = {id = 411507, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411508] = {id = 411508, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411601] = {id = 411601, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411602] = {id = 411602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411603] = {id = 411603, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411604] = {id = 411604, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411605] = {id = 411605, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411606] = {id = 411606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411607] = {id = 411607, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411608] = {id = 411608, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411701] = {id = 411701, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411702] = {id = 411702, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411703] = {id = 411703, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411704] = {id = 411704, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411705] = {id = 411705, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411706] = {id = 411706, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411707] = {id = 411707, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411708] = {id = 411708, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411801] = {id = 411801, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411802] = {id = 411802, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411803] = {id = 411803, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411804] = {id = 411804, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411805] = {id = 411805, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411806] = {id = 411806, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411807] = {id = 411807, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411808] = {id = 411808, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[411901] = {id = 411901, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[411902] = {id = 411902, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[411903] = {id = 411903, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[411904] = {id = 411904, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[411905] = {id = 411905, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[411906] = {id = 411906, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[411907] = {id = 411907, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[411908] = {id = 411908, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[412001] = {id = 412001, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[412002] = {id = 412002, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[412003] = {id = 412003, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[412004] = {id = 412004, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[412005] = {id = 412005, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[412006] = {id = 412006, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[412007] = {id = 412007, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[412008] = {id = 412008, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[412101] = {id = 412101, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[412102] = {id = 412102, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[412103] = {id = 412103, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[412104] = {id = 412104, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[412105] = {id = 412105, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[412106] = {id = 412106, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[412107] = {id = 412107, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[412108] = {id = 412108, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[412201] = {id = 412201, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[412202] = {id = 412202, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[412203] = {id = 412203, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[412204] = {id = 412204, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[412205] = {id = 412205, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[412206] = {id = 412206, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[412207] = {id = 412207, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[412208] = {id = 412208, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[412301] = {id = 412301, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[412302] = {id = 412302, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[412303] = {id = 412303, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[412304] = {id = 412304, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[412305] = {id = 412305, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[412306] = {id = 412306, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[412307] = {id = 412307, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[412308] = {id = 412308, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[412401] = {id = 412401, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[412402] = {id = 412402, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[412403] = {id = 412403, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[412404] = {id = 412404, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[412405] = {id = 412405, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[412406] = {id = 412406, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[412407] = {id = 412407, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[412408] = {id = 412408, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[412601] = {id = 412601, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[412602] = {id = 412602, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[412603] = {id = 412603, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[412604] = {id = 412604, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[412605] = {id = 412605, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[412606] = {id = 412606, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[412607] = {id = 412607, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[412608] = {id = 412608, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[413001] = {id = 413001, nameTextID = 303040, exDiscribeTextID = 303046}
, 
[413002] = {id = 413002, nameTextID = 303039, exDiscribeTextID = 303045}
, 
[413003] = {id = 413003, nameTextID = 303037, exDiscribeTextID = 303048}
, 
[413004] = {id = 413004, nameTextID = 303038, exDiscribeTextID = 303047}
, 
[413005] = {id = 413005, nameTextID = 303044, exDiscribeTextID = 303046}
, 
[413006] = {id = 413006, nameTextID = 303043, exDiscribeTextID = 303045}
, 
[413007] = {id = 413007, nameTextID = 303041, exDiscribeTextID = 303048}
, 
[413008] = {id = 413008, nameTextID = 303042, exDiscribeTextID = 303047}
, 
[500101] = {id = 500101, nameTextID = 301141, exDiscribeTextID = 301368}
, 
[500102] = {id = 500102, nameTextID = 301141, exDiscribeTextID = 301371}
, 
[500201] = {id = 500201, nameTextID = 301144, exDiscribeTextID = 301570}
, 
[500202] = {id = 500202, nameTextID = 301144, exDiscribeTextID = 301377}
, 
[500301] = {id = 500301, nameTextID = 302215, exDiscribeTextID = 303116}
, 
[500302] = {id = 500302, nameTextID = 302215, exDiscribeTextID = 303117}
, 
[500401] = {id = 500401, nameTextID = 301147, exDiscribeTextID = 301881}
, 
[500402] = {id = 500402, nameTextID = 301147, exDiscribeTextID = 301882}
, 
[500501] = {id = 500501, nameTextID = 301149, exDiscribeTextID = 301260}
, 
[500504] = {id = 500504, nameTextID = 301149, exDiscribeTextID = 301260}
, 
[500601] = {id = 500601, nameTextID = 302074, exDiscribeTextID = 302086}
, 
[500602] = {id = 500602, nameTextID = 302074, exDiscribeTextID = 302086}
, 
[500603] = {id = 500603, nameTextID = 302076, exDiscribeTextID = 302088}
, 
[500604] = {id = 500604, nameTextID = 302077, exDiscribeTextID = 302089}
, 
[500605] = {id = 500605, nameTextID = 302078, exDiscribeTextID = 302090}
, 
[500606] = {id = 500606, nameTextID = 302079, exDiscribeTextID = 302091}
, 
[500701] = {id = 500701, nameTextID = 301150, exDiscribeTextID = 301879}
, 
[500702] = {id = 500702, nameTextID = 301145, exDiscribeTextID = 301861}
, 
[500703] = {id = 500703, nameTextID = 301146, exDiscribeTextID = 301868}
, 
[500704] = {id = 500704, nameTextID = 301150, exDiscribeTextID = 301878}
, 
[500705] = {id = 500705, nameTextID = 301145, exDiscribeTextID = 301860}
, 
[500706] = {id = 500706, nameTextID = 301146, exDiscribeTextID = 301866}
, 
[500801] = {id = 500801, nameTextID = 301152, exDiscribeTextID = 303020}
, 
[500802] = {id = 500802, nameTextID = 301152, exDiscribeTextID = 303021}
, 
[500901] = {id = 500901, nameTextID = 301154, exDiscribeTextID = 301881}
, 
[500902] = {id = 500902, nameTextID = 301154, exDiscribeTextID = 301882}
, 
[501001] = {id = 501001, nameTextID = 301157, exDiscribeTextID = 301597}
, 
[501002] = {id = 501002, nameTextID = 301157, exDiscribeTextID = 301413}
, 
[501101] = {id = 501101, nameTextID = 301158, exDiscribeTextID = 301417}
, 
[501102] = {id = 501102, nameTextID = 301158, exDiscribeTextID = 301602}
, 
[501201] = {id = 501201, nameTextID = 303024, exDiscribeTextID = 303022}
, 
[501202] = {id = 501202, nameTextID = 303024, exDiscribeTextID = 303023}
, 
[501301] = {id = 501301, nameTextID = 301161, exDiscribeTextID = 303118}
, 
[501302] = {id = 501302, nameTextID = 301161, exDiscribeTextID = 303119}
, 
[501401] = {id = 501401, nameTextID = 301164, exDiscribeTextID = 301426}
, 
[501402] = {id = 501402, nameTextID = 301164, exDiscribeTextID = 301429}
, 
[501501] = {id = 501501, nameTextID = 301165, exDiscribeTextID = 301432}
, 
[501502] = {id = 501502, nameTextID = 301165, exDiscribeTextID = 301435}
, 
[501601] = {id = 501601, nameTextID = 303120, exDiscribeTextID = 303121}
, 
[501602] = {id = 501602, nameTextID = 303120, exDiscribeTextID = 303122}
, 
[501701] = {id = 501701, nameTextID = 301167, exDiscribeTextID = 303123}
, 
[501702] = {id = 501702, nameTextID = 301167, exDiscribeTextID = 303124}
, 
[501801] = {id = 501801, nameTextID = 301170, exDiscribeTextID = 301622}
, 
[501802] = {id = 501802, nameTextID = 301170, exDiscribeTextID = 301450}
, 
[501901] = {id = 501901, nameTextID = 301173, exDiscribeTextID = 303025}
, 
[501902] = {id = 501902, nameTextID = 301173, exDiscribeTextID = 303026}
, 
[502001] = {id = 502001, nameTextID = 301150, exDiscribeTextID = 301879}
, 
[502002] = {id = 502002, nameTextID = 301145, exDiscribeTextID = 301861}
, 
[502003] = {id = 502003, nameTextID = 301146, exDiscribeTextID = 301868}
, 
[502004] = {id = 502004, nameTextID = 301150, exDiscribeTextID = 301878}
, 
[502005] = {id = 502005, nameTextID = 301145, exDiscribeTextID = 301860}
, 
[502006] = {id = 502006, nameTextID = 301146, exDiscribeTextID = 301866}
, 
[502101] = {id = 502101, nameTextID = 301174, exDiscribeTextID = 301462}
, 
[502102] = {id = 502102, nameTextID = 301143, exDiscribeTextID = 301855}
, 
[502103] = {id = 502103, nameTextID = 301146, exDiscribeTextID = 301868}
, 
[502104] = {id = 502104, nameTextID = 301174, exDiscribeTextID = 301464}
, 
[502105] = {id = 502105, nameTextID = 301143, exDiscribeTextID = 301854}
, 
[502106] = {id = 502106, nameTextID = 301146, exDiscribeTextID = 301866}
, 
[502201] = {id = 502201, nameTextID = 301175, exDiscribeTextID = 303160}
, 
[502202] = {id = 502202, nameTextID = 301175, exDiscribeTextID = 303161}
, 
[502301] = {id = 502301, nameTextID = 303228, exDiscribeTextID = 303226}
, 
[502302] = {id = 502302, nameTextID = 303228, exDiscribeTextID = 303227}
, 
[502401] = {id = 502401, nameTextID = 301178, exDiscribeTextID = 301478}
, 
[502402] = {id = 502402, nameTextID = 301178, exDiscribeTextID = 301479}
, 
[502501] = {id = 502501, nameTextID = 303239, exDiscribeTextID = 303240}
, 
[502502] = {id = 502502, nameTextID = 303239, exDiscribeTextID = 303241}
, 
[502601] = {id = 502601, nameTextID = 301180, exDiscribeTextID = 301482}
, 
[502602] = {id = 502602, nameTextID = 301146, exDiscribeTextID = 301867}
, 
[502603] = {id = 502603, nameTextID = 301145, exDiscribeTextID = 301862}
, 
[502604] = {id = 502604, nameTextID = 301180, exDiscribeTextID = 301484}
, 
[502605] = {id = 502605, nameTextID = 301146, exDiscribeTextID = 301866}
, 
[502606] = {id = 502606, nameTextID = 301145, exDiscribeTextID = 301860}
, 
[502701] = {id = 502701, nameTextID = 301181, exDiscribeTextID = 301648}
, 
[502702] = {id = 502702, nameTextID = 301181, exDiscribeTextID = 301488}
, 
[502801] = {id = 502801, nameTextID = 301182, exDiscribeTextID = 301490}
, 
[502802] = {id = 502802, nameTextID = 301182, exDiscribeTextID = 301492}
, 
[502901] = {id = 502901, nameTextID = 301185, exDiscribeTextID = 303142}
, 
[502902] = {id = 502902, nameTextID = 301185, exDiscribeTextID = 303143}
, 
[503001] = {id = 503001, nameTextID = 301188, exDiscribeTextID = 301499}
, 
[503002] = {id = 503002, nameTextID = 301188, exDiscribeTextID = 301501}
, 
[503201] = {id = 503201, nameTextID = 301190, exDiscribeTextID = 301655}
, 
[503202] = {id = 503202, nameTextID = 301190, exDiscribeTextID = 301504}
, 
[503301] = {id = 503301, nameTextID = 301192, exDiscribeTextID = 301658}
, 
[503302] = {id = 503302, nameTextID = 301192, exDiscribeTextID = 301509}
, 
[503401] = {id = 503401, nameTextID = 301195, exDiscribeTextID = 302004}
, 
[503402] = {id = 503402, nameTextID = 301195, exDiscribeTextID = 302003}
, 
[503501] = {id = 503501, nameTextID = 301197, exDiscribeTextID = 301922}
, 
[503502] = {id = 503502, nameTextID = 301197, exDiscribeTextID = 301925}
, 
[503601] = {id = 503601, nameTextID = 303027, exDiscribeTextID = 303028}
, 
[503602] = {id = 503602, nameTextID = 303027, exDiscribeTextID = 303029}
, 
[503801] = {id = 503801, nameTextID = 303174, exDiscribeTextID = 303175}
, 
[503802] = {id = 503802, nameTextID = 303174, exDiscribeTextID = 303176}
, 
[503901] = {id = 503901, nameTextID = 301145, exDiscribeTextID = 301863}
, 
[503902] = {id = 503902, nameTextID = 301143, exDiscribeTextID = 301855}
, 
[503903] = {id = 503903, nameTextID = 301146, exDiscribeTextID = 301868}
, 
[503904] = {id = 503904, nameTextID = 301145, exDiscribeTextID = 301860}
, 
[503905] = {id = 503905, nameTextID = 301143, exDiscribeTextID = 301854}
, 
[503906] = {id = 503906, nameTextID = 301146, exDiscribeTextID = 301866}
, 
[503907] = {id = 503907, nameTextID = 303467, exDiscribeTextID = 303468}
, 
[503908] = {id = 503908, nameTextID = 303467, exDiscribeTextID = 303468}
, 
[504101] = {id = 504101, nameTextID = 301208, exDiscribeTextID = 301935}
, 
[504102] = {id = 504102, nameTextID = 301208, exDiscribeTextID = 301937}
, 
[504201] = {id = 504201, nameTextID = 301209, exDiscribeTextID = 303166}
, 
[504202] = {id = 504202, nameTextID = 301209, exDiscribeTextID = 303167}
, 
[504301] = {id = 504301, nameTextID = 301211, exDiscribeTextID = 301663}
, 
[504302] = {id = 504302, nameTextID = 301211, exDiscribeTextID = 301528}
, 
[504401] = {id = 504401, nameTextID = 301145, exDiscribeTextID = 301862}
, 
[504402] = {id = 504402, nameTextID = 301150, exDiscribeTextID = 301946}
, 
[504403] = {id = 504403, nameTextID = 301202, exDiscribeTextID = 301874}
, 
[504404] = {id = 504404, nameTextID = 301145, exDiscribeTextID = 301860}
, 
[504405] = {id = 504405, nameTextID = 301150, exDiscribeTextID = 301878}
, 
[504406] = {id = 504406, nameTextID = 301148, exDiscribeTextID = 301872}
, 
[504501] = {id = 504501, nameTextID = 303236, exDiscribeTextID = 303237}
, 
[504502] = {id = 504502, nameTextID = 303236, exDiscribeTextID = 303238}
, 
[504505] = {id = 504505, nameTextID = 301145, exDiscribeTextID = 301860}
, 
[504506] = {id = 504506, nameTextID = 301143, exDiscribeTextID = 301854}
, 
[504701] = {id = 504701, nameTextID = 301215, exDiscribeTextID = 303125}
, 
[504702] = {id = 504702, nameTextID = 301215, exDiscribeTextID = 303126}
, 
[504801] = {id = 504801, nameTextID = 301216, exDiscribeTextID = 301669}
, 
[504802] = {id = 504802, nameTextID = 301216, exDiscribeTextID = 301536}
, 
[504901] = {id = 504901, nameTextID = 303030, exDiscribeTextID = 303031}
, 
[504902] = {id = 504902, nameTextID = 303030, exDiscribeTextID = 303032}
, 
[505001] = {id = 505001, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505002] = {id = 505002, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505003] = {id = 505003, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505004] = {id = 505004, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505005] = {id = 505005, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505006] = {id = 505006, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505007] = {id = 505007, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505101] = {id = 505101, nameTextID = 301220, exDiscribeTextID = 301916}
, 
[505102] = {id = 505102, nameTextID = 301220, exDiscribeTextID = 301913}
, 
[505201] = {id = 505201, nameTextID = 301223, exDiscribeTextID = 301949}
, 
[505202] = {id = 505202, nameTextID = 301223, exDiscribeTextID = 301948}
, 
[505301] = {id = 505301, nameTextID = 301224, exDiscribeTextID = 303289}
, 
[505302] = {id = 505302, nameTextID = 301224, exDiscribeTextID = 303290}
, 
[505401] = {id = 505401, nameTextID = 301227, exDiscribeTextID = 301553}
, 
[505402] = {id = 505402, nameTextID = 301228, exDiscribeTextID = 301952}
, 
[505403] = {id = 505403, nameTextID = 301143, exDiscribeTextID = 301856}
, 
[505404] = {id = 505404, nameTextID = 301227, exDiscribeTextID = 301555}
, 
[505405] = {id = 505405, nameTextID = 301228, exDiscribeTextID = 301953}
, 
[505406] = {id = 505406, nameTextID = 301143, exDiscribeTextID = 301854}
, 
[505501] = {id = 505501, nameTextID = 303127, exDiscribeTextID = 303128}
, 
[505502] = {id = 505502, nameTextID = 303127, exDiscribeTextID = 303129}
, 
[505601] = {id = 505601, nameTextID = 301231, exDiscribeTextID = 303033}
, 
[505602] = {id = 505602, nameTextID = 301231, exDiscribeTextID = 303034}
, 
[505701] = {id = 505701, nameTextID = 302122, exDiscribeTextID = 302390}
, 
[505702] = {id = 505702, nameTextID = 302125, exDiscribeTextID = 302131}
, 
[505801] = {id = 505801, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505802] = {id = 505802, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505803] = {id = 505803, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505804] = {id = 505804, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505805] = {id = 505805, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505806] = {id = 505806, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505807] = {id = 505807, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[505901] = {id = 505901, nameTextID = 301232, exDiscribeTextID = 301890}
, 
[505902] = {id = 505902, nameTextID = 301232, exDiscribeTextID = 301892}
, 
[506001] = {id = 506001, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506002] = {id = 506002, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506003] = {id = 506003, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506004] = {id = 506004, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506005] = {id = 506005, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506006] = {id = 506006, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506007] = {id = 506007, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506101] = {id = 506101, nameTextID = 302262, exDiscribeTextID = 302264}
, 
[506102] = {id = 506102, nameTextID = 302262, exDiscribeTextID = 302265}
, 
[506201] = {id = 506201, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506202] = {id = 506202, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506203] = {id = 506203, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506204] = {id = 506204, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506205] = {id = 506205, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506206] = {id = 506206, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506207] = {id = 506207, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506301] = {id = 506301, nameTextID = 302915, exDiscribeTextID = 303168}
, 
[506302] = {id = 506302, nameTextID = 302915, exDiscribeTextID = 303169}
, 
[506401] = {id = 506401, nameTextID = 302340, exDiscribeTextID = 302341}
, 
[506402] = {id = 506402, nameTextID = 302340, exDiscribeTextID = 302343}
, 
[506403] = {id = 506403, nameTextID = 302295, exDiscribeTextID = 302298}
, 
[506404] = {id = 506404, nameTextID = 302296, exDiscribeTextID = 302299}
, 
[506405] = {id = 506405, nameTextID = 302295, exDiscribeTextID = 302301}
, 
[506406] = {id = 506406, nameTextID = 302296, exDiscribeTextID = 302302}
, 
[506407] = {id = 506407, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506501] = {id = 506501, nameTextID = 301234, exDiscribeTextID = 301561}
, 
[506502] = {id = 506502, nameTextID = 301234, exDiscribeTextID = 301563}
, 
[506601] = {id = 506601, nameTextID = 303445, exDiscribeTextID = 303446}
, 
[506602] = {id = 506602, nameTextID = 303445, exDiscribeTextID = 303447}
, 
[506603] = {id = 506603, nameTextID = 302296, exDiscribeTextID = 302299}
, 
[506604] = {id = 506604, nameTextID = 302294, exDiscribeTextID = 302300}
, 
[506605] = {id = 506605, nameTextID = 302295, exDiscribeTextID = 302301}
, 
[506606] = {id = 506606, nameTextID = 302296, exDiscribeTextID = 302302}
, 
[506607] = {id = 506607, nameTextID = 301219, exDiscribeTextID = 301219}
, 
[506701] = {id = 506701, nameTextID = 303439, exDiscribeTextID = 303440}
, 
[506702] = {id = 506702, nameTextID = 303439, exDiscribeTextID = 303440}
, 
[506703] = {id = 506703, nameTextID = 301145, exDiscribeTextID = 301862}
, 
[506704] = {id = 506704, nameTextID = 302722, exDiscribeTextID = 302725}
, 
[506705] = {id = 506705, nameTextID = 301143, exDiscribeTextID = 301854}
, 
[506706] = {id = 506706, nameTextID = 301145, exDiscribeTextID = 301860}
, 
[506801] = {id = 506801, nameTextID = 302731, exDiscribeTextID = 302736}
, 
[506802] = {id = 506802, nameTextID = 302732, exDiscribeTextID = 302734}
, 
[506803] = {id = 506803, nameTextID = 302733, exDiscribeTextID = 302735}
, 
[506804] = {id = 506804, nameTextID = 302731, exDiscribeTextID = 302739}
, 
[506805] = {id = 506805, nameTextID = 302732, exDiscribeTextID = 302737}
, 
[506806] = {id = 506806, nameTextID = 302733, exDiscribeTextID = 302738}
, 
[506901] = {id = 506901, nameTextID = 301236, exDiscribeTextID = 301886}
, 
[506902] = {id = 506902, nameTextID = 301236, exDiscribeTextID = 301888}
, 
[507001] = {id = 507001, nameTextID = 302359, exDiscribeTextID = 303035}
, 
[507002] = {id = 507002, nameTextID = 302359, exDiscribeTextID = 303036}
, 
[507101] = {id = 507101, nameTextID = 303266, exDiscribeTextID = 303267}
, 
[507102] = {id = 507102, nameTextID = 303266, exDiscribeTextID = 303268}
, 
[507201] = {id = 507201, nameTextID = 303233, exDiscribeTextID = 303234}
, 
[507202] = {id = 507202, nameTextID = 303233, exDiscribeTextID = 303235}
, 
[507301] = {id = 507301, nameTextID = 302321, exDiscribeTextID = 302326}
, 
[507302] = {id = 507302, nameTextID = 302321, exDiscribeTextID = 302325}
, 
[507401] = {id = 507401, nameTextID = 303130, exDiscribeTextID = 303131}
, 
[507402] = {id = 507402, nameTextID = 303130, exDiscribeTextID = 303132}
, 
[507501] = {id = 507501, nameTextID = 303133, exDiscribeTextID = 303134}
, 
[507502] = {id = 507502, nameTextID = 303133, exDiscribeTextID = 303135}
, 
[507601] = {id = 507601, nameTextID = 302211, exDiscribeTextID = 302212}
, 
[507602] = {id = 507602, nameTextID = 302211, exDiscribeTextID = 302213}
, 
[507801] = {id = 507801, nameTextID = 303276, exDiscribeTextID = 303277}
, 
[507802] = {id = 507802, nameTextID = 303276, exDiscribeTextID = 303278}
, 
[507901] = {id = 507901, nameTextID = 303283, exDiscribeTextID = 303284}
, 
[507902] = {id = 507902, nameTextID = 303283, exDiscribeTextID = 303285}
, 
[508001] = {id = 508001, nameTextID = 303400, exDiscribeTextID = 303401}
, 
[508002] = {id = 508002, nameTextID = 303400, exDiscribeTextID = 303401}
, 
[508101] = {id = 508101, nameTextID = 303248, exDiscribeTextID = 303249}
, 
[508102] = {id = 508102, nameTextID = 303248, exDiscribeTextID = 303249}
, 
[508201] = {id = 508201, nameTextID = 303812, exDiscribeTextID = 303813}
, 
[508202] = {id = 508202, nameTextID = 303812, exDiscribeTextID = 303813}
, 
[508301] = {id = 508301, nameTextID = 303350, exDiscribeTextID = 303351}
, 
[508302] = {id = 508302, nameTextID = 303350, exDiscribeTextID = 303351}
, 
[508401] = {id = 508401, nameTextID = 303556, exDiscribeTextID = 303557}
, 
[508402] = {id = 508402, nameTextID = 303556, exDiscribeTextID = 303557}
, 
[508501] = {id = 508501, nameTextID = 303549, exDiscribeTextID = 303550}
, 
[508502] = {id = 508502, nameTextID = 303549, exDiscribeTextID = 303550}
, 
[508601] = {id = 508601, nameTextID = 303452, exDiscribeTextID = 303453}
, 
[508602] = {id = 508602, nameTextID = 303452, exDiscribeTextID = 303454}
, 
[508801] = {id = 508801, nameTextID = 303677, exDiscribeTextID = 303678}
, 
[508802] = {id = 508802, nameTextID = 303677, exDiscribeTextID = 303678}
, 
[508901] = {id = 508901, nameTextID = 303342, exDiscribeTextID = 303343}
, 
[508902] = {id = 508902, nameTextID = 303342, exDiscribeTextID = 303343}
, 
[509001] = {id = 509001, nameTextID = 303344, exDiscribeTextID = 303345}
, 
[509002] = {id = 509002, nameTextID = 303344, exDiscribeTextID = 303345}
, 
[509101] = {id = 509101, nameTextID = 303475, exDiscribeTextID = 303476}
, 
[509102] = {id = 509102, nameTextID = 303475, exDiscribeTextID = 303476}
, 
[509201] = {id = 509201, nameTextID = 303482, exDiscribeTextID = 303483}
, 
[509202] = {id = 509202, nameTextID = 303482, exDiscribeTextID = 303483}
, 
[509301] = {id = 509301, nameTextID = 303833, exDiscribeTextID = 303834}
, 
[509302] = {id = 509302, nameTextID = 303833, exDiscribeTextID = 303834}
, 
[509401] = {id = 509401, nameTextID = 303563, exDiscribeTextID = 303564}
, 
[509402] = {id = 509402, nameTextID = 303563, exDiscribeTextID = 303564}
, 
[509501] = {id = 509501, nameTextID = 303356, exDiscribeTextID = 303357}
, 
[509502] = {id = 509502, nameTextID = 303356, exDiscribeTextID = 303357}
, 
[509701] = {id = 509701, nameTextID = 303585, exDiscribeTextID = 303586}
, 
[509702] = {id = 509702, nameTextID = 303585, exDiscribeTextID = 303586}
, 
[509801] = {id = 509801, nameTextID = 303752, exDiscribeTextID = 303753}
, 
[509802] = {id = 509802, nameTextID = 303752, exDiscribeTextID = 303753}
, 
[509901] = {id = 509901, nameTextID = 303459, exDiscribeTextID = 303460}
, 
[509902] = {id = 509902, nameTextID = 303459, exDiscribeTextID = 303460}
, 
[510001] = {id = 510001, nameTextID = 303408, exDiscribeTextID = 303409}
, 
[510002] = {id = 510002, nameTextID = 303408, exDiscribeTextID = 303409}
, 
[510101] = {id = 510101, nameTextID = 303576, exDiscribeTextID = 303577}
, 
[510102] = {id = 510102, nameTextID = 303576, exDiscribeTextID = 303577}
, 
[510201] = {id = 510201, nameTextID = 303499, exDiscribeTextID = 303500}
, 
[510202] = {id = 510202, nameTextID = 303499, exDiscribeTextID = 303500}
, 
[510301] = {id = 510301, nameTextID = 303491, exDiscribeTextID = 303492}
, 
[510302] = {id = 510302, nameTextID = 303491, exDiscribeTextID = 303492}
, 
[510401] = {id = 510401, nameTextID = 303694, exDiscribeTextID = 303695}
, 
[510402] = {id = 510402, nameTextID = 303694, exDiscribeTextID = 303695}
, 
[510501] = {id = 510501, nameTextID = 303772, exDiscribeTextID = 303773}
, 
[510502] = {id = 510502, nameTextID = 303772, exDiscribeTextID = 303773}
, 
[510601] = {id = 510601, nameTextID = 303414, exDiscribeTextID = 303415}
, 
[510602] = {id = 510602, nameTextID = 303414, exDiscribeTextID = 303415}
, 
[510701] = {id = 510701, nameTextID = 303778, exDiscribeTextID = 303779}
, 
[510702] = {id = 510702, nameTextID = 303778, exDiscribeTextID = 303779}
, 
[510703] = {id = 510703, nameTextID = 303778, exDiscribeTextID = 303779}
, 
[510704] = {id = 510704, nameTextID = 303778, exDiscribeTextID = 303779}
, 
[510801] = {id = 510801, nameTextID = 303373, exDiscribeTextID = 303374}
, 
[510802] = {id = 510802, nameTextID = 303373, exDiscribeTextID = 303374}
, 
[510901] = {id = 510901, nameTextID = 303744, exDiscribeTextID = 303745}
, 
[510902] = {id = 510902, nameTextID = 303744, exDiscribeTextID = 303745}
, 
[511001] = {id = 511001, nameTextID = 303367, exDiscribeTextID = 303368}
, 
[511002] = {id = 511002, nameTextID = 303367, exDiscribeTextID = 303368}
, 
[511101] = {id = 511101, nameTextID = 303716, exDiscribeTextID = 303717}
, 
[511102] = {id = 511102, nameTextID = 303716, exDiscribeTextID = 303717}
, 
[511201] = {id = 511201, nameTextID = 303686, exDiscribeTextID = 303687}
, 
[511202] = {id = 511202, nameTextID = 303686, exDiscribeTextID = 303687}
, 
[511301] = {id = 511301, nameTextID = 303708, exDiscribeTextID = 303709}
, 
[511302] = {id = 511302, nameTextID = 303708, exDiscribeTextID = 303709}
, 
[511501] = {id = 511501, nameTextID = 303737, exDiscribeTextID = 303738}
, 
[511502] = {id = 511502, nameTextID = 303737, exDiscribeTextID = 303738}
, 
[511601] = {id = 511601, nameTextID = 303826, exDiscribeTextID = 303827}
, 
[511602] = {id = 511602, nameTextID = 303826, exDiscribeTextID = 303827}
, 
[511701] = {id = 511701, nameTextID = 303784, exDiscribeTextID = 303785}
, 
[511702] = {id = 511702, nameTextID = 303784, exDiscribeTextID = 303785}
, 
[511801] = {id = 511801, nameTextID = 303840, exDiscribeTextID = 303841}
, 
[511802] = {id = 511802, nameTextID = 303840, exDiscribeTextID = 303841}
, 
[511901] = {id = 511901, nameTextID = 303759, exDiscribeTextID = 303760}
, 
[511902] = {id = 511902, nameTextID = 303759, exDiscribeTextID = 303760}
, 
[512001] = {id = 512001, nameTextID = 303701, exDiscribeTextID = 303702}
, 
[512002] = {id = 512002, nameTextID = 303701, exDiscribeTextID = 303702}
, 
[512101] = {id = 512101, nameTextID = 303798, exDiscribeTextID = 303799}
, 
[512102] = {id = 512102, nameTextID = 303798, exDiscribeTextID = 303799}
, 
[512201] = {id = 512201, nameTextID = 303791, exDiscribeTextID = 303792}
, 
[512202] = {id = 512202, nameTextID = 303791, exDiscribeTextID = 303792}
, 
[512301] = {id = 512301, nameTextID = 303805, exDiscribeTextID = 303806}
, 
[512302] = {id = 512302, nameTextID = 303805, exDiscribeTextID = 303806}
, 
[512401] = {id = 512401, nameTextID = 303819, exDiscribeTextID = 303820}
, 
[512402] = {id = 512402, nameTextID = 303819, exDiscribeTextID = 303820}
, 
[512601] = {id = 512601, nameTextID = 303847, exDiscribeTextID = 303848}
, 
[512602] = {id = 512602, nameTextID = 303847, exDiscribeTextID = 303848}
, 
[513001] = {id = 513001, nameTextID = 303861, exDiscribeTextID = 303862}
, 
[513002] = {id = 513002, nameTextID = 303861, exDiscribeTextID = 303862}
, 
[6000101] = {id = 6000101, nameTextID = 300404, exDiscribeTextID = 300624}
, 
[6000102] = {id = 6000102, nameTextID = 300404, exDiscribeTextID = 300624}
, 
[6000103] = {id = 6000103, nameTextID = 300404, exDiscribeTextID = 300624}
, 
[6000104] = {id = 6000104, nameTextID = 300404, exDiscribeTextID = 300624}
, 
[6000105] = {id = 6000105, nameTextID = 300404, exDiscribeTextID = 300624}
, 
[6000201] = {id = 6000201, nameTextID = 300405, exDiscribeTextID = 300629}
, 
[6000202] = {id = 6000202, nameTextID = 300405, exDiscribeTextID = 300629}
, 
[6000203] = {id = 6000203, nameTextID = 300405, exDiscribeTextID = 300629}
, 
[6000204] = {id = 6000204, nameTextID = 300405, exDiscribeTextID = 300629}
, 
[6000205] = {id = 6000205, nameTextID = 300405, exDiscribeTextID = 300629}
, 
[6000301] = {id = 6000301, nameTextID = 300406, exDiscribeTextID = 300634}
, 
[6000302] = {id = 6000302, nameTextID = 300406, exDiscribeTextID = 300634}
, 
[6000303] = {id = 6000303, nameTextID = 300406, exDiscribeTextID = 300634}
, 
[6000304] = {id = 6000304, nameTextID = 300406, exDiscribeTextID = 300634}
, 
[6000305] = {id = 6000305, nameTextID = 300406, exDiscribeTextID = 300634}
, 
[6000401] = {id = 6000401, nameTextID = 301975, exDiscribeTextID = 301976}
, 
[6000402] = {id = 6000402, nameTextID = 301975, exDiscribeTextID = 301976}
, 
[6000403] = {id = 6000403, nameTextID = 301975, exDiscribeTextID = 301976}
, 
[6000404] = {id = 6000404, nameTextID = 301975, exDiscribeTextID = 301976}
, 
[6000405] = {id = 6000405, nameTextID = 301975, exDiscribeTextID = 301976}
, 
[6000501] = {id = 6000501, nameTextID = 302243, exDiscribeTextID = 302245}
, 
[6000502] = {id = 6000502, nameTextID = 302243, exDiscribeTextID = 302245}
, 
[6000503] = {id = 6000503, nameTextID = 302243, exDiscribeTextID = 302245}
, 
[6000504] = {id = 6000504, nameTextID = 302243, exDiscribeTextID = 302245}
, 
[6000505] = {id = 6000505, nameTextID = 302243, exDiscribeTextID = 302245}
, 
[6000601] = {id = 6000601, nameTextID = 302369, exDiscribeTextID = 302370}
, 
[6000602] = {id = 6000602, nameTextID = 302369, exDiscribeTextID = 302370}
, 
[6000603] = {id = 6000603, nameTextID = 302369, exDiscribeTextID = 302370}
, 
[6000604] = {id = 6000604, nameTextID = 302369, exDiscribeTextID = 302370}
, 
[6000605] = {id = 6000605, nameTextID = 302369, exDiscribeTextID = 302370}
, 
[6001101] = {id = 6001101, nameTextID = 300407, exDiscribeTextID = 300639}
, 
[6001102] = {id = 6001102, nameTextID = 300407, exDiscribeTextID = 300639}
, 
[6001103] = {id = 6001103, nameTextID = 300407, exDiscribeTextID = 300639}
, 
[6001104] = {id = 6001104, nameTextID = 300407, exDiscribeTextID = 300639}
, 
[6001105] = {id = 6001105, nameTextID = 300407, exDiscribeTextID = 300639}
, 
[6002101] = {id = 6002101, nameTextID = 300408, exDiscribeTextID = 300644}
, 
[6002102] = {id = 6002102, nameTextID = 300408, exDiscribeTextID = 300644}
, 
[6002103] = {id = 6002103, nameTextID = 300408, exDiscribeTextID = 300644}
, 
[6002104] = {id = 6002104, nameTextID = 300408, exDiscribeTextID = 300644}
, 
[6002105] = {id = 6002105, nameTextID = 300408, exDiscribeTextID = 300644}
, 
[6002201] = {id = 6002201, nameTextID = 303049, exDiscribeTextID = 303050}
, 
[6002202] = {id = 6002202, nameTextID = 303049, exDiscribeTextID = 303050}
, 
[6002203] = {id = 6002203, nameTextID = 303049, exDiscribeTextID = 303050}
, 
[6002204] = {id = 6002204, nameTextID = 303049, exDiscribeTextID = 303050}
, 
[6002205] = {id = 6002205, nameTextID = 303049, exDiscribeTextID = 303050}
, 
[6003101] = {id = 6003101, nameTextID = 302219, exDiscribeTextID = 302221}
, 
[6003102] = {id = 6003102, nameTextID = 302219, exDiscribeTextID = 302221}
, 
[6003103] = {id = 6003103, nameTextID = 302219, exDiscribeTextID = 302221}
, 
[6003104] = {id = 6003104, nameTextID = 302219, exDiscribeTextID = 302221}
, 
[6003105] = {id = 6003105, nameTextID = 302219, exDiscribeTextID = 302221}
, 
[6003201] = {id = 6003201, nameTextID = 302220, exDiscribeTextID = 302935}
, 
[6003202] = {id = 6003202, nameTextID = 302220, exDiscribeTextID = 302935}
, 
[6003203] = {id = 6003203, nameTextID = 302220, exDiscribeTextID = 302935}
, 
[6003204] = {id = 6003204, nameTextID = 302220, exDiscribeTextID = 302935}
, 
[6003205] = {id = 6003205, nameTextID = 302220, exDiscribeTextID = 302935}
, 
[6004101] = {id = 6004101, nameTextID = 303051, exDiscribeTextID = 303052}
, 
[6004102] = {id = 6004102, nameTextID = 303051, exDiscribeTextID = 303052}
, 
[6004103] = {id = 6004103, nameTextID = 303051, exDiscribeTextID = 303052}
, 
[6004104] = {id = 6004104, nameTextID = 303051, exDiscribeTextID = 303052}
, 
[6004105] = {id = 6004105, nameTextID = 303051, exDiscribeTextID = 303052}
, 
[6004201] = {id = 6004201, nameTextID = 300413, exDiscribeTextID = 303053}
, 
[6004202] = {id = 6004202, nameTextID = 300413, exDiscribeTextID = 303053}
, 
[6004203] = {id = 6004203, nameTextID = 300413, exDiscribeTextID = 303053}
, 
[6004204] = {id = 6004204, nameTextID = 300413, exDiscribeTextID = 303053}
, 
[6004205] = {id = 6004205, nameTextID = 300413, exDiscribeTextID = 303053}
, 
[6005101] = {id = 6005101, nameTextID = 300415, exDiscribeTextID = 300679}
, 
[6005102] = {id = 6005102, nameTextID = 300415, exDiscribeTextID = 300679}
, 
[6005103] = {id = 6005103, nameTextID = 300415, exDiscribeTextID = 300679}
, 
[6005104] = {id = 6005104, nameTextID = 300415, exDiscribeTextID = 300679}
, 
[6005105] = {id = 6005105, nameTextID = 300415, exDiscribeTextID = 300679}
, 
[6005201] = {id = 6005201, nameTextID = 300416, exDiscribeTextID = 300680}
, 
[6005202] = {id = 6005202, nameTextID = 300416, exDiscribeTextID = 300680}
, 
[6005203] = {id = 6005203, nameTextID = 300416, exDiscribeTextID = 300680}
, 
[6005204] = {id = 6005204, nameTextID = 300416, exDiscribeTextID = 300680}
, 
[6005205] = {id = 6005205, nameTextID = 300416, exDiscribeTextID = 300680}
, 
[6006101] = {id = 6006101, nameTextID = 300417, exDiscribeTextID = 300685}
, 
[6006102] = {id = 6006102, nameTextID = 300417, exDiscribeTextID = 300685}
, 
[6006103] = {id = 6006103, nameTextID = 300417, exDiscribeTextID = 300685}
, 
[6006104] = {id = 6006104, nameTextID = 300417, exDiscribeTextID = 300685}
, 
[6006105] = {id = 6006105, nameTextID = 300417, exDiscribeTextID = 300685}
, 
[6006201] = {id = 6006201, nameTextID = 300418, exDiscribeTextID = 300690}
, 
[6006202] = {id = 6006202, nameTextID = 300418, exDiscribeTextID = 300690}
, 
[6006203] = {id = 6006203, nameTextID = 300418, exDiscribeTextID = 300690}
, 
[6006204] = {id = 6006204, nameTextID = 300418, exDiscribeTextID = 300690}
, 
[6006205] = {id = 6006205, nameTextID = 300418, exDiscribeTextID = 300690}
, 
[6007101] = {id = 6007101, nameTextID = 300419, exDiscribeTextID = 300695}
, 
[6007102] = {id = 6007102, nameTextID = 300419, exDiscribeTextID = 300695}
, 
[6007103] = {id = 6007103, nameTextID = 300419, exDiscribeTextID = 300695}
, 
[6007104] = {id = 6007104, nameTextID = 300419, exDiscribeTextID = 300695}
, 
[6007105] = {id = 6007105, nameTextID = 300419, exDiscribeTextID = 300695}
, 
[6007201] = {id = 6007201, nameTextID = 300420, exDiscribeTextID = 300700}
, 
[6007202] = {id = 6007202, nameTextID = 300420, exDiscribeTextID = 300700}
, 
[6007203] = {id = 6007203, nameTextID = 300420, exDiscribeTextID = 300700}
, 
[6007204] = {id = 6007204, nameTextID = 300420, exDiscribeTextID = 300700}
, 
[6007205] = {id = 6007205, nameTextID = 300420, exDiscribeTextID = 300700}
, 
[6008101] = {id = 6008101, nameTextID = 302950, exDiscribeTextID = 302952}
, 
[6008102] = {id = 6008102, nameTextID = 302950, exDiscribeTextID = 302952}
, 
[6008103] = {id = 6008103, nameTextID = 302950, exDiscribeTextID = 302952}
, 
[6008104] = {id = 6008104, nameTextID = 302950, exDiscribeTextID = 302952}
, 
[6008105] = {id = 6008105, nameTextID = 302950, exDiscribeTextID = 302952}
, 
[6008201] = {id = 6008201, nameTextID = 302951, exDiscribeTextID = 302953}
, 
[6008202] = {id = 6008202, nameTextID = 302951, exDiscribeTextID = 302953}
, 
[6008203] = {id = 6008203, nameTextID = 302951, exDiscribeTextID = 302953}
, 
[6008204] = {id = 6008204, nameTextID = 302951, exDiscribeTextID = 302953}
, 
[6008205] = {id = 6008205, nameTextID = 302951, exDiscribeTextID = 302953}
, 
[6009101] = {id = 6009101, nameTextID = 300423, exDiscribeTextID = 300715}
, 
[6009102] = {id = 6009102, nameTextID = 300423, exDiscribeTextID = 300715}
, 
[6009103] = {id = 6009103, nameTextID = 300423, exDiscribeTextID = 300715}
, 
[6009104] = {id = 6009104, nameTextID = 300423, exDiscribeTextID = 300715}
, 
[6009105] = {id = 6009105, nameTextID = 300423, exDiscribeTextID = 300715}
, 
[6009201] = {id = 6009201, nameTextID = 300424, exDiscribeTextID = 303054}
, 
[6009202] = {id = 6009202, nameTextID = 300424, exDiscribeTextID = 303054}
, 
[6009203] = {id = 6009203, nameTextID = 300424, exDiscribeTextID = 303054}
, 
[6009204] = {id = 6009204, nameTextID = 300424, exDiscribeTextID = 303054}
, 
[6009205] = {id = 6009205, nameTextID = 300424, exDiscribeTextID = 303054}
, 
[6010101] = {id = 6010101, nameTextID = 300425, exDiscribeTextID = 303269}
, 
[6010102] = {id = 6010102, nameTextID = 300425, exDiscribeTextID = 303269}
, 
[6010103] = {id = 6010103, nameTextID = 300425, exDiscribeTextID = 303269}
, 
[6010104] = {id = 6010104, nameTextID = 300425, exDiscribeTextID = 303269}
, 
[6010105] = {id = 6010105, nameTextID = 300425, exDiscribeTextID = 303269}
, 
[6010201] = {id = 6010201, nameTextID = 300426, exDiscribeTextID = 303271}
, 
[6010202] = {id = 6010202, nameTextID = 300426, exDiscribeTextID = 303271}
, 
[6010203] = {id = 6010203, nameTextID = 300426, exDiscribeTextID = 303271}
, 
[6010204] = {id = 6010204, nameTextID = 300426, exDiscribeTextID = 303271}
, 
[6010205] = {id = 6010205, nameTextID = 300426, exDiscribeTextID = 303271}
, 
[6011101] = {id = 6011101, nameTextID = 300427, exDiscribeTextID = 303057}
, 
[6011102] = {id = 6011102, nameTextID = 300427, exDiscribeTextID = 303057}
, 
[6011103] = {id = 6011103, nameTextID = 300427, exDiscribeTextID = 303057}
, 
[6011104] = {id = 6011104, nameTextID = 300427, exDiscribeTextID = 303057}
, 
[6011105] = {id = 6011105, nameTextID = 300427, exDiscribeTextID = 303057}
, 
[6011201] = {id = 6011201, nameTextID = 300428, exDiscribeTextID = 300740}
, 
[6011202] = {id = 6011202, nameTextID = 300428, exDiscribeTextID = 300740}
, 
[6011203] = {id = 6011203, nameTextID = 300428, exDiscribeTextID = 300740}
, 
[6011204] = {id = 6011204, nameTextID = 300428, exDiscribeTextID = 300740}
, 
[6011205] = {id = 6011205, nameTextID = 300428, exDiscribeTextID = 300740}
, 
[6012101] = {id = 6012101, nameTextID = 302944, exDiscribeTextID = 302942}
, 
[6012102] = {id = 6012102, nameTextID = 302944, exDiscribeTextID = 302942}
, 
[6012103] = {id = 6012103, nameTextID = 302944, exDiscribeTextID = 302942}
, 
[6012104] = {id = 6012104, nameTextID = 302944, exDiscribeTextID = 302942}
, 
[6012105] = {id = 6012105, nameTextID = 302944, exDiscribeTextID = 302942}
, 
[6012201] = {id = 6012201, nameTextID = 302945, exDiscribeTextID = 303329}
, 
[6012202] = {id = 6012202, nameTextID = 302945, exDiscribeTextID = 303329}
, 
[6012203] = {id = 6012203, nameTextID = 302945, exDiscribeTextID = 303329}
, 
[6012204] = {id = 6012204, nameTextID = 302945, exDiscribeTextID = 303329}
, 
[6012205] = {id = 6012205, nameTextID = 302945, exDiscribeTextID = 303329}
, 
[6013101] = {id = 6013101, nameTextID = 300429, exDiscribeTextID = 303158}
, 
[6013102] = {id = 6013102, nameTextID = 300429, exDiscribeTextID = 303158}
, 
[6013103] = {id = 6013103, nameTextID = 300429, exDiscribeTextID = 303158}
, 
[6013104] = {id = 6013104, nameTextID = 300429, exDiscribeTextID = 303158}
, 
[6013105] = {id = 6013105, nameTextID = 300429, exDiscribeTextID = 303158}
, 
[6013201] = {id = 6013201, nameTextID = 300430, exDiscribeTextID = 303058}
, 
[6013202] = {id = 6013202, nameTextID = 300430, exDiscribeTextID = 303058}
, 
[6013203] = {id = 6013203, nameTextID = 300430, exDiscribeTextID = 303058}
, 
[6013204] = {id = 6013204, nameTextID = 300430, exDiscribeTextID = 303058}
, 
[6013205] = {id = 6013205, nameTextID = 300430, exDiscribeTextID = 303058}
, 
[6014101] = {id = 6014101, nameTextID = 300431, exDiscribeTextID = 300755}
, 
[6014102] = {id = 6014102, nameTextID = 300431, exDiscribeTextID = 300755}
, 
[6014103] = {id = 6014103, nameTextID = 300431, exDiscribeTextID = 300755}
, 
[6014104] = {id = 6014104, nameTextID = 300431, exDiscribeTextID = 300755}
, 
[6014105] = {id = 6014105, nameTextID = 300431, exDiscribeTextID = 300755}
, 
[6014201] = {id = 6014201, nameTextID = 300432, exDiscribeTextID = 300760}
, 
[6014202] = {id = 6014202, nameTextID = 300432, exDiscribeTextID = 300760}
, 
[6014203] = {id = 6014203, nameTextID = 300432, exDiscribeTextID = 300760}
, 
[6014204] = {id = 6014204, nameTextID = 300432, exDiscribeTextID = 300760}
, 
[6014205] = {id = 6014205, nameTextID = 300432, exDiscribeTextID = 300760}
, 
[6014301] = {id = 6014301, nameTextID = 300433, exDiscribeTextID = 300761}
, 
[6014302] = {id = 6014302, nameTextID = 300433, exDiscribeTextID = 300761}
, 
[6014303] = {id = 6014303, nameTextID = 300433, exDiscribeTextID = 300761}
, 
[6014304] = {id = 6014304, nameTextID = 300433, exDiscribeTextID = 300761}
, 
[6014305] = {id = 6014305, nameTextID = 300433, exDiscribeTextID = 300761}
, 
[6014401] = {id = 6014401, nameTextID = 300431, exDiscribeTextID = 303163}
, 
[6014402] = {id = 6014402, nameTextID = 300431, exDiscribeTextID = 303163}
, 
[6014403] = {id = 6014403, nameTextID = 300431, exDiscribeTextID = 303163}
, 
[6014404] = {id = 6014404, nameTextID = 300431, exDiscribeTextID = 303163}
, 
[6014405] = {id = 6014405, nameTextID = 300431, exDiscribeTextID = 303163}
, 
[6015101] = {id = 6015101, nameTextID = 300434, exDiscribeTextID = 302948}
, 
[6015102] = {id = 6015102, nameTextID = 300434, exDiscribeTextID = 302948}
, 
[6015103] = {id = 6015103, nameTextID = 300434, exDiscribeTextID = 302948}
, 
[6015104] = {id = 6015104, nameTextID = 300434, exDiscribeTextID = 302948}
, 
[6015105] = {id = 6015105, nameTextID = 300434, exDiscribeTextID = 302948}
, 
[6015201] = {id = 6015201, nameTextID = 300435, exDiscribeTextID = 302949}
, 
[6015202] = {id = 6015202, nameTextID = 300435, exDiscribeTextID = 302949}
, 
[6015203] = {id = 6015203, nameTextID = 300435, exDiscribeTextID = 302949}
, 
[6015204] = {id = 6015204, nameTextID = 300435, exDiscribeTextID = 302949}
, 
[6015205] = {id = 6015205, nameTextID = 300435, exDiscribeTextID = 302949}
, 
[6016101] = {id = 6016101, nameTextID = 303104, exDiscribeTextID = 303105}
, 
[6016102] = {id = 6016102, nameTextID = 303104, exDiscribeTextID = 303105}
, 
[6016103] = {id = 6016103, nameTextID = 303104, exDiscribeTextID = 303105}
, 
[6016104] = {id = 6016104, nameTextID = 303104, exDiscribeTextID = 303105}
, 
[6016105] = {id = 6016105, nameTextID = 303104, exDiscribeTextID = 303105}
, 
[6016201] = {id = 6016201, nameTextID = 303106, exDiscribeTextID = 303107}
, 
[6016202] = {id = 6016202, nameTextID = 303106, exDiscribeTextID = 303107}
, 
[6016203] = {id = 6016203, nameTextID = 303106, exDiscribeTextID = 303107}
, 
[6016204] = {id = 6016204, nameTextID = 303106, exDiscribeTextID = 303107}
, 
[6016205] = {id = 6016205, nameTextID = 303106, exDiscribeTextID = 303107}
, 
[6017101] = {id = 6017101, nameTextID = 300438, exDiscribeTextID = 303115}
, 
[6017102] = {id = 6017102, nameTextID = 300438, exDiscribeTextID = 303115}
, 
[6017103] = {id = 6017103, nameTextID = 300438, exDiscribeTextID = 303115}
, 
[6017104] = {id = 6017104, nameTextID = 300438, exDiscribeTextID = 303115}
, 
[6017105] = {id = 6017105, nameTextID = 300438, exDiscribeTextID = 303115}
, 
[6017201] = {id = 6017201, nameTextID = 300439, exDiscribeTextID = 303059}
, 
[6017202] = {id = 6017202, nameTextID = 300439, exDiscribeTextID = 303059}
, 
[6017203] = {id = 6017203, nameTextID = 300439, exDiscribeTextID = 303059}
, 
[6017204] = {id = 6017204, nameTextID = 300439, exDiscribeTextID = 303059}
, 
[6017205] = {id = 6017205, nameTextID = 300439, exDiscribeTextID = 303059}
, 
[6018101] = {id = 6018101, nameTextID = 300440, exDiscribeTextID = 300796}
, 
[6018102] = {id = 6018102, nameTextID = 300440, exDiscribeTextID = 300796}
, 
[6018103] = {id = 6018103, nameTextID = 300440, exDiscribeTextID = 300796}
, 
[6018104] = {id = 6018104, nameTextID = 300440, exDiscribeTextID = 300796}
, 
[6018105] = {id = 6018105, nameTextID = 300440, exDiscribeTextID = 300796}
, 
[6018201] = {id = 6018201, nameTextID = 300441, exDiscribeTextID = 303064}
, 
[6018202] = {id = 6018202, nameTextID = 300441, exDiscribeTextID = 303064}
, 
[6018203] = {id = 6018203, nameTextID = 300441, exDiscribeTextID = 303064}
, 
[6018204] = {id = 6018204, nameTextID = 300441, exDiscribeTextID = 303064}
, 
[6018205] = {id = 6018205, nameTextID = 300441, exDiscribeTextID = 303064}
, 
[6019101] = {id = 6019101, nameTextID = 300442, exDiscribeTextID = 302962}
, 
[6019102] = {id = 6019102, nameTextID = 300442, exDiscribeTextID = 302962}
, 
[6019103] = {id = 6019103, nameTextID = 300442, exDiscribeTextID = 302962}
, 
[6019104] = {id = 6019104, nameTextID = 300442, exDiscribeTextID = 302962}
, 
[6019105] = {id = 6019105, nameTextID = 300442, exDiscribeTextID = 302962}
, 
[6019201] = {id = 6019201, nameTextID = 302958, exDiscribeTextID = 302963}
, 
[6019202] = {id = 6019202, nameTextID = 302958, exDiscribeTextID = 302963}
, 
[6019203] = {id = 6019203, nameTextID = 302958, exDiscribeTextID = 302963}
, 
[6019204] = {id = 6019204, nameTextID = 302958, exDiscribeTextID = 302963}
, 
[6019205] = {id = 6019205, nameTextID = 302958, exDiscribeTextID = 302963}
, 
[6020101] = {id = 6020101, nameTextID = 300444, exDiscribeTextID = 300816}
, 
[6020102] = {id = 6020102, nameTextID = 300444, exDiscribeTextID = 300816}
, 
[6020103] = {id = 6020103, nameTextID = 300444, exDiscribeTextID = 300816}
, 
[6020104] = {id = 6020104, nameTextID = 300444, exDiscribeTextID = 300816}
, 
[6020105] = {id = 6020105, nameTextID = 300444, exDiscribeTextID = 300816}
, 
[6020201] = {id = 6020201, nameTextID = 300445, exDiscribeTextID = 300821}
, 
[6020202] = {id = 6020202, nameTextID = 300445, exDiscribeTextID = 300821}
, 
[6020203] = {id = 6020203, nameTextID = 300445, exDiscribeTextID = 300821}
, 
[6020204] = {id = 6020204, nameTextID = 300445, exDiscribeTextID = 300821}
, 
[6020205] = {id = 6020205, nameTextID = 300445, exDiscribeTextID = 300821}
, 
[6021101] = {id = 6021101, nameTextID = 300446, exDiscribeTextID = 300826}
, 
[6021102] = {id = 6021102, nameTextID = 300446, exDiscribeTextID = 300826}
, 
[6021103] = {id = 6021103, nameTextID = 300446, exDiscribeTextID = 300826}
, 
[6021104] = {id = 6021104, nameTextID = 300446, exDiscribeTextID = 300826}
, 
[6021105] = {id = 6021105, nameTextID = 300446, exDiscribeTextID = 300826}
, 
[6021106] = {id = 6021106, nameTextID = 300446, exDiscribeTextID = 300826}
, 
[6021201] = {id = 6021201, nameTextID = 300447, exDiscribeTextID = 300831}
, 
[6021202] = {id = 6021202, nameTextID = 300447, exDiscribeTextID = 300831}
, 
[6021203] = {id = 6021203, nameTextID = 300447, exDiscribeTextID = 300831}
, 
[6021204] = {id = 6021204, nameTextID = 300447, exDiscribeTextID = 300831}
, 
[6021205] = {id = 6021205, nameTextID = 300447, exDiscribeTextID = 300831}
, 
[6022101] = {id = 6022101, nameTextID = 303017, exDiscribeTextID = 302964}
, 
[6022102] = {id = 6022102, nameTextID = 303017, exDiscribeTextID = 302964}
, 
[6022103] = {id = 6022103, nameTextID = 303017, exDiscribeTextID = 302964}
, 
[6022104] = {id = 6022104, nameTextID = 303017, exDiscribeTextID = 302964}
, 
[6022105] = {id = 6022105, nameTextID = 303017, exDiscribeTextID = 302964}
, 
[6022201] = {id = 6022201, nameTextID = 302941, exDiscribeTextID = 302969}
, 
[6022202] = {id = 6022202, nameTextID = 302941, exDiscribeTextID = 302969}
, 
[6022203] = {id = 6022203, nameTextID = 302941, exDiscribeTextID = 302969}
, 
[6022204] = {id = 6022204, nameTextID = 302941, exDiscribeTextID = 302969}
, 
[6022205] = {id = 6022205, nameTextID = 302941, exDiscribeTextID = 302969}
, 
[6023101] = {id = 6023101, nameTextID = 300451, exDiscribeTextID = 303224}
, 
[6023102] = {id = 6023102, nameTextID = 300451, exDiscribeTextID = 303224}
, 
[6023103] = {id = 6023103, nameTextID = 300451, exDiscribeTextID = 303224}
, 
[6023104] = {id = 6023104, nameTextID = 300451, exDiscribeTextID = 303224}
, 
[6023105] = {id = 6023105, nameTextID = 300451, exDiscribeTextID = 303224}
, 
[6023201] = {id = 6023201, nameTextID = 300450, exDiscribeTextID = 303225}
, 
[6023202] = {id = 6023202, nameTextID = 300450, exDiscribeTextID = 303225}
, 
[6023203] = {id = 6023203, nameTextID = 300450, exDiscribeTextID = 303225}
, 
[6023204] = {id = 6023204, nameTextID = 300450, exDiscribeTextID = 303225}
, 
[6023205] = {id = 6023205, nameTextID = 300450, exDiscribeTextID = 303225}
, 
[6024101] = {id = 6024101, nameTextID = 300452, exDiscribeTextID = 302974}
, 
[6024102] = {id = 6024102, nameTextID = 300452, exDiscribeTextID = 302974}
, 
[6024103] = {id = 6024103, nameTextID = 300452, exDiscribeTextID = 302974}
, 
[6024104] = {id = 6024104, nameTextID = 300452, exDiscribeTextID = 302974}
, 
[6024105] = {id = 6024105, nameTextID = 300452, exDiscribeTextID = 302974}
, 
[6024201] = {id = 6024201, nameTextID = 300453, exDiscribeTextID = 300861}
, 
[6024202] = {id = 6024202, nameTextID = 300453, exDiscribeTextID = 300861}
, 
[6024203] = {id = 6024203, nameTextID = 300453, exDiscribeTextID = 300861}
, 
[6024204] = {id = 6024204, nameTextID = 300453, exDiscribeTextID = 300861}
, 
[6024205] = {id = 6024205, nameTextID = 300453, exDiscribeTextID = 300861}
, 
[6025101] = {id = 6025101, nameTextID = 300454, exDiscribeTextID = 300866}
, 
[6025102] = {id = 6025102, nameTextID = 300454, exDiscribeTextID = 300866}
, 
[6025103] = {id = 6025103, nameTextID = 300454, exDiscribeTextID = 300866}
, 
[6025104] = {id = 6025104, nameTextID = 300454, exDiscribeTextID = 300866}
, 
[6025105] = {id = 6025105, nameTextID = 300454, exDiscribeTextID = 300866}
, 
[6025201] = {id = 6025201, nameTextID = 300455, exDiscribeTextID = 300871}
, 
[6025202] = {id = 6025202, nameTextID = 300455, exDiscribeTextID = 300871}
, 
[6025203] = {id = 6025203, nameTextID = 300455, exDiscribeTextID = 300871}
, 
[6025204] = {id = 6025204, nameTextID = 300455, exDiscribeTextID = 300871}
, 
[6025205] = {id = 6025205, nameTextID = 300455, exDiscribeTextID = 300871}
, 
[6025401] = {id = 6025401, nameTextID = 303242, exDiscribeTextID = 303243}
, 
[6025402] = {id = 6025402, nameTextID = 303242, exDiscribeTextID = 303243}
, 
[6025403] = {id = 6025403, nameTextID = 303242, exDiscribeTextID = 303243}
, 
[6025404] = {id = 6025404, nameTextID = 303242, exDiscribeTextID = 303243}
, 
[6025405] = {id = 6025405, nameTextID = 303242, exDiscribeTextID = 303243}
, 
[6026101] = {id = 6026101, nameTextID = 300456, exDiscribeTextID = 300876}
, 
[6026102] = {id = 6026102, nameTextID = 300456, exDiscribeTextID = 300876}
, 
[6026103] = {id = 6026103, nameTextID = 300456, exDiscribeTextID = 300876}
, 
[6026104] = {id = 6026104, nameTextID = 300456, exDiscribeTextID = 300876}
, 
[6026105] = {id = 6026105, nameTextID = 300456, exDiscribeTextID = 300876}
, 
[6026201] = {id = 6026201, nameTextID = 300457, exDiscribeTextID = 300881}
, 
[6026202] = {id = 6026202, nameTextID = 300457, exDiscribeTextID = 300881}
, 
[6026203] = {id = 6026203, nameTextID = 300457, exDiscribeTextID = 300881}
, 
[6026204] = {id = 6026204, nameTextID = 300457, exDiscribeTextID = 300881}
, 
[6026205] = {id = 6026205, nameTextID = 300457, exDiscribeTextID = 300881}
, 
[6027101] = {id = 6027101, nameTextID = 300458, exDiscribeTextID = 300886}
, 
[6027102] = {id = 6027102, nameTextID = 300458, exDiscribeTextID = 300886}
, 
[6027103] = {id = 6027103, nameTextID = 300458, exDiscribeTextID = 300886}
, 
[6027104] = {id = 6027104, nameTextID = 300458, exDiscribeTextID = 300886}
, 
[6027105] = {id = 6027105, nameTextID = 300458, exDiscribeTextID = 300886}
, 
[6027201] = {id = 6027201, nameTextID = 303060, exDiscribeTextID = 303061}
, 
[6027202] = {id = 6027202, nameTextID = 303060, exDiscribeTextID = 303061}
, 
[6027203] = {id = 6027203, nameTextID = 303060, exDiscribeTextID = 303061}
, 
[6027204] = {id = 6027204, nameTextID = 303060, exDiscribeTextID = 303061}
, 
[6027205] = {id = 6027205, nameTextID = 303060, exDiscribeTextID = 303061}
, 
[6028101] = {id = 6028101, nameTextID = 302959, exDiscribeTextID = 302975}
, 
[6028102] = {id = 6028102, nameTextID = 302959, exDiscribeTextID = 302975}
, 
[6028103] = {id = 6028103, nameTextID = 302959, exDiscribeTextID = 302975}
, 
[6028104] = {id = 6028104, nameTextID = 302959, exDiscribeTextID = 302975}
, 
[6028105] = {id = 6028105, nameTextID = 302959, exDiscribeTextID = 302975}
, 
[6028201] = {id = 6028201, nameTextID = 300461, exDiscribeTextID = 300901}
, 
[6028202] = {id = 6028202, nameTextID = 300461, exDiscribeTextID = 300901}
, 
[6028203] = {id = 6028203, nameTextID = 300461, exDiscribeTextID = 300901}
, 
[6028204] = {id = 6028204, nameTextID = 300461, exDiscribeTextID = 300901}
, 
[6028205] = {id = 6028205, nameTextID = 300461, exDiscribeTextID = 300901}
, 
[6029101] = {id = 6029101, nameTextID = 300462, exDiscribeTextID = 303140}
, 
[6029102] = {id = 6029102, nameTextID = 300462, exDiscribeTextID = 303140}
, 
[6029103] = {id = 6029103, nameTextID = 300462, exDiscribeTextID = 303140}
, 
[6029104] = {id = 6029104, nameTextID = 300462, exDiscribeTextID = 303140}
, 
[6029105] = {id = 6029105, nameTextID = 300462, exDiscribeTextID = 303140}
, 
[6029201] = {id = 6029201, nameTextID = 300463, exDiscribeTextID = 303141}
, 
[6029202] = {id = 6029202, nameTextID = 300463, exDiscribeTextID = 303141}
, 
[6029203] = {id = 6029203, nameTextID = 300463, exDiscribeTextID = 303141}
, 
[6029204] = {id = 6029204, nameTextID = 300463, exDiscribeTextID = 303141}
, 
[6029205] = {id = 6029205, nameTextID = 300463, exDiscribeTextID = 303141}
, 
[6030101] = {id = 6030101, nameTextID = 300453, exDiscribeTextID = 302976}
, 
[6030102] = {id = 6030102, nameTextID = 300453, exDiscribeTextID = 302976}
, 
[6030103] = {id = 6030103, nameTextID = 300453, exDiscribeTextID = 302976}
, 
[6030104] = {id = 6030104, nameTextID = 300453, exDiscribeTextID = 302976}
, 
[6030105] = {id = 6030105, nameTextID = 300453, exDiscribeTextID = 302976}
, 
[6030201] = {id = 6030201, nameTextID = 300464, exDiscribeTextID = 302977}
, 
[6030202] = {id = 6030202, nameTextID = 300464, exDiscribeTextID = 302977}
, 
[6030203] = {id = 6030203, nameTextID = 300464, exDiscribeTextID = 302977}
, 
[6030204] = {id = 6030204, nameTextID = 300464, exDiscribeTextID = 302977}
, 
[6030205] = {id = 6030205, nameTextID = 300464, exDiscribeTextID = 302977}
, 
[6032101] = {id = 6032101, nameTextID = 300465, exDiscribeTextID = 303062}
, 
[6032102] = {id = 6032102, nameTextID = 300465, exDiscribeTextID = 303062}
, 
[6032103] = {id = 6032103, nameTextID = 300465, exDiscribeTextID = 303062}
, 
[6032104] = {id = 6032104, nameTextID = 300465, exDiscribeTextID = 303062}
, 
[6032105] = {id = 6032105, nameTextID = 300465, exDiscribeTextID = 303062}
, 
[6032201] = {id = 6032201, nameTextID = 300466, exDiscribeTextID = 303063}
, 
[6032202] = {id = 6032202, nameTextID = 300466, exDiscribeTextID = 303063}
, 
[6032203] = {id = 6032203, nameTextID = 300466, exDiscribeTextID = 303063}
, 
[6032204] = {id = 6032204, nameTextID = 300466, exDiscribeTextID = 303063}
, 
[6032205] = {id = 6032205, nameTextID = 300466, exDiscribeTextID = 303063}
, 
[6033101] = {id = 6033101, nameTextID = 300467, exDiscribeTextID = 300936}
, 
[6033102] = {id = 6033102, nameTextID = 300467, exDiscribeTextID = 300936}
, 
[6033103] = {id = 6033103, nameTextID = 300467, exDiscribeTextID = 300936}
, 
[6033104] = {id = 6033104, nameTextID = 300467, exDiscribeTextID = 300936}
, 
[6033105] = {id = 6033105, nameTextID = 300467, exDiscribeTextID = 300936}
, 
[6033201] = {id = 6033201, nameTextID = 300468, exDiscribeTextID = 303065}
, 
[6033202] = {id = 6033202, nameTextID = 300468, exDiscribeTextID = 303065}
, 
[6033203] = {id = 6033203, nameTextID = 300468, exDiscribeTextID = 303065}
, 
[6033204] = {id = 6033204, nameTextID = 300468, exDiscribeTextID = 303065}
, 
[6033205] = {id = 6033205, nameTextID = 300468, exDiscribeTextID = 303065}
, 
[6034101] = {id = 6034101, nameTextID = 300469, exDiscribeTextID = 303066}
, 
[6034102] = {id = 6034102, nameTextID = 300469, exDiscribeTextID = 303066}
, 
[6034103] = {id = 6034103, nameTextID = 300469, exDiscribeTextID = 303066}
, 
[6034104] = {id = 6034104, nameTextID = 300469, exDiscribeTextID = 303066}
, 
[6034105] = {id = 6034105, nameTextID = 300469, exDiscribeTextID = 303066}
, 
[6034201] = {id = 6034201, nameTextID = 303067, exDiscribeTextID = 303068}
, 
[6034202] = {id = 6034202, nameTextID = 303067, exDiscribeTextID = 303068}
, 
[6034203] = {id = 6034203, nameTextID = 303067, exDiscribeTextID = 303068}
, 
[6034204] = {id = 6034204, nameTextID = 303067, exDiscribeTextID = 303068}
, 
[6034205] = {id = 6034205, nameTextID = 303067, exDiscribeTextID = 303068}
, 
[6035101] = {id = 6035101, nameTextID = 303019, exDiscribeTextID = 300956}
, 
[6035102] = {id = 6035102, nameTextID = 303019, exDiscribeTextID = 300956}
, 
[6035103] = {id = 6035103, nameTextID = 303019, exDiscribeTextID = 300956}
, 
[6035104] = {id = 6035104, nameTextID = 303019, exDiscribeTextID = 300956}
, 
[6035105] = {id = 6035105, nameTextID = 303019, exDiscribeTextID = 300956}
, 
[6035201] = {id = 6035201, nameTextID = 300472, exDiscribeTextID = 302978}
, 
[6035202] = {id = 6035202, nameTextID = 300472, exDiscribeTextID = 302978}
, 
[6035203] = {id = 6035203, nameTextID = 300472, exDiscribeTextID = 302978}
, 
[6035204] = {id = 6035204, nameTextID = 300472, exDiscribeTextID = 302978}
, 
[6035205] = {id = 6035205, nameTextID = 300472, exDiscribeTextID = 302978}
, 
[6036101] = {id = 6036101, nameTextID = 302960, exDiscribeTextID = 302983}
, 
[6036102] = {id = 6036102, nameTextID = 302960, exDiscribeTextID = 302983}
, 
[6036103] = {id = 6036103, nameTextID = 302960, exDiscribeTextID = 302983}
, 
[6036104] = {id = 6036104, nameTextID = 302960, exDiscribeTextID = 302983}
, 
[6036105] = {id = 6036105, nameTextID = 302960, exDiscribeTextID = 302983}
, 
[6036201] = {id = 6036201, nameTextID = 302961, exDiscribeTextID = 302988}
, 
[6036202] = {id = 6036202, nameTextID = 302961, exDiscribeTextID = 302988}
, 
[6036203] = {id = 6036203, nameTextID = 302961, exDiscribeTextID = 302988}
, 
[6036204] = {id = 6036204, nameTextID = 302961, exDiscribeTextID = 302988}
, 
[6036205] = {id = 6036205, nameTextID = 302961, exDiscribeTextID = 302988}
, 
[6038101] = {id = 6038101, nameTextID = 300475, exDiscribeTextID = 300976}
, 
[6038102] = {id = 6038102, nameTextID = 300475, exDiscribeTextID = 300976}
, 
[6038103] = {id = 6038103, nameTextID = 300475, exDiscribeTextID = 300976}
, 
[6038104] = {id = 6038104, nameTextID = 300475, exDiscribeTextID = 300976}
, 
[6038105] = {id = 6038105, nameTextID = 300475, exDiscribeTextID = 300976}
, 
[6038201] = {id = 6038201, nameTextID = 300476, exDiscribeTextID = 300977}
, 
[6038202] = {id = 6038202, nameTextID = 300476, exDiscribeTextID = 300977}
, 
[6038203] = {id = 6038203, nameTextID = 300476, exDiscribeTextID = 300977}
, 
[6038204] = {id = 6038204, nameTextID = 300476, exDiscribeTextID = 300977}
, 
[6038205] = {id = 6038205, nameTextID = 300476, exDiscribeTextID = 300977}
, 
[6038701] = {id = 6038701, nameTextID = 303170, exDiscribeTextID = 303172}
, 
[6038702] = {id = 6038702, nameTextID = 303170, exDiscribeTextID = 303172}
, 
[6038703] = {id = 6038703, nameTextID = 303170, exDiscribeTextID = 303172}
, 
[6038704] = {id = 6038704, nameTextID = 303170, exDiscribeTextID = 303172}
, 
[6038705] = {id = 6038705, nameTextID = 303170, exDiscribeTextID = 303172}
, 
[6038801] = {id = 6038801, nameTextID = 303171, exDiscribeTextID = 303173}
, 
[6038802] = {id = 6038802, nameTextID = 303171, exDiscribeTextID = 303173}
, 
[6038803] = {id = 6038803, nameTextID = 303171, exDiscribeTextID = 303173}
, 
[6038804] = {id = 6038804, nameTextID = 303171, exDiscribeTextID = 303173}
, 
[6038805] = {id = 6038805, nameTextID = 303171, exDiscribeTextID = 303173}
, 
[6039101] = {id = 6039101, nameTextID = 303463, exDiscribeTextID = 303464}
, 
[6039102] = {id = 6039102, nameTextID = 303463, exDiscribeTextID = 303464}
, 
[6039103] = {id = 6039103, nameTextID = 303463, exDiscribeTextID = 303464}
, 
[6039104] = {id = 6039104, nameTextID = 303463, exDiscribeTextID = 303464}
, 
[6039105] = {id = 6039105, nameTextID = 303463, exDiscribeTextID = 303464}
, 
[6039201] = {id = 6039201, nameTextID = 303465, exDiscribeTextID = 303466}
, 
[6039202] = {id = 6039202, nameTextID = 303465, exDiscribeTextID = 303466}
, 
[6039203] = {id = 6039203, nameTextID = 303465, exDiscribeTextID = 303466}
, 
[6039204] = {id = 6039204, nameTextID = 303465, exDiscribeTextID = 303466}
, 
[6039205] = {id = 6039205, nameTextID = 303465, exDiscribeTextID = 303466}
, 
[6041101] = {id = 6041101, nameTextID = 300479, exDiscribeTextID = 302946}
, 
[6041102] = {id = 6041102, nameTextID = 300479, exDiscribeTextID = 302946}
, 
[6041103] = {id = 6041103, nameTextID = 300479, exDiscribeTextID = 302946}
, 
[6041104] = {id = 6041104, nameTextID = 300479, exDiscribeTextID = 302946}
, 
[6041105] = {id = 6041105, nameTextID = 300479, exDiscribeTextID = 302946}
, 
[6041201] = {id = 6041201, nameTextID = 300480, exDiscribeTextID = 302947}
, 
[6041202] = {id = 6041202, nameTextID = 300480, exDiscribeTextID = 302947}
, 
[6041203] = {id = 6041203, nameTextID = 300480, exDiscribeTextID = 302947}
, 
[6041204] = {id = 6041204, nameTextID = 300480, exDiscribeTextID = 302947}
, 
[6041205] = {id = 6041205, nameTextID = 300480, exDiscribeTextID = 302947}
, 
[6042101] = {id = 6042101, nameTextID = 300481, exDiscribeTextID = 300998}
, 
[6042102] = {id = 6042102, nameTextID = 300481, exDiscribeTextID = 300998}
, 
[6042103] = {id = 6042103, nameTextID = 300481, exDiscribeTextID = 300998}
, 
[6042104] = {id = 6042104, nameTextID = 300481, exDiscribeTextID = 300998}
, 
[6042105] = {id = 6042105, nameTextID = 300481, exDiscribeTextID = 300998}
, 
[6042201] = {id = 6042201, nameTextID = 300482, exDiscribeTextID = 301003}
, 
[6042202] = {id = 6042202, nameTextID = 300482, exDiscribeTextID = 301003}
, 
[6042203] = {id = 6042203, nameTextID = 300482, exDiscribeTextID = 301003}
, 
[6042204] = {id = 6042204, nameTextID = 300482, exDiscribeTextID = 301003}
, 
[6042205] = {id = 6042205, nameTextID = 300482, exDiscribeTextID = 301003}
, 
[6043101] = {id = 6043101, nameTextID = 300484, exDiscribeTextID = 303112}
, 
[6043102] = {id = 6043102, nameTextID = 300484, exDiscribeTextID = 303112}
, 
[6043103] = {id = 6043103, nameTextID = 300484, exDiscribeTextID = 303112}
, 
[6043104] = {id = 6043104, nameTextID = 300484, exDiscribeTextID = 303112}
, 
[6043105] = {id = 6043105, nameTextID = 300484, exDiscribeTextID = 303112}
, 
[6043201] = {id = 6043201, nameTextID = 300483, exDiscribeTextID = 303113}
, 
[6043202] = {id = 6043202, nameTextID = 300483, exDiscribeTextID = 303113}
, 
[6043203] = {id = 6043203, nameTextID = 300483, exDiscribeTextID = 303113}
, 
[6043204] = {id = 6043204, nameTextID = 300483, exDiscribeTextID = 303113}
, 
[6043205] = {id = 6043205, nameTextID = 300483, exDiscribeTextID = 303113}
, 
[6044101] = {id = 6044101, nameTextID = 300485, exDiscribeTextID = 301018}
, 
[6044102] = {id = 6044102, nameTextID = 300485, exDiscribeTextID = 301018}
, 
[6044103] = {id = 6044103, nameTextID = 300485, exDiscribeTextID = 301018}
, 
[6044104] = {id = 6044104, nameTextID = 300485, exDiscribeTextID = 301018}
, 
[6044105] = {id = 6044105, nameTextID = 300485, exDiscribeTextID = 301018}
, 
[6044201] = {id = 6044201, nameTextID = 300486, exDiscribeTextID = 301023}
, 
[6044202] = {id = 6044202, nameTextID = 300486, exDiscribeTextID = 301023}
, 
[6044203] = {id = 6044203, nameTextID = 300486, exDiscribeTextID = 301023}
, 
[6044204] = {id = 6044204, nameTextID = 300486, exDiscribeTextID = 301023}
, 
[6044205] = {id = 6044205, nameTextID = 300486, exDiscribeTextID = 301023}
, 
[6045101] = {id = 6045101, nameTextID = 300487, exDiscribeTextID = 301028}
, 
[6045102] = {id = 6045102, nameTextID = 300487, exDiscribeTextID = 301028}
, 
[6045103] = {id = 6045103, nameTextID = 300487, exDiscribeTextID = 301028}
, 
[6045104] = {id = 6045104, nameTextID = 300487, exDiscribeTextID = 301028}
, 
[6045105] = {id = 6045105, nameTextID = 300487, exDiscribeTextID = 301028}
, 
[6045201] = {id = 6045201, nameTextID = 300488, exDiscribeTextID = 301033}
, 
[6045202] = {id = 6045202, nameTextID = 300488, exDiscribeTextID = 301033}
, 
[6045203] = {id = 6045203, nameTextID = 300488, exDiscribeTextID = 301033}
, 
[6045204] = {id = 6045204, nameTextID = 300488, exDiscribeTextID = 301033}
, 
[6045205] = {id = 6045205, nameTextID = 300488, exDiscribeTextID = 301033}
, 
[6047101] = {id = 6047101, nameTextID = 300489, exDiscribeTextID = 303069}
, 
[6047102] = {id = 6047102, nameTextID = 300489, exDiscribeTextID = 303069}
, 
[6047103] = {id = 6047103, nameTextID = 300489, exDiscribeTextID = 303069}
, 
[6047104] = {id = 6047104, nameTextID = 300489, exDiscribeTextID = 303069}
, 
[6047105] = {id = 6047105, nameTextID = 300489, exDiscribeTextID = 303069}
, 
[6047201] = {id = 6047201, nameTextID = 303070, exDiscribeTextID = 303071}
, 
[6047202] = {id = 6047202, nameTextID = 303070, exDiscribeTextID = 303071}
, 
[6047203] = {id = 6047203, nameTextID = 303070, exDiscribeTextID = 303071}
, 
[6047204] = {id = 6047204, nameTextID = 303070, exDiscribeTextID = 303071}
, 
[6047205] = {id = 6047205, nameTextID = 303070, exDiscribeTextID = 303071}
, 
[6048101] = {id = 6048101, nameTextID = 303072, exDiscribeTextID = 303073}
, 
[6048102] = {id = 6048102, nameTextID = 303072, exDiscribeTextID = 303073}
, 
[6048103] = {id = 6048103, nameTextID = 303072, exDiscribeTextID = 303073}
, 
[6048104] = {id = 6048104, nameTextID = 303072, exDiscribeTextID = 303073}
, 
[6048105] = {id = 6048105, nameTextID = 303072, exDiscribeTextID = 303073}
, 
[6048201] = {id = 6048201, nameTextID = 300492, exDiscribeTextID = 303074}
, 
[6048202] = {id = 6048202, nameTextID = 300492, exDiscribeTextID = 303074}
, 
[6048203] = {id = 6048203, nameTextID = 300492, exDiscribeTextID = 303074}
, 
[6048204] = {id = 6048204, nameTextID = 300492, exDiscribeTextID = 303074}
, 
[6048205] = {id = 6048205, nameTextID = 300492, exDiscribeTextID = 303074}
, 
[6049101] = {id = 6049101, nameTextID = 300493, exDiscribeTextID = 302957}
, 
[6049102] = {id = 6049102, nameTextID = 300493, exDiscribeTextID = 302957}
, 
[6049103] = {id = 6049103, nameTextID = 300493, exDiscribeTextID = 302957}
, 
[6049104] = {id = 6049104, nameTextID = 300493, exDiscribeTextID = 302957}
, 
[6049105] = {id = 6049105, nameTextID = 300493, exDiscribeTextID = 302957}
, 
[6049201] = {id = 6049201, nameTextID = 300494, exDiscribeTextID = 302956}
, 
[6049202] = {id = 6049202, nameTextID = 300494, exDiscribeTextID = 302956}
, 
[6049203] = {id = 6049203, nameTextID = 300494, exDiscribeTextID = 302956}
, 
[6049204] = {id = 6049204, nameTextID = 300494, exDiscribeTextID = 302956}
, 
[6049205] = {id = 6049205, nameTextID = 300494, exDiscribeTextID = 302956}
, 
[6051101] = {id = 6051101, nameTextID = 303108, exDiscribeTextID = 303109}
, 
[6051102] = {id = 6051102, nameTextID = 303108, exDiscribeTextID = 303109}
, 
[6051103] = {id = 6051103, nameTextID = 303108, exDiscribeTextID = 303109}
, 
[6051104] = {id = 6051104, nameTextID = 303108, exDiscribeTextID = 303109}
, 
[6051105] = {id = 6051105, nameTextID = 303108, exDiscribeTextID = 303109}
, 
[6051201] = {id = 6051201, nameTextID = 303110, exDiscribeTextID = 303111}
, 
[6051202] = {id = 6051202, nameTextID = 303110, exDiscribeTextID = 303111}
, 
[6051203] = {id = 6051203, nameTextID = 303110, exDiscribeTextID = 303111}
, 
[6051204] = {id = 6051204, nameTextID = 303110, exDiscribeTextID = 303111}
, 
[6051205] = {id = 6051205, nameTextID = 303110, exDiscribeTextID = 303111}
, 
[6052101] = {id = 6052101, nameTextID = 300498, exDiscribeTextID = 301083}
, 
[6052102] = {id = 6052102, nameTextID = 300498, exDiscribeTextID = 301083}
, 
[6052103] = {id = 6052103, nameTextID = 300498, exDiscribeTextID = 301083}
, 
[6052104] = {id = 6052104, nameTextID = 300498, exDiscribeTextID = 301083}
, 
[6052105] = {id = 6052105, nameTextID = 300498, exDiscribeTextID = 301083}
, 
[6052201] = {id = 6052201, nameTextID = 303075, exDiscribeTextID = 303076}
, 
[6052202] = {id = 6052202, nameTextID = 303075, exDiscribeTextID = 303076}
, 
[6052203] = {id = 6052203, nameTextID = 303075, exDiscribeTextID = 303076}
, 
[6052204] = {id = 6052204, nameTextID = 303075, exDiscribeTextID = 303076}
, 
[6052205] = {id = 6052205, nameTextID = 303075, exDiscribeTextID = 303076}
, 
[6053101] = {id = 6053101, nameTextID = 300499, exDiscribeTextID = 303287}
, 
[6053102] = {id = 6053102, nameTextID = 300499, exDiscribeTextID = 303287}
, 
[6053103] = {id = 6053103, nameTextID = 300499, exDiscribeTextID = 303287}
, 
[6053104] = {id = 6053104, nameTextID = 300499, exDiscribeTextID = 303287}
, 
[6053105] = {id = 6053105, nameTextID = 300499, exDiscribeTextID = 303287}
, 
[6053201] = {id = 6053201, nameTextID = 300500, exDiscribeTextID = 303288}
, 
[6053202] = {id = 6053202, nameTextID = 300500, exDiscribeTextID = 303288}
, 
[6053203] = {id = 6053203, nameTextID = 300500, exDiscribeTextID = 303288}
, 
[6053204] = {id = 6053204, nameTextID = 300500, exDiscribeTextID = 303288}
, 
[6053205] = {id = 6053205, nameTextID = 300500, exDiscribeTextID = 303288}
, 
[6054101] = {id = 6054101, nameTextID = 300501, exDiscribeTextID = 301968}
, 
[6054102] = {id = 6054102, nameTextID = 300501, exDiscribeTextID = 301968}
, 
[6054103] = {id = 6054103, nameTextID = 300501, exDiscribeTextID = 301968}
, 
[6054104] = {id = 6054104, nameTextID = 300501, exDiscribeTextID = 301968}
, 
[6054105] = {id = 6054105, nameTextID = 300501, exDiscribeTextID = 301968}
, 
[6054201] = {id = 6054201, nameTextID = 300502, exDiscribeTextID = 301099}
, 
[6054202] = {id = 6054202, nameTextID = 300502, exDiscribeTextID = 301099}
, 
[6054203] = {id = 6054203, nameTextID = 300502, exDiscribeTextID = 301099}
, 
[6054204] = {id = 6054204, nameTextID = 300502, exDiscribeTextID = 301099}
, 
[6054205] = {id = 6054205, nameTextID = 300502, exDiscribeTextID = 301099}
, 
[6055101] = {id = 6055101, nameTextID = 303077, exDiscribeTextID = 303078}
, 
[6055102] = {id = 6055102, nameTextID = 303077, exDiscribeTextID = 303078}
, 
[6055103] = {id = 6055103, nameTextID = 303077, exDiscribeTextID = 303078}
, 
[6055104] = {id = 6055104, nameTextID = 303077, exDiscribeTextID = 303078}
, 
[6055105] = {id = 6055105, nameTextID = 303077, exDiscribeTextID = 303078}
, 
[6055201] = {id = 6055201, nameTextID = 303079, exDiscribeTextID = 303080}
, 
[6055202] = {id = 6055202, nameTextID = 303079, exDiscribeTextID = 303080}
, 
[6055203] = {id = 6055203, nameTextID = 303079, exDiscribeTextID = 303080}
, 
[6055204] = {id = 6055204, nameTextID = 303079, exDiscribeTextID = 303080}
, 
[6055205] = {id = 6055205, nameTextID = 303079, exDiscribeTextID = 303080}
, 
[6056101] = {id = 6056101, nameTextID = 303016, exDiscribeTextID = 302993}
, 
[6056102] = {id = 6056102, nameTextID = 303016, exDiscribeTextID = 302993}
, 
[6056103] = {id = 6056103, nameTextID = 303016, exDiscribeTextID = 302993}
, 
[6056104] = {id = 6056104, nameTextID = 303016, exDiscribeTextID = 302993}
, 
[6056105] = {id = 6056105, nameTextID = 303016, exDiscribeTextID = 302993}
, 
[6056201] = {id = 6056201, nameTextID = 303015, exDiscribeTextID = 302998}
, 
[6056202] = {id = 6056202, nameTextID = 303015, exDiscribeTextID = 302998}
, 
[6056203] = {id = 6056203, nameTextID = 303015, exDiscribeTextID = 302998}
, 
[6056204] = {id = 6056204, nameTextID = 303015, exDiscribeTextID = 302998}
, 
[6056205] = {id = 6056205, nameTextID = 303015, exDiscribeTextID = 302998}
, 
[6057101] = {id = 6057101, nameTextID = 303087, exDiscribeTextID = 303088}
, 
[6057102] = {id = 6057102, nameTextID = 303087, exDiscribeTextID = 303088}
, 
[6057103] = {id = 6057103, nameTextID = 303087, exDiscribeTextID = 303088}
, 
[6057104] = {id = 6057104, nameTextID = 303087, exDiscribeTextID = 303088}
, 
[6057105] = {id = 6057105, nameTextID = 303087, exDiscribeTextID = 303088}
, 
[6057201] = {id = 6057201, nameTextID = 303089, exDiscribeTextID = 303090}
, 
[6057202] = {id = 6057202, nameTextID = 303089, exDiscribeTextID = 303090}
, 
[6057203] = {id = 6057203, nameTextID = 303089, exDiscribeTextID = 303090}
, 
[6057204] = {id = 6057204, nameTextID = 303089, exDiscribeTextID = 303090}
, 
[6057205] = {id = 6057205, nameTextID = 303089, exDiscribeTextID = 303090}
, 
[6059101] = {id = 6059101, nameTextID = 300505, exDiscribeTextID = 302954}
, 
[6059102] = {id = 6059102, nameTextID = 300505, exDiscribeTextID = 302954}
, 
[6059103] = {id = 6059103, nameTextID = 300505, exDiscribeTextID = 302954}
, 
[6059104] = {id = 6059104, nameTextID = 300505, exDiscribeTextID = 302954}
, 
[6059105] = {id = 6059105, nameTextID = 300505, exDiscribeTextID = 302954}
, 
[6059201] = {id = 6059201, nameTextID = 300506, exDiscribeTextID = 302955}
, 
[6059202] = {id = 6059202, nameTextID = 300506, exDiscribeTextID = 302955}
, 
[6059203] = {id = 6059203, nameTextID = 300506, exDiscribeTextID = 302955}
, 
[6059204] = {id = 6059204, nameTextID = 300506, exDiscribeTextID = 302955}
, 
[6059205] = {id = 6059205, nameTextID = 300506, exDiscribeTextID = 302955}
, 
[6060101] = {id = 6060101, nameTextID = 300507, exDiscribeTextID = 301108}
, 
[6060102] = {id = 6060102, nameTextID = 300507, exDiscribeTextID = 301108}
, 
[6060103] = {id = 6060103, nameTextID = 300507, exDiscribeTextID = 301108}
, 
[6060104] = {id = 6060104, nameTextID = 300507, exDiscribeTextID = 301108}
, 
[6060105] = {id = 6060105, nameTextID = 300507, exDiscribeTextID = 301108}
, 
[6060201] = {id = 6060201, nameTextID = 300508, exDiscribeTextID = 301109}
, 
[6060202] = {id = 6060202, nameTextID = 300508, exDiscribeTextID = 301109}
, 
[6060203] = {id = 6060203, nameTextID = 300508, exDiscribeTextID = 301109}
, 
[6060204] = {id = 6060204, nameTextID = 300508, exDiscribeTextID = 301109}
, 
[6060205] = {id = 6060205, nameTextID = 300508, exDiscribeTextID = 301109}
, 
[6061101] = {id = 6061101, nameTextID = 302250, exDiscribeTextID = 302252}
, 
[6061102] = {id = 6061102, nameTextID = 302250, exDiscribeTextID = 302252}
, 
[6061103] = {id = 6061103, nameTextID = 302250, exDiscribeTextID = 302252}
, 
[6061104] = {id = 6061104, nameTextID = 302250, exDiscribeTextID = 302252}
, 
[6061105] = {id = 6061105, nameTextID = 302250, exDiscribeTextID = 302252}
, 
[6061201] = {id = 6061201, nameTextID = 302251, exDiscribeTextID = 303091}
, 
[6061202] = {id = 6061202, nameTextID = 302251, exDiscribeTextID = 303091}
, 
[6061203] = {id = 6061203, nameTextID = 302251, exDiscribeTextID = 303091}
, 
[6061204] = {id = 6061204, nameTextID = 302251, exDiscribeTextID = 303091}
, 
[6061205] = {id = 6061205, nameTextID = 302251, exDiscribeTextID = 303091}
, 
[6063101] = {id = 6063101, nameTextID = 302909, exDiscribeTextID = 302911}
, 
[6063102] = {id = 6063102, nameTextID = 302909, exDiscribeTextID = 302911}
, 
[6063103] = {id = 6063103, nameTextID = 302909, exDiscribeTextID = 302911}
, 
[6063104] = {id = 6063104, nameTextID = 302909, exDiscribeTextID = 302911}
, 
[6063105] = {id = 6063105, nameTextID = 302909, exDiscribeTextID = 302911}
, 
[6063201] = {id = 6063201, nameTextID = 302910, exDiscribeTextID = 302912}
, 
[6063202] = {id = 6063202, nameTextID = 302910, exDiscribeTextID = 302912}
, 
[6063203] = {id = 6063203, nameTextID = 302910, exDiscribeTextID = 302912}
, 
[6063204] = {id = 6063204, nameTextID = 302910, exDiscribeTextID = 302912}
, 
[6063205] = {id = 6063205, nameTextID = 302910, exDiscribeTextID = 302912}
, 
[6064101] = {id = 6064101, nameTextID = 302328, exDiscribeTextID = 302330}
, 
[6064102] = {id = 6064102, nameTextID = 302328, exDiscribeTextID = 302330}
, 
[6064103] = {id = 6064103, nameTextID = 302328, exDiscribeTextID = 302330}
, 
[6064104] = {id = 6064104, nameTextID = 302328, exDiscribeTextID = 302330}
, 
[6064105] = {id = 6064105, nameTextID = 302328, exDiscribeTextID = 302330}
, 
[6064201] = {id = 6064201, nameTextID = 302329, exDiscribeTextID = 302334}
, 
[6064202] = {id = 6064202, nameTextID = 302329, exDiscribeTextID = 302334}
, 
[6064203] = {id = 6064203, nameTextID = 302329, exDiscribeTextID = 302334}
, 
[6064204] = {id = 6064204, nameTextID = 302329, exDiscribeTextID = 302334}
, 
[6064205] = {id = 6064205, nameTextID = 302329, exDiscribeTextID = 302334}
, 
[6065101] = {id = 6065101, nameTextID = 300509, exDiscribeTextID = 303013}
, 
[6065102] = {id = 6065102, nameTextID = 300509, exDiscribeTextID = 303013}
, 
[6065103] = {id = 6065103, nameTextID = 300509, exDiscribeTextID = 303013}
, 
[6065104] = {id = 6065104, nameTextID = 300509, exDiscribeTextID = 303013}
, 
[6065105] = {id = 6065105, nameTextID = 300509, exDiscribeTextID = 303013}
, 
[6065201] = {id = 6065201, nameTextID = 300510, exDiscribeTextID = 303014}
, 
[6065202] = {id = 6065202, nameTextID = 300510, exDiscribeTextID = 303014}
, 
[6065203] = {id = 6065203, nameTextID = 300510, exDiscribeTextID = 303014}
, 
[6065204] = {id = 6065204, nameTextID = 300510, exDiscribeTextID = 303014}
, 
[6065205] = {id = 6065205, nameTextID = 300510, exDiscribeTextID = 303014}
, 
[6066101] = {id = 6066101, nameTextID = 303441, exDiscribeTextID = 303442}
, 
[6066102] = {id = 6066102, nameTextID = 303441, exDiscribeTextID = 303442}
, 
[6066103] = {id = 6066103, nameTextID = 303441, exDiscribeTextID = 303442}
, 
[6066104] = {id = 6066104, nameTextID = 303441, exDiscribeTextID = 303442}
, 
[6066105] = {id = 6066105, nameTextID = 303441, exDiscribeTextID = 303442}
, 
[6066201] = {id = 6066201, nameTextID = 303443, exDiscribeTextID = 303444}
, 
[6066202] = {id = 6066202, nameTextID = 303443, exDiscribeTextID = 303444}
, 
[6066203] = {id = 6066203, nameTextID = 303443, exDiscribeTextID = 303444}
, 
[6066204] = {id = 6066204, nameTextID = 303443, exDiscribeTextID = 303444}
, 
[6066205] = {id = 6066205, nameTextID = 303443, exDiscribeTextID = 303444}
, 
[6067101] = {id = 6067101, nameTextID = 303435, exDiscribeTextID = 303436}
, 
[6067102] = {id = 6067102, nameTextID = 303435, exDiscribeTextID = 303436}
, 
[6067103] = {id = 6067103, nameTextID = 303435, exDiscribeTextID = 303436}
, 
[6067104] = {id = 6067104, nameTextID = 303435, exDiscribeTextID = 303436}
, 
[6067105] = {id = 6067105, nameTextID = 303435, exDiscribeTextID = 303436}
, 
[6067201] = {id = 6067201, nameTextID = 303437, exDiscribeTextID = 303438}
, 
[6067202] = {id = 6067202, nameTextID = 303437, exDiscribeTextID = 303438}
, 
[6067203] = {id = 6067203, nameTextID = 303437, exDiscribeTextID = 303438}
, 
[6067204] = {id = 6067204, nameTextID = 303437, exDiscribeTextID = 303438}
, 
[6067205] = {id = 6067205, nameTextID = 303437, exDiscribeTextID = 303438}
, 
[6068101] = {id = 6068101, nameTextID = 302727, exDiscribeTextID = 302729}
, 
[6068102] = {id = 6068102, nameTextID = 302727, exDiscribeTextID = 302729}
, 
[6068103] = {id = 6068103, nameTextID = 302727, exDiscribeTextID = 302729}
, 
[6068104] = {id = 6068104, nameTextID = 302727, exDiscribeTextID = 302729}
, 
[6068105] = {id = 6068105, nameTextID = 302727, exDiscribeTextID = 302729}
, 
[6068201] = {id = 6068201, nameTextID = 302728, exDiscribeTextID = 302730}
, 
[6068202] = {id = 6068202, nameTextID = 302728, exDiscribeTextID = 302730}
, 
[6068203] = {id = 6068203, nameTextID = 302728, exDiscribeTextID = 302730}
, 
[6068204] = {id = 6068204, nameTextID = 302728, exDiscribeTextID = 302730}
, 
[6068205] = {id = 6068205, nameTextID = 302728, exDiscribeTextID = 302730}
, 
[6069101] = {id = 6069101, nameTextID = 300511, exDiscribeTextID = 303008}
, 
[6069102] = {id = 6069102, nameTextID = 300511, exDiscribeTextID = 303008}
, 
[6069103] = {id = 6069103, nameTextID = 300511, exDiscribeTextID = 303008}
, 
[6069104] = {id = 6069104, nameTextID = 300511, exDiscribeTextID = 303008}
, 
[6069105] = {id = 6069105, nameTextID = 300511, exDiscribeTextID = 303008}
, 
[6069201] = {id = 6069201, nameTextID = 300512, exDiscribeTextID = 303003}
, 
[6069202] = {id = 6069202, nameTextID = 300512, exDiscribeTextID = 303003}
, 
[6069203] = {id = 6069203, nameTextID = 300512, exDiscribeTextID = 303003}
, 
[6069204] = {id = 6069204, nameTextID = 300512, exDiscribeTextID = 303003}
, 
[6069205] = {id = 6069205, nameTextID = 300512, exDiscribeTextID = 303003}
, 
[6070101] = {id = 6070101, nameTextID = 302345, exDiscribeTextID = 302347}
, 
[6070102] = {id = 6070102, nameTextID = 302345, exDiscribeTextID = 302347}
, 
[6070103] = {id = 6070103, nameTextID = 302345, exDiscribeTextID = 302347}
, 
[6070104] = {id = 6070104, nameTextID = 302345, exDiscribeTextID = 302347}
, 
[6070105] = {id = 6070105, nameTextID = 302345, exDiscribeTextID = 302347}
, 
[6070201] = {id = 6070201, nameTextID = 303018, exDiscribeTextID = 302352}
, 
[6070202] = {id = 6070202, nameTextID = 303018, exDiscribeTextID = 302352}
, 
[6070203] = {id = 6070203, nameTextID = 303018, exDiscribeTextID = 302352}
, 
[6070204] = {id = 6070204, nameTextID = 303018, exDiscribeTextID = 302352}
, 
[6070205] = {id = 6070205, nameTextID = 303018, exDiscribeTextID = 302352}
, 
[6070401] = {id = 6070401, nameTextID = 303018, exDiscribeTextID = 303159}
, 
[6070402] = {id = 6070402, nameTextID = 303018, exDiscribeTextID = 303159}
, 
[6070403] = {id = 6070403, nameTextID = 303018, exDiscribeTextID = 303159}
, 
[6070404] = {id = 6070404, nameTextID = 303018, exDiscribeTextID = 303159}
, 
[6070405] = {id = 6070405, nameTextID = 303018, exDiscribeTextID = 303159}
, 
[6071101] = {id = 6071101, nameTextID = 303262, exDiscribeTextID = 303263}
, 
[6071102] = {id = 6071102, nameTextID = 303262, exDiscribeTextID = 303263}
, 
[6071103] = {id = 6071103, nameTextID = 303262, exDiscribeTextID = 303263}
, 
[6071104] = {id = 6071104, nameTextID = 303262, exDiscribeTextID = 303263}
, 
[6071105] = {id = 6071105, nameTextID = 303262, exDiscribeTextID = 303263}
, 
[6071201] = {id = 6071201, nameTextID = 303264, exDiscribeTextID = 303265}
, 
[6071202] = {id = 6071202, nameTextID = 303264, exDiscribeTextID = 303265}
, 
[6071203] = {id = 6071203, nameTextID = 303264, exDiscribeTextID = 303265}
, 
[6071204] = {id = 6071204, nameTextID = 303264, exDiscribeTextID = 303265}
, 
[6071205] = {id = 6071205, nameTextID = 303264, exDiscribeTextID = 303265}
, 
[6072101] = {id = 6072101, nameTextID = 303229, exDiscribeTextID = 303230}
, 
[6072102] = {id = 6072102, nameTextID = 303229, exDiscribeTextID = 303230}
, 
[6072103] = {id = 6072103, nameTextID = 303229, exDiscribeTextID = 303230}
, 
[6072104] = {id = 6072104, nameTextID = 303229, exDiscribeTextID = 303230}
, 
[6072105] = {id = 6072105, nameTextID = 303229, exDiscribeTextID = 303230}
, 
[6072201] = {id = 6072201, nameTextID = 303231, exDiscribeTextID = 303232}
, 
[6072202] = {id = 6072202, nameTextID = 303231, exDiscribeTextID = 303232}
, 
[6072203] = {id = 6072203, nameTextID = 303231, exDiscribeTextID = 303232}
, 
[6072204] = {id = 6072204, nameTextID = 303231, exDiscribeTextID = 303232}
, 
[6072205] = {id = 6072205, nameTextID = 303231, exDiscribeTextID = 303232}
, 
[6073101] = {id = 6073101, nameTextID = 302309, exDiscribeTextID = 303092}
, 
[6073102] = {id = 6073102, nameTextID = 302309, exDiscribeTextID = 303092}
, 
[6073103] = {id = 6073103, nameTextID = 302309, exDiscribeTextID = 303092}
, 
[6073104] = {id = 6073104, nameTextID = 302309, exDiscribeTextID = 303092}
, 
[6073105] = {id = 6073105, nameTextID = 302309, exDiscribeTextID = 303092}
, 
[6073201] = {id = 6073201, nameTextID = 302310, exDiscribeTextID = 303093}
, 
[6073202] = {id = 6073202, nameTextID = 302310, exDiscribeTextID = 303093}
, 
[6073203] = {id = 6073203, nameTextID = 302310, exDiscribeTextID = 303093}
, 
[6073204] = {id = 6073204, nameTextID = 302310, exDiscribeTextID = 303093}
, 
[6073205] = {id = 6073205, nameTextID = 302310, exDiscribeTextID = 303093}
, 
[6074101] = {id = 6074101, nameTextID = 303096, exDiscribeTextID = 303097}
, 
[6074102] = {id = 6074102, nameTextID = 303096, exDiscribeTextID = 303097}
, 
[6074103] = {id = 6074103, nameTextID = 303096, exDiscribeTextID = 303097}
, 
[6074104] = {id = 6074104, nameTextID = 303096, exDiscribeTextID = 303097}
, 
[6074105] = {id = 6074105, nameTextID = 303096, exDiscribeTextID = 303097}
, 
[6074201] = {id = 6074201, nameTextID = 303098, exDiscribeTextID = 303099}
, 
[6074202] = {id = 6074202, nameTextID = 303098, exDiscribeTextID = 303099}
, 
[6074203] = {id = 6074203, nameTextID = 303098, exDiscribeTextID = 303099}
, 
[6074204] = {id = 6074204, nameTextID = 303098, exDiscribeTextID = 303099}
, 
[6074205] = {id = 6074205, nameTextID = 303098, exDiscribeTextID = 303099}
, 
[6075101] = {id = 6075101, nameTextID = 303100, exDiscribeTextID = 303101}
, 
[6075102] = {id = 6075102, nameTextID = 303100, exDiscribeTextID = 303101}
, 
[6075103] = {id = 6075103, nameTextID = 303100, exDiscribeTextID = 303101}
, 
[6075104] = {id = 6075104, nameTextID = 303100, exDiscribeTextID = 303101}
, 
[6075105] = {id = 6075105, nameTextID = 303100, exDiscribeTextID = 303101}
, 
[6075201] = {id = 6075201, nameTextID = 303102, exDiscribeTextID = 303103}
, 
[6075202] = {id = 6075202, nameTextID = 303102, exDiscribeTextID = 303103}
, 
[6075203] = {id = 6075203, nameTextID = 303102, exDiscribeTextID = 303103}
, 
[6075204] = {id = 6075204, nameTextID = 303102, exDiscribeTextID = 303103}
, 
[6075205] = {id = 6075205, nameTextID = 303102, exDiscribeTextID = 303103}
, 
[6076101] = {id = 6076101, nameTextID = 302179, exDiscribeTextID = 302199}
, 
[6076102] = {id = 6076102, nameTextID = 302180, exDiscribeTextID = 302199}
, 
[6076103] = {id = 6076103, nameTextID = 302181, exDiscribeTextID = 302199}
, 
[6076104] = {id = 6076104, nameTextID = 302182, exDiscribeTextID = 302199}
, 
[6076105] = {id = 6076105, nameTextID = 302183, exDiscribeTextID = 302199}
, 
[6076201] = {id = 6076201, nameTextID = 302933, exDiscribeTextID = 302934}
, 
[6076202] = {id = 6076202, nameTextID = 302933, exDiscribeTextID = 302934}
, 
[6076203] = {id = 6076203, nameTextID = 302933, exDiscribeTextID = 302934}
, 
[6076204] = {id = 6076204, nameTextID = 302933, exDiscribeTextID = 302934}
, 
[6076205] = {id = 6076205, nameTextID = 302933, exDiscribeTextID = 302934}
, 
[6078101] = {id = 6078101, nameTextID = 303272, exDiscribeTextID = 303273}
, 
[6078102] = {id = 6078102, nameTextID = 303272, exDiscribeTextID = 303273}
, 
[6078103] = {id = 6078103, nameTextID = 303272, exDiscribeTextID = 303273}
, 
[6078104] = {id = 6078104, nameTextID = 303272, exDiscribeTextID = 303273}
, 
[6078105] = {id = 6078105, nameTextID = 303272, exDiscribeTextID = 303273}
, 
[6078201] = {id = 6078201, nameTextID = 303274, exDiscribeTextID = 303275}
, 
[6078202] = {id = 6078202, nameTextID = 303274, exDiscribeTextID = 303275}
, 
[6078203] = {id = 6078203, nameTextID = 303274, exDiscribeTextID = 303275}
, 
[6078204] = {id = 6078204, nameTextID = 303274, exDiscribeTextID = 303275}
, 
[6078205] = {id = 6078205, nameTextID = 303274, exDiscribeTextID = 303275}
, 
[6079101] = {id = 6079101, nameTextID = 303279, exDiscribeTextID = 303280}
, 
[6079102] = {id = 6079102, nameTextID = 303279, exDiscribeTextID = 303280}
, 
[6079103] = {id = 6079103, nameTextID = 303279, exDiscribeTextID = 303280}
, 
[6079104] = {id = 6079104, nameTextID = 303279, exDiscribeTextID = 303280}
, 
[6079105] = {id = 6079105, nameTextID = 303279, exDiscribeTextID = 303280}
, 
[6079201] = {id = 6079201, nameTextID = 303281, exDiscribeTextID = 303282}
, 
[6079202] = {id = 6079202, nameTextID = 303281, exDiscribeTextID = 303282}
, 
[6079203] = {id = 6079203, nameTextID = 303281, exDiscribeTextID = 303282}
, 
[6079204] = {id = 6079204, nameTextID = 303281, exDiscribeTextID = 303282}
, 
[6079205] = {id = 6079205, nameTextID = 303281, exDiscribeTextID = 303282}
, 
[6080101] = {id = 6080101, nameTextID = 303396, exDiscribeTextID = 303397}
, 
[6080102] = {id = 6080102, nameTextID = 303396, exDiscribeTextID = 303397}
, 
[6080103] = {id = 6080103, nameTextID = 303396, exDiscribeTextID = 303397}
, 
[6080104] = {id = 6080104, nameTextID = 303396, exDiscribeTextID = 303397}
, 
[6080105] = {id = 6080105, nameTextID = 303396, exDiscribeTextID = 303397}
, 
[6080201] = {id = 6080201, nameTextID = 303398, exDiscribeTextID = 303399}
, 
[6080202] = {id = 6080202, nameTextID = 303398, exDiscribeTextID = 303399}
, 
[6080203] = {id = 6080203, nameTextID = 303398, exDiscribeTextID = 303399}
, 
[6080204] = {id = 6080204, nameTextID = 303398, exDiscribeTextID = 303399}
, 
[6080205] = {id = 6080205, nameTextID = 303398, exDiscribeTextID = 303399}
, 
[6081101] = {id = 6081101, nameTextID = 303244, exDiscribeTextID = 303245}
, 
[6081102] = {id = 6081102, nameTextID = 303244, exDiscribeTextID = 303245}
, 
[6081103] = {id = 6081103, nameTextID = 303244, exDiscribeTextID = 303245}
, 
[6081104] = {id = 6081104, nameTextID = 303244, exDiscribeTextID = 303245}
, 
[6081105] = {id = 6081105, nameTextID = 303244, exDiscribeTextID = 303245}
, 
[6081201] = {id = 6081201, nameTextID = 303246, exDiscribeTextID = 303247}
, 
[6081202] = {id = 6081202, nameTextID = 303246, exDiscribeTextID = 303247}
, 
[6081203] = {id = 6081203, nameTextID = 303246, exDiscribeTextID = 303247}
, 
[6081204] = {id = 6081204, nameTextID = 303246, exDiscribeTextID = 303247}
, 
[6081205] = {id = 6081205, nameTextID = 303246, exDiscribeTextID = 303247}
, 
[6082101] = {id = 6082101, nameTextID = 303808, exDiscribeTextID = 303809}
, 
[6082102] = {id = 6082102, nameTextID = 303808, exDiscribeTextID = 303809}
, 
[6082103] = {id = 6082103, nameTextID = 303808, exDiscribeTextID = 303809}
, 
[6082104] = {id = 6082104, nameTextID = 303808, exDiscribeTextID = 303809}
, 
[6082105] = {id = 6082105, nameTextID = 303808, exDiscribeTextID = 303809}
, 
[6082201] = {id = 6082201, nameTextID = 303810, exDiscribeTextID = 303811}
, 
[6082202] = {id = 6082202, nameTextID = 303810, exDiscribeTextID = 303811}
, 
[6082203] = {id = 6082203, nameTextID = 303810, exDiscribeTextID = 303811}
, 
[6082204] = {id = 6082204, nameTextID = 303810, exDiscribeTextID = 303811}
, 
[6082205] = {id = 6082205, nameTextID = 303810, exDiscribeTextID = 303811}
, 
[6083101] = {id = 6083101, nameTextID = 303346, exDiscribeTextID = 303347}
, 
[6083102] = {id = 6083102, nameTextID = 303346, exDiscribeTextID = 303347}
, 
[6083103] = {id = 6083103, nameTextID = 303346, exDiscribeTextID = 303347}
, 
[6083104] = {id = 6083104, nameTextID = 303346, exDiscribeTextID = 303347}
, 
[6083105] = {id = 6083105, nameTextID = 303346, exDiscribeTextID = 303347}
, 
[6083201] = {id = 6083201, nameTextID = 303348, exDiscribeTextID = 303349}
, 
[6083202] = {id = 6083202, nameTextID = 303348, exDiscribeTextID = 303349}
, 
[6083203] = {id = 6083203, nameTextID = 303348, exDiscribeTextID = 303349}
, 
[6083204] = {id = 6083204, nameTextID = 303348, exDiscribeTextID = 303349}
, 
[6083205] = {id = 6083205, nameTextID = 303348, exDiscribeTextID = 303349}
, 
[6084101] = {id = 6084101, nameTextID = 303552, exDiscribeTextID = 303553}
, 
[6084102] = {id = 6084102, nameTextID = 303552, exDiscribeTextID = 303553}
, 
[6084103] = {id = 6084103, nameTextID = 303552, exDiscribeTextID = 303553}
, 
[6084104] = {id = 6084104, nameTextID = 303552, exDiscribeTextID = 303553}
, 
[6084105] = {id = 6084105, nameTextID = 303552, exDiscribeTextID = 303553}
, 
[6084201] = {id = 6084201, nameTextID = 303554, exDiscribeTextID = 303555}
, 
[6084202] = {id = 6084202, nameTextID = 303554, exDiscribeTextID = 303555}
, 
[6084203] = {id = 6084203, nameTextID = 303554, exDiscribeTextID = 303555}
, 
[6084204] = {id = 6084204, nameTextID = 303554, exDiscribeTextID = 303555}
, 
[6084205] = {id = 6084205, nameTextID = 303554, exDiscribeTextID = 303555}
, 
[6085101] = {id = 6085101, nameTextID = 303545, exDiscribeTextID = 303546}
, 
[6085102] = {id = 6085102, nameTextID = 303545, exDiscribeTextID = 303546}
, 
[6085103] = {id = 6085103, nameTextID = 303545, exDiscribeTextID = 303546}
, 
[6085104] = {id = 6085104, nameTextID = 303545, exDiscribeTextID = 303546}
, 
[6085105] = {id = 6085105, nameTextID = 303545, exDiscribeTextID = 303546}
, 
[6085201] = {id = 6085201, nameTextID = 303547, exDiscribeTextID = 303548}
, 
[6085202] = {id = 6085202, nameTextID = 303547, exDiscribeTextID = 303548}
, 
[6085203] = {id = 6085203, nameTextID = 303547, exDiscribeTextID = 303548}
, 
[6085204] = {id = 6085204, nameTextID = 303547, exDiscribeTextID = 303548}
, 
[6085205] = {id = 6085205, nameTextID = 303547, exDiscribeTextID = 303548}
, 
[6086101] = {id = 6086101, nameTextID = 303448, exDiscribeTextID = 303449}
, 
[6086102] = {id = 6086102, nameTextID = 303448, exDiscribeTextID = 303449}
, 
[6086103] = {id = 6086103, nameTextID = 303448, exDiscribeTextID = 303449}
, 
[6086104] = {id = 6086104, nameTextID = 303448, exDiscribeTextID = 303449}
, 
[6086105] = {id = 6086105, nameTextID = 303448, exDiscribeTextID = 303449}
, 
[6086201] = {id = 6086201, nameTextID = 303450, exDiscribeTextID = 303451}
, 
[6086202] = {id = 6086202, nameTextID = 303450, exDiscribeTextID = 303451}
, 
[6086203] = {id = 6086203, nameTextID = 303450, exDiscribeTextID = 303451}
, 
[6086204] = {id = 6086204, nameTextID = 303450, exDiscribeTextID = 303451}
, 
[6086205] = {id = 6086205, nameTextID = 303450, exDiscribeTextID = 303451}
, 
[6088101] = {id = 6088101, nameTextID = 303673, exDiscribeTextID = 303674}
, 
[6088102] = {id = 6088102, nameTextID = 303673, exDiscribeTextID = 303674}
, 
[6088103] = {id = 6088103, nameTextID = 303673, exDiscribeTextID = 303674}
, 
[6088104] = {id = 6088104, nameTextID = 303673, exDiscribeTextID = 303674}
, 
[6088105] = {id = 6088105, nameTextID = 303673, exDiscribeTextID = 303674}
, 
[6088201] = {id = 6088201, nameTextID = 303675, exDiscribeTextID = 303676}
, 
[6088202] = {id = 6088202, nameTextID = 303675, exDiscribeTextID = 303676}
, 
[6088203] = {id = 6088203, nameTextID = 303675, exDiscribeTextID = 303676}
, 
[6088204] = {id = 6088204, nameTextID = 303675, exDiscribeTextID = 303676}
, 
[6088205] = {id = 6088205, nameTextID = 303675, exDiscribeTextID = 303676}
, 
[6089101] = {id = 6089101, nameTextID = 303334, exDiscribeTextID = 303335}
, 
[6089102] = {id = 6089102, nameTextID = 303334, exDiscribeTextID = 303335}
, 
[6089103] = {id = 6089103, nameTextID = 303334, exDiscribeTextID = 303335}
, 
[6089104] = {id = 6089104, nameTextID = 303334, exDiscribeTextID = 303335}
, 
[6089105] = {id = 6089105, nameTextID = 303334, exDiscribeTextID = 303335}
, 
[6089201] = {id = 6089201, nameTextID = 303336, exDiscribeTextID = 303337}
, 
[6089202] = {id = 6089202, nameTextID = 303336, exDiscribeTextID = 303337}
, 
[6089203] = {id = 6089203, nameTextID = 303336, exDiscribeTextID = 303337}
, 
[6089204] = {id = 6089204, nameTextID = 303336, exDiscribeTextID = 303337}
, 
[6089205] = {id = 6089205, nameTextID = 303336, exDiscribeTextID = 303337}
, 
[6090101] = {id = 6090101, nameTextID = 303338, exDiscribeTextID = 303339}
, 
[6090102] = {id = 6090102, nameTextID = 303338, exDiscribeTextID = 303339}
, 
[6090103] = {id = 6090103, nameTextID = 303338, exDiscribeTextID = 303339}
, 
[6090104] = {id = 6090104, nameTextID = 303338, exDiscribeTextID = 303339}
, 
[6090105] = {id = 6090105, nameTextID = 303338, exDiscribeTextID = 303339}
, 
[6090201] = {id = 6090201, nameTextID = 303340, exDiscribeTextID = 303341}
, 
[6090202] = {id = 6090202, nameTextID = 303340, exDiscribeTextID = 303341}
, 
[6090203] = {id = 6090203, nameTextID = 303340, exDiscribeTextID = 303341}
, 
[6090204] = {id = 6090204, nameTextID = 303340, exDiscribeTextID = 303341}
, 
[6090205] = {id = 6090205, nameTextID = 303340, exDiscribeTextID = 303341}
, 
[6091101] = {id = 6091101, nameTextID = 303471, exDiscribeTextID = 303472}
, 
[6091102] = {id = 6091102, nameTextID = 303471, exDiscribeTextID = 303472}
, 
[6091103] = {id = 6091103, nameTextID = 303471, exDiscribeTextID = 303472}
, 
[6091104] = {id = 6091104, nameTextID = 303471, exDiscribeTextID = 303472}
, 
[6091105] = {id = 6091105, nameTextID = 303471, exDiscribeTextID = 303472}
, 
[6091201] = {id = 6091201, nameTextID = 303473, exDiscribeTextID = 303474}
, 
[6091202] = {id = 6091202, nameTextID = 303473, exDiscribeTextID = 303474}
, 
[6091203] = {id = 6091203, nameTextID = 303473, exDiscribeTextID = 303474}
, 
[6091204] = {id = 6091204, nameTextID = 303473, exDiscribeTextID = 303474}
, 
[6091205] = {id = 6091205, nameTextID = 303473, exDiscribeTextID = 303474}
, 
[6092101] = {id = 6092101, nameTextID = 303478, exDiscribeTextID = 303479}
, 
[6092102] = {id = 6092102, nameTextID = 303478, exDiscribeTextID = 303479}
, 
[6092103] = {id = 6092103, nameTextID = 303478, exDiscribeTextID = 303479}
, 
[6092104] = {id = 6092104, nameTextID = 303478, exDiscribeTextID = 303479}
, 
[6092105] = {id = 6092105, nameTextID = 303478, exDiscribeTextID = 303479}
, 
[6092201] = {id = 6092201, nameTextID = 303480, exDiscribeTextID = 303481}
, 
[6092202] = {id = 6092202, nameTextID = 303480, exDiscribeTextID = 303481}
, 
[6092203] = {id = 6092203, nameTextID = 303480, exDiscribeTextID = 303481}
, 
[6092204] = {id = 6092204, nameTextID = 303480, exDiscribeTextID = 303481}
, 
[6092205] = {id = 6092205, nameTextID = 303480, exDiscribeTextID = 303481}
, 
[6093101] = {id = 6093101, nameTextID = 303829, exDiscribeTextID = 303830}
, 
[6093102] = {id = 6093102, nameTextID = 303829, exDiscribeTextID = 303830}
, 
[6093103] = {id = 6093103, nameTextID = 303829, exDiscribeTextID = 303830}
, 
[6093104] = {id = 6093104, nameTextID = 303829, exDiscribeTextID = 303830}
, 
[6093105] = {id = 6093105, nameTextID = 303829, exDiscribeTextID = 303830}
, 
[6093201] = {id = 6093201, nameTextID = 303831, exDiscribeTextID = 303832}
, 
[6093202] = {id = 6093202, nameTextID = 303831, exDiscribeTextID = 303832}
, 
[6093203] = {id = 6093203, nameTextID = 303831, exDiscribeTextID = 303832}
, 
[6093204] = {id = 6093204, nameTextID = 303831, exDiscribeTextID = 303832}
, 
[6093205] = {id = 6093205, nameTextID = 303831, exDiscribeTextID = 303832}
, 
[6094101] = {id = 6094101, nameTextID = 303559, exDiscribeTextID = 303560}
, 
[6094102] = {id = 6094102, nameTextID = 303559, exDiscribeTextID = 303560}
, 
[6094103] = {id = 6094103, nameTextID = 303559, exDiscribeTextID = 303560}
, 
[6094104] = {id = 6094104, nameTextID = 303559, exDiscribeTextID = 303560}
, 
[6094105] = {id = 6094105, nameTextID = 303559, exDiscribeTextID = 303560}
, 
[6094201] = {id = 6094201, nameTextID = 303561, exDiscribeTextID = 303562}
, 
[6094202] = {id = 6094202, nameTextID = 303561, exDiscribeTextID = 303562}
, 
[6094203] = {id = 6094203, nameTextID = 303561, exDiscribeTextID = 303562}
, 
[6094204] = {id = 6094204, nameTextID = 303561, exDiscribeTextID = 303562}
, 
[6094205] = {id = 6094205, nameTextID = 303561, exDiscribeTextID = 303562}
, 
[6095101] = {id = 6095101, nameTextID = 303352, exDiscribeTextID = 303353}
, 
[6095102] = {id = 6095102, nameTextID = 303352, exDiscribeTextID = 303353}
, 
[6095103] = {id = 6095103, nameTextID = 303352, exDiscribeTextID = 303353}
, 
[6095104] = {id = 6095104, nameTextID = 303352, exDiscribeTextID = 303353}
, 
[6095105] = {id = 6095105, nameTextID = 303352, exDiscribeTextID = 303353}
, 
[6095201] = {id = 6095201, nameTextID = 303354, exDiscribeTextID = 303355}
, 
[6095202] = {id = 6095202, nameTextID = 303354, exDiscribeTextID = 303355}
, 
[6095203] = {id = 6095203, nameTextID = 303354, exDiscribeTextID = 303355}
, 
[6095204] = {id = 6095204, nameTextID = 303354, exDiscribeTextID = 303355}
, 
[6095205] = {id = 6095205, nameTextID = 303354, exDiscribeTextID = 303355}
, 
[6097101] = {id = 6097101, nameTextID = 303581, exDiscribeTextID = 303582}
, 
[6097102] = {id = 6097102, nameTextID = 303581, exDiscribeTextID = 303582}
, 
[6097103] = {id = 6097103, nameTextID = 303581, exDiscribeTextID = 303582}
, 
[6097104] = {id = 6097104, nameTextID = 303581, exDiscribeTextID = 303582}
, 
[6097105] = {id = 6097105, nameTextID = 303581, exDiscribeTextID = 303582}
, 
[6097201] = {id = 6097201, nameTextID = 303583, exDiscribeTextID = 303584}
, 
[6097202] = {id = 6097202, nameTextID = 303583, exDiscribeTextID = 303584}
, 
[6097203] = {id = 6097203, nameTextID = 303583, exDiscribeTextID = 303584}
, 
[6097204] = {id = 6097204, nameTextID = 303583, exDiscribeTextID = 303584}
, 
[6097205] = {id = 6097205, nameTextID = 303583, exDiscribeTextID = 303584}
, 
[6098101] = {id = 6098101, nameTextID = 303748, exDiscribeTextID = 303749}
, 
[6098102] = {id = 6098102, nameTextID = 303748, exDiscribeTextID = 303749}
, 
[6098103] = {id = 6098103, nameTextID = 303748, exDiscribeTextID = 303749}
, 
[6098104] = {id = 6098104, nameTextID = 303748, exDiscribeTextID = 303749}
, 
[6098105] = {id = 6098105, nameTextID = 303748, exDiscribeTextID = 303749}
, 
[6098201] = {id = 6098201, nameTextID = 303750, exDiscribeTextID = 303751}
, 
[6098202] = {id = 6098202, nameTextID = 303750, exDiscribeTextID = 303751}
, 
[6098203] = {id = 6098203, nameTextID = 303750, exDiscribeTextID = 303751}
, 
[6098204] = {id = 6098204, nameTextID = 303750, exDiscribeTextID = 303751}
, 
[6098205] = {id = 6098205, nameTextID = 303750, exDiscribeTextID = 303751}
, 
[6099101] = {id = 6099101, nameTextID = 303455, exDiscribeTextID = 303456}
, 
[6099102] = {id = 6099102, nameTextID = 303455, exDiscribeTextID = 303456}
, 
[6099103] = {id = 6099103, nameTextID = 303455, exDiscribeTextID = 303456}
, 
[6099104] = {id = 6099104, nameTextID = 303455, exDiscribeTextID = 303456}
, 
[6099105] = {id = 6099105, nameTextID = 303455, exDiscribeTextID = 303456}
, 
[6099201] = {id = 6099201, nameTextID = 303457, exDiscribeTextID = 303458}
, 
[6099202] = {id = 6099202, nameTextID = 303457, exDiscribeTextID = 303458}
, 
[6099203] = {id = 6099203, nameTextID = 303457, exDiscribeTextID = 303458}
, 
[6099204] = {id = 6099204, nameTextID = 303457, exDiscribeTextID = 303458}
, 
[6099205] = {id = 6099205, nameTextID = 303457, exDiscribeTextID = 303458}
, 
[6100101] = {id = 6100101, nameTextID = 303404, exDiscribeTextID = 303405}
, 
[6100102] = {id = 6100102, nameTextID = 303404, exDiscribeTextID = 303405}
, 
[6100103] = {id = 6100103, nameTextID = 303404, exDiscribeTextID = 303405}
, 
[6100104] = {id = 6100104, nameTextID = 303404, exDiscribeTextID = 303405}
, 
[6100105] = {id = 6100105, nameTextID = 303404, exDiscribeTextID = 303405}
, 
[6100201] = {id = 6100201, nameTextID = 303406, exDiscribeTextID = 303407}
, 
[6100202] = {id = 6100202, nameTextID = 303406, exDiscribeTextID = 303407}
, 
[6100203] = {id = 6100203, nameTextID = 303406, exDiscribeTextID = 303407}
, 
[6100204] = {id = 6100204, nameTextID = 303406, exDiscribeTextID = 303407}
, 
[6100205] = {id = 6100205, nameTextID = 303406, exDiscribeTextID = 303407}
, 
[6101101] = {id = 6101101, nameTextID = 303572, exDiscribeTextID = 303573}
, 
[6101102] = {id = 6101102, nameTextID = 303572, exDiscribeTextID = 303573}
, 
[6101103] = {id = 6101103, nameTextID = 303572, exDiscribeTextID = 303573}
, 
[6101104] = {id = 6101104, nameTextID = 303572, exDiscribeTextID = 303573}
, 
[6101105] = {id = 6101105, nameTextID = 303572, exDiscribeTextID = 303573}
, 
[6101201] = {id = 6101201, nameTextID = 303574, exDiscribeTextID = 303575}
, 
[6101202] = {id = 6101202, nameTextID = 303574, exDiscribeTextID = 303575}
, 
[6101203] = {id = 6101203, nameTextID = 303574, exDiscribeTextID = 303575}
, 
[6101204] = {id = 6101204, nameTextID = 303574, exDiscribeTextID = 303575}
, 
[6101205] = {id = 6101205, nameTextID = 303574, exDiscribeTextID = 303575}
, 
[6102101] = {id = 6102101, nameTextID = 303495, exDiscribeTextID = 303496}
, 
[6102102] = {id = 6102102, nameTextID = 303495, exDiscribeTextID = 303496}
, 
[6102103] = {id = 6102103, nameTextID = 303495, exDiscribeTextID = 303496}
, 
[6102104] = {id = 6102104, nameTextID = 303495, exDiscribeTextID = 303496}
, 
[6102105] = {id = 6102105, nameTextID = 303495, exDiscribeTextID = 303496}
, 
[6102201] = {id = 6102201, nameTextID = 303497, exDiscribeTextID = 303498}
, 
[6102202] = {id = 6102202, nameTextID = 303497, exDiscribeTextID = 303498}
, 
[6102203] = {id = 6102203, nameTextID = 303497, exDiscribeTextID = 303498}
, 
[6102204] = {id = 6102204, nameTextID = 303497, exDiscribeTextID = 303498}
, 
[6102205] = {id = 6102205, nameTextID = 303497, exDiscribeTextID = 303498}
, 
[6103101] = {id = 6103101, nameTextID = 303487, exDiscribeTextID = 303488}
, 
[6103102] = {id = 6103102, nameTextID = 303487, exDiscribeTextID = 303488}
, 
[6103103] = {id = 6103103, nameTextID = 303487, exDiscribeTextID = 303488}
, 
[6103104] = {id = 6103104, nameTextID = 303487, exDiscribeTextID = 303488}
, 
[6103105] = {id = 6103105, nameTextID = 303487, exDiscribeTextID = 303488}
, 
[6103201] = {id = 6103201, nameTextID = 303489, exDiscribeTextID = 303490}
, 
[6103202] = {id = 6103202, nameTextID = 303489, exDiscribeTextID = 303490}
, 
[6103203] = {id = 6103203, nameTextID = 303489, exDiscribeTextID = 303490}
, 
[6103204] = {id = 6103204, nameTextID = 303489, exDiscribeTextID = 303490}
, 
[6103205] = {id = 6103205, nameTextID = 303489, exDiscribeTextID = 303490}
, 
[6104101] = {id = 6104101, nameTextID = 303690, exDiscribeTextID = 303691}
, 
[6104102] = {id = 6104102, nameTextID = 303690, exDiscribeTextID = 303691}
, 
[6104103] = {id = 6104103, nameTextID = 303690, exDiscribeTextID = 303691}
, 
[6104104] = {id = 6104104, nameTextID = 303690, exDiscribeTextID = 303691}
, 
[6104105] = {id = 6104105, nameTextID = 303690, exDiscribeTextID = 303691}
, 
[6104201] = {id = 6104201, nameTextID = 303692, exDiscribeTextID = 303693}
, 
[6104202] = {id = 6104202, nameTextID = 303692, exDiscribeTextID = 303693}
, 
[6104203] = {id = 6104203, nameTextID = 303692, exDiscribeTextID = 303693}
, 
[6104204] = {id = 6104204, nameTextID = 303692, exDiscribeTextID = 303693}
, 
[6104205] = {id = 6104205, nameTextID = 303692, exDiscribeTextID = 303693}
, 
[6105101] = {id = 6105101, nameTextID = 303768, exDiscribeTextID = 303769}
, 
[6105102] = {id = 6105102, nameTextID = 303768, exDiscribeTextID = 303769}
, 
[6105103] = {id = 6105103, nameTextID = 303768, exDiscribeTextID = 303769}
, 
[6105104] = {id = 6105104, nameTextID = 303768, exDiscribeTextID = 303769}
, 
[6105105] = {id = 6105105, nameTextID = 303768, exDiscribeTextID = 303769}
, 
[6105201] = {id = 6105201, nameTextID = 303770, exDiscribeTextID = 303771}
, 
[6105202] = {id = 6105202, nameTextID = 303770, exDiscribeTextID = 303771}
, 
[6105203] = {id = 6105203, nameTextID = 303770, exDiscribeTextID = 303771}
, 
[6105204] = {id = 6105204, nameTextID = 303770, exDiscribeTextID = 303771}
, 
[6105205] = {id = 6105205, nameTextID = 303770, exDiscribeTextID = 303771}
, 
[6106101] = {id = 6106101, nameTextID = 303410, exDiscribeTextID = 303411}
, 
[6106102] = {id = 6106102, nameTextID = 303410, exDiscribeTextID = 303411}
, 
[6106103] = {id = 6106103, nameTextID = 303410, exDiscribeTextID = 303411}
, 
[6106104] = {id = 6106104, nameTextID = 303410, exDiscribeTextID = 303411}
, 
[6106105] = {id = 6106105, nameTextID = 303410, exDiscribeTextID = 303411}
, 
[6106201] = {id = 6106201, nameTextID = 303412, exDiscribeTextID = 303413}
, 
[6106202] = {id = 6106202, nameTextID = 303412, exDiscribeTextID = 303413}
, 
[6106203] = {id = 6106203, nameTextID = 303412, exDiscribeTextID = 303413}
, 
[6106204] = {id = 6106204, nameTextID = 303412, exDiscribeTextID = 303413}
, 
[6106205] = {id = 6106205, nameTextID = 303412, exDiscribeTextID = 303413}
, 
[6107101] = {id = 6107101, nameTextID = 303774, exDiscribeTextID = 303775}
, 
[6107102] = {id = 6107102, nameTextID = 303774, exDiscribeTextID = 303775}
, 
[6107103] = {id = 6107103, nameTextID = 303774, exDiscribeTextID = 303775}
, 
[6107104] = {id = 6107104, nameTextID = 303774, exDiscribeTextID = 303775}
, 
[6107105] = {id = 6107105, nameTextID = 303774, exDiscribeTextID = 303775}
, 
[6107201] = {id = 6107201, nameTextID = 303776, exDiscribeTextID = 303777}
, 
[6107202] = {id = 6107202, nameTextID = 303776, exDiscribeTextID = 303777}
, 
[6107203] = {id = 6107203, nameTextID = 303776, exDiscribeTextID = 303777}
, 
[6107204] = {id = 6107204, nameTextID = 303776, exDiscribeTextID = 303777}
, 
[6107205] = {id = 6107205, nameTextID = 303776, exDiscribeTextID = 303777}
, 
[6109101] = {id = 6109101, nameTextID = 303740, exDiscribeTextID = 303741}
, 
[6109102] = {id = 6109102, nameTextID = 303740, exDiscribeTextID = 303741}
, 
[6109103] = {id = 6109103, nameTextID = 303740, exDiscribeTextID = 303741}
, 
[6109104] = {id = 6109104, nameTextID = 303740, exDiscribeTextID = 303741}
, 
[6109105] = {id = 6109105, nameTextID = 303740, exDiscribeTextID = 303741}
, 
[6109201] = {id = 6109201, nameTextID = 303742, exDiscribeTextID = 303743}
, 
[6109202] = {id = 6109202, nameTextID = 303742, exDiscribeTextID = 303743}
, 
[6109203] = {id = 6109203, nameTextID = 303742, exDiscribeTextID = 303743}
, 
[6109204] = {id = 6109204, nameTextID = 303742, exDiscribeTextID = 303743}
, 
[6109205] = {id = 6109205, nameTextID = 303742, exDiscribeTextID = 303743}
, 
[6111101] = {id = 6111101, nameTextID = 303712, exDiscribeTextID = 303713}
, 
[6111102] = {id = 6111102, nameTextID = 303712, exDiscribeTextID = 303713}
, 
[6111103] = {id = 6111103, nameTextID = 303712, exDiscribeTextID = 303713}
, 
[6111104] = {id = 6111104, nameTextID = 303712, exDiscribeTextID = 303713}
, 
[6111105] = {id = 6111105, nameTextID = 303712, exDiscribeTextID = 303713}
, 
[6111201] = {id = 6111201, nameTextID = 303714, exDiscribeTextID = 303715}
, 
[6111202] = {id = 6111202, nameTextID = 303714, exDiscribeTextID = 303715}
, 
[6111203] = {id = 6111203, nameTextID = 303714, exDiscribeTextID = 303715}
, 
[6111204] = {id = 6111204, nameTextID = 303714, exDiscribeTextID = 303715}
, 
[6111205] = {id = 6111205, nameTextID = 303714, exDiscribeTextID = 303715}
, 
[6112101] = {id = 6112101, nameTextID = 303682, exDiscribeTextID = 303683}
, 
[6112102] = {id = 6112102, nameTextID = 303682, exDiscribeTextID = 303683}
, 
[6112103] = {id = 6112103, nameTextID = 303682, exDiscribeTextID = 303683}
, 
[6112104] = {id = 6112104, nameTextID = 303682, exDiscribeTextID = 303683}
, 
[6112105] = {id = 6112105, nameTextID = 303682, exDiscribeTextID = 303683}
, 
[6112201] = {id = 6112201, nameTextID = 303684, exDiscribeTextID = 303685}
, 
[6112202] = {id = 6112202, nameTextID = 303684, exDiscribeTextID = 303685}
, 
[6112203] = {id = 6112203, nameTextID = 303684, exDiscribeTextID = 303685}
, 
[6112204] = {id = 6112204, nameTextID = 303684, exDiscribeTextID = 303685}
, 
[6112205] = {id = 6112205, nameTextID = 303684, exDiscribeTextID = 303685}
, 
[6113101] = {id = 6113101, nameTextID = 303704, exDiscribeTextID = 303705}
, 
[6113102] = {id = 6113102, nameTextID = 303704, exDiscribeTextID = 303705}
, 
[6113103] = {id = 6113103, nameTextID = 303704, exDiscribeTextID = 303705}
, 
[6113104] = {id = 6113104, nameTextID = 303704, exDiscribeTextID = 303705}
, 
[6113105] = {id = 6113105, nameTextID = 303704, exDiscribeTextID = 303705}
, 
[6113201] = {id = 6113201, nameTextID = 303706, exDiscribeTextID = 303707}
, 
[6113202] = {id = 6113202, nameTextID = 303706, exDiscribeTextID = 303707}
, 
[6113203] = {id = 6113203, nameTextID = 303706, exDiscribeTextID = 303707}
, 
[6113204] = {id = 6113204, nameTextID = 303706, exDiscribeTextID = 303707}
, 
[6113205] = {id = 6113205, nameTextID = 303706, exDiscribeTextID = 303707}
, 
[6115101] = {id = 6115101, nameTextID = 303733, exDiscribeTextID = 303734}
, 
[6115102] = {id = 6115102, nameTextID = 303733, exDiscribeTextID = 303734}
, 
[6115103] = {id = 6115103, nameTextID = 303733, exDiscribeTextID = 303734}
, 
[6115104] = {id = 6115104, nameTextID = 303733, exDiscribeTextID = 303734}
, 
[6115105] = {id = 6115105, nameTextID = 303733, exDiscribeTextID = 303734}
, 
[6115201] = {id = 6115201, nameTextID = 303735, exDiscribeTextID = 303736}
, 
[6115202] = {id = 6115202, nameTextID = 303735, exDiscribeTextID = 303736}
, 
[6115203] = {id = 6115203, nameTextID = 303735, exDiscribeTextID = 303736}
, 
[6115204] = {id = 6115204, nameTextID = 303735, exDiscribeTextID = 303736}
, 
[6115205] = {id = 6115205, nameTextID = 303735, exDiscribeTextID = 303736}
, 
[6116101] = {id = 6116101, nameTextID = 303822, exDiscribeTextID = 303823}
, 
[6116102] = {id = 6116102, nameTextID = 303822, exDiscribeTextID = 303823}
, 
[6116103] = {id = 6116103, nameTextID = 303822, exDiscribeTextID = 303823}
, 
[6116104] = {id = 6116104, nameTextID = 303822, exDiscribeTextID = 303823}
, 
[6116105] = {id = 6116105, nameTextID = 303822, exDiscribeTextID = 303823}
, 
[6116201] = {id = 6116201, nameTextID = 303824, exDiscribeTextID = 303825}
, 
[6116202] = {id = 6116202, nameTextID = 303824, exDiscribeTextID = 303825}
, 
[6116203] = {id = 6116203, nameTextID = 303824, exDiscribeTextID = 303825}
, 
[6116204] = {id = 6116204, nameTextID = 303824, exDiscribeTextID = 303825}
, 
[6116205] = {id = 6116205, nameTextID = 303824, exDiscribeTextID = 303825}
, 
[6117101] = {id = 6117101, nameTextID = 303780, exDiscribeTextID = 303781}
, 
[6117102] = {id = 6117102, nameTextID = 303780, exDiscribeTextID = 303781}
, 
[6117103] = {id = 6117103, nameTextID = 303780, exDiscribeTextID = 303781}
, 
[6117104] = {id = 6117104, nameTextID = 303780, exDiscribeTextID = 303781}
, 
[6117105] = {id = 6117105, nameTextID = 303780, exDiscribeTextID = 303781}
, 
[6117201] = {id = 6117201, nameTextID = 303782, exDiscribeTextID = 303783}
, 
[6117202] = {id = 6117202, nameTextID = 303782, exDiscribeTextID = 303783}
, 
[6117203] = {id = 6117203, nameTextID = 303782, exDiscribeTextID = 303783}
, 
[6117204] = {id = 6117204, nameTextID = 303782, exDiscribeTextID = 303783}
, 
[6117205] = {id = 6117205, nameTextID = 303782, exDiscribeTextID = 303783}
, 
[6118101] = {id = 6118101, nameTextID = 303836, exDiscribeTextID = 303837}
, 
[6118102] = {id = 6118102, nameTextID = 303836, exDiscribeTextID = 303837}
, 
[6118103] = {id = 6118103, nameTextID = 303836, exDiscribeTextID = 303837}
, 
[6118104] = {id = 6118104, nameTextID = 303836, exDiscribeTextID = 303837}
, 
[6118105] = {id = 6118105, nameTextID = 303836, exDiscribeTextID = 303837}
, 
[6118201] = {id = 6118201, nameTextID = 303838, exDiscribeTextID = 303839}
, 
[6118202] = {id = 6118202, nameTextID = 303838, exDiscribeTextID = 303839}
, 
[6118203] = {id = 6118203, nameTextID = 303838, exDiscribeTextID = 303839}
, 
[6118204] = {id = 6118204, nameTextID = 303838, exDiscribeTextID = 303839}
, 
[6118205] = {id = 6118205, nameTextID = 303838, exDiscribeTextID = 303839}
, 
[6119101] = {id = 6119101, nameTextID = 303755, exDiscribeTextID = 303756}
, 
[6119102] = {id = 6119102, nameTextID = 303755, exDiscribeTextID = 303756}
, 
[6119103] = {id = 6119103, nameTextID = 303755, exDiscribeTextID = 303756}
, 
[6119104] = {id = 6119104, nameTextID = 303755, exDiscribeTextID = 303756}
, 
[6119105] = {id = 6119105, nameTextID = 303755, exDiscribeTextID = 303756}
, 
[6119201] = {id = 6119201, nameTextID = 303757, exDiscribeTextID = 303758}
, 
[6119202] = {id = 6119202, nameTextID = 303757, exDiscribeTextID = 303758}
, 
[6119203] = {id = 6119203, nameTextID = 303757, exDiscribeTextID = 303758}
, 
[6119204] = {id = 6119204, nameTextID = 303757, exDiscribeTextID = 303758}
, 
[6119205] = {id = 6119205, nameTextID = 303757, exDiscribeTextID = 303758}
, 
[6120101] = {id = 6120101, nameTextID = 303697, exDiscribeTextID = 303698}
, 
[6120102] = {id = 6120102, nameTextID = 303697, exDiscribeTextID = 303698}
, 
[6120103] = {id = 6120103, nameTextID = 303697, exDiscribeTextID = 303698}
, 
[6120104] = {id = 6120104, nameTextID = 303697, exDiscribeTextID = 303698}
, 
[6120105] = {id = 6120105, nameTextID = 303697, exDiscribeTextID = 303698}
, 
[6120201] = {id = 6120201, nameTextID = 303699, exDiscribeTextID = 303700}
, 
[6120202] = {id = 6120202, nameTextID = 303699, exDiscribeTextID = 303700}
, 
[6120203] = {id = 6120203, nameTextID = 303699, exDiscribeTextID = 303700}
, 
[6120204] = {id = 6120204, nameTextID = 303699, exDiscribeTextID = 303700}
, 
[6120205] = {id = 6120205, nameTextID = 303699, exDiscribeTextID = 303700}
, 
[6121101] = {id = 6121101, nameTextID = 303794, exDiscribeTextID = 303795}
, 
[6121102] = {id = 6121102, nameTextID = 303794, exDiscribeTextID = 303795}
, 
[6121103] = {id = 6121103, nameTextID = 303794, exDiscribeTextID = 303795}
, 
[6121104] = {id = 6121104, nameTextID = 303794, exDiscribeTextID = 303795}
, 
[6121105] = {id = 6121105, nameTextID = 303794, exDiscribeTextID = 303795}
, 
[6121201] = {id = 6121201, nameTextID = 303796, exDiscribeTextID = 303797}
, 
[6121202] = {id = 6121202, nameTextID = 303796, exDiscribeTextID = 303797}
, 
[6121203] = {id = 6121203, nameTextID = 303796, exDiscribeTextID = 303797}
, 
[6121204] = {id = 6121204, nameTextID = 303796, exDiscribeTextID = 303797}
, 
[6121205] = {id = 6121205, nameTextID = 303796, exDiscribeTextID = 303797}
, 
[6122101] = {id = 6122101, nameTextID = 303787, exDiscribeTextID = 303788}
, 
[6122102] = {id = 6122102, nameTextID = 303787, exDiscribeTextID = 303788}
, 
[6122103] = {id = 6122103, nameTextID = 303787, exDiscribeTextID = 303788}
, 
[6122104] = {id = 6122104, nameTextID = 303787, exDiscribeTextID = 303788}
, 
[6122105] = {id = 6122105, nameTextID = 303787, exDiscribeTextID = 303788}
, 
[6122201] = {id = 6122201, nameTextID = 303789, exDiscribeTextID = 303790}
, 
[6122202] = {id = 6122202, nameTextID = 303789, exDiscribeTextID = 303790}
, 
[6122203] = {id = 6122203, nameTextID = 303789, exDiscribeTextID = 303790}
, 
[6122204] = {id = 6122204, nameTextID = 303789, exDiscribeTextID = 303790}
, 
[6122205] = {id = 6122205, nameTextID = 303789, exDiscribeTextID = 303790}
, 
[6123101] = {id = 6123101, nameTextID = 303801, exDiscribeTextID = 303802}
, 
[6123102] = {id = 6123102, nameTextID = 303801, exDiscribeTextID = 303802}
, 
[6123103] = {id = 6123103, nameTextID = 303801, exDiscribeTextID = 303802}
, 
[6123104] = {id = 6123104, nameTextID = 303801, exDiscribeTextID = 303802}
, 
[6123105] = {id = 6123105, nameTextID = 303801, exDiscribeTextID = 303802}
, 
[6123201] = {id = 6123201, nameTextID = 303803, exDiscribeTextID = 303804}
, 
[6123202] = {id = 6123202, nameTextID = 303803, exDiscribeTextID = 303804}
, 
[6123203] = {id = 6123203, nameTextID = 303803, exDiscribeTextID = 303804}
, 
[6123204] = {id = 6123204, nameTextID = 303803, exDiscribeTextID = 303804}
, 
[6123205] = {id = 6123205, nameTextID = 303803, exDiscribeTextID = 303804}
, 
[6124101] = {id = 6124101, nameTextID = 303815, exDiscribeTextID = 303816}
, 
[6124102] = {id = 6124102, nameTextID = 303815, exDiscribeTextID = 303816}
, 
[6124103] = {id = 6124103, nameTextID = 303815, exDiscribeTextID = 303816}
, 
[6124104] = {id = 6124104, nameTextID = 303815, exDiscribeTextID = 303816}
, 
[6124105] = {id = 6124105, nameTextID = 303815, exDiscribeTextID = 303816}
, 
[6124201] = {id = 6124201, nameTextID = 303817, exDiscribeTextID = 303818}
, 
[6124202] = {id = 6124202, nameTextID = 303817, exDiscribeTextID = 303818}
, 
[6124203] = {id = 6124203, nameTextID = 303817, exDiscribeTextID = 303818}
, 
[6124204] = {id = 6124204, nameTextID = 303817, exDiscribeTextID = 303818}
, 
[6124205] = {id = 6124205, nameTextID = 303817, exDiscribeTextID = 303818}
, 
[6126101] = {id = 6126101, nameTextID = 303843, exDiscribeTextID = 303844}
, 
[6126102] = {id = 6126102, nameTextID = 303843, exDiscribeTextID = 303844}
, 
[6126103] = {id = 6126103, nameTextID = 303843, exDiscribeTextID = 303844}
, 
[6126104] = {id = 6126104, nameTextID = 303843, exDiscribeTextID = 303844}
, 
[6126105] = {id = 6126105, nameTextID = 303843, exDiscribeTextID = 303844}
, 
[6126201] = {id = 6126201, nameTextID = 303845, exDiscribeTextID = 303846}
, 
[6126202] = {id = 6126202, nameTextID = 303845, exDiscribeTextID = 303846}
, 
[6126203] = {id = 6126203, nameTextID = 303845, exDiscribeTextID = 303846}
, 
[6126204] = {id = 6126204, nameTextID = 303845, exDiscribeTextID = 303846}
, 
[6126205] = {id = 6126205, nameTextID = 303845, exDiscribeTextID = 303846}
, 
[6130101] = {id = 6130101, nameTextID = 303857, exDiscribeTextID = 303858}
, 
[6130102] = {id = 6130102, nameTextID = 303857, exDiscribeTextID = 303858}
, 
[6130103] = {id = 6130103, nameTextID = 303857, exDiscribeTextID = 303858}
, 
[6130104] = {id = 6130104, nameTextID = 303857, exDiscribeTextID = 303858}
, 
[6130105] = {id = 6130105, nameTextID = 303857, exDiscribeTextID = 303858}
, 
[6130201] = {id = 6130201, nameTextID = 303859, exDiscribeTextID = 303860}
, 
[6130202] = {id = 6130202, nameTextID = 303859, exDiscribeTextID = 303860}
, 
[6130203] = {id = 6130203, nameTextID = 303859, exDiscribeTextID = 303860}
, 
[6130204] = {id = 6130204, nameTextID = 303859, exDiscribeTextID = 303860}
, 
[6130205] = {id = 6130205, nameTextID = 303859, exDiscribeTextID = 303860}
, 
[60108101] = {id = 60108101, nameTextID = 303369, exDiscribeTextID = 303370}
, 
[60108102] = {id = 60108102, nameTextID = 303369, exDiscribeTextID = 303370}
, 
[60108103] = {id = 60108103, nameTextID = 303369, exDiscribeTextID = 303370}
, 
[60108104] = {id = 60108104, nameTextID = 303369, exDiscribeTextID = 303370}
, 
[60108105] = {id = 60108105, nameTextID = 303369, exDiscribeTextID = 303370}
, 
[60108201] = {id = 60108201, nameTextID = 303371, exDiscribeTextID = 303372}
, 
[60108202] = {id = 60108202, nameTextID = 303371, exDiscribeTextID = 303372}
, 
[60108203] = {id = 60108203, nameTextID = 303371, exDiscribeTextID = 303372}
, 
[60108204] = {id = 60108204, nameTextID = 303371, exDiscribeTextID = 303372}
, 
[60108205] = {id = 60108205, nameTextID = 303371, exDiscribeTextID = 303372}
, 
[60110101] = {id = 60110101, nameTextID = 303363, exDiscribeTextID = 303364}
, 
[60110102] = {id = 60110102, nameTextID = 303363, exDiscribeTextID = 303364}
, 
[60110103] = {id = 60110103, nameTextID = 303363, exDiscribeTextID = 303364}
, 
[60110104] = {id = 60110104, nameTextID = 303363, exDiscribeTextID = 303364}
, 
[60110105] = {id = 60110105, nameTextID = 303363, exDiscribeTextID = 303364}
, 
[60110201] = {id = 60110201, nameTextID = 303365, exDiscribeTextID = 303366}
, 
[60110202] = {id = 60110202, nameTextID = 303365, exDiscribeTextID = 303366}
, 
[60110203] = {id = 60110203, nameTextID = 303365, exDiscribeTextID = 303366}
, 
[60110204] = {id = 60110204, nameTextID = 303365, exDiscribeTextID = 303366}
, 
[60110205] = {id = 60110205, nameTextID = 303365, exDiscribeTextID = 303366}
, 
[60381301] = {id = 60381301, nameTextID = 303171, exDiscribeTextID = 303205}
, 
[60381302] = {id = 60381302, nameTextID = 303171, exDiscribeTextID = 303205}
, 
[60381303] = {id = 60381303, nameTextID = 303171, exDiscribeTextID = 303205}
, 
[60381304] = {id = 60381304, nameTextID = 303171, exDiscribeTextID = 303205}
, 
[60381305] = {id = 60381305, nameTextID = 303171, exDiscribeTextID = 303205}
}
cskillshow_common.AllIds = {21, 22, 23, 24, 31, 32, 33, 34, 41, 42, 43, 44, 51, 52, 53, 54, 61, 62, 63, 64, 71, 72, 73, 74, 81, 82, 83, 84, 91, 92, 93, 94, 101, 102, 103, 104, 111, 112, 113, 114, 121, 122, 123, 124, 131, 132, 133, 134, 141, 142, 143, 144, 151, 152, 153, 154, 161, 162, 163, 164, 171, 172, 173, 174, 181, 182, 183, 184, 191, 192, 193, 194, 201, 202, 203, 204, 211, 212, 213, 214, 221, 222, 223, 224, 231, 232, 233, 234, 241, 242, 243, 244, 251, 252, 253, 254, 261, 262, 263, 264, 271, 272, 273, 274, 281, 282, 283, 284, 291, 292, 293, 294, 301, 302, 303, 304, 321, 322, 323, 324, 331, 332, 333, 334, 341, 342, 343, 344, 351, 352, 353, 354, 361, 362, 363, 364, 381, 382, 383, 384, 391, 392, 393, 394, 401, 402, 403, 404, 411, 412, 413, 414, 421, 422, 423, 424, 431, 432, 433, 434, 441, 442, 443, 444, 451, 452, 453, 454, 461, 462, 463, 464, 471, 472, 473, 474, 481, 482, 483, 484, 491, 492, 493, 494, 501, 502, 503, 504, 511, 512, 513, 514, 521, 522, 523, 524, 531, 532, 533, 534, 541, 542, 543, 544, 551, 552, 553, 554, 561, 562, 563, 564, 571, 572, 573, 574, 581, 582, 583, 584, 591, 592, 593, 594, 601, 602, 603, 604, 611, 612, 613, 614, 621, 622, 623, 624, 631, 632, 633, 634, 641, 642, 643, 644, 651, 652, 653, 654, 661, 662, 663, 664, 671, 672, 673, 674, 681, 682, 683, 684, 691, 692, 693, 694, 701, 702, 703, 704, 711, 712, 713, 714, 721, 722, 723, 724, 731, 732, 733, 734, 741, 742, 743, 744, 751, 752, 753, 754, 761, 762, 763, 764, 1021, 1022, 1023, 1024, 20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010, 20011, 20012, 20013, 20014, 20015, 20016, 20017, 20018, 20019, 20020, 20021, 20022, 20023, 20024, 20025, 20026, 20027, 20028, 20029, 20030, 20031, 20032, 20033, 20034, 20035, 20036, 20037, 20038, 20039, 20040, 20041, 20042, 20043, 20044, 20045, 20046, 20047, 20048, 20049, 20050, 20051, 20052, 20055, 20056, 20057, 20058, 20059, 20060, 20061, 20062, 20063, 20064, 20065, 20066, 20075, 20076, 20077, 20078, 20079, 20083, 31001, 31002, 31003, 32001, 32002, 32003, 33001, 33002, 33003, 34001, 34002, 34003, 35001, 35002, 35003, 36001, 36002, 36003, 37001, 37002, 37003, 201007, 201008, 201009, 201010, 201011, 201012, 201013, 201014, 201015, 201016, 201017, 201018, 201019, 201020, 201021, 201022, 201023, 201024, 201025, 201026, 201027, 201028, 201029, 201030, 201031, 201032, 201033, 201034, 201035, 201036, 201037, 201038, 201039, 201040, 201041, 201042, 201043, 201044, 201045, 201046, 201047, 201048, 201049, 201050, 201051, 201052, 201053, 201054, 201055, 201056, 201057, 201058, 201059, 201060, 201061, 201062, 201063, 201064, 201065, 201066, 201067, 201068, 201069, 201070, 201071, 201072, 201073, 201074, 201075, 201076, 201077, 201078, 201079, 201080, 201081, 201082, 201083, 201084, 201085, 201086, 201088, 201089, 201090, 201092, 201093, 201094, 201095, 201096, 201097, 201098, 201099, 201100, 201101, 201102, 201103, 201104, 201105, 201106, 201107, 201108, 201109, 201110, 201111, 201112, 201113, 201114, 201116, 201117, 201118, 201119, 201120, 201121, 201122, 201123, 201124, 201125, 201126, 201127, 201128, 201129, 201130, 201131, 201132, 201133, 201134, 201135, 201136, 201137, 201138, 201139, 201140, 201141, 201142, 201143, 201144, 201145, 201146, 201147, 201148, 201149, 201150, 201151, 201152, 201153, 201154, 201155, 201156, 201157, 201159, 201160, 201161, 201162, 201164, 201203, 201204, 201205, 201206, 201209, 201210, 201211, 201212, 201213, 201214, 201215, 201216, 201217, 201218, 201219, 201220, 201221, 201222, 201223, 201224, 201225, 201226, 201227, 201228, 201229, 201231, 201232, 201233, 201234, 201235, 201236, 201237, 201238, 201239, 201240, 201241, 201242, 201243, 201244, 201245, 201246, 201247, 201248, 201249, 201250, 201251, 201252, 201253, 201254, 201256, 201257, 201258, 201259, 201260, 201261, 201262, 201264, 201265, 201267, 201268, 201269, 201270, 201271, 201272, 201273, 201274, 201275, 201276, 201277, 201278, 201279, 201280, 201281, 201282, 201283, 201284, 201285, 201286, 201287, 201288, 201290, 201291, 201292, 201293, 201294, 201295, 201296, 201297, 201300, 201301, 201302, 201303, 201304, 201305, 201306, 201307, 201308, 201309, 201310, 201311, 201312, 201313, 201314, 201315, 201316, 201317, 201318, 201319, 201320, 201321, 201322, 201323, 201324, 201325, 201326, 201331, 201333, 201334, 201336, 201337, 201365, 201368, 201369, 201373, 201374, 201376, 201384, 201385, 201388, 201389, 201391, 201392, 201393, 201394, 201395, 201396, 201397, 201398, 201399, 201400, 201401, 201402, 201403, 201404, 201405, 201412, 201413, 201415, 201416, 201417, 201418, 201419, 201420, 201421, 201422, 201423, 201424, 201425, 201426, 201427, 201428, 201429, 201430, 201432, 201433, 201435, 201436, 201437, 201439, 201441, 201443, 201444, 201445, 201446, 201447, 201449, 201450, 201451, 201452, 201453, 201454, 201455, 201456, 201457, 201458, 201459, 201460, 201461, 201462, 201463, 201464, 201465, 201466, 201467, 201468, 201469, 201470, 201471, 201472, 201473, 201474, 201476, 201477, 201479, 201480, 201486, 201487, 201489, 201490, 201491, 201492, 201493, 201494, 201495, 201497, 201505, 201506, 201507, 201508, 201509, 201510, 201511, 201512, 201513, 201514, 201515, 201516, 201519, 201520, 201522, 201523, 201524, 201525, 201526, 201527, 201528, 201529, 201530, 201531, 201532, 201533, 201534, 201535, 201536, 201538, 201539, 201540, 201541, 201542, 201543, 201544, 201545, 201546, 201548, 201549, 201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201561, 201562, 201563, 201564, 201565, 201566, 201567, 201568, 201569, 201570, 201571, 201572, 201573, 201574, 201575, 201576, 201577, 201578, 201579, 201580, 201581, 201582, 201583, 201588, 201589, 201590, 201591, 201593, 201594, 201597, 201598, 201604, 201641, 201646, 201648, 201649, 201650, 201651, 201652, 201653, 201654, 201655, 201656, 201657, 201658, 201659, 201660, 201663, 201666, 201667, 201668, 201669, 201670, 201671, 201672, 201673, 201674, 201685, 201686, 201687, 201688, 201689, 201690, 201691, 201692, 201693, 201694, 201695, 201696, 201697, 201698, 201699, 201700, 201701, 201707, 201708, 201711, 201714, 201717, 201718, 201719, 201721, 201722, 201733, 201734, 201735, 201736, 201737, 201738, 201739, 201740, 201741, 201750, 201751, 201754, 201755, 201756, 201757, 201758, 201759, 201760, 201761, 201762, 201763, 201764, 201765, 201766, 201767, 201768, 201769, 201770, 201771, 201780, 201781, 201782, 201783, 201784, 201785, 201786, 201787, 201788, 201789, 201790, 201791, 201792, 201794, 201795, 201796, 201797, 201798, 201799, 201808, 201809, 201810, 201812, 201815, 201816, 201817, 201819, 201821, 201822, 201823, 201849, 201851, 201852, 201853, 201860, 201861, 201862, 201863, 201864, 201866, 201867, 300601, 300602, 300603, 300604, 300605, 300606, 300607, 300608, 300609, 300610, 300801, 300802, 300803, 300804, 300805, 300806, 300807, 300808, 300809, 300810, 301001, 301002, 301003, 301004, 301005, 301006, 301007, 301008, 301009, 301010, 301101, 301102, 301103, 301104, 301105, 301106, 301107, 301108, 301109, 301110, 301201, 301202, 301203, 301204, 301205, 301206, 301207, 301208, 301209, 301210, 301301, 301302, 301303, 301304, 301305, 301306, 301307, 301308, 301309, 301310, 301701, 301702, 301703, 301704, 301705, 301706, 301707, 301708, 301709, 301710, 302301, 302302, 302303, 302304, 302305, 302306, 302307, 302308, 302309, 302310, 302501, 302502, 302503, 302504, 302505, 302506, 302507, 302508, 302509, 302510, 302901, 302902, 302903, 302904, 302905, 302906, 302907, 302908, 302909, 302910, 303001, 303002, 303003, 303004, 303005, 303006, 303007, 303008, 303009, 303010, 303301, 303302, 303303, 303304, 303305, 303306, 303307, 303308, 303309, 303310, 303401, 303402, 303403, 303404, 303405, 303406, 303407, 303408, 303409, 303410, 303501, 303502, 303503, 303504, 303505, 303506, 303507, 303508, 303509, 303510, 303801, 303802, 303803, 303804, 303805, 303806, 303807, 303808, 303809, 303810, 303901, 303902, 303903, 303904, 303905, 303906, 303907, 303908, 303909, 303910, 304101, 304102, 304103, 304104, 304105, 304106, 304107, 304108, 304109, 304110, 304201, 304202, 304203, 304204, 304205, 304206, 304207, 304208, 304209, 304210, 304301, 304302, 304303, 304304, 304305, 304306, 304307, 304308, 304309, 304310, 304701, 304702, 304703, 304704, 304705, 304706, 304707, 304708, 304709, 304710, 304801, 304802, 304803, 304804, 304805, 304806, 304807, 304808, 304809, 304810, 305101, 305102, 305103, 305104, 305105, 305106, 305107, 305108, 305109, 305110, 305301, 305302, 305303, 305304, 305305, 305306, 305307, 305308, 305309, 305310, 305501, 305502, 305503, 305504, 305505, 305506, 305507, 305508, 305509, 305510, 305601, 305602, 305603, 305604, 305605, 305606, 305607, 305608, 305609, 305610, 305901, 305902, 305903, 305904, 305905, 305906, 305907, 305908, 305909, 305910, 306301, 306302, 306303, 306304, 306305, 306306, 306307, 306308, 306309, 306310, 306401, 306402, 306403, 306404, 306405, 306406, 306407, 306408, 306409, 306410, 306501, 306502, 306503, 306504, 306505, 306506, 306507, 306508, 306509, 306510, 306601, 306602, 306603, 306604, 306605, 306606, 306607, 306608, 306609, 306610, 306901, 306902, 306903, 306904, 306905, 306906, 306907, 306908, 306909, 306910, 307001, 307002, 307003, 307004, 307005, 307006, 307007, 307008, 307009, 307010, 307101, 307102, 307103, 307104, 307105, 307106, 307107, 307108, 307109, 307110, 307201, 307202, 307203, 307204, 307205, 307206, 307207, 307208, 307209, 307210, 307901, 307902, 307903, 307904, 307905, 307906, 307907, 307908, 307909, 307910, 308001, 308002, 308003, 308004, 308005, 308006, 308007, 308008, 308009, 308010, 308101, 308102, 308103, 308104, 308105, 308106, 308107, 308108, 308109, 308110, 308201, 308202, 308203, 308204, 308205, 308206, 308207, 308208, 308209, 308210, 308301, 308302, 308303, 308304, 308305, 308306, 308307, 308308, 308309, 308310, 308401, 308402, 308403, 308404, 308405, 308406, 308407, 308408, 308409, 308410, 308501, 308502, 308503, 308504, 308505, 308506, 308507, 308508, 308509, 308510, 308801, 308802, 308803, 308804, 308805, 308806, 308807, 308808, 308809, 308810, 308901, 308902, 308903, 308904, 308905, 308906, 308907, 308908, 308909, 308910, 309001, 309002, 309003, 309004, 309005, 309006, 309007, 309008, 309009, 309010, 309101, 309102, 309103, 309104, 309105, 309106, 309107, 309108, 309109, 309110, 309201, 309202, 309203, 309204, 309205, 309206, 309207, 309208, 309209, 309210, 309301, 309302, 309303, 309304, 309305, 309306, 309307, 309308, 309309, 309310, 309401, 309402, 309403, 309404, 309405, 309406, 309407, 309408, 309409, 309410, 309501, 309502, 309503, 309504, 309505, 309506, 309507, 309508, 309509, 309510, 309701, 309702, 309703, 309704, 309705, 309706, 309707, 309708, 309709, 309710, 309801, 309802, 309803, 309804, 309805, 309806, 309807, 309808, 309809, 309810, 309901, 309902, 309903, 309904, 309905, 309906, 309907, 309908, 309909, 309910, 310001, 310002, 310003, 310004, 310005, 310006, 310007, 310008, 310009, 310010, 310101, 310102, 310103, 310104, 310105, 310106, 310107, 310108, 310109, 310110, 310201, 310202, 310203, 310204, 310205, 310206, 310207, 310208, 310209, 310210, 310301, 310302, 310303, 310304, 310305, 310306, 310307, 310308, 310309, 310310, 310401, 310402, 310403, 310404, 310405, 310406, 310407, 310408, 310409, 310410, 310501, 310502, 310503, 310504, 310505, 310506, 310507, 310508, 310509, 310510, 310601, 310602, 310603, 310604, 310605, 310606, 310607, 310608, 310609, 310610, 310701, 310702, 310703, 310704, 310705, 310706, 310707, 310708, 310709, 310710, 310801, 310802, 310803, 310804, 310805, 310806, 310807, 310808, 310809, 310810, 310901, 310902, 310903, 310904, 310905, 310906, 310907, 310908, 310909, 310910, 311101, 311102, 311103, 311104, 311105, 311106, 311107, 311108, 311109, 311110, 311201, 311202, 311203, 311204, 311205, 311206, 311207, 311208, 311209, 311210, 311301, 311302, 311303, 311304, 311305, 311306, 311307, 311308, 311309, 311310, 311501, 311502, 311503, 311504, 311505, 311506, 311507, 311508, 311509, 311510, 311601, 311602, 311603, 311604, 311605, 311606, 311607, 311608, 311609, 311610, 311701, 311702, 311703, 311704, 311705, 311706, 311707, 311708, 311709, 311710, 311801, 311802, 311803, 311804, 311805, 311806, 311807, 311808, 311809, 311810, 311901, 311902, 311903, 311904, 311905, 311906, 311907, 311908, 311909, 311910, 312001, 312002, 312003, 312004, 312005, 312006, 312007, 312008, 312009, 312010, 312101, 312102, 312103, 312104, 312105, 312106, 312107, 312108, 312109, 312110, 312201, 312202, 312203, 312204, 312205, 312206, 312207, 312208, 312209, 312210, 312301, 312302, 312303, 312304, 312305, 312306, 312307, 312308, 312309, 312310, 312401, 312402, 312403, 312404, 312405, 312406, 312407, 312408, 312409, 312410, 312601, 312602, 312603, 312604, 312605, 312606, 312607, 312608, 312609, 312610, 313001, 313002, 313003, 313004, 313005, 313006, 313007, 313008, 313009, 313010, 400101, 400102, 400103, 400104, 400105, 400106, 400107, 400108, 400201, 400202, 400203, 400204, 400205, 400206, 400207, 400208, 400301, 400302, 400303, 400304, 400305, 400306, 400307, 400308, 400401, 400402, 400403, 400404, 400405, 400406, 400407, 400408, 400501, 400502, 400503, 400504, 400505, 400506, 400507, 400508, 400601, 400602, 400603, 400604, 400605, 400606, 400607, 400608, 400701, 400702, 400703, 400704, 400705, 400706, 400707, 400708, 400801, 400802, 400803, 400804, 400805, 400806, 400807, 400808, 400901, 400902, 400903, 400904, 400905, 400906, 400907, 400908, 401001, 401002, 401003, 401004, 401005, 401006, 401007, 401008, 401101, 401102, 401103, 401104, 401105, 401106, 401107, 401108, 401201, 401202, 401203, 401204, 401205, 401206, 401207, 401208, 401301, 401302, 401303, 401304, 401305, 401306, 401307, 401308, 401401, 401402, 401403, 401404, 401405, 401406, 401407, 401408, 401501, 401502, 401503, 401504, 401505, 401506, 401507, 401508, 401601, 401602, 401603, 401604, 401605, 401606, 401607, 401608, 401701, 401702, 401703, 401704, 401705, 401706, 401707, 401708, 401801, 401802, 401803, 401804, 401805, 401806, 401807, 401808, 401901, 401902, 401903, 401904, 401905, 401906, 401907, 401908, 402001, 402002, 402003, 402004, 402005, 402006, 402007, 402008, 402101, 402102, 402103, 402104, 402105, 402106, 402107, 402108, 402201, 402202, 402203, 402204, 402205, 402206, 402207, 402208, 402301, 402302, 402303, 402304, 402305, 402306, 402307, 402308, 402401, 402402, 402403, 402404, 402405, 402406, 402407, 402408, 402501, 402502, 402503, 402504, 402505, 402506, 402507, 402508, 402601, 402602, 402603, 402604, 402605, 402606, 402607, 402608, 402701, 402702, 402703, 402704, 402705, 402706, 402707, 402708, 402801, 402802, 402803, 402804, 402805, 402806, 402807, 402808, 402901, 402902, 402903, 402904, 402905, 402906, 402907, 402908, 403001, 403002, 403003, 403004, 403005, 403006, 403007, 403008, 403201, 403202, 403203, 403204, 403205, 403206, 403207, 403208, 403301, 403302, 403303, 403304, 403305, 403306, 403307, 403308, 403401, 403402, 403403, 403404, 403405, 403406, 403407, 403408, 403501, 403502, 403503, 403504, 403505, 403506, 403507, 403508, 403601, 403602, 403603, 403604, 403605, 403606, 403607, 403608, 403801, 403802, 403803, 403804, 403805, 403806, 403807, 403808, 403901, 403902, 403903, 403904, 403905, 403906, 403907, 403908, 404001, 404002, 404003, 404004, 404005, 404006, 404007, 404008, 404101, 404102, 404103, 404104, 404105, 404106, 404107, 404108, 404201, 404202, 404203, 404204, 404205, 404206, 404207, 404208, 404301, 404302, 404303, 404304, 404305, 404306, 404307, 404308, 404401, 404402, 404403, 404404, 404405, 404406, 404407, 404408, 404501, 404502, 404503, 404504, 404505, 404506, 404507, 404508, 404601, 404602, 404603, 404604, 404605, 404606, 404607, 404608, 404701, 404702, 404703, 404704, 404705, 404706, 404707, 404708, 404801, 404802, 404803, 404804, 404805, 404806, 404807, 404808, 404901, 404902, 404903, 404904, 404905, 404906, 404907, 404908, 405001, 405002, 405003, 405004, 405005, 405006, 405007, 405008, 405101, 405102, 405103, 405104, 405105, 405106, 405107, 405108, 405201, 405202, 405203, 405204, 405205, 405206, 405207, 405208, 405301, 405302, 405303, 405304, 405305, 405306, 405307, 405308, 405401, 405402, 405403, 405404, 405405, 405406, 405407, 405408, 405501, 405502, 405503, 405504, 405505, 405506, 405507, 405508, 405601, 405602, 405603, 405604, 405605, 405606, 405607, 405608, 405701, 405702, 405703, 405704, 405705, 405706, 405707, 405708, 405801, 405802, 405803, 405804, 405805, 405806, 405807, 405808, 405901, 405902, 405903, 405904, 405905, 405906, 405907, 405908, 406001, 406002, 406003, 406004, 406005, 406006, 406007, 406008, 406101, 406102, 406103, 406104, 406105, 406106, 406107, 406108, 406201, 406202, 406203, 406204, 406205, 406206, 406207, 406208, 406301, 406302, 406303, 406304, 406305, 406306, 406307, 406308, 406401, 406402, 406403, 406404, 406405, 406406, 406407, 406408, 406501, 406502, 406503, 406504, 406505, 406506, 406507, 406508, 406601, 406602, 406603, 406604, 406605, 406606, 406607, 406608, 406701, 406702, 406703, 406704, 406705, 406706, 406707, 406708, 406801, 406802, 406803, 406804, 406805, 406806, 406807, 406808, 406901, 406902, 406903, 406904, 406905, 406906, 406907, 406908, 407001, 407002, 407003, 407004, 407005, 407006, 407007, 407008, 407101, 407102, 407103, 407104, 407105, 407106, 407107, 407108, 407201, 407202, 407203, 407204, 407205, 407206, 407207, 407208, 407301, 407302, 407303, 407304, 407305, 407306, 407307, 407308, 407401, 407402, 407403, 407404, 407405, 407406, 407407, 407408, 407501, 407502, 407503, 407504, 407505, 407506, 407507, 407508, 407601, 407602, 407603, 407604, 407605, 407606, 407607, 407608, 407801, 407802, 407803, 407804, 407805, 407806, 407807, 407808, 407901, 407902, 407903, 407904, 407905, 407906, 407907, 407908, 408001, 408002, 408003, 408004, 408005, 408006, 408007, 408008, 408101, 408102, 408103, 408104, 408105, 408106, 408107, 408108, 408201, 408202, 408203, 408204, 408205, 408206, 408207, 408208, 408301, 408302, 408303, 408304, 408305, 408306, 408307, 408308, 408401, 408402, 408403, 408404, 408405, 408406, 408407, 408408, 408501, 408502, 408503, 408504, 408505, 408506, 408507, 408508, 408601, 408602, 408603, 408604, 408605, 408606, 408607, 408608, 408801, 408802, 408803, 408804, 408805, 408806, 408807, 408808, 408901, 408902, 408903, 408904, 408905, 408906, 408907, 408908, 409001, 409002, 409003, 409004, 409005, 409006, 409007, 409008, 409101, 409102, 409103, 409104, 409105, 409106, 409107, 409108, 409201, 409202, 409203, 409204, 409205, 409206, 409207, 409208, 409301, 409302, 409303, 409304, 409305, 409306, 409307, 409308, 409401, 409402, 409403, 409404, 409405, 409406, 409407, 409408, 409501, 409502, 409503, 409504, 409505, 409506, 409507, 409508, 409701, 409702, 409703, 409704, 409705, 409706, 409707, 409708, 409801, 409802, 409803, 409804, 409805, 409806, 409807, 409808, 409901, 409902, 409903, 409904, 409905, 409906, 409907, 409908, 410001, 410002, 410003, 410004, 410005, 410006, 410007, 410008, 410101, 410102, 410103, 410104, 410105, 410106, 410107, 410108, 410201, 410202, 410203, 410204, 410205, 410206, 410207, 410208, 410301, 410302, 410303, 410304, 410305, 410306, 410307, 410308, 410401, 410402, 410403, 410404, 410405, 410406, 410407, 410408, 410501, 410502, 410503, 410504, 410505, 410506, 410507, 410508, 410601, 410602, 410603, 410604, 410605, 410606, 410607, 410608, 410701, 410702, 410703, 410704, 410705, 410706, 410707, 410708, 410801, 410802, 410803, 410804, 410805, 410806, 410807, 410808, 410901, 410902, 410903, 410904, 410905, 410906, 410907, 410908, 411001, 411002, 411003, 411004, 411005, 411006, 411007, 411008, 411101, 411102, 411103, 411104, 411105, 411106, 411107, 411108, 411201, 411202, 411203, 411204, 411205, 411206, 411207, 411208, 411301, 411302, 411303, 411304, 411305, 411306, 411307, 411308, 411501, 411502, 411503, 411504, 411505, 411506, 411507, 411508, 411601, 411602, 411603, 411604, 411605, 411606, 411607, 411608, 411701, 411702, 411703, 411704, 411705, 411706, 411707, 411708, 411801, 411802, 411803, 411804, 411805, 411806, 411807, 411808, 411901, 411902, 411903, 411904, 411905, 411906, 411907, 411908, 412001, 412002, 412003, 412004, 412005, 412006, 412007, 412008, 412101, 412102, 412103, 412104, 412105, 412106, 412107, 412108, 412201, 412202, 412203, 412204, 412205, 412206, 412207, 412208, 412301, 412302, 412303, 412304, 412305, 412306, 412307, 412308, 412401, 412402, 412403, 412404, 412405, 412406, 412407, 412408, 412601, 412602, 412603, 412604, 412605, 412606, 412607, 412608, 413001, 413002, 413003, 413004, 413005, 413006, 413007, 413008, 500101, 500102, 500201, 500202, 500301, 500302, 500401, 500402, 500501, 500504, 500601, 500602, 500603, 500604, 500605, 500606, 500701, 500702, 500703, 500704, 500705, 500706, 500801, 500802, 500901, 500902, 501001, 501002, 501101, 501102, 501201, 501202, 501301, 501302, 501401, 501402, 501501, 501502, 501601, 501602, 501701, 501702, 501801, 501802, 501901, 501902, 502001, 502002, 502003, 502004, 502005, 502006, 502101, 502102, 502103, 502104, 502105, 502106, 502201, 502202, 502301, 502302, 502401, 502402, 502501, 502502, 502601, 502602, 502603, 502604, 502605, 502606, 502701, 502702, 502801, 502802, 502901, 502902, 503001, 503002, 503201, 503202, 503301, 503302, 503401, 503402, 503501, 503502, 503601, 503602, 503801, 503802, 503901, 503902, 503903, 503904, 503905, 503906, 503907, 503908, 504101, 504102, 504201, 504202, 504301, 504302, 504401, 504402, 504403, 504404, 504405, 504406, 504501, 504502, 504505, 504506, 504701, 504702, 504801, 504802, 504901, 504902, 505001, 505002, 505003, 505004, 505005, 505006, 505007, 505101, 505102, 505201, 505202, 505301, 505302, 505401, 505402, 505403, 505404, 505405, 505406, 505501, 505502, 505601, 505602, 505701, 505702, 505801, 505802, 505803, 505804, 505805, 505806, 505807, 505901, 505902, 506001, 506002, 506003, 506004, 506005, 506006, 506007, 506101, 506102, 506201, 506202, 506203, 506204, 506205, 506206, 506207, 506301, 506302, 506401, 506402, 506403, 506404, 506405, 506406, 506407, 506501, 506502, 506601, 506602, 506603, 506604, 506605, 506606, 506607, 506701, 506702, 506703, 506704, 506705, 506706, 506801, 506802, 506803, 506804, 506805, 506806, 506901, 506902, 507001, 507002, 507101, 507102, 507201, 507202, 507301, 507302, 507401, 507402, 507501, 507502, 507601, 507602, 507801, 507802, 507901, 507902, 508001, 508002, 508101, 508102, 508201, 508202, 508301, 508302, 508401, 508402, 508501, 508502, 508601, 508602, 508801, 508802, 508901, 508902, 509001, 509002, 509101, 509102, 509201, 509202, 509301, 509302, 509401, 509402, 509501, 509502, 509701, 509702, 509801, 509802, 509901, 509902, 510001, 510002, 510101, 510102, 510201, 510202, 510301, 510302, 510401, 510402, 510501, 510502, 510601, 510602, 510701, 510702, 510703, 510704, 510801, 510802, 510901, 510902, 511001, 511002, 511101, 511102, 511201, 511202, 511301, 511302, 511501, 511502, 511601, 511602, 511701, 511702, 511801, 511802, 511901, 511902, 512001, 512002, 512101, 512102, 512201, 512202, 512301, 512302, 512401, 512402, 512601, 512602, 513001, 513002, 6000101, 6000102, 6000103, 6000104, 6000105, 6000201, 6000202, 6000203, 6000204, 6000205, 6000301, 6000302, 6000303, 6000304, 6000305, 6000401, 6000402, 6000403, 6000404, 6000405, 6000501, 6000502, 6000503, 6000504, 6000505, 6000601, 6000602, 6000603, 6000604, 6000605, 6001101, 6001102, 6001103, 6001104, 6001105, 6002101, 6002102, 6002103, 6002104, 6002105, 6002201, 6002202, 6002203, 6002204, 6002205, 6003101, 6003102, 6003103, 6003104, 6003105, 6003201, 6003202, 6003203, 6003204, 6003205, 6004101, 6004102, 6004103, 6004104, 6004105, 6004201, 6004202, 6004203, 6004204, 6004205, 6005101, 6005102, 6005103, 6005104, 6005105, 6005201, 6005202, 6005203, 6005204, 6005205, 6006101, 6006102, 6006103, 6006104, 6006105, 6006201, 6006202, 6006203, 6006204, 6006205, 6007101, 6007102, 6007103, 6007104, 6007105, 6007201, 6007202, 6007203, 6007204, 6007205, 6008101, 6008102, 6008103, 6008104, 6008105, 6008201, 6008202, 6008203, 6008204, 6008205, 6009101, 6009102, 6009103, 6009104, 6009105, 6009201, 6009202, 6009203, 6009204, 6009205, 6010101, 6010102, 6010103, 6010104, 6010105, 6010201, 6010202, 6010203, 6010204, 6010205, 6011101, 6011102, 6011103, 6011104, 6011105, 6011201, 6011202, 6011203, 6011204, 6011205, 6012101, 6012102, 6012103, 6012104, 6012105, 6012201, 6012202, 6012203, 6012204, 6012205, 6013101, 6013102, 6013103, 6013104, 6013105, 6013201, 6013202, 6013203, 6013204, 6013205, 6014101, 6014102, 6014103, 6014104, 6014105, 6014201, 6014202, 6014203, 6014204, 6014205, 6014301, 6014302, 6014303, 6014304, 6014305, 6014401, 6014402, 6014403, 6014404, 6014405, 6015101, 6015102, 6015103, 6015104, 6015105, 6015201, 6015202, 6015203, 6015204, 6015205, 6016101, 6016102, 6016103, 6016104, 6016105, 6016201, 6016202, 6016203, 6016204, 6016205, 6017101, 6017102, 6017103, 6017104, 6017105, 6017201, 6017202, 6017203, 6017204, 6017205, 6018101, 6018102, 6018103, 6018104, 6018105, 6018201, 6018202, 6018203, 6018204, 6018205, 6019101, 6019102, 6019103, 6019104, 6019105, 6019201, 6019202, 6019203, 6019204, 6019205, 6020101, 6020102, 6020103, 6020104, 6020105, 6020201, 6020202, 6020203, 6020204, 6020205, 6021101, 6021102, 6021103, 6021104, 6021105, 6021106, 6021201, 6021202, 6021203, 6021204, 6021205, 6022101, 6022102, 6022103, 6022104, 6022105, 6022201, 6022202, 6022203, 6022204, 6022205, 6023101, 6023102, 6023103, 6023104, 6023105, 6023201, 6023202, 6023203, 6023204, 6023205, 6024101, 6024102, 6024103, 6024104, 6024105, 6024201, 6024202, 6024203, 6024204, 6024205, 6025101, 6025102, 6025103, 6025104, 6025105, 6025201, 6025202, 6025203, 6025204, 6025205, 6025401, 6025402, 6025403, 6025404, 6025405, 6026101, 6026102, 6026103, 6026104, 6026105, 6026201, 6026202, 6026203, 6026204, 6026205, 6027101, 6027102, 6027103, 6027104, 6027105, 6027201, 6027202, 6027203, 6027204, 6027205, 6028101, 6028102, 6028103, 6028104, 6028105, 6028201, 6028202, 6028203, 6028204, 6028205, 6029101, 6029102, 6029103, 6029104, 6029105, 6029201, 6029202, 6029203, 6029204, 6029205, 6030101, 6030102, 6030103, 6030104, 6030105, 6030201, 6030202, 6030203, 6030204, 6030205, 6032101, 6032102, 6032103, 6032104, 6032105, 6032201, 6032202, 6032203, 6032204, 6032205, 6033101, 6033102, 6033103, 6033104, 6033105, 6033201, 6033202, 6033203, 6033204, 6033205, 6034101, 6034102, 6034103, 6034104, 6034105, 6034201, 6034202, 6034203, 6034204, 6034205, 6035101, 6035102, 6035103, 6035104, 6035105, 6035201, 6035202, 6035203, 6035204, 6035205, 6036101, 6036102, 6036103, 6036104, 6036105, 6036201, 6036202, 6036203, 6036204, 6036205, 6038101, 6038102, 6038103, 6038104, 6038105, 6038201, 6038202, 6038203, 6038204, 6038205, 6038701, 6038702, 6038703, 6038704, 6038705, 6038801, 6038802, 6038803, 6038804, 6038805, 6039101, 6039102, 6039103, 6039104, 6039105, 6039201, 6039202, 6039203, 6039204, 6039205, 6041101, 6041102, 6041103, 6041104, 6041105, 6041201, 6041202, 6041203, 6041204, 6041205, 6042101, 6042102, 6042103, 6042104, 6042105, 6042201, 6042202, 6042203, 6042204, 6042205, 6043101, 6043102, 6043103, 6043104, 6043105, 6043201, 6043202, 6043203, 6043204, 6043205, 6044101, 6044102, 6044103, 6044104, 6044105, 6044201, 6044202, 6044203, 6044204, 6044205, 6045101, 6045102, 6045103, 6045104, 6045105, 6045201, 6045202, 6045203, 6045204, 6045205, 6047101, 6047102, 6047103, 6047104, 6047105, 6047201, 6047202, 6047203, 6047204, 6047205, 6048101, 6048102, 6048103, 6048104, 6048105, 6048201, 6048202, 6048203, 6048204, 6048205, 6049101, 6049102, 6049103, 6049104, 6049105, 6049201, 6049202, 6049203, 6049204, 6049205, 6051101, 6051102, 6051103, 6051104, 6051105, 6051201, 6051202, 6051203, 6051204, 6051205, 6052101, 6052102, 6052103, 6052104, 6052105, 6052201, 6052202, 6052203, 6052204, 6052205, 6053101, 6053102, 6053103, 6053104, 6053105, 6053201, 6053202, 6053203, 6053204, 6053205, 6054101, 6054102, 6054103, 6054104, 6054105, 6054201, 6054202, 6054203, 6054204, 6054205, 6055101, 6055102, 6055103, 6055104, 6055105, 6055201, 6055202, 6055203, 6055204, 6055205, 6056101, 6056102, 6056103, 6056104, 6056105, 6056201, 6056202, 6056203, 6056204, 6056205, 6057101, 6057102, 6057103, 6057104, 6057105, 6057201, 6057202, 6057203, 6057204, 6057205, 6059101, 6059102, 6059103, 6059104, 6059105, 6059201, 6059202, 6059203, 6059204, 6059205, 6060101, 6060102, 6060103, 6060104, 6060105, 6060201, 6060202, 6060203, 6060204, 6060205, 6061101, 6061102, 6061103, 6061104, 6061105, 6061201, 6061202, 6061203, 6061204, 6061205, 6063101, 6063102, 6063103, 6063104, 6063105, 6063201, 6063202, 6063203, 6063204, 6063205, 6064101, 6064102, 6064103, 6064104, 6064105, 6064201, 6064202, 6064203, 6064204, 6064205, 6065101, 6065102, 6065103, 6065104, 6065105, 6065201, 6065202, 6065203, 6065204, 6065205, 6066101, 6066102, 6066103, 6066104, 6066105, 6066201, 6066202, 6066203, 6066204, 6066205, 6067101, 6067102, 6067103, 6067104, 6067105, 6067201, 6067202, 6067203, 6067204, 6067205, 6068101, 6068102, 6068103, 6068104, 6068105, 6068201, 6068202, 6068203, 6068204, 6068205, 6069101, 6069102, 6069103, 6069104, 6069105, 6069201, 6069202, 6069203, 6069204, 6069205, 6070101, 6070102, 6070103, 6070104, 6070105, 6070201, 6070202, 6070203, 6070204, 6070205, 6070401, 6070402, 6070403, 6070404, 6070405, 6071101, 6071102, 6071103, 6071104, 6071105, 6071201, 6071202, 6071203, 6071204, 6071205, 6072101, 6072102, 6072103, 6072104, 6072105, 6072201, 6072202, 6072203, 6072204, 6072205, 6073101, 6073102, 6073103, 6073104, 6073105, 6073201, 6073202, 6073203, 6073204, 6073205, 6074101, 6074102, 6074103, 6074104, 6074105, 6074201, 6074202, 6074203, 6074204, 6074205, 6075101, 6075102, 6075103, 6075104, 6075105, 6075201, 6075202, 6075203, 6075204, 6075205, 6076101, 6076102, 6076103, 6076104, 6076105, 6076201, 6076202, 6076203, 6076204, 6076205, 6078101, 6078102, 6078103, 6078104, 6078105, 6078201, 6078202, 6078203, 6078204, 6078205, 6079101, 6079102, 6079103, 6079104, 6079105, 6079201, 6079202, 6079203, 6079204, 6079205, 6080101, 6080102, 6080103, 6080104, 6080105, 6080201, 6080202, 6080203, 6080204, 6080205, 6081101, 6081102, 6081103, 6081104, 6081105, 6081201, 6081202, 6081203, 6081204, 6081205, 6082101, 6082102, 6082103, 6082104, 6082105, 6082201, 6082202, 6082203, 6082204, 6082205, 6083101, 6083102, 6083103, 6083104, 6083105, 6083201, 6083202, 6083203, 6083204, 6083205, 6084101, 6084102, 6084103, 6084104, 6084105, 6084201, 6084202, 6084203, 6084204, 6084205, 6085101, 6085102, 6085103, 6085104, 6085105, 6085201, 6085202, 6085203, 6085204, 6085205, 6086101, 6086102, 6086103, 6086104, 6086105, 6086201, 6086202, 6086203, 6086204, 6086205, 6088101, 6088102, 6088103, 6088104, 6088105, 6088201, 6088202, 6088203, 6088204, 6088205, 6089101, 6089102, 6089103, 6089104, 6089105, 6089201, 6089202, 6089203, 6089204, 6089205, 6090101, 6090102, 6090103, 6090104, 6090105, 6090201, 6090202, 6090203, 6090204, 6090205, 6091101, 6091102, 6091103, 6091104, 6091105, 6091201, 6091202, 6091203, 6091204, 6091205, 6092101, 6092102, 6092103, 6092104, 6092105, 6092201, 6092202, 6092203, 6092204, 6092205, 6093101, 6093102, 6093103, 6093104, 6093105, 6093201, 6093202, 6093203, 6093204, 6093205, 6094101, 6094102, 6094103, 6094104, 6094105, 6094201, 6094202, 6094203, 6094204, 6094205, 6095101, 6095102, 6095103, 6095104, 6095105, 6095201, 6095202, 6095203, 6095204, 6095205, 6097101, 6097102, 6097103, 6097104, 6097105, 6097201, 6097202, 6097203, 6097204, 6097205, 6098101, 6098102, 6098103, 6098104, 6098105, 6098201, 6098202, 6098203, 6098204, 6098205, 6099101, 6099102, 6099103, 6099104, 6099105, 6099201, 6099202, 6099203, 6099204, 6099205, 6100101, 6100102, 6100103, 6100104, 6100105, 6100201, 6100202, 6100203, 6100204, 6100205, 6101101, 6101102, 6101103, 6101104, 6101105, 6101201, 6101202, 6101203, 6101204, 6101205, 6102101, 6102102, 6102103, 6102104, 6102105, 6102201, 6102202, 6102203, 6102204, 6102205, 6103101, 6103102, 6103103, 6103104, 6103105, 6103201, 6103202, 6103203, 6103204, 6103205, 6104101, 6104102, 6104103, 6104104, 6104105, 6104201, 6104202, 6104203, 6104204, 6104205, 6105101, 6105102, 6105103, 6105104, 6105105, 6105201, 6105202, 6105203, 6105204, 6105205, 6106101, 6106102, 6106103, 6106104, 6106105, 6106201, 6106202, 6106203, 6106204, 6106205, 6107101, 6107102, 6107103, 6107104, 6107105, 6107201, 6107202, 6107203, 6107204, 6107205, 6109101, 6109102, 6109103, 6109104, 6109105, 6109201, 6109202, 6109203, 6109204, 6109205, 6111101, 6111102, 6111103, 6111104, 6111105, 6111201, 6111202, 6111203, 6111204, 6111205, 6112101, 6112102, 6112103, 6112104, 6112105, 6112201, 6112202, 6112203, 6112204, 6112205, 6113101, 6113102, 6113103, 6113104, 6113105, 6113201, 6113202, 6113203, 6113204, 6113205, 6115101, 6115102, 6115103, 6115104, 6115105, 6115201, 6115202, 6115203, 6115204, 6115205, 6116101, 6116102, 6116103, 6116104, 6116105, 6116201, 6116202, 6116203, 6116204, 6116205, 6117101, 6117102, 6117103, 6117104, 6117105, 6117201, 6117202, 6117203, 6117204, 6117205, 6118101, 6118102, 6118103, 6118104, 6118105, 6118201, 6118202, 6118203, 6118204, 6118205, 6119101, 6119102, 6119103, 6119104, 6119105, 6119201, 6119202, 6119203, 6119204, 6119205, 6120101, 6120102, 6120103, 6120104, 6120105, 6120201, 6120202, 6120203, 6120204, 6120205, 6121101, 6121102, 6121103, 6121104, 6121105, 6121201, 6121202, 6121203, 6121204, 6121205, 6122101, 6122102, 6122103, 6122104, 6122105, 6122201, 6122202, 6122203, 6122204, 6122205, 6123101, 6123102, 6123103, 6123104, 6123105, 6123201, 6123202, 6123203, 6123204, 6123205, 6124101, 6124102, 6124103, 6124104, 6124105, 6124201, 6124202, 6124203, 6124204, 6124205, 6126101, 6126102, 6126103, 6126104, 6126105, 6126201, 6126202, 6126203, 6126204, 6126205, 6130101, 6130102, 6130103, 6130104, 6130105, 6130201, 6130202, 6130203, 6130204, 6130205, 60108101, 60108102, 60108103, 60108104, 60108105, 60108201, 60108202, 60108203, 60108204, 60108205, 60110101, 60110102, 60110103, 60110104, 60110105, 60110201, 60110202, 60110203, 60110204, 60110205, 60381301, 60381302, 60381303, 60381304, 60381305}
return cskillshow_common

