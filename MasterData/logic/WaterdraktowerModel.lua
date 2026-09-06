-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/model/WaterdraktowerModel.lua

module("logic.extensions.waterdraktower.view.WaterdraktowerModel", package.seeall)

local WaterdraktowerModel = class("WaterdraktowerModel", BaseModel)

function WaterdraktowerModel:ctor()
	self.openActType = 59
	self.openActId = nil
	self.openTowerType = 1
	self._baseInfo = nil
end

function WaterdraktowerModel:onInit()
	self:onReset()
end

function WaterdraktowerModel:onReset()
	self._baseInfo = nil
	self._tier = 0
	self._stage = 0
	self._clgTimes = 0
	self._buyTimes = 0
	self._daylyBuyTimes = 0
	self._specialPrizeNum = 0
	self._curFormation = nil
	self._isGianFinalPrize = false
end

function WaterdraktowerModel:setInfo(msg)
	self._tier = msg.tier
	self._stage = msg.stage
	self._clgTimes = msg.clgTimes
	self._buyTimes = msg.buyTimes
	self._daylyBuyTimes = msg.dailyBuyTimes
	self._specialPrizeNum = msg.specialPrizeNum
	self._isGianFinalPrize = msg.isGianFinalPrize
end

function WaterdraktowerModel:getPassTier()
	return self._tier
end

function WaterdraktowerModel:getPassStage()
	return self._stage
end

function WaterdraktowerModel:getSpecialPrizeNum()
	return self._specialPrizeNum
end

function WaterdraktowerModel:getBuyTime()
	return self._buyTimes
end

function WaterdraktowerModel:getDayliBuyTime()
	return self._daylyBuyTimes
end

function WaterdraktowerModel:getClgTimes()
	return self._clgTimes
end

function WaterdraktowerModel:isGetLastExtReward()
	return self._isGianFinalPrize
end

function WaterdraktowerModel:addBuyTime()
	self._buyTimes = self._buyTimes + 1
end

function WaterdraktowerModel:getWaterDarkTowerInfo()
	if self._baseInfo == nil then
		self._baseInfo = {}
		self._baseInfo.tier = 0
		self._baseInfo.stage = 0
		self._baseInfo.clgTimes = 0
		self._baseInfo.buyTimes = 0
		self._baseInfo.dailyBuyTimes = 0
		self._baseInfo.specialPrizeNum = 0
		self._baseInfo.isGianFinalPrize = false
	end

	return self._baseInfo
end

function WaterdraktowerModel:getTierStageIndexAndList()
	local targetList = self:getAllTierStageCfgs()

	if targetList == nil or #targetList == 0 then
		return nil, 0, false
	end

	if self._baseInfo == nil or checknumber(self._baseInfo.tier) <= 0 then
		return targetList, 1, false
	end

	if self._baseInfo.isGianFinalPrize then
		return targetList, #targetList, true
	end

	local index = 0

	for i = 1, #targetList do
		if (targetList[i].tier < self._baseInfo.tier or targetList[i].tier == self._baseInfo.tier and targetList[i].stage <= self._baseInfo.stage) and index < i then
			index = i
		end
	end

	if index < #targetList then
		index = index + 1
	end

	return targetList, index, false
end

function WaterdraktowerModel:getAllTierStageCfgs()
	local actCfg = WaterdraktowerConfig.instance:getTierCommCfg(self.openActId)

	if actCfg == nil or checknumber(actCfg.challengePlanId) <= 0 then
		return
	end

	local allCfgs = WaterdraktowerConfig.instance:getTierChallengeCfgs(actCfg.challengePlanId, self.openTowerType)
	local targetList = {}

	for _, list in pairs(allCfgs) do
		for _, cfg in pairs(list or {}) do
			if cfg and checknumber(cfg.planId) == actCfg.challengePlanId and not string.nilorempty(cfg.prize) then
				table.insert(targetList, {
					planId = cfg.planId,
					towerType = cfg.towerType,
					tier = cfg.tier,
					stage = cfg.stage,
					prize = string.split(cfg.prize, "#"),
					name = cfg.name,
					level = cfg.level,
					creepsMasterId = cfg.creepsMasterId,
					cutDownPlanId = cfg.cutDownPlanId,
					extraPrize = cfg.extraPrize
				})
			end
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.tier == b.tier then
				return a.stage < b.stage
			end

			return a.tier < b.tier
		end)
	end

	return targetList
