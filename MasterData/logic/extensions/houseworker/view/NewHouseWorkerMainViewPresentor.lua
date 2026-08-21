-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/NewHouseWorkerMainViewPresentor.lua

module("logic.extensions.houseworker.view.NewHouseWorkerMainViewPresentor", package.seeall)

local M = class("NewHouseWorkerMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_settled_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, NewHouseWorkerMainView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
