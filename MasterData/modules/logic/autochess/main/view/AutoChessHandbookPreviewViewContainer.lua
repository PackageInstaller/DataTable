-- chunkname: @modules/logic/autochess/main/view/AutoChessHandbookPreviewViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessHandbookPreviewViewContainer", package.seeall)

local AutoChessHandbookPreviewViewContainer = class("AutoChessHandbookPreviewViewContainer", BaseViewContainer)

function AutoChessHandbookPreviewViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessHandbookPreviewView.New())

	return views
end

return AutoChessHandbookPreviewViewContainer
