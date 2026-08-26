-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonSkipViewContainer.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonSkipViewContainer", package.seeall)

local RoomCritterSummonSkipViewContainer = class("RoomCritterSummonSkipViewContainer", BaseViewContainer)

function RoomCritterSummonSkipViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterSummonSkipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_content"))

	return views
end

function RoomCritterSummonSkipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			MultiView.New({
				RoomCritterSummonDragView.New()
			})
		}
	end
end

return RoomCritterSummonSkipViewContainer
