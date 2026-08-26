-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3FightRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3FightRuleTipViewContainer", package.seeall)

local Season123_2_3FightRuleTipViewContainer = class("Season123_2_3FightRuleTipViewContainer", BaseViewContainer)

function Season123_2_3FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_2_3FightRuleTipView.New()
	}
end

function Season123_2_3FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season123_2_3FightRuleView.New(),
		Season123_2_3FightCardView.New()
	}
end

function Season123_2_3FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season123_2_3FightRuleTipViewContainer
