-- chunkname: @modules/logic/sodache/view/inside/SodacheShopViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheShopViewContainer", package.seeall)

local SodacheShopViewContainer = class("SodacheShopViewContainer", BaseViewContainer)

function SodacheShopViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheShopView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheShopViewContainer:buildTabViews(tabContainerId)
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

return SodacheShopViewContainer
