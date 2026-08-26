-- chunkname: @modules/logic/autochess/main/view/game/AutoChessResultViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessResultViewContainer", package.seeall)

local AutoChessResultViewContainer = class("AutoChessResultViewContainer", BaseViewContainer)

function AutoChessResultViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessResultView.New())

	return views
end

return AutoChessResultViewContainer
