-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/message/AirWorkShopMsgLogViewPresentor.lua

module("logic.extensions.airworkshop.view.message.AirWorkShopMsgLogViewPresentor", package.seeall)

local M = class("AirWorkShopMsgLogViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_message_log_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopMsgLogView.New())

	local titleView = TitleView.New()

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)

	return views
end

return M
