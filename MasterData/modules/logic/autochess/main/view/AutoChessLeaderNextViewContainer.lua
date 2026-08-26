-- chunkname: @modules/logic/autochess/main/view/AutoChessLeaderNextViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessLeaderNextViewContainer", package.seeall)

local AutoChessLeaderNextViewContainer = class("AutoChessLeaderNextViewContainer", BaseViewContainer)

function AutoChessLeaderNextViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessLeaderNextView.New())

	return views
end

return AutoChessLeaderNextViewContainer
