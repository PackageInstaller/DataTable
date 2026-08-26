-- chunkname: @modules/logic/partygame/view/security/SecurityGameViewContainer.lua

module("modules.logic.partygame.view.security.SecurityGameViewContainer", package.seeall)

local SecurityGameViewContainer = class("SecurityGameViewContainer", SceneGameCommonViewContainer)

function SecurityGameViewContainer:getGameView()
	return {
		SecurityGameView.New()
	}
end

return SecurityGameViewContainer
