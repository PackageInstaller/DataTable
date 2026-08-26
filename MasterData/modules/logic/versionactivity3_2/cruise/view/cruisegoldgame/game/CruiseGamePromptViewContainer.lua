-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGamePromptViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGamePromptViewContainer", package.seeall)

local CruiseGamePromptViewContainer = class("CruiseGamePromptViewContainer", BaseViewContainer)

function CruiseGamePromptViewContainer:buildViews()
	return {
		CruiseGamePromptView.New()
	}
end

return CruiseGamePromptViewContainer
