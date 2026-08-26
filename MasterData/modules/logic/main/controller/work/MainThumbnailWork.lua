-- chunkname: @modules/logic/main/controller/work/MainThumbnailWork.lua

module("modules.logic.main.controller.work.MainThumbnailWork", package.seeall)

local MainThumbnailWork = class("MainThumbnailWork", BaseWork)

function MainThumbnailWork._checkShow()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.MainThumbnail) then
		return false
	end

	if PlayerModel.instance:getMainThumbnail() then
		return false
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return false
	end

	return true
end

function MainThumbnailWork:onStart(context)
	if not MainThumbnailWork._checkShow() then
		self:onDone(true)

		return
	end

	if ViewMgr.instance:isOpenFinish(ViewName.MainView) then
		self:_startMainThumbnailView()

		return
	end

	TaskDispatcher.cancelTask(self._overtimeHandler, self)
	TaskDispatcher.runDelay(self._overtimeHandler, self, 3)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinsh, self)
end

function MainThumbnailWork:_overtimeHandler()
	self:_startMainThumbnailView()
end

function MainThumbnailWork:_onOpenViewFinsh(viewName)
	if viewName == ViewName.MainView then
		self:_startMainThumbnailView()
	end
end

function MainThumbnailWork:_startMainThumbnailView()
	TaskDispatcher.cancelTask(self._overtimeHandler, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinsh, self)
	MainController.instance:dispatchEvent(MainEvent.OnShowMainThumbnailView)
	MainController.instance:registerCallback(MainEvent.OnMainThumbnailGreetingFinish, self._onMainThumbnailGreetingFinish, self)
	MainController.instance:openMainThumbnailView({
		needPlayGreeting = true
	})
end

function MainThumbnailWork:_onMainThumbnailGreetingFinish()
	self:onDone(true)
end

function MainThumbnailWork:clearWork()
	TaskDispatcher.cancelTask(self._overtimeHandler, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinsh, self)
	MainController.instance:unregisterCallback(MainEvent.OnMainThumbnailGreetingFinish, self._onMainThumbnailGreetingFinish, self)
end

return MainThumbnailWork
