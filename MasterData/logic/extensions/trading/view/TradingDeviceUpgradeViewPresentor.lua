-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingDeviceUpgradeViewPresentor.lua

module("logic.extensions.trading.view.TradingDeviceUpgradeViewPresentor", package.seeall)

local M = class("TradingDeviceUpgradeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_upgrade_tips,
		ResName.Room_facility_yield_unlock_cell,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TradingDeviceUpgradeView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.RoomUpgradeShowType))

	return views
end

return M
