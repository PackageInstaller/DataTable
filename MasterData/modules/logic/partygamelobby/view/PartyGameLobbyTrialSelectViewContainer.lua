-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyTrialSelectViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyTrialSelectViewContainer", package.seeall)

local PartyGameLobbyTrialSelectViewContainer = class("PartyGameLobbyTrialSelectViewContainer", BaseViewContainer)

function PartyGameLobbyTrialSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyTrialSelectView.New())

	return views
end

return PartyGameLobbyTrialSelectViewContainer
