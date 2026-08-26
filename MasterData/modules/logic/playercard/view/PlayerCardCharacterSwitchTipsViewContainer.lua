-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterSwitchTipsViewContainer.lua

module("modules.logic.playercard.view.PlayerCardCharacterSwitchTipsViewContainer", package.seeall)

local PlayerCardCharacterSwitchTipsViewContainer = class("PlayerCardCharacterSwitchTipsViewContainer", BaseViewContainer)

function PlayerCardCharacterSwitchTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardCharacterSwitchTipsView.New())

	return views
end

return PlayerCardCharacterSwitchTipsViewContainer
