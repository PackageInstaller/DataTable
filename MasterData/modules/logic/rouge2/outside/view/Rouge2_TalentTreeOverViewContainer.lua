-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_TalentTreeOverViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_TalentTreeOverViewContainer", package.seeall)

local Rouge2_TalentTreeOverViewContainer = class("Rouge2_TalentTreeOverViewContainer", BaseViewContainer)

function Rouge2_TalentTreeOverViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_TalentTreeOverView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_TalentTreeOverViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_TalentTreeOverViewContainer
