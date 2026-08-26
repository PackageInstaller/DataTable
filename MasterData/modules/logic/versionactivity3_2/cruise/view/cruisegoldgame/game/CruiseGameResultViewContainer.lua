-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGameResultViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGameResultViewContainer", package.seeall)

local CruiseGameResultViewContainer = class("CruiseGameResultViewContainer", BaseViewContainer)

function CruiseGameResultViewContainer:buildViews()
	return {
		CruiseGameResultView.New()
	}
end

return CruiseGameResultViewContainer
