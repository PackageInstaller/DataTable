-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8FightRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightRuleTipViewContainer", package.seeall)

local Season123_1_8FightRuleTipViewContainer = class("Season123_1_8FightRuleTipViewContainer", BaseViewContainer)

function Season123_1_8FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_1_8FightRuleTipView.New()
	}
end

function Season123_1_8FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season123_1_8FightRuleView.New(),
		Season123_1_8FightCardView.New()
	}
end

function Season123_1_8FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season123_1_8FightRuleTipViewContainer
