-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMembersViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyMembersViewContainer", package.seeall)

local OdysseyMembersViewContainer = class("OdysseyMembersViewContainer", BaseViewContainer)

function OdysseyMembersViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyMembersView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function OdysseyMembersViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.OdysseyReligion)

		return {
			self.navigateView
		}
	end
end

return OdysseyMembersViewContainer
