-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_EnterViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_EnterViewContainer", package.seeall)

local Rouge2_EnterViewContainer = class("Rouge2_EnterViewContainer", BaseViewContainer)

function Rouge2_EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_EnterView.New())
	table.insert(views, Rouge2_EnterScene.New())
	table.insert(views, Rouge2_EnterCamera.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Rouge2_EnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self.navigateView:setOverrideHelp(self.onHelpClick, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_EnterViewContainer:onHelpClick()
	Rouge2_Controller.instance:openTechniqueView()
end

return Rouge2_EnterViewContainer
