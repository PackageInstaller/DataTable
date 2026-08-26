-- chunkname: @modules/logic/weekwalk/view/WeekWalkViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkViewContainer", package.seeall)

local WeekWalkViewContainer = class("WeekWalkViewContainer", BaseViewContainer)

function WeekWalkViewContainer:buildViews()
	local views = {}

	self._weekWalkView = WeekWalkView.New()
	self._weekWalkMapView = WeekWalkMap.New()

	table.insert(views, self._weekWalkMapView)
	table.insert(views, self._weekWalkView)
	table.insert(views, WeekWalkEnding.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function WeekWalkViewContainer:getWeekWalkMap()
	return self._weekWalkMapView
end

function WeekWalkViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.WeekWalk)

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)

	return {
		self._navigateButtonView
	}
end

function WeekWalkViewContainer:getNavBtnView()
	return self._navigateButtonView
end

function WeekWalkViewContainer:_overrideClose()
	module_views_preloader.WeekWalkLayerViewPreload(function()
		self._weekWalkView._viewAnim:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(self._doClose, self, 0.133)
	end)
end

function WeekWalkViewContainer:_doClose()
	self:closeThis()

	if not ViewMgr.instance:isOpen(ViewName.WeekWalkLayerView) then
		WeekWalkController.instance:openWeekWalkLayerView({
			mapId = WeekWalkModel.instance:getCurMapId()
		})
	end
end

function WeekWalkViewContainer:onContainerInit()
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._navigateButtonView.refreshUI, self._navigateButtonView)
end

function WeekWalkViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

function WeekWalkViewContainer:onContainerDestroy()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._navigateButtonView.refreshUI, self._navigateButtonView)
	TaskDispatcher.cancelTask(self._doClose, self)
end

return WeekWalkViewContainer
