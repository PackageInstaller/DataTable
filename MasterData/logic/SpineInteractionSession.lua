-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/SpineInteractionSession.lua

module("logic.extensions.spineinterface.comp.SpineInteractionSession", package.seeall)

local SpineInteractionSession = class("SpineInteractionSession")

function SpineInteractionSession:ctor(owner)
	self._owner = owner
	self._motionMoQueue = {}
end

function SpineInteractionSession:onLoad(skinId)
	self:onClear()

	self._ownerSkinId = checknumber(skinId)
	self._definition = ConfigCompiler.New():compile(self._ownerSkinId)
	self._triggerRouter = TriggerRouter.New(self)
	self._motionExecutorRegistry = MotionExecutorRegistry.New(self)
end

function SpineInteractionSession:onClear()
	table.clear(self._motionMoQueue)

	if self._definition then
		self._definition:onClear()
	end

	self._definition = nil
	self._triggerRouter = nil
	self._motionExecutorRegistry = nil
	self._ownerSkinId = 0
end

function SpineInteractionSession:getOwner()
	return self._owner
end

function SpineInteractionSession:getDefinition()
	return self._definition
end

function SpineInteractionSession:checkTrigger(triggerEvent, eventData, ...)
	if self._triggerRouter == nil then
		return false
	end

	local fitStateList = self._triggerRouter:route(triggerEvent, eventData, ...)

	for _, state in ipairs(fitStateList) do
		self:addMotionMoToQueue(state)
	end

	self:tryTriggerDoMotionQueue()

	return #fitStateList > 0
end

function SpineInteractionSession:notifyInteraction(behaviorLayerId, behaviorId, finishCallback)
	if self._triggerRouter == nil then
		return false
	end

	local fitStateList = self._triggerRouter:route(MsEnum.TriggerType_EventNotify, nil, behaviorLayerId, behaviorId)

	if #fitStateList <= 0 then
		return false
	end

	for _, state in ipairs(fitStateList) do
		self:addMotionMoToQueue(state, finishCallback)
	end

	self:tryTriggerDoMotionQueue()

	return true
end

function SpineInteractionSession:addMotionMoToQueue(state, finishCallback)
	local fsmId = state:getFsmId()

	self._motionMoQueue[fsmId] = {}
	self._motionMoQueue[fsmId].finishCallback = finishCallback

	for _, motionMo in ipairs(state:getTriggerMotionMoList()) do
		local motionInfo = {
			blockState = 1,
			state = state,
			motionMo = motionMo,
			triggerType = state:getTriggerType(),
			triggerParam = state:getTriggerParam()
		}

		table.insert(self._motionMoQueue[fsmId], motionInfo)
	end

	if #self._motionMoQueue[fsmId] <= 0 then
		self:_finishMotionQueue(fsmId, self._motionMoQueue[fsmId])
	end
end

function SpineInteractionSession:tryTriggerDoMotionQueue()
	for fsmId, infoList in pairs(self._motionMoQueue) do
		while #infoList > 0 do
			local motionInfo = infoList[1]
			local blockState = motionInfo.blockState

			if blockState == 1 then
				self:doMotion(motionInfo)
			elseif blockState == 2 then
				break
			else
				table.remove(infoList, 1)
			end
		end

		if #infoList <= 0 then
			self:_finishMotionQueue(fsmId, infoList)
		end
	end

	SpineInterfaceMemoryRuntime.flush(self._owner)
end

function SpineInteractionSession:doMotion(motionInfo)
	if self._motionExecutorRegistry == nil then
		return
	end

	self._motionExecutorRegistry:execute(motionInfo)
end

function SpineInteractionSession:_finishMotionQueue(fsmId, infoList)
	if infoList == nil or infoList.isFinished then
		return
	end

	infoList.isFinished = true

	local finishCallback = infoList.finishCallback

	infoList.finishCallback = nil

	GameUtil.callBack(finishCallback)
end

return SpineInteractionSession
