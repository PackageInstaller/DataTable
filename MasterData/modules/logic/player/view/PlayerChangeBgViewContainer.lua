-- chunkname: @modules/logic/player/view/PlayerChangeBgViewContainer.lua

module("modules.logic.player.view.PlayerChangeBgViewContainer", package.seeall)

local PlayerChangeBgViewContainer = class("PlayerChangeBgViewContainer", BaseViewContainer)

function PlayerChangeBgViewContainer:buildViews()
	return {
		PlayerChangeBgView.New(),
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function PlayerChangeBgViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return PlayerChangeBgViewContainer
