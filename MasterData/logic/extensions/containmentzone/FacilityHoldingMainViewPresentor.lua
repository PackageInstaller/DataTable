-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/FacilityHoldingMainViewPresentor.lua

module("logic.extensions.containmentzone.FacilityHoldingMainViewPresentor", package.seeall)

local M = class("FacilityHoldingMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_main_view,
		CommonResPath.Url_Currency_Item,
		ResName.Room_facility_holding_facility_holding_point
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingMainView.New())
	table.insert(views, FacilityHoldingPointView.New())
	table.insert(views, HouseTitleView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))

	return views
end

return M
