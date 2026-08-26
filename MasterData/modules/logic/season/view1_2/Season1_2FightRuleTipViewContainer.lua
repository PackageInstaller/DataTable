-- chunkname: @modules/logic/season/view1_2/Season1_2FightRuleTipViewContainer.lua

module("modules.logic.season.view1_2.Season1_2FightRuleTipViewContainer", package.seeall)

local Season1_2FightRuleTipViewContainer = class("Season1_2FightRuleTipViewContainer", BaseViewContainer)

function Season1_2FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season1_2FightRuleTipView.New()
	}
end

function Season1_2FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season1_2FightRuleView.New(),
		Season1_2FightCardView.New()
	}
end

function Season1_2FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season1_2FightRuleTipViewContainer
