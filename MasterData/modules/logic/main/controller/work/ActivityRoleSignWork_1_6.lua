-- chunkname: @modules/logic/main/controller/work/ActivityRoleSignWork_1_6.lua

module("modules.logic.main.controller.work.ActivityRoleSignWork_1_6", package.seeall)

local ActivityRoleSignWork_1_6 = class("ActivityRoleSignWork_1_6", ActivityRoleSignWorkBase)

function ActivityRoleSignWork_1_6:onGetViewNames()
	return {
		ViewName.V1a6_Role_PanelSignView_Part1,
		ViewName.V1a6_Role_PanelSignView_Part2
	}
end

function ActivityRoleSignWork_1_6:onGetActIds()
	return {
		ActivityEnum.Activity.RoleSignViewPart1_1_6,
		ActivityEnum.Activity.RoleSignViewPart2_1_6
	}
end

return ActivityRoleSignWork_1_6
