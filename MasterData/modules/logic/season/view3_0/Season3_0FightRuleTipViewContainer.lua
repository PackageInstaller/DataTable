-- chunkname: @modules/logic/season/view3_0/Season3_0FightRuleTipViewContainer.lua

module("modules.logic.season.view3_0.Season3_0FightRuleTipViewContainer", package.seeall)

local Season3_0FightRuleTipViewContainer = class("Season3_0FightRuleTipViewContainer", BaseViewContainer)

function Season3_0FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season3_0FightRuleTipView.New()
	}
end

function Season3_0FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season3_0FightRuleView.New(),
		Season3_0FightCardView.New()
	}
end

function Season3_0FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season3_0FightRuleTipViewContainer
