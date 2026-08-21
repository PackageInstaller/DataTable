-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleConditionsChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleConditionsChangedCommand", package.seeall)

local BattleConditionsChangedCommand = class("BattleConditionsChangedCommand", BattleTimingCommandBase)

function BattleConditionsChangedCommand:parseServerCommand(cmdParser, wonConditionsChangedNO)
	local cmd = BattleConditionsChangedCommand:createInstance()

	cmd:setAddedConditions(wonConditionsChangedNO.added)
	cmd:setRemovedConditions(wonConditionsChangedNO.removed)
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattlePreviewTaskTargetCommand:create(cmd._addedWinConditions, cmd._addedLoseConditions))
end

function BattleConditionsChangedCommand:onInit()
	self._addedWinConditions = {}
	self._addedLoseConditions = {}
	self._removedWinConditions = {}
	self._removedLoseConditions = {}
end

function BattleConditionsChangedCommand:onClear()
	BattleMainViewFacade.instance:setVisible(true)
	ViewMgr.instance:close(ViewName.BattleConditions)
	BattleTableUtil.clearTable(self._addedWinConditions)
	BattleTableUtil.clearTable(self._addedLoseConditions)
	BattleTableUtil.clearTable(self._removedWinConditions)
	BattleTableUtil.clearTable(self._removedLoseConditions)
end

function BattleConditionsChangedCommand:execute(battleFlow)
	local winCondition = battleFlow.winCondition
	local baseWinConditions = BattleTableUtil.getTempList()

	BattleTableUtil.insertto(baseWinConditions, winCondition:getAdditionalWinConditionTags())
	winCondition:addWinConditionTags(self._addedWinConditions)
	winCondition:addLoseConditionTags(self._addedLoseConditions)
	winCondition:removeWinConditionTags(self._removedWinConditions)
	winCondition:removeLoseConditionTags(self._removedLoseConditions)
	battleFlow:fillKillEntityCodeListOfCamp(battleFlow.settingModel:getKillEntityCodeList())
	battleFlow:fillProtectEntityCodeListOfCamp(battleFlow.settingModel:getProtectEntityCodeList())
	BattleDispatcher:dispatchEvent(BattleEventType.OnCondtionsChanged)
	BattleMainViewFacade.instance:setVisible(false)
	ViewMgr.instance:open(ViewName.BattleConditions, true, baseWinConditions, self._addedWinConditions, self._removedWinConditions)
	BattleTableUtil.releaseTempList(baseWinConditions)
	self:startTimer(BattleConst.DelayThree)
end

function BattleConditionsChangedCommand:toString()
	return string.format("[entity conditions changed command addedWinConditions = %s,removedWinConditions = %s, addedLoseConditions = %s, removedLoseConditions = %s]", BattleTableUtil.arrayToString(self._addedWinConditions), BattleTableUtil.arrayToString(self._removedWinConditions), BattleTableUtil.arrayToString(self._addedLoseConditions), BattleTableUtil.arrayToString(self._removedLoseConditions))
end

function BattleConditionsChangedCommand:setAddedConditions(addedConditions)
	local dungeonBattleInfoCOWrapper = self:_getDungeonBattleInfoCOWrapper()

	for _, tag in ipairs(addedConditions) do
		if dungeonBattleInfoCOWrapper:isWinCondition(tag) then
			table.insert(self._addedWinConditions, tag)
		else
			table.insert(self._addedLoseConditions, tag)
		end
	end

	return self
end

function BattleConditionsChangedCommand:setRemovedConditions(removedConditions)
	local dungeonBattleInfoCOWrapper = self:_getDungeonBattleInfoCOWrapper()

	for _, tag in ipairs(removedConditions) do
		if dungeonBattleInfoCOWrapper:isWinCondition(tag) then
			table.insert(self._removedWinConditions, tag)
		else
			table.insert(self._removedLoseConditions, tag)
		end
	end

	return self
end

function BattleConditionsChangedCommand:_getDungeonBattleInfoCOWrapper()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	return DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(flow:getBattleLevelCode())
end

return BattleConditionsChangedCommand
