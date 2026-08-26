-- chunkname: @modules/logic/player/view/PlayerClothGuideViewContainer.lua

module("modules.logic.player.view.PlayerClothGuideViewContainer", package.seeall)

local PlayerClothGuideViewContainer = class("PlayerClothGuideViewContainer", BaseViewContainer)

function PlayerClothGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerClothGuideView.New())

	return views
end

return PlayerClothGuideViewContainer
