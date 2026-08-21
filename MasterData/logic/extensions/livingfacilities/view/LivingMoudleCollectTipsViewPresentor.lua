-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingMoudleCollectTipsViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingMoudleCollectTipsViewPresentor", package.seeall)

local M = class("LivingMoudleCollectTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_living_moudle_collect_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingMoudleCollectTipsView.New())

	return views
end

return M
