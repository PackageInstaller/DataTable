-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/uistate/UIStateTransition.lua

module("logiccommon.common.viewlib.uistate.UIStateTransition", package.seeall)

local UIStateTransition = class("UIStateTransition")

function UIStateTransition:ctor()
	self.stateFrom = nil
	self.stateTo = nil
	self._closeFromStateOnDone = nil
end

function UIStateTransition:startTransition(from, to, closeFromStateOnDone, ...)
	self.stateFrom = from
	self.stateTo = to
	self._closeFromStateOnDone = closeFromStateOnDone

	if ViewMgr.instance:isOpen(to) then
		self:tryCloseTransitionFromState()
		self:stopTransition()

		return
	end

	local param = ...

	if param == nil then
		ViewMgr.instance:open(self.stateTo)
	else
		ViewMgr.instance:open(self.stateTo, ...)
	end
end

function UIStateTransition:closeAndStopTransition()
	self:closeTransitionToState()
	self:tryCloseTransitionFromState()
	self:stopTransition()
end

function UIStateTransition:stopTransition()
	self.stateFrom = nil
	self.stateTo = nil
	self._closeFromStateOnDone = nil
end

function UIStateTransition:closeTransitionToState()
	if self.stateTo then
		ViewMgr.instance:close(self.stateTo)

		self.stateTo = nil
	end
end

function UIStateTransition:tryCloseTransitionFromState()
	if self._closeFromStateOnDone and self.stateTo ~= self.stateFrom then
		self:closeTransitionFromState()
	end
end

function UIStateTransition:closeTransitionFromState()
	if self.stateFrom then
		ViewMgr.instance:close(self.stateFrom)

		self.stateFrom = nil
	end
end

function UIStateTransition:getTransitionFrom()
	return self.stateFrom
end

function UIStateTransition:getTransitionTo()
	return self.stateTo
end

return UIStateTransition
