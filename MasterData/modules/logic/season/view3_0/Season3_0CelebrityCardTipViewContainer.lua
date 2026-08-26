-- chunkname: @modules/logic/season/view3_0/Season3_0CelebrityCardTipViewContainer.lua

module("modules.logic.season.view3_0.Season3_0CelebrityCardTipViewContainer", package.seeall)

local Season3_0CelebrityCardTipViewContainer = class("Season3_0CelebrityCardTipViewContainer", BaseViewContainer)

function Season3_0CelebrityCardTipViewContainer:buildViews()
	return {
		Season3_0CelebrityCardTipView.New()
	}
end

return Season3_0CelebrityCardTipViewContainer
