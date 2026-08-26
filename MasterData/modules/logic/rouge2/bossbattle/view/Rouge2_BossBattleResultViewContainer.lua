-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleResultViewContainer.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleResultViewContainer", package.seeall)

local Rouge2_BossBattleResultViewContainer = class("Rouge2_BossBattleResultViewContainer", BaseViewContainer)

function Rouge2_BossBattleResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BossBattleResultView.New())

	return views
end

return Rouge2_BossBattleResultViewContainer
