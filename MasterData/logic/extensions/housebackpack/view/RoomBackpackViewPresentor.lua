-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackViewPresentor.lua

module("logic.extensions.housebackpack.view.RoomBackpackViewPresentor", package.seeall)

local M = class("RoomBackpackViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Furniture_backpack_furniture_backpack_view,
		ResName.Common_Backpack_Item,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Backpack)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomBackpackView.New())
	table.insert(views, RoomBackpackType1View.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
