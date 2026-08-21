-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseHeroEditView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseHeroEditView", package.seeall)

local M = class("PlayerCourseHeroEditView", PlayerCourseEditView)

function M:ctor()
	self._editType = GameEnum.DisplayTypeEnum.Hero
	self._itemPrefabName = "player_course_hero_item"
	self._viewName = ViewName.PlayerCourseHeroEditView
	self._cellCls = CourseHeroItem
	self._callDataCls = CourseCharacterData
end

return M
