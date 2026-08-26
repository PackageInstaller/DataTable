-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackBoxTipsViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackBoxTipsViewContainer", package.seeall)

local Rouge2_BackpackBoxTipsViewContainer = class("Rouge2_BackpackBoxTipsViewContainer", BaseViewContainer)

function Rouge2_BackpackBoxTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BackpackBoxTipsView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_BackpackBoxTipsViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigationView = NavigateButtonsView.New({
			false,
			false,
			true
		})

		navigationView:setOverrideHelp(self.overrideHelpBtn, self)

		return {
			navigationView
		}
	end
end

function Rouge2_BackpackBoxTipsViewContainer:overrideHelpBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BackpackBoxTips)
end

return Rouge2_BackpackBoxTipsViewContainer
