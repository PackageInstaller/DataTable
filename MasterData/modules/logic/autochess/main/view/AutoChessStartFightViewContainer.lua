-- chunkname: @modules/logic/autochess/main/view/AutoChessStartFightViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessStartFightViewContainer", package.seeall)

local AutoChessStartFightViewContainer = class("AutoChessStartFightViewContainer", BaseViewContainer)

function AutoChessStartFightViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessStartFightView.New())

	return views
end

return AutoChessStartFightViewContainer
