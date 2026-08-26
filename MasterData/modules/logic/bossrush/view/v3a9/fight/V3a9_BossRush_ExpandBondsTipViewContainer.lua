-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_ExpandBondsTipViewContainer.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_ExpandBondsTipViewContainer", package.seeall)

local V3a9_BossRush_ExpandBondsTipViewContainer = class("V3a9_BossRush_ExpandBondsTipViewContainer", BaseViewContainer)

function V3a9_BossRush_ExpandBondsTipViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9_BossRush_ExpandBondsTipView.New())

	return views
end

return V3a9_BossRush_ExpandBondsTipViewContainer
