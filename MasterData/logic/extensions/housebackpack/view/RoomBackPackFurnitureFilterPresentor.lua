-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackPackFurnitureFilterPresentor.lua

module("logic.extensions.housebackpack.view.RoomBackPackFurnitureFilterPresentor", package.seeall)

local M = class("RoomBackPackFurnitureFilterPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_backpack_furniture_filter_view,
		ResName.Common_team_filter_tab,
		ResName.Room_suit_filter_tab
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomBackPackFurnitureFilterView.New())

	return views
end

return M
