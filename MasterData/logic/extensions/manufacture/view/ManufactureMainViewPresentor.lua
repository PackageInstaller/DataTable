-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureMainViewPresentor.lua

module("logic.extensions.manufacture.view.ManufactureMainViewPresentor", package.seeall)

local M = class("ManufactureMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_main_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ManufactureMainView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))
	table.insert(views, HouseTitleView.New())

	return views
end

return M
