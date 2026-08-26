-- chunkname: @modules/logic/autochess/main/view/game/AutoChessForcePickViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessForcePickViewContainer", package.seeall)

local AutoChessForcePickViewContainer = class("AutoChessForcePickViewContainer", BaseViewContainer)

function AutoChessForcePickViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessForcePickView.New())

	return views
end

return AutoChessForcePickViewContainer
