-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayResultViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayResultViewContainer", package.seeall)

local GuessGamePlayResultViewContainer = class("GuessGamePlayResultViewContainer", BaseViewContainer)

function GuessGamePlayResultViewContainer:buildViews()
	return {
		GuessGamePlayResultView.New()
	}
end

return GuessGamePlayResultViewContainer
