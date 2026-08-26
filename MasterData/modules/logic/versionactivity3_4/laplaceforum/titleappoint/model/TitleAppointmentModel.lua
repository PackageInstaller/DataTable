-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/titleappoint/model/TitleAppointmentModel.lua

module("modules.logic.versionactivity3_4.laplaceforum.titleappoint.model.TitleAppointmentModel", package.seeall)

local TitleAppointmentModel = class("TitleAppointmentModel", BaseModel)

function TitleAppointmentModel:onInit()
	self:reInit()
end

function TitleAppointmentModel:reInit()
	self._curRewardIndex = 0
	self._loopRewardCount = 0
end

function TitleAppointmentModel:setHasGetRewardId(index)
	self._curRewardIndex = index
end

function TitleAppointmentModel:getHasGetRewardId()
	return self._curRewardIndex
end

function TitleAppointmentModel:setLoopRewardCount(count)
	self._loopRewardCount = count
end

function TitleAppointmentModel:getLoopRewardCount()
	return self._loopRewardCount
end

function TitleAppointmentModel:hasRewardCouldGet()
	local id = tonumber(TitleAppointmentConfig.instance:getConstCO(1).value)
	local currency = CurrencyModel.instance:getCurrency(id)

	return currency.quantity > self._curRewardIndex
end

function TitleAppointmentModel:getPopularValueCount()
	local constCo = TitleAppointmentConfig.instance:getConstCO(1)

	if not constCo then
		return 0
	end

	local itemId = tonumber(constCo.value)
	local currencyMO = CurrencyModel.instance:getCurrency(itemId)

	if not currencyMO then
		return 0
	end

	return currencyMO.quantity
end

function TitleAppointmentModel:getCurSpRewardProgress()
	local bonusCos = TitleAppointmentConfig.instance:getMilestoneBonusCos()

	if self._curRewardIndex >= #bonusCos then
		return 0
	end

	for i = self._curRewardIndex + 1, #bonusCos do
		if bonusCos[i].isSpBonus then
			return bonusCos[i].coinNum, i
		end
	end

	return 0
end

function TitleAppointmentModel:getCurRewardIndex()
	local count = self:getPopularValueCount()
	local bonusCos = TitleAppointmentConfig.instance:getMilestoneBonusCos()

	if count < bonusCos[2].coinNum then
		return 1
	end

	for i = 2, #bonusCos - 1 do
		if count >= bonusCos[i].coinNum and count < bonusCos[i + 1].coinNum then
			return i
		end
	end

	return #bonusCos
end

function TitleAppointmentModel:isRewardCouldGet(index)
	if index <= self._curRewardIndex then
		return false
	end

	local curIndex = self:getCurRewardIndex()

	return index <= curIndex
end

function TitleAppointmentModel:isRewardHasGet(index)
	return index <= self._curRewardIndex
end

function TitleAppointmentModel:getTargetTitle()
	local curIndex = self:getCurRewardIndex()
	local bonusCos = TitleAppointmentConfig.instance:getMilestoneBonusCos()

	for i = curIndex, 1, -1 do
		if bonusCos[i].titleId > 0 then
			return bonusCos[i].titleId
		end
	end

	return 0
end

function TitleAppointmentModel:getTargetGuideBonusId(curRewardId)
	local bonusCos = TitleAppointmentConfig.instance:getMilestoneBonusCos()

	for i = curRewardId, #bonusCos do
		if bonusCos[i].titleId > 0 then
			return i
		end
	end

	for i = #bonusCos, 1, -1 do
		if bonusCos[i].titleId > 0 then
			return i
		end
	end

	return 0
end

function TitleAppointmentModel:isLoopBonus(index)
	local bonusCo = TitleAppointmentConfig.instance:getMilestoneBonusCo(index)

	return bonusCo and bonusCo.isLoopBonus
end

function TitleAppointmentModel:getTitleStageByPopularCount(count)
	local bonusCos = TitleAppointmentConfig.instance:getMilestoneBonusCos()

	if count >= bonusCos[#bonusCos].coinNum then
		local interver = math.floor((count - bonusCos[#bonusCos].coinNum) / bonusCos[#bonusCos].loopBonusIntervalNum)

		return #bonusCos + interver
	end

	for i = 1, #bonusCos - 1 do
		if count >= bonusCos[i].coinNum and count < bonusCos[i + 1].coinNum then
			return i
		end
	end
end

TitleAppointmentModel.instance = TitleAppointmentModel.New()

return TitleAppointmentModel
