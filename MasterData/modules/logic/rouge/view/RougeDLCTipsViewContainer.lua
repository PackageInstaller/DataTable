-- chunkname: @modules/logic/rouge/view/RougeDLCTipsViewContainer.lua

module("modules.logic.rouge.view.RougeDLCTipsViewContainer", package.seeall)

local RougeDLCTipsViewContainer = class("RougeDLCTipsViewContainer", BaseViewContainer)

function RougeDLCTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeDLCTipsView.New())
	table.insert(views, TabViewGroup.New(1, "#go_root/#go_topleft"))

	return views
end

function RougeDLCTipsViewContainer:buildTabViews(tabContainerId)
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

return RougeDLCTipsViewContainer
