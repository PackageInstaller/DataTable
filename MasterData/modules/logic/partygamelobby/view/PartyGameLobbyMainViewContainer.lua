-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyMainViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyMainViewContainer", package.seeall)

local PartyGameLobbyMainViewContainer = class("PartyGameLobbyMainViewContainer", BaseViewContainer)

function PartyGameLobbyMainViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyPlayerListView.New())
	table.insert(views, PartyGameLobbyMainView.New())
	table.insert(views, PartyGameLobbyBuildingListView.New())
	table.insert(views, PartyGameLobbyEmojiView.New())

	return views
end

return PartyGameLobbyMainViewContainer
