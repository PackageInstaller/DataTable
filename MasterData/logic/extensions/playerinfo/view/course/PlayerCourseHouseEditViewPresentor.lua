-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseHouseEditViewPresentor.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseHouseEditViewPresentor", package.seeall)

local M = class("PlayerCourseHouseEditViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Course_show_facility_change_tips,
		ResName.Course_player_course_house_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerCourseHouseEditView.New())

	return views
end

return M
