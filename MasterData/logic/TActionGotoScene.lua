-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionGotoScene.lua

module("logic.extensions.task.model.actions.TActionGotoScene", package.seeall)

local TActionGotoScene = class("TActionGotoScene", TActionBase)

function TActionGotoScene:ctor(target, sceneId)
	TActionGotoScene.super.ctor(self, target)

	self._sceneId = sceneId
	self._isFinished = nil
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
end

function TActionGotoScene:getActionType()
	return TaskConst.GOTOSCENE
end

function TActionGotoScene:runAction()
	self.isRunning = true

	if self._mainPlayer.transmitPoint == self._sceneId and not UnlockFacade.instance:checkSceneUnLock(self._sceneId) then
		self._isBreaked = true

		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene:getSceneId() ~= self._sceneId then
		self._gotoScene = self._mainPlayer:gotoScene(self._sceneId)
		self._gotoScene.onStoped = self.breakAction
		self._gotoScene.onStopedObj = self
	end
end

function TActionGotoScene:tick()
	if self._gotoScene and self._gotoScene:isDone() and (self._gotoScene:isInvalid() or not UnlockFacade.instance:isSceneUnLock(self._sceneId)) then
		self._isBreaked = true
	end
end

function TActionGotoScene:stopAction()
	self.isRunning = nil

	if self._gotoScene ~= nil and self._gotoScene.isRunning then
		self._gotoScene.onStoped = nil
		self._gotoScene.onStopedObj = nil

		self._mainPlayer:stopAction(self._gotoScene)

		self._gotoScene = nil
	end

	self._mainPlayer = nil
	self._isFinished = nil
end

function TActionGotoScene:isFinished()
	local scene = SceneMgr.instance:getCurScene()

	return scene:getSceneId() == self._sceneId and scene.isReady
end

function TActionGotoScene:breakAction()
	if not self._mainPlayer then
		return
	end

	if not self._mainPlayer.transmitPoint or not UnlockFacade.instance:isSceneUnLock(self._sceneId) then
		self._isBreaked = true
	end
end

return TActionGotoScene
