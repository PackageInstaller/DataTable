-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/model/ZeropayModel.lua

module("logic.extensions.zeropay.view.ZeropayModel", package.seeall)

local ZeropayModel = class("ZeropayModel", BaseModel)

function ZeropayModel:ctor()
	return
end

function ZeropayModel:onInit()
	self:onReset()
end

function ZeropayModel:onReset()
	self._actId = false
	self._hasBuyGift = {}
	self._buyTimes = 0
end

function ZeropayModel:setGiftInfo(msg)
	self._actId = msg.activityId
	self._hasBuyGift = msg.hasBuyGift
	self._buyTimes = msg.buyTimes
end

function ZeropayModel:isBuyGift(actId, giftId)
	local buy = false

	if self._actId == actId then
		for i, v in ipairs(self._hasBuyGift) do
			buy = v == giftId

			if buy then
				break
			end
		end
	end

	return buy
end

function ZeropayModel:buyGiftRes(msg)
	if self._actId == msg.activityId then
		table.insert(self._hasBuyGift, msg.giftId)
	end

	self._buyTimes = self._buyTimes + 1
end

function ZeropayModel:getBuyTimes()
	return self._buyTimes
end

ZeropayModel.instance = ZeropayModel.New()

return ZeropayModel
