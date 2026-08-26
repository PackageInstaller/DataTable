-- chunkname: @modules/logic/autochess/main/view/game/AutoChessPveFirstSettleViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessPveFirstSettleViewContainer", package.seeall)

local AutoChessPveFirstSettleViewContainer = class("AutoChessPveFirstSettleViewContainer", BaseViewContainer)

function AutoChessPveFirstSettleViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessPveFirstSettleView.New())

	return views
end

return AutoChessPveFirstSettleViewContainer
