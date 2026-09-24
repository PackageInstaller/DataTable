-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomSkinViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomSkinViewContainer", package.seeall)

local CandyRoomSkinViewContainer = class("CandyRoomSkinViewContainer", BaseViewContainer)

function CandyRoomSkinViewContainer:buildViews()
	local views = {}

	table.insert(views, CandyRoomSkinView.New())

	return views
end

return CandyRoomSkinViewContainer
