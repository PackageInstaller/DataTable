-- chunkname: @modules/logic/tower/view/assistboss/TowerSkillTipViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerSkillTipViewContainer", package.seeall)

local TowerSkillTipViewContainer = class("TowerSkillTipViewContainer", BaseViewContainer)

function TowerSkillTipViewContainer:buildViews()
	return {
		TowerSkillTipView.New()
	}
end

function TowerSkillTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return TowerSkillTipViewContainer
