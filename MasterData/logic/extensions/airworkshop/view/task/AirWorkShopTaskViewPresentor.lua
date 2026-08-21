-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/task/AirWorkShopTaskViewPresentor.lua

module("logic.extensions.airworkshop.view.task.AirWorkShopTaskViewPresentor", package.seeall)

local M = class("AirWorkShopTaskViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_task_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopTaskView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
