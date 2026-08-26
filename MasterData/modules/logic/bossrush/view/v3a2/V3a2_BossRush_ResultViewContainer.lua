-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_ResultViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_ResultViewContainer", package.seeall)

local V3a2_BossRush_ResultViewContainer = class("V3a2_BossRush_ResultViewContainer", BaseViewContainer)

function V3a2_BossRush_ResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a2_BossRush_ResultView.New())

	return views
end

return V3a2_BossRush_ResultViewContainer
