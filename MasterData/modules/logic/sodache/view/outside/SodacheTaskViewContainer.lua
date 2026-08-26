-- chunkname: @modules/logic/sodache/view/outside/SodacheTaskViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheTaskViewContainer", package.seeall)

local SodacheTaskViewContainer = class("SodacheTaskViewContainer", BaseViewContainer)

function SodacheTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return SodacheTaskViewContainer
