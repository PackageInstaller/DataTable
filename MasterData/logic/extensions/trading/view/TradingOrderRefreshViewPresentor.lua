-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderRefreshViewPresentor.lua

module("logic.extensions.trading.view.TradingOrderRefreshViewPresentor", package.seeall)

local M = class("TradingOrderRefreshViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Dialog_message_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TradingOrderRefreshView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
