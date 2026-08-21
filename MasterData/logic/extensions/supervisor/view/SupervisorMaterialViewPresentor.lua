-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorMaterialViewPresentor.lua

module("logic.extensions.supervisor.view.SupervisorMaterialViewPresentor", package.seeall)

local M = class("SupervisorMaterialViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_room_orders_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SupervisorMaterialView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
