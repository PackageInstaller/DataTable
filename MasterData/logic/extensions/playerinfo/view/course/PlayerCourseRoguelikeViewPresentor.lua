-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseRoguelikeViewPresentor.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseRoguelikeViewPresentor", package.seeall)

local M = class("PlayerCourseRoguelikeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Course_player_course_rungroup_panel,
		ResName.Course_player_course_roguelike_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerCourseRoguelikeView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
