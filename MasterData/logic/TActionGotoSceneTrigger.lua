-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionGotoSceneTrigger.lua

module("logic.extensions.task.model.actions.TActionGotoSceneTrigger", package.seeall)

local TActionGotoSceneTrigger = class("TActionGotoSceneTrigger", TActionBase)

function TActionGotoSceneTrigger:ctor(target)
	TActionGotoSceneTrigger.super.ctor(self, target)

	self._sceneId = target:getSceneId()
	self._triggerId = target:getTriggerId()
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	self._isFinished = nil
end

function TActionGotoSceneTrigger:getActionType()
	return TaskConst.GOTOSCENETRIGGER
end

function TActionGotoSceneTrigger:runAction()
	if not self.isRunning then
		self.isRunning = true

		local scene = SceneMgr.instance:getCurScene()

		if scene:getSceneId() ~= self._sceneId then
			self._gotoScene = TActionFactory.createTAction(TaskConst.GOTOSCENE, self.target, self._sceneId)

			self._gotoScene:runAction()
		else
			self:_goToTarget()
		end
	end
end

function TActionGotoSceneTrigger:tick()
	if self._gotoScene then
		if self._gotoScene:isBreaked() then
			self:breakAction()
		else
			self._gotoScene:tick()

			if self._gotoScene:isFinished() then
				self._gotoScene:stopAction()
				self:_goToTarget()

				self._gotoScene = nil
			end
		end
	end
end

function TActionGotoSceneTrigger:isFinished()
	return self._isFinished
end

function TActionGotoSceneTrigger:stopAction()
	if self.isRunning then
		self.isRunning = nil

		if self._gotoTrigger ~= nil and self._gotoTrigger.isRunning then
			self._gotoTrigger.onStoped = nil
			self._gotoTrigger.onStopedObj = nil

			self._mainPlayer:stopAction(self._gotoTrigger)

			self._gotoTrigger = nil
		end

		if self._gotoScene then
			self._gotoScene:stopAction()

			self._gotoScene = nil
		end
	end

	self._isFinished = nil
end

function TActionGotoSceneTrigger:_goToTarget()
	if self._mainPlayer.triggerId == self._triggerId then
		self._isFinished = true

		GlobalDispatcher:dispatch(GlobalNotify.EnterSceneTrigger, self._sceneId, self._triggerId)
	else
		self._gotoTrigger = self._mainPlayer:gotoTrigger(self._triggerId, self._onMoveToTriggerFinish, self)
		self._gotoTrigger.onStoped = self.breakAction
		self._gotoTrigger.onStopedObj = self
	end
end

function TActionGotoSceneTrigger:_onMoveToTriggerFinish()
	self._isFinished = true
end

return TActionGotoSceneTrigger
