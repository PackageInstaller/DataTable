-- chunkname: @modules/logic/seasonver/act123/view/Season123FightRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123FightRuleTipViewContainer", package.seeall)

local Season123FightRuleTipViewContainer = class("Season123FightRuleTipViewContainer", BaseViewContainer)

function Season123FightRuleTipViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123FightRuleTipView.New()
	}
end

function Season123FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season123FightRuleView.New(),
		Season123FightCardView.New()
	}
end

function Season123FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season123FightRuleTipViewContainer
