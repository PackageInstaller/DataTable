-- chunkname: @modules/logic/playercard/view/PlayerCardEnterSettingViewContainer.lua

module("modules.logic.playercard.view.PlayerCardEnterSettingViewContainer", package.seeall)

local PlayerCardEnterSettingViewContainer = class("PlayerCardEnterSettingViewContainer", BaseViewContainer)

function PlayerCardEnterSettingViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardEnterSettingView.New())

	return views
end

return PlayerCardEnterSettingViewContainer
