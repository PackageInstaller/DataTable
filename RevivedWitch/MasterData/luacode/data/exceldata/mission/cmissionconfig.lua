-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/mission/cmissionconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cmissionconfig = {}
cmissionconfig.Data = {
[10001] = {id = 10001, missionname = "镜片收集", missionnameTextID = 1000001, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 3, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "收集伊敏瑟伦之镜的碎片", short_descriptionTextID = 1000091, description = "伊敏瑟伦之镜的碎片散落在<color=#82C65D>塔内</color>，收集它们似乎会发生某些奇异的事情。", descriptionTextID = 1000147, startevent = 0, endevent = 200001, loadevent = "200002,200032,200010,200014", loadtag = 0, accept_mission = 200028, 
progressname = {"碎片"}
, 
progressnameTextID = {1000203}
, 
toptip = {200006}
, rewardtype = 0, rewardid = 1925, 
rewarditem = {35002, 0}
, 
rewardquantity = {4000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10002] = {id = 10002, missionname = "前往伊敏瑟伦之间", missionnameTextID = 1000002, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 4, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔·伊敏瑟伦之间", locationTextID = 1000058, short_description = "前往伊敏瑟伦之间", short_descriptionTextID = 1000092, description = "镜片已经收集完毕$B$前往<color=#82C65D>伊敏瑟伦之间</color>伊敏瑟伦之间就能解开疑惑。", descriptionTextID = 1000148, startevent = 200002, endevent = 200003, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1926, 
rewarditem = {35002, 0}
, 
rewardquantity = {5000, 0}
, unlockcondition = "10001", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10003] = {id = 10003, missionname = "最初的羁绊", missionnameTextID = 1000887, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 5, jumpAim = 3, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "累计召唤10次人偶", short_descriptionTextID = 1000888, description = "累计召唤10次人偶", descriptionTextID = 1000888, startevent = 0, endevent = 200085, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1927, 
rewarditem = {35002, 0}
, 
rewardquantity = {10000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10004] = {id = 10004, missionname = "最初的成长", missionnameTextID = 1000889, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 2, jumpAim = 3, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "人偶最高等级达到10级", short_descriptionTextID = 1000444, description = "人偶最高等级达到10级", descriptionTextID = 1000444, startevent = 0, endevent = 200086, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1928, 
rewarditem = {35002, 0}
, 
rewardquantity = {10000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10006] = {id = 10006, missionname = "神秘的巨木", missionnameTextID = 1000004, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 17, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·巨木", locationTextID = 1000060, short_description = "寻找巨木出现的原因", short_descriptionTextID = 1000094, description = "探索整个伊敏瑟伦之森，寻找巨木出现的原因。", descriptionTextID = 1000150, startevent = 200010, endevent = 200011, loadevent = "200052,200054,200058,200070,200074,200076,200080", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1929, 
rewarditem = {35002, 0}
, 
rewardquantity = {5000, 0}
, unlockcondition = "10002", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10008] = {id = 10008, missionname = "蛙与蝶·相遇", missionnameTextID = 1000006, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 5, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·森林入口", locationTextID = 1000061, short_description = "探寻生物变异的原因", short_descriptionTextID = 1000096, description = "继续前行，探寻森林生物变异的原因。", descriptionTextID = 1000152, startevent = 200014, endevent = 200015, loadevent = "200020", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1930, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "10002", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10011] = {id = 10011, missionname = "蛙与蝶·酒壶", missionnameTextID = 1000009, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 5, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·河畔小径", locationTextID = 1000062, short_description = "寻找酒壶", short_descriptionTextID = 1000099, description = "青蛙骑士费吉亚丢失了他心爱的<color=#82C65D>酒壶</color>，探索的过程中留心寻找吧。", descriptionTextID = 1000155, startevent = 200020, endevent = 200021, loadevent = "200022", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1931, 
rewarditem = {76001, 0}
, 
rewardquantity = {3, 0}
, unlockcondition = "10008", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10012] = {id = 10012, missionname = "蛙与蝶·魔杖", missionnameTextID = 1000010, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 14, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·祭祀场", locationTextID = 1000063, short_description = "寻找魔杖", short_descriptionTextID = 1000100, description = "费吉亚的<color=#82C65D>魔杖</color>同样不见了，还真是粗心啊，在探索途中帮他找找看吧。", descriptionTextID = 1000156, startevent = 200022, endevent = 200023, loadevent = "200036", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1932, 
rewarditem = {76001, 0}
, 
rewardquantity = {3, 0}
, unlockcondition = "10011", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10017] = {id = 10017, missionname = "蛙与蝶·归还", missionnameTextID = 1000013, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 16, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·巨木外围", locationTextID = 1000065, short_description = "归还魔杖", short_descriptionTextID = 1000103, description = "已经找到了丢失的魔杖，可以归还给费吉亚了。他目前应该在<color=#82C65D>巨木外围</color>。", descriptionTextID = 1000159, startevent = 200036, endevent = 200037, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1933, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "10012", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10019] = {id = 10019, missionname = "向上探索时之塔", missionnameTextID = 1000015, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 18, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "继续向上探索时之塔", short_descriptionTextID = 1000105, description = "狄璐卡发现一个神秘的女性进入了时之塔高层，继续向上探索时之塔吧。", descriptionTextID = 1000161, startevent = 200058, endevent = 200059, loadevent = "200060,200062,200064,200066,200068,200072,200078", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1934, 
rewarditem = {35002, 0}
, 
rewardquantity = {5000, 0}
, unlockcondition = "10006", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10020] = {id = 10020, missionname = "前往谢波契卡", missionnameTextID = 1000016, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 24, worldname = 1, worldimg = 10587, backgroundtype = 10464, location = "谢波契卡", locationTextID = 1000066, short_description = "前往谢波契卡", short_descriptionTextID = 1000106, description = "谢波契卡曾经是守护者战争的结束之地，那里也许有你想要的答案。", descriptionTextID = 1000162, startevent = 200060, endevent = 200061, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1935, 
rewarditem = {35008, 0}
, 
rewardquantity = {40, 0}
, unlockcondition = "10019", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10021] = {id = 10021, missionname = "去四周看看", missionnameTextID = 1000017, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 24, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡", locationTextID = 1000066, short_description = "去四周看看", short_descriptionTextID = 1000107, description = "到达了谢波契卡之山，看看四周都有些什么吧。", descriptionTextID = 1000163, startevent = 200062, endevent = 200063, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1936, 
rewarditem = {74000, 0}
, 
rewardquantity = {5, 0}
, unlockcondition = "10020", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10022] = {id = 10022, missionname = "风雪消停", missionnameTextID = 1000018, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 40, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡山顶", locationTextID = 1000067, short_description = "寻找停止风雪的办法", short_descriptionTextID = 1000108, description = "据说暴风雪的来源是山顶的魔法阵，去<color=#82C65D>山顶</color>看看，说不定能让风雪停止。", descriptionTextID = 1000164, startevent = 200064, endevent = 200065, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1937, 
rewarditem = {35008, 0}
, 
rewardquantity = {40, 0}
, unlockcondition = "10021", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10023] = {id = 10023, missionname = "击败圣女瑟希薇", missionnameTextID = 1000019, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 41, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·圣女广场", locationTextID = 1000068, short_description = "击败圣女瑟希薇", short_descriptionTextID = 1000109, description = "前往山顶的<color=#82C65D>圣女广场</color>击败圣女瑟希薇，将暴风雪停止。", descriptionTextID = 1000165, startevent = 200066, endevent = 200067, loadevent = "200083", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1938, 
rewarditem = {35008, 0}
, 
rewardquantity = {80, 0}
, unlockcondition = "10022", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10024] = {id = 10024, missionname = "狩猎争执·报信", missionnameTextID = 1000020, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 25, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·村外冰原南部", locationTextID = 1000069, short_description = "将猎人的信息传递给银弓", short_descriptionTextID = 1000110, description = "帮助受伤的猎人，将信息传递给<color=#82C65D>银弓</color>。", descriptionTextID = 1000166, startevent = 200052, endevent = 200053, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1939, 
rewarditem = {76001, 0}
, 
rewardquantity = {3, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10025] = {id = 10025, missionname = "狩猎争执·调解", missionnameTextID = 1000021, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 29, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·冰湖猎场中段", locationTextID = 1000070, short_description = "调解银弓与老猎人的关系", short_descriptionTextID = 1000111, description = "去<color=#82C65D>冰湖猎场·中段</color>找到银弓，尝试调解银弓和老猎人组织之间的关系。", descriptionTextID = 1000167, startevent = 200068, endevent = 200069, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1940, 
rewarditem = {74000, 0}
, 
rewardquantity = {5, 0}
, unlockcondition = "10024", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10026] = {id = 10026, missionname = "狼群的灾难·说服", missionnameTextID = 1000022, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 31, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·山腰冰原", locationTextID = 1000071, short_description = "说服狼群首领", short_descriptionTextID = 1000112, description = "狼群与人类之间似乎存在某种误会，说服狼群的首领，或许就能调解他们之间的关系。", descriptionTextID = 1000168, startevent = 200070, endevent = 200071, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1941, 
rewarditem = {76001, 0}
, 
rewardquantity = {3, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10027] = {id = 10027, missionname = "找到艾妮萌", missionnameTextID = 1000023, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 21, worldname = 1, worldimg = 10587, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "找到艾妮萌", short_descriptionTextID = 1000113, description = "艾妮萌逃走时掉落了火焰徽章，找到<color=#82C65D>艾妮萌</color>，把火焰徽章还给她。", descriptionTextID = 1000169, startevent = 200080, endevent = 200081, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1942, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "10006", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10028] = {id = 10028, missionname = "继续探索时之塔", missionnameTextID = 1000024, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 42, worldname = 1, worldimg = 10587, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "继续向上探索时之塔", short_descriptionTextID = 1000114, description = "继续向上探索时之塔，探寻其中的秘密吧。", descriptionTextID = 1000170, startevent = 200083, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1943, 
rewarditem = {35008, 0}
, 
rewardquantity = {40, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10029] = {id = 10029, missionname = "寻找德亚丝", missionnameTextID = 1000025, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 43, worldname = 1, worldimg = 10587, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "找到德亚丝", short_descriptionTextID = 1000115, description = "德亚丝在独自一人引开怪物，布露恩十分担心。<color=#82C65D>向上探索</color>，帮她确认德亚丝的安危。", descriptionTextID = 1000171, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1944, 
rewarditem = {74000, 0}
, 
rewardquantity = {5, 0}
, unlockcondition = "10006", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10030] = {id = 10030, missionname = "返回谢波契卡", missionnameTextID = 1000026, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 47, worldname = 1, worldimg = 10587, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "通过逆之间的镜面返回谢波契卡", short_descriptionTextID = 1000116, description = "再次运用事象移动的能力，尝试扭转谢波契卡的终结。", descriptionTextID = 1000172, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1945, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10031] = {id = 10031, missionname = "去附近看看", missionnameTextID = 1000027, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 48, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·村外小道", locationTextID = 1000072, short_description = "去附近看看", short_descriptionTextID = 1000117, description = "事象移动后的谢波契卡似乎和之前有所不同，去附近看看吧。", descriptionTextID = 1000173, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1946, 
rewarditem = {76001, 0}
, 
rewardquantity = {4, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10032] = {id = 10032, missionname = "风雪的起因", missionnameTextID = 1000028, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 55, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·山腰结界", locationTextID = 1000073, short_description = "继续探索谢波契卡", short_descriptionTextID = 1000118, description = "继续向前探索，探寻瑟希薇降下风雪的缘由。", descriptionTextID = 1000174, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1947, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10033] = {id = 10033, missionname = "去结界外看看", missionnameTextID = 1000029, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 50, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·山脚冰原", locationTextID = 1000074, short_description = "探索结界外部", short_descriptionTextID = 1000119, description = "瑟希薇设置了强大的结界，在外部探索寻找线索。", descriptionTextID = 1000175, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1948, 
rewarditem = {35018, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10034] = {id = 10034, missionname = "调查山脚猎场", missionnameTextID = 1000030, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 51, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·山脚猎场", locationTextID = 1000075, short_description = "前往山脚猎场", short_descriptionTextID = 1000120, description = "山脚猎场的魔力感应最强，也许那里就是结界的入口。", descriptionTextID = 1000176, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1949, 
rewarditem = {74000, 0}
, 
rewardquantity = {5, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10035] = {id = 10035, missionname = "进入结界", missionnameTextID = 1000031, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 52, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·猎场结界", locationTextID = 1000076, short_description = "探索结界内部", short_descriptionTextID = 1000121, description = "成功进入了瑟希薇设置的结界，在结界内部探索，看看有何异常。", descriptionTextID = 1000177, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1950, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10036] = {id = 10036, missionname = "小心探索结界", missionnameTextID = 1000032, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 55, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·山腰结界", locationTextID = 1000073, short_description = "在结界内部寻找线索", short_descriptionTextID = 1000122, description = "结界内部有可疑的生物，小心前进。", descriptionTextID = 1000178, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1951, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10037] = {id = 10037, missionname = "地热的源头", missionnameTextID = 1000033, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 58, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·骑士团营地", locationTextID = 1000077, short_description = "寻找地热的源头", short_descriptionTextID = 1000123, description = "瑟希薇消耗魔力制造风雪来抑制地热，但她不愿接受帮助。先<color=#82C65D>继续探索</color>，去调查地热的源头吧。", descriptionTextID = 1000179, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1952, 
rewarditem = {74000, 0}
, 
rewardquantity = {5, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10038] = {id = 10038, missionname = "怪物出现的地方", missionnameTextID = 1000034, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 61, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·圣女广场", locationTextID = 1000068, short_description = "前往圣女广场", short_descriptionTextID = 1000124, description = "那些可疑的怪物似乎与地热有关，前往<color=#82C65D>圣女广场</color>寻找怪物出现的地方。", descriptionTextID = 1000180, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1953, 
rewarditem = {76001, 0}
, 
rewardquantity = {4, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10039] = {id = 10039, missionname = "追上瑟希薇", missionnameTextID = 1000035, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 65, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·地下广场", locationTextID = 1000078, short_description = "前往地下深处", short_descriptionTextID = 1000125, description = "追上瑟希薇，去看看地热的源头究竟是什么。", descriptionTextID = 1000181, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1954, 
rewarditem = {35008, 0}
, 
rewardquantity = {40, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10040] = {id = 10040, missionname = "寻找寒霜的线索", missionnameTextID = 1000036, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 66, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·城堡入口", locationTextID = 1000079, short_description = "和前方的骑士团长对话", short_descriptionTextID = 1000126, description = "必须想办法应对辛莫拉的熔岩核心才能阻止谢波契卡的毁灭。询问前面的<color=#82C65D>冰雪骑士团团长</color>关于寒霜的线索。", descriptionTextID = 1000182, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1955, 
rewarditem = {35018, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10041] = {id = 10041, missionname = "制作寒霜", missionnameTextID = 1000037, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 66, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·城堡入口", locationTextID = 1000079, short_description = "找到拉·柯莉玛", short_descriptionTextID = 1000127, description = "从团长处得到了冰之晶石，加上之前从瑟希薇处获得的不融寒冰，接下来只需要找到拉·柯莉玛了。据说她在<color=#82C65D>城堡前段</color>。", descriptionTextID = 1000183, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1956, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10042] = {id = 10042, missionname = "阻止辛莫拉", missionnameTextID = 1000038, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 67, worldname = 3, worldimg = 12817, backgroundtype = 10463, location = "谢波契卡·地下广场", locationTextID = 1000078, short_description = "阻止谢波契卡的毁灭", short_descriptionTextID = 1000128, description = "击败辛莫拉，逆转谢波契卡必然毁灭的命运。", descriptionTextID = 1000184, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1957, 
rewarditem = {35008, 0}
, 
rewardquantity = {80, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10043] = {id = 10043, missionname = "继续探索时之塔", missionnameTextID = 1000039, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 43, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "继续向上探索时之塔", short_descriptionTextID = 1000129, description = "继续向上探索时之塔，探寻其中的秘密吧。", descriptionTextID = 1000185, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1958, 
rewarditem = {35008, 0}
, 
rewardquantity = {40, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10044] = {id = 10044, missionname = "让德亚丝恢复正常", missionnameTextID = 1000890, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 73, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1000057, short_description = "追上德亚丝", short_descriptionTextID = 1000891, description = "布露恩的劝说并未奏效，德亚丝已经变得非常危险。", descriptionTextID = 1000892, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 1959, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10045] = {id = 10045, missionname = "危险的探索", missionnameTextID = 1000105, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 68, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1001066, short_description = "继续向上探索时之塔", short_descriptionTextID = 1001026, description = "继续向上探索时之塔。", descriptionTextID = 1001046, startevent = 200088, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2711, 
rewarditem = {35002, 0}
, 
rewardquantity = {30000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10046] = {id = 10046, missionname = "引渡人的恩怨", missionnameTextID = 1000955, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 68, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1001067, short_description = "帮助奇芬", short_descriptionTextID = 1001027, description = "奇芬为了履行引渡人的职责，也为拯救昔日的好友，决定独自追捕<color=#82C65D>古尔薇格</color>。", descriptionTextID = 1001047, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2712, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10047] = {id = 10047, missionname = "逃走的古尔薇格", missionnameTextID = 1000956, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 70, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1001068, short_description = "寻找逃走的古尔薇格", short_descriptionTextID = 1001028, description = "帮助奇芬寻找逃走的古尔薇格。", descriptionTextID = 1001048, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2713, 
rewarditem = {76004, 0}
, 
rewardquantity = {4, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10048] = {id = 10048, missionname = "追捕古尔薇格", missionnameTextID = 1000957, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 72, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1001069, short_description = "追捕逃走的古尔薇格", short_descriptionTextID = 1001029, description = "古尔薇格十分危险，必须尽快找到她。", descriptionTextID = 1001049, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2714, 
rewarditem = {35002, 0}
, 
rewardquantity = {30000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[10049] = {id = 10049, missionname = "德亚丝的行踪", missionnameTextID = 1000958, missiontype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 73, worldname = 1, worldimg = 10588, backgroundtype = 10464, location = "时之塔", locationTextID = 1001070, short_description = "寻找精神异常的德亚丝", short_descriptionTextID = 1001030, description = "德亚丝的精神状态已经不正常了，必须尽快找到她。", descriptionTextID = 1001050, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2715, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20001] = {id = 20001, missionname = "兄弟·寻找", missionnameTextID = 1000040, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 9, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·商业区", locationTextID = 1000080, short_description = "受委托寻找弟弟", short_descriptionTextID = 1000130, description = "受变成毛虫的兄长的委托，在<color=#82C65D>前方的森林</color>里，帮助他寻找失散的弟弟。", descriptionTextID = 1000186, startevent = 200032, endevent = 200033, loadevent = "200048", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1960, 
rewarditem = {74000, 0}
, 
rewardquantity = {5, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20002] = {id = 20002, missionname = "索雷优的曲谱·寻找", missionnameTextID = 1000041, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 10, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·哨戒营外围", locationTextID = 1000081, short_description = "找回索雷优的乐谱", short_descriptionTextID = 1000131, description = "索雷优希望能找回他最珍贵的乐谱。在<color=#82C65D>哨戒营外围</color>四处找一找，然后去<color=#82C65D>哨戒营</color>找他吧。", descriptionTextID = 1000187, startevent = 0, endevent = 200041, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1961, 
rewarditem = {35018, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20003] = {id = 20003, missionname = "珍贵之物·铠甲", missionnameTextID = 1000042, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 8, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·商业区入口", locationTextID = 1000082, short_description = "找回商人的铠甲", short_descriptionTextID = 1000132, description = "商人最爱的铠甲放在<color=#82C65D>商业区入口</color>集市的店铺里，帮他寻回铠甲。", descriptionTextID = 1000188, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1962, 
rewarditem = {76001, 0}
, 
rewardquantity = {3, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20004] = {id = 20004, missionname = "索雷优的曲谱·异样", missionnameTextID = 1000043, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 12, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·沼", locationTextID = 1000083, short_description = "查看索雷优的状况", short_descriptionTextID = 1000133, description = "得到了曲谱的索雷优似乎有些奇怪，追上去看看到底发生了什么。", descriptionTextID = 1000189, startevent = 0, endevent = 200035, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1963, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20005] = {id = 20005, missionname = "珍贵之物·金银", missionnameTextID = 1000044, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 9, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·商业区", locationTextID = 1000080, short_description = "找回商人的金银", short_descriptionTextID = 1000134, description = "商人积攒的金银埋在<color=#82C65D>商业区</color>的店铺地下，帮他找回埋藏的金银。", descriptionTextID = 1000190, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1964, 
rewarditem = {35002, 0}
, 
rewardquantity = {5000, 0}
, unlockcondition = "20003", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20006] = {id = 20006, missionname = "珍贵之物·故乡", missionnameTextID = 1000045, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 13, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·近卫营外围", locationTextID = 1000084, short_description = "找到商人的积蓄", short_descriptionTextID = 1000135, description = "商人只剩下埋在故乡的一点积蓄了，向前方探索寻找艾琳岛，帮他回到自己的故乡。", descriptionTextID = 1000191, startevent = 0, endevent = 200000, loadevent = "200047", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1965, 
rewarditem = {35018, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "20005", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20007] = {id = 20007, missionname = "珍贵之物", missionnameTextID = 1000046, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 15, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·艾琳岛", locationTextID = 1000085, short_description = "找到商人真正的故乡", short_descriptionTextID = 1000136, description = "真正的珍贵之物是心中的故乡，在<color=#82C65D>艾琳岛</color>找到商人真正的故乡，替他完成遗愿。", descriptionTextID = 1000192, startevent = 200047, endevent = 200034, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1966, 
rewarditem = {35008, 0}
, 
rewardquantity = {40, 0}
, unlockcondition = "20006", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20008] = {id = 20008, missionname = "兄弟·返信", missionnameTextID = 1000047, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 16, worldname = 2, worldimg = 10587, backgroundtype = 10463, location = "伊敏瑟伦·巨木外围", locationTextID = 1000065, short_description = "将消息传递给等待的兄长", short_descriptionTextID = 1000137, description = "将弟弟也已经变成毛毛虫的消息传递给焦急的哥哥，他应该还在<color=#82C65D>商业区</color>或已经前往了<color=#82C65D>巨木外围</color>。", descriptionTextID = 1000193, startevent = 200048, endevent = 200049, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1967, 
rewarditem = {74000, 0}
, 
rewardquantity = {5, 0}
, unlockcondition = "20001", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20009] = {id = 20009, missionname = "寻找木材", missionnameTextID = 1000048, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 26, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·山脚猎场外围", locationTextID = 1000086, short_description = "帮村民安迪寻找木材", short_descriptionTextID = 1000138, description = "帮助村民安迪寻找<color=#82C65D>适合做拐杖的木材</color>，他会用宝物与你交换。", descriptionTextID = 1000194, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1968, 
rewarditem = {35018, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "20001", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20010] = {id = 20010, missionname = "教训偷粮贼", missionnameTextID = 1000049, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 25, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·村外冰原西部", locationTextID = 1000087, short_description = "教训偷走粮食的狐狸", short_descriptionTextID = 1000139, description = "村民的粮食被狡猾的狐狸偷走了，帮他找到粮食，教训那些狐狸。", descriptionTextID = 1000195, startevent = 200054, endevent = 200055, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1969, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20011] = {id = 20011, missionname = "归还行李", missionnameTextID = 1000050, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 36, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·崎岖山路后段", locationTextID = 1000088, short_description = "归还银弓的行李", short_descriptionTextID = 1000140, description = "雪狼偷走了银弓的行李，帮忙将银弓的行李还回去。据说银弓目前在<color=#82C65D>崎岖山路·后段</color>。", descriptionTextID = 1000196, startevent = 200072, endevent = 200073, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1970, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20012] = {id = 20012, missionname = "受伤的小狼", missionnameTextID = 1000051, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 31, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·山腰冰原", locationTextID = 1000071, short_description = "送受伤的小狼回家", short_descriptionTextID = 1000141, description = "将受伤的小狼送回家。", descriptionTextID = 1000197, startevent = 200074, endevent = 200075, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1971, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20013] = {id = 20013, missionname = "保护猎人·寻找白熊", missionnameTextID = 1000052, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 32, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·山腰岔路前段", locationTextID = 1000089, short_description = "询问银弓关于白熊的情报", short_descriptionTextID = 1000142, description = "白熊经常攻击附近的人类，收集关于白熊出没地点的情报吧。也许可以问问<color=#82C65D>银弓</color>，在途中留意一下他的身影吧。", descriptionTextID = 1000198, startevent = 200076, endevent = 200077, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1972, 
rewarditem = {76001, 0}
, 
rewardquantity = {3, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20014] = {id = 20014, missionname = "保护猎人·驱赶白熊", missionnameTextID = 1000053, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 37, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·冰封湖面", locationTextID = 1000090, short_description = "驱赶凶恶的白熊", short_descriptionTextID = 1000143, description = "打败凶恶的<color=#82C65D>白熊</color>，让他无法再伤害人类。", descriptionTextID = 1000199, startevent = 200078, endevent = 200079, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 1973, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20015] = {id = 20015, missionname = "归还猎弓", missionnameTextID = 1000054, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 59, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·冰封湖面", locationTextID = 1000090, short_description = "将猎弓还给年轻的猎人", short_descriptionTextID = 1000144, description = "因狩猎争执夺走了年轻人的猎弓，帮忙将它归还。他就在前面的<color=#82C65D>冰封湖面</color>。", descriptionTextID = 1000200, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2708, 
rewarditem = {35002, 0}
, 
rewardquantity = {6000, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20016] = {id = 20016, missionname = "想回家的小狼 ", missionnameTextID = 1000055, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 50, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·山腰冰原", locationTextID = 1000071, short_description = "带小狼回到狼群首领那里", short_descriptionTextID = 1000145, description = "前往<color=#82C65D>山脚冰原</color>，找到狼群首领。", descriptionTextID = 1000201, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2709, 
rewarditem = {76001, 0}
, 
rewardquantity = {4, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[20017] = {id = 20017, missionname = "储藏的食物", missionnameTextID = 1000056, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, jumpAim = 54, worldname = 3, worldimg = 11325, backgroundtype = 10463, location = "谢波契卡·山脚冰原", locationTextID = 1000074, short_description = "在附近寻找储藏的食物", short_descriptionTextID = 1000146, description = "小狐狸贮藏的食物应该就<color=#82C65D>在附近</color>，在周围找找看吧。", descriptionTextID = 1000202, startevent = 0, endevent = 200084, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200027}
, rewardtype = 0, rewardid = 2710, 
rewarditem = {35011, 0}
, 
rewardquantity = {20, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4", branchmission_item = 0}
, 
[60001] = {id = 60001, missionname = "“邀请”", missionnameTextID = 1000931, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 21, jumpAim = 5001, worldname = 101, worldimg = 10588, backgroundtype = 10464, location = "幕一——“邀请”", locationTextID = 1000937, short_description = "完成幕一——“邀请”", short_descriptionTextID = 1000943, description = "完成德亚丝-XX断片-XXXX-幕一——“邀请”", descriptionTextID = 1000949, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 0, 
rewarditem = {0, 0}
, 
rewardquantity = {0, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4,5,6,7", branchmission_item = 0}
, 
[60002] = {id = 60002, missionname = "“力量”", missionnameTextID = 1000932, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 21, jumpAim = 5002, worldname = 101, worldimg = 10588, backgroundtype = 10464, location = "幕二——“力量”", locationTextID = 1000938, short_description = "完成幕二——“力量”", short_descriptionTextID = 1000944, description = "完成德亚丝-XX断片-XXXX-幕二——“力量”", descriptionTextID = 1000950, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 0, 
rewarditem = {0, 0}
, 
rewardquantity = {0, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4,5,6,7", branchmission_item = 0}
, 
[60003] = {id = 60003, missionname = "“志同道合”", missionnameTextID = 1000933, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 21, jumpAim = 5003, worldname = 101, worldimg = 10588, backgroundtype = 10464, location = "幕三——“志同道合”", locationTextID = 1000939, short_description = "完成幕三——“志同道合”", short_descriptionTextID = 1000945, description = "完成德亚丝-XX断片-XXXX-幕三——“志同道合”", descriptionTextID = 1000951, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 0, 
rewarditem = {0, 0}
, 
rewardquantity = {0, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4,5,6,7", branchmission_item = 0}
, 
[60004] = {id = 60004, missionname = "“秘密”", missionnameTextID = 1000934, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 21, jumpAim = 5004, worldname = 101, worldimg = 10588, backgroundtype = 10464, location = "幕四——“秘密”", locationTextID = 1000940, short_description = "完成幕四——“秘密”", short_descriptionTextID = 1000946, description = "完成德亚丝-XX断片-XXXX-幕四——“秘密”", descriptionTextID = 1000952, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 0, 
rewarditem = {0, 0}
, 
rewardquantity = {0, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4,5,6,7", branchmission_item = 0}
, 
[60005] = {id = 60005, missionname = "“不期而遇”", missionnameTextID = 1000935, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 21, jumpAim = 5005, worldname = 101, worldimg = 10588, backgroundtype = 10463, location = "幕五——“不期而遇”", locationTextID = 1000941, short_description = "完成幕五——“不期而遇”", short_descriptionTextID = 1000947, description = "完成德亚丝-XX断片-XXXX-幕五——“不期而遇”", descriptionTextID = 1000953, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 0, 
rewarditem = {0, 0}
, 
rewardquantity = {0, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4,5,6,7", branchmission_item = 0}
, 
[60006] = {id = 60006, missionname = "“礼物”", missionnameTextID = 1000936, missiontype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 21, jumpAim = 5006, worldname = 101, worldimg = 10588, backgroundtype = 10463, location = "幕六——“礼物”", locationTextID = 1000942, short_description = "完成幕六——“礼物”", short_descriptionTextID = 1000948, description = "完成德亚丝-XX断片-XXXX-幕六——“礼物”", descriptionTextID = 1000954, startevent = 0, endevent = 200000, loadevent = "", loadtag = 0, accept_mission = 200028, 
progressname = {}
, 
progressnameTextID = {}
, 
toptip = {200005}
, rewardtype = 0, rewardid = 0, 
rewarditem = {0, 0}
, 
rewardquantity = {0, 0}
, unlockcondition = "0", chapter = 0, lastchapter = "0,1,2,3,4,5,6,7", branchmission_item = 0}
}
cmissionconfig.AllIds = {10001, 10002, 10003, 10004, 10006, 10008, 10011, 10012, 10017, 10019, 10020, 10021, 10022, 10023, 10024, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 10042, 10043, 10044, 10045, 10046, 10047, 10048, 10049, 20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010, 20011, 20012, 20013, 20014, 20015, 20016, 20017, 60001, 60002, 60003, 60004, 60005, 60006}
return cmissionconfig

