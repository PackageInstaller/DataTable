-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/DeviceUpgradeSucceedViewPresentor.lua

module("logic.extensions.house.view.common.DeviceUpgradeSucceedViewPresentor", package.seeall)

local M = class("DeviceUpgradeSucceedViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_upgrade_succeed_tips,
		ResName.Room_facility_yield_unlock_cell
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, DeviceUpgradeSucceedView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
