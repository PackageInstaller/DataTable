-- chunkname: @modules/logic/playercard/view/PlayerCardBadgeGetViewContainer.lua

module("modules.logic.playercard.view.PlayerCardBadgeGetViewContainer", package.seeall)

local PlayerCardBadgeGetViewContainer = class("PlayerCardBadgeGetViewContainer", BaseViewContainer)

function PlayerCardBadgeGetViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardBadgeGetView.New())

	return views
end

return PlayerCardBadgeGetViewContainer
