-- chunkname: @modules/logic/autochess/main/view/game/AutoChessCrazyModeTipViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessCrazyModeTipViewContainer", package.seeall)

local AutoChessCrazyModeTipViewContainer = class("AutoChessCrazyModeTipViewContainer", BaseViewContainer)

function AutoChessCrazyModeTipViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessCrazyModeTipView.New())

	return views
end

return AutoChessCrazyModeTipViewContainer
