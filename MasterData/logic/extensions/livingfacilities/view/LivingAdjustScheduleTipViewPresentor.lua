-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingAdjustScheduleTipViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingAdjustScheduleTipViewPresentor", package.seeall)

local M = class("LivingAdjustScheduleTipViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_adjust_schedule_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingAdjustScheduleTipView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
