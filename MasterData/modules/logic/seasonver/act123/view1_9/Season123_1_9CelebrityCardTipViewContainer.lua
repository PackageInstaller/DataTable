-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9CelebrityCardTipViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9CelebrityCardTipViewContainer", package.seeall)

local Season123_1_9CelebrityCardTipViewContainer = class("Season123_1_9CelebrityCardTipViewContainer", BaseViewContainer)

function Season123_1_9CelebrityCardTipViewContainer:buildViews()
	return {
		Season123_1_9CelebrityCardTipView.New()
	}
end

return Season123_1_9CelebrityCardTipViewContainer
