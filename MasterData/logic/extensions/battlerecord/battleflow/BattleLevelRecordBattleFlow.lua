-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/battleflow/BattleLevelRecordBattleFlow.lua

module("logic.extensions.battlerecord.battleflow.BattleLevelRecordBattleFlow", package.seeall)

local BattleLevelRecordBattleFlow = class("BattleLevelRecordBattleFlow", LevelBattleFlowBase)

function BattleLevelRecordBattleFlow:_registerComponents()
	BattleLevelRecordBattleFlow.super._registerComponents(self)
	self:_removeComponent("netEventMgr")
	self:_removeComponent("starConditionNotify")
	self:_addComponent("netEventMgr", BattleCompRecordNetEventMgr)
end

function BattleLevelRecordBattleFlow:handleEnterBattle()
	BattleRecordUtil.enterSetup()
end

function BattleLevelRecordBattleFlow:handleExitBattleFinish()
	BattleRecordUtil.exitSetup()
end

function BattleLevelRecordBattleFlow:handleBattleStart()
	self.netEventMgr:processNextEvent()
end

function BattleLevelRecordBattleFlow:createCalculateWork()
	return false
end

function BattleLevelRecordBattleFlow:createExitBattleWork()
	return WorkExitScene.New()
end

function BattleLevelRecordBattleFlow:isEnableCampAdjustment()
	return false
end

return BattleLevelRecordBattleFlow
