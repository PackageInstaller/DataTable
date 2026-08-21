-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseHouseViewPresentor.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseHouseViewPresentor", package.seeall)

local M = class("PlayerCourseHouseViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Course_player_course_base_panel,
		M.Url_Roguelike_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerCourseHouseView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
