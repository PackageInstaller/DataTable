-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HouseGMScheduleViewPresentor.lua

module("logic.extensions.house.view.gm.HouseGMScheduleViewPresentor", package.seeall)

local M = class("HouseGMScheduleViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Main_schedule_select_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseGMScheduleView.New())

	return views
end

return M
