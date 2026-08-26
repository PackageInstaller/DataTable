-- chunkname: @modules/logic/sp02/paomian/marcus/model/Sp02_MarcusModel.lua

module("modules.logic.sp02.paomian.marcus.model.Sp02_MarcusModel", package.seeall)

local Sp02_MarcusModel = class("Sp02_MarcusModel", BaseModel)

function Sp02_MarcusModel:initInfo(rpcInfo)
	self._activityId = rpcInfo.activityId
	self._bonusInfoMap = GameUtil.rpcInfosToMap(rpcInfo.bonuss, Sp02_MarcusBonusInfoMO, "_id")

	Sp02_PaoMianController.instance:dispatchEvent(Sp02_MarcusEvent.OnUpdateMarcus)
end

function Sp02_MarcusModel:getBonusInfo(actId, id)
	if actId ~= self._activityId then
		return
	end

	return self._bonusInfoMap and self._bonusInfoMap[id]
end

function Sp02_MarcusModel:getStatus(actId, id)
	local bonusInfo = self:getBonusInfo(actId, id)

	return bonusInfo and bonusInfo:getStatus() or Sp02_MarcusEnum.BonusStatus.Lock
end

function Sp02_MarcusModel:isFirstLock(actId, id)
	local status = self:getStatus(actId, id)

	if status ~= Sp02_MarcusEnum.BonusStatus.Lock then
		return
	end

	local maxRunTime = 100
	local curRunTime = 0
	local preId = Sp02_MarcusConfig.instance:getPreBonusId(actId, id)

	while preId and preId ~= 0 and curRunTime < maxRunTime do
		curRunTime = curRunTime + 1

		local preBonusStatus = self:getStatus(actId, preId)

		if preBonusStatus == Sp02_MarcusEnum.BonusStatus.Lock then
			return false
		end

		preId = Sp02_MarcusConfig.instance:getPreBonusId(actId, preId)
	end

	return true
end

function Sp02_MarcusModel:getBonusArriveOpenRemainTime(actId, id)
	local openTime = Sp02_MarcusConfig.instance:getBonusOpenTime(actId, id)
	local limitTime = openTime - ServerTime.now()

	return math.max(limitTime, 0, limitTime)
end

function Sp02_MarcusModel:getNextOpenBonus(actId)
	local bonusCoList = Sp02_MarcusConfig.instance:getBonusList(actId)

	if not bonusCoList then
		return
	end

	for _, bonusCo in ipairs(bonusCoList) do
		local status = self:getStatus(bonusCo.activityId, bonusCo.id)

		if status == Sp02_MarcusEnum.BonusStatus.Lock then
			return bonusCo
		end
	end
end

function Sp02_MarcusModel:getNextOpenBonusTime(actId)
	local bonusCoList = Sp02_MarcusConfig.instance:getBonusList(actId)

	if not bonusCoList then
		return
	end

	for _, bonusCo in ipairs(bonusCoList) do
		local limitOpenTime = self:getBonusArriveOpenRemainTime(bonusCo.activityId, bonusCo.id)

		if limitOpenTime and limitOpenTime > 0 then
			return limitOpenTime, bonusCo
		end
	end
end

Sp02_MarcusModel.instance = Sp02_MarcusModel.New()

return Sp02_MarcusModel
