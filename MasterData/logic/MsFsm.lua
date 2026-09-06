-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/fsm/MsFsm.lua

module("logic.extensions.spineinterface.fsm.MsFsm", package.seeall)

local MsFsm = class("MsFsm")

function MsFsm:ctor(fsmId, states)
	self._fsmId = fsmId
	self._isDestroyed = false
	self._stateDic = {}
	self._curState = nil
	self._curStateTime = 0

	for _, state in ipairs(states) do
		local stateId = state:getStateId()

		if self._stateDic[stateId] ~= nil then
			printError(string.format("FSM '%s' state '%s' already exists.", fsmId, stateId))
		end

		self._stateDic[stateId] = state

		state:onInit(self)
	end
end

function MsFsm.createFsm(fsmName, states)
	if states == nil or #states < 1 then
		printError("FSM states are invalid.")
	end

	return MsFsm.New(fsmName, states)
end

function MsFsm:isDestroyed()
	return self._isDestroyed
end

function MsFsm:getFsmId()
	return self._fsmId
end

function MsFsm:getCurStateTime()
	return self._curStateTime
end

function MsFsm:getCurState()
	return self._curState
end

function MsFsm:destroyFsm()
	if self._curState ~= nil then
		self._curState:onExit()
	end

	for _, state in pairs(self._stateDic) do
		state:onDestroy()
	end

	self._fsmId = nil
	self._stateDic = {}
	self._curState = nil
	self._isDestroyed = true
	self._curStateTime = 0
end

function MsFsm:changeState(stateId)
	local state = self:getState(stateId)

	if state == nil then
		printError(string.format("FSM '%s' cannot change to non-existent state '%s'.", self._fsmId, stateId))
	end

	if self._curState ~= nil then
		self._curState:onExit()
	end

	self._curStateTime = 0
	self._curState = state

	self._curState:onEnter()
end

function MsFsm:getState(stateId)
	return self._stateDic[stateId]
end

function MsFsm:onUpdate(elapseSeconds, realElapseSeconds)
	if self._curState == nil then
		return
	end

	self._curStateTime = self._curStateTime + elapseSeconds

	self._curState:onUpdate(elapseSeconds, realElapseSeconds)
end

return MsFsm
