-- chunkname: @modules/logic/tower/view/assistboss/TowerBossSkillTipsViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerBossSkillTipsViewContainer", package.seeall)

local TowerBossSkillTipsViewContainer = class("TowerBossSkillTipsViewContainer", BaseViewContainer)

function TowerBossSkillTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossSkillTipsView.New())

	return views
end

function TowerBossSkillTipsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return TowerBossSkillTipsViewContainer
