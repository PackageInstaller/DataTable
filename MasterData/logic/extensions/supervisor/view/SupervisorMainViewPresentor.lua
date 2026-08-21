-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorMainViewPresentor.lua

module("logic.extensions.supervisor.view.SupervisorMainViewPresentor", package.seeall)

local M = class("SupervisorMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_main_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SupervisorMainView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))
	table.insert(views, HouseTitleView.New())

	return views
end

return M
