-- chunkname: @modules/logic/roomfishing/view/RoomFishingRewardViewContainer.lua

module("modules.logic.roomfishing.view.RoomFishingRewardViewContainer", package.seeall)

local RoomFishingRewardViewContainer = class("RoomFishingRewardViewContainer", BaseViewContainer)

function RoomFishingRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomFishingRewardView.New())

	return views
end

return RoomFishingRewardViewContainer
