-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesAdjustScheduleViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesAdjustScheduleViewPresentor", package.seeall)

local M = class("LivingFacilitiesAdjustScheduleViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_adjust_schedule_view2
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingFacilitiesAdjustScheduleView.New())

	return views
end

return M
