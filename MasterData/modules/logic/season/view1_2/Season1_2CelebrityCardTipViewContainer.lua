-- chunkname: @modules/logic/season/view1_2/Season1_2CelebrityCardTipViewContainer.lua

module("modules.logic.season.view1_2.Season1_2CelebrityCardTipViewContainer", package.seeall)

local Season1_2CelebrityCardTipViewContainer = class("Season1_2CelebrityCardTipViewContainer", BaseViewContainer)

function Season1_2CelebrityCardTipViewContainer:buildViews()
	return {
		Season1_2CelebrityCardTipView.New()
	}
end

return Season1_2CelebrityCardTipViewContainer
