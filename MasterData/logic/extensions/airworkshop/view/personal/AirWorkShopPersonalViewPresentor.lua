-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/personal/AirWorkShopPersonalViewPresentor.lua

module("logic.extensions.airworkshop.view.personal.AirWorkShopPersonalViewPresentor", package.seeall)

local M = class("AirWorkShopPersonalViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_personal_page_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopPersonalView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
