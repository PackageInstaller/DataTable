local UIBattlePass = {
    Name = UIWindowNames.UIBattlePass,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIBattlePass.Model.UIBattlePassModel",
    Ctrl = require "UI.UIBattlePass.Ctrl.UIBattlePassCtrl",
    View = require "UI.UIBattlePass.View.UIBattlePassView",
    PrefabPath = "UI/Prefabs/View/UI/Pass/UIBattlePass.prefab",
}

local UIBattlePassBuyLevel = {
    Name = UIWindowNames.UIBattlePassBuyLevel,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIBattlePass.Model.UIBattlePassBuyLevelModel",
    Ctrl = require "UI.UIBattlePass.Ctrl.UIBattlePassBuyLevelCtrl",
    View = require "UI.UIBattlePass.View.UIBattlePassBuyLevelView",
    PrefabPath = "UI/Prefabs/View/UI/Pass/UIBattlePassBuyLevel.prefab",
}

local UIBattlePassLevelUp = {
    Name = UIWindowNames.UIBattlePassLevelUp,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIBattlePass.Model.UIBattlePassLevelUpModel",
    Ctrl = require "UI.UIBattlePass.Ctrl.UIBattlePassLevelUpCtrl",
    View = require "UI.UIBattlePass.View.UIBattlePassLevelUpView",
    PrefabPath = "UI/Prefabs/View/UI/Pass/UIBattlePassLevelUp.prefab",
}

local UIBattlePassBuyPass = {
    Name = UIWindowNames.UIBattlePassBuyPass,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIBattlePass.Model.UIBattlePassBuyPassModel",
    Ctrl = require "UI.UIBattlePass.Ctrl.UIBattlePassBuyPassCtrl",
    View = require "UI.UIBattlePass.View.UIBattlePassBuyPassView",
    PrefabPath = "UI/Prefabs/View/UI/Pass/UIBattlePassBuyPass.prefab",
}

local UIBattlePassReward = {
    Name = UIWindowNames.UIBattlePassReward,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIBattlePass.Model.UIBattlePassRewardModel",
    Ctrl = require "UI.UIBattlePass.Ctrl.UIBattlePassRewardCtrl",
    View = require "UI.UIBattlePass.View.UIBattlePassRewardView",
    PrefabPath = "UI/Prefabs/View/UI/Pass/UIBattlePassReward.prefab",
}



return {
    UIBattlePass = UIBattlePass,
    UIBattlePassBuyLevel = UIBattlePassBuyLevel,
    UIBattlePassLevelUp = UIBattlePassLevelUp,
    UIBattlePassBuyPass = UIBattlePassBuyPass,
    UIBattlePassReward = UIBattlePassReward,
}