end

function WaterdraktowerModel:getTierSpecialPrize(planId, tier)
	local cfg = WaterdraktowerConfig.instance:getTierSpecialPrizeCfgs(checknumber(planId), self.openTowerType, checknumber(tier))

	if cfg == nil or string.nilorempty(cfg.specialPrize) then
		return
	end

	return string.split(cfg.specialPrize, "#"), cfg.maxGainNum
end

function WaterdraktowerModel:getTierPrizePreviewList()
	local actCfg = WaterdraktowerConfig.instance:getTierCommCfg(self.openActId)

	if actCfg == nil or checknumber(actCfg.prizePlanId) <= 0 then
		return
	end

	local targetList = self:getAllTierStageCfgs()

	if targetList == nil or #targetList == 0 then
		return
	end

	local tierNum = 0
	local specialList = {}

	for i = #targetList, 1, -1 do
		if targetList[i].tier ~= tierNum then
			tierNum = targetList[i].tier
			specialList[i] = self:getTierSpecialPrize(actCfg.prizePlanId, targetList[i].tier)
		end
	end

	return targetList, specialList
end

function WaterdraktowerModel:getWaterEndFightInfo(isSet)
	if isSet then
		self._endFightInfo = nil

		return
	end

	return self._endFightInfo
end

function WaterdraktowerModel:scSendWaterDarkTowerGetInfo(msg)
	if msg == nil then
		self._baseInfo = nil
	end

	self._baseInfo.tier = checknumber(msg.tier)
	self._baseInfo.stage = checknumber(msg.stage)
	self._baseInfo.clgTimes = checknumber(msg.clgTimes)
	self._baseInfo.buyTimes = checknumber(msg.buyTimes)
	self._baseInfo.dailyBuyTimes = checknumber(msg.dailyBuyTimes)
	self._baseInfo.specialPrizeNum = checknumber(msg.specialPrizeNum)
	self._baseInfo.isGianFinalPrize = msg.isGianFinalPrize
end

function WaterdraktowerModel:scSendWaterDarkTowerBuyTimes()
	if self._baseInfo == nil then
		self:getWaterDarkTowerInfo()
	end

	self._baseInfo.buyTimes = self._baseInfo.buyTimes + 1
	self._baseInfo.dailyBuyTimes = self._baseInfo.dailyBuyTimes + 1
end

function WaterdraktowerModel:scSendWaterDarkTowerAfterFight(msg)
	if msg == nil then
		self._endFightInfo = nil

		return
	end

	self._endFightInfo = {}
	self._endFightInfo.newTier = nil
	self._endFightInfo.isWin = msg.isWin
	self._endFightInfo.tier = msg.tier
	self._endFightInfo.stage = msg.stage
	self._endFightInfo.finishSize = msg.finishSize

	if self._baseInfo and self._baseInfo.tier < msg.tier then
		self._endFightInfo.newTier = msg.tier
	end
end

function WaterdraktowerModel:getCurFormation()
	self._curFormation = self._curFormation or FormationMO.New(function(petId)
		return self:getPetMo(petId)
	end)

	return self._curFormation
end

function WaterdraktowerModel:getPetMo(petId)
	if checknumber(petId) <= 0 then
		return
	end

	local pet = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end
end

function WaterdraktowerModel:getWLTowerRedpoint()
	WaterdraktowerConfig.instance:getOpenTowerActivityId()

	if checknumber(self.openActId) <= 0 then
		return false
	end

	local value = GameUtil.getUserDayData("WLTowerMain_Redpoint_" .. LoginModel.instance.userId)

	if checknumber(value) ~= 1 then
		return true
	end

	return false
end

function WaterdraktowerModel:setWLTowerRedpoint(isMain)
	if isMain then
		if checknumber(GameUtil.getUserDayData("WLTowerMain_Redpoint_" .. LoginModel.instance.userId)) ~= 1 then
			GameUtil.saveUserDayData("WLTowerMain_Redpoint_" .. LoginModel.instance.userId, 1)
		end
	elseif checknumber(GameUtil.getUserDayData("WLTowerBuff_Redpoint_" .. LoginModel.instance.userId)) ~= 1 then
		GameUtil.saveUserDayData("WLTowerBuff_Redpoint_" .. LoginModel.instance.userId, 1)
	end
end

WaterdraktowerModel.instance = WaterdraktowerModel.New()

return WaterdraktowerModel
