---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/13 17:16
---


local UISetting = {
    Name = UIWindowNames.UISetting,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UISetting.UISettingModel",
    Ctrl = require "UI.UISetting.UISettingCtrl",
    View = require "UI.UISetting.UISettingView",
    PrefabPath = "UI/Prefabs/View/UI/UISetting.prefab",
}

local UICodeSetting = {
    Name = UIWindowNames.UICodeSetting,
    Layer = UILayers.TipLayer,
    Model = require "UI.UISetting.UICodeSettingModel",
    Ctrl = nil,
    View = require "UI.UISetting.UICodeSettingView",
    PrefabPath = "UI/Prefabs/View/UI/UICodeSetting.prefab",
}

local UIRedeemCode = {
    Name = UIWindowNames.UIRedeemCode,
    Layer = UILayers.TipLayer,
    Model = nil,
    Ctrl = nil,
    View = require "UI.UISetting.UIRedeemCode.UIRedeemCodeView",
    PrefabPath = "UI/Prefabs/View/UI/UIRedeemCode.prefab",
}

local UIMoreSetting = {
    Name = UIWindowNames.UIMoreSetting,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UISetting.UIMoreSettingModel",
    Ctrl = require "UI.UISetting.UIMoreSettingCtrl",
    View = require "UI.UISetting.UIMoreSettingView",
    PrefabPath = "UI/Prefabs/View/UI/UIMoreSetting.prefab",
}

return {
    UISetting = UISetting,
    UICodeSetting = UICodeSetting,
    UIRedeemCode = UIRedeemCode,
    UIMoreSetting = UIMoreSetting,
}