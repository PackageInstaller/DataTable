-- chunkname: @modules/logic/season/view/SeasonCelebrityCardTipViewContainer.lua

module("modules.logic.season.view.SeasonCelebrityCardTipViewContainer", package.seeall)

local SeasonCelebrityCardTipViewContainer = class("SeasonCelebrityCardTipViewContainer", BaseViewContainer)

function SeasonCelebrityCardTipViewContainer:buildViews()
	return {
		SeasonCelebrityCardTipView.New()
	}
end

return SeasonCelebrityCardTipViewContainer
