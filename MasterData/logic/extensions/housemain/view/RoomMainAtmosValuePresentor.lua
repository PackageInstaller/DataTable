-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomMainAtmosValuePresentor.lua

module("logic.extensions.housemain.view.RoomMainAtmosValuePresentor", package.seeall)

local M = class("RoomMainAtmosValuePresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_atmosphere_value_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomMainAtmosValueTipView.New())

	return views
end

return M
