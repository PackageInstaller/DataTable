-- chunkname: @modules/logic/autochess/main/view/AutoChessCardpackInfoViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessCardpackInfoViewContainer", package.seeall)

local AutoChessCardpackInfoViewContainer = class("AutoChessCardpackInfoViewContainer", BaseViewContainer)

function AutoChessCardpackInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessCardpackInfoView.New())

	return views
end

return AutoChessCardpackInfoViewContainer
