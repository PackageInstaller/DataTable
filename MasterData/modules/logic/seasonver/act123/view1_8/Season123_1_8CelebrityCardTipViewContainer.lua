-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8CelebrityCardTipViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8CelebrityCardTipViewContainer", package.seeall)

local Season123_1_8CelebrityCardTipViewContainer = class("Season123_1_8CelebrityCardTipViewContainer", BaseViewContainer)

function Season123_1_8CelebrityCardTipViewContainer:buildViews()
	return {
		Season123_1_8CelebrityCardTipView.New()
	}
end

return Season123_1_8CelebrityCardTipViewContainer
