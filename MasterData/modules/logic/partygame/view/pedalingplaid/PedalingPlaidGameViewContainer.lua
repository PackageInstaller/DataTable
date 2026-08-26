-- chunkname: @modules/logic/partygame/view/pedalingplaid/PedalingPlaidGameViewContainer.lua

module("modules.logic.partygame.view.pedalingplaid.PedalingPlaidGameViewContainer", package.seeall)

local PedalingPlaidGameViewContainer = class("PedalingPlaidGameViewContainer", SceneGameCommonViewContainer)

function PedalingPlaidGameViewContainer:getGameView()
	return {
		PedalingPlaidGameView.New()
	}
end

return PedalingPlaidGameViewContainer
