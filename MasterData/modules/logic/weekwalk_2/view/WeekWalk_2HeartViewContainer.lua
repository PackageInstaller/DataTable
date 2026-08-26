-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartViewContainer", package.seeall)

local WeekWalk_2HeartViewContainer = class("WeekWalk_2HeartViewContainer", BaseViewContainer)

function WeekWalk_2HeartViewContainer:buildViews()
	local views = {}

	self._heartView = WeekWalk_2HeartView.New()

	table.insert(views, self._heartView)
	table.insert(views, WeekWalk_2Ending.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function WeekWalk_2HeartViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
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
end

function WeekWalk_2HeartViewContainer:_overrideClose()
	module_views_preloader.WeekWalk_2HeartLayerViewPreload(function()
		self._heartView._viewAnim:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(self._doClose, self, 0.133)
	end)
end

function WeekWalk_2HeartViewContainer:_doClose()
	if not ViewMgr.instance:isOpen(ViewName.WeekWalk_2HeartLayerView) then
		WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView({
			mapId = WeekWalk_2Model.instance:getCurMapId()
		})
	end

	self:closeThis()
end

function WeekWalk_2HeartViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self._doClose, self)
end

return WeekWalk_2HeartViewContainer
