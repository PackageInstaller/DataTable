-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomMainViewPresentor.lua

module("logic.extensions.housemain.view.RoomMainViewPresentor", package.seeall)

local M = class("RoomMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_main_room_main_view,
		ResName.Room_main_room_distribution_sign,
		ResName.Room_room_map_point,
		ResName.Room_room_map_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomMainView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))
	table.insert(views, HouseMapView.New())

	return views
end

return M
