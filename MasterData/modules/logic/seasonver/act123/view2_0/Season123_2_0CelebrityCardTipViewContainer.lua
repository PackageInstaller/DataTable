-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0CelebrityCardTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0CelebrityCardTipViewContainer", package.seeall)

local Season123_2_0CelebrityCardTipViewContainer = class("Season123_2_0CelebrityCardTipViewContainer", BaseViewContainer)

function Season123_2_0CelebrityCardTipViewContainer:buildViews()
	return {
		Season123_2_0CelebrityCardTipView.New()
	}
end

return Season123_2_0CelebrityCardTipViewContainer
