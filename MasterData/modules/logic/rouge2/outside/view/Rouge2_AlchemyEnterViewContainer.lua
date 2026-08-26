-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyEnterViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyEnterViewContainer", package.seeall)

local Rouge2_AlchemyEnterViewContainer = class("Rouge2_AlchemyEnterViewContainer", BaseViewContainer)

function Rouge2_AlchemyEnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_AlchemyEnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Rouge2_AlchemyEnterViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_AlchemyEnterViewContainer
