-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMythViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyMythViewContainer", package.seeall)

local OdysseyMythViewContainer = class("OdysseyMythViewContainer", BaseViewContainer)

function OdysseyMythViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyMythView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function OdysseyMythViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.OdysseyMyth)

		return {
			self.navigateView
		}
	end
end

return OdysseyMythViewContainer
