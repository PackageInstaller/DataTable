-- chunkname: @modules/logic/sodache/view/outside/SodacheRelicOverViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheRelicOverViewContainer", package.seeall)

local SodacheRelicOverViewContainer = class("SodacheRelicOverViewContainer", BaseViewContainer)

function SodacheRelicOverViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheRelicOverView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheRelicOverViewContainer:buildTabViews(tabContainerId)
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

return SodacheRelicOverViewContainer
