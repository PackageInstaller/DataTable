-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/discountaccruingpay/model/DiscountaccruingpayModel.lua

module("logic.extensions.discountaccruingpay.view.DiscountaccruingpayModel", package.seeall)

local DiscountaccruingpayModel = class("DiscountaccruingpayModel", BaseModel)

function DiscountaccruingpayModel:ctor()
	return
end

function DiscountaccruingpayModel:onInit()
	self:onReset()
end

function DiscountaccruingpayModel:onReset()
	self._infos = {}
	self._isGianExGift = false
end

function DiscountaccruingpayModel:setPayInfos(msg)
	self._infos = GameUtil.pbToTable(msg.infos)
	self._isGianExGift = msg.isGianExGift
end

function DiscountaccruingpayModel:getPayInfos()
	return self._infos
end

function DiscountaccruingpayModel:setBuyGiftInfo(info)
	local hasInfo = false

	for i, v in ipairs(self._infos) do
		if v.giftId == info.giftId then
			hasInfo = true
			v.buyTimes = info.buyTimes

			break
		end
	end

	if not hasInfo then
		table.insert(self._infos, info)
	end
end

function DiscountaccruingpayModel:hasGetExtraPrize()
	return self._isGianExGift
end

function DiscountaccruingpayModel:setGainExGiftRes(actId)
	self._isGianExGift = true
end

DiscountaccruingpayModel.instance = DiscountaccruingpayModel.New()

return DiscountaccruingpayModel
