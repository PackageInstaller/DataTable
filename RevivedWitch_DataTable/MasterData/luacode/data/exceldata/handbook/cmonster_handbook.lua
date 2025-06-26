-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/handbook/cmonster_handbook.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cmonster_handbook = {}
cmonster_handbook.Data = {
[92] = {id = 92, name = "咒术书·炎", nameTextID = 1300156, monsterType = 0, isShow = 0, monsterNumber = "T-19", miniIcon = 11117, shapeID = 20056, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201248, 201249}
, 
tag = {1304843}
, descriptionTextID = 1300261}
, 
[93] = {id = 93, name = "咒术书·土", nameTextID = 1300157, monsterType = 0, isShow = 0, monsterNumber = "T-20", miniIcon = 11118, shapeID = 20057, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201252, 201253}
, 
tag = {1304822}
, descriptionTextID = 1300244}
, 
[94] = {id = 94, name = "咒术书·水", nameTextID = 1300158, monsterType = 0, isShow = 0, monsterNumber = "T-21", miniIcon = 11119, shapeID = 20058, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201250, 201251}
, 
tag = {1304823}
, descriptionTextID = 1300262}
, 
[101] = {id = 101, name = "石像怪", nameTextID = 1300080, monsterType = 0, isShow = 1, monsterNumber = "T-01", miniIcon = 11103, shapeID = 20154, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.66, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201641}
, 
tag = {1304843}
, descriptionTextID = 1300186}
, 
[102] = {id = 102, name = "古塔蝙蝠", nameTextID = 1300082, monsterType = 0, isShow = 1, monsterNumber = "T-02", miniIcon = 11102, shapeID = 20007, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.62, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201020}
, 
tag = {1304843}
, descriptionTextID = 1300188}
, 
[103] = {id = 103, name = "咒术书·雷", nameTextID = 1300083, monsterType = 0, isShow = 1, monsterNumber = "T-03", miniIcon = 11104, shapeID = 20005, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.62, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201246, 201247}
, 
tag = {1304824}
, descriptionTextID = 1300189}
, 
[104] = {id = 104, name = "古塔幼蝠", nameTextID = 1300084, monsterType = 0, isShow = 1, monsterNumber = "T-04", miniIcon = 11115, shapeID = 20040, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.32, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201081}
, 
tag = {1304843}
, descriptionTextID = 1300190}
, 
[105] = {id = 105, name = "魅魔", nameTextID = 1300085, monsterType = 0, isShow = 1, monsterNumber = "T-05", miniIcon = 11105, shapeID = 20008, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.77, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201018, 201019}
, 
tag = {1304822, 1304833}
, descriptionTextID = 1300191}
, 
[106] = {id = 106, name = "石像鬼", nameTextID = 1300081, monsterType = 1, isShow = 1, monsterNumber = "T-06", miniIcon = 11101, shapeID = 20003, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.6, adScore = 0.3, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201017, 201008}
, 
tag = {1304843}
, descriptionTextID = 1300187}
, 
[107] = {id = 107, name = "怨念聚合体", nameTextID = 1300086, monsterType = 1, isShow = 1, monsterNumber = "T-07", miniIcon = 11111, shapeID = 20030, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.83, adScore = 0.5, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201038, 201042, 201039, 201040}
, 
tag = {1304822}
, descriptionTextID = 1300192}
, 
[108] = {id = 108, name = "次元监视者", nameTextID = 1300087, monsterType = 1, isShow = 1, monsterNumber = "T-08", miniIcon = 11097, shapeID = 20006, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.76, adScore = 0.5, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201016, 201012, 201215, 201013, 201014, 201047}
, 
tag = {1304822}
, descriptionTextID = 1300193}
, 
[201] = {id = 201, name = "史莱姆", nameTextID = 1300167, monsterType = 0, isShow = 1, monsterNumber = "I-01", miniIcon = 11107, shapeID = 20023, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.39, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201074}
, 
tag = {1304825, 1304823}
, descriptionTextID = 1300194}
, 
[202] = {id = 202, name = "史莱姆", nameTextID = 1300167, monsterType = 0, isShow = 0, monsterNumber = "F-02", miniIcon = 11108, shapeID = 20024, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.39, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201074}
, 
tag = {1304825, 1304823}
, descriptionTextID = 1300195}
, 
[203] = {id = 203, name = "史莱姆", nameTextID = 1300167, monsterType = 0, isShow = 0, monsterNumber = "F-03", miniIcon = 11109, shapeID = 20025, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.49, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201074}
, 
tag = {1304825, 1304823}
, descriptionTextID = 1300196}
, 
[204] = {id = 204, name = "史莱姆", nameTextID = 1300167, monsterType = 0, isShow = 0, monsterNumber = "F-04", miniIcon = 11110, shapeID = 20026, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.49, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201074}
, 
tag = {1304825, 1304823}
, descriptionTextID = 1300197}
, 
[206] = {id = 206, name = "连射藤蔓", nameTextID = 1300092, monsterType = 0, isShow = 1, monsterNumber = "I-02", miniIcon = 11128, shapeID = 10005, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.48, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201065, 201022}
, 
tag = {1304843}
, descriptionTextID = 1300198}
, 
[208] = {id = 208, name = "变异藤蔓", nameTextID = 1300093, monsterType = 0, isShow = 1, monsterNumber = "I-03", miniIcon = 11127, shapeID = 20013, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.48, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201065, 201022, 201068}
, 
tag = {1304826}
, descriptionTextID = 1300199}
, 
[209] = {id = 209, name = "毒伞菇", nameTextID = 1300094, monsterType = 0, isShow = 1, monsterNumber = "I-04", miniIcon = 11120, shapeID = 10015, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.49, adScore = 0.01, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201066}
, 
tag = {1304827}
, descriptionTextID = 1300200}
, 
[210] = {id = 210, name = "青伞菇", nameTextID = 1300095, monsterType = 0, isShow = 0, monsterNumber = "F-10", miniIcon = 11121, shapeID = 10014, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.3, adScore = 0.01, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201024}
, 
tag = {1304843}
, descriptionTextID = 1300201}
, 
[211] = {id = 211, name = "绿伞菇", nameTextID = 1300096, monsterType = 0, isShow = 0, monsterNumber = "F-05", miniIcon = 11126, shapeID = 20011, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.3, adScore = 0.01, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201024}
, 
tag = {1304843}
, descriptionTextID = 1300202}
, 
[212] = {id = 212, name = "松树精", nameTextID = 1300097, monsterType = 0, isShow = 1, monsterNumber = "I-05", miniIcon = 11122, shapeID = 10031, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.49, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201021, 201231}
, 
tag = {1304843}
, descriptionTextID = 1300203}
, 
[213] = {id = 213, name = "花树精", nameTextID = 1300098, monsterType = 0, isShow = 1, monsterNumber = "I-06", miniIcon = 11123, shapeID = 10033, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.47, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201021, 201231, 201067}
, 
tag = {1304828}
, descriptionTextID = 1300204}
, 
[214] = {id = 214, name = "小史莱姆", nameTextID = 1300099, monsterType = 0, isShow = 1, monsterNumber = "I-07", miniIcon = 11135, shapeID = 20053, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.2, adScore = 0.01, apScore = 0.2, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201074}
, 
tag = {1304823}
, descriptionTextID = 1300205}
, 
[215] = {id = 215, name = "小史莱姆", nameTextID = 1300099, monsterType = 0, isShow = 0, monsterNumber = "F-15", miniIcon = 11136, shapeID = 20063, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.2, adScore = 0.01, apScore = 0.2, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201074}
, 
tag = {1304823}
, descriptionTextID = 1300206}
, 
[216] = {id = 216, name = "小史莱姆", nameTextID = 1300099, monsterType = 0, isShow = 0, monsterNumber = "F-16", miniIcon = 11137, shapeID = 20064, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.2, adScore = 0.01, apScore = 0.2, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201074}
, 
tag = {1304823}
, descriptionTextID = 1300207}
, 
[217] = {id = 217, name = "小史莱姆", nameTextID = 1300099, monsterType = 0, isShow = 0, monsterNumber = "F-17", miniIcon = 11138, shapeID = 20065, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.2, adScore = 0.01, apScore = 0.2, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201074}
, 
tag = {1304823}
, descriptionTextID = 1300208}
, 
[218] = {id = 218, name = "松果球", nameTextID = 1300103, monsterType = 0, isShow = 1, monsterNumber = "I-08", miniIcon = 11133, shapeID = 20054, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.21, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201069, 201070}
, 
tag = {1304829}
, descriptionTextID = 1300209}
, 
[219] = {id = 219, name = "独角仙", nameTextID = 1300104, monsterType = 0, isShow = 1, monsterNumber = "I-09", miniIcon = 11134, shapeID = 20055, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.39, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0.3, mdScore = 0.3, 
skillid = {201277}
, 
tag = {1304826}
, descriptionTextID = 1300210}
, 
[220] = {id = 220, name = "石巨人", nameTextID = 1300105, monsterType = 0, isShow = 1, monsterNumber = "I-10", miniIcon = 11125, shapeID = 10001, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.75, adScore = 0.6, apScore = 0.01, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201027, 201028, 201029, 201059}
, 
tag = {1304822}
, descriptionTextID = 1300211}
, 
[221] = {id = 221, name = "兰花螳螂", nameTextID = 1300106, monsterType = 1, isShow = 1, monsterNumber = "I-11", miniIcon = 11131, shapeID = 20031, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.74, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201050, 201051, 201052, 201061}
, 
tag = {1304826, 1304842}
, descriptionTextID = 1300212}
, 
[222] = {id = 222, name = "幽灵螳螂", nameTextID = 1300107, monsterType = 1, isShow = 1, monsterNumber = "I-12", miniIcon = 11132, shapeID = 20032, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.74, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201053, 201054, 201055}
, 
tag = {1304843}
, descriptionTextID = 1300213}
, 
[223] = {id = 223, name = "歌唱家索雷优", nameTextID = 1300108, monsterType = 1, isShow = 1, monsterNumber = "I-13", miniIcon = 11124, shapeID = 10041, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.87, adScore = 0.6, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201035, 201036}
, 
tag = {1304843}
, descriptionTextID = 1300214}
, 
[224] = {id = 224, name = "孢子", nameTextID = 1300111, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11130, shapeID = 20033, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.46, adScore = 0.01, apScore = 1, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201063}
, 
tag = {1304830, 1304829}
, descriptionTextID = 1300217}
, 
[227] = {id = 227, name = "司祭弗莱尔", nameTextID = 1300109, monsterType = 1, isShow = 1, monsterNumber = "I-14", miniIcon = 11130, shapeID = 20089, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.86, adScore = 0.01, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201049, 201025, 201026, 201031}
, 
tag = {1304822}
, descriptionTextID = 1300215}
, 
[228] = {id = 228, name = "守护者埃舍雷", nameTextID = 1300110, monsterType = 1, isShow = 1, monsterNumber = "I-15", miniIcon = 11192, shapeID = 20001, affiliation = 0, area = "伊敏瑟伦", areaTextID = 1300184, hpScore = 0.85, adScore = 0.7, apScore = 0.2, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201216, 201044, 201045, 201046, 201064}
, 
tag = {1304822, 1304832}
, descriptionTextID = 1300216}
, 
[301] = {id = 301, name = "巫毒娃娃", nameTextID = 1300112, monsterType = 0, isShow = 1, monsterNumber = "T-09", miniIcon = 11106, shapeID = 20049, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.56, adScore = 0.01, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201082}
, 
tag = {1304831}
, descriptionTextID = 1300218}
, 
[302] = {id = 302, name = "幽灵水母", nameTextID = 1300113, monsterType = 0, isShow = 1, monsterNumber = "T-10", miniIcon = 11112, shapeID = 20050, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.01, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201083}
, 
tag = {1304822}
, descriptionTextID = 1300219}
, 
[303] = {id = 303, name = "巨鼠", nameTextID = 1300114, monsterType = 0, isShow = 1, monsterNumber = "T-11", miniIcon = 11114, shapeID = 20052, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201080}
, 
tag = {1304843}
, descriptionTextID = 1300220}
, 
[304] = {id = 304, name = "幼鼠", nameTextID = 1300115, monsterType = 0, isShow = 1, monsterNumber = "T-12", miniIcon = 11113, shapeID = 20051, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.23, adScore = 0.2, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201078}
, 
tag = {1304843}
, descriptionTextID = 1300221}
, 
[305] = {id = 305, name = "时空信徒", nameTextID = 1300116, monsterType = 0, isShow = 1, monsterNumber = "T-13", miniIcon = 11116, shapeID = 20091, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.77, adScore = 0.01, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201084, 201085, 201086}
, 
tag = {1304822, 1304823}
, descriptionTextID = 1300222}
, 
[306] = {id = 306, name = "元素使艾妮萌", nameTextID = 1300117, monsterType = 1, isShow = 0, monsterNumber = "T-14", miniIcon = 11471, shapeID = 5014, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.85, adScore = 0.01, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201128, 201129, 201130, 201131, 201132}
, 
tag = {1304824}
, descriptionTextID = 1300223}
, 
[401] = {id = 401, name = "幼狼", nameTextID = 1300118, monsterType = 0, isShow = 1, monsterNumber = "S-01", miniIcon = 11140, shapeID = 20034, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.23, adScore = 0.2, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201077}
, 
tag = {1304843}
, descriptionTextID = 1300224}
, 
[402] = {id = 402, name = "白狼", nameTextID = 1300119, monsterType = 0, isShow = 1, monsterNumber = "S-02", miniIcon = 11144, shapeID = 20042, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.5, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201088, 201089, 201090}
, 
tag = {1304832}
, descriptionTextID = 1300225}
, 
[403] = {id = 403, name = "巨熊", nameTextID = 1300120, monsterType = 0, isShow = 1, monsterNumber = "S-03", miniIcon = 11150, shapeID = 20060, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.57, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201126}
, 
tag = {1304843}
, descriptionTextID = 1300226}
, 
[404] = {id = 404, name = "冰霜树精", nameTextID = 1300121, monsterType = 0, isShow = 1, monsterNumber = "S-04", miniIcon = 11142, shapeID = 20036, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.46, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201092, 201233}
, 
tag = {1304823}
, descriptionTextID = 1300227}
, 
[405] = {id = 405, name = "猎人", nameTextID = 1300122, monsterType = 0, isShow = 1, monsterNumber = "S-05", miniIcon = 11148, shapeID = 20044, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.46, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201102, 201103}
, 
tag = {1304843}
, descriptionTextID = 1300228}
, 
[406] = {id = 406, name = "热血的猎人", nameTextID = 1300123, monsterType = 0, isShow = 1, monsterNumber = "S-06", miniIcon = 11151, shapeID = 20045, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201104, 201105, 201106}
, 
tag = {1304826}
, descriptionTextID = 1300229}
, 
[407] = {id = 407, name = "雪狼", nameTextID = 1300124, monsterType = 0, isShow = 0, monsterNumber = "I-07", miniIcon = 11193, shapeID = 5013, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201088, 201089, 201090}
, 
tag = {1304832}
, descriptionTextID = 1300230}
, 
[408] = {id = 408, name = "雪女", nameTextID = 1300125, monsterType = 0, isShow = 1, monsterNumber = "S-07", miniIcon = 11149, shapeID = 20039, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.74, adScore = 0.01, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201107, 201108, 201109}
, 
tag = {1304822, 1304823}
, descriptionTextID = 1300231}
, 
[409] = {id = 409, name = "雪球", nameTextID = 1300126, monsterType = 0, isShow = 1, monsterNumber = "S-08", miniIcon = 11141, shapeID = 20035, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.5, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201075}
, 
tag = {1304825, 1304823}
, descriptionTextID = 1300232}
, 
[410] = {id = 410, name = "小雪球", nameTextID = 1300127, monsterType = 0, isShow = 1, monsterNumber = "S-09", miniIcon = 11143, shapeID = 20041, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.21, adScore = 0.01, apScore = 0.2, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201075}
, 
tag = {1304823}
, descriptionTextID = 1300233}
, 
[411] = {id = 411, name = "雪怪", nameTextID = 1300128, monsterType = 0, isShow = 1, monsterNumber = "S-10", miniIcon = 11145, shapeID = 20037, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.57, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201093, 201094}
, 
tag = {1304843}
, descriptionTextID = 1300234}
, 
[412] = {id = 412, name = "冰雪巨人", nameTextID = 1300129, monsterType = 0, isShow = 1, monsterNumber = "S-11", miniIcon = 11154, shapeID = 20048, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.77, adScore = 0.75, apScore = 0.01, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {201110, 201111, 201112}
, 
tag = {1304822, 1304823}
, descriptionTextID = 1300235}
, 
[413] = {id = 413, name = "哨兵", nameTextID = 1300130, monsterType = 0, isShow = 1, monsterNumber = "S-12", miniIcon = 11146, shapeID = 20043, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.5, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201097, 201098, 201101}
, 
tag = {1304843}
, descriptionTextID = 1300236}
, 
[414] = {id = 414, name = "卫兵", nameTextID = 1300131, monsterType = 0, isShow = 1, monsterNumber = "S-13", miniIcon = 11147, shapeID = 20038, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.5, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201099, 201100, 201101}
, 
tag = {1304843}
, descriptionTextID = 1300237}
, 
[415] = {id = 415, name = "哨兵队长", nameTextID = 1300132, monsterType = 0, isShow = 1, monsterNumber = "S-14", miniIcon = 11152, shapeID = 20046, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.77, adScore = 0.6, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201133, 201134, 201135, 201136}
, 
tag = {1304843}
, descriptionTextID = 1300238}
, 
[416] = {id = 416, name = "卫兵队长", nameTextID = 1300133, monsterType = 0, isShow = 1, monsterNumber = "S-15", miniIcon = 11153, shapeID = 20047, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.77, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201137, 201138, 201139, 201140}
, 
tag = {1304843}
, descriptionTextID = 1300239}
, 
[417] = {id = 417, name = "冰墙", nameTextID = 1300137, monsterType = 0, isShow = 0, monsterNumber = "I-20", miniIcon = 11099, shapeID = 20075, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.24, adScore = 0.01, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304833}
, descriptionTextID = 1300243}
, 
[418] = {id = 418, name = "冰蕊", nameTextID = 1300138, monsterType = 0, isShow = 0, monsterNumber = "T-16", miniIcon = 11102, shapeID = 10045, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.24, adScore = 0.01, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304833}
, descriptionTextID = 1300244}
, 
[419] = {id = 419, name = "骑士团团长", nameTextID = 1300134, monsterType = 1, isShow = 1, monsterNumber = "S-16", miniIcon = 11100, shapeID = 20059, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.4, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201118, 201119, 201120, 201123, 201124}
, 
tag = {1304826, 1304823}
, descriptionTextID = 1300240}
, 
[420] = {id = 420, name = "白熊 赫沃奥塔", nameTextID = 1300135, monsterType = 1, isShow = 1, monsterNumber = "S-17", miniIcon = 11098, shapeID = 20072, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.7, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201159, 201160, 201161, 201162}
, 
tag = {1304822, 1304826, 1304823}
, descriptionTextID = 1300241}
, 
[421] = {id = 421, name = "守护者 瑟希薇", nameTextID = 1300136, monsterType = 1, isShow = 1, monsterNumber = "S-18", miniIcon = 11099, shapeID = 20090, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.01, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201280, 201141, 201142, 201145, 201146, 201147, 201150, 201148}
, 
tag = {1304822, 1304826}
, descriptionTextID = 1300242}
, 
[501] = {id = 501, name = "魂火", nameTextID = 1300139, monsterType = 0, isShow = 1, monsterNumber = "T-14", miniIcon = 11472, shapeID = 20078, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.23, adScore = 0.01, apScore = 0.2, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201217}
, 
tag = {1304843}
, descriptionTextID = 1300245}
, 
[502] = {id = 502, name = "怨念体", nameTextID = 1300140, monsterType = 0, isShow = 1, monsterNumber = "T-15", miniIcon = 11473, shapeID = 20079, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201219, 201218}
, 
tag = {1304843}
, descriptionTextID = 1300246}
, 
[503] = {id = 503, name = "怨灵法师", nameTextID = 1300141, monsterType = 0, isShow = 1, monsterNumber = "T-16", miniIcon = 11474, shapeID = 20077, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.01, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201282, 201279, 201218}
, 
tag = {1304832}
, descriptionTextID = 1300247}
, 
[504] = {id = 504, name = "骸骨蛇", nameTextID = 1300142, monsterType = 0, isShow = 1, monsterNumber = "T-17", miniIcon = 11475, shapeID = 20080, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.77, adScore = 0.6, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201221, 201222, 201223}
, 
tag = {1304822, 1304826}
, descriptionTextID = 1300248}
, 
[505] = {id = 505, name = "古尔薇格", nameTextID = 1300143, monsterType = 1, isShow = 0, monsterNumber = "T-19", miniIcon = 11476, shapeID = 10049, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.85, adScore = 0.8, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0.8, 
skillid = {}
, 
tag = {1304834, 1304833}
, descriptionTextID = 1300249}
, 
[506] = {id = 506, name = "德亚丝", nameTextID = 1300144, monsterType = 1, isShow = 0, monsterNumber = "T-20", miniIcon = 11477, shapeID = 20165, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.85, adScore = 0.01, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201281, 201285, 201283, 201284, 201286, 201287}
, 
tag = {1304835}
, descriptionTextID = 1300250}
, 
[601] = {id = 601, name = "冰雪飞蛾", nameTextID = 1300145, monsterType = 0, isShow = 1, monsterNumber = "S-19", miniIcon = 11478, shapeID = 20085, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.51, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201273}
, 
tag = {1304836}
, descriptionTextID = 1300251}
, 
[602] = {id = 602, name = "兰花树精", nameTextID = 1300146, monsterType = 0, isShow = 1, monsterNumber = "S-20", miniIcon = 11479, shapeID = 20086, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.51, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201274, 201275}
, 
tag = {1304828}
, descriptionTextID = 1300252}
, 
[603] = {id = 603, name = "冰霜独角仙", nameTextID = 1300147, monsterType = 0, isShow = 1, monsterNumber = "S-21", miniIcon = 11480, shapeID = 20087, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.51, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0.3, mdScore = 0.3, 
skillid = {201276, 201277}
, 
tag = {1304826}
, descriptionTextID = 1300253}
, 
[604] = {id = 604, name = "冰霜魔菇", nameTextID = 1300148, monsterType = 0, isShow = 1, monsterNumber = "S-22", miniIcon = 11481, shapeID = 20088, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.51, adScore = 0.01, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201278}
, 
tag = {1304828}
, descriptionTextID = 1300254}
, 
[605] = {id = 605, name = "熔岩魔灵", nameTextID = 1300149, monsterType = 0, isShow = 1, monsterNumber = "S-23", miniIcon = 11482, shapeID = 20081, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.23, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201234, 201235}
, 
tag = {1304843}
, descriptionTextID = 1300255}
, 
[606] = {id = 606, name = "冰封熔岩兽", nameTextID = 1300150, monsterType = 0, isShow = 1, monsterNumber = "S-24", miniIcon = 11483, shapeID = 20082, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.84, adScore = 0.5, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201236, 201237}
, 
tag = {1304843}
, descriptionTextID = 1300256}
, 
[607] = {id = 607, name = "熔岩兽", nameTextID = 1300151, monsterType = 0, isShow = 1, monsterNumber = "S-25", miniIcon = 11484, shapeID = 20083, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.51, adScore = 0.5, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201238, 201239, 201240}
, 
tag = {1304832}
, descriptionTextID = 1300257}
, 
[608] = {id = 608, name = "熔岩巨兽", nameTextID = 1300152, monsterType = 0, isShow = 1, monsterNumber = "S-26", miniIcon = 11485, shapeID = 20084, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.77, adScore = 0.7, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201241, 201242, 201243, 201245, 201244}
, 
tag = {1304832}
, descriptionTextID = 1300258}
, 
[609] = {id = 609, name = "赤色战姬", nameTextID = 1300153, monsterType = 1, isShow = 1, monsterNumber = "S-27", miniIcon = 11486, shapeID = 20144, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.8, apScore = 0.01, mixScore = 0, pdScore = 0.3, mdScore = 0.3, 
skillid = {201321, 201322, 201323, 201324, 201315, 201326}
, 
tag = {1304822}
, descriptionTextID = 1300259}
, 
[610] = {id = 610, name = "地狱之焰-辛莫拉", nameTextID = 1300155, monsterType = 1, isShow = 1, monsterNumber = "S-28", miniIcon = 11488, shapeID = 20155, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.5, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201288}
, 
tag = {1304832}
, descriptionTextID = 1300260}
, 
[611] = {id = 611, name = "地狱之焰-辛莫拉", nameTextID = 1300154, monsterType = 1, isShow = 0, monsterNumber = "S-12", miniIcon = 11487, shapeID = 50022, affiliation = 0, area = "谢波契卡", areaTextID = 1300185, hpScore = 0.85, adScore = 0.4, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201288}
, 
tag = {1304832}
, descriptionTextID = 1300260}
, 
[701] = {id = 701, name = "恶魔甲虫", nameTextID = 1303500, monsterType = 0, isShow = 0, monsterNumber = "T-18", miniIcon = 12302, shapeID = 20119, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.45, adScore = 0.6, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201525, 201526}
, 
tag = {1304843}
, descriptionTextID = 1303546}
, 
[702] = {id = 702, name = "时之巡逻者", nameTextID = 1303501, monsterType = 0, isShow = 0, monsterNumber = "T-19", miniIcon = 12303, shapeID = 20120, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201535, 201536}
, 
tag = {1304843}
, descriptionTextID = 1303547}
, 
[703] = {id = 703, name = "恶魔犬", nameTextID = 1303502, monsterType = 0, isShow = 0, monsterNumber = "T-20", miniIcon = 12304, shapeID = 20121, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.8, adScore = 0.8, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201527, 201528, 201529, 201530}
, 
tag = {1304843}
, descriptionTextID = 1303548}
, 
[704] = {id = 704, name = "时之守卫", nameTextID = 1303503, monsterType = 0, isShow = 0, monsterNumber = "T-21", miniIcon = 12305, shapeID = 20122, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201531, 201532, 201533, 201534}
, 
tag = {1304843}
, descriptionTextID = 1303549}
, 
[705] = {id = 705, name = "影之艾琳娜", nameTextID = 1303504, monsterType = 0, isShow = 1, monsterNumber = "T-18", miniIcon = 12306, shapeID = 20156, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.85, adScore = 0.5, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201412, 201413, 201415, 201416, 201417}
, 
tag = {1304843}
, descriptionTextID = 1303550}
, 
[706] = {id = 706, name = "德亚丝（已黑化）", nameTextID = 1303505, monsterType = 0, isShow = 0, monsterNumber = "T-23", miniIcon = 12307, shapeID = 20136, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.95, adScore = 0, apScore = 0.95, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201561, 201562, 201563, 201564, 201565}
, 
tag = {1304843}
, descriptionTextID = 1303551}
, 
[801] = {id = 801, name = "幻形幼虫", nameTextID = 1303506, monsterType = 0, isShow = 1, monsterNumber = "C-01", miniIcon = 12308, shapeID = 20112, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.4, adScore = 0.45, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201476, 201477}
, 
tag = {1304843}
, descriptionTextID = 1303552}
, 
[802] = {id = 802, name = "幻形虫", nameTextID = 1303507, monsterType = 0, isShow = 1, monsterNumber = "C-02", miniIcon = 12309, shapeID = 20114, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.5, adScore = 0, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201479}
, 
tag = {1304843}
, descriptionTextID = 1303553}
, 
[803] = {id = 803, name = "幻形飞蛾", nameTextID = 1303508, monsterType = 0, isShow = 1, monsterNumber = "C-03", miniIcon = 12310, shapeID = 20125, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.7, adScore = 0.6, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201545, 201546, 201548, 201549}
, 
tag = {1304837}
, descriptionTextID = 1303554}
, 
[804] = {id = 804, name = "孵化之卵", nameTextID = 1303509, monsterType = 0, isShow = 1, monsterNumber = "C-04", miniIcon = 12311, shapeID = 20118, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.5, adScore = 0, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201538}
, 
tag = {1304838}
, descriptionTextID = 1303555}
, 
[805] = {id = 805, name = "幼飞蛇", nameTextID = 1303510, monsterType = 0, isShow = 1, monsterNumber = "C-05", miniIcon = 12312, shapeID = 20110, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.65, adScore = 0, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201487}
, 
tag = {1304843}
, descriptionTextID = 1303556}
, 
[806] = {id = 806, name = "魔飞龙", nameTextID = 1303511, monsterType = 0, isShow = 1, monsterNumber = "C-06", miniIcon = 12313, shapeID = 20109, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.85, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201473, 201474}
, 
tag = {1304822}
, descriptionTextID = 1303558}
, 
[807] = {id = 807, name = "飞空鱼", nameTextID = 1303512, monsterType = 0, isShow = 1, monsterNumber = "C-07", miniIcon = 12314, shapeID = 20099, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.65, adScore = 0.55, apScore = 0.55, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201429, 201430, 201432, 201433}
, 
tag = {1304822}
, descriptionTextID = 1303559}
, 
[808] = {id = 808, name = "浮空锯齿鲨", nameTextID = 1303513, monsterType = 0, isShow = 1, monsterNumber = "C-08", miniIcon = 12315, shapeID = 20092, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.65, adScore = 0.55, apScore = 0.55, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201400, 201401, 201402, 201403}
, 
tag = {1304822}
, descriptionTextID = 1303560}
, 
[809] = {id = 809, name = "飞翼魔狼", nameTextID = 1303514, monsterType = 0, isShow = 1, monsterNumber = "C-09", miniIcon = 12316, shapeID = 20107, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.85, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201444, 201445, 201447, 201449}
, 
tag = {1304822}
, descriptionTextID = 1303561}
, 
[810] = {id = 810, name = "嗜血蚊", nameTextID = 1303515, monsterType = 0, isShow = 1, monsterNumber = "C-10", miniIcon = 12317, shapeID = 20100, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.6, adScore = 0.65, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201423, 201424}
, 
tag = {1304839}
, descriptionTextID = 1303562}
, 
[811] = {id = 811, name = "针喙鸟", nameTextID = 1303516, monsterType = 0, isShow = 1, monsterNumber = "C-11", miniIcon = 12318, shapeID = 20101, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.65, adScore = 0.55, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201426, 201428}
, 
tag = {1304843}
, descriptionTextID = 1303563}
, 
[812] = {id = 812, name = "杀人蜂", nameTextID = 1303517, monsterType = 0, isShow = 1, monsterNumber = "C-12", miniIcon = 12319, shapeID = 20116, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.65, adScore = 0.55, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201490, 201491}
, 
tag = {1304843}
, descriptionTextID = 1303564}
, 
[813] = {id = 813, name = "魔飞蛇", nameTextID = 1303518, monsterType = 0, isShow = 1, monsterNumber = "C-13", miniIcon = 12320, shapeID = 20111, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.85, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201493, 201495, 201497}
, 
tag = {1304832}
, descriptionTextID = 1303557}
, 
[814] = {id = 814, name = "巨雷龙", nameTextID = 1303519, monsterType = 0, isShow = 1, monsterNumber = "C-14", miniIcon = 12321, shapeID = 20127, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.85, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201505, 201506, 201507, 201508}
, 
tag = {1304843}
, descriptionTextID = 1303565}
, 
[815] = {id = 815, name = "杀人鲸", nameTextID = 1303520, monsterType = 0, isShow = 1, monsterNumber = "C-15", miniIcon = 12322, shapeID = 20123, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.85, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201509, 201510, 201511, 201512}
, 
tag = {1304843}
, descriptionTextID = 1303566}
, 
[816] = {id = 816, name = "双子绞杀者", nameTextID = 1303522, monsterType = 1, isShow = 1, monsterNumber = "C-16", miniIcon = 12323, shapeID = 20141, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.9, adScore = 0.95, apScore = 0.95, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201418, 201419, 201420, 201421, 201422}
, 
tag = {1304843}
, descriptionTextID = 1303568}
, 
[817] = {id = 817, name = "牧师 费拉古德", nameTextID = 1303523, monsterType = 1, isShow = 1, monsterNumber = "C-17", miniIcon = 12324, shapeID = 20142, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.9, adScore = 0, apScore = 0.95, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201539, 201540, 201541, 201542, 201543, 201544}
, 
tag = {1304843}
, descriptionTextID = 1303569}
, 
[818] = {id = 818, name = "索拉迪乌斯", nameTextID = 1303526, monsterType = 1, isShow = 1, monsterNumber = "C-18", miniIcon = 12325, shapeID = 20143, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.95, adScore = 0.95, apScore = 0.95, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, 
tag = {1304843}
, descriptionTextID = 1303570}
, 
[819] = {id = 819, name = "魔物分裂体", nameTextID = 1303527, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 12326, shapeID = 20132, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.65, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201583}
, 
tag = {1304843}
, descriptionTextID = 1303570}
, 
[820] = {id = 820, name = "混沌之子", nameTextID = 1306279, monsterType = 0, isShow = 1, monsterNumber = "C-20", miniIcon = 15096, shapeID = 20206, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.55, adScore = 0.3, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201764, 201767, 201769, 201771}
, 
tag = {1306277}
, descriptionTextID = 1306294}
, 
[821] = {id = 821, name = "秩序之子", nameTextID = 1306280, monsterType = 0, isShow = 1, monsterNumber = "C-21", miniIcon = 15097, shapeID = 20207, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.55, adScore = 0.3, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201762, 201766, 201768, 201770}
, 
tag = {1306277}
, descriptionTextID = 1306295}
, 
[822] = {id = 822, name = "飞马", nameTextID = 1306281, monsterType = 0, isShow = 1, monsterNumber = "C-22", miniIcon = 15098, shapeID = 20213, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.75, adScore = 0.1, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201790, 201791, 201792, 201849}
, 
tag = {1304841}
, descriptionTextID = 1306296}
, 
[823] = {id = 823, name = "均衡执法者 达修斯", nameTextID = 1306282, monsterType = 1, isShow = 1, monsterNumber = "C-23", miniIcon = 15099, shapeID = 20215, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.9, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201851, 201852, 201853}
, 
tag = {1304841}
, descriptionTextID = 1306297}
, 
[824] = {id = 824, name = "守卫神官", nameTextID = 1306283, monsterType = 1, isShow = 1, monsterNumber = "C-24", miniIcon = 15100, shapeID = 20208, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.9, adScore = 0.8, apScore = 0.1, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201781, 201782, 201785, 201786, 201787}
, 
tag = {1304840}
, descriptionTextID = 1306298}
, 
[825] = {id = 825, name = "守护者 卡蜜莉安", nameTextID = 1306284, monsterType = 1, isShow = 1, monsterNumber = "C-25", miniIcon = 15101, shapeID = 20211, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.1, apScore = 0.9, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201815, 201816, 201817, 201819, 201821, 201822}
, 
tag = {1304841, 1304830}
, descriptionTextID = 1306299}
, 
[826] = {id = 826, name = "秩序分裂体", nameTextID = 1306285, monsterType = 0, isShow = 1, monsterNumber = "C-26", miniIcon = 15102, shapeID = 20205, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.3, adScore = 0.3, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201762, 201763}
, 
tag = {}
, descriptionTextID = 1306300}
, 
[827] = {id = 827, name = "混沌分裂体", nameTextID = 1306286, monsterType = 0, isShow = 1, monsterNumber = "C-27", miniIcon = 15103, shapeID = 20204, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.3, adScore = 0.3, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201764, 201765}
, 
tag = {}
, descriptionTextID = 1306301}
, 
[828] = {id = 828, name = "魔能之手-火", nameTextID = 1306287, monsterType = 0, isShow = 1, monsterNumber = "C-28", miniIcon = 15104, shapeID = 20202, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.7, adScore = 0.45, apScore = 0.1, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201758, 201759}
, 
tag = {1306278}
, descriptionTextID = 1306302}
, 
[829] = {id = 829, name = "魔能之手-水", nameTextID = 1306288, monsterType = 0, isShow = 1, monsterNumber = "C-29", miniIcon = 15105, shapeID = 20203, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.7, adScore = 0.35, apScore = 0.1, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201760, 201761}
, 
tag = {1304823}
, descriptionTextID = 1306303}
, 
[830] = {id = 830, name = "魔能之手-风", nameTextID = 1306289, monsterType = 0, isShow = 1, monsterNumber = "C-30", miniIcon = 15106, shapeID = 20201, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.7, adScore = 0.1, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201756, 201757}
, 
tag = {1304833}
, descriptionTextID = 1306304}
, 
[831] = {id = 831, name = "精灵龙幼体", nameTextID = 1306290, monsterType = 0, isShow = 1, monsterNumber = "C-31", miniIcon = 15107, shapeID = 20200, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.3, adScore = 0.1, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201754, 201755}
, 
tag = {1304834}
, descriptionTextID = 1306305}
, 
[832] = {id = 832, name = "小精灵龙", nameTextID = 1306291, monsterType = 0, isShow = 1, monsterNumber = "C-32", miniIcon = 15108, shapeID = 20197, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.45, adScore = 0.1, apScore = 0.45, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201740, 201741}
, 
tag = {}
, descriptionTextID = 1306306}
, 
[833] = {id = 833, name = "精灵龙", nameTextID = 1306292, monsterType = 0, isShow = 1, monsterNumber = "C-33", miniIcon = 15109, shapeID = 20198, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.6, adScore = 0.1, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201750, 201751}
, 
tag = {1304832}
, descriptionTextID = 1306307}
, 
[834] = {id = 834, name = "神族幻术师", nameTextID = 1306293, monsterType = 0, isShow = 1, monsterNumber = "C-34", miniIcon = 15110, shapeID = 20210, affiliation = 0, area = "嘉庇艾尔", areaTextID = 1303499, hpScore = 0.5, adScore = 0.1, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201788, 201789}
, 
tag = {1304832}
, descriptionTextID = 1306308}
, 
[835] = {id = 835, name = "次元监视者", nameTextID = 1300087, monsterType = 1, isShow = 1, monsterNumber = "T-08", miniIcon = 11097, shapeID = 20006, affiliation = 0, area = "公会试炼", areaTextID = 1307252, hpScore = 0.76, adScore = 0.5, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, 
tag = {1304822}
, descriptionTextID = 1300193}
, 
[836] = {id = 836, name = "祟-水银", nameTextID = 1305286, monsterType = 1, isShow = 1, monsterNumber = "SF-1", miniIcon = 14093, shapeID = 20186, affiliation = 0, area = "公会试炼", areaTextID = 1307252, hpScore = 0.7, adScore = 0.7, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201707, 201708, 201711, 201714, 201717}
, 
tag = {1305294}
, descriptionTextID = 1305290}
, 
[837] = {id = 837, name = "蟹宝王", nameTextID = 1304957, monsterType = 1, isShow = 1, monsterNumber = "X-13", miniIcon = 13346, shapeID = 20171, affiliation = 0, area = "公会试炼", areaTextID = 1307252, hpScore = 0.9, adScore = 0.8, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, 
tag = {1304843}
, descriptionTextID = 1304964}
, 
[838] = {id = 838, name = "白熊 赫沃奥塔", nameTextID = 1300135, monsterType = 1, isShow = 1, monsterNumber = "S-17", miniIcon = 11098, shapeID = 20072, affiliation = 0, area = "公会试炼", areaTextID = 1307252, hpScore = 0.85, adScore = 0.7, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, 
tag = {1304822, 1304826, 1304823}
, descriptionTextID = 1300241}
, 
[839] = {id = 839, name = "地狱守卫", nameTextID = 1303540, monsterType = 1, isShow = 1, monsterNumber = "B-03", miniIcon = 12330, shapeID = 50024, affiliation = 0, area = "公会试炼", areaTextID = 1307252, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201531, 201532, 201533, 201534}
, 
tag = {1304843}
, descriptionTextID = 1303582}
, 
[840] = {id = 840, name = "守卫神官", nameTextID = 1306283, monsterType = 1, isShow = 1, monsterNumber = "C-24", miniIcon = 15100, shapeID = 20208, affiliation = 0, area = "公会试炼", areaTextID = 1307252, hpScore = 0.9, adScore = 0.8, apScore = 0.1, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201780, 201781, 201782, 201783, 201784, 201785, 201786, 201787}
, 
tag = {1304840}
, descriptionTextID = 1306298}
, 
[901] = {id = 901, name = "蝠翼飞狮", nameTextID = 1303521, monsterType = 1, isShow = 1, monsterNumber = "C-19", miniIcon = 12327, shapeID = 20117, affiliation = 0, area = "嘉庇埃尔", areaTextID = 1303499, hpScore = 0.8, adScore = 0.85, apScore = 0.85, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201514, 201515, 201520}
, 
tag = {1304843}
, descriptionTextID = 1303567}
, 
[2001] = {id = 2001, name = "古塔蝙蝠", nameTextID = 1300162, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11102, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2002] = {id = 2002, name = "巫毒娃娃", nameTextID = 1300163, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11106, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.01, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2003] = {id = 2003, name = "幼鼠", nameTextID = 1300164, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11113, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.4, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2004] = {id = 2004, name = "幽灵水母", nameTextID = 1300165, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11112, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.01, apScore = 0.4, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2005] = {id = 2005, name = "魅魔", nameTextID = 1300166, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11105, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.01, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2006] = {id = 2006, name = "史莱姆", nameTextID = 1300167, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11107, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0.3, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2007] = {id = 2007, name = "连射藤蔓", nameTextID = 1300168, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11128, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0.3, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2008] = {id = 2008, name = "伞菇", nameTextID = 1300169, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11126, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0.3, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2009] = {id = 2009, name = "树精", nameTextID = 1300170, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11122, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0.3, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2010] = {id = 2010, name = "石头人", nameTextID = 1300171, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11125, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0.3, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2011] = {id = 2011, name = "幽灵螳螂", nameTextID = 1300172, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11132, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0.3, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2012] = {id = 2012, name = "雪球", nameTextID = 1300173, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11141, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2013] = {id = 2013, name = "冰霜树精", nameTextID = 1300174, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11142, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2014] = {id = 2014, name = "白狼", nameTextID = 1300175, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11144, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.3, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2015] = {id = 2015, name = "白熊", nameTextID = 1300176, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11150, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.3, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2016] = {id = 2016, name = "雪女", nameTextID = 1300177, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11149, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.01, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2017] = {id = 2017, name = "冰雪巨人", nameTextID = 1300178, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11154, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.5, adScore = 0.5, apScore = 0.01, mixScore = 0, pdScore = 0.5, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2018] = {id = 2018, name = "怨念聚合体", nameTextID = 1300179, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11111, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.8, adScore = 0.8, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2019] = {id = 2019, name = "蝴蝶妖精", nameTextID = 1300180, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11130, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.8, adScore = 0.01, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[2020] = {id = 2020, name = "白熊 赫沃奥塔", nameTextID = 1300181, monsterType = 0, isShow = 0, monsterNumber = "0", miniIcon = 11098, shapeID = 20070, affiliation = 0, area = "时之塔", areaTextID = 1300183, hpScore = 0.8, adScore = 0.8, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {}
, 
tag = {1304843}
, descriptionTextID = 1300264}
, 
[10001] = {id = 10001, name = "时之巡逻者-紫", nameTextID = 1303538, monsterType = 0, isShow = 1, monsterNumber = "B-01", miniIcon = 12328, shapeID = 50022, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201535, 201536}
, 
tag = {1304843}
, descriptionTextID = 1303580}
, 
[10002] = {id = 10002, name = "时之巡逻者-黄", nameTextID = 1303539, monsterType = 0, isShow = 1, monsterNumber = "B-02", miniIcon = 12329, shapeID = 50023, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201535, 201536}
, 
tag = {1304843}
, descriptionTextID = 1303581}
, 
[10003] = {id = 10003, name = "地狱守卫", nameTextID = 1303540, monsterType = 1, isShow = 1, monsterNumber = "B-03", miniIcon = 12330, shapeID = 50024, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201531, 201532, 201533, 201534}
, 
tag = {1304843}
, descriptionTextID = 1303582}
, 
[10004] = {id = 10004, name = "地狱恶魔犬", nameTextID = 1303541, monsterType = 0, isShow = 1, monsterNumber = "B-04", miniIcon = 12331, shapeID = 50025, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.8, adScore = 0.8, apScore = 0, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201527, 201528, 201529, 201530}
, 
tag = {1304843}
, descriptionTextID = 1303583}
, 
[10005] = {id = 10005, name = "不稳定岩核", nameTextID = 1303542, monsterType = 0, isShow = 1, monsterNumber = "B-05", miniIcon = 12332, shapeID = 20081, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.45, adScore = 0.45, apScore = 0.45, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201234, 201235}
, 
tag = {1304843}
, descriptionTextID = 1303584}
, 
[10006] = {id = 10006, name = "熔岩巨兽", nameTextID = 1303543, monsterType = 0, isShow = 1, monsterNumber = "B-06", miniIcon = 12333, shapeID = 20083, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.77, adScore = 0.7, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201236, 201237}
, 
tag = {1304843}
, descriptionTextID = 1303585}
, 
[10007] = {id = 10007, name = "磷火熔岩兽", nameTextID = 1303544, monsterType = 0, isShow = 1, monsterNumber = "B-07", miniIcon = 12334, shapeID = 50027, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.84, adScore = 0.5, apScore = 0.3, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201238, 201239, 201240}
, 
tag = {1304843}
, descriptionTextID = 1303586}
, 
[10008] = {id = 10008, name = "磷火巨兽", nameTextID = 1303545, monsterType = 1, isShow = 1, monsterNumber = "B-08", miniIcon = 12335, shapeID = 50028, affiliation = 0, area = "破碎之境", areaTextID = 1303668, hpScore = 0.77, adScore = 0.7, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201241, 201242, 201243, 201245, 201244}
, 
tag = {1304843}
, descriptionTextID = 1303587}
, 
[10009] = {id = 10009, name = "星辰幻境-欲魇", nameTextID = 1304805, monsterType = 0, isShow = 1, monsterNumber = "X-01", miniIcon = 13045, shapeID = 20157, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 0.6, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201646}
, 
tag = {1304843}
, descriptionTextID = 1304811}
, 
[10010] = {id = 10010, name = "星辰幻境-食魇", nameTextID = 1304806, monsterType = 0, isShow = 1, monsterNumber = "X-02", miniIcon = 13047, shapeID = 20159, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 0.6, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201650, 201651}
, 
tag = {1304843}
, descriptionTextID = 1304812}
, 
[10011] = {id = 10011, name = "星辰幻境-惑魇", nameTextID = 1304807, monsterType = 0, isShow = 1, monsterNumber = "X-03", miniIcon = 13046, shapeID = 20158, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201648, 201649}
, 
tag = {1304843}
, descriptionTextID = 1304813}
, 
[10012] = {id = 10012, name = "星辰幻境-怠魇", nameTextID = 1304808, monsterType = 0, isShow = 1, monsterNumber = "X-04", miniIcon = 13048, shapeID = 20160, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 0.6, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201652, 201653}
, 
tag = {1304843}
, descriptionTextID = 1304814}
, 
[10013] = {id = 10013, name = "星辰幻境-暴魇", nameTextID = 1304809, monsterType = 0, isShow = 1, monsterNumber = "X-05", miniIcon = 13049, shapeID = 20161, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 0.6, adScore = 0.8, apScore = 0.5, mixScore = 0, pdScore = 1, mdScore = 0, 
skillid = {201654, 201655, 201656}
, 
tag = {1304840}
, descriptionTextID = 1304815}
, 
[10014] = {id = 10014, name = "星辰幻境-象魇", nameTextID = 1304810, monsterType = 0, isShow = 1, monsterNumber = "X-06", miniIcon = 13050, shapeID = 20162, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 0.6, adScore = 0.5, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 1, 
skillid = {201657, 201658, 201659, 201660}
, 
tag = {1304841}
, descriptionTextID = 1304816}
, 
[10015] = {id = 10015, name = "命运的化身", nameTextID = 1304817, monsterType = 1, isShow = 1, monsterNumber = "X-07", miniIcon = 13059, shapeID = 20163, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 1, adScore = 0, apScore = 0.9, mixScore = 0, pdScore = 0.8, mdScore = 0.8, 
skillid = {201666, 201667, 201668, 201669, 201670, 201671, 201672, 201673, 201674}
, 
tag = {1304843}
, descriptionTextID = 1304819}
, 
[10016] = {id = 10016, name = "绝·命运的化身（不显示）", nameTextID = 1304818, monsterType = 1, isShow = 0, monsterNumber = "X-08", miniIcon = 13060, shapeID = 20164, affiliation = 0, area = "星辰幻境", areaTextID = 1304803, hpScore = 0.6, adScore = 0.5, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 1, 
skillid = {201657, 201658, 201659, 201660}
, 
tag = {1304843}
, descriptionTextID = 1304819}
, 
[10017] = {id = 10017, name = "珍珠章鱼", nameTextID = 1304952, monsterType = 0, isShow = 1, monsterNumber = "X-08", miniIcon = 13341, shapeID = 20167, affiliation = 0, area = "夏日冒险", areaTextID = 1304958, hpScore = 0.5, adScore = 0.45, apScore = 0.45, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201688, 201689}
, 
tag = {1304843}
, descriptionTextID = 1304959}
, 
[10018] = {id = 10018, name = "开心蟹", nameTextID = 1304953, monsterType = 0, isShow = 1, monsterNumber = "X-09", miniIcon = 13342, shapeID = 20170, affiliation = 0, area = "夏日冒险", areaTextID = 1304958, hpScore = 0.5, adScore = 0.01, apScore = 0.45, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201696}
, 
tag = {1304843}
, descriptionTextID = 1304960}
, 
[10019] = {id = 10019, name = "珊瑚海马", nameTextID = 1304954, monsterType = 0, isShow = 1, monsterNumber = "X-10", miniIcon = 13343, shapeID = 20169, affiliation = 0, area = "夏日冒险", areaTextID = 1304958, hpScore = 0.6, adScore = 0.45, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201694, 201695}
, 
tag = {1304843}
, descriptionTextID = 1304961}
, 
[10020] = {id = 10020, name = "美人鱼", nameTextID = 1304955, monsterType = 0, isShow = 1, monsterNumber = "X-11", miniIcon = 13344, shapeID = 20166, affiliation = 0, area = "夏日冒险", areaTextID = 1304958, hpScore = 0.7, adScore = 0.65, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201685, 201686, 201687}
, 
tag = {1304843}
, descriptionTextID = 1304962}
, 
[10021] = {id = 10021, name = "珊瑚龙", nameTextID = 1304956, monsterType = 0, isShow = 1, monsterNumber = "X-12", miniIcon = 13345, shapeID = 20168, affiliation = 0, area = "夏日冒险", areaTextID = 1304958, hpScore = 0.7, adScore = 0.7, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201690, 201691, 201692, 201693}
, 
tag = {1304843}
, descriptionTextID = 1304963}
, 
[10022] = {id = 10022, name = "蟹宝王", nameTextID = 1304957, monsterType = 1, isShow = 1, monsterNumber = "X-13", miniIcon = 13346, shapeID = 20171, affiliation = 0, area = "夏日冒险", areaTextID = 1304958, hpScore = 0.9, adScore = 0.8, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, 
tag = {1304843}
, descriptionTextID = 1304964}
, 
[10026] = {id = 10026, name = "小雪球", nameTextID = 1305271, monsterType = 0, isShow = 1, monsterNumber = "CH-1", miniIcon = 13894, shapeID = 20179, affiliation = 0, area = "闪耀舞台", areaTextID = 1305270, hpScore = 0.5, adScore = 0.01, apScore = 0.45, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201075}
, 
tag = {1304843}
, descriptionTextID = 1305278}
, 
[10027] = {id = 10027, name = "雪球", nameTextID = 1305272, monsterType = 0, isShow = 1, monsterNumber = "CH-2", miniIcon = 13895, shapeID = 20180, affiliation = 0, area = "闪耀舞台", areaTextID = 1305270, hpScore = 0.5, adScore = 0.01, apScore = 0.45, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201075}
, 
tag = {1304843}
, descriptionTextID = 1305279}
, 
[10028] = {id = 10028, name = "雪怪", nameTextID = 1305273, monsterType = 0, isShow = 1, monsterNumber = "CH-3", miniIcon = 13897, shapeID = 20182, affiliation = 0, area = "闪耀舞台", areaTextID = 1305270, hpScore = 0.6, adScore = 0.45, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201093, 201094}
, 
tag = {1304843}
, descriptionTextID = 1305280}
, 
[10029] = {id = 10029, name = "雪女", nameTextID = 1305274, monsterType = 0, isShow = 1, monsterNumber = "CH-4", miniIcon = 13898, shapeID = 20183, affiliation = 0, area = "闪耀舞台", areaTextID = 1305270, hpScore = 0.7, adScore = 0.7, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201107, 201108, 201109}
, 
tag = {1304843}
, descriptionTextID = 1305281}
, 
[10030] = {id = 10030, name = "冰树精", nameTextID = 1305275, monsterType = 0, isShow = 1, monsterNumber = "CH-5", miniIcon = 13896, shapeID = 20181, affiliation = 0, area = "闪耀舞台", areaTextID = 1305270, hpScore = 0.6, adScore = 0.45, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201092, 201233}
, 
tag = {1304843}
, descriptionTextID = 1305282}
, 
[10031] = {id = 10031, name = "冰巨人", nameTextID = 1305276, monsterType = 0, isShow = 1, monsterNumber = "CH-6", miniIcon = 13899, shapeID = 20184, affiliation = 0, area = "闪耀舞台", areaTextID = 1305270, hpScore = 0.6, adScore = 0.45, apScore = 0.01, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201110, 201111, 201112}
, 
tag = {1304843}
, descriptionTextID = 1305283}
, 
[10032] = {id = 10032, name = "雪狼 芬里尔", nameTextID = 1305277, monsterType = 1, isShow = 1, monsterNumber = "CH-7", miniIcon = 13900, shapeID = 20185, affiliation = 0, area = "闪耀舞台", areaTextID = 1305270, hpScore = 0.9, adScore = 0.8, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201088, 201089, 201090}
, 
tag = {1304843}
, descriptionTextID = 1305284}
, 
[10033] = {id = 10033, name = "祟-水银", nameTextID = 1305286, monsterType = 1, isShow = 1, monsterNumber = "SF-1", miniIcon = 14093, shapeID = 20186, affiliation = 0, area = "年兽来袭", areaTextID = 1305296, hpScore = 0.7, adScore = 0.7, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201714, 201711, 201708, 201717}
, 
tag = {1305294}
, descriptionTextID = 1305290}
, 
[10034] = {id = 10034, name = "祟-盐石", nameTextID = 1305287, monsterType = 1, isShow = 1, monsterNumber = "SF-2", miniIcon = 14094, shapeID = 20187, affiliation = 0, area = "年兽来袭", areaTextID = 1305296, hpScore = 0.7, adScore = 0.7, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201714, 201711, 201708, 201717}
, 
tag = {1305295}
, descriptionTextID = 1305291}
, 
[10035] = {id = 10035, name = "祟-硫火", nameTextID = 1305285, monsterType = 1, isShow = 1, monsterNumber = "SF-3", miniIcon = 14092, shapeID = 20188, affiliation = 0, area = "年兽来袭", areaTextID = 1305296, hpScore = 0.7, adScore = 0.7, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201714, 201711, 201708, 201717}
, 
tag = {1305293}
, descriptionTextID = 1305289}
, 
[10036] = {id = 10036, name = "年兽", nameTextID = 1305288, monsterType = 1, isShow = 1, monsterNumber = "SF-4", miniIcon = 14091, shapeID = 20190, affiliation = 0, area = "年兽来袭", areaTextID = 1305296, hpScore = 0.9, adScore = 0.8, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201718, 201719, 201721, 201722, 201707, 201717}
, 
tag = {1304843}
, descriptionTextID = 1305292}
, 
[10037] = {id = 10037, name = "卑琐之人", nameTextID = 1305628, monsterType = 1, isShow = 1, monsterNumber = "V-1", miniIcon = 14156, shapeID = 20192, affiliation = 0, area = "露尼亚之旅", areaTextID = 1305627, hpScore = 0.7, adScore = 0.6, apScore = 0.8, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201733, 201734, 201735}
, 
tag = {1304843}
, descriptionTextID = 1305632}
, 
[10038] = {id = 10038, name = "厌恶之情", nameTextID = 1305629, monsterType = 0, isShow = 1, monsterNumber = "V-2", miniIcon = 14154, shapeID = 20194, affiliation = 0, area = "露尼亚之旅", areaTextID = 1305627, hpScore = 0.7, adScore = 0.1, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201736}
, 
tag = {1304843}
, descriptionTextID = 1305633}
, 
[10039] = {id = 10039, name = "配置的解药", nameTextID = 1305630, monsterType = 0, isShow = 1, monsterNumber = "V-3", miniIcon = 14155, shapeID = 20193, affiliation = 0, area = "露尼亚之旅", areaTextID = 1305627, hpScore = 0.7, adScore = 0.1, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201737}
, 
tag = {1304843}
, descriptionTextID = 1305634}
, 
[10040] = {id = 10040, name = "爱慕之心", nameTextID = 1305631, monsterType = 0, isShow = 1, monsterNumber = "V-4", miniIcon = 14153, shapeID = 20195, affiliation = 0, area = "露尼亚之旅", areaTextID = 1305627, hpScore = 0.9, adScore = 0.6, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201738, 201739}
, 
tag = {1304843}
, descriptionTextID = 1305635}
, 
[10041] = {id = 10041, name = "愚人小丑", nameTextID = 701936, monsterType = 0, isShow = 0, monsterNumber = "AP-1", miniIcon = 14153, shapeID = 20199, affiliation = 0, area = "愚乐园", areaTextID = 701959, hpScore = 0.9, adScore = 0.6, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201738, 201739}
, 
tag = {1304843}
, descriptionTextID = 1305635}
, 
[11001] = {id = 11001, name = "艾迪恩", nameTextID = 1303530, monsterType = 1, isShow = 1, monsterNumber = "D-01", miniIcon = 12336, shapeID = 20093, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201439, 201441, 201443, 201437, 201435, 201436}
, 
tag = {1304843}
, descriptionTextID = 1303572}
, 
[11002] = {id = 11002, name = "恐惧", nameTextID = 1303531, monsterType = 1, isShow = 1, monsterNumber = "D-02", miniIcon = 12337, shapeID = 20102, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.53, adScore = 0.52, apScore = 0.52, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201450, 201451, 201452}
, 
tag = {1304843}
, descriptionTextID = 1303573}
, 
[11003] = {id = 11003, name = "影之惧", nameTextID = 1303532, monsterType = 1, isShow = 1, monsterNumber = "D-03", miniIcon = 12338, shapeID = 20103, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.61, adScore = 0.6, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201454, 201455, 201456, 201457}
, 
tag = {1304843}
, descriptionTextID = 1303574}
, 
[11004] = {id = 11004, name = "恐惧之源", nameTextID = 1303533, monsterType = 1, isShow = 1, monsterNumber = "D-04", miniIcon = 12339, shapeID = 20104, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.67, adScore = 0.67, apScore = 0.67, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201458, 201459, 201460, 201461, 201462}
, 
tag = {1304843}
, descriptionTextID = 1303575}
, 
[11005] = {id = 11005, name = "深渊的绝望", nameTextID = 1303534, monsterType = 1, isShow = 1, monsterNumber = "D-05", miniIcon = 12340, shapeID = 20105, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.75, apScore = 0.75, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201463, 201465, 201466, 201467, 201468}
, 
tag = {1304843}
, descriptionTextID = 1303576}
, 
[11006] = {id = 11006, name = "奥拉迪尔", nameTextID = 1303535, monsterType = 1, isShow = 1, monsterNumber = "D-06", miniIcon = 12341, shapeID = 20094, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.6, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201593, 201404, 201405}
, 
tag = {1304843}
, descriptionTextID = 1303577}
, 
[11007] = {id = 11007, name = "格拉梅尔", nameTextID = 1303536, monsterType = 1, isShow = 1, monsterNumber = "D-07", miniIcon = 12342, shapeID = 20096, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.65, adScore = 0.5, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201522, 201524, 201523}
, 
tag = {1304843}
, descriptionTextID = 1303578}
, 
[11008] = {id = 11008, name = "迪亚斯", nameTextID = 1303537, monsterType = 1, isShow = 1, monsterNumber = "D-08", miniIcon = 12343, shapeID = 20095, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.7, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201597, 201598}
, 
tag = {1304843}
, descriptionTextID = 1303579}
, 
[11009] = {id = 11009, name = "索卢克", nameTextID = 1303529, monsterType = 1, isShow = 1, monsterNumber = "D-09", miniIcon = 12344, shapeID = 20106, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.7, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201553, 201554, 201555, 201556, 201557, 201558, 201559, 201550, 201551, 201552, 201588, 201589}
, 
tag = {1304843}
, descriptionTextID = 1303571}
, 
[110011] = {id = 110011, name = "艾迪恩-1", nameTextID = 1303530, monsterType = 1, isShow = 0, monsterNumber = "D-01", miniIcon = 12336, shapeID = 20093, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201439, 201441}
, 
tag = {1304843}
, descriptionTextID = 1303572}
, 
[110012] = {id = 110012, name = "艾迪恩-2", nameTextID = 1303530, monsterType = 1, isShow = 0, monsterNumber = "D-01", miniIcon = 12336, shapeID = 20093, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201439, 201441, 201443}
, 
tag = {1304843}
, descriptionTextID = 1303572}
, 
[110013] = {id = 110013, name = "艾迪恩-3", nameTextID = 1303530, monsterType = 1, isShow = 0, monsterNumber = "D-01", miniIcon = 12336, shapeID = 20093, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201441, 201437}
, 
tag = {1304843}
, descriptionTextID = 1303572}
, 
[110014] = {id = 110014, name = "艾迪恩-4", nameTextID = 1303530, monsterType = 1, isShow = 0, monsterNumber = "D-01", miniIcon = 12336, shapeID = 20093, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201439, 201441, 201435}
, 
tag = {1304843}
, descriptionTextID = 1303572}
, 
[110015] = {id = 110015, name = "艾迪恩-5", nameTextID = 1303530, monsterType = 1, isShow = 0, monsterNumber = "D-01", miniIcon = 12336, shapeID = 20093, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201441, 201436}
, 
tag = {1304843}
, descriptionTextID = 1303572}
, 
[110016] = {id = 110016, name = "艾迪恩-6", nameTextID = 1303530, monsterType = 1, isShow = 0, monsterNumber = "D-01", miniIcon = 12336, shapeID = 20093, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.7, apScore = 0.7, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201441, 201437, 201435}
, 
tag = {1304843}
, descriptionTextID = 1303572}
, 
[110061] = {id = 110061, name = "奥拉迪尔1-4", nameTextID = 1303535, monsterType = 1, isShow = 0, monsterNumber = "D-06", miniIcon = 12341, shapeID = 20094, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.6, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201593, 201405}
, 
tag = {1304843}
, descriptionTextID = 1303577}
, 
[110062] = {id = 110062, name = "奥拉迪尔5-6", nameTextID = 1303535, monsterType = 1, isShow = 0, monsterNumber = "D-06", miniIcon = 12341, shapeID = 20094, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.75, adScore = 0.6, apScore = 0.6, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201404, 201405}
, 
tag = {1304843}
, descriptionTextID = 1303577}
, 
[110071] = {id = 110071, name = "格拉梅尔1-4", nameTextID = 1303536, monsterType = 1, isShow = 0, monsterNumber = "D-07", miniIcon = 12342, shapeID = 20096, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.65, adScore = 0.5, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201522, 201523}
, 
tag = {1304843}
, descriptionTextID = 1303578}
, 
[110072] = {id = 110072, name = "格拉梅尔5-6", nameTextID = 1303536, monsterType = 1, isShow = 0, monsterNumber = "D-07", miniIcon = 12342, shapeID = 20096, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.65, adScore = 0.5, apScore = 0.5, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201524, 201523}
, 
tag = {1304843}
, descriptionTextID = 1303578}
, 
[110091] = {id = 110091, name = "索卢克-破坏刺杀", nameTextID = 1303529, monsterType = 1, isShow = 0, monsterNumber = "D-09", miniIcon = 12344, shapeID = 20106, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.7, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201553, 201554, 201555}
, 
tag = {1304843}
, descriptionTextID = 1303571}
, 
[110092] = {id = 110092, name = "索卢克-魔导妨害", nameTextID = 1303529, monsterType = 1, isShow = 0, monsterNumber = "D-09", miniIcon = 12344, shapeID = 20106, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.7, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201556, 201557, 201558, 201559}
, 
tag = {1304843}
, descriptionTextID = 1303571}
, 
[110093] = {id = 110093, name = "索卢克-守护恢复", nameTextID = 1303529, monsterType = 1, isShow = 0, monsterNumber = "D-09", miniIcon = 12344, shapeID = 20106, affiliation = 0, area = "梦境世界", areaTextID = 1303669, hpScore = 0.7, adScore = 0.65, apScore = 0.65, mixScore = 0, pdScore = 0, mdScore = 0, 
skillid = {201550, 201551, 201552, 201588, 201589}
, 
tag = {1304843}
, descriptionTextID = 1303571}
}
cmonster_handbook.AllIds = {92, 93, 94, 101, 102, 103, 104, 105, 106, 107, 108, 201, 202, 203, 204, 206, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 227, 228, 301, 302, 303, 304, 305, 306, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 501, 502, 503, 504, 505, 506, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 701, 702, 703, 704, 705, 706, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 901, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018, 10019, 10020, 10021, 10022, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 11001, 11002, 11003, 11004, 11005, 11006, 11007, 11008, 11009, 110011, 110012, 110013, 110014, 110015, 110016, 110061, 110062, 110071, 110072, 110091, 110092, 110093}
return cmonster_handbook

