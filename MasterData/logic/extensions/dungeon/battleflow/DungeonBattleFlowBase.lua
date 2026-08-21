-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/DungeonBattleFlowBase.lua

module("logic.extensions.dungeon.battleflow.DungeonBattleFlowBase", package.seeall)

local DungeonBattleFlowBase = class("DungeonBattleFlowBase", LevelBattleFlowBase, IDungeonConfigBattleFlow)

function DungeonBattleFlowBase:_registerComponents()
	DungeonBattleFlowBase.super._registerComponents(self)
	self:_addComponent("starConditionNotify", DungeonFlowCompStarConditionNotify)
end

function DungeonBattleFlowBase:handleInit()
	DungeonBattleFlowBase.super.handleInit(self)

	self._passId = 0
end

function DungeonBattleFlowBase:handleExitBattleFinish()
	if not DungeonController.instance:getIsInDungeonBattleFlow() then
		BattleEnterUtil.exitFromDungeon()
	end
end

function DungeonBattleFlowBase:createAfterExitBattleWork()
	return DungeonBattleFlowWorkShowPlotAfterBattle.New()
end

function DungeonBattleFlowBase:getPassId()
	return self._passId
end

function DungeonBattleFlowBase:isSupportRestart()
	return true
end

function DungeonBattleFlowBase:sendRestartRequest(restartType)
	local isRestart = true
	local multiCount = self.model:getMultiCount() or 1

	if restartType == BattleEnum.RestartType.CONSECUTIVE then
		isRestart = false
		multiCount = 0
	end

	local dungeonCode = self:getPassId()
	local gamePlay = self.model:getGamePlay()

	DungeonAgent.instance:sendStartDungeonRequest(dungeonCode, multiCount, isRestart, gamePlay)
end

function DungeonBattleFlowBase:buildBattleFieldInfo(battleInfoNO)
	self._passId = battleInfoNO.passId

	DungeonModel.instance:setLastEnterDungeonCode(self._passId)

	return DungeonBattleFlowBase.super.buildBattleFieldInfo(self, battleInfoNO)
end

function DungeonBattleFlowBase:userRequestRestart(restartType)
	self:restart(restartType)
end

function DungeonBattleFlowBase:createBeforeEndBattleWork()
	if self.model:isWin() and not BattleCalculateModel.instance:hasGotCalculateData() then
		return WorkBattleWaitingDispatch.New(BattleEventType.BattleCalculateReady)
	else
		return false
	end
end

return DungeonBattleFlowBase
