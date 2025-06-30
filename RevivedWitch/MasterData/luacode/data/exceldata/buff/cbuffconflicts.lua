-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/buff/cbuffconflicts.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cbuffconflicts = {}
cbuffconflicts.Data = {
[5] = {id = 5, name = "打断类型技能", cancelbuffGroud = "", cancelbuff = "20835;20863;20946;20888;20955", immunebuffGroud = "", immunebuff = ""}
, 
[10005] = {id = 10005, name = "净化", cancelbuffGroud = "3;5", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[10006] = {id = 10006, name = "复活", cancelbuffGroud = "", cancelbuff = "20000", immunebuffGroud = "", immunebuff = ""}
, 
[10013] = {id = 10013, name = "驱散", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[10015] = {id = 10015, name = "驱散", cancelbuffGroud = "", cancelbuff = "20199", immunebuffGroud = "20201", immunebuff = ""}
, 
[10019] = {id = 10019, name = "驱散计数buff", cancelbuffGroud = "", cancelbuff = "21249;21250;21251;21269;21270;21271;21272;21273;21274;21275;21276", immunebuffGroud = "", immunebuff = ""}
, 
[20014] = {id = 20014, name = "无敌", cancelbuffGroud = "", cancelbuff = "20020", immunebuffGroud = "", immunebuff = ""}
, 
[20020] = {id = 20020, name = "大硬直-3倍伤害", cancelbuffGroud = "", cancelbuff = "20014", immunebuffGroud = "", immunebuff = ""}
, 
[20048] = {id = 20048, name = "无敌（势不可挡）", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20083] = {id = 20083, name = "BOSS虚弱取消蓄力", cancelbuffGroud = "", cancelbuff = "20254;20279;20904;20944;20955", immunebuffGroud = "", immunebuff = "20568"}
, 
[20084] = {id = 20084, name = "守护状态", cancelbuffGroud = "", cancelbuff = "20176", immunebuffGroud = "", immunebuff = "20176"}
, 
[20087] = {id = 20087, name = "回旋斩", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20088] = {id = 20088, name = "雷电回旋斩", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20099] = {id = 20099, name = "流光斩免疫buff", cancelbuffGroud = "", cancelbuff = "20455", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20110] = {id = 20110, name = "免疫buff", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20115] = {id = 20115, name = "孢子爆炸免疫控制", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20116] = {id = 20116, name = "大型怪免疫击飞", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "20018;20108;20212;20765"}
, 
[20165] = {id = 20165, name = "誓言", cancelbuffGroud = "3;5", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10001;10017;10013"}
, 
[20168] = {id = 20168, name = "宿命", cancelbuffGroud = "", cancelbuff = "20167", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017;20167"}
, 
[20177] = {id = 20177, name = "机械核心", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "60167;60171;60172;60173;60174"}
, 
[20178] = {id = 20178, name = "机械核心-释放", cancelbuffGroud = "", cancelbuff = "20177;20265", immunebuffGroud = "", immunebuff = ""}
, 
[20197] = {id = 20197, name = "免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20208] = {id = 20208, name = "骑士团驱散", cancelbuffGroud = "", cancelbuff = "20206;20207", immunebuffGroud = "", immunebuff = ""}
, 
[20211] = {id = 20211, name = "变身驱散一阶段暴风雪特效", cancelbuffGroud = "", cancelbuff = "20282;20083", immunebuffGroud = "", immunebuff = ""}
, 
[20243] = {id = 20243, name = "棺之璧-驱散", cancelbuffGroud = "", cancelbuff = "20084", immunebuffGroud = "", immunebuff = ""}
, 
[20281] = {id = 20281, name = "驱散一阶段暴风雪伤害", cancelbuffGroud = "", cancelbuff = "20280", immunebuffGroud = "", immunebuff = "20280"}
, 
[20285] = {id = 20285, name = "二阶段暴风雪驱散一阶段暴风雪特效", cancelbuffGroud = "", cancelbuff = "20282", immunebuffGroud = "", immunebuff = ""}
, 
[20307] = {id = 20307, name = "极光祝福-LV1", cancelbuffGroud = "", cancelbuff = "20335;20336;20337;20338;20339", immunebuffGroud = "", immunebuff = ""}
, 
[20308] = {id = 20308, name = "极光祝福-LV2", cancelbuffGroud = "", cancelbuff = "20335;20336;20337;20338;20339", immunebuffGroud = "", immunebuff = ""}
, 
[20309] = {id = 20309, name = "极光祝福-LV3", cancelbuffGroud = "", cancelbuff = "20335;20336;20337;20338;20339", immunebuffGroud = "", immunebuff = ""}
, 
[20310] = {id = 20310, name = "极光祝福-LV4", cancelbuffGroud = "", cancelbuff = "20335;20336;20337;20338;20339", immunebuffGroud = "", immunebuff = ""}
, 
[20311] = {id = 20311, name = "极光祝福-LV5", cancelbuffGroud = "", cancelbuff = "20335;20336;20337;20338;20339", immunebuffGroud = "", immunebuff = ""}
, 
[20318] = {id = 20318, name = "涅槃后清除挂载buff", cancelbuffGroud = "", cancelbuff = "20319;20320", immunebuffGroud = "", immunebuff = ""}
, 
[20331] = {id = 20331, name = "红刺", cancelbuffGroud = "", cancelbuff = "20332", immunebuffGroud = "", immunebuff = ""}
, 
[20332] = {id = 20332, name = "千本", cancelbuffGroud = "", cancelbuff = "20331", immunebuffGroud = "", immunebuff = ""}
, 
[20356] = {id = 20356, name = "净化之音", cancelbuffGroud = "3;5", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = ""}
, 
[20367] = {id = 20367, name = "赤瞳", cancelbuffGroud = "", cancelbuff = "20366", immunebuffGroud = "", immunebuff = ""}
, 
[20375] = {id = 20375, name = "命运-弱", cancelbuffGroud = "", cancelbuff = "20376", immunebuffGroud = "", immunebuff = ""}
, 
[20376] = {id = 20376, name = "命运-强", cancelbuffGroud = "", cancelbuff = "20375", immunebuffGroud = "", immunebuff = ""}
, 
[20377] = {id = 20377, name = "占卜-弱", cancelbuffGroud = "", cancelbuff = "20378", immunebuffGroud = "", immunebuff = ""}
, 
[20378] = {id = 20378, name = "占卜-强", cancelbuffGroud = "", cancelbuff = "20377", immunebuffGroud = "", immunebuff = ""}
, 
[20403] = {id = 20403, name = "抹杀-增加一次技能威力", cancelbuffGroud = "", cancelbuff = "20402", immunebuffGroud = "", immunebuff = ""}
, 
[20406] = {id = 20406, name = "蝴蝶护盾，免疫控制", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20409] = {id = 20409, name = "盔甲熊-狂暴2", cancelbuffGroud = "", cancelbuff = "20408", immunebuffGroud = "", immunebuff = ""}
, 
[20410] = {id = 20410, name = "盔甲熊-狂暴3", cancelbuffGroud = "", cancelbuff = "20409", immunebuffGroud = "", immunebuff = ""}
, 
[20411] = {id = 20411, name = "盔甲熊-狂暴4", cancelbuffGroud = "", cancelbuff = "20410", immunebuffGroud = "", immunebuff = ""}
, 
[20412] = {id = 20412, name = "盔甲熊-狂暴5", cancelbuffGroud = "", cancelbuff = "20411", immunebuffGroud = "", immunebuff = ""}
, 
[20437] = {id = 20437, name = "炼金术师技能用buff", cancelbuffGroud = "", cancelbuff = "20436", immunebuffGroud = "", immunebuff = ""}
, 
[20443] = {id = 20443, name = "赤色战姬-深红2buff", cancelbuffGroud = "", cancelbuff = "20442", immunebuffGroud = "", immunebuff = ""}
, 
[20444] = {id = 20444, name = "赤色战姬-深红3buff", cancelbuffGroud = "", cancelbuff = "20443;20442", immunebuffGroud = "", immunebuff = ""}
, 
[20445] = {id = 20445, name = "赤色战姬-深红4buff", cancelbuffGroud = "", cancelbuff = "20444;20443;20442", immunebuffGroud = "", immunebuff = ""}
, 
[20446] = {id = 20446, name = "赤色战姬-深红5buff", cancelbuffGroud = "", cancelbuff = "20445;20444;20443;20442", immunebuffGroud = "", immunebuff = ""}
, 
[20461] = {id = 20461, name = "冰霜独角仙-高双抗", cancelbuffGroud = "", cancelbuff = "20420", immunebuffGroud = "", immunebuff = ""}
, 
[20485] = {id = 20485, name = "龙之少女顶掉人形态普通攻击触发龙息", cancelbuffGroud = "", cancelbuff = "20457", immunebuffGroud = "", immunebuff = ""}
, 
[20489] = {id = 20489, name = "免疫buff", cancelbuffGroud = "", cancelbuff = "20483;20484", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20493] = {id = 20493, name = "清除降低消耗buff", cancelbuffGroud = "", cancelbuff = "20455", immunebuffGroud = "", immunebuff = ""}
, 
[20502] = {id = 20502, name = "清除痛觉享受", cancelbuffGroud = "", cancelbuff = "20501;20504", immunebuffGroud = "", immunebuff = ""}
, 
[20516] = {id = 20516, name = "清除炫色旋律buff", cancelbuffGroud = "", cancelbuff = "20515", immunebuffGroud = "", immunebuff = ""}
, 
[20521] = {id = 20521, name = "清除神官之祝福", cancelbuffGroud = "", cancelbuff = "20555;20556", immunebuffGroud = "", immunebuff = ""}
, 
[20524] = {id = 20524, name = "清除冥府之力", cancelbuffGroud = "", cancelbuff = "20557;20558", immunebuffGroud = "", immunebuff = ""}
, 
[20538] = {id = 20538, name = "清除神之诺", cancelbuffGroud = "", cancelbuff = "20559;20560", immunebuffGroud = "", immunebuff = ""}
, 
[20545] = {id = 20545, name = "清除凝珠成雨", cancelbuffGroud = "", cancelbuff = "20561;20562", immunebuffGroud = "", immunebuff = ""}
, 
[20548] = {id = 20548, name = "清除森之庇护", cancelbuffGroud = "", cancelbuff = "20563;20564", immunebuffGroud = "", immunebuff = ""}
, 
[20550] = {id = 20550, name = "清除圣灵之辉光buff", cancelbuffGroud = "", cancelbuff = "20486;20487", immunebuffGroud = "", immunebuff = ""}
, 
[20551] = {id = 20551, name = "清除绚丽buff", cancelbuffGroud = "", cancelbuff = "20512;20513", immunebuffGroud = "", immunebuff = ""}
, 
[20554] = {id = 20554, name = "清除暗之飨宴", cancelbuffGroud = "", cancelbuff = "20552;20553", immunebuffGroud = "", immunebuff = ""}
, 
[20567] = {id = 20567, name = "献祭深渊-变人时驱散地狱火效果", cancelbuffGroud = "", cancelbuff = "20492;21072", immunebuffGroud = "", immunebuff = ""}
, 
[20590] = {id = 20590, name = "喜", cancelbuffGroud = "", cancelbuff = "20592", immunebuffGroud = "", immunebuff = ""}
, 
[20591] = {id = 20591, name = "哀", cancelbuffGroud = "", cancelbuff = "20590", immunebuffGroud = "", immunebuff = ""}
, 
[20592] = {id = 20592, name = "怒", cancelbuffGroud = "", cancelbuff = "20591", immunebuffGroud = "", immunebuff = ""}
, 
[20597] = {id = 20597, name = "boss献祭深渊的少女变人清除恶魔buff", cancelbuffGroud = "", cancelbuff = "20598;20599", immunebuffGroud = "", immunebuff = ""}
, 
[20602] = {id = 20602, name = "献祭深渊的少女虚弱状态", cancelbuffGroud = "", cancelbuff = "20598;20599", immunebuffGroud = "", immunebuff = ""}
, 
[20651] = {id = 20651, name = "测试用buff", cancelbuffGroud = "", cancelbuff = "20652", immunebuffGroud = "", immunebuff = ""}
, 
[20652] = {id = 20652, name = "测试用buff", cancelbuffGroud = "", cancelbuff = "20651;20653", immunebuffGroud = "", immunebuff = ""}
, 
[20653] = {id = 20653, name = "测试用buff", cancelbuffGroud = "", cancelbuff = "20652", immunebuffGroud = "", immunebuff = ""}
, 
[20663] = {id = 20663, name = "破魔之枪-驱散", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[20677] = {id = 20677, name = "双子绞杀者-绞杀清除连击点", cancelbuffGroud = "", cancelbuff = "20673", immunebuffGroud = "", immunebuff = ""}
, 
[20689] = {id = 20689, name = "贯穿之枪-枪舞/乱舞-霸体", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20726] = {id = 20726, name = "圣迹-神之光辉-互斥", cancelbuffGroud = "", cancelbuff = "20724;20725", immunebuffGroud = "", immunebuff = "20724;20725"}
, 
[20742] = {id = 20742, name = "圣灵之辉光-互斥", cancelbuffGroud = "", cancelbuff = "20738;20739", immunebuffGroud = "", immunebuff = "20738;20739"}
, 
[20745] = {id = 20745, name = "幻境之佑-无敌", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20749] = {id = 20749, name = "解脱-驱散", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[20755] = {id = 20755, name = "星光采集者-星能转移互斥", cancelbuffGroud = "", cancelbuff = "20750;20754;20760;20756;2757;20758;20759", immunebuffGroud = "", immunebuff = ""}
, 
[20788] = {id = 20788, name = "复活-互斥消失", cancelbuffGroud = "2;3;5", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[20789] = {id = 20789, name = "资源副本-破坏刺杀-狂战士之血免疫控制", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20790] = {id = 20790, name = "资源副本-破坏刺杀-狂战士之血虚弱驱散免疫控制", cancelbuffGroud = "", cancelbuff = "20789", immunebuffGroud = "", immunebuff = ""}
, 
[20797] = {id = 20797, name = "冰锥扩散-互斥", cancelbuffGroud = "", cancelbuff = "20798", immunebuffGroud = "", immunebuff = ""}
, 
[20817] = {id = 20817, name = "梦魇护盾-护盾特效1", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20818] = {id = 20818, name = "梦魇护盾-护盾特效2", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20819] = {id = 20819, name = "梦魇护盾-护盾特效3", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20820] = {id = 20820, name = "梦魇护盾-护盾特效4", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20822] = {id = 20822, name = "脆弱状态清除护盾", cancelbuffGroud = "", cancelbuff = "20817;20818;20819;20820;20856;20947", immunebuffGroud = "", immunebuff = ""}
, 
[20823] = {id = 20823, name = "阴影-易伤状态驱散buff", cancelbuffGroud = "", cancelbuff = "20821", immunebuffGroud = "5", immunebuff = ""}
, 
[20835] = {id = 20835, name = "梦境之蛾相位移动", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20841] = {id = 20841, name = "免疫buff", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20842] = {id = 20842, name = "免疫感染狂化", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "20766"}
, 
[20869] = {id = 20869, name = "召唤怪物使免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20870] = {id = 20870, name = "召唤怪物使免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20871] = {id = 20871, name = "召唤怪物使免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20878] = {id = 20878, name = "装备副本-攻击类型改变", cancelbuffGroud = "20873", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[20879] = {id = 20879, name = "双子绞杀者-删除拘束连携", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "20861"}
, 
[20899] = {id = 20899, name = "黑化炼金术士-汲取释放", cancelbuffGroud = "", cancelbuff = "20898", immunebuffGroud = "", immunebuff = ""}
, 
[20922] = {id = 20922, name = "宝珠自爆时驱散挂载buff", cancelbuffGroud = "", cancelbuff = "20921;20923", immunebuffGroud = "", immunebuff = ""}
, 
[20927] = {id = 20927, name = "清除无敌buff", cancelbuffGroud = "", cancelbuff = "20938", immunebuffGroud = "", immunebuff = ""}
, 
[20936] = {id = 20936, name = "无敌-通用", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20938] = {id = 20938, name = "宝珠出现时免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20941] = {id = 20941, name = "复活加血-互斥", cancelbuffGroud = "", cancelbuff = "20940;20777;20778;20779;20780;20781", immunebuffGroud = "", immunebuff = ""}
, 
[20943] = {id = 20943, name = "艾琳娜II免疫击飞", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "20018;20108;20212;20765"}
, 
[20945] = {id = 20945, name = "免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[20947] = {id = 20947, name = "索拉迪乌斯 免疫控制", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20949] = {id = 20949, name = "免疫控制", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = ""}
, 
[20952] = {id = 20952, name = "双子-解除拘束", cancelbuffGroud = "", cancelbuff = "20860", immunebuffGroud = "", immunebuff = ""}
, 
[20953] = {id = 20953, name = "复活-互斥", cancelbuffGroud = "", cancelbuff = "20770;20775;20772;20773;20774;20806;20807;20808;20809;20810;20811;20812;20813;20814;20815", immunebuffGroud = "", immunebuff = ""}
, 
[20958] = {id = 20958, name = "双子专用虚弱", cancelbuffGroud = "", cancelbuff = "20888", immunebuffGroud = "", immunebuff = ""}
, 
[20961] = {id = 20961, name = "复活-免疫祝福效果", cancelbuffGroud = "", cancelbuff = "20770;20775;20772;20773;20774;20806;20807;20808;20809;20810;20811;20812;20813;20814;20815", immunebuffGroud = "", immunebuff = ""}
, 
[20969] = {id = 20969, name = "圣灵惩戒者被动失效", cancelbuffGroud = "", cancelbuff = "20967", immunebuffGroud = "", immunebuff = ""}
, 
[20970] = {id = 20970, name = "圣灵惩戒者被动失效", cancelbuffGroud = "", cancelbuff = "20968", immunebuffGroud = "", immunebuff = ""}
, 
[20973] = {id = 20973, name = "圣灵惩戒者净化", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[20977] = {id = 20977, name = "神之馈赠烟花", cancelbuffGroud = "", cancelbuff = "20975", immunebuffGroud = "", immunebuff = ""}
, 
[20985] = {id = 20985, name = "灵魂操纵者初始形态解除", cancelbuffGroud = "", cancelbuff = "20984", immunebuffGroud = "", immunebuff = ""}
, 
[21018] = {id = 21018, name = "炎击术-净化", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[21026] = {id = 21026, name = "元素亲和-互斥", cancelbuffGroud = "", cancelbuff = "21016", immunebuffGroud = "", immunebuff = ""}
, 
[21029] = {id = 21029, name = "镜中人-互斥1", cancelbuffGroud = "", cancelbuff = "21030", immunebuffGroud = "", immunebuff = ""}
, 
[21035] = {id = 21035, name = "镜中人-互斥2", cancelbuffGroud = "", cancelbuff = "21029", immunebuffGroud = "", immunebuff = ""}
, 
[21038] = {id = 21038, name = "镜之反射-清除计数", cancelbuffGroud = "", cancelbuff = "21036;21037", immunebuffGroud = "", immunebuff = ""}
, 
[21040] = {id = 21040, name = "百合之力", cancelbuffGroud = "3", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[21041] = {id = 21041, name = "召唤物免疫复活", cancelbuffGroud = "", cancelbuff = "10006", immunebuffGroud = "", immunebuff = ""}
, 
[21053] = {id = 21053, name = "哀", cancelbuffGroud = "", cancelbuff = "21055;21219", immunebuffGroud = "", immunebuff = ""}
, 
[21054] = {id = 21054, name = "喜", cancelbuffGroud = "", cancelbuff = "21053;21220", immunebuffGroud = "", immunebuff = ""}
, 
[21055] = {id = 21055, name = "怒", cancelbuffGroud = "", cancelbuff = "21054;21221", immunebuffGroud = "", immunebuff = ""}
, 
[21058] = {id = 21058, name = "清除自身伤害增益buff", cancelbuffGroud = "", cancelbuff = "21057", immunebuffGroud = "", immunebuff = ""}
, 
[21064] = {id = 21064, name = "灵魂箭加成清除挂载buff", cancelbuffGroud = "", cancelbuff = "21066", immunebuffGroud = "", immunebuff = ""}
, 
[21065] = {id = 21065, name = "灵魂箭清除伤害加成", cancelbuffGroud = "", cancelbuff = "21064", immunebuffGroud = "", immunebuff = ""}
, 
[21077] = {id = 21077, name = "抱枕-净化", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[21078] = {id = 21078, name = "抱枕-净化", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[21190] = {id = 21190, name = "驱散复活buff", cancelbuffGroud = "", cancelbuff = "21177", immunebuffGroud = "", immunebuff = ""}
, 
[21192] = {id = 21192, name = "核心击穿-驱散挂载", cancelbuffGroud = "", cancelbuff = "21169", immunebuffGroud = "", immunebuff = ""}
, 
[21209] = {id = 21209, name = "状态buff免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "20981;10000;10001;10007;10016;10017"}
, 
[21210] = {id = 21210, name = "状态buff免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "20981;10000;10001;10007;10016;10017"}
, 
[21211] = {id = 21211, name = "状态buff免疫伤害", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "20981;10000;10001;10007;10016;10017"}
, 
[21216] = {id = 21216, name = "清除逝灵咏叹者被动技能挂载", cancelbuffGroud = "", cancelbuff = "21214;21215", immunebuffGroud = "", immunebuff = ""}
, 
[21225] = {id = 21225, name = "清除非常驻增益buff", cancelbuffGroud = "", cancelbuff = "21219;21220;21221;21224", immunebuffGroud = "", immunebuff = ""}
, 
[21237] = {id = 21237, name = "免疫控制技能", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "5", immunebuff = " "}
, 
[21239] = {id = 21239, name = "驱散静止buff", cancelbuffGroud = "", cancelbuff = "21238", immunebuffGroud = "", immunebuff = ""}
, 
[21244] = {id = 21244, name = "眩晕驱散", cancelbuffGroud = "", cancelbuff = "21242;21243;21241", immunebuffGroud = "", immunebuff = ""}
, 
[21245] = {id = 21245, name = "驱散计数buff", cancelbuffGroud = "", cancelbuff = "21240;21242;21243", immunebuffGroud = "", immunebuff = ""}
, 
[21252] = {id = 21252, name = "圣迹-驱散计数buff", cancelbuffGroud = "", cancelbuff = "21251", immunebuffGroud = "", immunebuff = "21251"}
, 
[21306] = {id = 21306, name = "", cancelbuffGroud = "", cancelbuff = "21310;21311", immunebuffGroud = "", immunebuff = ""}
, 
[21310] = {id = 21310, name = "", cancelbuffGroud = "", cancelbuff = "21306", immunebuffGroud = "", immunebuff = ""}
, 
[21314] = {id = 21314, name = "驱散计数buff", cancelbuffGroud = "", cancelbuff = "21316", immunebuffGroud = "", immunebuff = ""}
, 
[21322] = {id = 21322, name = "驱散增益buff", cancelbuffGroud = "", cancelbuff = "21323", immunebuffGroud = "", immunebuff = "21323"}
, 
[21331] = {id = 21331, name = "停止能量转移-爆发", cancelbuffGroud = "", cancelbuff = "21330", immunebuffGroud = "", immunebuff = ""}
, 
[21339] = {id = 21339, name = "未定之路木桩无敌", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017;20981"}
, 
[21373] = {id = 21373, name = "爱迪希亚-潮起潮落-驱散计数buff", cancelbuffGroud = "", cancelbuff = "21371", immunebuffGroud = "", immunebuff = ""}
, 
[21408] = {id = 21408, name = "暗之艾妮萌1技能计数互斥", cancelbuffGroud = "", cancelbuff = "21402", immunebuffGroud = "", immunebuff = ""}
, 
[21415] = {id = 21415, name = "暗之艾妮萌技能挂载互斥", cancelbuffGroud = "", cancelbuff = "21407", immunebuffGroud = "", immunebuff = ""}
, 
[21416] = {id = 21416, name = "神居2技能互斥", cancelbuffGroud = "", cancelbuff = "21317;21417;21418", immunebuffGroud = "", immunebuff = ""}
, 
[21427] = {id = 21427, name = "神居灵魂技能互斥", cancelbuffGroud = "", cancelbuff = "21425;21426", immunebuffGroud = "", immunebuff = ""}
, 
[21432] = {id = 21432, name = "艾拉-互斥", cancelbuffGroud = "", cancelbuff = "21431", immunebuffGroud = "", immunebuff = ""}
, 
[21441] = {id = 21441, name = "凯多尼娅-破甲计数互斥", cancelbuffGroud = "", cancelbuff = "21056;21068", immunebuffGroud = "", immunebuff = ""}
, 
[21449] = {id = 21449, name = "idol芙洛莱-减少混沌消耗-互斥", cancelbuffGroud = "", cancelbuff = "21445", immunebuffGroud = "", immunebuff = ""}
, 
[21466] = {id = 21466, name = "idol芙洛莱中间商", cancelbuffGroud = "", cancelbuff = "21446", immunebuffGroud = "", immunebuff = ""}
, 
[21469] = {id = 21469, name = "梅莫菲斯专武-互斥", cancelbuffGroud = "", cancelbuff = "21467", immunebuffGroud = "", immunebuff = ""}
, 
[21478] = {id = 21478, name = "瑟希薇被动互斥", cancelbuffGroud = "", cancelbuff = "21450;21451", immunebuffGroud = "", immunebuff = ""}
, 
[21499] = {id = 21499, name = "卡普拉被动-计数互斥", cancelbuffGroud = "", cancelbuff = "21493", immunebuffGroud = "", immunebuff = ""}
, 
[21506] = {id = 21506, name = "夜之托奈兰-护盾-破碎互斥", cancelbuffGroud = "", cancelbuff = "21505", immunebuffGroud = "", immunebuff = ""}
, 
[21508] = {id = 21508, name = "阿鵺伦专武互斥", cancelbuffGroud = "", cancelbuff = "21472", immunebuffGroud = "", immunebuff = ""}
, 
[21524] = {id = 21524, name = "年兽-盐石-形态转换水-火-互斥", cancelbuffGroud = "", cancelbuff = "21520", immunebuffGroud = "", immunebuff = ""}
, 
[21525] = {id = 21525, name = "年兽-盐石-形态转换火-土-互斥", cancelbuffGroud = "", cancelbuff = "21524", immunebuffGroud = "", immunebuff = ""}
, 
[21565] = {id = 21565, name = "卡普拉-二技能互斥", cancelbuffGroud = "", cancelbuff = "21560;21561;21562;21563;21564", immunebuffGroud = "", immunebuff = ""}
, 
[21566] = {id = 21566, name = "双子绞杀者-专武-互斥", cancelbuffGroud = "", cancelbuff = "21557", immunebuffGroud = "", immunebuff = ""}
, 
[21568] = {id = 21568, name = "辛妮-一技能净化效果", cancelbuffGroud = "3", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[21571] = {id = 21571, name = "荷恩-幻境力场-净化", cancelbuffGroud = "2", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[21590] = {id = 21590, name = "艾迪恩-专属装备技能-互斥释放", cancelbuffGroud = "", cancelbuff = "21589", immunebuffGroud = "", immunebuff = ""}
, 
[21609] = {id = 21609, name = "拉芬-被动技能互斥", cancelbuffGroud = "", cancelbuff = "21608", immunebuffGroud = "", immunebuff = ""}
, 
[21613] = {id = 21613, name = "拉苏-被动单次触发", cancelbuffGroud = "", cancelbuff = "21608;21609", immunebuffGroud = "", immunebuff = ""}
, 
[21617] = {id = 21617, name = "拉芬-专武驱散", cancelbuffGroud = "", cancelbuff = "21616", immunebuffGroud = "", immunebuff = ""}
, 
[21618] = {id = 21618, name = "拉芬-被动无敌", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[21621] = {id = 21621, name = "古代机械魔像-转阶段无敌", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[21625] = {id = 21625, name = "暗之艾妮萌专武-被动互斥", cancelbuffGroud = "", cancelbuff = "21626;21627", immunebuffGroud = "", immunebuff = ""}
, 
[21626] = {id = 21626, name = "暗之艾妮萌专武-伤害提高", cancelbuffGroud = "", cancelbuff = "21625", immunebuffGroud = "", immunebuff = ""}
, 
[21631] = {id = 21631, name = "柯塔娜专武-互斥", cancelbuffGroud = "", cancelbuff = "21630", immunebuffGroud = "", immunebuff = ""}
, 
[21632] = {id = 21632, name = "年幼阿卡莎-格挡无敌", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[21634] = {id = 21634, name = "年幼的剑姬阿卡莎-驱散被动4", cancelbuffGroud = "", cancelbuff = "21651", immunebuffGroud = "", immunebuff = ""}
, 
[21635] = {id = 21635, name = "年幼的剑姬阿卡莎-驱散星辰buff", cancelbuffGroud = "", cancelbuff = "21633", immunebuffGroud = "", immunebuff = ""}
, 
[21637] = {id = 21637, name = "年幼的剑姬阿卡莎-驱散被动5", cancelbuffGroud = "", cancelbuff = "21652", immunebuffGroud = "", immunebuff = ""}
, 
[21642] = {id = 21642, name = "爱迪希亚专武驱散", cancelbuffGroud = "", cancelbuff = "21641", immunebuffGroud = "", immunebuff = ""}
, 
[21644] = {id = 21644, name = "年幼的剑姬阿卡莎-驱散被动1", cancelbuffGroud = "", cancelbuff = "21634", immunebuffGroud = "", immunebuff = ""}
, 
[21645] = {id = 21645, name = "年幼的剑姬阿卡莎-驱散被动2", cancelbuffGroud = "", cancelbuff = "21637", immunebuffGroud = "", immunebuff = ""}
, 
[21650] = {id = 21650, name = "年幼的剑姬阿卡莎-驱散被动3", cancelbuffGroud = "", cancelbuff = "21644;21645", immunebuffGroud = "", immunebuff = ""}
, 
[21655] = {id = 21655, name = "双子绞杀者-专武-互斥", cancelbuffGroud = "", cancelbuff = "21653", immunebuffGroud = "", immunebuff = ""}
, 
[21677] = {id = 21677, name = "守护素体进阶-互斥", cancelbuffGroud = "", cancelbuff = "21670", immunebuffGroud = "", immunebuff = ""}
, 
[21679] = {id = 21679, name = "刺杀素体进阶-互斥", cancelbuffGroud = "", cancelbuff = "21672", immunebuffGroud = "", immunebuff = ""}
, 
[21682] = {id = 21682, name = "魔导素体进阶-互斥", cancelbuffGroud = "", cancelbuff = "21675", immunebuffGroud = "", immunebuff = ""}
, 
[21683] = {id = 21683, name = "魔女素体进阶-互斥", cancelbuffGroud = "", cancelbuff = "21676", immunebuffGroud = "", immunebuff = ""}
, 
[21706] = {id = 21706, name = "玛特薇芙专武 互斥", cancelbuffGroud = "", cancelbuff = "21707", immunebuffGroud = "", immunebuff = ""}
, 
[21707] = {id = 21707, name = "玛特薇芙专武 互斥", cancelbuffGroud = "", cancelbuff = "21706", immunebuffGroud = "", immunebuff = ""}
, 
[21708] = {id = 21708, name = "玛特薇芙专武 互斥", cancelbuffGroud = "", cancelbuff = "21709", immunebuffGroud = "", immunebuff = ""}
, 
[21709] = {id = 21709, name = "玛特薇芙专武 互斥", cancelbuffGroud = "", cancelbuff = "21708", immunebuffGroud = "", immunebuff = ""}
, 
[21725] = {id = 21725, name = "埃舍雷被动-1技能互斥计数", cancelbuffGroud = "", cancelbuff = "21720;21727", immunebuffGroud = "", immunebuff = ""}
, 
[21726] = {id = 21726, name = "埃舍雷被动-2技能互斥计数", cancelbuffGroud = "", cancelbuff = "21721;21728", immunebuffGroud = "", immunebuff = ""}
, 
[21733] = {id = 21733, name = "弗莱尔驱散被动", cancelbuffGroud = "", cancelbuff = "21711;21712", immunebuffGroud = "", immunebuff = ""}
, 
[21738] = {id = 21738, name = "女神达娜", cancelbuffGroud = "", cancelbuff = "21737", immunebuffGroud = "", immunebuff = ""}
, 
[21754] = {id = 21754, name = "boss轮换-物理免疫", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "10000;10016"}
, 
[21755] = {id = 21755, name = "boss轮换-魔法免疫", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "", immunebuff = "10001;10017"}
, 
[21758] = {id = 21758, name = "boss轮换-狂暴-免疫驱散无敌", cancelbuffGroud = "6", cancelbuff = "", immunebuffGroud = "6", immunebuff = ""}
, 
[21760] = {id = 21760, name = "驱散狂暴调用连携-超大", cancelbuffGroud = "", cancelbuff = "21756", immunebuffGroud = "", immunebuff = ""}
, 
[21765] = {id = 21765, name = "驱散狂暴调用连携-大", cancelbuffGroud = "", cancelbuff = "21761", immunebuffGroud = "", immunebuff = ""}
, 
[21766] = {id = 21766, name = "驱散狂暴调用连携-中", cancelbuffGroud = "", cancelbuff = "21763", immunebuffGroud = "", immunebuff = ""}
, 
[21771] = {id = 21771, name = "流失之殇 2技能-释放顶buff", cancelbuffGroud = "", cancelbuff = "21770;21801;21800;21799;21798", immunebuffGroud = "", immunebuff = ""}
, 
[21790] = {id = 21790, name = "第六章怪物30%魔法抗性", cancelbuffGroud = "", cancelbuff = "21794", immunebuffGroud = "", immunebuff = ""}
, 
[21791] = {id = 21791, name = "第六章怪物50%魔法抗性", cancelbuffGroud = "", cancelbuff = "21795", immunebuffGroud = "", immunebuff = ""}
, 
[21792] = {id = 21792, name = "第六章怪物30%物理抗性", cancelbuffGroud = "", cancelbuff = "21796", immunebuffGroud = "", immunebuff = ""}
, 
[21793] = {id = 21793, name = "第六章怪物50%物理抗性", cancelbuffGroud = "", cancelbuff = "21797", immunebuffGroud = "", immunebuff = ""}
, 
[21805] = {id = 21805, name = "卡蜜莉安驱散真理", cancelbuffGroud = "", cancelbuff = "21804", immunebuffGroud = "", immunebuff = ""}
, 
[21812] = {id = 21812, name = "卡蜜莉安驱散反伤", cancelbuffGroud = "", cancelbuff = "21810", immunebuffGroud = "", immunebuff = ""}
, 
[21813] = {id = 21813, name = "卡蜜莉安驱散减伤", cancelbuffGroud = "", cancelbuff = "21811", immunebuffGroud = "", immunebuff = ""}
, 
[21819] = {id = 21819, name = "葛淑丝驱散免疫被动", cancelbuffGroud = "", cancelbuff = "21820;21823", immunebuffGroud = "", immunebuff = "21820;21823"}
, 
[21822] = {id = 21822, name = "葛淑丝-被动无敌", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[21837] = {id = 21837, name = "达奈莉姆-净化", cancelbuffGroud = "3", cancelbuff = "", immunebuffGroud = "", immunebuff = ""}
, 
[21847] = {id = 21847, name = "达奈莉姆-被动无敌", cancelbuffGroud = "", cancelbuff = "", immunebuffGroud = "3;5", immunebuff = "10000;10001;10007;10016;10017"}
, 
[21848] = {id = 21848, name = "达奈莉姆驱散免疫被动", cancelbuffGroud = "", cancelbuff = "21845;21846", immunebuffGroud = "", immunebuff = "21845;21846"}
, 
[21858] = {id = 21858, name = "海中匿影专武 互斥", cancelbuffGroud = "", cancelbuff = "21859", immunebuffGroud = "", immunebuff = ""}
, 
[21859] = {id = 21859, name = "海中匿影专武 互斥", cancelbuffGroud = "", cancelbuff = "21858", immunebuffGroud = "", immunebuff = ""}
, 
[21860] = {id = 21860, name = "海中匿影专武 互斥", cancelbuffGroud = "", cancelbuff = "21861", immunebuffGroud = "", immunebuff = ""}
, 
[21861] = {id = 21861, name = "海中匿影专武 互斥", cancelbuffGroud = "", cancelbuff = "21860", immunebuffGroud = "", immunebuff = ""}
, 
[21868] = {id = 21868, name = "达奈莉姆驱散免疫被动", cancelbuffGroud = "", cancelbuff = "21845;21846", immunebuffGroud = "", immunebuff = "21845;21846"}
, 
[21888] = {id = 21888, name = "散华专武 互斥", cancelbuffGroud = "", cancelbuff = "21887", immunebuffGroud = "", immunebuff = ""}
, 
[21903] = {id = 21903, name = "异次元游商专武 互斥", cancelbuffGroud = "", cancelbuff = "21900", immunebuffGroud = "", immunebuff = ""}
, 
[21916] = {id = 21916, name = "情感诊疗师专武 互斥", cancelbuffGroud = "", cancelbuff = "21915", immunebuffGroud = "", immunebuff = ""}
, 
[21934] = {id = 21934, name = "晨星光耀专武-互斥", cancelbuffGroud = "", cancelbuff = "21933", immunebuffGroud = "", immunebuff = ""}
, 
[21945] = {id = 21945, name = "夕音-被动-互斥", cancelbuffGroud = "", cancelbuff = "21943;21944", immunebuffGroud = "", immunebuff = ""}
, 
[21947] = {id = 21947, name = "夕音-专武-互斥", cancelbuffGroud = "", cancelbuff = "21946", immunebuffGroud = "", immunebuff = ""}
, 
[21984] = {id = 21984, name = "埃列什嘉尔专武驱散", cancelbuffGroud = "", cancelbuff = "21983", immunebuffGroud = "", immunebuff = ""}
, 
[21992] = {id = 21992, name = "精灵凝莎专武-互斥", cancelbuffGroud = "", cancelbuff = "21990", immunebuffGroud = "", immunebuff = ""}
}
cbuffconflicts.AllIds = {5, 10005, 10006, 10013, 10015, 10019, 20014, 20020, 20048, 20083, 20084, 20087, 20088, 20099, 20110, 20115, 20116, 20165, 20168, 20177, 20178, 20197, 20208, 20211, 20243, 20281, 20285, 20307, 20308, 20309, 20310, 20311, 20318, 20331, 20332, 20356, 20367, 20375, 20376, 20377, 20378, 20403, 20406, 20409, 20410, 20411, 20412, 20437, 20443, 20444, 20445, 20446, 20461, 20485, 20489, 20493, 20502, 20516, 20521, 20524, 20538, 20545, 20548, 20550, 20551, 20554, 20567, 20590, 20591, 20592, 20597, 20602, 20651, 20652, 20653, 20663, 20677, 20689, 20726, 20742, 20745, 20749, 20755, 20788, 20789, 20790, 20797, 20817, 20818, 20819, 20820, 20822, 20823, 20835, 20841, 20842, 20869, 20870, 20871, 20878, 20879, 20899, 20922, 20927, 20936, 20938, 20941, 20943, 20945, 20947, 20949, 20952, 20953, 20958, 20961, 20969, 20970, 20973, 20977, 20985, 21018, 21026, 21029, 21035, 21038, 21040, 21041, 21053, 21054, 21055, 21058, 21064, 21065, 21077, 21078, 21190, 21192, 21209, 21210, 21211, 21216, 21225, 21237, 21239, 21244, 21245, 21252, 21306, 21310, 21314, 21322, 21331, 21339, 21373, 21408, 21415, 21416, 21427, 21432, 21441, 21449, 21466, 21469, 21478, 21499, 21506, 21508, 21524, 21525, 21565, 21566, 21568, 21571, 21590, 21609, 21613, 21617, 21618, 21621, 21625, 21626, 21631, 21632, 21634, 21635, 21637, 21642, 21644, 21645, 21650, 21655, 21677, 21679, 21682, 21683, 21706, 21707, 21708, 21709, 21725, 21726, 21733, 21738, 21754, 21755, 21758, 21760, 21765, 21766, 21771, 21790, 21791, 21792, 21793, 21805, 21812, 21813, 21819, 21822, 21837, 21847, 21848, 21858, 21859, 21860, 21861, 21868, 21888, 21903, 21916, 21934, 21945, 21947, 21984, 21992}
return cbuffconflicts

