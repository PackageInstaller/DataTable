-- chunkname: @modules/logic/season/view1_5/Season1_5CelebrityCardTipViewContainer.lua

module("modules.logic.season.view1_5.Season1_5CelebrityCardTipViewContainer", package.seeall)

local Season1_5CelebrityCardTipViewContainer = class("Season1_5CelebrityCardTipViewContainer", BaseViewContainer)

function Season1_5CelebrityCardTipViewContainer:buildViews()
	return {
		Season1_5CelebrityCardTipView.New()
	}
end

return Season1_5CelebrityCardTipViewContainer
