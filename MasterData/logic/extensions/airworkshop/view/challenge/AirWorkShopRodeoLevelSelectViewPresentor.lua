-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoLevelSelectViewPresentor.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoLevelSelectViewPresentor", package.seeall)

local M = class("AirWorkShopRodeoLevelSelectViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_sports_mode_level_select_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopRodeoLevelSelectView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
