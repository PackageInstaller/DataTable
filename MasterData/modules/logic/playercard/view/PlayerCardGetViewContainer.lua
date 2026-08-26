-- chunkname: @modules/logic/playercard/view/PlayerCardGetViewContainer.lua

module("modules.logic.playercard.view.PlayerCardGetViewContainer", package.seeall)

local PlayerCardGetViewContainer = class("PlayerCardGetViewContainer", BaseViewContainer)

function PlayerCardGetViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardGetView.New())

	return views
end

return PlayerCardGetViewContainer
