-- chunkname: @modules/logic/fight/view/FightFocusViewContainer.lua

module("modules.logic.fight.view.FightFocusViewContainer", package.seeall)

local FightFocusViewContainer = class("FightFocusViewContainer", BaseViewContainer)

function FightFocusViewContainer:buildViews()
	return {
		FightFocusView.New(),
		TabViewGroup.New(1, "fightinfocontainer/skilltipview")
	}
end

function FightFocusViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function FightFocusViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._skillTipView = SkillTipView.New()

		return {
			self._skillTipView
		}
	end
end

function FightFocusViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

function FightFocusViewContainer:showSkillTipView(info, isCharacter, entityId)
	self._skillTipView:showInfo(info, isCharacter, entityId)
end

function FightFocusViewContainer:hideSkillTipView()
	self._skillTipView:hideInfo()
end

function FightFocusViewContainer:playOpenTransition()
	FightFocusViewContainer.super.playOpenTransition(self, {
		anim = "open"
	})
end

function FightFocusViewContainer:playCloseTransition()
	FightFocusViewContainer.super.playCloseTransition(self, {
		anim = "close"
	})
end

return FightFocusViewContainer
