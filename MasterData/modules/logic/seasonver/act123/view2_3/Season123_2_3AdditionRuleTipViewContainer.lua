-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3AdditionRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3AdditionRuleTipViewContainer", package.seeall)

local Season123_2_3AdditionRuleTipViewContainer = class("Season123_2_3AdditionRuleTipViewContainer", BaseViewContainer)

function Season123_2_3AdditionRuleTipViewContainer:buildViews()
	return {
		Season123_2_3AdditionRuleTipView.New()
	}
end

return Season123_2_3AdditionRuleTipViewContainer
