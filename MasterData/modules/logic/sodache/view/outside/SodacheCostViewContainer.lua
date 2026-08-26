-- chunkname: @modules/logic/sodache/view/outside/SodacheCostViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheCostViewContainer", package.seeall)

local SodacheCostViewContainer = class("SodacheCostViewContainer", BaseViewContainer)

function SodacheCostViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheCostView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheCostViewContainer:buildTabViews(tabContainerId)
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

return SodacheCostViewContainer
