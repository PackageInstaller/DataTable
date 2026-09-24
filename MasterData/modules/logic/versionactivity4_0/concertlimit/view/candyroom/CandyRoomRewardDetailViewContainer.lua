-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomRewardDetailViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomRewardDetailViewContainer", package.seeall)

local CandyRoomRewardDetailViewContainer = class("CandyRoomRewardDetailViewContainer", BaseViewContainer)

function CandyRoomRewardDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, CandyRoomRewardDetailView.New())

	return views
end

return CandyRoomRewardDetailViewContainer
