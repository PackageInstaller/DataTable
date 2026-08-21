-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsSkillShowItemViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsSkillShowItemViewPresentor", package.seeall)

local M = class("ToolTipsSkillShowItemViewPresentor", ToolTipsSimpleViewPresentor)

function M:buildViews()
	local views = M.super.buildViews(self)

	table.insert(views, ToolTipsOnlyShowItemSkillComp.New())

	return views
end

return M
