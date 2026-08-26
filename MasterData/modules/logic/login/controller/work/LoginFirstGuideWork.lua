-- chunkname: @modules/logic/login/controller/work/LoginFirstGuideWork.lua

module("modules.logic.login.controller.work.LoginFirstGuideWork", package.seeall)

local LoginFirstGuideWork = class("LoginFirstGuideWork", BaseWork)

function LoginFirstGuideWork:onStart(context)
	if GuideController.instance:isForbidGuides() then
		self:onDone(true)
	elseif GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		self:onDone(true)
	else
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._enterSceneFinish, self)
		GameSceneMgr.instance:startScene(SceneType.Newbie, 101, 10101)
	end
end

function LoginFirstGuideWork:_enterSceneFinish(sceneType, sceneId)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)

	if GuideModel.instance:isDoingFirstGuide() and not GuideController.instance:isForbidGuides() then
		GameSceneMgr.instance:registerCallback(SceneEventName.WaitCloseHeadsetView, self._startFirstGuide, self)
	else
		self:_startFirstGuide()
	end
end

function LoginFirstGuideWork:_startFirstGuide()
	local firstGuideCO = GuideConfig.instance:getGuideCO(GuideController.FirstGuideId)

	GuideController.instance:checkStartFirstGuide()
end

function LoginFirstGuideWork:_onFinishGuide(guideId)
	if guideId == GuideController.FirstGuideId then
		self:onDone(true)
	end
end

function LoginFirstGuideWork:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.WaitCloseHeadsetView, self._startFirstGuide, self)
end

function LoginFirstGuideWork:_removeEvents()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._enterSceneFinish, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.WaitCloseHeadsetView, self._startFirstGuide, self)
end

return LoginFirstGuideWork
