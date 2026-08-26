-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookMainViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookMainViewContainer", package.seeall)

local Rouge2_CareerHandBookMainViewContainer = class("Rouge2_CareerHandBookMainViewContainer", BaseViewContainer)

function Rouge2_CareerHandBookMainViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, Rouge2_CareerHandBookMainView.New())

	return views
end

function Rouge2_CareerHandBookMainViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_CareerHandBookMainViewContainer
