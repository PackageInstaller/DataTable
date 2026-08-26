-- chunkname: @modules/logic/chessgame/game/event/ChessEventMgr.lua

module("modules.logic.chessgame.game.event.ChessEventMgr", package.seeall)

local ChessEventMgr = class("ChessEventMgr")

function ChessEventMgr:ctor()
	self._stepList = {}
	self._stepPool = nil
	self._curStep = nil
	self._curEventData = nil
	self._curEvent = nil
	self._flow = nil
	self._lastWork = nil
end

ChessEventMgr.EventClzMap = {
	[ChessGameEnum.GameEventType.Normal] = ChessStateNormal
}

function ChessEventMgr:setCurEvent(serverEvt)
	self._curEventData = serverEvt ~= nil and not string.nilorempty(serverEvt.param) and cjson.decode(serverEvt.param) or nil

	self:buildEventState()
end

function ChessEventMgr:setCurEventByObj(obj)
	self._curEventData = obj and obj or nil

	self:buildEventState()
end

function ChessEventMgr:buildEventState()
	local eventType = not self._curEventData and ChessGameEnum.GameEventType.Normal or self._curEventData.eventType

	if self._curEvent and self._curEvent:getStateType() == eventType then
		return
	end

	local clz = ChessEventMgr.EventClzMap[eventType]

	if clz then
		self:disposeEventState()

		self._curEvent = clz.New()

		self._curEvent:init(eventType, self._curEventData)
		self._curEvent:start()
	end
end

function ChessEventMgr:setLockEvent()
	self:disposeEventState()

	self._curEventData = nil
	self._curEvent = ChessStateLock.New()

	self._curEvent:init()
	self._curEvent:start()
end

function ChessEventMgr:disposeEventState()
	if self._curEvent ~= nil then
		self._curEvent:dispose()

		self._curEvent = nil
	end
end

function ChessEventMgr:getCurEvent()
	return self._curEvent
end

function ChessEventMgr:insertStepList(steps)
	self._flow = FlowSequence.New()

	local len = #steps

	for i = 1, len do
		local stepData = steps[i]

		self:insertStep2(self._flow, stepData)
	end

	self._flow:addWork(ChessCheckIsCatch.New())

	self._moveFlow = nil

	self._flow:registerDoneListener(self._onFlowDone, self)

	local catchObj = ChessGameModel.instance:getCatchObj()

	self._flow:start(catchObj)
end

function ChessEventMgr:_onFlowDone()
	if not ChessGameModel.instance:isTalking() then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameMapDataUpdate)
	end

	self._flow = nil
	self._lastWork = nil
end

function ChessEventMgr:isPlayingFlow()
	if self._flow then
		return true
	end
end

function ChessEventMgr:stopFlow()
	if self._flow and self._flow.status == WorkStatus.Running then
		self._flow:stop()
	end

	self._flow = nil
end

function ChessEventMgr:insertStep2(flow, stepData)
	local work = self:buildStep(stepData)

	if work.originData.stepType == ChessGameEnum.StepType.Move then
		if self._lastWork and self._lastWork.originData.id == work.originData.id then
			self._moveFlow = nil

			flow:addWork(work)

			self._lastWork = work
		else
			if not self._moveFlow then
				self._moveFlow = FlowParallel.New()

				flow:addWork(self._moveFlow)

				self._lastWork = work
			end

			self._moveFlow:addWork(work)

			self._lastWork = work
		end
	else
		self._moveFlow = nil

		flow:addWork(work)

		self._lastWork = work
	end
end

function ChessEventMgr:isNeedBlock()
	if self._stepList then
		for i = 1, #self._stepList do
			if self:_chekNeedBlock(self._stepList[i]) then
				return true
			end
		end
	end

	if self:_chekNeedBlock(self._curStep) then
		return true
	end

	return false
end

function ChessEventMgr:_chekNeedBlock(stepObj)
	if stepObj then
		::label_14_0::

		local var_14_0 = stepObj.originData

		if stepObj.originData then
			local stepId = stepObj.originData.stepType

			self._needBlockStepMap = self._needBlockStepMap or {
				[ChessGameEnum.StepType.Story] = true,
				[ChessGameEnum.StepType.Move] = true,
				[ChessGameEnum.StepType.InteractDelete] = true,
				[ChessGameEnum.StepType.Transport] = true,
				[ChessGameEnum.StepType.Dialogue] = true
			}

			return self._needBlockStepMap[stepId]
		end
	end
end

ChessEventMgr.StepClzMap = {
	[ChessGameEnum.StepType.UpdateRound] = ChessStepUpdateRound,
	[ChessGameEnum.StepType.Move] = ChessStepMove,
	[ChessGameEnum.StepType.Transport] = ChessStepTransport,
	[ChessGameEnum.StepType.CurrMapRefresh] = ChessStepCurrMapRefresh,
	[ChessGameEnum.StepType.InteractDelete] = ChessStepInteractDelete,
	[ChessGameEnum.StepType.Story] = ChessStepStory,
	[ChessGameEnum.StepType.Guide] = ChessStepGuide,
	[ChessGameEnum.StepType.Pass] = ChessStepPass,
	[ChessGameEnum.StepType.Dead] = ChessStepDead,
	[ChessGameEnum.StepType.Dialogue] = ChessStepDialogue,
	[ChessGameEnum.StepType.Completed] = ChessStepCompleted,
	[ChessGameEnum.StepType.ShowInteract] = ChessStepShowInteract,
	[ChessGameEnum.StepType.ChangeModule] = ChessStepChangeModule,
	[ChessGameEnum.StepType.ShowToast] = ChessStepShowToast,
	[ChessGameEnum.StepType.BreakObstacle] = ChessStepBreakObstacle,
	[ChessGameEnum.StepType.Talk] = ChessStepTalk,
	[ChessGameEnum.StepType.RefreshTarget] = ChessStepRefreshTarget
}

function ChessEventMgr:buildStep(serverData)
	local data = cjson.decode(serverData.param)
	local actId = ChessModel.instance:getActId()
	local stepClz = ChessEventMgr.StepClzMap[data.stepType]

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

function ChessEventMgr:nextStep()
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

function ChessEventMgr:recycleCurStep()
	if self._curStep then
		self._curStep:dispose()

		self._stepPool[self._curStep.class] = self._stepPool[self._curStep.class] or {}

		table.insert(self._stepPool[self._curStep.class], self._curStep)

		self._curStep = nil
	end
end

function ChessEventMgr:disposeAllStep()
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

function ChessEventMgr:removeAll()
	self._stepList = nil
	self._curStep = nil

	self:disposeAllStep()
	self:disposeEventState()
end

return ChessEventMgr
