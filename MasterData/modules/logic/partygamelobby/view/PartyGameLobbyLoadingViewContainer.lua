-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyLoadingViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyLoadingViewContainer", package.seeall)

local PartyGameLobbyLoadingViewContainer = class("PartyGameLobbyLoadingViewContainer", BaseViewContainer)

function PartyGameLobbyLoadingViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyLoadingView.New())

	return views
end

return PartyGameLobbyLoadingViewContainer
