-- chunkname: @modules/logic/main/controller/work/ActivityRoleSignWorkBase.lua

module("modules.logic.main.controller.work.ActivityRoleSignWorkBase", package.seeall)

local ActivityRoleSignWorkBase = class("ActivityRoleSignWorkBase", SimpleGiftWorkBase)

function ActivityRoleSignWorkBase:onStart()
	ActivityRoleSignWorkBase.super.onStart(self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
end

function ActivityRoleSignWorkBase:clearWork()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
	ActivityRoleSignWorkBase.super.clearWork(self)
end

function ActivityRoleSignWorkBase:_refreshNorSignActivity()
	local actId = self._actId
	local viewName = self._viewName

	if not actId then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId) then
		if ViewMgr.instance:isOpen(viewName) then
			return
		end

		self:_work()

		return
	end

	local viewParam = {
		actId = actId
	}

	ViewMgr.instance:openView(viewName, viewParam)
end

function ActivityRoleSignWorkBase:onWork(refWorkContext)
	local actId = self._actId

	if ActivityType101Model.instance:isOpen(actId) then
		refWorkContext.bAutoWorkNext = false

		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	else
		refWorkContext.bAutoWorkNext = true
	end
end

return ActivityRoleSignWorkBase
