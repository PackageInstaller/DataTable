-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseRoguelikeWidgets.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseRoguelikeWidgets", package.seeall)

local M = class("CourseRoguelikeWidgets", PlayerCourseWidgets)

function M:ctor(view)
	self._view = view
	self._editType = GameEnum.DisplayTypeEnum.Roguelike
end

function M:buildUI()
	local view = self._view

	self._txtCount = view:getText("player_course_panel_1154112399")
	self._txtRate = view:getText("player_course_panel_1469298570")
	self._btnMore = view:getBtn("player_course_panel_1020295774")

	local go = view:getGo("player_course_panel_1168317531")

	return M.super.buildEditUI(self, go)
end

function M:onInit()
	M.super.init(self)

	if not self._locked then
		self._txtCount.text = self._data:getTotalPassCount()
		self._txtRate.text = string.format("%.0f%%", math.floor(self._data:getTotalFinishedRate() * 100))
	end
end

function M:bindEvents()
	self._btnMore:AddClickListener(self._onClickMore, self)
end

function M:unbindEvents()
	self._btnMore:RemoveClickListener()
end

function M:setIsInEdit(isInEdit)
	M.super.setIsInEdit(self, isInEdit)
end

function M:_onClickMore()
	ViewMgr.instance:open(ViewName.PlayerCourseRoguelikeView)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._txtCount = nil
	self._txtRate = nil
	self._btnMore = nil
end

return M
