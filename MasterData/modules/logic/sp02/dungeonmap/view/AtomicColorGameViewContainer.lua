-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicColorGameViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicColorGameViewContainer", package.seeall)

local AtomicColorGameViewContainer = class("AtomicColorGameViewContainer", BaseViewContainer)

function AtomicColorGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicColorGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function AtomicColorGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.AtomicColorGame)

		return {
			self.navigateView
		}
	end
end

return AtomicColorGameViewContainer
