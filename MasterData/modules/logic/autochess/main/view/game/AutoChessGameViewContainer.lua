-- chunkname: @modules/logic/autochess/main/view/game/AutoChessGameViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessGameViewContainer", package.seeall)

local AutoChessGameViewContainer = class("AutoChessGameViewContainer", BaseViewContainer)

function AutoChessGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessGameView.New())
	table.insert(views, AutoChessGameScene.New())

	return views
end

return AutoChessGameViewContainer
