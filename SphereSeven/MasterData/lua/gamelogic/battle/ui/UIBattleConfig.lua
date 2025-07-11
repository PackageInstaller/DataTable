---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/6/11 15:50
---

-- 窗口配置
local UIBuffGlances = {
    Name = UIWindowNames.UIBuffGlances,
    Layer = UILayers.InfoLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBuffGlances.UIBuffGlancesView",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBuffGlances.prefab",
}

local UIBuffDetails = {
    Name = UIWindowNames.UIBuffDetails,
    Layer = UILayers.InfoLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBuffGlances.UIBuffDetailsView",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBuffDetails.prefab",
}

local UIBattlePlayerInfo = {
    Name = UIWindowNames.UIBattlePlayerInfo,
    Layer = UILayers.InfoLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBuffGlances.UIBattlePlayerInfo",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBattlePlayerInfo.prefab",
}

local UISkillToast = {
    Name = UIWindowNames.UISkillToast,
    Layer = UILayers.NormalLayer,
    Model = require "GameLogic.Battle.UI.UISkillToast.UISkillToastModel",
    Ctrl = require "GameLogic.Battle.UI.UISkillToast.UISkillToastCtrl",
    View = require "GameLogic.Battle.UI.UISkillToast.UISkillToastView",
    PrefabPath = "UI/Prefabs/UI/Battle/UISkillToast.prefab",
}

local UISkillFightSoul = {
    Name = UIWindowNames.UISkillFightSoul,
    Layer = UILayers.NormalLayer,
    Model = require "GameLogic.Battle.UI.UISkillFightSoul.UISkillFightSoulModel",
    Ctrl = require "GameLogic.Battle.UI.UISkillFightSoul.UISkillFightSoulCtrl",
    View = require "GameLogic.Battle.UI.UISkillFightSoul.UISkillFightSoulView",
    PrefabPath = "UI/Prefabs/UI/Battle/UISkillFightSoul.prefab",
}

local UIBattleShowRound = {
    Name = UIWindowNames.UIBattleShowRound,
    Layer = UILayers.NormalLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBattleShowRound",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBattleShowRound.prefab",
}
local UIBattleAwake = {
    Name = UIWindowNames.UIBattleAwake,
    Layer = UILayers.NormalLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBattleAwake",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBattleAwake.prefab",
}
local UIBossEffect = {
    Name = UIWindowNames.UIBossEffect,
    Layer = UILayers.NormalLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBossEffect",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBossEffect.prefab",
}
local UIBattlePause = {
    Name = UIWindowNames.UIBattlePause,
    Layer = UILayers.InfoLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBattlePause",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBattlePauseNew.prefab",
}
local UIBattleRevive = {
    Name = UIWindowNames.UIBattleRevive,
    Layer = UILayers.TipLayer,
    Model = require "GameLogic.Battle.UI.UIBattleReviveModel",
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBattleRevive",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBattleRevive.prefab",
}
local UIBattleStatus = {
    Name = UIWindowNames.UIBattleStatus,
    Layer = UILayers.InfoLayer,
    Model = nil,
    Ctrl = nil,
    View = require "GameLogic.Battle.UI.UIBattleStatus.UIBattleStatusView",
    PrefabPath = "UI/Prefabs/UI/Battle/UIBattleStatus.prefab",
}

return {
    UIBuffGlances = UIBuffGlances,
    UIBuffDetails = UIBuffDetails,
    UIBattlePlayerInfo = UIBattlePlayerInfo,
    UISkillToast = UISkillToast,
    UISkillFightSoul = UISkillFightSoul,
    UIBattleShowRound=UIBattleShowRound,
    UIBattleAwake=UIBattleAwake,
    UIBossEffect=UIBossEffect,
    UIBattlePause=UIBattlePause,
    UIBattleRevive=UIBattleRevive,
    UIBattleStatus=UIBattleStatus,
}