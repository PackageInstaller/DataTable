-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomPanelViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomPanelViewContainer", package.seeall)

local CandyRoomPanelViewContainer = class("CandyRoomPanelViewContainer", BaseViewContainer)

function CandyRoomPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, CandyRoomPanelView.New())

	return views
end

return CandyRoomPanelViewContainer
