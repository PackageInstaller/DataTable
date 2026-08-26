-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicLineGameViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicLineGameViewContainer", package.seeall)

local AtomicLineGameViewContainer = class("AtomicLineGameViewContainer", BaseViewContainer)

function AtomicLineGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicLineGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AtomicLineGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.AtomicLineGame)

		return {
			self.navigateView
		}
	end
end

return AtomicLineGameViewContainer
