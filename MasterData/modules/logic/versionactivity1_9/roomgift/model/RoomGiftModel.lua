-- chunkname: @modules/logic/versionactivity1_9/roomgift/model/RoomGiftModel.lua

module("modules.logic.versionactivity1_9.roomgift.model.RoomGiftModel", package.seeall)

local RoomGiftModel = class("RoomGiftModel", BaseModel)

function RoomGiftModel:onInit()
	self:setActivityInfo()
end

function RoomGiftModel:reInit()
	self:onInit()
end

function RoomGiftModel:getActId()
	return ActivityEnum.Activity.RoomGift
end

function RoomGiftModel:setActivityInfo(msg)
	local tmpMsg = msg or {}

	self:setCurDay(tmpMsg.currentDay)
	self:setHasGotBonus(tmpMsg.hasGetBonus)
end

function RoomGiftModel:setCurDay(curDay)
	self._curDay = curDay
end

function RoomGiftModel:setHasGotBonus(hasGot)
	self._hasGotBonus = hasGot
end

function RoomGiftModel:getHasGotBonus()
	return self._hasGotBonus
end

function RoomGiftModel:isActOnLine(isToast)
	local result = false
	local actId = self:getActId()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId, true)

	if status == ActivityEnum.ActivityStatus.Normal then
		result = true
	elseif isToast and toastId then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end

	return result
end

function RoomGiftModel:isCanGetBonus()
	local result = false
	local isOnline = self:isActOnLine()

	if isOnline then
		local actId = self:getActId()
		local hasBonus = RoomGiftConfig.instance:getRoomGiftBonus(actId, self._curDay)

		if hasBonus then
			local hasGotBonus = self:getHasGotBonus()

			if hasGotBonus ~= nil then
				result = not hasGotBonus
			end
		end
	end

	return result
end

RoomGiftModel.instance = RoomGiftModel.New()

return RoomGiftModel
