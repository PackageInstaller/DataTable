---
---

local UIChallenge = {
    Name = UIWindowNames.UIChallenge,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIChallenge.UIChallengeModel",
    Ctrl = require "UI.UIChallenge.UIChallengeCtrl",
    View = require "UI.UIChallenge.UIChallengeView",
    PrefabPath = "UI/Prefabs/View/UI/UIChallenge.prefab",
}

local UIChallenge1 = {
    Name = UIWindowNames.UIChallenge1,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIChallenge.UIChallenge1.UIChallenge1Model",
    Ctrl = nil,
    View = require "UI.UIChallenge.UIChallenge1.UIChallenge1View",
    PrefabPath = "UI/Prefabs/View/UI/UIChallenge_1.prefab",
}

local UIChallenge2 = {
    Name = UIWindowNames.UIChallenge2,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIChallenge.UIChallenge2.UIChallenge2Model",
    Ctrl = nil,
    View = require "UI.UIChallenge.UIChallenge2.UIChallenge2View",
    PrefabPath = "UI/Prefabs/View/UI/UIChallenge_2.prefab",
}

local UIChallenge3 = {
    Name = UIWindowNames.UIChallenge3,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIChallenge.UIChallenge3.UIChallenge3Model",
    Ctrl = nil,
    View = require "UI.UIChallenge.UIChallenge3.UIChallenge3View",
    PrefabPath = "UI/Prefabs/View/UI/UIChallenge_3.prefab",
}

local UIChallenge4 = {
    Name = UIWindowNames.UIChallenge4,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIChallenge.UIChallenge4.UIChallenge4Model",
    Ctrl = nil,
    View = require "UI.UIChallenge.UIChallenge4.UIChallenge4View",
    PrefabPath = "UI/Prefabs/View/UI/UIChallenge_4.prefab",
}

local UIChallengeSectionInfo = {
    Name = UIWindowNames.UIChallengeSectionInfo,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIChallenge.UIChallengeSectionInfo.UIChallengeSectionInfoModel",
    Ctrl = nil,
    View = require "UI.UIChallenge.UIChallengeSectionInfo.UIChallengeSectionInfoView",
    PrefabPath = "UI/Prefabs/View/UI/UIChallengeSectionInfo.prefab",
}

return {UIChallenge = UIChallenge,
        UIChallenge1 = UIChallenge1,
        UIChallenge2 = UIChallenge2,
        UIChallenge3 = UIChallenge3,
        UIChallenge4 = UIChallenge4,
        UIChallengeSectionInfo = UIChallengeSectionInfo};