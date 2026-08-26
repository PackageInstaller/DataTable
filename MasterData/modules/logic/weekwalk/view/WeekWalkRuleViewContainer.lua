-- chunkname: @modules/logic/weekwalk/view/WeekWalkRuleViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkRuleViewContainer", package.seeall)

local WeekWalkRuleViewContainer = class("WeekWalkRuleViewContainer", BaseViewContainer)

function WeekWalkRuleViewContainer:buildViews()
	return {
		WeekWalkRuleView.New()
	}
end

return WeekWalkRuleViewContainer
