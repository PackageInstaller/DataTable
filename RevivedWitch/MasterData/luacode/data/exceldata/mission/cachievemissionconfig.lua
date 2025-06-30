-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/mission/cachievemissionconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cachievemissionconfig = {}
cachievemissionconfig.Data = {
[40000] = {id = 40000, missionname = "异境的联络", missionnameTextID = 1000374, tabID = 4, groupID = 23, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 15, description = "拥有第一个好友", descriptionTextID = 1001343, endevent = 33, rewardid = 2826, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 31, unlockcondition = "2,16", unlockid = 1001352}
, 
[40001] = {id = 40001, missionname = "踏入异境", missionnameTextID = 1000361, tabID = 1, groupID = 1, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败时空监视者", descriptionTextID = 1000438, endevent = 20, rewardid = 1848, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001256}
, 
[40002] = {id = 40002, missionname = "香消玉殒", missionnameTextID = 1000362, tabID = 1, groupID = 2, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败弗莱尔", descriptionTextID = 1000439, endevent = 21, rewardid = 1849, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001257}
, 
[40003] = {id = 40003, missionname = "拯救伊敏瑟伦", missionnameTextID = 1000363, tabID = 1, groupID = 3, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败埃舍雷", descriptionTextID = 1000440, endevent = 22, rewardid = 1850, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001258}
, 
[40004] = {id = 40004, missionname = "凶恶之熊", missionnameTextID = 1000364, tabID = 1, groupID = 4, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败赫沃奥塔", descriptionTextID = 1000441, endevent = 23, rewardid = 1851, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001259}
, 
[40005] = {id = 40005, missionname = "风雪消停", missionnameTextID = 1000365, tabID = 1, groupID = 5, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败瑟希薇", descriptionTextID = 1000442, endevent = 24, rewardid = 1852, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001260}
, 
[40006] = {id = 40006, missionname = "拯救谢波契卡", missionnameTextID = 1000366, tabID = 1, groupID = 6, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败辛莫拉", descriptionTextID = 1000443, endevent = 25, rewardid = 1853, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001261}
, 
[40007] = {id = 40007, missionname = "宝箱收集者", missionnameTextID = 1000340, tabID = 1, groupID = 7, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计打开100个宝箱", descriptionTextID = 1000417, endevent = 5, rewardid = 1854, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001262}
, 
[40008] = {id = 40008, missionname = "宝箱收集者", missionnameTextID = 1000341, tabID = 1, groupID = 7, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计打开500个宝箱", descriptionTextID = 1000418, endevent = 6, rewardid = 1855, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001263}
, 
[40009] = {id = 40009, missionname = "玛那收集者", missionnameTextID = 1000343, tabID = 1, groupID = 8, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计打开50个玛那晶簇", descriptionTextID = 1000420, endevent = 8, rewardid = 1856, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001264}
, 
[40010] = {id = 40010, missionname = "玛那收集者", missionnameTextID = 1000344, tabID = 1, groupID = 8, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计打开250个玛那晶簇", descriptionTextID = 1000421, endevent = 9, rewardid = 1857, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001265}
, 
[40011] = {id = 40011, missionname = "魔物猎手", missionnameTextID = 1000336, tabID = 1, groupID = 9, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计击败50个怪物", descriptionTextID = 1000413, endevent = 1, rewardid = 1858, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 7, unlockcondition = "1,3", unlockid = 1001266}
, 
[40012] = {id = 40012, missionname = "魔物猎手", missionnameTextID = 1000337, tabID = 1, groupID = 9, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计击败500个怪物", descriptionTextID = 1000414, endevent = 2, rewardid = 1859, 
rewarditem = {35008, 31070}
, 
rewardquantity = {80, 1}
, achievePoint = 10, badgeID = 8, unlockcondition = "1,3", unlockid = 1001267}
, 
[40013] = {id = 40013, missionname = "魔物猎手", missionnameTextID = 1000338, tabID = 1, groupID = 9, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计击败2000个怪物", descriptionTextID = 1000415, endevent = 3, rewardid = 1860, 
rewarditem = {35008, 31070}
, 
rewardquantity = {200, 1}
, achievePoint = 10, badgeID = 9, unlockcondition = "1,3", unlockid = 1001268}
, 
[40014] = {id = 40014, missionname = "汇聚魔力", missionnameTextID = 1000348, tabID = 3, groupID = 10, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计获得10万玛那", descriptionTextID = 1000425, endevent = 13, rewardid = 1861, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 13, unlockcondition = "1,3", unlockid = 1001269}
, 
[40015] = {id = 40015, missionname = "汇聚魔力", missionnameTextID = 1000349, tabID = 3, groupID = 10, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计获得500万玛那", descriptionTextID = 1000426, endevent = 14, rewardid = 1862, 
rewarditem = {35008, 31070}
, 
rewardquantity = {80, 1}
, achievePoint = 10, badgeID = 14, unlockcondition = "1,3", unlockid = 1001270}
, 
[40016] = {id = 40016, missionname = "汇聚魔力", missionnameTextID = 1000350, tabID = 3, groupID = 10, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计获得5000万玛那", descriptionTextID = 1000427, endevent = 15, rewardid = 1863, 
rewarditem = {35008, 31070}
, 
rewardquantity = {500, 1}
, achievePoint = 10, badgeID = 15, unlockcondition = "1,3", unlockid = 1001271}
, 
[40017] = {id = 40017, missionname = "装备收集者", missionnameTextID = 1000354, tabID = 3, groupID = 11, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计获得20件装备", descriptionTextID = 1000431, endevent = 49, rewardid = 1864, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001272}
, 
[40018] = {id = 40018, missionname = "装备收集者", missionnameTextID = 1000355, tabID = 3, groupID = 11, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计获得200件装备", descriptionTextID = 1000432, endevent = 50, rewardid = 1865, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001273}
, 
[40019] = {id = 40019, missionname = "装备收集者", missionnameTextID = 1000356, tabID = 3, groupID = 11, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计获得500件装备", descriptionTextID = 1000433, endevent = 51, rewardid = 1866, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001274}
, 
[40020] = {id = 40020, missionname = "梦境世界", missionnameTextID = 1001153, tabID = 3, groupID = 12, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "通关梦境世界全部关卡", descriptionTextID = 1001154, endevent = 117, rewardid = 1867, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,4", unlockid = 1001275}
, 
[40021] = {id = 40021, missionname = "战斗技巧", missionnameTextID = 1000982, tabID = 1, groupID = 13, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "打断1次敌人施法", descriptionTextID = 1001004, endevent = 118, rewardid = 1868, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001276}
, 
[40022] = {id = 40022, missionname = "突破上限", missionnameTextID = 1000370, tabID = 3, groupID = 14, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "任意3个人偶达到突破1阶", descriptionTextID = 1000447, endevent = 29, rewardid = 1869, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 28, unlockcondition = "1,3", unlockid = 1001277}
, 
[40023] = {id = 40023, missionname = "突破上限", missionnameTextID = 1001167, tabID = 3, groupID = 14, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "任意3个人偶达到突破2阶", descriptionTextID = 1001170, endevent = 30, rewardid = 1870, 
rewarditem = {35008, 31070}
, 
rewardquantity = {80, 1}
, achievePoint = 10, badgeID = 29, unlockcondition = "1,3", unlockid = 1001278}
, 
[40024] = {id = 40024, missionname = "突破上限", missionnameTextID = 1001168, tabID = 3, groupID = 14, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "任意3个人偶达到突破3阶", descriptionTextID = 1001171, endevent = 31, rewardid = 1871, 
rewarditem = {35008, 31070}
, 
rewardquantity = {200, 1}
, achievePoint = 10, badgeID = 30, unlockcondition = "1,3", unlockid = 1001279}
, 
[40025] = {id = 40025, missionname = "突破上限", missionnameTextID = 1001169, tabID = 3, groupID = 14, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "3个人偶达到突破4阶", descriptionTextID = 1001172, endevent = 149, rewardid = 1872, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001280}
, 
[40026] = {id = 40026, missionname = "进化之力", missionnameTextID = 1000988, tabID = 3, groupID = 15, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 4, description = "累计1个人偶达到进化1级", descriptionTextID = 1001010, endevent = 119, rewardid = 1873, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001281}
, 
[40027] = {id = 40027, missionname = "进化之力", missionnameTextID = 1000988, tabID = 3, groupID = 15, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 4, description = "累计3个人偶达到进化2级", descriptionTextID = 1001011, endevent = 120, rewardid = 1874, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001282}
, 
[40028] = {id = 40028, missionname = "进化之力", missionnameTextID = 1000989, tabID = 3, groupID = 15, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 4, description = "累计6个人偶达到进化3级", descriptionTextID = 1001173, endevent = 150, rewardid = 1875, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001283}
, 
[40029] = {id = 40029, missionname = "人偶收集者", missionnameTextID = 1000391, tabID = 2, groupID = 16, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "拥有10个人偶", descriptionTextID = 1000468, endevent = 46, rewardid = 1876, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001284}
, 
[40030] = {id = 40030, missionname = "人偶收集者", missionnameTextID = 1000392, tabID = 2, groupID = 16, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "拥有30个人偶", descriptionTextID = 1000469, endevent = 47, rewardid = 1877, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001285}
, 
[40031] = {id = 40031, missionname = "人偶收集者", missionnameTextID = 1000393, tabID = 2, groupID = 16, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "拥有50个人偶", descriptionTextID = 1000470, endevent = 48, rewardid = 1878, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001286}
, 
[40032] = {id = 40032, missionname = "一心同体", missionnameTextID = 1000394, tabID = 2, groupID = 17, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "任意人偶的羁绊等级达到2", descriptionTextID = 1000471, endevent = 59, rewardid = 1879, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 4, unlockcondition = "1,6", unlockid = 1001287}
, 
[40033] = {id = 40033, missionname = "一心同体", missionnameTextID = 1000395, tabID = 2, groupID = 17, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "任意人偶的羁绊等级达到10", descriptionTextID = 1000472, endevent = 60, rewardid = 1880, 
rewarditem = {35008, 31070}
, 
rewardquantity = {80, 1}
, achievePoint = 10, badgeID = 5, unlockcondition = "1,6", unlockid = 1001288}
, 
[40034] = {id = 40034, missionname = "一心同体", missionnameTextID = 1000396, tabID = 2, groupID = 17, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 8, description = "任意人偶的羁绊等级达到20", descriptionTextID = 1000473, endevent = 61, rewardid = 1881, 
rewarditem = {35008, 31070}
, 
rewardquantity = {200, 1}
, achievePoint = 10, badgeID = 6, unlockcondition = "1,6", unlockid = 1001289}
, 
[40035] = {id = 40035, missionname = "技能之力", missionnameTextID = 1000990, tabID = 3, groupID = 18, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 11, description = "任意1个人偶技能提升至满级", descriptionTextID = 1001012, endevent = 121, rewardid = 1882, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001290}
, 
[40036] = {id = 40036, missionname = "技能之力", missionnameTextID = 1000991, tabID = 3, groupID = 18, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 11, description = "任意3个人偶技能提升至满级", descriptionTextID = 1001013, endevent = 122, rewardid = 1883, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001291}
, 
[40037] = {id = 40037, missionname = "时尚达人", missionnameTextID = 1000992, tabID = 2, groupID = 19, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "获得1个人偶外观", descriptionTextID = 1001014, endevent = 123, rewardid = 1884, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001292}
, 
[40038] = {id = 40038, missionname = "时尚达人", missionnameTextID = 1000993, tabID = 2, groupID = 19, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "获得10个不同的人偶外观", descriptionTextID = 1001015, endevent = 124, rewardid = 1885, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001293}
, 
[40039] = {id = 40039, missionname = "锻造术", missionnameTextID = 1001174, tabID = 3, groupID = 20, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "任意装备强化至5级", descriptionTextID = 1001175, endevent = 151, rewardid = 1886, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001294}
, 
[40040] = {id = 40040, missionname = "锻造术", missionnameTextID = 1000994, tabID = 3, groupID = 20, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "3个装备强化至20级", descriptionTextID = 1001016, endevent = 125, rewardid = 1887, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001295}
, 
[40041] = {id = 40041, missionname = "锻造术", missionnameTextID = 1000995, tabID = 3, groupID = 20, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "3个装备强化至40级", descriptionTextID = 1001017, endevent = 126, rewardid = 1888, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001296}
, 
[40042] = {id = 40042, missionname = "装备附魔", missionnameTextID = 1000406, tabID = 3, groupID = 21, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "进行1次装备附魔", descriptionTextID = 1000483, endevent = 71, rewardid = 1889, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,20", unlockid = 1001297}
, 
[40043] = {id = 40043, missionname = "装备附魔", missionnameTextID = 1000407, tabID = 3, groupID = 21, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "累计进行装备附魔100次", descriptionTextID = 1000484, endevent = 72, rewardid = 1890, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,20", unlockid = 1001298}
, 
[40044] = {id = 40044, missionname = "装备附魔", missionnameTextID = 1000408, tabID = 3, groupID = 21, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "累计进行装备附魔500次", descriptionTextID = 1000485, endevent = 73, rewardid = 1891, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,20", unlockid = 1001299}
, 
[40045] = {id = 40045, missionname = "装备突破", missionnameTextID = 1001176, tabID = 3, groupID = 22, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "进行1次装备突破", descriptionTextID = 1001177, endevent = 152, rewardid = 1892, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001300}
, 
[40046] = {id = 40046, missionname = "装备突破", missionnameTextID = 1000996, tabID = 3, groupID = 22, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "累计3个装备达到突破2级", descriptionTextID = 1001018, endevent = 127, rewardid = 1893, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001301}
, 
[40047] = {id = 40047, missionname = "装备突破", missionnameTextID = 1000997, tabID = 3, groupID = 22, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 13, description = "累计3个装备达到突破3级", descriptionTextID = 1001019, endevent = 128, rewardid = 1894, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001302}
, 
[40048] = {id = 40048, missionname = "异境的联络", missionnameTextID = 1000375, tabID = 4, groupID = 23, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 15, description = "拥有10名好友", descriptionTextID = 1000452, endevent = 34, rewardid = 3183, 
rewarditem = {35008, 31070}
, 
rewardquantity = {80, 1}
, achievePoint = 10, badgeID = 32, unlockcondition = "2,16", unlockid = 1001303}
, 
[40049] = {id = 40049, missionname = "异境的联络", missionnameTextID = 1000376, tabID = 4, groupID = 23, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 15, description = "拥有100名好友", descriptionTextID = 1000453, endevent = 35, rewardid = 3184, 
rewarditem = {35008, 31070}
, 
rewardquantity = {500, 1}
, achievePoint = 10, badgeID = 33, unlockcondition = "2,16", unlockid = 1001304}
, 
[40050] = {id = 40050, missionname = "友谊之心", missionnameTextID = 1000771, tabID = 4, groupID = 24, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 15, description = "累计获得200点友情点", descriptionTextID = 1000772, endevent = 106, rewardid = 1897, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,16", unlockid = 1001305}
, 
[40051] = {id = 40051, missionname = "友谊之心", missionnameTextID = 1000757, tabID = 4, groupID = 24, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 15, description = "累计获得1000点友情点", descriptionTextID = 1000740, endevent = 92, rewardid = 1898, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,16", unlockid = 1001306}
, 
[40052] = {id = 40052, missionname = "友谊之心", missionnameTextID = 1000758, tabID = 4, groupID = 24, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 15, description = "累计获得5000点友情点", descriptionTextID = 1000741, endevent = 93, rewardid = 1899, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,16", unlockid = 1001307}
, 
[40053] = {id = 40053, missionname = "人偶收藏家", missionnameTextID = 1000759, tabID = 2, groupID = 25, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 5, description = "累计抽卡30次", descriptionTextID = 1000742, endevent = 94, rewardid = 1900, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001308}
, 
[40054] = {id = 40054, missionname = "人偶收藏家", missionnameTextID = 1000760, tabID = 2, groupID = 25, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 5, description = "累计抽卡100次", descriptionTextID = 1000743, endevent = 95, rewardid = 1901, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001309}
, 
[40055] = {id = 40055, missionname = "人偶收藏家", missionnameTextID = 1000761, tabID = 2, groupID = 25, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 5, description = "累计抽卡500次", descriptionTextID = 1000744, endevent = 96, rewardid = 1902, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001310}
, 
[40056] = {id = 40056, missionname = "人偶收藏家", missionnameTextID = 1000762, tabID = 2, groupID = 25, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 5, description = "累计抽卡1000次", descriptionTextID = 1000745, endevent = 97, rewardid = 1903, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001311}
, 
[40057] = {id = 40057, missionname = "友谊的价值", missionnameTextID = 1000763, tabID = 4, groupID = 26, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "在友情点商城购买50次道具", descriptionTextID = 1000746, endevent = 98, rewardid = 1904, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,18", unlockid = 1001312}
, 
[40058] = {id = 40058, missionname = "友谊的价值", missionnameTextID = 1000764, tabID = 4, groupID = 26, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "在友情点商城购买100次道具", descriptionTextID = 1000747, endevent = 99, rewardid = 1905, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,18", unlockid = 1001313}
, 
[40059] = {id = 40059, missionname = "梦境螺旋", missionnameTextID = 1000999, tabID = 3, groupID = 27, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "梦境螺旋满级1次", descriptionTextID = 1001021, endevent = 130, rewardid = 1906, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001314}
, 
[40060] = {id = 40060, missionname = "梦境螺旋", missionnameTextID = 1001000, tabID = 3, groupID = 27, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "梦境螺旋满级2次", descriptionTextID = 1001022, endevent = 131, rewardid = 1907, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001315}
, 
[40061] = {id = 40061, missionname = "收集达人", missionnameTextID = 1000765, tabID = 3, groupID = 28, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "获得100点家具币", descriptionTextID = 1000748, endevent = 100, rewardid = 1908, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001316}
, 
[40062] = {id = 40062, missionname = "收集达人", missionnameTextID = 1000766, tabID = 3, groupID = 28, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "获得1000点家具币", descriptionTextID = 1000749, endevent = 101, rewardid = 1909, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001317}
, 
[40063] = {id = 40063, missionname = "收集达人", missionnameTextID = 1000767, tabID = 3, groupID = 28, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 19, description = "获得5000点家具币", descriptionTextID = 1000750, endevent = 102, rewardid = 1910, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001318}
, 
[40064] = {id = 40064, missionname = "异界之镜", missionnameTextID = 1000384, tabID = 3, groupID = 29, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "在庭院探索异界之镜1次", descriptionTextID = 1000461, endevent = 43, rewardid = 1911, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001319}
, 
[40065] = {id = 40065, missionname = "异界之镜", missionnameTextID = 1000385, tabID = 3, groupID = 29, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "累计在庭院探索异界之镜20次", descriptionTextID = 1000462, endevent = 55, rewardid = 1912, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001320}
, 
[40066] = {id = 40066, missionname = "异界之镜", missionnameTextID = 1000386, tabID = 3, groupID = 29, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "累计在庭院探索异界之镜100次", descriptionTextID = 1000463, endevent = 56, rewardid = 1913, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001321}
, 
[40067] = {id = 40067, missionname = "炼金术", missionnameTextID = 1001001, tabID = 3, groupID = 30, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "进行1次炼金", descriptionTextID = 1001023, endevent = 132, rewardid = 1914, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001322}
, 
[40068] = {id = 40068, missionname = "炼金术", missionnameTextID = 1001002, tabID = 3, groupID = 30, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "进行50次炼金", descriptionTextID = 1001024, endevent = 133, rewardid = 1915, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001323}
, 
[40069] = {id = 40069, missionname = "炼金术", missionnameTextID = 1001003, tabID = 3, groupID = 30, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "进行100次炼金", descriptionTextID = 1001025, endevent = 134, rewardid = 1916, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001324}
, 
[40070] = {id = 40070, missionname = "温馨家园", missionnameTextID = 1000780, tabID = 3, groupID = 31, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "庭院全部建筑达到满级", descriptionTextID = 1000776, endevent = 66, rewardid = 1917, 
rewarditem = {35008, 31070}
, 
rewardquantity = {500, 1}
, achievePoint = 10, badgeID = 24, unlockcondition = "2,8", unlockid = 1001325}
, 
[40071] = {id = 40071, missionname = "主题家具", missionnameTextID = 1001100, tabID = 3, groupID = 32, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "使用1套家具主题", descriptionTextID = 1001101, endevent = 140, rewardid = 1918, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001326}
, 
[40072] = {id = 40072, missionname = "主题家具", missionnameTextID = 1001102, tabID = 3, groupID = 32, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "使用5套不同的家具主题", descriptionTextID = 1001103, endevent = 141, rewardid = 1919, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001327}
, 
[40073] = {id = 40073, missionname = "主题家具", missionnameTextID = 1001104, tabID = 3, groupID = 32, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "使用10套不同的家具主题", descriptionTextID = 1001105, endevent = 142, rewardid = 1920, 
rewarditem = {35008}
, 
rewardquantity = {500}
, achievePoint = 10, badgeID = 0, unlockcondition = "2,8", unlockid = 1001328}
, 
[40077] = {id = 40077, missionname = "破碎之境", missionnameTextID = 1001106, tabID = 3, groupID = 34, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 30, description = "通关1次破碎之境", descriptionTextID = 1001107, endevent = 143, rewardid = 2663, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "3,35", unlockid = 1001329}
, 
[40078] = {id = 40078, missionname = "破碎之境", missionnameTextID = 1001108, tabID = 3, groupID = 34, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 30, description = "通关5次破碎之境", descriptionTextID = 1001109, endevent = 144, rewardid = 2664, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "3,35", unlockid = 1001330}
, 
[40079] = {id = 40079, missionname = "破碎之境", missionnameTextID = 1001110, tabID = 3, groupID = 34, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 30, description = "通关20次破碎之境", descriptionTextID = 1001111, endevent = 145, rewardid = 2665, 
rewarditem = {35008}
, 
rewardquantity = {200}
, achievePoint = 10, badgeID = 0, unlockcondition = "3,35", unlockid = 1001331}
, 
[40083] = {id = 40083, missionname = "回溯梦境", missionnameTextID = 1000378, tabID = 1, groupID = 36, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "第一次通关梦境世界", descriptionTextID = 1001335, endevent = 37, rewardid = 2816, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 1, unlockcondition = "1,3", unlockid = 1001344}
, 
[40084] = {id = 40084, missionname = "茁壮成长", missionnameTextID = 1000398, tabID = 3, groupID = 37, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "魔法树达到3级", descriptionTextID = 1001336, endevent = 63, rewardid = 2817, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 18, unlockcondition = "2,8", unlockid = 1001345}
, 
[40085] = {id = 40085, missionname = "肩负使命", missionnameTextID = 1000357, tabID = 1, groupID = 38, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 0, description = "累计完成10个任务", descriptionTextID = 1000434, endevent = 52, rewardid = 2818, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 19, unlockcondition = "1,3", unlockid = 1001346}
, 
[40086] = {id = 40086, missionname = "肩负使命", missionnameTextID = 1000358, tabID = 1, groupID = 38, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 0, description = "累计完成100个任务", descriptionTextID = 1000435, endevent = 53, rewardid = 2819, 
rewarditem = {35008, 31070}
, 
rewardquantity = {80, 1}
, achievePoint = 10, badgeID = 20, unlockcondition = "1,3", unlockid = 1001347}
, 
[40087] = {id = 40087, missionname = "肩负使命", missionnameTextID = 1000359, tabID = 1, groupID = 38, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 0, description = "累计完成200个任务", descriptionTextID = 1000436, endevent = 54, rewardid = 2820, 
rewarditem = {35008, 31070}
, 
rewardquantity = {500, 1}
, achievePoint = 10, badgeID = 21, unlockcondition = "1,3", unlockid = 1001348}
, 
[40088] = {id = 40088, missionname = "探索未知", missionnameTextID = 1000351, tabID = 1, groupID = 39, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计完成一次关卡", descriptionTextID = 1000428, endevent = 16, rewardid = 2821, 
rewarditem = {35008, 31070}
, 
rewardquantity = {40, 1}
, achievePoint = 10, badgeID = 25, unlockcondition = "1,3", unlockid = 1001349}
, 
[40089] = {id = 40089, missionname = "探索未知", missionnameTextID = 1000352, tabID = 1, groupID = 39, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计完成50次关卡", descriptionTextID = 1000429, endevent = 17, rewardid = 2822, 
rewarditem = {35008, 31070}
, 
rewardquantity = {80, 1}
, achievePoint = 10, badgeID = 26, unlockcondition = "1,3", unlockid = 1001350}
, 
[40090] = {id = 40090, missionname = "探索未知", missionnameTextID = 1000353, tabID = 1, groupID = 39, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计完成100次关卡", descriptionTextID = 1000430, endevent = 18, rewardid = 2823, 
rewarditem = {35008, 31070}
, 
rewardquantity = {500, 1}
, achievePoint = 10, badgeID = 27, unlockcondition = "1,3", unlockid = 1001351}
, 
[40091] = {id = 40091, missionname = "分享经历", missionnameTextID = 1001599, tabID = 4, groupID = 40, missiontype = 4, jumptype = -1, 
jumpvalue = {0}
, UIjumpvalue = 0, description = "完成1次评论", descriptionTextID = 1001600, endevent = 107, rewardid = 2826, 
rewarditem = {35008}
, 
rewardquantity = {40}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001347}
, 
[40095] = {id = 40095, missionname = "嘉庇艾尔的未来", missionnameTextID = 1001657, tabID = 1, groupID = 41, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败卡蜜莉安", descriptionTextID = 1001658, endevent = 153, rewardid = 4069, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001347}
, 
[40096] = {id = 40096, missionname = "剑的选择", missionnameTextID = 1001659, tabID = 1, groupID = 42, missiontype = 4, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "击败阿卡莎", descriptionTextID = 1001660, endevent = 154, rewardid = 4070, 
rewarditem = {35008}
, 
rewardquantity = {80}
, achievePoint = 10, badgeID = 0, unlockcondition = "1,3", unlockid = 1001347}
}
cachievemissionconfig.AllIds = {40000, 40001, 40002, 40003, 40004, 40005, 40006, 40007, 40008, 40009, 40010, 40011, 40012, 40013, 40014, 40015, 40016, 40017, 40018, 40019, 40020, 40021, 40022, 40023, 40024, 40025, 40026, 40027, 40028, 40029, 40030, 40031, 40032, 40033, 40034, 40035, 40036, 40037, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40046, 40047, 40048, 40049, 40050, 40051, 40052, 40053, 40054, 40055, 40056, 40057, 40058, 40059, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40067, 40068, 40069, 40070, 40071, 40072, 40073, 40077, 40078, 40079, 40083, 40084, 40085, 40086, 40087, 40088, 40089, 40090, 40091, 40095, 40096}
return cachievemissionconfig

