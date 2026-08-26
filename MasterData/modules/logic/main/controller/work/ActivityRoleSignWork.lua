-- chunkname: @modules/logic/main/controller/work/ActivityRoleSignWork.lua

module("modules.logic.main.controller.work.ActivityRoleSignWork", package.seeall)

local ActivityRoleSignWork = class("ActivityRoleSignWork", ActivityRoleSignWorkBase)

function ActivityRoleSignWork:onGetViewNames()
	return {
		ViewName.Role_PanelSignView_Part1,
		ViewName.Role_PanelSignView_Part2
	}
end

function ActivityRoleSignWork:onGetActIds()
	return ActivityType101Config.instance:getRoleSignActIdList()
end

return ActivityRoleSignWork
