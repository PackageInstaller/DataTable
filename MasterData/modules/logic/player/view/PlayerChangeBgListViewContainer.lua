-- chunkname: @modules/logic/player/view/PlayerChangeBgListViewContainer.lua

module("modules.logic.player.view.PlayerChangeBgListViewContainer", package.seeall)

local PlayerChangeBgListViewContainer = class("PlayerChangeBgListViewContainer", BaseViewContainer)

function PlayerChangeBgListViewContainer:buildViews()
	return {
		PlayerChangeBgListView.New()
	}
end

return PlayerChangeBgListViewContainer
