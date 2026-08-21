-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseCupEditView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseCupEditView", package.seeall)

local M = class("PlayerCourseCupEditView", PlayerCourseEditView)

function M:ctor()
	self._editType = GameEnum.DisplayTypeEnum.Cup
	self._itemPrefabName = "player_course_card_item"
	self._viewName = ViewName.PlayerCourseCupEditView
	self._cellCls = CourseCupItem
	self._callDataCls = CourseCupData
end

return M
