-- chunkname: @modules/logic/seasonver/act123/view/Season123CelebrityCardTipViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123CelebrityCardTipViewContainer", package.seeall)

local Season123CelebrityCardTipViewContainer = class("Season123CelebrityCardTipViewContainer", BaseViewContainer)

function Season123CelebrityCardTipViewContainer:buildViews()
	return {
		Season123CelebrityCardTipView.New()
	}
end

return Season123CelebrityCardTipViewContainer
