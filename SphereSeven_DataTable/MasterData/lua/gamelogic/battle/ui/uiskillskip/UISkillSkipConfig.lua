
local UISkillSkip = {
    Name = UIWindowNames.UISkillSkip,
    Layer = UILayers.NormalLayer,
    Model = require "GameLogic.Battle.UI.UISkillSkip.UISkillSkipModel",
    Ctrl = require "GameLogic.Battle.UI.UISkillSkip.UISkillSkipCtrl",
    View = require "GameLogic.Battle.UI.UISkillSkip.UISkillSkipView",
    PrefabPath = "UI/Prefabs/View/UISkillSkip.prefab",
}

return {UISkillSkip = UISkillSkip};