-- chunkname: @modules/logic/season/view1_5/Season1_5FightRuleTipViewContainer.lua

module("modules.logic.season.view1_5.Season1_5FightRuleTipViewContainer", package.seeall)

local Season1_5FightRuleTipViewContainer = class("Season1_5FightRuleTipViewContainer", BaseViewContainer)

function Season1_5FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season1_5FightRuleTipView.New()
	}
end

function Season1_5FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season1_5FightRuleView.New(),
		Season1_5FightCardView.New()
	}
end

function Season1_5FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season1_5FightRuleTipViewContainer
