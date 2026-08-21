-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/sort/AirWorkShopHotRecommendViewPresentor.lua

module("logic.extensions.airworkshop.view.sort.AirWorkShopHotRecommendViewPresentor", package.seeall)

local M = class("AirWorkShopHotRecommendViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_hot_recommend_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopHotRecommendView.New())

	local titleView = TitleView.New()

	titleView:setTitle(lang("tip_air_entry_hot_mode"))
	table.insert(views, titleView)

	return views
end

return M
