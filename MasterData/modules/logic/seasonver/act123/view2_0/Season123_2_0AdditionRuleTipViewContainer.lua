-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0AdditionRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0AdditionRuleTipViewContainer", package.seeall)

local Season123_2_0AdditionRuleTipViewContainer = class("Season123_2_0AdditionRuleTipViewContainer", BaseViewContainer)

function Season123_2_0AdditionRuleTipViewContainer:buildViews()
	return {
		Season123_2_0AdditionRuleTipView.New()
	}
end

return Season123_2_0AdditionRuleTipViewContainer
