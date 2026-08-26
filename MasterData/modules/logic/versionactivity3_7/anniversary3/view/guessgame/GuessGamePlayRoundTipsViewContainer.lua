-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayRoundTipsViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayRoundTipsViewContainer", package.seeall)

local GuessGamePlayRoundTipsViewContainer = class("GuessGamePlayRoundTipsViewContainer", BaseViewContainer)

function GuessGamePlayRoundTipsViewContainer:buildViews()
	return {
		GuessGamePlayRoundTipsView.New()
	}
end

return GuessGamePlayRoundTipsViewContainer
