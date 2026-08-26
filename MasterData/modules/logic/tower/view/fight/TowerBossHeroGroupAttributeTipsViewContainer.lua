-- chunkname: @modules/logic/tower/view/fight/TowerBossHeroGroupAttributeTipsViewContainer.lua

module("modules.logic.tower.view.fight.TowerBossHeroGroupAttributeTipsViewContainer", package.seeall)

local TowerBossHeroGroupAttributeTipsViewContainer = class("TowerBossHeroGroupAttributeTipsViewContainer", BaseViewContainer)

function TowerBossHeroGroupAttributeTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossHeroGroupAttributeTipsView.New())

	return views
end

function TowerBossHeroGroupAttributeTipsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return TowerBossHeroGroupAttributeTipsViewContainer
