-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingReportFragmentView.lua

module("logic.extensions.battle.viewsetting.BattleSettingReportFragmentView", package.seeall)

local M = class("BattleSettingReportFragmentView", StaticFragmentView)

function M:buildUI()
	self._goStarCondition = goutil.findChild(self.mainGO, "element1/condition")
	self._goEmptyStarCondition = goutil.findChild(self.mainGO, "element1/condition/stateEmpty")
	self._conditionItemList = {}

	for i = 1, 3 do
		local goConditionItem = goutil.findChild(self.mainGO, string.format("element1/condition/condition%s", i))

		self._conditionItemList[i] = Astral.SimpleLuaComponentContainer.Add(goConditionItem, BattleSettingStarConditionItem)
	end

	self._winCondition = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "element2/win/descScroll"), BattleSettingWinConditionView)
	self._loseCondition = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "element2/fail/descScroll"), BattleSettingWinConditionView)
end

function M:destroyUI()
	self._goStarCondition = nil
	self._goEmptyStarCondition = nil
	self._winCondition = nil
	self._loseCondition = nil
	self._conditionItemList = nil
end

function M:onEnter()
	local battleFllow = BattleMgr.instance:getActiveBattleFlow()

	if OOPUtil.isInstanceOf(battleFllow, DungeonBattleFlowBase) then
		self:_updateAsDungeonBattle()
	elseif OOPUtil.isInstanceOf(battleFllow, LevelBattleFlowBase) then
		self:_updateAsLevelBattle()
	else
		self:_updateAsEmpty()
	end
end

function M:onExit()
	self._winCondition:clear()
	self._loseCondition:clear()
end

function M:_updateAsDungeonBattle()
	local winCondition = BattleMgr.instance:getWinCondition()

	self._winCondition:setConditionStr(winCondition:getWinConditionDescription())
	self._loseCondition:setConditionStr(winCondition:getLoseConditionDescription())

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local starCodes = dungeonMO:getStarRequire()

	goutil.setActive(self._goEmptyStarCondition, not starCodes or not (#starCodes > 0))

	if starCodes and #starCodes > 0 then
		local starStates = dungeonMO:getStar()

		for index, starCode in pairs(starCodes) do
			local conditionItem = self._conditionItemList[index]

			conditionItem:setDungeonInfo(starCode, starStates[index])
		end
	else
		for i, conditionItem in ipairs(self._conditionItemList) do
			conditionItem:setDungeonInfo()
		end
	end
end

function M:_updateAsLevelBattle()
	local winCondition = BattleMgr.instance:getWinCondition()

	self._winCondition:setConditionStr(winCondition:getWinConditionDescription())
	self._loseCondition:setConditionStr(winCondition:getLoseConditionDescription())

	for i, conditionItem in ipairs(self._conditionItemList) do
		conditionItem:setDungeonInfo()
	end

	goutil.setActive(self._goEmptyStarCondition, true)
end

function M:_updateAsEmpty()
	if enableWarnLog then
		printWarn("BattleSettingReportFragmentView::unhandle battle flow type")
	end

	self._winCondition:setConditionStr("NONE")
	self._loseCondition:setConditionStr("NONE")

	for i, conditionItem in ipairs(self._conditionItemList) do
		conditionItem:setDungeonInfo()
	end

	goutil.setActive(self._goEmptyStarCondition, true)
end

return M
