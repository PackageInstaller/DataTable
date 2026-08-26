-- chunkname: @modules/logic/season/view1_4/Season1_4FightRuleTipViewContainer.lua

module("modules.logic.season.view1_4.Season1_4FightRuleTipViewContainer", package.seeall)

local Season1_4FightRuleTipViewContainer = class("Season1_4FightRuleTipViewContainer", BaseViewContainer)

function Season1_4FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season1_4FightRuleTipView.New()
	}
end

function Season1_4FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season1_4FightRuleView.New(),
		Season1_4FightCardView.New()
	}
end

function Season1_4FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season1_4FightRuleTipViewContainer
