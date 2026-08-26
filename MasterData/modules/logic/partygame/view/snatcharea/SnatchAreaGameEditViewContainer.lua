-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGameEditViewContainer.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGameEditViewContainer", package.seeall)

local SnatchAreaGameEditViewContainer = class("SnatchAreaGameEditViewContainer", BaseViewContainer)

function SnatchAreaGameEditViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/left/top_left"),
		SnatchAreaEditGameView.New()
	}
end

function SnatchAreaGameEditViewContainer:buildTabViews(tabContainerId)
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

return SnatchAreaGameEditViewContainer
