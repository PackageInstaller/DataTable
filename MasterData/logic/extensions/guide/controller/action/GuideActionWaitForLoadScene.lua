-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionWaitForLoadScene.lua

module("logic.extensions.guide.controller.action.GuideActionWaitForLoadScene", package.seeall)

local M = class("GuideActionWaitForLoadScene", BaseGuideAction)

function M:ctor(guideId, stepId, guideStepCO)
	M.super.ctor(self, guideId, stepId, guideStepCO)

	self._targetSceneId = guideStepCO.guideControlParam
end

function M:onEnter(context)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:close(ViewName.GuideView)
	end

	if ViewMgr.instance:isOpen(ViewName.ImageGuide) then
		ViewMgr.instance:close(ViewName.ImageGuide)
	end

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Guide)
	GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onEnterSceneFinish, self)
	M.super.onEnter(self, context)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onEnterSceneFinish, self)
	M.super.onExit(self)
end

function M:_onEnterSceneFinish(key, sceneType, sceneId)
	if string.nilorempty(self._targetSceneId) then
		return
	end

	if tonumber(self._targetSceneId) == sceneId then
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)

		self._targetSceneId = false

		self:onDone(WorkResult.Succeed)
	end
end

return M
