-- chunkname: @modules/logic/udimo/view/UdimoChangeBgViewContainer.lua

module("modules.logic.udimo.view.UdimoChangeBgViewContainer", package.seeall)

local UdimoChangeBgViewContainer = class("UdimoChangeBgViewContainer", BaseViewContainer)

function UdimoChangeBgViewContainer:buildViews()
	local views = {}

	table.insert(views, UdimoChangeBgView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function UdimoChangeBgViewContainer:buildTabViews(tabContainerId)
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

return UdimoChangeBgViewContainer
