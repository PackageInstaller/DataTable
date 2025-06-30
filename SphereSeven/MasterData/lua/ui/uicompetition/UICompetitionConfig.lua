---
---

local UICompetition = {
    Name = UIWindowNames.UICompetition,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UICompetition.UICompetitionModel",
    Ctrl = require "UI.UICompetition.UICompetitionCtrl",
    View = require "UI.UICompetition.UICompetitionView",
    PrefabPath = "UI/Prefabs/View/UI/UICompetition.prefab",
}

return {
    -- 配置
    UICompetition = UICompetition,
}