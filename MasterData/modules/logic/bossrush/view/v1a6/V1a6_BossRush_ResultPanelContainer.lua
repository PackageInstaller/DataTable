-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_ResultPanelContainer.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultPanelContainer", package.seeall)

local V1a6_BossRush_ResultPanelContainer = class("V1a6_BossRush_ResultPanelContainer", BaseViewContainer)

function V1a6_BossRush_ResultPanelContainer:buildViews()
	local views = {
		V1a6_BossRush_ResultPanel.New()
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(views, FightGMRecordView.New())
	end

	return views
end

return V1a6_BossRush_ResultPanelContainer
