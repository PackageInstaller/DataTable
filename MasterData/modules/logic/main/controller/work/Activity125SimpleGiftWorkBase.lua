-- chunkname: @modules/logic/main/controller/work/Activity125SimpleGiftWorkBase.lua

module("modules.logic.main.controller.work.Activity125SimpleGiftWorkBase", package.seeall)

local Activity125SimpleGiftWorkBase = class("Activity125SimpleGiftWorkBase", SimpleGiftWorkBase)

function Activity125SimpleGiftWorkBase:onStart()
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
	Activity125SimpleGiftWorkBase.super.onStart(self)
end

function Activity125SimpleGiftWorkBase:clearWork()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
	Activity125SimpleGiftWorkBase.super.clearWork(self)
end

function Activity125SimpleGiftWorkBase:_onDataUpdate()
	local actId = self._actId
	local viewName = self._viewName

	if not actId then
		return
	end

	local activity125MO = Activity125Model.instance:getById(actId)

	if not activity125MO then
		return
	end

	local isClaimed = activity125MO:isEpisodeFinished(1)

	if isClaimed then
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

function Activity125SimpleGiftWorkBase:onWork(refWorkContext)
	local actId = self._actId
	local isOpen = ActivityHelper.getActivityStatus(actId, true) == ActivityEnum.ActivityStatus.Normal

	if isOpen then
		refWorkContext.bAutoWorkNext = false

		Activity125Rpc.instance:sendGetAct125InfosRequest(actId)
	else
		refWorkContext.bAutoWorkNext = true
	end
end

return Activity125SimpleGiftWorkBase
