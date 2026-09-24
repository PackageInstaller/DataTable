-- chunkname: @modules/logic/matchgame/outside/enter/MatchGameEnterViewContainer.lua

module("modules.logic.matchgame.outside.enter.MatchGameEnterViewContainer", package.seeall)

local MatchGameEnterViewContainer = class("MatchGameEnterViewContainer", BaseViewContainer)

function MatchGameEnterViewContainer:buildViews()
	return {
		MatchGameEnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function MatchGameEnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return MatchGameEnterViewContainer
