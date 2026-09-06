-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/fsm/MsFsmState.lua

module("logic.extensions.spineinterface.fsm.MsFsmState", package.seeall)

local MsFsmState = class("MsFsmState")

function MsFsmState:ctor(stateId)
	self._stateId = stateId
end

function MsFsmState:onInit(fsm)
	self._fsm = fsm
end

function MsFsmState:onDestroy()
	self._fsm = nil
end

function MsFsmState:getStateId()
	return self._stateId
end

function MsFsmState:getFsmId()
	return self._fsm:getFsmId()
end

function MsFsmState:onEnter()
	return
end

function MsFsmState:onExit()
	return
end

function MsFsmState:onUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MsFsmState:changeState(stateId)
	self._fsm:changeState(stateId)
end

return MsFsmState
