-- chunkname: @modules/logic/main/controller/work/MainSignInWork.lua

module("modules.logic.main.controller.work.MainSignInWork", package.seeall)

local MainSignInWork = class("MainSignInWork", BaseWork)

local function _checkCanShow()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return false
	end

	if not GuideModel.instance:isGuideFinish(108) then
		return false
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return false
	end

	local date = SignInModel.instance:getCurDate()

	if SignInModel.instance:isSignDayRewardGet(date.day) then
		return false
	end

	return true
end

local function _isNeedWait()
	local mainViewguideBlock = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MainViewGuideBlock)

	if mainViewguideBlock then
		return true
	end

	local isInMainView = MainController.instance:isInMainView()

	return not isInMainView
end

function MainSignInWork:_isNeedWaitShow()
	self._isWaiting = _isNeedWait()

	return self._isWaiting
end

function MainSignInWork:onStart(context)
	self:clearWork()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:_tryStart()
end

function MainSignInWork:_tryStart()
	self:_endBlock()

	if not self:_isNeedWaitShow() then
		self:_startSignInWork()
	end
end

function MainSignInWork:_onOpenViewFinish(openingViewName)
	if self._isWaiting then
		local viewName = ViewName.MainView

		if openingViewName ~= viewName then
			return
		end

		self:_tryStart()
	elseif self._isShowingLifeCircle then
		local viewName = ViewName.LifeCircleRewardView

		if openingViewName ~= viewName then
			return
		end

		self:_endBlock()
	end
end

function MainSignInWork:_onCloseViewFinish(closingViewName)
	if self._isWaiting then
		self:_tryStart()
	elseif self._isShowingLifeCircle then
		local viewName = ViewName.LifeCircleRewardView

		if closingViewName ~= viewName then
			return
		end

		if ViewMgr.instance:isOpen(viewName) then
			return
		end

		self:_showSignInDetailView()
	end
end

function MainSignInWork:_startSignInWork()
	self:_startBlock()

	if not _checkCanShow() then
		self:onDone(true)

		return
	end

	if LifeCircleController.instance:isClaimableAccumulateReward() then
		self._isShowingLifeCircle = true

		LifeCircleController.instance:sendSignInTotalRewardAllRequest(function(_, resultCode)
			self:_endBlock()

			if resultCode ~= 0 then
				self:_showSignInDetailView()
			end
		end)

		return
	else
		self:_showSignInDetailView()
	end
end

function MainSignInWork:_showSignInDetailView()
	self._isShowingLifeCircle = false

	local date = SignInModel.instance:getCurDate()

	SignInModel.instance:setTargetDate(tonumber(date.year), tonumber(date.month), tonumber(date.day))

	local data = {
		callback = self._closeSignInViewFinished,
		callbackObj = self
	}

	ViewMgr.instance:openView(ViewName.SignInDetailView, data)
	self:_endBlock()
end

function MainSignInWork:_closeSignInViewFinished()
	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		self:onDone(true)
	else
		TaskDispatcher.cancelTask(self._onCheckEnterMainView, self)
		TaskDispatcher.runRepeat(self._onCheckEnterMainView, self, 0.5)
	end
end

function MainSignInWork:_onCheckEnterMainView()
	local isInMainView = MainController.instance:isInMainView()

	if not isInMainView then
		return
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		self:onDone(true)
	end
end

function MainSignInWork:clearWork()
	self._isWaiting = false
	self._isShowingLifeCircle = false

	TaskDispatcher.cancelTask(self._onCheckEnterMainView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:_endBlock()
end

function MainSignInWork:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function MainSignInWork:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function MainSignInWork:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

return MainSignInWork
