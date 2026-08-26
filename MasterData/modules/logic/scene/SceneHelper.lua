-- chunkname: @modules/logic/scene/SceneHelper.lua

module("modules.logic.scene.SceneHelper", package.seeall)

local SceneHelper = class("SceneHelper")

function SceneHelper:waitSceneDone(sceneType, callback, callbackObj, param)
	self.currSceneType = sceneType
	self.callback = callback
	self.callbackObj = callbackObj
	self.param = param

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self.onEnterSceneFinish, self)
	TaskDispatcher.runDelay(self._overtime, self, 10)
end

function SceneHelper:onEnterSceneFinish(sceneType)
	if sceneType ~= self.currSceneType then
		return
	end

	self:clearWork()

	if self.callback then
		self.callback(self.callbackObj, self.param)
	end
end

function SceneHelper:_overtime()
	logError("等待加载场景超时了.. " .. tostring(self.currSceneType))
	self:clearWork()

	if self.callback then
		self.callback(self.callbackObj, self.param)
	end
end

function SceneHelper:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self.onEnterSceneFinish, self)
	TaskDispatcher.cancelTask(self._overtime, self)
end

SceneHelper.instance = SceneHelper.New()

return SceneHelper
