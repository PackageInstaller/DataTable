-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_TalentTreeViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_TalentTreeViewContainer", package.seeall)

local Rouge2_TalentTreeViewContainer = class("Rouge2_TalentTreeViewContainer", BaseViewContainer)

function Rouge2_TalentTreeViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_TalentTreeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_TalentTreeViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_TalentTreeViewContainer
