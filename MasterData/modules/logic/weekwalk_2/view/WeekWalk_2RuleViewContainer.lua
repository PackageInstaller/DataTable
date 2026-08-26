-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2RuleViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2RuleViewContainer", package.seeall)

local WeekWalk_2RuleViewContainer = class("WeekWalk_2RuleViewContainer", BaseViewContainer)

function WeekWalk_2RuleViewContainer:buildViews()
	return {
		WeekWalk_2RuleView.New()
	}
end

return WeekWalk_2RuleViewContainer
