-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/model/FightAgainstLandlordsModel.lua

module("logic.extensions.landlords.model.FightAgainstLandlordsModel", package.seeall)

local FightAgainstLandlordsModel = class("FightAgainstLandlordsModel", BaseModel)

function FightAgainstLandlordsModel:ctor()
	return
end

function FightAgainstLandlordsModel:onInit()
	self:onReset()
end

function FightAgainstLandlordsModel:onReset()
	self._falCustomFmtMo = nil
	self._pkInfoMsg = {}
	self._rankMsg = {}
	self._supplyInfoMsg = {}
	self._dealCardMsg = {}
	self._formSetMsg = {}
	self._formShowMsg = {}
	self._recordInfoListInBR = {}
	self._battleResultMsg = nil
	self._getSimpleRecordMsg = {}
	self._isFirstShowPets = false
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKInfoRes(msg)
	self._pkInfoMsg = msg
	self._tokenScore = msg.tokenScore
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKGetDailySuppluGainRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes(msg)
	self._supplyInfoMsg = msg
	self._tokenScore = msg.tokenScore
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKGetOnlineTimeSupplyGainRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKRankViewRes(msg)
	self._rankMsg = msg
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKGetBattleRecordRes(msg)
	self._recordInfoListInBR = {}

	for idx, v in ipairs(msg.records) do
		local info = {}

		info.idx = idx
		info.msg = v

		local recordMo = FalBatRecordMo.New()

		recordMo:init(v.simpleRecord)

		info.recordMo = recordMo
		self._recordInfoListInBR[idx] = info
	end
end

function FightAgainstLandlordsModel:getRecordInfoListInBR()
	return self._recordInfoListInBR or {}
end

function FightAgainstLandlordsModel:getRecordInfoInBR(idx)
	return self:getRecordInfoListInBR()[idx]
end

function FightAgainstLandlordsModel:getRecordMoInBR(idx)
	local info = self:getRecordInfoInBR(idx)

	return info.recordMo
end

function FightAgainstLandlordsModel:getTimeMillsInBR(idx)
	local info = self:getRecordInfoInBR(idx)

	return info.msg.timeMills
end

function FightAgainstLandlordsModel:getBattleIdInBR(idx)
	local info = self:getRecordInfoInBR(idx)

	return info.msg.battleId
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKGetSimpleRecordRes(msg)
	local recordMo = FalBatRecordMo.New()

	recordMo:init(msg.record)

	self._getSimpleRecordMsg.recordMo = recordMo
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKGetBattleVideoRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKMatchRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKCancelMatchRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKLandlordRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKFormSetRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKChatRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKNotifyDealCardRes(msg)
	self._dealCardMsg = msg
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKNotifyLandlordsAckRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKNotifyLandlordsCofirmRes(msg)
	return
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKNotifyLandlordsFormSetRes(msg)
	self._formSetMsg = msg
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKNotifyLandlordsFormShowRes(msg)
	self._formShowMsg = msg
end

function FightAgainstLandlordsModel:handlePM_LandlordsPKNotifyBattleResultRes(msg)
	self._battleResultMsg = msg
end

function FightAgainstLandlordsModel:getTokenScore()
	return checknumber(self._tokenScore)
end

function FightAgainstLandlordsModel:getPlayNum()
	return self._pkInfoMsg.playNum or 0
end

function FightAgainstLandlordsModel:getDailyLosePrizeTimes()
	return self._pkInfoMsg.dailyLosePrizeTimes or 0
end

function FightAgainstLandlordsModel:isCanGainLostPrize()
	local times = checknumber(FightAgainstLandlordsConfig.instance:getFalCommonValue("DAILY_LOSE_PRIZE_TIMES"))

	return times - (self._pkInfoMsg.dailyLosePrizeTimes or 0) > 0
end

function FightAgainstLandlordsModel:isHasGainDailySupply()
	return self._supplyInfoMsg.dailySupplyGain == true
end

function FightAgainstLandlordsModel:getActivateTimeStamp()
	return self._supplyInfoMsg.activateTime or 0
end

function FightAgainstLandlordsModel:getOnlineTimeSec()
	return checknumber(self._supplyInfoMsg.onlineTimeSec)
end

function FightAgainstLandlordsModel:getTotalOnlineTimeSec()
	return checknumber(self._supplyInfoMsg.gainOnlineTimeSecGet)
end

function FightAgainstLandlordsModel:getMyRank()
	return self._rankMsg.myRank
end

function FightAgainstLandlordsModel:getRankInfoList()
	return self._rankMsg.ranks
end

function FightAgainstLandlordsModel:getRecordMoInSimpleRecord()
	return self._getSimpleRecordMsg.recordMo
end

function FightAgainstLandlordsModel:getFalCustomFmtMo()
	if self._falCustomFmtMo == nil then
		self._falCustomFmtMo = FalCustomFmtMo.New()
	end

	return self._falCustomFmtMo
end

function FightAgainstLandlordsModel:getLandlordsCardsInDealCard()
	return {}
end

function FightAgainstLandlordsModel:getLandlordsBuffsInDealCard()
	return self._dealCardMsg.landlordsBuffs or {}
end

function FightAgainstLandlordsModel:getBattleResultMsg()
	return self._battleResultMsg
end

function FightAgainstLandlordsModel:getPetMoAsFal(petId)
	local creepsData = FightAgainstLandlordsConfig.instance:getFalCreepsData(petId)

	if creepsData then
		self._fmo = self._fmo or FightingPowerPetMo.New()

		self._fmo:fromChallengeCreepCo(creepsData)

		return (self._fmo:toBaseBagPetMo())
	end

	return nil
end

FightAgainstLandlordsModel.instance = FightAgainstLandlordsModel.New()

return FightAgainstLandlordsModel
