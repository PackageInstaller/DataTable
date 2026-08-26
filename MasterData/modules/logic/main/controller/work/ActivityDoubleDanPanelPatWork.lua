-- chunkname: @modules/logic/main/controller/work/ActivityDoubleDanPanelPatWork.lua

module("modules.logic.main.controller.work.ActivityDoubleDanPanelPatWork", package.seeall)

local ActivityDoubleDanPanelPatWork = class("ActivityDoubleDanPanelPatWork", ActivityRoleSignWorkBase)

function ActivityDoubleDanPanelPatWork:onGetViewNames()
	local viewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)

	if not string.nilorempty(viewName) then
		return {
			viewName
		}
	end

	viewName = GameBranchMgr.instance:Vxax_ViewName("DoubleDanActivity_PanelView", ViewName.V3a3_DoubleDanActivity_PanelView)

	return {
		viewName
	}
end

function ActivityDoubleDanPanelPatWork:onGetActIds()
	return {
		(ActivityType101Config.instance:getDoubleDanActId())
	}
end

return ActivityDoubleDanPanelPatWork
