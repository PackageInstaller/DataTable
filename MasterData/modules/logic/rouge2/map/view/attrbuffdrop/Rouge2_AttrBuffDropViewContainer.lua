-- chunkname: @modules/logic/rouge2/map/view/attrbuffdrop/Rouge2_AttrBuffDropViewContainer.lua

module("modules.logic.rouge2.map.view.attrbuffdrop.Rouge2_AttrBuffDropViewContainer", package.seeall)

local Rouge2_AttrBuffDropViewContainer = class("Rouge2_AttrBuffDropViewContainer", BaseViewContainer)

function Rouge2_AttrBuffDropViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_AttrBuffDropView.New())
	table.insert(views, Rouge2_AttrBuffDropFrontView.New())
	table.insert(views, TabViewGroup.New(1, "#go_Info/#go_topleft"))

	return views
end

function Rouge2_AttrBuffDropViewContainer:buildTabViews(tabContainerId)
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

function Rouge2_AttrBuffDropViewContainer:overrideHelpBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.AttrDrop)
end

return Rouge2_AttrBuffDropViewContainer
