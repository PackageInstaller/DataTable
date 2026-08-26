-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyAddRoomViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyAddRoomViewContainer", package.seeall)

local PartyGameLobbyAddRoomViewContainer = class("PartyGameLobbyAddRoomViewContainer", BaseViewContainer)

function PartyGameLobbyAddRoomViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyAddRoomView.New())

	return views
end

return PartyGameLobbyAddRoomViewContainer
