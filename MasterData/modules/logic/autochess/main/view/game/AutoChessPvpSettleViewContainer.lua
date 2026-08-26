-- chunkname: @modules/logic/autochess/main/view/game/AutoChessPvpSettleViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessPvpSettleViewContainer", package.seeall)

local AutoChessPvpSettleViewContainer = class("AutoChessPvpSettleViewContainer", BaseViewContainer)

function AutoChessPvpSettleViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessPvpSettleView.New())

	return views
end

return AutoChessPvpSettleViewContainer
