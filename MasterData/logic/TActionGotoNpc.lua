-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionGotoNpc.lua

module("logic.extensions.task.model.actions.TActionGotoNpc", package.seeall)

local TActionGotoNpc = class("TActionGotoNpc", TActionBase)

function TActionGotoNpc:ctor(target, npcId)
	TActionGotoNpc.super.ctor(self, target)

	self._npcId = npcId
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	self._isFinished = nil
end

function TActionGotoNpc:getActionType()
	return TaskConst.GOTONPC
end

function TActionGotoNpc:runAction()
	if not self.isRunning then
		self.isRunning = true

		local scene = SceneMgr.instance:getCurScene()
		local npcCo = SceneConfig.instance:getNpcCo(self._npcId)

		if npcCo and (scene:getSceneId() ~= npcCo.sceneId or not scene.isReady) then
			self._gotoScene = TActionFactory.createTAction(TaskConst.GOTOSCENE, self.target, npcCo.sceneId)

			self._gotoScene:runAction()
		else
			self:_goToTarget()
		end
	end
end

function TActionGotoNpc:tick()
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

function TActionGotoNpc:isFinished()
	return self._isFinished
end

function TActionGotoNpc:stopAction()
	if self.isRunning then
		self.isRunning = nil

		if self._gotoScene then
			self._gotoScene:stopAction()

			self._gotoScene = nil
		end

		self._isFinished = nil
	end

	if self._gotoNpc ~= nil and self._gotoNpc.isRunning then
		self._gotoNpc.onStoped = nil
		self._gotoNpc.onStopedObj = nil

		self._mainPlayer:stopAction(self._gotoNpc)

		self._gotoNpc = nil
	end
end

function TActionGotoNpc:_goToTarget()
	self._gotoNpc = self._mainPlayer:gotoNpc(self._npcId, self._onMoveToNpcFinish, self)

	if self._gotoNpc then
		self._gotoNpc.onStoped = self.breakAction
		self._gotoNpc.onStopedObj = self
	else
		self._isFinished = true
	end
end

function TActionGotoNpc:_onMoveToNpcFinish()
	self._isFinished = true
end

return TActionGotoNpc
