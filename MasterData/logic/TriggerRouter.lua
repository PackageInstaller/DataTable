-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/TriggerRouter.lua

module("logic.extensions.spineinterface.comp.TriggerRouter", package.seeall)

local TriggerRouter = class("TriggerRouter")

function TriggerRouter:ctor(session)
	self._session = session
end

function TriggerRouter:route(triggerEvent, eventData, ...)
	local comp = self._session:getOwner()
	local fitStateList = {}

	if comp:_isForbidOp() then
		return fitStateList
	end

	local param, args = (...)

	if param then
		args = {
			...
		}
	end

	if eventData then
		comp._pointerInfo:setEventData(eventData)
	end

	local function tryAddStateToFitListFunc(_state)
		local result = true
		local condValidator = _state:getTriggerValidator()

		if not string.nilorempty(condValidator) then
			result = GameUtil.expScript(condValidator, function(str)
				return comp:_isEnoughParam(str)
			end)
		end

		if result then
			table.insert(fitStateList, _state)
		end

		return result
	end

	if triggerEvent == MsEnum.TriggerEvent_EnterState or triggerEvent == MsEnum.TriggerEvent_LimitEnterState then
		self:_routeEnterState(comp, triggerEvent, tryAddStateToFitListFunc)
	elseif triggerEvent == MsEnum.TriggerEvent_BeginDrag then
		self:_routeBeginDrag(comp, triggerEvent, eventData)
	elseif triggerEvent == MsEnum.TriggerEvent_EndDrag then
		comp._pointerInfo:setCurTriggerBoardNameOfDrag(nil)
	elseif triggerEvent == MsEnum.TriggerEvent_Drag then
		self:_routeDrag(comp, triggerEvent, tryAddStateToFitListFunc)
	elseif triggerEvent == MsEnum.TriggerEvent_PointerClick then
		self:_routePointerClick(comp, triggerEvent, eventData, args, tryAddStateToFitListFunc)
	elseif triggerEvent == MsEnum.TriggerType_EventNotify then
		self:_routeEventNotify(comp, args, tryAddStateToFitListFunc)
	elseif triggerEvent == MsEnum.TriggerEvent_Timer then
		self:_routeTimer(comp, tryAddStateToFitListFunc)
	end

	return fitStateList
end

function TriggerRouter:_routeEnterState(comp, triggerEvent, tryAddStateToFitListFunc)
	local curState

	for _, fsm in ipairs(comp._fsmList) do
		curState = fsm:getCurState()

		if curState:isEnterTrigger() and MsEnum.TriggerTypeBelong[triggerEvent][curState:getTriggerType()] ~= nil then
			tryAddStateToFitListFunc(curState)
			curState:setIsEnterTrigger(false)
		end
	end
end

function TriggerRouter:_routeBeginDrag(comp, triggerEvent, eventData)
	comp:_updateBoundingBoxData()

	local fitList = {}

	for _, fsm in ipairs(comp._fsmList) do
		local curState = fsm:getCurState()
		local triggerBoardName = curState:getTriggerBoardName()

		if MsEnum.TriggerTypeBelong[triggerEvent][curState:getTriggerType()] ~= nil then
			local slotIndex = comp:_getTriggerBoxSlotIndexByName(triggerBoardName, eventData)

			if slotIndex >= 0 then
				table.insert(fitList, {
					state = curState,
					slotIndex = slotIndex
				})
			end
		end
	end

	table.sort(fitList, function(a, b)
		if a.slotIndex ~= b.slotIndex then
			return a.slotIndex < b.slotIndex
		end

		return false
	end)

	for i, v in ipairs(fitList) do
		local condValidator = v.state:getTriggerValidator()

		if (not string.nilorempty(condValidator) or nil) and GameUtil.expScript(condValidator, function(str)
			return comp:_isEnoughParam(str)
		end) then
			comp._pointerInfo:setCurTriggerBoardNameOfDrag(v.state:getTriggerBoardName())

			break
		end
	end
end

function TriggerRouter:_routeDrag(comp, triggerEvent, tryAddStateToFitListFunc)
	for _, fsm in ipairs(comp._fsmList) do
		local curState = fsm:getCurState()

		if MsEnum.TriggerTypeBelong[triggerEvent][curState:getTriggerType()] ~= nil and comp._pointerInfo:getCurTriggerBoardNameOfDrag() == curState:getTriggerBoardName() then
			tryAddStateToFitListFunc(curState)
		end
	end
end

function TriggerRouter:_routePointerClick(comp, triggerEvent, eventData, args, tryAddStateToFitListFunc)
	comp:_updateBoundingBoxData()

	local fitList = {}

	for idx, fsm in ipairs(comp._fsmList) do
		local curState = fsm:getCurState()
		local triggerBoardName = curState:getTriggerBoardName()
		local triggerType = curState:getTriggerType()

		if triggerType and MsEnum.TriggerTypeBelong[triggerEvent][triggerType] ~= nil and eventData.dragging == false and (triggerType == MsEnum.TriggerType_PointerClick or triggerType == args[1]) then
			local slotIndex = comp:_getTriggerBoxSlotIndexByName(triggerBoardName, eventData)

			if slotIndex >= 0 then
				table.insert(fitList, {
					state = curState,
					slotIndex = slotIndex
				})
			end
		end
	end

	table.sort(fitList, function(a, b)
		if a.slotIndex ~= b.slotIndex then
			return a.slotIndex < b.slotIndex
		end

		return false
	end)

	for i, v in ipairs(fitList) do
		if tryAddStateToFitListFunc(v.state) then
			break
		end
	end
end

function TriggerRouter:_routeEventNotify(comp, args, tryAddStateToFitListFunc)
	local behaviorLayerId, behaviorId = args[1], args[2]
	local stateId = SpineInterfaceController.instance:getFsmStateId(comp._skinId, behaviorLayerId, behaviorId)

	for _, fsm in ipairs(comp._fsmList) do
		if fsm:getCurState():getStateId() == stateId then
			tryAddStateToFitListFunc(fsm:getCurState())

			break
		end
	end
end

function TriggerRouter:_routeTimer(comp, tryAddStateToFitListFunc)
	local state

	for _, fsm in ipairs(comp._fsmList) do
		state = fsm:getCurState()

		if state:getTriggerType() == MsEnum.TriggerType_Timer and state:getCurrentTime() >= state:getTimerTriggerTime() then
			tryAddStateToFitListFunc(state)

			break
		end
	end
end

return TriggerRouter
