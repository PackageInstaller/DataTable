-- chunkname: @modules/logic/season/view1_4/Season1_4CelebrityCardTipViewContainer.lua

module("modules.logic.season.view1_4.Season1_4CelebrityCardTipViewContainer", package.seeall)

local Season1_4CelebrityCardTipViewContainer = class("Season1_4CelebrityCardTipViewContainer", BaseViewContainer)

function Season1_4CelebrityCardTipViewContainer:buildViews()
	return {
		Season1_4CelebrityCardTipView.New()
	}
end

return Season1_4CelebrityCardTipViewContainer
