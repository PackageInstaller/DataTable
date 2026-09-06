-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/model/RebateMallModel.lua

module("logic.extensions.doubleeleven.model.RebateMallModel", package.seeall)

local RebateMallModel = class("RebateMallModel", BaseModel)

function RebateMallModel:ctor()
	return
end

function RebateMallModel:onInit()
	self:onReset()
end

function RebateMallModel:onReset()
	self._mallRechargeInfo = {}
	self._mallBuyInfo = {}
end

function RebateMallModel:setMallRechargeInfo(msg)
	table.clear(self._mallRechargeInfo)
	GameUtil.pbToTable(msg, self._mallRechargeInfo)
end

function RebateMallModel:getRechargeMoney()
	return self._mallRechargeInfo.rechargeMoney or 0
end

function RebateMallModel:isGainPrize(prizeId)
	return TableUtil.isHad(self._mallRechargeInfo.gainProgressPrizeIds, prizeId)
end

function RebateMallModel:setBuyInfo(msg)
	table.clear(self._mallBuyInfo)
	GameUtil.pbToTable(msg, self._mallBuyInfo)
end

function RebateMallModel:getBuyInfo()
	return self._mallBuyInfo
end

RebateMallModel.instance = RebateMallModel.New()

return RebateMallModel
