-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/role/roleconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local roleconfig = {}
roleconfig.Data = {
[1] = {id = 1, name = "$heroine$", nameTextID = 501584, titleTextID = 501656, shapeID = 1, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10001, addhp = 40.5, addattack = 12.15, adddef = 2.7, addmagicDef = 2.7, addspeed = 0, addatkspeed = 0, breakaddhp = 40.5, breakaddattack = 12.15, breakadddef = 2.7, breakaddmagicDef = 2.7, 
breakMultiple = {15, 35, 70, 120}
, hp = 405, attack = 121, def = 27, magicDef = 27, speed = "25", atkspeed = 100, vocation = 7, element = 4, breakType = 1, evolutionType = 1, comborate1 = 0, comborate2 = 0, contractskillid = 60011, contractskillid2 = 60003, contractskillid3 = 500101, assistSkillid = 60011, 
yardskillid = {3003}
, roleLine = "出场喊话1", roleLineTextID = 501958, victoryTalk = "指尖涌出的魔力，这感觉，就是魔女的孤独吗……", victoryTalkTextID = 502030, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[2] = {id = 2, name = "柯萝谢", nameTextID = 501585, titleTextID = 501657, shapeID = 1004, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10002, addhp = 40.5, addattack = 8.51, adddef = 2.16, addmagicDef = 2.16, addspeed = 0, addatkspeed = 0, breakaddhp = 40.5, breakaddattack = 8.51, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 405, attack = 85, def = 21, magicDef = 21, speed = "20", atkspeed = 100, vocation = 5, element = 3, breakType = 2, evolutionType = 2, comborate1 = 0, comborate2 = 0, contractskillid = 60021, contractskillid2 = 60022, contractskillid3 = 500201, assistSkillid = 60022, 
yardskillid = {1002}
, roleLine = "我叫做柯萝谢。我不喜欢争斗，不过……会努力助你一臂之力。", roleLineTextID = 501959, victoryTalk = "有人受伤吗？没关系，快接受我的救治吧。", victoryTalkTextID = 502031, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[3] = {id = 3, name = "未来", nameTextID = 501586, titleTextID = 501658, shapeID = 1008, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10003, addhp = 56.7, addattack = 11.48, adddef = 2.7, addmagicDef = 2.7, addspeed = 2, addatkspeed = 0, breakaddhp = 56.7, breakaddattack = 11.48, breakadddef = 2.7, breakaddmagicDef = 2.7, 
breakMultiple = {15, 35, 70, 120}
, hp = 567, attack = 114, def = 27, magicDef = 27, speed = "25", atkspeed = 100, vocation = 2, element = 2, breakType = 3, evolutionType = 3, comborate1 = 0, comborate2 = 0, contractskillid = 60031, contractskillid2 = 60032, contractskillid3 = 500301, assistSkillid = 60031, 
yardskillid = {2002}
, roleLine = "我和姐姐不同，没有才能的我，还需要更严厉的修行。拜托了，请你指导我吧！", roleLineTextID = 501960, victoryTalk = "我也能和姐姐一样，守护弗摩尔的土地！", victoryTalkTextID = 502032, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[4] = {id = 4, name = "优丽雅", nameTextID = 501587, titleTextID = 501659, shapeID = 1006, rarity = 1, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10004, addhp = 38.25, addattack = 7.65, adddef = 0.2, addmagicDef = 2.04, addspeed = 2, addatkspeed = 0, breakaddhp = 38.25, breakaddattack = 7.65, breakadddef = 0.2, breakaddmagicDef = 2.04, 
breakMultiple = {15, 35, 70, 120}
, hp = 382, attack = 76, def = 2, magicDef = 20, speed = "25", atkspeed = 100, vocation = 5, element = 2, breakType = 4, evolutionType = 4, comborate1 = 0, comborate2 = 0, contractskillid = 60041, contractskillid2 = 60042, contractskillid3 = 500401, assistSkillid = 60041, 
yardskillid = {1001}
, roleLine = "我是露尼亚公国的公主优丽雅，如果不会造成您的困扰，能否允许我同行？", roleLineTextID = 501961, victoryTalk = "看啊，看啊，优丽雅和之前不一样吧？", victoryTalkTextID = 502033, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[5] = {id = 5, name = "废弃", nameTextID = 501588, titleTextID = 501660, shapeID = 1009, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10005, addhp = 42.75, addattack = 8.55, adddef = 2.28, addmagicDef = 2.28, addspeed = 1.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 8.55, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 85, def = 22, magicDef = 22, speed = "17.5", atkspeed = 100, vocation = 4, element = 4, breakType = 5, evolutionType = 5, comborate1 = 0, comborate2 = 0, contractskillid = 60051, contractskillid2 = 60052, contractskillid3 = 500501, assistSkillid = 60051, 
yardskillid = {3002}
, roleLine = "吾正是来自虚空的魔术师乌托……就凭你是不可能看透吾的魂魄。", roleLineTextID = 501962, victoryTalk = "畏惧虚空，然后迎来终结。", victoryTalkTextID = 502034, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[6] = {id = 6, name = "薇妲尔", nameTextID = 501589, titleTextID = 501661, shapeID = 1003, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10006, addhp = 45, addattack = 9.45, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9.45, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 94, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 6, evolutionType = 6, comborate1 = 0, comborate2 = 0, contractskillid = 60061, contractskillid2 = 60062, contractskillid3 = 500601, assistSkillid = 60061, 
yardskillid = {1003}
, roleLine = "初次见面，我叫薇妲尔，是这世界首屈一指的舞娘。就让我献上一段舞蹈代替自我介绍吧。", roleLineTextID = 501963, victoryTalk = "请仔细观看我的舞姿。", victoryTalkTextID = 502035, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 95006, uniqueequipidunlocktime = "2023-04-20 04:00:00"}
, 
[7] = {id = 7, name = "废弃", nameTextID = 501590, titleTextID = 501662, shapeID = 1007, rarity = 1, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10007, addhp = 53.55, addattack = 10.84, adddef = 2.55, addmagicDef = 2.55, addspeed = 2.4, addatkspeed = 0, breakaddhp = 53.55, breakaddattack = 10.84, breakadddef = 2.55, breakaddmagicDef = 2.55, 
breakMultiple = {15, 35, 70, 120}
, hp = 535, attack = 108, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 2, element = 4, breakType = 7, evolutionType = 7, comborate1 = 0, comborate2 = 0, contractskillid = 60071, contractskillid2 = 60072, contractskillid3 = 500701, assistSkillid = 60071, 
yardskillid = {2001}
, roleLine = "脆弱的人类，记住我的名字——瓦鲁夫，流淌着战斗之血的大块头。", roleLineTextID = 501964, victoryTalk = "哦！！！力量！！！", victoryTalkTextID = 502036, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[8] = {id = 8, name = "爱珐怜", nameTextID = 501591, titleTextID = 501663, shapeID = 1018, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10008, addhp = 90, addattack = 6, adddef = 2.4, addmagicDef = 4, addspeed = 0, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 3.6, breakaddmagicDef = 6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 396, magicDef = 660, speed = "20", atkspeed = 100, vocation = 1, element = 1, breakType = 8, evolutionType = 8, comborate1 = 0, comborate2 = 0, contractskillid = 60081, contractskillid2 = 60082, contractskillid3 = 500801, assistSkillid = 60082, 
yardskillid = {2003}
, roleLine = "爱珐怜，其实是……圣域的守护者哟！", roleLineTextID = 501965, victoryTalk = "企图入侵圣域者，已全部清除。", victoryTalkTextID = 502037, hitornothit = 1, hitproportion = 10, slackoffproportion = 90, favourgift = 2, defaultBuff = "", uniqueequipid = 95008, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[9] = {id = 9, name = "普利姆拉", nameTextID = 501592, titleTextID = 501664, shapeID = 1019, rarity = 1, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10009, addhp = 38.25, addattack = 7.65, adddef = 2.04, addmagicDef = 0.2, addspeed = 2, addatkspeed = 0, breakaddhp = 38.25, breakaddattack = 7.65, breakadddef = 2.04, breakaddmagicDef = 0.2, 
breakMultiple = {15, 35, 70, 120}
, hp = 382, attack = 76, def = 20, magicDef = 2, speed = "25", atkspeed = 100, vocation = 5, element = 3, breakType = 9, evolutionType = 9, comborate1 = 0, comborate2 = 0, contractskillid = 60091, contractskillid2 = 60092, contractskillid3 = 500901, assistSkillid = 60092, 
yardskillid = {3001}
, roleLine = "田间的芬芳真让人陶醉，为普利姆拉摘一朵花，好吗？", roleLineTextID = 501966, victoryTalk = "已经结束了吗？", victoryTalkTextID = 502038, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[10] = {id = 10, name = "芙洛莱", nameTextID = 501593, titleTextID = 501665, shapeID = 1016, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10010, addhp = 45, addattack = 9.45, adddef = 2.4, addmagicDef = 2.52, addspeed = 2, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9.45, breakadddef = 2.4, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 94, def = 24, magicDef = 25, speed = "25", atkspeed = 100, vocation = 5, element = 2, breakType = 10, evolutionType = 10, comborate1 = 0, comborate2 = 4, contractskillid = 60101, contractskillid2 = 60102, contractskillid3 = 501001, assistSkillid = 60101, 
yardskillid = {3003}
, roleLine = "你不是精灵湖畔的人吧……我吗？我叫做芙洛莱，让我用琴声助你一臂之力吧。", roleLineTextID = 501967, victoryTalk = "即便是冥途，我的歌声也能到达。", victoryTalkTextID = 502039, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 95010, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[11] = {id = 11, name = "凯多尼娅", nameTextID = 501594, titleTextID = 501666, shapeID = 1015, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10011, addhp = 90, addattack = 6, adddef = 4, addmagicDef = 2.4, addspeed = 1.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 3.6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 396, speed = "17.5", atkspeed = 100, vocation = 1, element = 3, breakType = 11, evolutionType = 11, comborate1 = 4, comborate2 = 0, contractskillid = 60112, contractskillid2 = 60111, contractskillid3 = 501101, assistSkillid = 60112, 
yardskillid = {1003}
, roleLine = "在问我的名字吗？凯多尼娅，是的，和这孩子一起为你效力。", roleLineTextID = 501968, victoryTalk = "和这孩子一起取得了胜利！", victoryTalkTextID = 502040, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 95011, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[12] = {id = 12, name = "艾妮萌", nameTextID = 501595, titleTextID = 501667, shapeID = 1007, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10012, addhp = 45, addattack = 13.5, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.2, addatkspeed = 0, breakaddhp = 45, breakaddattack = 13.5, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 135, def = 24, magicDef = 24, speed = "27.5", atkspeed = 100, vocation = 6, element = 1, breakType = 12, evolutionType = 12, comborate1 = 0, comborate2 = 0, contractskillid = 60121, contractskillid2 = 60122, contractskillid3 = 501201, assistSkillid = 60121, 
yardskillid = {2003}
, roleLine = "堕落的家伙，接受艾妮萌的制裁吧！", roleLineTextID = 501969, victoryTalk = "伸手触碰黑暗者，亦将沉睡于黑夜之中。", victoryTalkTextID = 502041, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 95012, uniqueequipidunlocktime = "2022-07-28 04:00:00"}
, 
[13] = {id = 13, name = "阿卡莎", nameTextID = 501596, titleTextID = 501668, shapeID = 1012, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10013, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 13, evolutionType = 13, comborate1 = 0, comborate2 = 0, contractskillid = 60131, contractskillid2 = 60132, contractskillid3 = 501301, assistSkillid = 60132, 
yardskillid = {3003}
, roleLine = "阿卡莎——这里真是个奇妙的地方……那么，你又是谁呢？", roleLineTextID = 501970, victoryTalk = "剑道深远……我只是略窥一二。", victoryTalkTextID = 502042, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 95013, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[14] = {id = 14, name = "奈茉茜", nameTextID = 501597, titleTextID = 501669, shapeID = 1014, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10014, addhp = 22.68, addattack = 14.85, adddef = 1.62, addmagicDef = 1.62, addspeed = 2.4, addatkspeed = 0, breakaddhp = 22.68, breakaddattack = 14.85, breakadddef = 1.62, breakaddmagicDef = 1.62, 
breakMultiple = {15, 35, 70, 120}
, hp = 226, attack = 148, def = 16, magicDef = 16, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 14, evolutionType = 14, comborate1 = 0, comborate2 = 0, contractskillid = 60141, contractskillid2 = 60143, contractskillid3 = 501401, assistSkillid = 60141, 
yardskillid = {3002}
, roleLine = "说吧，你的目标……是谁？", roleLineTextID = 501971, victoryTalk = "刃出，即无生还。", victoryTalkTextID = 502043, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[15] = {id = 15, name = "帕嘉妮", nameTextID = 501598, titleTextID = 501670, shapeID = 1022, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10015, addhp = 42.53, addattack = 11.54, adddef = 2.27, addmagicDef = 2.05, addspeed = 2, addatkspeed = 0, breakaddhp = 42.53, breakaddattack = 11.54, breakadddef = 2.27, breakaddmagicDef = 2.05, 
breakMultiple = {15, 35, 70, 120}
, hp = 425, attack = 115, def = 22, magicDef = 20, speed = "25", atkspeed = 100, vocation = 6, element = 1, breakType = 15, evolutionType = 15, comborate1 = 0, comborate2 = 0, contractskillid = 60152, contractskillid2 = 60151, contractskillid3 = 501501, assistSkillid = 60152, 
yardskillid = {1002}
, roleLine = "汝若渴望冰封这个世界，那么跟随汝也无妨。", roleLineTextID = 501972, victoryTalk = "冰雪已经覆盖了这个世界。", victoryTalkTextID = 502044, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[16] = {id = 16, name = "奥塔薇娅", nameTextID = 501599, titleTextID = 501671, shapeID = 1021, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10016, addhp = 56.7, addattack = 10.9, adddef = 2.84, addmagicDef = 2.84, addspeed = 2.4, addatkspeed = 0, breakaddhp = 56.7, breakaddattack = 10.9, breakadddef = 2.84, breakaddmagicDef = 2.84, 
breakMultiple = {15, 35, 70, 120}
, hp = 567, attack = 109, def = 28, magicDef = 28, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 16, evolutionType = 16, comborate1 = 0, comborate2 = 0, contractskillid = 60161, contractskillid2 = 60162, contractskillid3 = 501601, assistSkillid = 60162, 
yardskillid = {2002}
, roleLine = "我存在的意义就是挥剑，此外无他。", roleLineTextID = 501973, victoryTalk = "为剑而生，斩落一切。", victoryTalkTextID = 502045, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[17] = {id = 17, name = "艾拉", nameTextID = 501600, titleTextID = 501672, shapeID = 1025, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10017, addhp = 66.15, addattack = 12.11, adddef = 3.15, addmagicDef = 3.15, addspeed = 2.4, addatkspeed = 0, breakaddhp = 66.15, breakaddattack = 12.11, breakadddef = 3.15, breakaddmagicDef = 3.15, 
breakMultiple = {15, 35, 70, 120}
, hp = 661, attack = 121, def = 31, magicDef = 31, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 17, evolutionType = 17, comborate1 = 0, comborate2 = 0, contractskillid = 60171, contractskillid2 = 60172, contractskillid3 = 501701, assistSkillid = 60171, 
yardskillid = {1003}
, roleLine = "好久没有见过人类了，大概有……五百年？", roleLineTextID = 501974, victoryTalk = "哈哈……见识到龙族的力量了吧！", victoryTalkTextID = 502046, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 2, defaultBuff = "", uniqueequipid = 95017, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[18] = {id = 18, name = "玉", nameTextID = 501601, titleTextID = 501673, shapeID = 1033, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10018, addhp = 42.75, addattack = 8.55, adddef = 2.28, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 8.55, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 85, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 18, evolutionType = 18, comborate1 = 0, comborate2 = 0, contractskillid = 60181, contractskillid2 = 60182, contractskillid3 = 501801, assistSkillid = 60182, 
yardskillid = {2003}
, roleLine = "哎？需要我的力量吗？如果是你的话……嗯，我愿意尽全力帮助你。", roleLineTextID = 501975, victoryTalk = "虽然很辛苦，但我不会逃避。", victoryTalkTextID = 502047, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[19] = {id = 19, name = "命", nameTextID = 501602, titleTextID = 501675, shapeID = 1023, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10019, addhp = 36.45, addattack = 8.91, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36.45, breakaddattack = 8.91, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 364, attack = 89, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 19, evolutionType = 19, comborate1 = 0, comborate2 = 0, contractskillid = 60191, contractskillid2 = 60192, contractskillid3 = 501901, assistSkillid = 60191, 
yardskillid = {3002}
, roleLine = "魔道……必将无处可遁。", roleLineTextID = 501976, victoryTalk = "魔道……退治完毕……", victoryTalkTextID = 502048, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[20] = {id = 20, name = "废弃", nameTextID = 501603, titleTextID = 501676, shapeID = 1024, rarity = 1, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10020, addhp = 53.55, addattack = 10.84, adddef = 2.55, addmagicDef = 2.55, addspeed = 2.4, addatkspeed = 0, breakaddhp = 53.55, breakaddattack = 10.84, breakadddef = 2.55, breakaddmagicDef = 2.55, 
breakMultiple = {15, 35, 70, 120}
, hp = 535, attack = 108, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 2, element = 4, breakType = 20, evolutionType = 20, comborate1 = 0, comborate2 = 0, contractskillid = 60201, contractskillid2 = 60202, contractskillid3 = 502001, assistSkillid = 60201, 
yardskillid = {1001}
, roleLine = "潘诺尼亚的和平，终有一天会来临。", roleLineTextID = 501977, victoryTalk = "敌人，已经全部击败了。", victoryTalkTextID = 502049, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[21] = {id = 21, name = "斯瓦尔巴", nameTextID = 501604, titleTextID = 501677, shapeID = 1026, rarity = 1, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10021, addhp = 56.23, addattack = 10.3, adddef = 2.3, addmagicDef = 3.06, addspeed = 2.4, addatkspeed = 0, breakaddhp = 56.23, breakaddattack = 10.3, breakadddef = 2.3, breakaddmagicDef = 3.06, 
breakMultiple = {15, 35, 70, 120}
, hp = 562, attack = 102, def = 22, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 4, breakType = 21, evolutionType = 21, comborate1 = 0, comborate2 = 0, contractskillid = 60211, contractskillid2 = 60212, contractskillid3 = 502101, assistSkillid = 60211, 
yardskillid = {2001}
, roleLine = "活着的意义……唯有复仇。", roleLineTextID = 501978, victoryTalk = "我的道路坚定不移。", victoryTalkTextID = 502050, hitornothit = 0, hitproportion = 50, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[22] = {id = 22, name = "古尔薇格", nameTextID = 501605, titleTextID = 501678, shapeID = 1027, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10022, addhp = 49.5, addattack = 9, adddef = 2.88, addmagicDef = 2.88, addspeed = 2.4, addatkspeed = 0, breakaddhp = 49.5, breakaddattack = 9, breakadddef = 2.88, breakaddmagicDef = 2.88, 
breakMultiple = {15, 35, 70, 120}
, hp = 495, attack = 90, def = 28, magicDef = 28, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 22, evolutionType = 22, comborate1 = 0, comborate2 = 0, contractskillid = 60222, contractskillid2 = 60221, contractskillid3 = 502201, assistSkillid = 60222, 
yardskillid = {2003}
, roleLine = "你也能感受到这无上的快乐吗？", roleLineTextID = 501979, victoryTalk = "悲鸣？你们的痛苦还远远不够……", victoryTalkTextID = 502051, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[23] = {id = 23, name = "凯瑟琳", nameTextID = 501606, titleTextID = 501679, shapeID = 1028, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10023, addhp = 90, addattack = 6, adddef = 4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 3.6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 396, speed = "30", atkspeed = 100, vocation = 1, element = 3, breakType = 23, evolutionType = 23, comborate1 = 4, comborate2 = 0, contractskillid = 60231, contractskillid2 = 60232, contractskillid3 = 502301, assistSkillid = 60232, 
yardskillid = {3003}
, roleLine = "所有侵略者都将被逐出祖国，死者除外。", roleLineTextID = 501980, victoryTalk = "所有侵略者都将被逐出祖国，死者除外。", victoryTalkTextID = 502052, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 3, defaultBuff = "", uniqueequipid = 95023, uniqueequipidunlocktime = "2022-10-13 15:00:00"}
, 
[24] = {id = 24, name = "谢尔妮", nameTextID = 501607, titleTextID = 501680, shapeID = 1029, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10024, addhp = 40.5, addattack = 8.51, adddef = 2.05, addmagicDef = 2.05, addspeed = 2.4, addatkspeed = 0, breakaddhp = 40.5, breakaddattack = 8.51, breakadddef = 2.05, breakaddmagicDef = 2.05, 
breakMultiple = {15, 35, 70, 120}
, hp = 405, attack = 85, def = 20, magicDef = 20, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 24, evolutionType = 24, comborate1 = 0, comborate2 = 0, contractskillid = 60241, contractskillid2 = 60242, contractskillid3 = 502401, assistSkillid = 60242, 
yardskillid = {1002}
, roleLine = "你身上似乎散发出金钱的气息……", roleLineTextID = 501981, victoryTalk = "只值这点吗？", victoryTalkTextID = 502053, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[25] = {id = 25, name = "达修斯", nameTextID = 501608, titleTextID = 501681, shapeID = 1030, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10025, addhp = 42.75, addattack = 12.83, adddef = 2.28, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 12.83, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 128, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 25, evolutionType = 25, comborate1 = 0, comborate2 = 0, contractskillid = 60251, contractskillid2 = 60252, contractskillid3 = 502501, assistSkillid = 60251, 
yardskillid = {3003}
, roleLine = "执法者达修斯，愿助你一臂之力。", roleLineTextID = 501982, victoryTalk = "接受正义的审判吧！", victoryTalkTextID = 502054, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[26] = {id = 26, name = "露西亚", nameTextID = 501609, titleTextID = 501682, shapeID = 1031, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10026, addhp = 32.4, addattack = 13.5, adddef = 1.62, addmagicDef = 1.62, addspeed = 2.4, addatkspeed = 0, breakaddhp = 32.4, breakaddattack = 13.5, breakadddef = 1.62, breakaddmagicDef = 1.62, 
breakMultiple = {15, 35, 70, 120}
, hp = 324, attack = 135, def = 16, magicDef = 16, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 26, evolutionType = 26, comborate1 = 0, comborate2 = 0, contractskillid = 60261, contractskillid2 = 60262, contractskillid3 = 502601, assistSkillid = 60261, 
yardskillid = {2002}
, roleLine = "满目所见，仍是血色之花。", roleLineTextID = 501983, victoryTalk = "亡骸，华丽地迎来终结。", victoryTalkTextID = 502055, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[27] = {id = 27, name = "凯忒丝", nameTextID = 501610, titleTextID = 501683, shapeID = 1032, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10027, addhp = 81, addattack = 5.4, adddef = 3.6, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 81, breakaddattack = 5.4, breakadddef = 5.4, breakaddmagicDef = 3.24, 
breakMultiple = {15, 35, 70, 120}
, hp = 810, attack = 54, def = 594, magicDef = 356.4, speed = "30", atkspeed = 100, vocation = 1, element = 3, breakType = 27, evolutionType = 27, comborate1 = 0, comborate2 = 0, contractskillid = 60271, contractskillid2 = 60272, contractskillid3 = 502701, assistSkillid = 60271, 
yardskillid = {3002}
, roleLine = "满目所见，仍是血色之花。", roleLineTextID = 501984, victoryTalk = "不想失去性命，就在我面前消失！", victoryTalkTextID = 502056, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[28] = {id = 28, name = "薇奥拉", nameTextID = 501611, titleTextID = 501684, shapeID = 1034, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10028, addhp = 44.89, addattack = 11.54, adddef = 2.39, addmagicDef = 2.39, addspeed = 2.4, addatkspeed = 0, breakaddhp = 44.89, breakaddattack = 11.54, breakadddef = 2.39, breakaddmagicDef = 2.39, 
breakMultiple = {15, 35, 70, 120}
, hp = 448, attack = 115, def = 23, magicDef = 23, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 28, evolutionType = 28, comborate1 = 0, comborate2 = 0, contractskillid = 60281, contractskillid2 = 60282, contractskillid3 = 502801, assistSkillid = 60281, 
yardskillid = {1003}
, roleLine = "你能帮助我学习人类的行为吗？", roleLineTextID = 501985, victoryTalk = "你们的行为……不值得学习。", victoryTalkTextID = 502057, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[29] = {id = 29, name = "瑟兰雅", nameTextID = 501612, titleTextID = 501685, shapeID = 1035, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10029, addhp = 35.28, addattack = 15, adddef = 1.89, addmagicDef = 1.89, addspeed = 2.4, addatkspeed = 0, breakaddhp = 35.28, breakaddattack = 15, breakadddef = 1.89, breakaddmagicDef = 1.89, 
breakMultiple = {15, 35, 70, 120}
, hp = 352, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 29, evolutionType = 29, comborate1 = 0, comborate2 = 0, contractskillid = 60291, contractskillid2 = 60292, contractskillid3 = 502901, assistSkillid = 60291, 
yardskillid = {1003}
, roleLine = "以父亲之名，向天空射出誓约之箭。", roleLineTextID = 501986, victoryTalk = "一箭入魂，无需二发！", victoryTalkTextID = 502058, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 95029, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[30] = {id = 30, name = "阿迦娜", nameTextID = 501613, titleTextID = 501686, shapeID = 1036, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10030, addhp = 42.75, addattack = 8.55, adddef = 2.28, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 8.55, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 85, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 30, evolutionType = 30, comborate1 = 0, comborate2 = 4, contractskillid = 60302, contractskillid2 = 60301, contractskillid3 = 503001, assistSkillid = 60302, 
yardskillid = {2003}
, roleLine = "你就是我的新主顾吗？", roleLineTextID = 501987, victoryTalk = "你们的命运，在此终结。", victoryTalkTextID = 502059, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 95030, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[31] = {id = 31, name = "废弃", nameTextID = 501613, titleTextID = 501686, shapeID = 1036, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10030, addhp = 42.75, addattack = 8.55, adddef = 2.28, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 8.55, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 85, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 4, element = 4, breakType = 30, evolutionType = 30, comborate1 = 0, comborate2 = 0, contractskillid = 60301, contractskillid2 = 60302, contractskillid3 = 503101, assistSkillid = 60301, 
yardskillid = {3003}
, roleLine = "你就是我的新主顾吗？", roleLineTextID = 501987, victoryTalk = "你们的命运，在此终结。", victoryTalkTextID = 502059, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[32] = {id = 32, name = "伊利斯", nameTextID = 501615, titleTextID = 501688, shapeID = 1038, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10032, addhp = 34.02, addattack = 13.5, adddef = 1.57, addmagicDef = 1.57, addspeed = 2.4, addatkspeed = 0, breakaddhp = 34.02, breakaddattack = 13.5, breakadddef = 1.57, breakaddmagicDef = 1.57, 
breakMultiple = {15, 35, 70, 120}
, hp = 340, attack = 135, def = 15, magicDef = 15, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 32, evolutionType = 32, comborate1 = 0, comborate2 = 0, contractskillid = 60321, contractskillid2 = 60322, contractskillid3 = 503201, assistSkillid = 60322, 
yardskillid = {1002}
, roleLine = "森林的主宰，就是我。", roleLineTextID = 501989, victoryTalk = "自不量力的家伙。", victoryTalkTextID = 502061, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[33] = {id = 33, name = "希奈缇娅", nameTextID = 501616, titleTextID = 501689, shapeID = 1039, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10033, addhp = 42.75, addattack = 8.55, adddef = 2.28, addmagicDef = 1.6, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 8.55, breakadddef = 2.28, breakaddmagicDef = 1.6, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 85, def = 22, magicDef = 15, speed = "30", atkspeed = 100, vocation = 5, element = 2, breakType = 33, evolutionType = 33, comborate1 = 0, comborate2 = 4, contractskillid = 60331, contractskillid2 = 60332, contractskillid3 = 503301, assistSkillid = 60332, 
yardskillid = {1003}
, roleLine = "希奈缇娅，听到了你呼唤的声音~~", roleLineTextID = 501990, victoryTalk = "别担心，我会帮你治疗的。", victoryTalkTextID = 502062, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 3, defaultBuff = "", uniqueequipid = 95033, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[34] = {id = 34, name = "夏芙尔", nameTextID = 501617, titleTextID = 501690, shapeID = 1040, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10034, addhp = 37.62, addattack = 14.68, adddef = 1.54, addmagicDef = 1.54, addspeed = 2.4, addatkspeed = 0, breakaddhp = 37.62, breakaddattack = 14.68, breakadddef = 1.54, breakaddmagicDef = 1.54, 
breakMultiple = {15, 35, 70, 120}
, hp = 376, attack = 146, def = 15, magicDef = 15, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 34, evolutionType = 34, comborate1 = 0, comborate2 = 0, contractskillid = 60341, contractskillid2 = 60342, contractskillid3 = 503401, assistSkillid = 60342, 
yardskillid = {2003}
, roleLine = "存在之物，一定是合理的吗？", roleLineTextID = 501991, victoryTalk = "平等地给予你们终结。", victoryTalkTextID = 502063, hitornothit = 1, hitproportion = 30, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 95034, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[35] = {id = 35, name = "莉莉娅", nameTextID = 501618, titleTextID = 501691, shapeID = 1041, rarity = 5, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10035, addhp = 42.75, addattack = 13.5, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 13.5, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 135, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 35, evolutionType = 35, comborate1 = 0, comborate2 = 0, contractskillid = 60352, contractskillid2 = 60351, contractskillid3 = 503501, assistSkillid = 60351, 
yardskillid = {3003}
, roleLine = "这里……和我的故乡……有什么不同吗？", roleLineTextID = 501992, victoryTalk = "放心吧，一切都结束了……没有痛苦。", victoryTalkTextID = 502064, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[36] = {id = 36, name = "卡丝庇妲", nameTextID = 501619, titleTextID = 501692, shapeID = 1042, rarity = 1, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10036, addhp = 38.25, addattack = 11.48, adddef = 2.04, addmagicDef = 2.04, addspeed = 2.4, addatkspeed = 0, breakaddhp = 38.25, breakaddattack = 11.48, breakadddef = 2.04, breakaddmagicDef = 2.04, 
breakMultiple = {15, 35, 70, 120}
, hp = 382, attack = 114, def = 20, magicDef = 20, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 36, evolutionType = 36, comborate1 = 0, comborate2 = 0, contractskillid = 60361, contractskillid2 = 60362, contractskillid3 = 503601, assistSkillid = 60361, 
yardskillid = {3001}
, roleLine = "这狂乱的气息，是吗……你也是同类啊……", roleLineTextID = 501993, victoryTalk = "疯狂……", victoryTalkTextID = 502065, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[38] = {id = 38, name = "梅莫菲斯", nameTextID = 501621, titleTextID = 501694, shapeID = 1044, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10038, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 38, evolutionType = 38, comborate1 = 0, comborate2 = 0, contractskillid = 60381, contractskillid2 = 60382, contractskillid3 = 503801, assistSkillid = 60382, 
yardskillid = {2003}
, roleLine = "喜怒哀乐，终归虚无。", roleLineTextID = 501995, victoryTalk = "让我来读取你的灵魂，轻盈而优雅。", victoryTalkTextID = 502067, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "20984;21224", uniqueequipid = 95038, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[39] = {id = 39, name = "拉芬", nameTextID = 501622, titleTextID = 501695, shapeID = 1045, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10039, addhp = 63, addattack = 12.75, adddef = 3, addmagicDef = 3, addspeed = 2.4, addatkspeed = 0, breakaddhp = 63, breakaddattack = 12.75, breakadddef = 3, breakaddmagicDef = 3, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 127, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 39, evolutionType = 39, comborate1 = 0, comborate2 = 0, contractskillid = 60391, contractskillid2 = 60392, contractskillid3 = 503907, assistSkillid = 60391, 
yardskillid = {1003}
, roleLine = "能告诉拉芬，命运为何指引你来到此地？", roleLineTextID = 501996, victoryTalk = "弗摩尔的平静，由我来守护。", victoryTalkTextID = 502068, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 95039, uniqueequipidunlocktime = "2022-04-28 14:00:00"}
, 
[40] = {id = 40, name = "麻里奈", nameTextID = 501623, titleTextID = 501696, shapeID = 1046, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10040, addhp = 39.69, addattack = 12.39, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 39.69, breakaddattack = 12.39, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 396, attack = 123, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 40, evolutionType = 40, comborate1 = 0, comborate2 = 0, contractskillid = 60401, contractskillid2 = 60402, contractskillid3 = 504001, assistSkillid = 60401, 
yardskillid = {2002}
, roleLine = "任何精细的工作，我的人偶都能完成。", roleLineTextID = 501997, victoryTalk = "寡不敌众，所以你不可能战胜我。", victoryTalkTextID = 502069, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[41] = {id = 41, name = "乌斯庇娅", nameTextID = 501624, titleTextID = 501697, shapeID = 1047, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10041, addhp = 43.61, addattack = 12.57, adddef = 2.17, addmagicDef = 2.39, addspeed = 2.4, addatkspeed = 0, breakaddhp = 43.61, breakaddattack = 12.57, breakadddef = 2.17, breakaddmagicDef = 2.39, 
breakMultiple = {15, 35, 70, 120}
, hp = 436, attack = 125, def = 21, magicDef = 23, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 41, evolutionType = 41, comborate1 = 0, comborate2 = 0, contractskillid = 60411, contractskillid2 = 60412, contractskillid3 = 504101, assistSkillid = 60411, 
yardskillid = {3003}
, roleLine = "拜倒在妾身的脚下吧。", roleLineTextID = 501998, victoryTalk = "违背妾身者，汝等命运于此终结。", victoryTalkTextID = 502070, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 95041, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[42] = {id = 42, name = "阿鵺伦", nameTextID = 501625, titleTextID = 501698, shapeID = 1048, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10042, addhp = 41.47, addattack = 13.21, adddef = 2.21, addmagicDef = 2.21, addspeed = 2.4, addatkspeed = 0, breakaddhp = 41.47, breakaddattack = 13.21, breakadddef = 2.21, breakaddmagicDef = 2.21, 
breakMultiple = {15, 35, 70, 120}
, hp = 414, attack = 132, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 42, evolutionType = 42, comborate1 = 0, comborate2 = 0, contractskillid = 60421, contractskillid2 = 60422, contractskillid3 = 504201, assistSkillid = 60421, 
yardskillid = {1003}
, roleLine = "脆弱的生命啊，感激妾身为汝等咏唱。", roleLineTextID = 501999, victoryTalk = "纵然命火燃尽，妾身以此狂想曲，与汝等共入冥道轮回。", victoryTalkTextID = 502071, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 95042, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[43] = {id = 43, name = "诺伦", nameTextID = 501626, titleTextID = 501699, shapeID = 1049, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10043, addhp = 42.75, addattack = 8.55, adddef = 2.28, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 8.55, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 85, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 5, element = 3, breakType = 43, evolutionType = 43, comborate1 = 0, comborate2 = 0, contractskillid = 60431, contractskillid2 = 60432, contractskillid3 = 504301, assistSkillid = 60431, 
yardskillid = {2003}
, roleLine = "永生的花儿，也会为你绽放。", roleLineTextID = 502000, victoryTalk = "清流在于其源，心清才得永生。", victoryTalkTextID = 502072, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 95043, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[44] = {id = 44, name = "帕玫", nameTextID = 501627, titleTextID = 501700, shapeID = 1050, rarity = 1, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10044, addhp = 40.16, addattack = 10.9, adddef = 2.04, addmagicDef = 2.04, addspeed = 2.4, addatkspeed = 0, breakaddhp = 40.16, breakaddattack = 10.9, breakadddef = 2.04, breakaddmagicDef = 2.04, 
breakMultiple = {15, 35, 70, 120}
, hp = 401, attack = 109, def = 20, magicDef = 20, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 44, evolutionType = 44, comborate1 = 0, comborate2 = 0, contractskillid = 60441, contractskillid2 = 60442, contractskillid3 = 504401, assistSkillid = 60441, 
yardskillid = {2001}
, roleLine = "魔法的修炼之旅，能陪我到终点吗？", roleLineTextID = 502001, victoryTalk = "你们还需要更多的修炼。", victoryTalkTextID = 502073, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[45] = {id = 45, name = "达娜", nameTextID = 501629, titleTextID = 502800, shapeID = 1052, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10045, addhp = 40.5, addattack = 12.15, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 40.5, breakaddattack = 12.15, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 405, attack = 121, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 46, evolutionType = 45, comborate1 = 0, comborate2 = 0, contractskillid = 60451, contractskillid2 = 60452, contractskillid3 = 504501, assistSkillid = 60452, 
yardskillid = {3002}
, roleLine = "人类的气息，上次还是千年之前吧……", roleLineTextID = 502003, victoryTalk = "笑止，汝等竟妄言为高贵精灵之敌。", victoryTalkTextID = 502075, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[46] = {id = 46, name = "露索尼亚", nameTextID = 501620, titleTextID = 501693, shapeID = 1043, rarity = 1, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10037, addhp = 56.7, addattack = 11.48, adddef = 2.7, addmagicDef = 2.7, addspeed = 2.4, addatkspeed = 0, breakaddhp = 56.7, breakaddattack = 11.48, breakadddef = 2.7, breakaddmagicDef = 2.7, 
breakMultiple = {15, 35, 70, 120}
, hp = 567, attack = 114, def = 27, magicDef = 27, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 46, evolutionType = 37, comborate1 = 0, comborate2 = 0, contractskillid = 60371, contractskillid2 = 60372, contractskillid3 = 504601, assistSkillid = 60371, 
yardskillid = {3001}
, roleLine = "这温柔的气息……或许你也是值得依靠之人……", roleLineTextID = 501994, victoryTalk = "这份温暖，不能再度失去……", victoryTalkTextID = 502066, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[47] = {id = 47, name = "诺忒娜", nameTextID = 501630, titleTextID = 501703, shapeID = 1053, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10047, addhp = 37.62, addattack = 13.68, adddef = 1.88, addmagicDef = 1.54, addspeed = 2.4, addatkspeed = 0, breakaddhp = 37.62, breakaddattack = 13.68, breakadddef = 1.88, breakaddmagicDef = 1.54, 
breakMultiple = {15, 35, 70, 120}
, hp = 376, attack = 136, def = 18, magicDef = 15, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 47, evolutionType = 47, comborate1 = 0, comborate2 = 0, contractskillid = 60471, contractskillid2 = 60472, contractskillid3 = 504701, assistSkillid = 60471, 
yardskillid = {3003}
, roleLine = "夜之气息……你也是我的同伴吗？", roleLineTextID = 502004, victoryTalk = "太弱了，打发时间都称不上……", victoryTalkTextID = 502076, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 95047, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[48] = {id = 48, name = "奇芬", nameTextID = 501631, titleTextID = 501704, shapeID = 1055, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10048, addhp = 59.85, addattack = 12.11, adddef = 2.85, addmagicDef = 2.85, addspeed = 2.4, addatkspeed = 0, breakaddhp = 59.85, breakaddattack = 12.11, breakadddef = 2.85, breakaddmagicDef = 2.85, 
breakMultiple = {15, 35, 70, 120}
, hp = 598, attack = 121, def = 28, magicDef = 28, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 48, evolutionType = 48, comborate1 = 0, comborate2 = 0, contractskillid = 60481, contractskillid2 = 60482, contractskillid3 = 504801, assistSkillid = 60482, 
yardskillid = {1003}
, roleLine = "即便是引渡人，也需要劳逸结合啊。", roleLineTextID = 502005, victoryTalk = "哎？又来了新灵魂？好麻烦啊，交给其他人吧。", victoryTalkTextID = 502077, hitornothit = 1, hitproportion = 30, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 95048, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[49] = {id = 49, name = "尤露古", nameTextID = 501632, titleTextID = 501705, shapeID = 1056, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10049, addhp = 81, addattack = 5.4, adddef = 2.16, addmagicDef = 3.6, addspeed = 2.4, addatkspeed = 0, breakaddhp = 81, breakaddattack = 5.4, breakadddef = 3.24, breakaddmagicDef = 5.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 810, attack = 54, def = 356.4, magicDef = 594, speed = "30", atkspeed = 100, vocation = 1, element = 1, breakType = 49, evolutionType = 49, comborate1 = 0, comborate2 = 0, contractskillid = 60492, contractskillid2 = 60491, contractskillid3 = 504901, assistSkillid = 60491, 
yardskillid = {1002}
, roleLine = "为何，你也能踏入虚空之境？", roleLineTextID = 502006, victoryTalk = "任何企图入侵虚空者，平等地给予死亡。", victoryTalkTextID = 502078, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[50] = {id = 50, name = "废弃", nameTextID = 501640, titleTextID = 501713, shapeID = 1065, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10050, addhp = 63, addattack = 12.75, adddef = 3, addmagicDef = 3, addspeed = 2.4, addatkspeed = 0, breakaddhp = 63, breakaddattack = 12.75, breakadddef = 3, breakaddmagicDef = 3, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 127, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 4, breakType = 50, evolutionType = 50, comborate1 = 0, comborate2 = 0, contractskillid = 60501, contractskillid2 = 60502, contractskillid3 = 505001, assistSkillid = 60501, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502014, victoryTalk = "???", victoryTalkTextID = 502086, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[51] = {id = 51, name = "托奈兰", nameTextID = 501634, titleTextID = 501707, shapeID = 1059, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10051, addhp = 47.25, addattack = 9, adddef = 2.28, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 47.25, breakaddattack = 9, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 472, attack = 90, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 5, element = 2, breakType = 51, evolutionType = 51, comborate1 = 0, comborate2 = 4, contractskillid = 60511, contractskillid2 = 60512, contractskillid3 = 505101, assistSkillid = 60512, 
yardskillid = {1003}
, roleLine = "那个……你需要治疗吗？别担心，我会帮助你的~", roleLineTextID = 502008, victoryTalk = "和书本上说的一样……坏人被击败了？", victoryTalkTextID = 502080, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 4, defaultBuff = "", uniqueequipid = 95051, uniqueequipidunlocktime = "2022-12-08 15:00:00"}
, 
[52] = {id = 52, name = "尤妲娅", nameTextID = 501635, titleTextID = 501708, shapeID = 1060, rarity = 2, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10052, addhp = 40.5, addattack = 8.51, adddef = 1.94, addmagicDef = 1.94, addspeed = 2.4, addatkspeed = 0, breakaddhp = 40.5, breakaddattack = 8.51, breakadddef = 1.94, breakaddmagicDef = 1.94, 
breakMultiple = {15, 35, 70, 120}
, hp = 405, attack = 85, def = 19, magicDef = 19, speed = "30", atkspeed = 100, vocation = 5, element = 2, breakType = 52, evolutionType = 52, comborate1 = 0, comborate2 = 0, contractskillid = 60521, contractskillid2 = 60522, contractskillid3 = 505201, assistSkillid = 60522, 
yardskillid = {2002}
, roleLine = "我是尤妲娅~~要和我一起玩吗？", roleLineTextID = 502009, victoryTalk = "大胜利~~~喔！！！", victoryTalkTextID = 502081, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[53] = {id = 53, name = "爱迪希亚", nameTextID = 501636, titleTextID = 501709, shapeID = 1061, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10053, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 1, breakType = 53, evolutionType = 53, comborate1 = 0, comborate2 = 4, contractskillid = 60531, contractskillid2 = 60532, contractskillid3 = 505301, assistSkillid = 60531, 
yardskillid = {2003}
, roleLine = "哎，你是？妈妈说过，不可以和陌生人说话哟~~", roleLineTextID = 502010, victoryTalk = "要一起去沙滩漫步吗？海风拂面的感觉很舒服的~", victoryTalkTextID = 502082, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 95053, uniqueequipidunlocktime = "2022-10-13 15:00:00"}
, 
[54] = {id = 54, name = "嘉代提斯", nameTextID = 501637, titleTextID = 501710, shapeID = 1062, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10054, addhp = 40.61, addattack = 8.98, adddef = 2.28, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 40.61, breakaddattack = 8.98, breakadddef = 2.28, breakaddmagicDef = 2.28, 
breakMultiple = {15, 35, 70, 120}
, hp = 406, attack = 89, def = 22, magicDef = 22, speed = "30", atkspeed = 100, vocation = 5, element = 2, breakType = 54, evolutionType = 54, comborate1 = 0, comborate2 = 0, contractskillid = 60541, contractskillid2 = 60542, contractskillid3 = 505401, assistSkillid = 60541, 
yardskillid = {2003}
, roleLine = "灵界的吟游诗人——嘉代提斯，你能给我带来新的灵感吗？", roleLineTextID = 502011, victoryTalk = "你们都将成为我创作的音符。", victoryTalkTextID = 502083, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[55] = {id = 55, name = "伊&露", nameTextID = 501638, titleTextID = 501711, shapeID = 1063, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10055, addhp = 33.17, addattack = 14.68, adddef = 1.68, addmagicDef = 1.68, addspeed = 2.4, addatkspeed = 0, breakaddhp = 33.17, breakaddattack = 14.68, breakadddef = 1.68, breakaddmagicDef = 1.68, 
breakMultiple = {15, 35, 70, 120}
, hp = 331, attack = 146, def = 16, magicDef = 16, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 55, evolutionType = 55, comborate1 = 0, comborate2 = 0, contractskillid = 60551, contractskillid2 = 60552, contractskillid3 = 505501, assistSkillid = 60552, 
yardskillid = {3003}
, roleLine = "请下达新的命令吧！我们会帮你清除任何目标~~", roleLineTextID = 502012, victoryTalk = "目标已经消灭~~", victoryTalkTextID = 502084, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95055, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[56] = {id = 56, name = "脱解", nameTextID = 501639, titleTextID = 501712, shapeID = 1064, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10056, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 56, evolutionType = 56, comborate1 = 0, comborate2 = 4, contractskillid = 60561, contractskillid2 = 60562, contractskillid3 = 505601, assistSkillid = 60561, 
yardskillid = {3003}
, roleLine = "外面的世界是怎样的呢？妾身，非常感兴趣。", roleLineTextID = 502013, victoryTalk = "日升之处，魑魅魍魉自当退散。", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 30, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95056, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[57] = {id = 57, name = "阿维尔", nameTextID = 501633, titleTextID = 501706, shapeID = 1058, rarity = 1, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10057, addhp = 76.5, addattack = 5.1, adddef = 3.4, addmagicDef = 0.34, addspeed = 2.4, addatkspeed = 0, breakaddhp = 76.5, breakaddattack = 5.1, breakadddef = 5.1, breakaddmagicDef = 0.51, 
breakMultiple = {15, 35, 70, 120}
, hp = 765, attack = 51, def = 561, magicDef = 56.1, speed = "30", atkspeed = 100, vocation = 1, element = 3, breakType = 57, evolutionType = 57, comborate1 = 0, comborate2 = 0, contractskillid = 60571, contractskillid2 = 60572, contractskillid3 = 505701, assistSkillid = 60572, 
yardskillid = {1001}
, roleLine = "我是王城守卫阿维尔，誓将守卫贝尔吉卡王室的荣耀！", roleLineTextID = 502007, victoryTalk = "王室的荣耀，将再次照耀这片土地！", victoryTalkTextID = 502079, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[58] = {id = 58, name = "废弃", nameTextID = 501641, titleTextID = 501714, shapeID = 1066, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10058, addhp = 32.4, addattack = 13.1, adddef = 1.7, addmagicDef = 1.62, addspeed = 2.4, addatkspeed = 0, breakaddhp = 32.4, breakaddattack = 13.1, breakadddef = 1.7, breakaddmagicDef = 1.62, 
breakMultiple = {15, 35, 70, 120}
, hp = 324, attack = 130, def = 17, magicDef = 16, speed = "30", atkspeed = 100, vocation = 3, element = 4, breakType = 58, evolutionType = 58, comborate1 = 0, comborate2 = 0, contractskillid = 60581, contractskillid2 = 60582, contractskillid3 = 505801, assistSkillid = 60581, 
yardskillid = {3002}
, roleLine = "???", roleLineTextID = 502015, victoryTalk = "???", victoryTalkTextID = 502087, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[59] = {id = 59, name = "鸾", nameTextID = 501642, titleTextID = 501715, shapeID = 1067, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10059, addhp = 85.5, addattack = 5.7, adddef = 3.8, addmagicDef = 2.28, addspeed = 2.4, addatkspeed = 0, breakaddhp = 85.5, breakaddattack = 5.7, breakadddef = 5.7, breakaddmagicDef = 3.42, 
breakMultiple = {15, 35, 70, 120}
, hp = 855, attack = 57, def = 627, magicDef = 376.2, speed = "30", atkspeed = 100, vocation = 1, element = 1, breakType = 59, evolutionType = 59, comborate1 = 0, comborate2 = 0, contractskillid = 60591, contractskillid2 = 60592, contractskillid3 = 505901, assistSkillid = 60592, 
yardskillid = {1003}
, roleLine = "缭乱的世界更具有魅力。人，风，太阳...充满生命的光芒……", roleLineTextID = 502016, victoryTalk = "我的热情会燃尽一切。", victoryTalkTextID = 502088, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95059, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[60] = {id = 60, name = "废弃", nameTextID = 501643, titleTextID = 501716, shapeID = 1068, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10060, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 60, evolutionType = 60, comborate1 = 0, comborate2 = 0, contractskillid = 60601, contractskillid2 = 60602, contractskillid3 = 506001, assistSkillid = 60601, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502017, victoryTalk = "???", victoryTalkTextID = 502089, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[61] = {id = 61, name = "由依", nameTextID = 501644, titleTextID = 501717, shapeID = 1069, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10061, addhp = 59.85, addattack = 12.72, adddef = 2.71, addmagicDef = 2.71, addspeed = 2.4, addatkspeed = 0, breakaddhp = 59.85, breakaddattack = 12.72, breakadddef = 2.71, breakaddmagicDef = 2.71, 
breakMultiple = {15, 35, 70, 120}
, hp = 598, attack = 127, def = 27, magicDef = 27, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 61, evolutionType = 61, comborate1 = 0, comborate2 = 0, contractskillid = 60611, contractskillid2 = 60612, contractskillid3 = 506101, assistSkillid = 60611, 
yardskillid = {2003}
, roleLine = "继承了神官家族——欧琳迪克的血脉，破魔之枪由依，应你的召唤前来。", roleLineTextID = 502018, victoryTalk = "破魔之枪非为斩恶而锋利，为渡世向善而生之锋利。", victoryTalkTextID = 502090, hitornothit = 1, hitproportion = 30, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[62] = {id = 62, name = "纳莎（需要换ID）", nameTextID = 501645, titleTextID = 501718, shapeID = 1070, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10062, addhp = 45, addattack = 13.5, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 13.5, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 135, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 62, evolutionType = 62, comborate1 = 0, comborate2 = 0, contractskillid = 60621, contractskillid2 = 60622, contractskillid3 = 506201, assistSkillid = 60621, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502019, victoryTalk = "???", victoryTalkTextID = 502091, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[63] = {id = 63, name = "南奈尔", nameTextID = 501646, titleTextID = 501719, shapeID = 1071, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10063, addhp = 90, addattack = 6, adddef = 4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 3.6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 396, speed = "30", atkspeed = 100, vocation = 1, element = 1, breakType = 63, evolutionType = 63, comborate1 = 0, comborate2 = 0, contractskillid = 60631, contractskillid2 = 60632, contractskillid3 = 506301, assistSkillid = 60631, 
yardskillid = {3003}
, roleLine = "你是……不认识的人呢。南奈尔一直在镜中睡觉，不清楚外面的事情。", roleLineTextID = 502020, victoryTalk = "请不要再靠近我了！", victoryTalkTextID = 502092, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95063, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[64] = {id = 64, name = "伊莎贝拉", nameTextID = 501647, titleTextID = 501720, shapeID = 1072, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10064, addhp = 32.4, addattack = 15, adddef = 1.98, addmagicDef = 1.98, addspeed = 2.4, addatkspeed = 0, breakaddhp = 32.4, breakaddattack = 15, breakadddef = 1.98, breakaddmagicDef = 1.98, 
breakMultiple = {15, 35, 70, 120}
, hp = 324, attack = 150, def = 19, magicDef = 19, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 64, evolutionType = 64, comborate1 = 0, comborate2 = 0, contractskillid = 60641, contractskillid2 = 60642, contractskillid3 = 506401, assistSkillid = 60641, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502021, victoryTalk = "???", victoryTalkTextID = 502093, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95064, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[65] = {id = 65, name = "拉·柯莉玛", nameTextID = 501648, titleTextID = 501721, shapeID = 1073, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10065, addhp = 42.75, addattack = 6.84, adddef = 2.51, addmagicDef = 2.51, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 6.84, breakadddef = 2.51, breakaddmagicDef = 2.51, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 68, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 65, evolutionType = 65, comborate1 = 0, comborate2 = 4, contractskillid = 60651, contractskillid2 = 60652, contractskillid3 = 506501, assistSkillid = 60652, 
yardskillid = {3003}
, roleLine = "抹不尽的泪水，从两颊流下，为什么总是触动我的心弦？孤身一人时，止不住再次落泪。", roleLineTextID = 502022, victoryTalk = "我不喜欢战斗……所以，请你们快点离开吧……", victoryTalkTextID = 502094, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "21197", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[66] = {id = 66, name = "荷恩", nameTextID = 501649, titleTextID = 501722, shapeID = 1090, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10066, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 66, evolutionType = 66, comborate1 = 0, comborate2 = 4, contractskillid = 60661, contractskillid2 = 60662, contractskillid3 = 506601, assistSkillid = 60661, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502023, victoryTalk = "???", victoryTalkTextID = 502095, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95066, uniqueequipidunlocktime = "2023-01-05 15:00:00"}
, 
[67] = {id = 67, name = "辛妮", nameTextID = 501614, titleTextID = 501687, shapeID = 1037, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10067, addhp = 66.15, addattack = 12.11, adddef = 3.15, addmagicDef = 3.15, addspeed = 2.4, addatkspeed = 0, breakaddhp = 66.15, breakaddattack = 12.11, breakadddef = 3.15, breakaddmagicDef = 3.15, 
breakMultiple = {15, 35, 70, 120}
, hp = 661, attack = 121, def = 31, magicDef = 31, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 67, evolutionType = 67, comborate1 = 0, comborate2 = 0, contractskillid = 60671, contractskillid2 = 60672, contractskillid3 = 506701, assistSkillid = 60671, 
yardskillid = {3003}
, roleLine = "你也喜欢奶油蛋糕吗？要我教你制作的方法吗？", roleLineTextID = 501988, victoryTalk = "碍事的家伙都被解决了，要去做新的蛋糕了~~", victoryTalkTextID = 502060, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[68] = {id = 68, name = "多琳", nameTextID = 501651, titleTextID = 501724, shapeID = 1092, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10068, addhp = 38.25, addattack = 7.65, adddef = 2.04, addmagicDef = 2.04, addspeed = 2.4, addatkspeed = 0, breakaddhp = 38.25, breakaddattack = 7.65, breakadddef = 2.04, breakaddmagicDef = 2.04, 
breakMultiple = {15, 35, 70, 120}
, hp = 382, attack = 76, def = 20, magicDef = 20, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 68, evolutionType = 68, comborate1 = 0, comborate2 = 0, contractskillid = 60681, contractskillid2 = 60682, contractskillid3 = 506801, assistSkillid = 60681, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502025, victoryTalk = "???", victoryTalkTextID = 502097, hitornothit = 0, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[69] = {id = 69, name = "玛娅维尔", nameTextID = 501652, titleTextID = 501725, shapeID = 1077, rarity = 3, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10069, addhp = 44.89, addattack = 12.18, adddef = 2.39, addmagicDef = 2.17, addspeed = 2.4, addatkspeed = 0, breakaddhp = 44.89, breakaddattack = 12.18, breakadddef = 2.39, breakaddmagicDef = 2.17, 
breakMultiple = {15, 35, 70, 120}
, hp = 448, attack = 121, def = 23, magicDef = 21, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 69, evolutionType = 69, comborate1 = 0, comborate2 = 0, contractskillid = 60692, contractskillid2 = 60691, contractskillid3 = 506901, assistSkillid = 60691, 
yardskillid = {1003}
, roleLine = "你强烈的思念……我确实感受到了。", roleLineTextID = 502026, victoryTalk = "女神大人赋予了我守护这片森林的使命。", victoryTalkTextID = 502098, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95069, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[70] = {id = 70, name = "米奈厄", nameTextID = 501653, titleTextID = 501726, shapeID = 1078, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10070, addhp = 45, addattack = 13.5, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 13.5, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 135, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 70, evolutionType = 70, comborate1 = 0, comborate2 = 0, contractskillid = 60702, contractskillid2 = 60701, contractskillid3 = 507001, assistSkillid = 60702, 
yardskillid = {1003}
, roleLine = "放下心中的杂念，欣赏这美丽的夜色吧~", roleLineTextID = 502027, victoryTalk = "为了达娜大人，我要尽全力守护这片森林。", victoryTalkTextID = 502099, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95070, uniqueequipidunlocktime = "2021-03-14 04:00:00"}
, 
[71] = {id = 71, name = "玛特薇芙", nameTextID = 502624, titleTextID = 502619, shapeID = 1087, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10071, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 71, evolutionType = 71, comborate1 = 0, comborate2 = 0, contractskillid = 60711, contractskillid2 = 60712, contractskillid3 = 507101, assistSkillid = 60711, 
yardskillid = {2003}
, roleLine = "我存在的意义就是挥剑，此外无他。", roleLineTextID = 501973, victoryTalk = "为剑而生，斩落一切。", victoryTalkTextID = 502045, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95071, uniqueequipidunlocktime = "2022-06-21 04:00:00"}
, 
[72] = {id = 72, name = "夏尔", nameTextID = 501655, titleTextID = 501728, shapeID = 1080, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10072, addhp = 40.5, addattack = 9.45, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 40.5, breakaddattack = 9.45, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 405, attack = 94, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 3, breakType = 72, evolutionType = 72, comborate1 = 0, comborate2 = 0, contractskillid = 60721, contractskillid2 = 60722, contractskillid3 = 507201, assistSkillid = 60721, 
yardskillid = {2003}
, roleLine = "和你的相遇一定是命运的指引……", roleLineTextID = 502029, victoryTalk = "我已经下定决心……也要努力看看。", victoryTalkTextID = 502101, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 95072, uniqueequipidunlocktime = "2022-07-21 15:00:00"}
, 
[73] = {id = 73, name = "露达", nameTextID = 502620, titleTextID = 502615, shapeID = 1083, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10073, addhp = 36.45, addattack = 8.51, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36.45, breakaddattack = 8.51, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 364, attack = 85, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 5, element = 3, breakType = 73, evolutionType = 73, comborate1 = 0, comborate2 = 0, contractskillid = 60731, contractskillid2 = 60732, contractskillid3 = 507301, assistSkillid = 60732, 
yardskillid = {3002}
, roleLine = "星光采集者——露达。凡人，称赞我的美貌，成为我的信徒吧~~", roleLineTextID = 502689, victoryTalk = "如果音乐是爱情的食粮，那么就让它继续演奏下去，直到你拜倒在我身下为止。", victoryTalkTextID = 502693, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[74] = {id = 74, name = "希尔达", nameTextID = 502621, titleTextID = 502616, shapeID = 1084, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10074, addhp = 51.03, addattack = 12.05, adddef = 2.7, addmagicDef = 2.7, addspeed = 2.4, addatkspeed = 0, breakaddhp = 51.03, breakaddattack = 12.05, breakadddef = 2.7, breakaddmagicDef = 2.7, 
breakMultiple = {15, 35, 70, 120}
, hp = 510, attack = 120, def = 27, magicDef = 27, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 74, evolutionType = 74, comborate1 = 0, comborate2 = 0, contractskillid = 60741, contractskillid2 = 60742, contractskillid3 = 507401, assistSkillid = 60741, 
yardskillid = {1002}
, roleLine = "洛哈伯王室的剑士——希尔达，祖国的荣耀与我同在！", roleLineTextID = 502690, victoryTalk = "不抱有死亡的觉悟，就没有资格踏入这片战场。", victoryTalkTextID = 502694, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[75] = {id = 75, name = "菲", nameTextID = 502622, titleTextID = 502617, shapeID = 1085, rarity = 1, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10075, addhp = 48.2, addattack = 11.38, adddef = 2.55, addmagicDef = 2.55, addspeed = 2.4, addatkspeed = 0, breakaddhp = 48.2, breakaddattack = 11.38, breakadddef = 2.55, breakaddmagicDef = 2.55, 
breakMultiple = {15, 35, 70, 120}
, hp = 481, attack = 113, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 75, evolutionType = 75, comborate1 = 0, comborate2 = 0, contractskillid = 60751, contractskillid2 = 60752, contractskillid3 = 507501, assistSkillid = 60751, 
yardskillid = {2001}
, roleLine = "菲——以这把魔枪起誓，助你一臂之力！", roleLineTextID = 502691, victoryTalk = "贯彻自己的信念，直到最后一刻。", victoryTalkTextID = 502695, hitornothit = 1, hitproportion = 10, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[76] = {id = 76, name = "莫尔提茉", nameTextID = 502623, titleTextID = 502618, shapeID = 1086, rarity = 2, damagetype = 1, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10076, addhp = 36.45, addattack = 8.51, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36.45, breakaddattack = 8.51, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 364, attack = 85, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 5, element = 2, breakType = 76, evolutionType = 76, comborate1 = 0, comborate2 = 0, contractskillid = 60761, contractskillid2 = 60762, contractskillid3 = 507601, assistSkillid = 60761, 
yardskillid = {2002}
, roleLine = "一个人走夜路是很危险的哟~~莫尔提茉，感受到了你的气息。", roleLineTextID = 502692, victoryTalk = "这么快就结束了？我还没有尽兴呢~~", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[78] = {id = 78, name = "水月", nameTextID = 502811, titleTextID = 502810, shapeID = 1097, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10078, addhp = 59.85, addattack = 12.11, adddef = 2.85, addmagicDef = 2.85, addspeed = 2.4, addatkspeed = 0, breakaddhp = 59.85, breakaddattack = 12.11, breakadddef = 2.85, breakaddmagicDef = 2.85, 
breakMultiple = {15, 35, 70, 120}
, hp = 598, attack = 121, def = 28, magicDef = 28, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 78, evolutionType = 78, comborate1 = 0, comborate2 = 0, contractskillid = 60781, contractskillid2 = 60782, contractskillid3 = 507801, assistSkillid = 60782, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[79] = {id = 79, name = "辛布莉特", nameTextID = 502813, titleTextID = 502812, shapeID = 1098, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10079, addhp = 90, addattack = 6, adddef = 4.06, addmagicDef = 4.06, addspeed = 2.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 660, speed = "30", atkspeed = 100, vocation = 1, element = 1, breakType = 79, evolutionType = 79, comborate1 = 0, comborate2 = 0, contractskillid = 60791, contractskillid2 = 60792, contractskillid3 = 507901, assistSkillid = 60792, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 95079, uniqueequipidunlocktime = "2022-10-17 04:00:00"}
, 
[80] = {id = 80, name = "纳莎", nameTextID = 501645, titleTextID = 501718, shapeID = 1105, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10080, addhp = 42.75, addattack = 13.5, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 13.5, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 135, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 80, evolutionType = 80, comborate1 = 0, comborate2 = 0, contractskillid = 60801, contractskillid2 = 60802, contractskillid3 = 508001, assistSkillid = 60801, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 95080, uniqueequipidunlocktime = "2022-12-15 15:00:00"}
, 
[81] = {id = 81, name = "神居", nameTextID = 502801, titleTextID = 502802, shapeID = 1068, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10081, addhp = 49.5, addattack = 8.1, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 49.5, breakaddattack = 8.1, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 495, attack = 81, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 81, evolutionType = 81, comborate1 = 0, comborate2 = 0, contractskillid = 60811, contractskillid2 = 60812, contractskillid3 = 508101, assistSkillid = 60811, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502017, victoryTalk = "???", victoryTalkTextID = 502089, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 5, defaultBuff = "", uniqueequipid = 95081, uniqueequipidunlocktime = "2022-07-26 04:00:00"}
, 
[82] = {id = 82, name = "地狱之焰", nameTextID = 503041, titleTextID = 503042, shapeID = 1135, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10082, addhp = 63, addattack = 13.01, adddef = 3.06, addmagicDef = 2.94, addspeed = 2.4, addatkspeed = 0, breakaddhp = 63, breakaddattack = 13.01, breakadddef = 3.06, breakaddmagicDef = 2.94, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 130, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 82, evolutionType = 82, comborate1 = 0, comborate2 = 0, contractskillid = 60821, contractskillid2 = 60822, contractskillid3 = 508201, assistSkillid = 60822, 
yardskillid = {3003}
, roleLine = "？？", roleLineTextID = 502014, victoryTalk = "？？", victoryTalkTextID = 502086, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 5, defaultBuff = "", uniqueequipid = 95082, uniqueequipidunlocktime = "2023-03-02 4:00:00"}
, 
[83] = {id = 83, name = "瑟希薇", nameTextID = 502840, titleTextID = 502839, shapeID = 1101, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10083, addhp = 49.5, addattack = 8.1, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 49.5, breakaddattack = 8.1, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 495, attack = 81, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 83, evolutionType = 83, comborate1 = 0, comborate2 = 0, contractskillid = 60831, contractskillid2 = 60832, contractskillid3 = 508301, assistSkillid = 60831, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[84] = {id = 84, name = "埃舍雷", nameTextID = 502924, titleTextID = 502925, shapeID = 1113, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10084, addhp = 45, addattack = 15, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 15, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 135, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 84, evolutionType = 84, comborate1 = 0, comborate2 = 0, contractskillid = 60841, contractskillid2 = 60842, contractskillid3 = 508401, assistSkillid = 60842, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95084, uniqueequipidunlocktime = "2022-06-30 4:00:00"}
, 
[85] = {id = 85, name = "弗莱尔", nameTextID = 502922, titleTextID = 502923, shapeID = 1114, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10085, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 3, breakType = 85, evolutionType = 85, comborate1 = 0, comborate2 = 0, contractskillid = 60851, contractskillid2 = 60852, contractskillid3 = 508501, assistSkillid = 60852, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95085, uniqueequipidunlocktime = "2022-06-30 4:00:00"}
, 
[86] = {id = 86, name = "费吉亚", nameTextID = 502887, titleTextID = 502886, shapeID = 1109, rarity = 3, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10086, addhp = 33.17, addattack = 14.68, adddef = 1.68, addmagicDef = 1.68, addspeed = 2.4, addatkspeed = 0, breakaddhp = 33.17, breakaddattack = 14.68, breakadddef = 1.68, breakaddmagicDef = 1.68, 
breakMultiple = {15, 35, 70, 120}
, hp = 331, attack = 146, def = 16, magicDef = 16, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 86, evolutionType = 86, comborate1 = 0, comborate2 = 0, contractskillid = 60861, contractskillid2 = 60862, contractskillid3 = 508601, assistSkillid = 60861, 
yardskillid = {3003}
, roleLine = "阿卡莎——这里真是个奇妙的地方……那么，你又是谁呢？", roleLineTextID = 501970, victoryTalk = "剑道深远……我只是略窥一二。", victoryTalkTextID = 502042, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[88] = {id = 88, name = "卡蜜莉安", nameTextID = 502950, titleTextID = 502951, shapeID = 1119, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10088, addhp = 63, addattack = 12.75, adddef = 3, addmagicDef = 3, addspeed = 2.4, addatkspeed = 0, breakaddhp = 63, breakaddattack = 12.75, breakadddef = 3, breakaddmagicDef = 3, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 127, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 88, evolutionType = 88, comborate1 = 0, comborate2 = 0, contractskillid = 60881, contractskillid2 = 60882, contractskillid3 = 508801, assistSkillid = 60882, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 5, defaultBuff = "", uniqueequipid = 95088, uniqueequipidunlocktime = "2022-08-11 4:00:00"}
, 
[89] = {id = 89, name = "暗之艾妮萌", nameTextID = 502824, titleTextID = 502823, shapeID = 1099, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10089, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 89, evolutionType = 89, comborate1 = 0, comborate2 = 0, contractskillid = 60891, contractskillid2 = 60892, contractskillid3 = 508901, assistSkillid = 60891, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502017, victoryTalk = "???", victoryTalkTextID = 502089, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95089, uniqueequipidunlocktime = "2022-05-05 15:00:00"}
, 
[90] = {id = 90, name = "蓓丝蒂", nameTextID = 502822, titleTextID = 502821, shapeID = 1100, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10090, addhp = 66.15, addattack = 12.11, adddef = 3.15, addmagicDef = 3.15, addspeed = 2.4, addatkspeed = 0, breakaddhp = 66.15, breakaddattack = 12.11, breakadddef = 3.15, breakaddmagicDef = 3.15, 
breakMultiple = {15, 35, 70, 120}
, hp = 661, attack = 121, def = 31, magicDef = 31, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 90, evolutionType = 90, comborate1 = 0, comborate2 = 0, contractskillid = 60901, contractskillid2 = 60902, contractskillid3 = 509001, assistSkillid = 60902, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95090, uniqueequipidunlocktime = "2021-05-24 04:00:00"}
, 
[91] = {id = 91, name = "柯塔娜", nameTextID = 502896, titleTextID = 502895, shapeID = 1065, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10091, addhp = 61.74, addattack = 13.01, adddef = 3.06, addmagicDef = 2.94, addspeed = 2.4, addatkspeed = 0, breakaddhp = 61.74, breakaddattack = 13.01, breakadddef = 3.06, breakaddmagicDef = 2.94, 
breakMultiple = {15, 35, 70, 120}
, hp = 617, attack = 130, def = 30, magicDef = 29, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 91, evolutionType = 91, comborate1 = 0, comborate2 = 0, contractskillid = 60911, contractskillid2 = 60912, contractskillid3 = 509101, assistSkillid = 60912, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502014, victoryTalk = "日升之处，魑魅魍魉自当退散。", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95091, uniqueequipidunlocktime = "2022-05-19 15:00:00"}
, 
[92] = {id = 92, name = "年幼阿卡莎", nameTextID = 502904, titleTextID = 502903, shapeID = 1110, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10092, addhp = 59.85, addattack = 13.39, adddef = 3, addmagicDef = 3, addspeed = 2.4, addatkspeed = 0, breakaddhp = 59.85, breakaddattack = 13.39, breakadddef = 3, breakaddmagicDef = 3, 
breakMultiple = {15, 35, 70, 120}
, hp = 598, attack = 133, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 92, evolutionType = 92, comborate1 = 0, comborate2 = 0, contractskillid = 60921, contractskillid2 = 60922, contractskillid3 = 509201, assistSkillid = 60922, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 50, slackoffproportion = 10, favourgift = 2, defaultBuff = "", uniqueequipid = 95092, uniqueequipidunlocktime = "2022-05-13 15:00:00"}
, 
[93] = {id = 93, name = "灾厄医生", nameTextID = 503056, titleTextID = 503057, shapeID = 1138, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10093, addhp = 45, addattack = 9.45, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9.45, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 94, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 3, breakType = 93, evolutionType = 93, comborate1 = 0, comborate2 = 0, contractskillid = 60931, contractskillid2 = 60932, contractskillid3 = 509301, assistSkillid = 60931, 
yardskillid = {2003}
, roleLine = "和你的相遇一定是命运的指引……", roleLineTextID = 502029, victoryTalk = "我已经下定决心……也要努力看看。", victoryTalkTextID = 502101, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 95093, uniqueequipidunlocktime = "2023-04-20 04:00:00"}
, 
[94] = {id = 94, name = "女神达娜", nameTextID = 502926, titleTextID = 502927, shapeID = 1116, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10094, addhp = 47.25, addattack = 14.18, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 47.25, breakaddattack = 14.18, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 472, attack = 141, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 94, evolutionType = 94, comborate1 = 0, comborate2 = 0, contractskillid = 60941, contractskillid2 = 60942, contractskillid3 = 509401, assistSkillid = 60942, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95094, uniqueequipidunlocktime = "2022-06-30 4:00:00"}
, 
[95] = {id = 95, name = "芙洛莱", nameTextID = 502843, titleTextID = 502842, shapeID = 1102, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10095, addhp = 42.75, addattack = 13.5, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 42.75, breakaddattack = 13.5, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 427, attack = 135, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 95, evolutionType = 95, comborate1 = 0, comborate2 = 0, contractskillid = 60951, contractskillid2 = 60952, contractskillid3 = 509501, assistSkillid = 60951, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 4, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[97] = {id = 97, name = "菲莱诺希丝", nameTextID = 502945, titleTextID = 502946, shapeID = 1118, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10097, addhp = 45, addattack = 9.45, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9.45, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 94, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 97, evolutionType = 97, comborate1 = 0, comborate2 = 0, contractskillid = 60971, contractskillid2 = 60972, contractskillid3 = 509701, assistSkillid = 60972, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95097, uniqueequipidunlocktime = "2022-07-28 4:00:00"}
, 
[98] = {id = 98, name = "玛嘉·茜姬", nameTextID = 502999, titleTextID = 503000, shapeID = 1127, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10098, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 98, evolutionType = 98, comborate1 = 0, comborate2 = 0, contractskillid = 60981, contractskillid2 = 60982, contractskillid3 = 509801, assistSkillid = 60982, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95098, uniqueequipidunlocktime = "2022-11-03 4:00:00"}
, 
[99] = {id = 99, name = "艾迪恩", nameTextID = 502889, titleTextID = 502888, shapeID = 1108, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10099, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 1, breakType = 99, evolutionType = 99, comborate1 = 0, comborate2 = 4, contractskillid = 60991, contractskillid2 = 60992, contractskillid3 = 509901, assistSkillid = 60992, 
yardskillid = {2003}
, roleLine = "外面的世界是怎样的呢？妾身，非常感兴趣。", roleLineTextID = 502013, victoryTalk = "日升之处，魑魅魍魉自当退散。", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95099, uniqueequipidunlocktime = "2022-04-07 14:00:00"}
, 
[100] = {id = 100, name = "阿墨莱", nameTextID = 502874, titleTextID = 502875, shapeID = 1103, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10100, addhp = 40.5, addattack = 9.45, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 40.5, breakaddattack = 9.45, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 405, attack = 94, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 3, breakType = 100, evolutionType = 100, comborate1 = 0, comborate2 = 4, contractskillid = 61001, contractskillid2 = 61002, contractskillid3 = 510001, assistSkillid = 61001, 
yardskillid = {2003}
, roleLine = "和你的相遇一定是命运的指引……", roleLineTextID = 502029, victoryTalk = "我已经下定决心……也要努力看看。", victoryTalkTextID = 502101, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 95100, uniqueequipidunlocktime = "2023-03-02 15:00:00"}
, 
[101] = {id = 101, name = "贝拉薇塔", nameTextID = 502940, titleTextID = 502941, shapeID = 1117, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10101, addhp = 45, addattack = 13.5, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 13.5, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 135, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 1, breakType = 101, evolutionType = 101, comborate1 = 0, comborate2 = 4, contractskillid = 61011, contractskillid2 = 61012, contractskillid3 = 510101, assistSkillid = 61012, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95101, uniqueequipidunlocktime = "2022-07-08 4:00:00"}
, 
[102] = {id = 102, name = "脱解公主", nameTextID = 502919, titleTextID = 502918, shapeID = 1112, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10102, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 1, breakType = 102, evolutionType = 102, comborate1 = 0, comborate2 = 4, contractskillid = 61021, contractskillid2 = 61022, contractskillid3 = 510201, assistSkillid = 61022, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95102, uniqueequipidunlocktime = "2022-06-16 15:30:00"}
, 
[103] = {id = 103, name = "凝莎", nameTextID = 502916, titleTextID = 502915, shapeID = 1111, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10103, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 2, breakType = 103, evolutionType = 103, comborate1 = 0, comborate2 = 0, contractskillid = 61031, contractskillid2 = 61032, contractskillid3 = 510301, assistSkillid = 61032, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95103, uniqueequipidunlocktime = "2022-05-26 15:00:00"}
, 
[104] = {id = 104, name = "优·波莉本", nameTextID = 502969, titleTextID = 502970, shapeID = 1121, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10104, addhp = 47.25, addattack = 14.18, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 47.25, breakaddattack = 14.18, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 472, attack = 141, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 104, evolutionType = 104, comborate1 = 0, comborate2 = 0, contractskillid = 61041, contractskillid2 = 61042, contractskillid3 = 510401, assistSkillid = 61042, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 4, defaultBuff = "", uniqueequipid = 95104, uniqueequipidunlocktime = "2022-09-01 4:00:00"}
, 
[105] = {id = 105, name = "柯莱尔", nameTextID = 503019, titleTextID = 503020, shapeID = 1130, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10105, addhp = 47.25, addattack = 14.18, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 47.25, breakaddattack = 14.18, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 472, attack = 141, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 105, evolutionType = 105, comborate1 = 0, comborate2 = 0, contractskillid = 61051, contractskillid2 = 61052, contractskillid3 = 510501, assistSkillid = 61052, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 4, defaultBuff = "", uniqueequipid = 95105, uniqueequipidunlocktime = "2022-12-22 4:00:00"}
, 
[106] = {id = 106, name = "莎诺", nameTextID = 502876, titleTextID = 502877, shapeID = 1104, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10106, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 106, evolutionType = 106, comborate1 = 0, comborate2 = 0, contractskillid = 61061, contractskillid2 = 61062, contractskillid3 = 510601, assistSkillid = 61061, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502017, victoryTalk = "???", victoryTalkTextID = 502089, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 5, defaultBuff = "", uniqueequipid = 95106, uniqueequipidunlocktime = "2022-09-08 04:00:00"}
, 
[107] = {id = 107, name = "奈解", nameTextID = 503003, titleTextID = 503004, shapeID = 1128, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10107, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 107, evolutionType = 107, comborate1 = 0, comborate2 = 0, contractskillid = 61071, contractskillid2 = 61072, contractskillid3 = 510701, assistSkillid = 61072, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 4, defaultBuff = "", uniqueequipid = 95107, uniqueequipidunlocktime = "2022-12-22 4:00:00"}
, 
[108] = {id = 108, name = "夜之托奈兰", nameTextID = 502855, titleTextID = 502854, shapeID = 1106, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 100108, addhp = 90, addattack = 6, adddef = 4.06, addmagicDef = 4.06, addspeed = 2.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 660, speed = "30", atkspeed = 100, vocation = 1, element = 1, breakType = 108, evolutionType = 108, comborate1 = 0, comborate2 = 0, contractskillid = 601081, contractskillid2 = 601082, contractskillid3 = 510801, assistSkillid = 601081, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 95108, uniqueequipidunlocktime = "2022-09-08 04:00:00"}
, 
[109] = {id = 109, name = "散华", nameTextID = 502990, titleTextID = 502991, shapeID = 1125, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10109, addhp = 90, addattack = 6, adddef = 4.06, addmagicDef = 4.06, addspeed = 2.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 660, speed = "30", atkspeed = 100, vocation = 1, element = 2, breakType = 109, evolutionType = 109, comborate1 = 0, comborate2 = 0, contractskillid = 61091, contractskillid2 = 61092, contractskillid3 = 510901, assistSkillid = 61092, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 4, defaultBuff = "", uniqueequipid = 95109, uniqueequipidunlocktime = "2022-11-03 4:00:00"}
, 
[110] = {id = 110, name = "卡普拉", nameTextID = 502857, titleTextID = 502856, shapeID = 1107, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 100110, addhp = 66.15, addattack = 12.11, adddef = 3.15, addmagicDef = 3.15, addspeed = 2.4, addatkspeed = 0, breakaddhp = 66.15, breakaddattack = 12.11, breakadddef = 3.15, breakaddmagicDef = 3.15, 
breakMultiple = {15, 35, 70, 120}
, hp = 661, attack = 121, def = 31, magicDef = 31, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 110, evolutionType = 110, comborate1 = 0, comborate2 = 0, contractskillid = 601101, contractskillid2 = 601102, contractskillid3 = 511001, assistSkillid = 601102, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 2, defaultBuff = "", uniqueequipid = 0, uniqueequipidunlocktime = ""}
, 
[111] = {id = 111, name = "安格泠", nameTextID = 502979, titleTextID = 502980, shapeID = 1123, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10111, addhp = 63, addattack = 12.75, adddef = 3, addmagicDef = 3, addspeed = 2.4, addatkspeed = 0, breakaddhp = 63, breakaddattack = 12.75, breakadddef = 3, breakaddmagicDef = 3, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 127, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 111, evolutionType = 111, comborate1 = 0, comborate2 = 0, contractskillid = 61111, contractskillid2 = 61112, contractskillid3 = 511101, assistSkillid = 61112, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95111, uniqueequipidunlocktime = "2022-09-27 4:00:00"}
, 
[112] = {id = 112, name = "葛淑丝", nameTextID = 502956, titleTextID = 502957, shapeID = 1120, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10112, addhp = 90, addattack = 6, adddef = 4.06, addmagicDef = 4.06, addspeed = 2.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 660, speed = "30", atkspeed = 100, vocation = 1, element = 3, breakType = 112, evolutionType = 112, comborate1 = 0, comborate2 = 0, contractskillid = 61121, contractskillid2 = 61122, contractskillid3 = 511201, assistSkillid = 61122, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 2, defaultBuff = "", uniqueequipid = 95112, uniqueequipidunlocktime = "2022-08-18 4:00:00"}
, 
[113] = {id = 113, name = "皎", nameTextID = 502987, titleTextID = 502988, shapeID = 1124, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10113, addhp = 47.25, addattack = 14.18, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 47.25, breakaddattack = 14.18, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 472, attack = 141, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 113, evolutionType = 113, comborate1 = 0, comborate2 = 0, contractskillid = 61131, contractskillid2 = 61132, contractskillid3 = 511301, assistSkillid = 61132, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 2, defaultBuff = "", uniqueequipid = 95113, uniqueequipidunlocktime = "2022-09-08 4:00:00"}
, 
[115] = {id = 115, name = "永夜诺忒娜", nameTextID = 502993, titleTextID = 502994, shapeID = 1126, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10115, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 115, evolutionType = 115, comborate1 = 0, comborate2 = 0, contractskillid = 61151, contractskillid2 = 61152, contractskillid3 = 511501, assistSkillid = 61152, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95115, uniqueequipidunlocktime = "2022-10-27 4:00:00"}
, 
[116] = {id = 116, name = "渡魂者", nameTextID = 503052, titleTextID = 503053, shapeID = 1137, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "1;8", evolutionLimit = 3, attackID = 10116, addhp = 90, addattack = 6, adddef = 4.06, addmagicDef = 4.06, addspeed = 2.4, addatkspeed = 0, breakaddhp = 90, breakaddattack = 6, breakadddef = 6, breakaddmagicDef = 6, 
breakMultiple = {15, 35, 70, 120}
, hp = 900, attack = 60, def = 660, magicDef = 660, speed = "30", atkspeed = 100, vocation = 1, element = 1, breakType = 116, evolutionType = 116, comborate1 = 0, comborate2 = 0, contractskillid = 61161, contractskillid2 = 61162, contractskillid3 = 511601, assistSkillid = 61162, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 10, slackoffproportion = 20, favourgift = 5, defaultBuff = "", uniqueequipid = 95116, uniqueequipidunlocktime = "2023-03-30 4:00:00"}
, 
[117] = {id = 117, name = "珂莉俄丝", nameTextID = 503023, titleTextID = 503024, shapeID = 1131, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10117, addhp = 59.85, addattack = 12.75, adddef = 3, addmagicDef = 3, addspeed = 2.4, addatkspeed = 0, breakaddhp = 66.15, breakaddattack = 12.11, breakadddef = 3, breakaddmagicDef = 3, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 121, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 117, evolutionType = 117, comborate1 = 0, comborate2 = 0, contractskillid = 61171, contractskillid2 = 61172, contractskillid3 = 511701, assistSkillid = 61172, 
yardskillid = {1003}
, roleLine = "？？", roleLineTextID = 502013, victoryTalk = "？？", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95117, uniqueequipidunlocktime = "2023-01-01 4:00:00"}
, 
[118] = {id = 118, name = "时空守护者", nameTextID = 503061, titleTextID = 503062, shapeID = 1139, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10118, addhp = 47.25, addattack = 14.18, adddef = 2.52, addmagicDef = 2.52, addspeed = 2.4, addatkspeed = 0, breakaddhp = 47.25, breakaddattack = 14.18, breakadddef = 2.52, breakaddmagicDef = 2.52, 
breakMultiple = {15, 35, 70, 120}
, hp = 472, attack = 141, def = 25, magicDef = 25, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 118, evolutionType = 118, comborate1 = 0, comborate2 = 0, contractskillid = 61181, contractskillid2 = 61182, contractskillid3 = 511801, assistSkillid = 61181, 
yardskillid = {1003}
, roleLine = "???", roleLineTextID = 502692, victoryTalk = "???", victoryTalkTextID = 502696, hitornothit = 1, hitproportion = 20, slackoffproportion = 10, favourgift = 3, defaultBuff = "", uniqueequipid = 95118, uniqueequipidunlocktime = "2023-05-04 04:00:00"}
, 
[119] = {id = 119, name = "莉可妮丝", nameTextID = 503010, titleTextID = 503011, shapeID = 1129, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "6;8", evolutionLimit = 3, attackID = 10119, addhp = 47.25, addattack = 14.18, adddef = 2.16, addmagicDef = 2.16, addspeed = 2.4, addatkspeed = 0, breakaddhp = 47.25, breakaddattack = 14.18, breakadddef = 2.16, breakaddmagicDef = 2.16, 
breakMultiple = {15, 35, 70, 120}
, hp = 472, attack = 141, def = 21, magicDef = 21, speed = "30", atkspeed = 100, vocation = 6, element = 1, breakType = 119, evolutionType = 119, comborate1 = 0, comborate2 = 0, contractskillid = 61191, contractskillid2 = 61192, contractskillid3 = 511901, assistSkillid = 61192, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95119, uniqueequipidunlocktime = "2022-11-24 4:00:00"}
, 
[120] = {id = 120, name = "达奈莉姆", nameTextID = 502976, titleTextID = 502977, shapeID = 1122, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10120, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 2, breakType = 120, evolutionType = 120, comborate1 = 0, comborate2 = 4, contractskillid = 61201, contractskillid2 = 61202, contractskillid3 = 512001, assistSkillid = 61202, 
yardskillid = {3003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 5, defaultBuff = "", uniqueequipid = 95120, uniqueequipidunlocktime = "2022-09-08 4:00:00"}
, 
[121] = {id = 121, name = "夕音", nameTextID = 503032, titleTextID = 503033, shapeID = 1133, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10121, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 121, evolutionType = 121, comborate1 = 0, comborate2 = 0, contractskillid = 61211, contractskillid2 = 61212, contractskillid3 = 512101, assistSkillid = 61212, 
yardskillid = {2003}
, roleLine = "？？", roleLineTextID = 502015, victoryTalk = "？？", victoryTalkTextID = 502087, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95121, uniqueequipidunlocktime = "2023-01-12 4:00:00"}
, 
[122] = {id = 122, name = "灏", nameTextID = 503029, titleTextID = 503030, shapeID = 1132, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10122, addhp = 61.74, addattack = 13.01, adddef = 3.06, addmagicDef = 2.94, addspeed = 2.4, addatkspeed = 0, breakaddhp = 66.15, breakaddattack = 13.01, breakadddef = 3.06, breakaddmagicDef = 2.94, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 130, def = 30, magicDef = 29, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 122, evolutionType = 122, comborate1 = 0, comborate2 = 0, contractskillid = 61221, contractskillid2 = 61222, contractskillid3 = 512201, assistSkillid = 61222, 
yardskillid = {1003}
, roleLine = "？？", roleLineTextID = 502014, victoryTalk = "？？", victoryTalkTextID = 502086, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 2, defaultBuff = "", uniqueequipid = 95122, uniqueequipidunlocktime = "2023-01-12 4:00:00"}
, 
[123] = {id = 123, name = "甜味速递", nameTextID = 503035, titleTextID = 503036, shapeID = 1134, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "4;8", evolutionLimit = 3, attackID = 10123, addhp = 45, addattack = 9, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 9, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 90, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 4, element = 3, breakType = 123, evolutionType = 123, comborate1 = 0, comborate2 = 0, contractskillid = 61231, contractskillid2 = 61232, contractskillid3 = 512301, assistSkillid = 61232, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95123, uniqueequipidunlocktime = "2023-02-16 4:00:00"}
, 
[124] = {id = 124, name = "翡翠之心", nameTextID = 503045, titleTextID = 503046, shapeID = 1136, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "3;8", evolutionLimit = 3, attackID = 10124, addhp = 36, addattack = 15, adddef = 1.8, addmagicDef = 1.8, addspeed = 2.4, addatkspeed = 0, breakaddhp = 36, breakaddattack = 15, breakadddef = 1.8, breakaddmagicDef = 1.8, 
breakMultiple = {15, 35, 70, 120}
, hp = 360, attack = 150, def = 18, magicDef = 18, speed = "30", atkspeed = 100, vocation = 3, element = 3, breakType = 124, evolutionType = 124, comborate1 = 0, comborate2 = 0, contractskillid = 61241, contractskillid2 = 61242, contractskillid3 = 512401, assistSkillid = 61242, 
yardskillid = {1003}
, roleLine = "？？", roleLineTextID = 502014, victoryTalk = "？？", victoryTalkTextID = 502086, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 5, defaultBuff = "", uniqueequipid = 95124, uniqueequipidunlocktime = "2023-03-09 4:00:00"}
, 
[126] = {id = 126, name = "精灵凝莎", nameTextID = 503065, titleTextID = 503066, shapeID = 1140, rarity = 4, damagetype = 2, silentFraps = 0, roleEquipType = "5;8", evolutionLimit = 3, attackID = 10126, addhp = 45, addattack = 13.5, adddef = 2.4, addmagicDef = 2.4, addspeed = 2.4, addatkspeed = 0, breakaddhp = 45, breakaddattack = 13.5, breakadddef = 2.4, breakaddmagicDef = 2.4, 
breakMultiple = {15, 35, 70, 120}
, hp = 450, attack = 135, def = 24, magicDef = 24, speed = "30", atkspeed = 100, vocation = 5, element = 1, breakType = 126, evolutionType = 126, comborate1 = 0, comborate2 = 0, contractskillid = 61261, contractskillid2 = 61262, contractskillid3 = 512601, assistSkillid = 61262, 
yardskillid = {2003}
, roleLine = "???", roleLineTextID = 502013, victoryTalk = "???", victoryTalkTextID = 502085, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 3, defaultBuff = "", uniqueequipid = 95126, uniqueequipidunlocktime = "2023-05-11 4:00:00"}
, 
[130] = {id = 130, name = "诺尔伊迪", nameTextID = 503073, titleTextID = 503074, shapeID = 1142, rarity = 4, damagetype = 1, silentFraps = 0, roleEquipType = "2;8", evolutionLimit = 3, attackID = 10130, addhp = 63, addattack = 12.75, adddef = 3, addmagicDef = 3, addspeed = 2.4, addatkspeed = 0, breakaddhp = 63, breakaddattack = 12.75, breakadddef = 3, breakaddmagicDef = 3, 
breakMultiple = {15, 35, 70, 120}
, hp = 630, attack = 127, def = 30, magicDef = 30, speed = "30", atkspeed = 100, vocation = 2, element = 2, breakType = 130, evolutionType = 130, comborate1 = 0, comborate2 = 0, contractskillid = 61301, contractskillid2 = 61302, contractskillid3 = 513001, assistSkillid = 61302, 
yardskillid = {2003}
, roleLine = "？？", roleLineTextID = 502014, victoryTalk = "？？", victoryTalkTextID = 502086, hitornothit = 1, hitproportion = 10, slackoffproportion = 30, favourgift = 5, defaultBuff = "", uniqueequipid = 95130, uniqueequipidunlocktime = "2023-05-11 4:00:00"}
}
roleconfig.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 88, 89, 90, 91, 92, 93, 94, 95, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 126, 130}
return roleconfig

