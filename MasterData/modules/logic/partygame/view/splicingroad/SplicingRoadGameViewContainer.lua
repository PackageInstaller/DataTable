-- chunkname: @modules/logic/partygame/view/splicingroad/SplicingRoadGameViewContainer.lua

module("modules.logic.partygame.view.splicingroad.SplicingRoadGameViewContainer", package.seeall)

local SplicingRoadGameViewContainer = class("SplicingRoadGameViewContainer", SceneGameCommonViewContainer)

function SplicingRoadGameViewContainer:getGameView()
	return {
		SplicingRoadGameView.New()
	}
end

return SplicingRoadGameViewContainer
