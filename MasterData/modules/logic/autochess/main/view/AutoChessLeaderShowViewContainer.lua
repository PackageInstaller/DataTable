-- chunkname: @modules/logic/autochess/main/view/AutoChessLeaderShowViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessLeaderShowViewContainer", package.seeall)

local AutoChessLeaderShowViewContainer = class("AutoChessLeaderShowViewContainer", BaseViewContainer)

function AutoChessLeaderShowViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessLeaderShowView.New())

	return views
end

return AutoChessLeaderShowViewContainer
