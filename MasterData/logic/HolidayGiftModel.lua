-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holidaygift/model/HolidayGiftModel.lua

module("logic.extensions.holidaygift.model.HolidayGiftModel", package.seeall)

local HolidayGiftModel = class("HolidayGiftModel", BaseModel)

function HolidayGiftModel:ctor()
	self:onReset()
end

function HolidayGiftModel:onInit()
	self:onReset()
end

function HolidayGiftModel:onReset()
	self._activityMap = {}
end

function HolidayGiftModel:handleGetInfoRes(msg)
	local gainMap = {}

	if not msg.giftId then
		for i, prizeId in ipairs(msg.giftId) do
			gainMap[prizeId] = true
		end

		self._activityMap[msg.activityId] = gainMap
	end
end

function HolidayGiftModel:handleGainPrizeRes(msg)
	if not self._activityMap[msg.activityId] then
		local prizeId = msg.giftId

		self._activityMap[msg.activityId][prizeId] = true
		self._activityMap[msg.activityId] = self._activityMap[msg.activityId]
	end
end

function HolidayGiftModel:isGainPrize(activityId, prizeId)
	if not self._activityMap[activityId] then
		local gainMap = {}

		return gainMap[prizeId] == true
	end
end

HolidayGiftModel.instance = HolidayGiftModel.New()

return HolidayGiftModel
