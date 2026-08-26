-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterViewContainer.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterViewContainer", package.seeall)

local RougeLimiterViewContainer = class("RougeLimiterViewContainer", BaseViewContainer)

function RougeLimiterViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeLimiterView.New())
	table.insert(views, RougeLimiterDebuffTipsView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))
	table.insert(views, RougeLimiterViewEmblemComp.New("#go_RightTop"))

	return views
end

function RougeLimiterViewContainer:buildTabViews(tabContainerId)
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

return RougeLimiterViewContainer
