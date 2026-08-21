-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesStatisticsTipsViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesStatisticsTipsViewPresentor", package.seeall)

local M = class("LivingFacilitiesStatisticsTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_live_furniture_statistics_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingFacilitiesStatisticsTipsView.New())

	return views
end

return M
