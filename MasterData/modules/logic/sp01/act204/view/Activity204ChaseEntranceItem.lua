-- chunkname: @modules/logic/sp01/act204/view/Activity204ChaseEntranceItem.lua

module("modules.logic.sp01.act204.view.Activity204ChaseEntranceItem", package.seeall)

local Activity204ChaseEntranceItem = class("Activity204ChaseEntranceItem", Activity204EntranceItemBase)

function Activity204ChaseEntranceItem:init(go)
	Activity204ChaseEntranceItem.super.init(self, go)
end

function Activity204ChaseEntranceItem:addEventListeners()
	Activity204ChaseEntranceItem.super.addEventListeners(self)
end

function Activity204ChaseEntranceItem:removeEventListeners()
	Activity204ChaseEntranceItem.super.removeEventListeners(self)
end

function Activity204ChaseEntranceItem:initActInfo(actId)
	Activity204ChaseEntranceItem.super.initActInfo(self, actId)

	self._fakeEndTimeStamp = AssassinChaseHelper.getActivityEndTimeStamp(self._endTime)
end

function Activity204ChaseEntranceItem:_getTimeStr()
	if not self._actMo then
		return
	end

	local status = self:_getActivityStatus()

	return self:_decorateTimeStr(status, self._startTime, self._fakeEndTimeStamp)
end

function Activity204ChaseEntranceItem:_getActivityStatus()
	local status, toastId = Activity204ChaseEntranceItem.super._getActivityStatus(self)

	if status == ActivityEnum.ActivityStatus.Normal then
		local isActOpen = AssassinChaseModel.instance:isActOpen(self._actId, false, false)
		local hasReward = AssassinChaseModel.instance:isActHaveReward(self._actId)
		local isCanEnter = isActOpen or hasReward

		status = isCanEnter and ActivityEnum.ActivityStatus.Normal or ActivityEnum.ActivityStatus.Expired
		toastId = isCanEnter and toastId or ToastEnum.ActivityEnd
	end

	return status, toastId
end

return Activity204ChaseEntranceItem
