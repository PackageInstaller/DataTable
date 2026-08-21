-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/message/AirWorkShopMessageLogTipsViewPresentor.lua

module("logic.extensions.airworkshop.view.message.AirWorkShopMessageLogTipsViewPresentor", package.seeall)

local M = class("AirWorkShopMessageLogTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_message_log_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopMessageLogTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
