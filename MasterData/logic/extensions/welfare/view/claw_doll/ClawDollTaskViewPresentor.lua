-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollTaskViewPresentor.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollTaskViewPresentor", package.seeall)

local M = class("ClawDollTaskViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.ClawDoll_task_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ClawDollTaskView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
