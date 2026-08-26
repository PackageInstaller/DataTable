-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CelebrityCardTipViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CelebrityCardTipViewContainer", package.seeall)

local Season123_3_5CelebrityCardTipViewContainer = class("Season123_3_5CelebrityCardTipViewContainer", BaseViewContainer)

function Season123_3_5CelebrityCardTipViewContainer:buildViews()
	return {
		Season123_3_5CelebrityCardTipView.New()
	}
end

return Season123_3_5CelebrityCardTipViewContainer
