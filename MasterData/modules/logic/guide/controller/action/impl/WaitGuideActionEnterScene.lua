-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEnterScene.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterScene", package.seeall)

local WaitGuideActionEnterScene = class("WaitGuideActionEnterScene", BaseGuideAction)

function WaitGuideActionEnterScene:onStart(context)
	WaitGuideActionEnterScene.super.onStart(self, context)

	self._sceneType = SceneType[self.actionParam]

	if GameSceneMgr.instance:getCurSceneType() == self._sceneType and not GameSceneMgr.instance:isLoading() then
		self:onDone(true)
	else
		GameSceneMgr.instance:registerCallback(self._sceneType, self._onEnterScene, self)
	end
end

function WaitGuideActionEnterScene:_onEnterScene(sceneId, enterOrExit)
	if enterOrExit == 1 then
		GameSceneMgr.instance:unregisterCallback(self._sceneType, self._onEnterScene, self)
		self:onDone(true)
	end
end

function WaitGuideActionEnterScene:clearWork()
	GameSceneMgr.instance:unregisterCallback(self._sceneType, self._onEnterScene, self)
end

return WaitGuideActionEnterScene
