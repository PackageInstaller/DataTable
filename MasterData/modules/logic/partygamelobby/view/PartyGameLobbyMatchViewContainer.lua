-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyMatchViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyMatchViewContainer", package.seeall)

local PartyGameLobbyMatchViewContainer = class("PartyGameLobbyMatchViewContainer", BaseViewContainer)

function PartyGameLobbyMatchViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyMatchView.New())

	return views
end

return PartyGameLobbyMatchViewContainer
