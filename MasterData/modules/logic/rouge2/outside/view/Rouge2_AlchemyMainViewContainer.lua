-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyMainViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyMainViewContainer", package.seeall)

local Rouge2_AlchemyMainViewContainer = class("Rouge2_AlchemyMainViewContainer", BaseViewContainer)

function Rouge2_AlchemyMainViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_AlchemyMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Rouge2_AlchemyMainViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_AlchemyMainViewContainer
