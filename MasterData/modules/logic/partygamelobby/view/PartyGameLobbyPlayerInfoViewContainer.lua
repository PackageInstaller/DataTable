-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyPlayerInfoViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyPlayerInfoViewContainer", package.seeall)

local PartyGameLobbyPlayerInfoViewContainer = class("PartyGameLobbyPlayerInfoViewContainer", BaseViewContainer)

function PartyGameLobbyPlayerInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyPlayerInfoView.New())

	return views
end

function PartyGameLobbyPlayerInfoViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return PartyGameLobbyPlayerInfoViewContainer
