-- chunkname: @modules/logic/main/controller/work/ActivityRoleSignWork_1_5.lua

module("modules.logic.main.controller.work.ActivityRoleSignWork_1_5", package.seeall)

local ActivityRoleSignWork_1_5 = class("ActivityRoleSignWork_1_5", ActivityRoleSignWorkBase)

function ActivityRoleSignWork_1_5:onGetViewNames()
	return {
		ViewName.V1a5_Role_PanelSignView_Part1,
		ViewName.V1a5_Role_PanelSignView_Part2,
		ViewName.V1a5_DoubleFestival_PanelSignView
	}
end

function ActivityRoleSignWork_1_5:onGetActIds()
	return {
		ActivityEnum.Activity.RoleSignViewPart1_1_5,
		ActivityEnum.Activity.RoleSignViewPart2_1_5,
		ActivityEnum.Activity.DoubleFestivalSign_1_5
	}
end

return ActivityRoleSignWork_1_5
