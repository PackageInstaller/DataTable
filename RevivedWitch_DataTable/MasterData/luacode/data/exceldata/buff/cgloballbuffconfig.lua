-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/buff/cgloballbuffconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cgloballbuffconfig = {}
cgloballbuffconfig.Data = {
[21115] = {id = 21115, system = 2, time = 0, limit = "", target = 3, buffattr = "time=999999;maxhp_value=5*maxhpa"}
, 
[21116] = {id = 21116, system = 2, time = 0, limit = "", target = 1, buffattr = "time=999999;hp_value=-maxhpb"}
, 
[21117] = {id = 21117, system = 2, time = 0, limit = "", target = 2, buffattr = "time=999999;attack_value=fixedpoint(\"0.1\")*staticattacka"}
, 
[21118] = {id = 21118, system = 2, time = 0, limit = "", target = 2, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.2\")*maxhpa"}
, 
[21119] = {id = 21119, system = 2, time = 0, limit = "", target = 2, buffattr = "time=999999;attack_value=fixedpoint(\"0.2\")*staticattacka;maxhp_value=fixedpoint(\"0.2\")*maxhpa"}
, 
[21120] = {id = 21120, system = 2, time = 900, limit = "", target = 3, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.1\");curativeadd_value=-fixedpoint(\"0.1\")"}
, 
[21121] = {id = 21121, system = 2, time = 1800, limit = "", target = 3, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.2\");curativeadd_value=-fixedpoint(\"0.2\")"}
, 
[21122] = {id = 21122, system = 2, time = 2700, limit = "", target = 3, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.5\");curativeadd_value=-fixedpoint(\"0.5\")"}
, 
[21123] = {id = 21123, system = 2, time = 3600, limit = "", target = 3, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"1\");curativeadd_value=-fixedpoint(\"1\")"}
, 
[21157] = {id = 21157, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.05\")*staticattacka"}
, 
[21158] = {id = 21158, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.1\")*staticattacka"}
, 
[21159] = {id = 21159, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;critrate_value=fixedpoint(\"0.05\");critdegree_value=fixedpoint(\"0.15\")"}
, 
[21160] = {id = 21160, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;critrate_value=fixedpoint(\"0.1\");critdegree_value=fixedpoint(\"0.3\")"}
, 
[21161] = {id = 21161, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;monsterbonus=fixedpoint(\"0.3\")"}
, 
[21162] = {id = 21162, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;bossbonus=fixedpoint(\"0.3\")"}
, 
[21163] = {id = 21163, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999"}
, 
[21164] = {id = 21164, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;roundcd=300"}
, 
[21165] = {id = 21165, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;orderpwrgrow_value=fixedpoint(\"0.2\")"}
, 
[21166] = {id = 21166, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;defend_value=chaospwr*fixedpoint(\"0.03\");magicdef_value=chaospwr*fixedpoint(\"0.03\")"}
, 
[21167] = {id = 21167, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;defend_value=orderpwr*fixedpoint(\"0.03\");magicdef_value=orderpwr*fixedpoint(\"0.03\")"}
, 
[21168] = {id = 21168, system = 3, time = 150, limit = "", target = 2, buffattr = "time=300;timecell=999;hp_value=-math.min(200000,fixedpoint(\"0.1\")*maxhpb)"}
, 
[21169] = {id = 21169, system = 3, time = 0, limit = "", target = 2, buffattr = "time=999999"}
, 
[21170] = {id = 21170, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.05\")*maxhpb"}
, 
[21171] = {id = 21171, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.1\")*maxhpb"}
, 
[21172] = {id = 21172, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;physicallifesteal_value=fixedpoint(\"0.05\");magiclifesteal_value=fixedpoint(\"0.05\")"}
, 
[21173] = {id = 21173, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;physicallifesteal_value=fixedpoint(\"0.1\");magiclifesteal_value=fixedpoint(\"0.1\")"}
, 
[21174] = {id = 21174, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;curativeadd_value=fixedpoint(\"0.15\")"}
, 
[21175] = {id = 21175, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;curativeadd_value=fixedpoint(\"0.3\")"}
, 
[21176] = {id = 21176, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;timecell=300;hp_value=f.hpheal(fixedpoint(\"0.1\"))"}
, 
[21177] = {id = 21177, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999"}
, 
[21178] = {id = 21178, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;physicalreduce_value=fixedpoint(\"0.05\")"}
, 
[21179] = {id = 21179, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;physicalreduce_value=fixedpoint(\"0.1\")"}
, 
[21180] = {id = 21180, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;magicreduce_value=fixedpoint(\"0.05\")"}
, 
[21181] = {id = 21181, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;magicreduce_value=fixedpoint(\"0.1\")"}
, 
[21182] = {id = 21182, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;rate=10"}
, 
[21183] = {id = 21183, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;effecttimes=1"}
, 
[21184] = {id = 21184, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;physicalbonus_value=1;magicbonus_value=1"}
, 
[21185] = {id = 21185, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.2\")*(1-hpb/maxhpb);magicbonus_value=fixedpoint(\"0.2\")*(1-hpb/maxhpb)"}
, 
[21186] = {id = 21186, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.2\");magicbonus_value=fixedpoint(\"0.2\");physicalreduce_value=fixedpoint(\"0.1\");magicreduce_value=fixedpoint(\"0.1\")"}
, 
[21187] = {id = 21187, system = 3, time = 0, limit = "", target = 2, buffattr = "time=300"}
, 
[21193] = {id = 21193, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;healskilladd_value=fixedpoint(\"0.05\");dmgskilladd_value=fixedpoint(\"0.05\")"}
, 
[21194] = {id = 21194, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;healskilladd_value=fixedpoint(\"0.1\");dmgskilladd_value=fixedpoint(\"0.1\")"}
, 
[21284] = {id = 21284, system = 4, time = 900, limit = "", target = 2, buffattr = "time=999999"}
, 
[21285] = {id = 21285, system = 4, time = 2700, limit = "", target = 2, buffattr = "time=999999"}
, 
[21286] = {id = 21286, system = 4, time = 5400, limit = "", target = 2, buffattr = "time=999999"}
, 
[21287] = {id = 21287, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=-fixedpoint(\"0.15\")*maxhpa"}
, 
[21288] = {id = 21288, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=-fixedpoint(\"0.35\")*maxhpa"}
, 
[21289] = {id = 21289, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=-fixedpoint(\"0.6\")*maxhpa"}
, 
[21290] = {id = 21290, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.2\");magicbonus_value=fixedpoint(\"0.2\")"}
, 
[21291] = {id = 21291, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.4\");magicbonus_value=fixedpoint(\"0.4\")"}
, 
[21292] = {id = 21292, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.6\");magicbonus_value=fixedpoint(\"0.8\")"}
, 
[21293] = {id = 21293, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;defend_value=2000"}
, 
[21294] = {id = 21294, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;defend_value=4000"}
, 
[21295] = {id = 21295, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;defend_value=8000"}
, 
[21296] = {id = 21296, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;magicdef_value=2000"}
, 
[21297] = {id = 21297, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;magicdef_value=4000"}
, 
[21298] = {id = 21298, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;magicdef_value=8000"}
, 
[21299] = {id = 21299, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;maxhpscale_value=fixedpoint(\"0.25\")"}
, 
[21300] = {id = 21300, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;maxhpscale_value=fixedpoint(\"0.5\")"}
, 
[21301] = {id = 21301, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;maxhpscale_value=1"}
, 
[21333] = {id = 21333, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;enemyorderpwrgrow_value=-20"}
, 
[21334] = {id = 21334, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;enemyorderpwrgrow_value=-40"}
, 
[21335] = {id = 21335, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;enemyorderpwrgrow_value=-80"}
, 
[21336] = {id = 21336, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=-fixedpoint(\"0.2\")*staticattacka"}
, 
[21337] = {id = 21337, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=-fixedpoint(\"0.4\")*staticattacka"}
, 
[21338] = {id = 21338, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=-fixedpoint(\"0.8\")*staticattacka"}
, 
[21340] = {id = 21340, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.1\")*staticattacka"}
, 
[21341] = {id = 21341, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.2\")*staticattacka"}
, 
[21342] = {id = 21342, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.3\")*staticattacka"}
, 
[21343] = {id = 21343, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.4\")*staticattacka"}
, 
[21344] = {id = 21344, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.1\")*maxhpa"}
, 
[21345] = {id = 21345, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.2\")*maxhpa"}
, 
[21346] = {id = 21346, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.3\")*maxhpa"}
, 
[21347] = {id = 21347, system = 5, time = 0, limit = "", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.4\")*maxhpa"}
, 
[21348] = {id = 21348, system = 5, time = 0, limit = "", target = 2, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.5\")*maxhpa"}
, 
[21349] = {id = 21349, system = 5, time = 0, limit = "", target = 2, buffattr = "time=999999;maxhp_value=fixedpoint(\"1\")*maxhpa"}
, 
[21350] = {id = 21350, system = 5, time = 0, limit = "", target = 2, buffattr = "time=999999;attack_value=fixedpoint(\"0.5\")*staticattacka"}
, 
[21351] = {id = 21351, system = 5, time = 0, limit = "", target = 2, buffattr = "time=999999;attack_value=fixedpoint(\"1\")*staticattacka"}
, 
[21354] = {id = 21354, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;curativeadd_value=-fixedpoint(\"0.2\")"}
, 
[21355] = {id = 21355, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;curativeadd_value=-fixedpoint(\"0.4\")"}
, 
[21356] = {id = 21356, system = 4, time = -1, limit = "", target = 1, buffattr = "time=999999;curativeadd_value=-fixedpoint(\"0.8\")"}
, 
[21386] = {id = 21386, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.2\");magicbonus_value=fixedpoint(\"0.2\")"}
, 
[21387] = {id = 21387, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.4\");magicbonus_value=fixedpoint(\"0.4\")"}
, 
[21388] = {id = 21388, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.8\");magicbonus_value=fixedpoint(\"0.8\")"}
, 
[21389] = {id = 21389, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;attack_value=fixedpoint(\"0.2\")*staticattacka"}
, 
[21390] = {id = 21390, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;attack_value=fixedpoint(\"0.4\")*staticattacka"}
, 
[21391] = {id = 21391, system = 4, time = -1, limit = "", target = 2, buffattr = "time=999999;attack_value=fixedpoint(\"0.8\")*staticattacka"}
, 
[21477] = {id = 21477, system = 6, time = 1800, limit = "", target = 2, buffattr = "time=999999"}
, 
[21480] = {id = 21480, system = 6, time = 0, limit = "", target = 2, buffattr = "time=999999;elementype=1;elementdmg=fixedpoint(\"0.5\");elementnum=6"}
, 
[21481] = {id = 21481, system = 6, time = 0, limit = "", target = 2, buffattr = "time=999999;elementype=2;elementdmg=fixedpoint(\"0.5\");elementnum=6"}
, 
[21482] = {id = 21482, system = 6, time = 0, limit = "", target = 2, buffattr = "time=999999;elementype=3;elementdmg=fixedpoint(\"0.5\");elementnum=6"}
, 
[22007] = {id = 22007, system = 4, time = 900, limit = "", target = 2, buffattr = "time=999999"}
, 
[22008] = {id = 22008, system = 4, time = 2700, limit = "", target = 2, buffattr = "time=999999"}
, 
[22009] = {id = 22009, system = 4, time = 5400, limit = "", target = 2, buffattr = "time=999999"}
, 
[22013] = {id = 22013, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;orderpwrgrow_value=fixedpoint(\"0.2\")"}
, 
[22014] = {id = 22014, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;defend_value=chaospwr*fixedpoint(\"0.03\");magicdef_value=chaospwr*fixedpoint(\"0.03\")"}
, 
[22015] = {id = 22015, system = 3, time = 0, limit = "", target = 1, buffattr = "time=999999;defend_value=orderpwr*fixedpoint(\"0.03\");magicdef_value=orderpwr*fixedpoint(\"0.03\")"}
, 
[70001] = {id = 70001, system = 7, time = -1, limit = "1001", target = 1, buffattr = "time=999999;maxhp_value=3000"}
, 
[70002] = {id = 70002, system = 7, time = -1, limit = "1005", target = 1, buffattr = "time=999999;attack_value=250"}
, 
[70003] = {id = 70003, system = 7, time = -1, limit = "2004", target = 1, buffattr = "time=999999;defend_value=50;magicdef_value=50"}
, 
[70021] = {id = 70021, system = 7, time = -1, limit = "1003", target = 1, buffattr = "time=999999;critrate_value=fixedpoint(\"0.1\");critdegree_value=fixedpoint(\"0.1\")"}
, 
[70022] = {id = 70022, system = 7, time = -1, limit = "2006", target = 2, buffattr = "time=999999;magicdef_value=-fixedpoint(\"0.2\")*staticmagicdefb"}
, 
[70023] = {id = 70023, system = 7, time = -1, limit = "1002", target = 1, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.05\")"}
, 
[70041] = {id = 70041, system = 7, time = -1, limit = "3001", target = 1, buffattr = "time=999999;physicalreduce_value=fixedpoint(\"0.2\")"}
, 
[70042] = {id = 70042, system = 7, time = -1, limit = "3003", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.15\")*maxhpa"}
, 
[70043] = {id = 70043, system = 7, time = -1, limit = "3002", target = 1, buffattr = "time=999999;magicreduce_value=fixedpoint(\"0.2\")"}
, 
[70061] = {id = 70061, system = 7, time = -1, limit = "3001", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.15\")*staticattacka"}
, 
[70062] = {id = 70062, system = 7, time = -1, limit = "3003", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.15\")*staticattacka"}
, 
[70063] = {id = 70063, system = 7, time = -1, limit = "3002", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.15\")*staticattacka"}
, 
[70081] = {id = 70081, system = 7, time = -1, limit = "", target = 1, buffattr = "time=999999"}
, 
[70082] = {id = 70082, system = 7, time = -1, limit = "", target = 1, buffattr = "time=999999;orderpwrgrow_value=10"}
, 
[70101] = {id = 70101, system = 7, time = -1, limit = "", target = 1, buffattr = "time=999999;physicalbonus_value=fixedpoint(\"0.3\")"}
, 
[70102] = {id = 70102, system = 7, time = -1, limit = "", target = 1, buffattr = "time=999999;magicbonus_value=fixedpoint(\"0.3\")"}
, 
[70201] = {id = 70201, system = 7, time = -1, limit = "1003", target = 1, buffattr = "time=999999;critrate_value=fixedpoint(\"0.12\")"}
, 
[70202] = {id = 70202, system = 7, time = -1, limit = "3002;3003", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.15\")*maxhpa"}
, 
[70203] = {id = 70203, system = 7, time = -1, limit = "", target = 1, buffattr = "time=999999;critdegree_value=fixedpoint(\"1.0\")"}
, 
[70211] = {id = 70211, system = 7, time = -1, limit = "1006", target = 1, buffattr = "time=999999;magicbonus_value=fixedpoint(\"0.05\")"}
, 
[70212] = {id = 70212, system = 7, time = -1, limit = "2004", target = 2, buffattr = "time=999999;magicdef_value=-300"}
, 
[70213] = {id = 70213, system = 7, time = -1, limit = "3001", target = 1, buffattr = "time=999999;magicdefbreak_value=fixedpoint(\"0.25\")*staticattacka"}
, 
[70214] = {id = 70214, system = 7, time = -1, limit = "", target = 1, buffattr = "time=999999;timecell=270;chaospwr_value=1"}
, 
[71001] = {id = 71001, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=600"}
, 
[71002] = {id = 71002, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=1200"}
, 
[71003] = {id = 71003, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=1800"}
, 
[71004] = {id = 71004, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;physicaldefbreak_value=400"}
, 
[71005] = {id = 71005, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;physicaldefbreak_value=800"}
, 
[71006] = {id = 71006, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;physicaldefbreak_value=1200"}
, 
[71007] = {id = 71007, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;magicdefbreak_value=400"}
, 
[71008] = {id = 71008, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;magicdefbreak_value=800"}
, 
[71009] = {id = 71009, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;magicdefbreak_value=1200"}
, 
[71010] = {id = 71010, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=5000"}
, 
[71011] = {id = 71011, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=10000"}
, 
[71012] = {id = 71012, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=15000"}
, 
[71101] = {id = 71101, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=fixedpoint(\"0.05\")*maxhpa"}
, 
[71102] = {id = 71102, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=-fixedpoint(\"0.35\")*maxhpa"}
, 
[71103] = {id = 71103, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;maxhp_value=-fixedpoint(\"0.6\")*maxhpa"}
, 
[71104] = {id = 71104, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;physicalreduce_value=fixedpoint(\"0.05\");magicreduce_value=fixedpoint(\"0.05\")"}
, 
[71105] = {id = 71105, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;physicalreduce_value=-fixedpoint(\"0.4\");magicreduce_value=-fixedpoint(\"0.4\")"}
, 
[71106] = {id = 71106, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;physicalreduce_value=-fixedpoint(\"0.8\");magicreduce_value=-fixedpoint(\"0.8\")"}
, 
[71107] = {id = 71107, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;defend_value=-200"}
, 
[71108] = {id = 71108, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;defend_value=4000"}
, 
[71109] = {id = 71109, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;defend_value=8000"}
, 
[71110] = {id = 71110, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;magicdef_value=-200"}
, 
[71111] = {id = 71111, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;magicdef_value=4000"}
, 
[71112] = {id = 71112, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;magicdef_value=8000"}
, 
[71113] = {id = 71113, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;maxhpscale_value=-fixedpoint(\"0.05\")"}
, 
[71114] = {id = 71114, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;maxhpscale_value=fixedpoint(\"0.5\")"}
, 
[71115] = {id = 71115, system = 5, time = -1, limit = "", target = 2, buffattr = "time=999999;maxhpscale_value=1"}
, 
[71116] = {id = 71116, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=fixedpoint(\"0.05\")*attacka"}
, 
[71117] = {id = 71117, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=-fixedpoint(\"0.4\")*attacka"}
, 
[71118] = {id = 71118, system = 5, time = -1, limit = "", target = 1, buffattr = "time=999999;attack_value=-fixedpoint(\"0.8\")*attacka"}
}
cgloballbuffconfig.AllIds = {21115, 21116, 21117, 21118, 21119, 21120, 21121, 21122, 21123, 21157, 21158, 21159, 21160, 21161, 21162, 21163, 21164, 21165, 21166, 21167, 21168, 21169, 21170, 21171, 21172, 21173, 21174, 21175, 21176, 21177, 21178, 21179, 21180, 21181, 21182, 21183, 21184, 21185, 21186, 21187, 21193, 21194, 21284, 21285, 21286, 21287, 21288, 21289, 21290, 21291, 21292, 21293, 21294, 21295, 21296, 21297, 21298, 21299, 21300, 21301, 21333, 21334, 21335, 21336, 21337, 21338, 21340, 21341, 21342, 21343, 21344, 21345, 21346, 21347, 21348, 21349, 21350, 21351, 21354, 21355, 21356, 21386, 21387, 21388, 21389, 21390, 21391, 21477, 21480, 21481, 21482, 22007, 22008, 22009, 22013, 22014, 22015, 70001, 70002, 70003, 70021, 70022, 70023, 70041, 70042, 70043, 70061, 70062, 70063, 70081, 70082, 70101, 70102, 70201, 70202, 70203, 70211, 70212, 70213, 70214, 71001, 71002, 71003, 71004, 71005, 71006, 71007, 71008, 71009, 71010, 71011, 71012, 71101, 71102, 71103, 71104, 71105, 71106, 71107, 71108, 71109, 71110, 71111, 71112, 71113, 71114, 71115, 71116, 71117, 71118}
return cgloballbuffconfig

