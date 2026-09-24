-- chunkname: @modules/logic/college/view/common/CollegeStatIdleTimeView.lua

module("modules.logic.college.view.common.CollegeStatIdleTimeView", package.seeall)

local CollegeStatIdleTimeView = class("CollegeStatIdleTimeView", BaseView)

function CollegeStatIdleTimeView:ctor(statName)
	self.statName = statName
end

function CollegeStatIdleTimeView:addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onViewStatChange, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onViewStatChange, self)
	self.viewContainer:registerCallback(CollegeEvent.OnViewStat, self.customStat, self)
	self.viewContainer:registerCallback(CollegeEvent.SetViewStatName, self.setStatName, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnViewVisibleChange, self.onViewStatChange, self)
end

function CollegeStatIdleTimeView:removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onViewStatChange, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onViewStatChange, self)
	self.viewContainer:unregisterCallback(CollegeEvent.OnViewStat, self.customStat, self)
	self.viewContainer:unregisterCallback(CollegeEvent.SetViewStatName, self.setStatName, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnViewVisibleChange, self.onViewStatChange, self)
end

function CollegeStatIdleTimeView:onOpen()
	self.isTop = false
	self.isHasVisibleView = false

	for i, v in ipairs(self.viewContainer._views) do
		if v and v.class == CollegeVisibleBaseView then
			self.isHasVisibleView = true

			break
		end
	end

	self:onViewStatChange()
end

function CollegeStatIdleTimeView:onViewStatChange()
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.CollegeToastView,
		ViewName.CollegeCurrencyTipsView,
		ViewName.ToastView,
		ViewName.GMToolView,
		ViewName.GMToolView2,
		ViewName.MessageBoxView,
		ViewName.TopMessageBoxView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	if isTop and self.isHasVisibleView then
		isTop = CollegeModel.instance:isViewVisible(self.viewName)
	end

	if isTop ~= self.isTop then
		self.isTop = isTop

		if isTop then
			self.beginDt = ServerTime.now()
		elseif self.beginDt then
			self:_doStat()
		end
	end
end

function CollegeStatIdleTimeView:customStat()
	if not self.isTop then
		return
	end

	self:_doStat()

	self.beginDt = ServerTime.now()
end

function CollegeStatIdleTimeView:setStatName(statName)
	self.statName = statName

	if not self.statName then
		self.beginDt = nil
	else
		self.beginDt = ServerTime.now()
	end
end

function CollegeStatIdleTimeView:_doStat()
	if not self.beginDt or not self.statName then
		return
	end

	CollegeStatHelper.instance:statViewClose(self.statName, self.beginDt)

	self.beginDt = nil
end

function CollegeStatIdleTimeView:onClose()
	self:_doStat()
end

return CollegeStatIdleTimeView
