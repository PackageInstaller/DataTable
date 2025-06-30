-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/csidestorystage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local csidestorystage = {}
csidestorystage.Data = {
[5000] = {id = 5000, stagefloor = "100-0", stagesort = 0, stagename = "占坑位，用于每个区间结算", stagenametxtid = 0, stagefinishnamenumid = 0, stagefinishnametxtid = 0, sideid = 0, suggestlvl = 0, stageintro = "0", stageintrotxt = 0, spirit = 0, isBoss = 0, 
firstItems = {0}
, 
firstItemNums = {0}
, sceneid = 30001}
, 
[5001] = {id = 5001, stagefloor = "101-1", stagesort = 1, stagename = "幕一:“邀请”", stagenametxtid = 1900417, stagefinishnamenumid = 1900680, stagefinishnametxtid = 1900651, sideid = 101, suggestlvl = 75, stageintro = "德亚丝在时之塔郊外与魔物战斗借以调查入塔的线索，遇到了正在召集人手并想要进入塔内的布露恩…", stageintrotxt = 1900423, spirit = 15, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60001}
, 
[5002] = {id = 5002, stagefloor = "101-2", stagesort = 2, stagename = "幕二:“力量”", stagenametxtid = 1900418, stagefinishnamenumid = 1900681, stagefinishnametxtid = 1900652, sideid = 101, suggestlvl = 75, stageintro = "回程的路上，德亚丝被奇怪的小女孩缠上，不知该如何处置的德亚丝决定姑且带上小女孩一起去找布露恩…", stageintrotxt = 1900424, spirit = 15, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60002}
, 
[5003] = {id = 5003, stagefloor = "101-3", stagesort = 3, stagename = "幕三:“志同道合”", stagenametxtid = 1900419, stagefinishnamenumid = 1900682, stagefinishnametxtid = 1900653, sideid = 101, suggestlvl = 75, stageintro = "布露恩认为德亚丝回来即表示同意加入队伍。一番考量后，德亚丝最决定加入队伍。就在她们讨论进入时之塔的方法时，突然有人现身，来者自称是圣教会的牧师费拉古德…", stageintrotxt = 1900425, spirit = 15, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60003}
, 
[5004] = {id = 5004, stagefloor = "101-4", stagesort = 4, stagename = "幕四:“秘密”", stagenametxtid = 1900420, stagefinishnamenumid = 1900683, stagefinishnametxtid = 1900654, sideid = 101, suggestlvl = 75, stageintro = "费拉古德找来并称发现了魔物更密集的新地点，希望有人能一起前去查看并点名艾拉。德亚丝心生疑虑并要求一同前往…", stageintrotxt = 1900426, spirit = 15, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60004}
, 
[5005] = {id = 5005, stagefloor = "101-5", stagesort = 5, stagename = "幕五:“不期而遇”", stagenametxtid = 1900421, stagefinishnamenumid = 1900684, stagefinishnametxtid = 1900655, sideid = 101, suggestlvl = 75, stageintro = "即将进入时之塔时，费拉古德却极力劝阻布露恩一行进入，其间表示他对于三人没有按其计划的那样被魔物解决掉而十分苦恼。争执之下，费拉古德唤出…", stageintrotxt = 1900478, spirit = 15, isBoss = 1, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60005}
, 
[5006] = {id = 5006, stagefloor = "101-6", stagesort = 6, stagename = "幕六:“礼物”", stagenametxtid = 1900422, stagefinishnamenumid = 1900685, stagefinishnametxtid = 1900656, sideid = 101, suggestlvl = 1, stageintro = "德亚丝醒来后圣教会一行早已不在，虽然感觉有些许异样但感觉只是小睡了一会，于是起身跟随布露恩走进了时之塔…", stageintrotxt = 1900479, spirit = 15, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60006}
, 
[5007] = {id = 5007, stagefloor = "201-1", stagesort = 1, stagename = "幕一:“失意”", stagenametxtid = 1900468, stagefinishnamenumid = 1900680, stagefinishnametxtid = 1900657, sideid = 201, suggestlvl = 50, stageintro = "露尼亚公国陷入内战后，各地开始出现猎取活人灵魂的魔物。莫尔提茉是露尼亚公国最大的花园的管理者。一天，魔物入侵了莫尔提茉守护的花园...", stageintrotxt = 1900427, spirit = 10, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60007}
, 
[5008] = {id = 5008, stagefloor = "201-2", stagesort = 2, stagename = "幕二:“巧遇”", stagenametxtid = 1900469, stagefinishnamenumid = 1900681, stagefinishnametxtid = 1900658, sideid = 201, suggestlvl = 50, stageintro = "逃离过程中，莫尔提茉遇见了诺忒娜，误认为她就是操纵魔物的幕后黑手。莫尔提茉强撑着受伤的身体，试图和诺忒娜战斗，但是最终体力不支倒下…", stageintrotxt = 1900428, spirit = 10, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60008}
, 
[5009] = {id = 5009, stagefloor = "201-3", stagesort = 3, stagename = "幕三:“公主”", stagenametxtid = 1900470, stagefinishnamenumid = 1900682, stagefinishnametxtid = 1900659, sideid = 201, suggestlvl = 50, stageintro = "莫尔提茉和诺忒娜解除误会后，发现花园附近已经完全被魔物占领了，莫尔提茉决定去城堡，把这个消息告知大公，然而…", stageintrotxt = 1900429, spirit = 10, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60009}
, 
[5010] = {id = 5010, stagefloor = "201-4", stagesort = 4, stagename = "幕四:“出发”", stagenametxtid = 1900471, stagefinishnamenumid = 1900683, stagefinishnametxtid = 1900660, sideid = 201, suggestlvl = 50, stageintro = "莫尔提茉和诺忒娜在城堡附近解救了正在被袭击的公主。救下公主后，从公主护卫的口中得知了幕后黑手的方位。于是他们出发去寻找幕后黑手…", stageintrotxt = 1900430, spirit = 10, isBoss = 0, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60010}
, 
[5011] = {id = 5011, stagefloor = "201-5", stagesort = 5, stagename = "幕五:“追随”", stagenametxtid = 1900472, stagefinishnamenumid = 1900684, stagefinishnametxtid = 1900661, sideid = 201, suggestlvl = 55, stageintro = "众人最终发现了幕后黑手，并与她展开了激烈的战斗…", stageintrotxt = 1900467, spirit = 15, isBoss = 1, 
firstItems = {35008}
, 
firstItemNums = {50}
, sceneid = 60011}
}
csidestorystage.AllIds = {5000, 5001, 5002, 5003, 5004, 5005, 5006, 5007, 5008, 5009, 5010, 5011}
return csidestorystage

