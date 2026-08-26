-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartLayerViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerViewContainer", package.seeall)

local WeekWalk_2HeartLayerViewContainer = class("WeekWalk_2HeartLayerViewContainer", BaseViewContainer)

function WeekWalk_2HeartLayerViewContainer:buildViews()
	local views = {}

	table.insert(views, WeekWalk_2HeartLayerView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	self.helpView = HelpShowView.New()

	self.helpView:setHelpId(HelpEnum.HelpId.WeekWalk_2HeartLayerOnce)
	table.insert(views, self.helpView)

	return views
end

function WeekWalk_2HeartLayerViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.WeekWalk_2HeartLayer)

		return {
			self.navigateView
		}
	end
end

return WeekWalk_2HeartLayerViewContainer
