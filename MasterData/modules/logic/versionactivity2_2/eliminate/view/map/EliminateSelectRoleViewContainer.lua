-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateSelectRoleViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectRoleViewContainer", package.seeall)

local EliminateSelectRoleViewContainer = class("EliminateSelectRoleViewContainer", BaseViewContainer)

function EliminateSelectRoleViewContainer:buildViews()
	local views = {}

	table.insert(views, EliminateSelectRoleView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function EliminateSelectRoleViewContainer:buildTabViews(tabContainerId)
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

return EliminateSelectRoleViewContainer
