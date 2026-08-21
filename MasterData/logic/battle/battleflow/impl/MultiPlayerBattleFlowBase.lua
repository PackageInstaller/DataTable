-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/impl/MultiPlayerBattleFlowBase.lua

module("logic.battle.battleflow.impl.MultiPlayerBattleFlowBase", package.seeall)

local MultiPlayerBattleFlowBase = class("MultiPlayerBattleFlowBase", CoreBattleFlow)

function MultiPlayerBattleFlowBase:_registerComponents()
	MultiPlayerBattleFlowBase.super._registerComponents(self)
	self:_addComponent("multiPlayerNetStateMgr", BattleMultiPlayerNetStateMgr)
end

function MultiPlayerBattleFlowBase:buildBattleFieldInfo(battleInfoNO)
	return BattleNOConverter:convertAsPvp(battleInfoNO)
end

return MultiPlayerBattleFlowBase
