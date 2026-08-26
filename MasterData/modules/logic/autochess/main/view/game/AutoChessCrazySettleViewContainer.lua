-- chunkname: @modules/logic/autochess/main/view/game/AutoChessCrazySettleViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessCrazySettleViewContainer", package.seeall)

local AutoChessCrazySettleViewContainer = class("AutoChessCrazySettleViewContainer", BaseViewContainer)

function AutoChessCrazySettleViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessCrazySettleView.New())

	return views
end

return AutoChessCrazySettleViewContainer
