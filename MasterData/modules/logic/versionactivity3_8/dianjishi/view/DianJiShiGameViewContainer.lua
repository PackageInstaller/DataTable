-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameViewContainer.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameViewContainer", package.seeall)

local DianJiShiGameViewContainer = class("DianJiShiGameViewContainer", BaseViewContainer)

function DianJiShiGameViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, DianJiShiGameView.New())
	table.insert(views, DianJiShiGameGuideView.New())

	return views
end

function DianJiShiGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function DianJiShiGameViewContainer:getNavigateButtonView()
	return self._navigateButtonsView
end

return DianJiShiGameViewContainer
