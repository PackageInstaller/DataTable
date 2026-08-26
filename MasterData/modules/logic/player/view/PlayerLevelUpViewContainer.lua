-- chunkname: @modules/logic/player/view/PlayerLevelUpViewContainer.lua

module("modules.logic.player.view.PlayerLevelUpViewContainer", package.seeall)

local PlayerLevelUpViewContainer = class("PlayerLevelUpViewContainer", BaseViewContainer)

function PlayerLevelUpViewContainer:buildViews()
	return {
		PlayerLevelUpView.New()
	}
end

return PlayerLevelUpViewContainer
