-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionBase.lua

module("logic.extensions.task.model.actions.TActionBase", package.seeall)

local TActionBase = class("TActionBase")

function TActionBase:ctor(target)
	self.isRunning = nil
	self.target = target
end

function TActionBase:getActionType()
	return nil
end

function TActionBase:runAction()
	self.isRunning = true
end

function TActionBase:stopAction()
	self.isRunning = nil
end

function TActionBase:tick()
	return
end

function TActionBase:isFinished()
	return nil
end

function TActionBase:breakAction()
	self._isBreaked = true
end

function TActionBase:isBreaked()
	return self._isBreaked
end

return TActionBase
