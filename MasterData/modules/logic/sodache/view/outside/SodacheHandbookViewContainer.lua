-- chunkname: @modules/logic/sodache/view/outside/SodacheHandbookViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheHandbookViewContainer", package.seeall)

local SodacheHandbookViewContainer = class("SodacheHandbookViewContainer", BaseViewContainer)

function SodacheHandbookViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheHandbookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheHandbookViewContainer:buildTabViews(tabContainerId)
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

return SodacheHandbookViewContainer
