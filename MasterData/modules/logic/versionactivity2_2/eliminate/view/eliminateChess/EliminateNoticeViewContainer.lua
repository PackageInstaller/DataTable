-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateNoticeViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateNoticeViewContainer", package.seeall)

local EliminateNoticeViewContainer = class("EliminateNoticeViewContainer", BaseViewContainer)

function EliminateNoticeViewContainer:buildViews()
	local views = {}

	table.insert(views, EliminateNoticeView.New())

	return views
end

return EliminateNoticeViewContainer
