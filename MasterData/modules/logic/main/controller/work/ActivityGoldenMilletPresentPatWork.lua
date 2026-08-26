-- chunkname: @modules/logic/main/controller/work/ActivityGoldenMilletPresentPatWork.lua

module("modules.logic.main.controller.work.ActivityGoldenMilletPresentPatWork", package.seeall)

local ActivityGoldenMilletPresentPatWork = class("ActivityGoldenMilletPresentPatWork", ActivityRoleSignWorkBase)

function ActivityGoldenMilletPresentPatWork:onGetViewNames()
	local viewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)

	if not string.nilorempty(viewName) then
		return {
			viewName
		}
	end

	viewName = GameBranchMgr.instance:Vxax_ViewName("GoldenMilletPresent", ViewName.GoldenMilletPresent)

	return {
		viewName
	}
end

function ActivityGoldenMilletPresentPatWork:onGetActIds()
	return {
		(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId())
	}
end

return ActivityGoldenMilletPresentPatWork
