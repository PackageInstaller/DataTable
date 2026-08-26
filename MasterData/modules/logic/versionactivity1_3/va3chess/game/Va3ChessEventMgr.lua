-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/Va3ChessEventMgr.lua

module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessEventMgr", package.seeall)

local Va3ChessEventMgr = class("Va3ChessEventMgr")

function Va3ChessEventMgr:ctor()
	self._stepList = {}
	self._stepPool = nil
	self._curStep = nil
	self._curEventData = nil
	self._curEvent = nil
end

Va3ChessEventMgr.EventClzMap = {
	[Va3ChessEnum.GameEventType.Lock] = Va3ChessStateLock,
	[Va3ChessEnum.GameEventType.Normal] = Va3ChessStateNormal,
	[Va3ChessEnum.GameEventType.Battle] = Va3ChessStateBattle,
	[Va3ChessEnum.GameEventType.UseItem] = Va3ChessStateUseItem,
	[Va3ChessEnum.GameEventType.FinishEvent] = Va3ChessStateFinishEvent
}

function Va3ChessEventMgr:setCurEvent(serverEvt)
	self._curEventData = serverEvt ~= nil and not string.nilorempty(serverEvt.param) and cjson.decode(serverEvt.param) or nil

	self:buildEventState()
end

function Va3ChessEventMgr:setCurEventByObj(obj)
	self._curEventData = obj and obj or nil

	self:buildEventState()
end

function Va3ChessEventMgr:buildEventState()
	local eventType = not self._curEventData and Va3ChessEnum.GameEventType.Normal or self._curEventData.eventType

	if self._curEvent and self._curEvent:getStateType() == eventType then
		return
	end

	local clz = Va3ChessEventMgr.EventClzMap[eventType]

	if clz then
		self:disposeEventState()

		self._curEvent = clz.New()

		self._curEvent:init(eventType, self._curEventData)
		self._curEvent:start()
	end
end

function Va3ChessEventMgr:setLockEvent()
	self:disposeEventState()

	self._curEventData = nil
	self._curEvent = Va3ChessStateLock.New()

	self._curEvent:init()
	self._curEvent:start()
end

function Va3ChessEventMgr:disposeEventState()
	if self._curEvent ~= nil then
		self._curEvent:dispose()

		self._curEvent = nil
	end
end

function Va3ChessEventMgr:getCurEvent()
	return self._curEvent
end

function Va3ChessEventMgr:insertStepList(serverData)
	local len = #serverData

	for i = 1, len do
		local stepData = serverData[i]

		self:insertStep(stepData)
	end
end

function Va3ChessEventMgr:insertStep(serverData)
	local step = self:buildStep(serverData)

	if step then
		self._stepList = self._stepList or {}

		table.insert(self._stepList, step)
	end

	if self._curStep == nil then
		self:nextStep()
	end
end

function Va3ChessEventMgr:isNeedBlock()
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

function Va3ChessEventMgr:_chekNeedBlock(stepObj)
	if stepObj then
		::label_11_0::

		local var_11_0 = stepObj.originData

		if stepObj.originData then
			local stepId = stepObj.originData.stepType

			self._needBlockStepMap = self._needBlockStepMap or {
				[Va3ChessEnum.GameStepType.Story] = true,
				[Va3ChessEnum.GameStepType.Move] = true,
				[Va3ChessEnum.GameStepType.DeleteObject] = true,
				[Va3ChessEnum.GameStepType.CreateObject] = true,
				[Va3ChessEnum.GameStepType.NextMap] = true
			}

			return self._needBlockStepMap[stepId]
		end
	end
end

Va3ChessEventMgr.StepClzMap = {
	[Va3ChessEnum.GameStepType.GameFinish] = Va3ChessStepGameFinish,
	[Va3ChessEnum.GameStepType.Move] = Va3ChessStepMove,
	[Va3ChessEnum.GameStepType.NextRound] = Va3ChessStepNextRound,
	[Va3ChessEnum.GameStepType.CallEvent] = Va3ChessStepCallEvent,
	[Va3ChessEnum.GameStepType.CreateObject] = Va3ChessStepCreateObject,
	[Va3ChessEnum.GameStepType.DeleteObject] = Va3ChessStepDeleteObject,
	[Va3ChessEnum.GameStepType.PickUp] = Va3ChessStepPickUpItem,
	[Va3ChessEnum.GameStepType.InteractFinish] = Va3ChessStepInteractFinish,
	[Va3ChessEnum.GameStepType.SyncInteractObj] = Va3ChessStepSyncObject,
	[Va3ChessEnum.GameStepType.Story] = Va3ChessStepStory,
	[Va3ChessEnum.GameStepType.Toast] = Va3ChessStepToast,
	[Va3ChessEnum.GameStepType.NextMap] = Va3ChessStepNextMap,
	[Va3ChessEnum.GameStepType.HpUpdate] = Va3ChessStepDeductHp,
	[Va3ChessEnum.GameStepType.MapUpdate] = Va3ChessStepMapUpdate,
	[Va3ChessEnum.GameStepType.TargetUpdate] = Va3ChessStepTargetUpdate,
	[Va3ChessEnum.GameStepType.BulletUpdate] = Va3ChessStepBulletUpdate,
	[Va3ChessEnum.GameStepType.BrazierTrigger] = Va3ChessStepBrazierTrigger,
	[Va3ChessEnum.GameStepType.RefreshPedalStatus] = Va3ChessStepRefreshPedal
}
Va3ChessEventMgr.ActStepClzMap = {
	[Va3ChessEnum.ActivityId.Act120] = {
		[Va3ChessEnum.GameStepType.NextMap] = Va3ChessStepNextMapAct120,
		[Va3ChessEnum.Act120StepType.TilePosui] = Va3ChessStepTilePoSui
	},
	[Va3ChessEnum.ActivityId.Act142] = {
		[Va3ChessEnum.Act142StepType.TileFragile] = Va3ChessStepTileBroken,
		[Va3ChessEnum.Act142StepType.TileBroken] = Va3ChessStepTileBroken
	}
}

function Va3ChessEventMgr:buildStep(serverData)
	local data = cjson.decode(serverData.param)
	local actId = Va3ChessGameModel.instance:getActId()
	local acttClzMap = Va3ChessEventMgr.ActStepClzMap[actId]

	if acttClzMap then
		if not acttClzMap[data.stepType] then
			local stepClz = Va3ChessEventMgr.StepClzMap[data.stepType]

			if data.stepType == Va3ChessEnum.GameStepType.NextMap then
				logNormal("stepClz actId = " .. actId)
			end

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
	end
end

function Va3ChessEventMgr:nextStep()
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

function Va3ChessEventMgr:recycleCurStep()
	if self._curStep then
		self._curStep:dispose()

		self._stepPool[self._curStep.class] = self._stepPool[self._curStep.class] or {}

		table.insert(self._stepPool[self._curStep.class], self._curStep)

		self._curStep = nil
	end
end

function Va3ChessEventMgr:disposeAllStep()
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

function Va3ChessEventMgr:removeAll()
	self._stepList = nil
	self._curStep = nil

	self:disposeAllStep()
	self:disposeEventState()
end

return Va3ChessEventMgr
