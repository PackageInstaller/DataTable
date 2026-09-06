-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/model/DressSellModel.lua

module("logic.extensions.dressactivityshop.model.DressSellModel", package.seeall)

local DressSellModel = class("DressSellModel", BaseModel)

function DressSellModel:onReset()
	self._actId = 0
end

function DressSellModel:onGetInfo(msg)
	for k, v in ipairs(msg.dressList) do
		local info = {}

		info.id = checkint(v.id)
		info.isBuy = checkbool(v.isBuy)
		info.endTime = checkint(v.endTimeStamp)
		self._giftInfos[info.id] = info
	end
end

function DressSellModel:onBuyGoodSuc(msg)
	self:buySucGood(checkint(msg.id))
end

function DressSellModel:getCurActTimeCfg()
	local activityCfg = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.DiscountDressGift)

	for i, cfg in ipairs(activityCfg) do
		if ActivityDefineController.instance:isRelateServerBy(cfg.relatedAreaIds) and ActivityDefineController.instance:_isInActivityTimeByCfg(cfg) and cfg.activityId ~= 154004 then
			return cfg
		end
	end
end

function DressSellModel:setActId(actId)
	self:onReset()

	self._actId = actId
	self._giftInfos = {}
end

function DressSellModel:getCurActId()
	return self._actId
end

function DressSellModel:getInfo(goodId)
	if goodId then
		return self._giftInfos[checkint(goodId)]
	else
		return self._giftInfos[1]
	end
end

function DressSellModel:buySucGood(goodId)
	local info = self:getInfo(goodId)

	if info then
		info.isBuy = true
	end
end

DressSellModel.instance = DressSellModel.New()

return DressSellModel
