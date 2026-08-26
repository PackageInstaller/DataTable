-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_ResultPanelContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_ResultPanelContainer", package.seeall)

local V3a2_BossRush_ResultPanelContainer = class("V3a2_BossRush_ResultPanelContainer", BaseViewContainer)

function V3a2_BossRush_ResultPanelContainer:buildViews()
	local views = {}

	table.insert(views, V3a2_BossRush_ResultPanel.New())

	return views
end

return V3a2_BossRush_ResultPanelContainer
