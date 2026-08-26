-- chunkname: @modules/logic/sodache/view/outside/SodacheLevelViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheLevelViewContainer", package.seeall)

local SodacheLevelViewContainer = class("SodacheLevelViewContainer", BaseViewContainer)

function SodacheLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheLevelViewContainer:buildTabViews(tabContainerId)
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

return SodacheLevelViewContainer
