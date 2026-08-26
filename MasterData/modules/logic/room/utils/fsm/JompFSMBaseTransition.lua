-- chunkname: @modules/logic/room/utils/fsm/JompFSMBaseTransition.lua

module("modules.logic.room.utils.fsm.JompFSMBaseTransition", package.seeall)

local JompFSMBaseTransition = class("JompFSMBaseTransition", SimpleFSMBaseTransition)

function JompFSMBaseTransition:ctor(fromStateName, toStateName, eventId, jompStateNames)
	JompFSMBaseTransition.super.ctor(self, fromStateName, toStateName, eventId)

	self.jompStateNames = {}

	tabletool.addValues(self.jompStateNames, jompStateNames)
end

function JompFSMBaseTransition:onDone()
	local toState

	for i = 1, #self.jompStateNames do
		if self:checkJompState(self.jompStateNames[i]) then
			toState = self.jompStateNames[i]

			break
		end
	end

	self.fsm:endTransition(toState or self.toStateName)
end

function JompFSMBaseTransition:checkJompState(state)
	return state and RoomFSMHelper.isCanJompTo(state)
end

return JompFSMBaseTransition
