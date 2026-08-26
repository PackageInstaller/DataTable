-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9FightRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightRuleTipViewContainer", package.seeall)

local Season123_1_9FightRuleTipViewContainer = class("Season123_1_9FightRuleTipViewContainer", BaseViewContainer)

function Season123_1_9FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_1_9FightRuleTipView.New()
	}
end

function Season123_1_9FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season123_1_9FightRuleView.New(),
		Season123_1_9FightCardView.New()
	}
end

function Season123_1_9FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season123_1_9FightRuleTipViewContainer
