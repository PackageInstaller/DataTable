-- chunkname: @modules/logic/autochess/main/view/game/AutoChessWarnUpViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessWarnUpViewContainer", package.seeall)

local AutoChessWarnUpViewContainer = class("AutoChessWarnUpViewContainer", BaseViewContainer)

function AutoChessWarnUpViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessWarnUpView.New())

	return views
end

return AutoChessWarnUpViewContainer
