-- chunkname: @modules/logic/survival/controller/work/SurvivalWaitSceneFinishWork.lua

module("modules.logic.survival.controller.work.SurvivalWaitSceneFinishWork", package.seeall)

local SurvivalWaitSceneFinishWork = class("SurvivalWaitSceneFinishWork", BaseWork)

function SurvivalWaitSceneFinishWork:onStart(context)
	if self.context.fastExecute then
		self:onDone(true)

		return
	end

	TaskDispatcher.runDelay(self._delayCheckIsLoadingScene, self, 1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
end

function SurvivalWaitSceneFinishWork:_delayCheckIsLoadingScene()
	if not GameSceneMgr.instance:isLoading() then
		self:waitLoadingFinish()
	end
end

function SurvivalWaitSceneFinishWork:_onEnterOneSceneFinish()
	self:waitLoadingFinish()
end

function SurvivalWaitSceneFinishWork:waitLoadingFinish()
	if ViewMgr.instance:isOpen(ViewName.SurvivalLoadingView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	else
		self:onDone(true)
	end
end

function SurvivalWaitSceneFinishWork:_onCloseViewFinish(viewName)
	if viewName == ViewName.SurvivalLoadingView then
		TaskDispatcher.runDelay(self._delayOnDone, self, 0)
	end
end

function SurvivalWaitSceneFinishWork:_delayOnDone()
	self:onDone(true)
end

function SurvivalWaitSceneFinishWork:clearWork()
	TaskDispatcher.cancelTask(self._delayOnDone, self)
	TaskDispatcher.cancelTask(self._delayCheckIsLoadingScene, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
end

return SurvivalWaitSceneFinishWork
