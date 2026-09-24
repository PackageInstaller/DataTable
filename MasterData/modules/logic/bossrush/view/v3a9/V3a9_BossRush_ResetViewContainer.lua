-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_ResetViewContainer.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_ResetViewContainer", package.seeall)

local V3a9_BossRush_ResetViewContainer = class("V3a9_BossRush_ResetViewContainer", BaseViewContainer)

function V3a9_BossRush_ResetViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9_BossRush_ResetView.New())

	return views
end

return V3a9_BossRush_ResetViewContainer
