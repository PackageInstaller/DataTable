-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsSkillDetailViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsSkillDetailViewPresentor", package.seeall)

local M = class("ToolTipsSkillDetailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_skill_detail_tips,
		ViewlibResPath.AuthorityTextItem,
		ViewlibResPath.ContractOrEchoTextItem,
		ViewlibResPath.BuffDetailItem1,
		ViewlibResPath.SkillItem1,
		ViewlibResPath.BreakLevelItem
	}
end

function M:buildViews()
	local views = {}

	self._clickView = ToolTipsPointerDownHandlerComp.New()

	table.insert(views, self._clickView)
	table.insert(views, ToolTipsSkillInfoComp.New())
	table.insert(views, ToolTipsSkillDetailComp.New())
	table.insert(views, ToolTipsHardSetPosComp.New())

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
