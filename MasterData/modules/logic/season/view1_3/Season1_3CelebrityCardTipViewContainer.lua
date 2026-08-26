-- chunkname: @modules/logic/season/view1_3/Season1_3CelebrityCardTipViewContainer.lua

module("modules.logic.season.view1_3.Season1_3CelebrityCardTipViewContainer", package.seeall)

local Season1_3CelebrityCardTipViewContainer = class("Season1_3CelebrityCardTipViewContainer", BaseViewContainer)

function Season1_3CelebrityCardTipViewContainer:buildViews()
	return {
		Season1_3CelebrityCardTipView.New()
	}
end

return Season1_3CelebrityCardTipViewContainer
