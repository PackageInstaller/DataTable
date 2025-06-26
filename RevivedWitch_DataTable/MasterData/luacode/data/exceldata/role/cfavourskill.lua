-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/role/cfavourskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cfavourskill = {}
cfavourskill.Data = {
[21] = {id = 21, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[22] = {id = 22, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[23] = {id = 23, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[24] = {id = 24, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[31] = {id = 31, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>64</color>", skillattributiontxt = 302841}
, 
[32] = {id = 32, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>64</color>", skillattributiontxt = 302842}
, 
[33] = {id = 33, skillattribution = "生命强化   生命增加<color=#82C65D>1360</color>", skillattributiontxt = 302843}
, 
[34] = {id = 34, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[41] = {id = 41, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>48</color>", skillattributiontxt = 302845}
, 
[42] = {id = 42, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>48</color>", skillattributiontxt = 302846}
, 
[43] = {id = 43, skillattribution = "攻击强化   攻击增加<color=#82C65D>183</color>", skillattributiontxt = 302847}
, 
[44] = {id = 44, skillattribution = "生命强化   生命增加<color=#82C65D>918</color>", skillattributiontxt = 302848}
, 
[51] = {id = 51, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[52] = {id = 52, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[53] = {id = 53, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[54] = {id = 54, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[61] = {id = 61, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[62] = {id = 62, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[63] = {id = 63, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[64] = {id = 64, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[71] = {id = 71, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>61</color>", skillattributiontxt = 302853}
, 
[72] = {id = 72, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>61</color>", skillattributiontxt = 302854}
, 
[73] = {id = 73, skillattribution = "生命强化   生命增加<color=#82C65D>1285</color>", skillattributiontxt = 302855}
, 
[74] = {id = 74, skillattribution = "攻击强化   攻击增加<color=#82C65D>260</color>", skillattributiontxt = 302856}
, 
[81] = {id = 81, skillattribution = "攻击强化   攻击增加<color=#82C65D>144</color>", skillattributiontxt = 302857}
, 
[82] = {id = 82, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>144</color>", skillattributiontxt = 302858}
, 
[83] = {id = 83, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>144</color>", skillattributiontxt = 302859}
, 
[84] = {id = 84, skillattribution = "生命强化   生命增加<color=#82C65D>2160</color>", skillattributiontxt = 302860}
, 
[91] = {id = 91, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>48</color>", skillattributiontxt = 302845}
, 
[92] = {id = 92, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>48</color>", skillattributiontxt = 302846}
, 
[93] = {id = 93, skillattribution = "攻击强化   攻击增加<color=#82C65D>183</color>", skillattributiontxt = 302847}
, 
[94] = {id = 94, skillattribution = "生命强化   生命增加<color=#82C65D>918</color>", skillattributiontxt = 302848}
, 
[101] = {id = 101, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[102] = {id = 102, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[103] = {id = 103, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[104] = {id = 104, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[111] = {id = 111, skillattribution = "攻击强化   攻击增加<color=#82C65D>144</color>", skillattributiontxt = 302857}
, 
[112] = {id = 112, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>144</color>", skillattributiontxt = 302859}
, 
[113] = {id = 113, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>144</color>", skillattributiontxt = 302858}
, 
[114] = {id = 114, skillattribution = "生命强化   生命增加<color=#82C65D>2160</color>", skillattributiontxt = 302860}
, 
[121] = {id = 121, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[122] = {id = 122, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[123] = {id = 123, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[124] = {id = 124, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[131] = {id = 131, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>43</color>", skillattributiontxt = 302866}
, 
[132] = {id = 132, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>43</color>", skillattributiontxt = 302867}
, 
[133] = {id = 133, skillattribution = "生命强化   生命增加<color=#82C65D>864</color>", skillattributiontxt = 302868}
, 
[134] = {id = 134, skillattribution = "攻击强化   攻击增加<color=#82C65D>360</color>", skillattributiontxt = 302869}
, 
[141] = {id = 141, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>38</color>", skillattributiontxt = 302870}
, 
[142] = {id = 142, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>38</color>", skillattributiontxt = 302871}
, 
[143] = {id = 143, skillattribution = "生命强化   生命增加<color=#82C65D>777</color>", skillattributiontxt = 302872}
, 
[144] = {id = 144, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[151] = {id = 151, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[152] = {id = 152, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[153] = {id = 153, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[154] = {id = 154, skillattribution = "攻击强化   攻击增加<color=#82C65D>291</color>", skillattributiontxt = 302873}
, 
[161] = {id = 161, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>64</color>", skillattributiontxt = 302842}
, 
[162] = {id = 162, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>64</color>", skillattributiontxt = 302841}
, 
[163] = {id = 163, skillattribution = "生命强化   生命增加<color=#82C65D>1360</color>", skillattributiontxt = 302843}
, 
[164] = {id = 164, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[171] = {id = 171, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[172] = {id = 172, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[173] = {id = 173, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[174] = {id = 174, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[181] = {id = 181, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[182] = {id = 182, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[183] = {id = 183, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[184] = {id = 184, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[191] = {id = 191, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[192] = {id = 192, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[193] = {id = 193, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[194] = {id = 194, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[201] = {id = 201, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>61</color>", skillattributiontxt = 302853}
, 
[202] = {id = 202, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>61</color>", skillattributiontxt = 302854}
, 
[203] = {id = 203, skillattribution = "生命强化   生命增加<color=#82C65D>1285</color>", skillattributiontxt = 302855}
, 
[204] = {id = 204, skillattribution = "攻击强化   攻击增加<color=#82C65D>260</color>", skillattributiontxt = 302856}
, 
[211] = {id = 211, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>61</color>", skillattributiontxt = 302853}
, 
[212] = {id = 212, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>61</color>", skillattributiontxt = 302854}
, 
[213] = {id = 213, skillattribution = "生命强化   生命增加<color=#82C65D>1285</color>", skillattributiontxt = 302855}
, 
[214] = {id = 214, skillattribution = "攻击强化   攻击增加<color=#82C65D>260</color>", skillattributiontxt = 302856}
, 
[221] = {id = 221, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[222] = {id = 222, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[223] = {id = 223, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[224] = {id = 224, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[231] = {id = 231, skillattribution = "攻击强化   攻击增加<color=#82C65D>144</color>", skillattributiontxt = 302857}
, 
[232] = {id = 232, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>144</color>", skillattributiontxt = 302859}
, 
[233] = {id = 233, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>144</color>", skillattributiontxt = 302858}
, 
[234] = {id = 234, skillattribution = "生命强化   生命增加<color=#82C65D>2160</color>", skillattributiontxt = 302860}
, 
[241] = {id = 241, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[242] = {id = 242, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[243] = {id = 243, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[244] = {id = 244, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[251] = {id = 251, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[252] = {id = 252, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[253] = {id = 253, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[254] = {id = 254, skillattribution = "攻击强化   攻击增加<color=#82C65D>307</color>", skillattributiontxt = 302878}
, 
[261] = {id = 261, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>38</color>", skillattributiontxt = 302870}
, 
[262] = {id = 262, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>38</color>", skillattributiontxt = 302871}
, 
[263] = {id = 263, skillattribution = "生命强化   生命增加<color=#82C65D>777</color>", skillattributiontxt = 302872}
, 
[264] = {id = 264, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[271] = {id = 271, skillattribution = "攻击强化   攻击增加<color=#82C65D>129</color>", skillattributiontxt = 302879}
, 
[272] = {id = 272, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>129</color>", skillattributiontxt = 302880}
, 
[273] = {id = 273, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>129</color>", skillattributiontxt = 302881}
, 
[274] = {id = 274, skillattribution = "生命强化   生命增加<color=#82C65D>1944</color>", skillattributiontxt = 302882}
, 
[281] = {id = 281, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[282] = {id = 282, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[283] = {id = 283, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[284] = {id = 284, skillattribution = "攻击强化   攻击增加<color=#82C65D>307</color>", skillattributiontxt = 302878}
, 
[291] = {id = 291, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>43</color>", skillattributiontxt = 302866}
, 
[292] = {id = 292, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>43</color>", skillattributiontxt = 302867}
, 
[293] = {id = 293, skillattribution = "生命强化   生命增加<color=#82C65D>864</color>", skillattributiontxt = 302868}
, 
[294] = {id = 294, skillattribution = "攻击强化   攻击增加<color=#82C65D>360</color>", skillattributiontxt = 302869}
, 
[301] = {id = 301, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[302] = {id = 302, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[303] = {id = 303, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[304] = {id = 304, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[321] = {id = 321, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>38</color>", skillattributiontxt = 302870}
, 
[322] = {id = 322, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>38</color>", skillattributiontxt = 302871}
, 
[323] = {id = 323, skillattribution = "生命强化   生命增加<color=#82C65D>777</color>", skillattributiontxt = 302872}
, 
[324] = {id = 324, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[331] = {id = 331, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[332] = {id = 332, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[333] = {id = 333, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[334] = {id = 334, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[341] = {id = 341, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>41</color>", skillattributiontxt = 302883}
, 
[342] = {id = 342, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>41</color>", skillattributiontxt = 302884}
, 
[343] = {id = 343, skillattribution = "生命强化   生命增加<color=#82C65D>820</color>", skillattributiontxt = 302885}
, 
[344] = {id = 344, skillattribution = "攻击强化   攻击增加<color=#82C65D>342</color>", skillattributiontxt = 302886}
, 
[351] = {id = 351, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[352] = {id = 352, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[353] = {id = 353, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[354] = {id = 354, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[361] = {id = 361, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>48</color>", skillattributiontxt = 302845}
, 
[362] = {id = 362, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>48</color>", skillattributiontxt = 302846}
, 
[363] = {id = 363, skillattribution = "生命强化   生命增加<color=#82C65D>918</color>", skillattributiontxt = 302848}
, 
[364] = {id = 364, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[381] = {id = 381, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[382] = {id = 382, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[383] = {id = 383, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[384] = {id = 384, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[391] = {id = 391, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>64</color>", skillattributiontxt = 302842}
, 
[392] = {id = 392, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>64</color>", skillattributiontxt = 302841}
, 
[393] = {id = 393, skillattribution = "生命强化   生命增加<color=#82C65D>1360</color>", skillattributiontxt = 302843}
, 
[394] = {id = 394, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[401] = {id = 401, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[402] = {id = 402, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[403] = {id = 403, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[404] = {id = 404, skillattribution = "攻击强化   攻击增加<color=#82C65D>291</color>", skillattributiontxt = 302873}
, 
[411] = {id = 411, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[412] = {id = 412, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[413] = {id = 413, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[414] = {id = 414, skillattribution = "攻击强化   攻击增加<color=#82C65D>307</color>", skillattributiontxt = 302878}
, 
[421] = {id = 421, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[422] = {id = 422, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[423] = {id = 423, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[424] = {id = 424, skillattribution = "攻击强化   攻击增加<color=#82C65D>307</color>", skillattributiontxt = 302878}
, 
[431] = {id = 431, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[432] = {id = 432, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[433] = {id = 433, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[434] = {id = 434, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[441] = {id = 441, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>48</color>", skillattributiontxt = 302845}
, 
[442] = {id = 442, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>48</color>", skillattributiontxt = 302846}
, 
[443] = {id = 443, skillattribution = "生命强化   生命增加<color=#82C65D>918</color>", skillattributiontxt = 302848}
, 
[444] = {id = 444, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[451] = {id = 451, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[452] = {id = 452, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[453] = {id = 453, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[454] = {id = 454, skillattribution = "攻击强化   攻击增加<color=#82C65D>291</color>", skillattributiontxt = 302873}
, 
[461] = {id = 461, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>64</color>", skillattributiontxt = 302841}
, 
[462] = {id = 462, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>64</color>", skillattributiontxt = 302842}
, 
[463] = {id = 463, skillattribution = "生命强化   生命增加<color=#82C65D>1360</color>", skillattributiontxt = 302843}
, 
[464] = {id = 464, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[471] = {id = 471, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>41</color>", skillattributiontxt = 302883}
, 
[472] = {id = 472, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>41</color>", skillattributiontxt = 302884}
, 
[473] = {id = 473, skillattribution = "生命强化   生命增加<color=#82C65D>820</color>", skillattributiontxt = 302885}
, 
[474] = {id = 474, skillattribution = "攻击强化   攻击增加<color=#82C65D>342</color>", skillattributiontxt = 302886}
, 
[481] = {id = 481, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>68</color>", skillattributiontxt = 302887}
, 
[482] = {id = 482, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>68</color>", skillattributiontxt = 302888}
, 
[483] = {id = 483, skillattribution = "生命强化   生命增加<color=#82C65D>1436</color>", skillattributiontxt = 302889}
, 
[484] = {id = 484, skillattribution = "攻击强化   攻击增加<color=#82C65D>290</color>", skillattributiontxt = 302890}
, 
[491] = {id = 491, skillattribution = "攻击强化   攻击增加<color=#82C65D>129</color>", skillattributiontxt = 302879}
, 
[492] = {id = 492, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>129</color>", skillattributiontxt = 302881}
, 
[493] = {id = 493, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>129</color>", skillattributiontxt = 302880}
, 
[494] = {id = 494, skillattribution = "生命强化   生命增加<color=#82C65D>1944</color>", skillattributiontxt = 302882}
, 
[501] = {id = 501, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[502] = {id = 502, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[503] = {id = 503, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[504] = {id = 504, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[511] = {id = 511, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[512] = {id = 512, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[513] = {id = 513, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[514] = {id = 514, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[521] = {id = 521, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[522] = {id = 522, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[523] = {id = 523, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[524] = {id = 524, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[531] = {id = 531, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[532] = {id = 532, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[533] = {id = 533, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[534] = {id = 534, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[541] = {id = 541, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[542] = {id = 542, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[543] = {id = 543, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[544] = {id = 544, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[551] = {id = 551, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>41</color>", skillattributiontxt = 302883}
, 
[552] = {id = 552, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>41</color>", skillattributiontxt = 302884}
, 
[553] = {id = 553, skillattribution = "生命强化   生命增加<color=#82C65D>820</color>", skillattributiontxt = 302885}
, 
[554] = {id = 554, skillattribution = "攻击强化   攻击增加<color=#82C65D>342</color>", skillattributiontxt = 302886}
, 
[561] = {id = 561, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[562] = {id = 562, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[563] = {id = 563, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[564] = {id = 564, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[571] = {id = 571, skillattribution = "攻击强化   攻击增加<color=#82C65D>122</color>", skillattributiontxt = 302891}
, 
[572] = {id = 572, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>122</color>", skillattributiontxt = 302892}
, 
[573] = {id = 573, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>122</color>", skillattributiontxt = 302893}
, 
[574] = {id = 574, skillattribution = "生命强化   生命增加<color=#82C65D>1836</color>", skillattributiontxt = 302894}
, 
[581] = {id = 581, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>38</color>", skillattributiontxt = 302870}
, 
[582] = {id = 582, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>38</color>", skillattributiontxt = 302871}
, 
[583] = {id = 583, skillattribution = "生命强化   生命增加<color=#82C65D>777</color>", skillattributiontxt = 302872}
, 
[584] = {id = 584, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[591] = {id = 591, skillattribution = "攻击强化   攻击增加<color=#82C65D>136</color>", skillattributiontxt = 302895}
, 
[592] = {id = 592, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>136</color>", skillattributiontxt = 302896}
, 
[593] = {id = 593, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>136</color>", skillattributiontxt = 302897}
, 
[594] = {id = 594, skillattribution = "生命强化   生命增加<color=#82C65D>2052</color>", skillattributiontxt = 302898}
, 
[601] = {id = 601, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[602] = {id = 602, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[603] = {id = 603, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[604] = {id = 604, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[611] = {id = 611, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>68</color>", skillattributiontxt = 302887}
, 
[612] = {id = 612, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>68</color>", skillattributiontxt = 302888}
, 
[613] = {id = 613, skillattribution = "生命强化   生命增加<color=#82C65D>1436</color>", skillattributiontxt = 302889}
, 
[614] = {id = 614, skillattribution = "攻击强化   攻击增加<color=#82C65D>290</color>", skillattributiontxt = 302890}
, 
[621] = {id = 621, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[622] = {id = 622, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[623] = {id = 623, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[624] = {id = 624, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[631] = {id = 631, skillattribution = "攻击强化   攻击增加<color=#82C65D>144</color>", skillattributiontxt = 302857}
, 
[632] = {id = 632, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>144</color>", skillattributiontxt = 302858}
, 
[633] = {id = 633, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>144</color>", skillattributiontxt = 302859}
, 
[634] = {id = 634, skillattribution = "生命强化   生命增加<color=#82C65D>2160</color>", skillattributiontxt = 302860}
, 
[641] = {id = 641, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>38</color>", skillattributiontxt = 302870}
, 
[642] = {id = 642, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>38</color>", skillattributiontxt = 302871}
, 
[643] = {id = 643, skillattribution = "生命强化   生命增加<color=#82C65D>777</color>", skillattributiontxt = 302872}
, 
[644] = {id = 644, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[651] = {id = 651, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[652] = {id = 652, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[653] = {id = 653, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[654] = {id = 654, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[661] = {id = 661, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[662] = {id = 662, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[663] = {id = 663, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[664] = {id = 664, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[671] = {id = 671, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302841}
, 
[672] = {id = 672, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302842}
, 
[673] = {id = 673, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302843}
, 
[674] = {id = 674, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302844}
, 
[681] = {id = 681, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>48</color>", skillattributiontxt = 302846}
, 
[682] = {id = 682, skillattribution = "生命强化   生命增加<color=#82C65D>918</color>", skillattributiontxt = 302848}
, 
[683] = {id = 683, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>48</color>", skillattributiontxt = 302845}
, 
[684] = {id = 684, skillattribution = "攻击强化   攻击增加<color=#82C65D>183</color>", skillattributiontxt = 302847}
, 
[691] = {id = 691, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[692] = {id = 692, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[693] = {id = 693, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[694] = {id = 694, skillattribution = "攻击强化   攻击增加<color=#82C65D>307</color>", skillattributiontxt = 302878}
, 
[701] = {id = 701, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[702] = {id = 702, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[703] = {id = 703, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[704] = {id = 704, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[711] = {id = 711, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[712] = {id = 712, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[713] = {id = 713, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[714] = {id = 714, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[721] = {id = 721, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[722] = {id = 722, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[723] = {id = 723, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[724] = {id = 724, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[731] = {id = 731, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[732] = {id = 732, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[733] = {id = 733, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[734] = {id = 734, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[741] = {id = 741, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>64</color>", skillattributiontxt = 302841}
, 
[742] = {id = 742, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>64</color>", skillattributiontxt = 302842}
, 
[743] = {id = 743, skillattribution = "生命强化   生命增加<color=#82C65D>1360</color>", skillattributiontxt = 302843}
, 
[744] = {id = 744, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[751] = {id = 751, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>61</color>", skillattributiontxt = 302853}
, 
[752] = {id = 752, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>61</color>", skillattributiontxt = 302854}
, 
[753] = {id = 753, skillattribution = "生命强化   生命增加<color=#82C65D>1285</color>", skillattributiontxt = 302855}
, 
[754] = {id = 754, skillattribution = "攻击强化   攻击增加<color=#82C65D>260</color>", skillattributiontxt = 302856}
, 
[761] = {id = 761, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[762] = {id = 762, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[763] = {id = 763, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[764] = {id = 764, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[781] = {id = 781, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>64</color>", skillattributiontxt = 302841}
, 
[782] = {id = 782, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>64</color>", skillattributiontxt = 302842}
, 
[783] = {id = 783, skillattribution = "生命强化   生命增加<color=#82C65D>1360</color>", skillattributiontxt = 302843}
, 
[784] = {id = 784, skillattribution = "攻击强化   攻击增加<color=#82C65D>275</color>", skillattributiontxt = 302844}
, 
[791] = {id = 791, skillattribution = "攻击强化   攻击增加<color=#82C65D>129</color>", skillattributiontxt = 302879}
, 
[792] = {id = 792, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>129</color>", skillattributiontxt = 302881}
, 
[793] = {id = 793, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>129</color>", skillattributiontxt = 302880}
, 
[794] = {id = 794, skillattribution = "生命强化   生命增加<color=#82C65D>1944</color>", skillattributiontxt = 302882}
, 
[801] = {id = 801, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[802] = {id = 802, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[803] = {id = 803, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[804] = {id = 804, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[811] = {id = 811, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[812] = {id = 812, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[813] = {id = 813, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[814] = {id = 814, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[821] = {id = 821, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[822] = {id = 822, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[823] = {id = 823, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[824] = {id = 824, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[831] = {id = 831, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[832] = {id = 832, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[833] = {id = 833, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[834] = {id = 834, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[841] = {id = 841, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>43</color>", skillattributiontxt = 302866}
, 
[842] = {id = 842, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>43</color>", skillattributiontxt = 302867}
, 
[843] = {id = 843, skillattribution = "生命强化   生命增加<color=#82C65D>864</color>", skillattributiontxt = 302868}
, 
[844] = {id = 844, skillattribution = "攻击强化   攻击增加<color=#82C65D>360</color>", skillattributiontxt = 302869}
, 
[851] = {id = 851, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[852] = {id = 852, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[853] = {id = 853, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[854] = {id = 854, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[861] = {id = 861, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>43</color>", skillattributiontxt = 302866}
, 
[862] = {id = 862, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>43</color>", skillattributiontxt = 302867}
, 
[863] = {id = 863, skillattribution = "生命强化   生命增加<color=#82C65D>864</color>", skillattributiontxt = 302868}
, 
[864] = {id = 864, skillattribution = "攻击强化   攻击增加<color=#82C65D>360</color>", skillattributiontxt = 302869}
, 
[881] = {id = 881, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[882] = {id = 882, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[883] = {id = 883, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[884] = {id = 884, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[891] = {id = 891, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>61</color>", skillattributiontxt = 302853}
, 
[892] = {id = 892, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>61</color>", skillattributiontxt = 302854}
, 
[893] = {id = 893, skillattribution = "生命强化   生命增加<color=#82C65D>1285</color>", skillattributiontxt = 302855}
, 
[894] = {id = 894, skillattribution = "攻击强化   攻击增加<color=#82C65D>260</color>", skillattributiontxt = 302856}
, 
[901] = {id = 901, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>51</color>", skillattributiontxt = 302837}
, 
[902] = {id = 902, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>51</color>", skillattributiontxt = 302838}
, 
[903] = {id = 903, skillattribution = "攻击强化   攻击增加<color=#82C65D>194</color>", skillattributiontxt = 302839}
, 
[904] = {id = 904, skillattribution = "生命强化   生命增加<color=#82C65D>972</color>", skillattributiontxt = 302840}
, 
[911] = {id = 911, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[912] = {id = 912, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[913] = {id = 913, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[914] = {id = 914, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[921] = {id = 921, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[922] = {id = 922, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[923] = {id = 923, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[924] = {id = 924, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[931] = {id = 931, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[932] = {id = 932, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[933] = {id = 933, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[934] = {id = 934, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[941] = {id = 941, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[942] = {id = 942, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[943] = {id = 943, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[944] = {id = 944, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[951] = {id = 951, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[952] = {id = 952, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[953] = {id = 953, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[954] = {id = 954, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[971] = {id = 971, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[972] = {id = 972, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[973] = {id = 973, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[974] = {id = 974, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[981] = {id = 981, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[982] = {id = 982, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[983] = {id = 983, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[991] = {id = 991, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[992] = {id = 992, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[993] = {id = 993, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[994] = {id = 994, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[1001] = {id = 1001, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1002] = {id = 1002, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1003] = {id = 1003, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[1004] = {id = 1004, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1011] = {id = 1011, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1012] = {id = 1012, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1013] = {id = 1013, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[1014] = {id = 1014, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1021] = {id = 1021, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1022] = {id = 1022, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1023] = {id = 1023, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[1024] = {id = 1024, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1031] = {id = 1031, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[1032] = {id = 1032, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[1033] = {id = 1033, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[1034] = {id = 1034, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[1041] = {id = 1041, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1042] = {id = 1042, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1043] = {id = 1043, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1044] = {id = 1044, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1051] = {id = 1051, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1052] = {id = 1052, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1053] = {id = 1053, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1054] = {id = 1054, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1061] = {id = 1061, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>61</color>", skillattributiontxt = 302853}
, 
[1062] = {id = 1062, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>61</color>", skillattributiontxt = 302854}
, 
[1063] = {id = 1063, skillattribution = "生命强化   生命增加<color=#82C65D>1285</color>", skillattributiontxt = 302855}
, 
[1064] = {id = 1064, skillattribution = "攻击强化   攻击增加<color=#82C65D>260</color>", skillattributiontxt = 302856}
, 
[1071] = {id = 1071, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1072] = {id = 1072, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1073] = {id = 1073, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1074] = {id = 1074, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1081] = {id = 1081, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1082] = {id = 1082, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1083] = {id = 1083, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1084] = {id = 1084, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1091] = {id = 1091, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1092] = {id = 1092, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1093] = {id = 1093, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1094] = {id = 1094, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1101] = {id = 1101, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1102] = {id = 1102, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1103] = {id = 1103, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1104] = {id = 1104, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1111] = {id = 1111, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[1112] = {id = 1112, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[1113] = {id = 1113, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[1114] = {id = 1114, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[1121] = {id = 1121, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1122] = {id = 1122, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1123] = {id = 1123, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1124] = {id = 1124, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1131] = {id = 1131, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1132] = {id = 1132, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1133] = {id = 1133, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1134] = {id = 1134, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1151] = {id = 1151, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>43</color>", skillattributiontxt = 302866}
, 
[1152] = {id = 1152, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>43</color>", skillattributiontxt = 302867}
, 
[1153] = {id = 1153, skillattribution = "生命强化   生命增加<color=#82C65D>864</color>", skillattributiontxt = 302868}
, 
[1154] = {id = 1154, skillattribution = "攻击强化   攻击增加<color=#82C65D>360</color>", skillattributiontxt = 302869}
, 
[1161] = {id = 1161, skillattribution = "攻击强化   攻击增加<color=#82C65D>129</color>", skillattributiontxt = 302879}
, 
[1162] = {id = 1162, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>129</color>", skillattributiontxt = 302881}
, 
[1163] = {id = 1163, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>129</color>", skillattributiontxt = 302880}
, 
[1164] = {id = 1164, skillattribution = "生命强化   生命增加<color=#82C65D>1944</color>", skillattributiontxt = 302882}
, 
[1171] = {id = 1171, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[1172] = {id = 1172, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[1173] = {id = 1173, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[1174] = {id = 1174, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[1181] = {id = 1181, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1182] = {id = 1182, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1183] = {id = 1183, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1184] = {id = 1184, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1191] = {id = 1191, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1192] = {id = 1192, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1193] = {id = 1193, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1194] = {id = 1194, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1201] = {id = 1201, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1202] = {id = 1202, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1203] = {id = 1203, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[1204] = {id = 1204, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1211] = {id = 1211, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1212] = {id = 1212, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1213] = {id = 1213, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1214] = {id = 1214, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1221] = {id = 1221, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>72</color>", skillattributiontxt = 302874}
, 
[1222] = {id = 1222, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>72</color>", skillattributiontxt = 302875}
, 
[1223] = {id = 1223, skillattribution = "生命强化   生命增加<color=#82C65D>1512</color>", skillattributiontxt = 302876}
, 
[1224] = {id = 1224, skillattribution = "攻击强化   攻击增加<color=#82C65D>306</color>", skillattributiontxt = 302877}
, 
[1231] = {id = 1231, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>54</color>", skillattributiontxt = 302849}
, 
[1232] = {id = 1232, skillattribution = "生命强化   生命增加<color=#82C65D>1026</color>", skillattributiontxt = 302850}
, 
[1233] = {id = 1233, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>54</color>", skillattributiontxt = 302851}
, 
[1234] = {id = 1234, skillattribution = "攻击强化   攻击增加<color=#82C65D>205</color>", skillattributiontxt = 302852}
, 
[1241] = {id = 1241, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1242] = {id = 1242, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1243] = {id = 1243, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1244] = {id = 1244, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
, 
[1261] = {id = 1261, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1262] = {id = 1262, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1263] = {id = 1263, skillattribution = "攻击强化   攻击增加<color=#82C65D>216</color>", skillattributiontxt = 302863}
, 
[1264] = {id = 1264, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1301] = {id = 1301, skillattribution = "物理防御强化   物理防御增加<color=#82C65D>57</color>", skillattributiontxt = 302861}
, 
[1302] = {id = 1302, skillattribution = "魔法防御强化   魔法防御增加<color=#82C65D>57</color>", skillattributiontxt = 302862}
, 
[1303] = {id = 1303, skillattribution = "生命强化   生命增加<color=#82C65D>1080</color>", skillattributiontxt = 302864}
, 
[1304] = {id = 1304, skillattribution = "攻击强化   攻击增加<color=#82C65D>324</color>", skillattributiontxt = 302865}
}
cfavourskill.AllIds = {21, 22, 23, 24, 31, 32, 33, 34, 41, 42, 43, 44, 51, 52, 53, 54, 61, 62, 63, 64, 71, 72, 73, 74, 81, 82, 83, 84, 91, 92, 93, 94, 101, 102, 103, 104, 111, 112, 113, 114, 121, 122, 123, 124, 131, 132, 133, 134, 141, 142, 143, 144, 151, 152, 153, 154, 161, 162, 163, 164, 171, 172, 173, 174, 181, 182, 183, 184, 191, 192, 193, 194, 201, 202, 203, 204, 211, 212, 213, 214, 221, 222, 223, 224, 231, 232, 233, 234, 241, 242, 243, 244, 251, 252, 253, 254, 261, 262, 263, 264, 271, 272, 273, 274, 281, 282, 283, 284, 291, 292, 293, 294, 301, 302, 303, 304, 321, 322, 323, 324, 331, 332, 333, 334, 341, 342, 343, 344, 351, 352, 353, 354, 361, 362, 363, 364, 381, 382, 383, 384, 391, 392, 393, 394, 401, 402, 403, 404, 411, 412, 413, 414, 421, 422, 423, 424, 431, 432, 433, 434, 441, 442, 443, 444, 451, 452, 453, 454, 461, 462, 463, 464, 471, 472, 473, 474, 481, 482, 483, 484, 491, 492, 493, 494, 501, 502, 503, 504, 511, 512, 513, 514, 521, 522, 523, 524, 531, 532, 533, 534, 541, 542, 543, 544, 551, 552, 553, 554, 561, 562, 563, 564, 571, 572, 573, 574, 581, 582, 583, 584, 591, 592, 593, 594, 601, 602, 603, 604, 611, 612, 613, 614, 621, 622, 623, 624, 631, 632, 633, 634, 641, 642, 643, 644, 651, 652, 653, 654, 661, 662, 663, 664, 671, 672, 673, 674, 681, 682, 683, 684, 691, 692, 693, 694, 701, 702, 703, 704, 711, 712, 713, 714, 721, 722, 723, 724, 731, 732, 733, 734, 741, 742, 743, 744, 751, 752, 753, 754, 761, 762, 763, 764, 781, 782, 783, 784, 791, 792, 793, 794, 801, 802, 803, 804, 811, 812, 813, 814, 821, 822, 823, 824, 831, 832, 833, 834, 841, 842, 843, 844, 851, 852, 853, 854, 861, 862, 863, 864, 881, 882, 883, 884, 891, 892, 893, 894, 901, 902, 903, 904, 911, 912, 913, 914, 921, 922, 923, 924, 931, 932, 933, 934, 941, 942, 943, 944, 951, 952, 953, 954, 971, 972, 973, 974, 981, 982, 983, 991, 992, 993, 994, 1001, 1002, 1003, 1004, 1011, 1012, 1013, 1014, 1021, 1022, 1023, 1024, 1031, 1032, 1033, 1034, 1041, 1042, 1043, 1044, 1051, 1052, 1053, 1054, 1061, 1062, 1063, 1064, 1071, 1072, 1073, 1074, 1081, 1082, 1083, 1084, 1091, 1092, 1093, 1094, 1101, 1102, 1103, 1104, 1111, 1112, 1113, 1114, 1121, 1122, 1123, 1124, 1131, 1132, 1133, 1134, 1151, 1152, 1153, 1154, 1161, 1162, 1163, 1164, 1171, 1172, 1173, 1174, 1181, 1182, 1183, 1184, 1191, 1192, 1193, 1194, 1201, 1202, 1203, 1204, 1211, 1212, 1213, 1214, 1221, 1222, 1223, 1224, 1231, 1232, 1233, 1234, 1241, 1242, 1243, 1244, 1261, 1262, 1263, 1264, 1301, 1302, 1303, 1304}
return cfavourskill

