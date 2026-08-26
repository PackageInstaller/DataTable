-- chunkname: @modules/logic/season/view1_3/Season1_3FightRuleTipViewContainer.lua

module("modules.logic.season.view1_3.Season1_3FightRuleTipViewContainer", package.seeall)

local Season1_3FightRuleTipViewContainer = class("Season1_3FightRuleTipViewContainer", BaseViewContainer)

function Season1_3FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season1_3FightRuleTipView.New()
	}
end

function Season1_3FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season1_3FightRuleView.New(),
		Season1_3FightCardView.New()
	}
end

function Season1_3FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season1_3FightRuleTipViewContainer
