-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionGoto.lua

module("logic.extensions.task.model.actions.TActionGoto", package.seeall)

local TActionGoto = class("TActionGoto", TActionBase)

function TActionGoto:ctor(target, x, y)
	TActionGoto.super.ctor(self, target)

	self._x = x
	self._z = y
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	self._isEnded = nil
end

function TActionGoto:runAction()
	if not self.isRunning then
		self._isEnded = nil
		self.isRunning = true
		self._gotoPath = self._mainPlayer:runPath(self._x, self._y, self._onMoveToFinish, self)
		self._gotoPath.onStoped = self.breakAction
		self._gotoPath.onStopedObj = self
	end
end

function TActionGoto:getActionType()
	return TaskConst.GOTO
end

function TActionGoto:isFinished()
	if self._isEnded then
		return true
	end

	return nil
end

function TActionGoto:stopAction()
	if self.isRunning then
		self.isRunning = nil
	end

	if self._gotoPath ~= nil and self._gotoPath.isRunning then
		self._gotoPath.onStoped = nil
		self._gotoPath.onStopedObj = nil

		self._mainPlayer:stopAction(self._gotoPath)

		self._gotoPath = nil
	end
end

function TActionGoto:_onMoveToFinish()
	self._isEnded = true
end

return TActionGoto
