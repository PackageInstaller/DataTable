-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0FightRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0FightRuleTipViewContainer", package.seeall)

local Season123_2_0FightRuleTipViewContainer = class("Season123_2_0FightRuleTipViewContainer", BaseViewContainer)

function Season123_2_0FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_2_0FightRuleTipView.New()
	}
end

function Season123_2_0FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season123_2_0FightRuleView.New(),
		Season123_2_0FightCardView.New()
	}
end

function Season123_2_0FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season123_2_0FightRuleTipViewContainer
