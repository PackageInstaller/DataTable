-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/SkillSmallTipsViewPresentor.lua

module("logic.extensions.common.view.SkillSmallTipsViewPresentor", package.seeall)

local M = class("SkillSmallTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_CardSkill_small_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SkillSmallTipsView.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

return M
