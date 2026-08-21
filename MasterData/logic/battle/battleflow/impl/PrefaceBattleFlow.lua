-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/impl/PrefaceBattleFlow.lua

module("logic.battle.battleflow.impl.PrefaceBattleFlow", package.seeall)

local PrefaceBattleFlow = class("PrefaceBattleFlow", LevelBattleFlowBase, IDungeonConfigBattleFlow)
local kLocalSettingKey = "PrefaceBattleFlow"

function PrefaceBattleFlow:_registerComponents()
	PrefaceBattleFlow.super._registerComponents(self)
	self:_removeComponent("starConditionNotify")
	self:_removeComponent("drawGoalCell")
end

function PrefaceBattleFlow:getPassId()
	return self._passId
end

function PrefaceBattleFlow:handleInit()
	PrefaceBattleFlow.super.handleInit(self)

	self._passId = 0
end

function PrefaceBattleFlow:buildBattleFieldInfo(battleInfoNO)
	self._passId = battleInfoNO.passId

	return PrefaceBattleFlow.super.buildBattleFieldInfo(self, battleInfoNO)
end

function PrefaceBattleFlow:createBeforeStartBattleWork()
	return WorkPrefaceBattlePlot.New()
end

function PrefaceBattleFlow:handleEnterBattleFinish()
	PrefaceBattleFlow.super.handleEnterBattleFinish(self)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Setting, false, kLocalSettingKey)
end

function PrefaceBattleFlow:handleExitBattleFinish()
	PrefaceBattleFlow.super.handleExitBattleFinish(self)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Setting, true, kLocalSettingKey)
end

function PrefaceBattleFlow:createCalculateWork()
	local isFinish = PlayerModel.instance:getPrologueFinished()

	if not isFinish then
		local _allDungenonMo = PlayerModel.instance:getPrologueDungeonMO()
		local len = #_allDungenonMo
		local _dungeonInfo = _allDungenonMo[len]
		local _dungeonCode = _dungeonInfo.id or 0
		local dungeonCO = DungeonConfig.instance:getDungeonCfgById(_dungeonCode)

		if dungeonCO and dungeonCO.levelID == self:getBattleLevelCode() then
			PlayerAgent.instance:sendPrologueFinishStageRequest()
		end
	end

	return false
end

function PrefaceBattleFlow:createExitBattleWork()
	return WorkExitScene.New()
end

function PrefaceBattleFlow:isEnableCampAdjustment()
	return false
end

function PrefaceBattleFlow:isShowBlackLoading()
	return true
end

return PrefaceBattleFlow
