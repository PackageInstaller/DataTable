-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5FightRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5FightRuleTipViewContainer", package.seeall)

local Season123_3_5FightRuleTipViewContainer = class("Season123_3_5FightRuleTipViewContainer", BaseViewContainer)

function Season123_3_5FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_3_5FightRuleTipView.New()
	}
end

function Season123_3_5FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season123_3_5FightRuleView.New(),
		Season123_3_5FightCardView.New()
	}
end

function Season123_3_5FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season123_3_5FightRuleTipViewContainer
