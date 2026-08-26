-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateLevelResultViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelResultViewContainer", package.seeall)

local EliminateLevelResultViewContainer = class("EliminateLevelResultViewContainer", BaseViewContainer)

function EliminateLevelResultViewContainer:buildViews()
	local views = {}

	table.insert(views, EliminateLevelResultView.New())

	return views
end

return EliminateLevelResultViewContainer
