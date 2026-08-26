-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEnterScene.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEnterScene", package.seeall)

local GuideTriggerEnterScene = class("GuideTriggerEnterScene", BaseGuideTrigger)

function GuideTriggerEnterScene:ctor(triggerKey)
	GuideTriggerEnterScene.super.ctor(self, triggerKey)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
end

function GuideTriggerEnterScene:assertGuideSatisfy(param, configParam)
	local configSceneType = SceneType[configParam]

	return param == configSceneType
end

function GuideTriggerEnterScene:_onEnterOneSceneFinish(sceneType, sceneId)
	self:checkStartGuide(sceneType)
end

return GuideTriggerEnterScene
