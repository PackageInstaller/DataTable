-- chunkname: @modules/logic/autochess/main/view/AutoChessRankUpViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessRankUpViewContainer", package.seeall)

local AutoChessRankUpViewContainer = class("AutoChessRankUpViewContainer", BaseViewContainer)

function AutoChessRankUpViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessRankUpView.New())

	return views
end

return AutoChessRankUpViewContainer
