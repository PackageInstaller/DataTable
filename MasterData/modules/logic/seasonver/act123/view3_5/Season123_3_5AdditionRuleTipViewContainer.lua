-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5AdditionRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5AdditionRuleTipViewContainer", package.seeall)

local Season123_3_5AdditionRuleTipViewContainer = class("Season123_3_5AdditionRuleTipViewContainer", BaseViewContainer)

function Season123_3_5AdditionRuleTipViewContainer:buildViews()
	return {
		Season123_3_5AdditionRuleTipView.New()
	}
end

return Season123_3_5AdditionRuleTipViewContainer
