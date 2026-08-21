-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureUpgradeViewPresentor.lua

module("logic.extensions.manufacture.view.ManufactureUpgradeViewPresentor", package.seeall)

local M = class("ManufactureUpgradeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_upgrade_tips,
		ResName.Room_facility_yield_unlock_cell,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ManufactureUpgradeView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.RoomUpgradeShowType))

	return views
end

return M
