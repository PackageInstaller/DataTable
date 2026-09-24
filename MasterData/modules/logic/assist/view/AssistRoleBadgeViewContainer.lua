-- chunkname: @modules/logic/assist/view/AssistRoleBadgeViewContainer.lua

module("modules.logic.assist.view.AssistRoleBadgeViewContainer", package.seeall)

local AssistRoleBadgeViewContainer = class("AssistRoleBadgeViewContainer", BaseViewContainer)

function AssistRoleBadgeViewContainer:buildViews()
	local views = {}

	table.insert(views, AssistRoleBadgeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AssistRoleBadgeViewContainer:buildTabViews(tabContainerId)
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

return AssistRoleBadgeViewContainer
