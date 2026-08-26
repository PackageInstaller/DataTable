-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_EnterViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_EnterViewContainer", package.seeall)

local V3a2_BossRush_EnterViewContainer = class("V3a2_BossRush_EnterViewContainer", BaseViewContainer)

function V3a2_BossRush_EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a2_BossRush_EnterView.New())

	return views
end

return V3a2_BossRush_EnterViewContainer
