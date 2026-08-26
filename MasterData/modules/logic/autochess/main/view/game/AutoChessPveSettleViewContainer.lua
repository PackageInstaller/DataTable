-- chunkname: @modules/logic/autochess/main/view/game/AutoChessPveSettleViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessPveSettleViewContainer", package.seeall)

local AutoChessPveSettleViewContainer = class("AutoChessPveSettleViewContainer", BaseViewContainer)

function AutoChessPveSettleViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessPveSettleView.New())

	return views
end

return AutoChessPveSettleViewContainer
