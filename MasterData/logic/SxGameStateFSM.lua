-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameStateFSM.lua

module("logic.extensions.sxgame.view.state.SxGameStateFSM", package.seeall)

local SxGameStateFSM = class("SxGameStateFSM")

function SxGameStateFSM:ctor()
	self._states = {}
	self._curState = nil
	self._preState = nil
end

function SxGameStateFSM:onInit()
	self:swicthState("SxGameDefaultState")
end

function SxGameStateFSM:AddState(stateName)
	self._states = self._states or {}

	local GGG = getglobal("_G")

	self._states[stateName] = self._states[stateName] or GGG[stateName].New(stateName)
end

function SxGameStateFSM:AddInitState(state)
	return
end

function SxGameStateFSM:swicthState(stateName)
	if self._curState and self._curState._stateName ~= stateName then
		self._preState = self._curState._stateName

		self._curState:onExit(self._unit)
	end

	if not self._states[stateName] then
		self:AddState(stateName)
	end

	self._curState = self._states[stateName]

	self._curState:onEnter()
end

function SxGameStateFSM:getCurState()
	if not self._curState then
		return
	end

	return self._curState
end

function SxGameStateFSM:getCurStateName()
	if not self._curState then
		return ""
	end

	return self._curState._stateName
end

function SxGameStateFSM:getPreStateName()
	return self._preState
end

function SxGameStateFSM:clear()
	for k, v in pairs(self._states) do
		v:onExit(self._unit)
	end

	self._states = nil
	self._curState = nil
end

return SxGameStateFSM
