-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/impl/RogueFlow.lua

module("logic.extensions.roguelike.flow.impl.RogueFlow", package.seeall)

local M = class("RogueFlow", IRogueFlowHandler)

function M:ctor()
	self._compList = {}
	self._workingWork = false

	self:_registerComponents()
	self:_notifyComponents(BattleFunctionName.onInit)
	self:handleInit()
end

function M:handleInit()
	return
end

function M:enter()
	self:setEvent(true)
	self:_notifyComponents(BattleFunctionName.onStart)
end

function M:exit()
	self:setEvent(false)
	self:_notifyComponents(BattleFunctionName.onClear)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_MEET_EVENT, self._onMeetRogueEvent, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_FIGHT_EVENT, self._onMeetRogueFight, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MEET_EVENT, self._onMeetRogueEvent, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FIGHT_EVENT, self._onMeetRogueFight, self)
	end
end

function M:buildRogueFieldInfo(fieldInfo)
	self.model:setRogueFieldInfo(fieldInfo)
end

function M:_onMeetRogueEvent(eventId, eventType)
	self.model:setCurEventType(eventType)

	if self._gameEventFlow ~= nil then
		self._gameEventFlow:exit()
	end

	self._gameEventFlow = RogueGameEventFlow.New()

	self.model:setCurEventId(eventId)
	self.stateMgr:setRoundIndex(self:getRoundIndex())
	self.stateMgr:updateExtraPatterns()
	self._gameEventFlow:enter()

	self._curGameFlow = self._gameEventFlow

	if RogueMgr.instance:getIsClientMode() then
		return
	end

	local replyCo = self.model:getCurReplyCo()

	RoguelikeAgent.instance:sendStartJudgeRequest(eventType, replyCo and replyCo.id or 0, eventId)
end

function M:_onMeetRogueFight(monsterId, beforeCallback)
	if self._gameFightFlow ~= nil then
		self._gameFightFlow:exit()
	end

	self._gameFightFlow = RogueGameFightFlow.New()

	self.model:setCurEventType(RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT)
	self.stateMgr:setRoundIndex(self:getRoundIndex())
	self.model:setCurMonster(monsterId)
	self.stateMgr:updateExtraPatterns()

	if beforeCallback ~= nil then
		beforeCallback()
	end

	self._gameFightFlow:enter()

	self._curGameFlow = self._gameFightFlow

	self.model:setCurReplyCo(nil)
end

function M:_onMeetMonster(monsterId)
	if self._gameFightFlow ~= nil then
		self._gameFightFlow:exit()
	end

	self.model:setCurEventType(RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT)
	self.model:setCurMonster(monsterId)
end

function M:enterMonsterFight()
	self.stateMgr:setRoundIndex(self:getRoundIndex())
	self.stateMgr:updateExtraPatterns()

	self._gameFightFlow = RogueGameFightFlow.New()
	self._curGameFlow = self._gameFightFlow

	self._gameFightFlow:enter()

	local monsterId = self.model:getCurMonster()

	RoguelikeAgent.instance:sendStartJudgeRequest(RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT, monsterId)
end

function M:changeRogueState(state)
	if not self._curGameFlow then
		return
	end

	self._curGameFlow.gamePlay:changeState(state)
end

function M:getCurGamePlay()
	if not self._curGameFlow then
		return
	end

	return self._curGameFlow.gamePlay:getGamePlay()
end

function M:updateRoleInfo(msg)
	self.stateMgr:updateRoleInfo(msg)
end

function M:getRoundIndex()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.round ~= 0 then
		return judgeArchive.round
	else
		return 1
	end
end

function M:_registerComponents()
	self:_addComponent("stateMgr", RogueGameStateMgr)
	self:_addComponent("conditionMgr", RogueConditionMgr)
	self:_addComponent("unitMgr", RogueUnitMgr)
	self:_addComponent("model", RogueModel)
	self:_addComponent("judgeModel", RogueJudgeModel)
	self:_addComponent("judgeMgr", RogueGameJudgeMgr)
	self:_addComponent("diceMgr", RogueGameDiceMgr)
	self:_addComponent("shieldMgr", RogueGameShieldMgr)
	self:_addComponent("mapMgr", RogueMapMgr)
	self:_addComponent("plateMgr", RoguePlateMgr)
	self:_addComponent("forecastDrawing", RogueCompForecastDrawing)
	self:_addComponent("pickHandler", RogueScenePickerHandler)
end

function M:_notifyComponents(functionName)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component)
		end
	end
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New()

	self[compName] = compInst
	compInst.flow = self

	table.insert(self._compList, compInst)
end

function M:_removeComponent(compName)
	local compInst = self[compName]

	if compInst then
		self[compName] = nil

		table.removebyvalue(self._compList, compInst, true)
	end
end

function M:internal_NotifyComponent(functionName)
	self:_notifyComponents(functionName)
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

return M
