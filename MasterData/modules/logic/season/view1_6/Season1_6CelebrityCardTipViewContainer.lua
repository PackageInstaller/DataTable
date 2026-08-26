-- chunkname: @modules/logic/season/view1_6/Season1_6CelebrityCardTipViewContainer.lua

module("modules.logic.season.view1_6.Season1_6CelebrityCardTipViewContainer", package.seeall)

local Season1_6CelebrityCardTipViewContainer = class("Season1_6CelebrityCardTipViewContainer", BaseViewContainer)

function Season1_6CelebrityCardTipViewContainer:buildViews()
	return {
		Season1_6CelebrityCardTipView.New()
	}
end

return Season1_6CelebrityCardTipViewContainer
