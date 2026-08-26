-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTalentTreeViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyTalentTreeViewContainer", package.seeall)

local OdysseyTalentTreeViewContainer = class("OdysseyTalentTreeViewContainer", BaseViewContainer)

function OdysseyTalentTreeViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyTalentTreeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function OdysseyTalentTreeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.OdysseyTalentTree)

		return {
			self.navigateView
		}
	end
end

return OdysseyTalentTreeViewContainer
