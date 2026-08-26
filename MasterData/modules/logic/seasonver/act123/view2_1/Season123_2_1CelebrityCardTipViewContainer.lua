-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1CelebrityCardTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1CelebrityCardTipViewContainer", package.seeall)

local Season123_2_1CelebrityCardTipViewContainer = class("Season123_2_1CelebrityCardTipViewContainer", BaseViewContainer)

function Season123_2_1CelebrityCardTipViewContainer:buildViews()
	return {
		Season123_2_1CelebrityCardTipView.New()
	}
end

return Season123_2_1CelebrityCardTipViewContainer
