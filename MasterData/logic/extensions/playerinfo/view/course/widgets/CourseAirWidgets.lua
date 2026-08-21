-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseAirWidgets.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseAirWidgets", package.seeall)

local M = class("CourseAirWidgets", PlayerCourseWidgets)

function M:ctor(view)
	self._view = view
	self._editType = GameEnum.DisplayTypeEnum.AirStudio
end

function M:buildUI()
	local view = self._view
	local go = view:getGo("player_course_panel_1293840277")

	return M.super.buildEditUI(self, go)
end

function M:onInit()
	M.super.init(self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setIsInEdit(isInEdit)
	M.super.setIsInEdit(self, isInEdit)
end

function M:destroyUI()
	M.super.destroyUI(self)
end

return M
