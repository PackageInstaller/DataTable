-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186ViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186ViewContainer", package.seeall)

local Activity186ViewContainer = class("Activity186ViewContainer", BaseViewContainer)

function Activity186ViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity186View.New())
	table.insert(views, Activity186HeroView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity186ViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Activity186ViewContainer
