-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsSkillBuffTagTipsViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsSkillBuffTagTipsViewPresentor", package.seeall)

local M = class("ToolTipsSkillBuffTagTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_skill_buff_tag_tips
	}
end

function M:buildViews()
	local views = {}

	self._clickView = ToolTipsPointerDownHandlerComp.New()

	table.insert(views, self._clickView)
	table.insert(views, ToolTipsSkillBuffTagTipsViewComp.New())
	table.insert(views, ToolTipsFixTipsPosComp.New())

	return views
end

function M:_onCloseAnimationDone()
	if self._clickView._isDraging then
		self._clickView:simulateCloseWhenDraging()
	else
		M.super._onCloseAnimationDone(self)
	end
end

function M:closeWhenDragEnd()
	M.super._onCloseAnimationDone(self)
end

return M
