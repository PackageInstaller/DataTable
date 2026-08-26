-- chunkname: @modules/logic/player/view/PlayerModifyNameViewContainer.lua

module("modules.logic.player.view.PlayerModifyNameViewContainer", package.seeall)

local PlayerModifyNameViewContainer = class("PlayerModifyNameViewContainer", BaseViewContainer)

function PlayerModifyNameViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerModifyNameView.New())

	return views
end

return PlayerModifyNameViewContainer
