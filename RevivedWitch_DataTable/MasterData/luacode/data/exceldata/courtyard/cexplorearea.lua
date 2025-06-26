-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/courtyard/cexplorearea.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cexplorearea = {}
cexplorearea.Data = {
[1] = {id = 1, name = "古堡", nameTextID = 800006, rarity = 1, unlockCondition = 1, destribe = "森林深处的古老城堡，已经很久没有人居住了。", destribeTextID = 800019, imageID = 11502, time = 360, getRate = 120, costEmotion = 5000, mainItem = 74003, mainItemNum = 1, mainItemVolume = 999, 
secondaryItem = {35002}
, 
secondaryItemNum = {1000}
, 
secondaryItemVolume = {0}
}
, 
[2] = {id = 2, name = "地下藏书室", nameTextID = 800007, rarity = 1, unlockCondition = 1, destribe = "鲜有人踏入的藏书室，书架上落满了灰尘。", destribeTextID = 800020, imageID = 11502, time = 360, getRate = 120, costEmotion = 5000, mainItem = 35002, mainItemNum = 3000, mainItemVolume = 999, 
secondaryItem = {76000}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[3] = {id = 3, name = "幽冥洞穴", nameTextID = 800008, rarity = 2, unlockCondition = 2, destribe = "终年不见阳光的洞穴，不断地传出窸窸窣窣的声音。", destribeTextID = 800021, imageID = 11503, time = 480, getRate = 120, costEmotion = 6000, mainItem = 76000, mainItemNum = 2, mainItemVolume = 999, 
secondaryItem = {35002}
, 
secondaryItemNum = {1000}
, 
secondaryItemVolume = {0}
}
, 
[4] = {id = 4, name = "蓝色花园", nameTextID = 800009, rarity = 2, unlockCondition = 2, destribe = "天然形成的蓝色花海，仿佛是女神的后花园。", destribeTextID = 800022, imageID = 11503, time = 480, getRate = 120, costEmotion = 6000, mainItem = 74000, mainItemNum = 1, mainItemVolume = 999, 
secondaryItem = {74003}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[5] = {id = 5, name = "沼泽地", nameTextID = 800010, rarity = 2, unlockCondition = 2, destribe = "不断扩张的沼泽地，周围盘踞着怪物。", destribeTextID = 800023, imageID = 11503, time = 480, getRate = 120, costEmotion = 6000, mainItem = 35002, mainItemNum = 7000, mainItemVolume = 999, 
secondaryItem = {76000}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[6] = {id = 6, name = "魔物松林", nameTextID = 800011, rarity = 2, unlockCondition = 2, destribe = "一片一望无际的松林，可以嗅到魔物的气息。", destribeTextID = 800024, imageID = 11503, time = 480, getRate = 120, costEmotion = 6000, mainItem = 31124, mainItemNum = 1, mainItemVolume = 999, 
secondaryItem = {35002}
, 
secondaryItemNum = {1000}
, 
secondaryItemVolume = {0}
}
, 
[7] = {id = 7, name = "猎场", nameTextID = 800012, rarity = 2, unlockCondition = 3, destribe = "走兽珍禽的栖息地，是理想的狩猎之地。", destribeTextID = 800025, imageID = 11504, time = 600, getRate = 120, costEmotion = 8000, mainItem = 74001, mainItemNum = 1, mainItemVolume = 999, 
secondaryItem = {74003}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[8] = {id = 8, name = "狼之湾", nameTextID = 800013, rarity = 2, unlockCondition = 3, destribe = "仿佛受到了指引，无数的狼群聚集在这里生活。", destribeTextID = 800026, imageID = 11504, time = 600, getRate = 120, costEmotion = 8000, mainItem = 35002, mainItemNum = 15000, mainItemVolume = 999, 
secondaryItem = {76000}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[9] = {id = 9, name = "冰窟", nameTextID = 800014, rarity = 2, unlockCondition = 3, destribe = "异常寒冷的冰窟，千百年也未曾融化。", destribeTextID = 800027, imageID = 11504, time = 600, getRate = 120, costEmotion = 8000, mainItem = 35008, mainItemNum = 20, mainItemVolume = 999, 
secondaryItem = {76000}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[10] = {id = 10, name = "古代战场", nameTextID = 800018, rarity = 2, unlockCondition = 3, destribe = "荒凉的古代战场，硝烟早已散去。", destribeTextID = 800031, imageID = 11504, time = 600, getRate = 120, costEmotion = 8000, mainItem = 31125, mainItemNum = 1, mainItemVolume = 999, 
secondaryItem = {35002}
, 
secondaryItemNum = {1000}
, 
secondaryItemVolume = {0}
}
, 
[11] = {id = 11, name = "极寒矿场", nameTextID = 800016, rarity = 2, unlockCondition = 3, destribe = "人迹罕至的大矿场，早已没有了生物的气息。", destribeTextID = 800029, imageID = 11504, time = 600, getRate = 120, costEmotion = 8000, mainItem = 76001, mainItemNum = 2, mainItemVolume = 999, 
secondaryItem = {35002}
, 
secondaryItemNum = {1000}
, 
secondaryItemVolume = {0}
}
, 
[12] = {id = 12, name = "储物间", nameTextID = 800015, rarity = 3, unlockCondition = 4, destribe = "旧贵族们的储物间，陈列着各式各样的物品。", destribeTextID = 800028, imageID = 11502, time = 720, getRate = 120, costEmotion = 10000, mainItem = 35008, mainItemNum = 30, mainItemVolume = 999, 
secondaryItem = {76000}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[13] = {id = 13, name = "兵器室", nameTextID = 800017, rarity = 3, unlockCondition = 4, destribe = "远征军的兵器室，虽然已经认不清破旧的旗帜。", destribeTextID = 800030, imageID = 11502, time = 720, getRate = 120, costEmotion = 10000, mainItem = 76002, mainItemNum = 2, mainItemVolume = 999, 
secondaryItem = {35002}
, 
secondaryItemNum = {1000}
, 
secondaryItemVolume = {0}
}
, 
[14] = {id = 14, name = "杂物间", nameTextID = 800328, rarity = 2, unlockCondition = 3, destribe = "人迹罕至的杂物间，应该可以找到很多有用的物品。", destribeTextID = 800330, imageID = 11502, time = 600, getRate = 120, costEmotion = 8000, mainItem = 35002, mainItemNum = 15000, mainItemVolume = 999, 
secondaryItem = {31127}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
, 
[15] = {id = 15, name = "紫色花园", nameTextID = 800329, rarity = 3, unlockCondition = 4, destribe = "充满着紫色鲜花的花园，花丛中似乎还有着亮晶晶的东西。", destribeTextID = 800331, imageID = 11503, time = 720, getRate = 120, costEmotion = 10000, mainItem = 35008, mainItemNum = 30, mainItemVolume = 999, 
secondaryItem = {31128}
, 
secondaryItemNum = {1}
, 
secondaryItemVolume = {0}
}
}
cexplorearea.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
return cexplorearea

