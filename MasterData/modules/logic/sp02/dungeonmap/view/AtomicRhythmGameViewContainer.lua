-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicRhythmGameViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicRhythmGameViewContainer", package.seeall)

local AtomicRhythmGameViewContainer = class("AtomicRhythmGameViewContainer", BaseViewContainer)

function AtomicRhythmGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicRhythmGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function AtomicRhythmGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.AtomicRhythmGame)

		return {
			self.navigateView
		}
	end
end

return AtomicRhythmGameViewContainer
