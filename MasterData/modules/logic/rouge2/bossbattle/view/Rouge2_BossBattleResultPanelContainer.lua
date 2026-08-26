-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleResultPanelContainer.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleResultPanelContainer", package.seeall)

local Rouge2_BossBattleResultPanelContainer = class("Rouge2_BossBattleResultPanelContainer", BaseViewContainer)

function Rouge2_BossBattleResultPanelContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BossBattleResultPanel.New())

	return views
end

return Rouge2_BossBattleResultPanelContainer
