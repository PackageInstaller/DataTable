-- chunkname: @modules/logic/autochess/main/view/game/AutoChessLeaderBuffViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessLeaderBuffViewContainer", package.seeall)

local AutoChessLeaderBuffViewContainer = class("AutoChessLeaderBuffViewContainer", BaseViewContainer)

function AutoChessLeaderBuffViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessLeaderBuffView.New())

	return views
end

return AutoChessLeaderBuffViewContainer
