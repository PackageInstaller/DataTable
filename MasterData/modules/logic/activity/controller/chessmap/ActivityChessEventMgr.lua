-- chunkname: @modules/logic/activity/controller/chessmap/ActivityChessEventMgr.lua

module("modules.logic.activity.controller.chessmap.ActivityChessEventMgr", package.seeall)

local ActivityChessEventMgr = class("ActivityChessEventMgr")

function ActivityChessEventMgr:ctor()
	self._stepList = {}
	self._stepPool = nil
	self._curStep = nil
	self._curEventData = nil
	self._curEvent = nil
end

ActivityChessEventMgr.EventClzMap = {
	[ActivityChessEnum.GameEventType.Lock] = ActivityChessStateLock,
	[ActivityChessEnum.GameEventType.Normal] = ActivityChessStateNormal,
	[ActivityChessEnum.GameEventType.Battle] = ActivityChessStateBattle,
	[ActivityChessEnum.GameEventType.UseItem] = ActivityChessStateUseItem,
	[ActivityChessEnum.GameEventType.FinishEvent] = ActivityChessStateFinishEvent
}

function ActivityChessEventMgr:setCurEvent(serverEvt)
	self._curEventData = serverEvt ~= nil and not string.nilorempty(serverEvt.param) and cjson.decode(serverEvt.param) or nil

	self:buildEventState()
end

function ActivityChessEventMgr:setCurEventByObj(obj)
	self._curEventData = obj and obj or nil

	self:buildEventState()
end

function ActivityChessEventMgr:buildEventState()
	local eventType = not self._curEventData and ActivityChessEnum.GameEventType.Normal or self._curEventData.eventType

	if self._curEvent and self._curEvent:getStateType() == eventType then
		return
	end

	local clz = ActivityChessEventMgr.EventClzMap[eventType]

	if clz then
		self:disposeEventState()

		self._curEvent = clz.New()

		self._curEvent:init(eventType, self._curEventData)
		self._curEvent:start()
	end
end

function ActivityChessEventMgr:setLockEvent()
	self:disposeEventState()

	self._curEventData = nil
	self._curEvent = ActivityChessStateLock.New()

	self._curEvent:init()
	self._curEvent:start()
end

function ActivityChessEventMgr:disposeEventState()
	if self._curEvent ~= nil then
		self._curEvent:dispose()

		self._curEvent = nil
	end
end

function ActivityChessEventMgr:getCurEvent()
	return self._curEvent
end

function ActivityChessEventMgr:insertStepList(serverData)
	local len = #serverData

	for i = 1, len do
		local stepData = serverData[i]

		self:insertStep(stepData)
	end
end

function ActivityChessEventMgr:insertStep(serverData)
	local step = self:buildStep(serverData)

	if step then
		self._stepList = self._stepList or {}

		table.insert(self._stepList, step)
	end

	if self._curStep == nil then
		self:nextStep()
	end
end

ActivityChessEventMgr.StepClzMap = {
	[ActivityChessEnum.GameStepType.GameFinish] = ActivityChessStepGameFinish,
	[ActivityChessEnum.GameStepType.Move] = ActivityChessStepMove,
	[ActivityChessEnum.GameStepType.NextRound] = ActivityChessStepNextRound,
	[ActivityChessEnum.GameStepType.CallEvent] = ActivityChessStepCallEvent,
	[ActivityChessEnum.GameStepType.CreateObject] = ActivityChessStepCreateObject,
	[ActivityChessEnum.GameStepType.DeleteObject] = ActivityChessStepDeleteObject,
	[ActivityChessEnum.GameStepType.PickUp] = ActivityChessStepPickUpItem,
	[ActivityChessEnum.GameStepType.InteractFinish] = ActivityChessStepInteractFinish,
	[ActivityChessEnum.GameStepType.SyncInteractObj] = ActivityChessStepSyncObject
}

function ActivityChessEventMgr:buildStep(serverData)
	local data = cjson.decode(serverData.param)
	local stepClz = ActivityChessEventMgr.StepClzMap[data.stepType]

	if stepClz then
		local stepObj

		self._stepPool = self._stepPool or {}

		if self._stepPool[stepClz] ~= nil and #self._stepPool[stepClz] >= 1 then
			local len = #self._stepPool[stepClz]

			stepObj = self._stepPool[stepClz][len]
			self._stepPool[stepClz][len] = nil
		else
			stepObj = stepClz.New()
		end

		stepObj:init(data)

		return stepObj
	end
end

function ActivityChessEventMgr:nextStep()
	self:recycleCurStep()

	if not self._isStepStarting then
		self._isStepStarting = true

		while self._stepList and #self._stepList > 0 and self._curStep == nil do
			self._curStep = self._stepList[1]

			table.remove(self._stepList, 1)
			self._curStep:start()
		end

		self._isStepStarting = false
	end
end

function ActivityChessEventMgr:recycleCurStep()
	if self._curStep then
		self._curStep:dispose()

		self._stepPool[self._curStep.class] = self._stepPool[self._curStep.class] or {}

		table.insert(self._stepPool[self._curStep.class], self._curStep)

		self._curStep = nil
	end
end

function ActivityChessEventMgr:disposeAllStep()
	if self._curStep then
		self._curStep:dispose()

		self._curStep = nil
	end

	if self._stepList then
		for _, step in pairs(self._stepList) do
			step:dispose()
		end

		self._stepList = nil
	end

	self._stepPool = nil
	self._isStepStarting = false
end

function ActivityChessEventMgr:removeAll()
	self._stepList = nil
	self._curStep = nil

	self:disposeAllStep()
	self:disposeEventState()
end

return ActivityChessEventMgr
