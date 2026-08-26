-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_ResultViewContainer.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_ResultViewContainer", package.seeall)

local V3a9_BossRush_ResultViewContainer = class("V3a9_BossRush_ResultViewContainer", BaseViewContainer)

function V3a9_BossRush_ResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9_BossRush_ResultView.New())

	return views
end

return V3a9_BossRush_ResultViewContainer
