-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/interface/IBattleFlowComp.lua

module("logic.battle.battleflow.component.interface.IBattleFlowComp", package.seeall)

local IBattleFlowComp = class("IBattleFlowComp")

IBattleFlowComp.flow = false
IBattleFlowComp[BattleFunctionName.onInit] = false
IBattleFlowComp[BattleFunctionName.onStart] = false
IBattleFlowComp[BattleFunctionName.onResourceLoaded] = false
IBattleFlowComp[BattleFunctionName.onEnterDone] = false
IBattleFlowComp[BattleFunctionName.onPreClear] = false
IBattleFlowComp[BattleFunctionName.onClear] = false
IBattleFlowComp[BattleFunctionName.onUndoReset] = false
IBattleFlowComp[BattleFunctionName.onUpdateTimeScale] = false

return IBattleFlowComp
