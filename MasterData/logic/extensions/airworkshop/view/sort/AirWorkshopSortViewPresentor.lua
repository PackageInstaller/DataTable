-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/sort/AirWorkshopSortViewPresentor.lua

module("logic.extensions.airworkshop.view.sort.AirWorkshopSortViewPresentor", package.seeall)

local M = class("AirWorkshopSortViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_sort_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkshopSortView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
