-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesProductViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesProductViewPresentor", package.seeall)

local M = class("LivingFacilitiesProductViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_room_orders_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingFacilitiesProductView.New())
	table.insert(views, HouseTitleView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
