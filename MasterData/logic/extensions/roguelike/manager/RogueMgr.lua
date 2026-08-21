-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/manager/RogueMgr.lua

module("logic.extensions.roguelike.manager.RogueMgr", package.seeall)

local M = class("RogueMgr")

function M:ctor()
	self._unitIdIndex = 0
	self._rogueFlowCaches = {}
	self._activeRogueFlow = nil
	self._showDice = true
	self._waitTimeScale = 1
	self._isClientMode = false
	self._isAutoThrowDice = false
	self._isHackToolModel = false
end

function M:enter(originalInfo, battleFlowClass)
	self:_setActiveRogueFlow(battleFlowClass or RogueFlow)
	self._activeRogueFlow:enter()

	local battleFieldInfo = self._activeRogueFlow:buildRogueFieldInfo(originalInfo)

	self._activeRogueFlow:enter(battleFieldInfo)
end

function M:meetMonster(monsterId)
	self:setGambleTime(RoguelikeModel.instance:getAllInTime())
	RogueBroadcastModel.instance:clearList()
	self._activeRogueFlow:_onMeetMonster(monsterId)
end

function M:enterMonsterFight()
	self._activeRogueFlow:enterMonsterFight()
end

function M:enterFight(monsterId)
	self:setGambleTime(RoguelikeModel.instance:getAllInTime())
	RogueBroadcastModel.instance:clearList()
	self._activeRogueFlow:_onMeetRogueFight(monsterId)
	RoguelikeModel.instance:setEnterRoleStates()
end

function M:enterEvent(eventId, eventType)
	self:setGambleTime(RoguelikeModel.instance:getAllInTime())
	RogueBroadcastModel.instance:clearList()
	self._activeRogueFlow:_onMeetRogueEvent(eventId, eventType)
	RoguelikeModel.instance:setEnterRoleStates()
end

local kBlockKeyRogue = "BlockKeyRogue"

function M:enterEventWithToast(eventId, eventType)
	ViewBlockMgr.instance:blockClick(true, kBlockKeyRogue)
	FloatWordMgr.instance:show("判定过程演算中…3")
	settimer(1, function()
		FloatWordMgr.instance:clear(true)
		FloatWordMgr.instance:show("判定过程演算中…2")
		settimer(1, function()
			FloatWordMgr.instance:clear(true)
			FloatWordMgr.instance:show("判定过程演算中…1")
			settimer(1, function()
				if self:isInRogue() then
					self:enterEvent(eventId, eventType)
				end

				settimer(1, function()
					ViewBlockMgr.instance:blockClick(false, kBlockKeyRogue)
				end, self, false)
			end, self, false)
		end, self, false)
	end, self, false)
end

function M:exit()
	if self._activeRogueFlow then
		self._activeRogueFlow:exit()
	end

	RoguePlotUtil.instance:clear()
	RoguelikeController.instance:clear()
	RoguelikeModel.instance:clearScriptId()
	self:_clearActiveRogueFlow()

	if ViewMgr.instance:isOpen(ViewName.RogueSelectPropAndRole) then
		ViewMgr.instance:close(ViewName.RogueSelectPropAndRole)
	end
end

function M:isInRogue()
	return self._activeRogueFlow and true or false
end

function M:getUnitMgr()
	return self._activeRogueFlow.unitMgr
end

function M:getModel()
	return self._activeRogueFlow and self._activeRogueFlow.model or nil
end

function M:getStateMgr()
	return self._activeRogueFlow.stateMgr
end

function M:getConditionMgr()
	return self._activeRogueFlow.conditionMgr
end

function M:getMapMgr()
	if not self._activeRogueFlow then
		return nil
	end

	return self._activeRogueFlow.mapMgr
end

function M:getPlateMgr()
	if not self._activeRogueFlow then
		return nil
	end

	return self._activeRogueFlow.plateMgr
end

function M:getForecastDrawer()
	return self._activeRogueFlow.forecastDrawing
end

function M:_setActiveRogueFlow(rogueFlowClass)
	local rogueFlow = self._rogueFlowCaches[rogueFlowClass]

	rogueFlow = rogueFlow or rogueFlowClass.New()
	self._activeRogueFlow = rogueFlow
end

function M:_clearActiveRogueFlow()
	self._activeRogueFlow = false
end

function M:changeRogueState(state)
	self._activeRogueFlow:changeRogueState(state)
end

function M:getRogueFlow()
	return self._activeRogueFlow
end

function M:getNewUnitIdIndex()
	self._unitIdIndex = self._unitIdIndex + 1

	return self._unitIdIndex
end

function M:getIsAutoThrowDice()
	return self._isAutoThrowDice
end

function M:getNeedShowDice()
	return self._showDice
end

function M:reverseShowDice()
	self._showDice = not self._showDice

	return self._showDice
end

function M:setNeedShowDice(showDice)
	self._showDice = showDice
end

function M:updateRoleInfo(msg)
	if self:isInRogue() then
		self._activeRogueFlow:updateRoleInfo(msg)
	end
end

function M:setGambleTime(time)
	self._gambleTime = time
end

function M:getGambleTime()
	local time = self._gambleTime

	return time
end

function M:setWaitTimeScale(scale)
	self._waitTimeScale = scale
end

function M:getWaitTimeScale()
	return self._waitTimeScale
end

function M:setIsClientMode(isClientMode)
	self._isClientMode = isClientMode
end

function M:getIsClientMode()
	return self._isClientMode
end

function M:setHackToolModel(hackToolModel)
	self._isHackToolModel = hackToolModel
end

function M:getHackToolModel()
	return self._isHackToolModel
end

function M:recoverAllDice()
	local diceMgr = self:getRogueFlow().diceMgr
	local judgeMgr = self:getRogueFlow().judgeMgr
	local combatDices = judgeMgr:getCurRoundCombatDice()
	local playerDices = judgeMgr:getCurRoundPlayerDice()

	for k, v in pairs(combatDices) do
		diceMgr:recoveryDiceObj(v:getGo())
	end

	for k, v in pairs(playerDices) do
		diceMgr:recoveryDiceObj(v:getGo())
	end
end

function M:setTempDicePatterns(patterns)
	self._tmpDicePatterns = {}

	if patterns and patterns ~= "" then
		local patternList = string.split(patterns, ",")

		for k, v in ipairs(patternList or {}) do
			table.insert(self._tmpDicePatterns, tonumber(v))
		end
	end
end

function M:getTempDicePatterns()
	return self._tmpDicePatterns or {}
end

M.instance = M.New()

return M
