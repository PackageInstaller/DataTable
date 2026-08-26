-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3CelebrityCardTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3CelebrityCardTipViewContainer", package.seeall)

local Season123_2_3CelebrityCardTipViewContainer = class("Season123_2_3CelebrityCardTipViewContainer", BaseViewContainer)

function Season123_2_3CelebrityCardTipViewContainer:buildViews()
	return {
		Season123_2_3CelebrityCardTipView.New()
	}
end

return Season123_2_3CelebrityCardTipViewContainer
