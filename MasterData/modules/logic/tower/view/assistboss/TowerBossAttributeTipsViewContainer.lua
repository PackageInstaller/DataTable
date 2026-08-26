-- chunkname: @modules/logic/tower/view/assistboss/TowerBossAttributeTipsViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerBossAttributeTipsViewContainer", package.seeall)

local TowerBossAttributeTipsViewContainer = class("TowerBossAttributeTipsViewContainer", BaseViewContainer)

function TowerBossAttributeTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossAttributeTipsView.New())

	return views
end

function TowerBossAttributeTipsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return TowerBossAttributeTipsViewContainer
