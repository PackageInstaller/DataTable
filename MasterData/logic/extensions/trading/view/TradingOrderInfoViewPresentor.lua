-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderInfoViewPresentor.lua

module("logic.extensions.trading.view.TradingOrderInfoViewPresentor", package.seeall)

local M = class("TradingOrderInfoViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_trade_order_details_tips,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TradingOrderInfoView.New())

	return views
end

return M
