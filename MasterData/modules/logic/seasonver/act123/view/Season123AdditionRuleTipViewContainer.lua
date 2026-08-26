-- chunkname: @modules/logic/seasonver/act123/view/Season123AdditionRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123AdditionRuleTipViewContainer", package.seeall)

local Season123AdditionRuleTipViewContainer = class("Season123AdditionRuleTipViewContainer", BaseViewContainer)

function Season123AdditionRuleTipViewContainer:buildViews()
	return {
		Season123AdditionRuleTipView.New()
	}
end

return Season123AdditionRuleTipViewContainer
