-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoCheckRecordTipsPresentor.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoCheckRecordTipsPresentor", package.seeall)

local M = class("AirWorkShopRodeoCheckRecordTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_sports_check_record_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopRodeoCheckRecordTips.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
