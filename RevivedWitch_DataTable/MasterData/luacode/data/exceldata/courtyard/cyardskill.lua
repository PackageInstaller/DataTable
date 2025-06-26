-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/courtyard/cyardskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cyardskill = {}
cyardskill.Data = {
[1001] = {id = 1001, name = "新手", nameTextID = 800032, functionID = 200, image = 10966, desc = "探索<color=#8CECFAff>异界之镜</color>时副产物掉落概率提升<color=#FFCA65ff>6%</color>。", descTextID = 800038, exploreSecondary = 6, alchemyType = "", alchemyProbability = 0, dormEmotion = 0}
, 
[1002] = {id = 1002, name = "探险队", nameTextID = 800033, functionID = 200, image = 10966, desc = "探索<color=#8CECFAff>异界之镜</color>时副产物掉落概率提升<color=#FFCA65ff>8%</color>。", descTextID = 800039, exploreSecondary = 8, alchemyType = "", alchemyProbability = 0, dormEmotion = 0}
, 
[1003] = {id = 1003, name = "冒险大师", nameTextID = 800070, functionID = 200, image = 10966, desc = "探索<color=#8CECFAff>异界之镜</color>时副产物掉落概率提升<color=#FFCA65ff>10%</color>。", descTextID = 800073, exploreSecondary = 10, alchemyType = "", alchemyProbability = 0, dormEmotion = 0}
, 
[2001] = {id = 2001, name = "合成术", nameTextID = 800034, functionID = 400, image = 10965, desc = "对<color=#FBFAA5ff>结晶</color>进行炼金时，副产物产出概率提升<color=#FFCA65ff>6%</color>。", descTextID = 800040, exploreSecondary = 0, alchemyType = "2", alchemyProbability = 6, dormEmotion = 0}
, 
[2002] = {id = 2002, name = "炼金术", nameTextID = 800035, functionID = 400, image = 10965, desc = "对<color=#FBFAA5ff>结晶</color>进行炼金时，副产物产出概率提升<color=#FFCA65ff>8%</color>。", descTextID = 800041, exploreSecondary = 0, alchemyType = "2", alchemyProbability = 8, dormEmotion = 0}
, 
[2003] = {id = 2003, name = "点石成金", nameTextID = 800071, functionID = 400, image = 10965, desc = "对<color=#FBFAA5ff>结晶</color>进行炼金时，副产物产出概率提升<color=#FFCA65ff>10%</color>。", descTextID = 800074, exploreSecondary = 0, alchemyType = "2", alchemyProbability = 10, dormEmotion = 0}
, 
[3001] = {id = 3001, name = "家务新手", nameTextID = 800036, functionID = 500, image = 11505, desc = "入驻<color=#B4F59Bff>小屋</color>时，该层所有人偶精力恢复速度提升<color=#FFCA65ff>6%</color>。", descTextID = 800042, exploreSecondary = 0, alchemyType = "", alchemyProbability = 0, dormEmotion = 6}
, 
[3002] = {id = 3002, name = "家务达人", nameTextID = 800037, functionID = 500, image = 11505, desc = "入驻<color=#B4F59Bff>小屋</color>时，该层所有人偶精力恢复速度提升<color=#FFCA65ff>8%</color>。", descTextID = 800043, exploreSecondary = 0, alchemyType = "", alchemyProbability = 0, dormEmotion = 8}
, 
[3003] = {id = 3003, name = "全能管家", nameTextID = 800072, functionID = 500, image = 11505, desc = "入驻<color=#B4F59Bff>小屋</color>时，该层所有人偶精力恢复速度提升<color=#FFCA65ff>10%</color>。", descTextID = 800075, exploreSecondary = 0, alchemyType = "", alchemyProbability = 0, dormEmotion = 10}
}
cyardskill.AllIds = {1001, 1002, 1003, 2001, 2002, 2003, 3001, 3002, 3003}
return cyardskill

