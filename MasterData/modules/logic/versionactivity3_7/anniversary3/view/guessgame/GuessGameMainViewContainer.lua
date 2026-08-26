-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGameMainViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGameMainViewContainer", package.seeall)

local GuessGameMainViewContainer = class("GuessGameMainViewContainer", BaseViewContainer)

function GuessGameMainViewContainer:buildViews()
	local views = {}

	table.insert(views, GuessGameMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function GuessGameMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return GuessGameMainViewContainer
