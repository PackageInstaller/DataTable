-- chunkname: @modules/logic/season/view1_6/Season1_6FightRuleTipViewContainer.lua

module("modules.logic.season.view1_6.Season1_6FightRuleTipViewContainer", package.seeall)

local Season1_6FightRuleTipViewContainer = class("Season1_6FightRuleTipViewContainer", BaseViewContainer)

function Season1_6FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season1_6FightRuleTipView.New()
	}
end

function Season1_6FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season1_6FightRuleView.New(),
		Season1_6FightCardView.New()
	}
end

function Season1_6FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season1_6FightRuleTipViewContainer
