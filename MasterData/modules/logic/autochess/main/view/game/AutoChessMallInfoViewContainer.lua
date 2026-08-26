-- chunkname: @modules/logic/autochess/main/view/game/AutoChessMallInfoViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessMallInfoViewContainer", package.seeall)

local AutoChessMallInfoViewContainer = class("AutoChessMallInfoViewContainer", BaseViewContainer)

function AutoChessMallInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessMallInfoView.New())

	return views
end

return AutoChessMallInfoViewContainer
