-- chunkname: @modules/logic/fight/view/FightAttributeTipViewContainer.lua

module("modules.logic.fight.view.FightAttributeTipViewContainer", package.seeall)

local FightAttributeTipViewContainer = class("FightAttributeTipViewContainer", BaseViewContainer)

function FightAttributeTipViewContainer:buildViews()
	return {
		FightAttributeTipView.New()
	}
end

function FightAttributeTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return FightAttributeTipViewContainer
