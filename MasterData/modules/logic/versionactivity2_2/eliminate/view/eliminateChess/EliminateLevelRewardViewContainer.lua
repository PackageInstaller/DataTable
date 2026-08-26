-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateLevelRewardViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelRewardViewContainer", package.seeall)

local EliminateLevelRewardViewContainer = class("EliminateLevelRewardViewContainer", BaseViewContainer)

function EliminateLevelRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, EliminateLevelRewardView.New())

	return views
end

return EliminateLevelRewardViewContainer
