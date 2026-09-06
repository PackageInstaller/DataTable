-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/model/GoddesscollectorModel.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorModel", package.seeall)

local GoddesscollectorModel = class("GoddesscollectorModel", BaseModel)

GoddesscollectorModel.WholeLife_Dot = "GoddesscollectorModel.WholeLife_Dot"

function GoddesscollectorModel:ctor()
	return
end

function GoddesscollectorModel:onInit()
	self:onReset()
end

function GoddesscollectorModel:onReset()
	self._activityId = 0
	self._myRank = -1
	self._petInfo = nil
	self._skinInfo = nil
	self._verificationInfo = nil
	self._currPetPage = {}
	self._verifyCurScore = 0
	self._verifyHistoryBestScore = 0
	self._verifyPetInfos = {}
	self._rankInfos = {}
end

function GoddesscollectorModel:setActivityId(id)
	self._activityId = id
end

function GoddesscollectorModel:getActivityId()
	return self._activityId
end

function GoddesscollectorModel:setInfo(msg)
	self._petInfo = msg.petInfo
	self._skinInfo = msg.skinInfo
	self._qualitys = msg.skinInfo.qualitys or {}
	self._verificationInfo = msg.verificationInfo
	self._verifyHistoryBestScore = self._verificationInfo.historyBestScore
end

function GoddesscollectorModel:setRankInfos(msg)
	self._myRank = msg.myRank

	if msg.rankInfos then
		self._rankInfos = msg.rankInfos
	end
end

function GoddesscollectorModel:getRankInfos()
	return self._rankInfos
end

function GoddesscollectorModel:getMyRank()
	return self._myRank
end

function GoddesscollectorModel:setCurrPetPage(viewType, page)
	self._currPetPage[viewType] = page
end

function GoddesscollectorModel:getCurrPetPage(viewType, defaultPage)
	return self._currPetPage[viewType] or defaultPage or 1
end

function GoddesscollectorModel:isSkinCollect(configId)
	if self._skinInfo then
		for i, v in ipairs(self._skinInfo.collectedSkinConfigIds) do
			if v == configId then
				return true
			end
		end
	end

	return false
end

function GoddesscollectorModel:getSkinCollectScore()
	if self._skinInfo then
		return self._skinInfo.curScore
	end

	return 0
end

function GoddesscollectorModel:isGainSkinCollectPrize(prizeId)
	if self._skinInfo then
		for i, v in ipairs(self._skinInfo.gainedPrizeIds) do
			if v == prizeId then
				return true
			end
		end
	end
end

function GoddesscollectorModel:isCanGainSkinCollectPrize(prizeId)
	if not self:isGainSkinCollectPrize(prizeId) then
		local acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
		local pcfg = GoddesscollectorConfig.instance:getPrizeCfg(acfg.skinPrizePlanId, prizeId)
		local curScore = self:getSkinCollectScore()

		return curScore >= pcfg.needScore
	end
end

function GoddesscollectorModel:getSkinQualityList()
	if self._skinInfo then
		return self._skinInfo.qualitys
	end
end

function GoddesscollectorModel:getSkinQualityNumBySkinRareId(skinRareId)
	if self._skinInfo and self._skinInfo.qualitys then
		for k, skinInfo in pairs(self._skinInfo.qualitys) do
			if skinInfo.quality == skinRareId then
				return (skinInfo.skinIds or nil) and (#skinInfo.skinIds or 0)
			end
		end
	end

	return 0
end

function GoddesscollectorModel:isPetCollect(configId)
	if self._petInfo then
		for i, v in ipairs(self._petInfo.collectedPetConfigIds) do
			if v == configId then
				return true
			end
		end
	end

	return false
end

function GoddesscollectorModel:getPetCollectScore()
	if self._petInfo then
		return self._petInfo.curScore
	end

	return 0
end

function GoddesscollectorModel:isGainPetCollectPrize(prizeId)
	if self._petInfo then
		for i, v in ipairs(self._petInfo.gainedPrizeIds) do
			if v == prizeId then
				return true
			end
		end
	end
end

function GoddesscollectorModel:isCanGainPetCollectPrize(prizeId)
	if not self:isGainPetCollectPrize(prizeId) then
		local acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
		local pcfg = GoddesscollectorConfig.instance:getPrizeCfg(acfg.petPrizePlanId, prizeId)
		local curScore = self:getPetCollectScore()

		return curScore >= pcfg.needScore
	end
end

function GoddesscollectorModel:gainPrizeRes(prizeType, prizeId)
	if GameEnum.GoddessCollector_PrizeType.PET_PRIZE == prizeType then
		if self._petInfo then
			self._petInfo.gainedPrizeIds:append(prizeId)
		end
	elseif GameEnum.GoddessCollector_PrizeType.SKIN_PRIZE == prizeType then
		if self._skinInfo then
			self._skinInfo.gainedPrizeIds:append(prizeId)
		end
	elseif GameEnum.GoddessCollector_PrizeType.VERIFICATION_PRIZE == prizeType and self._verificationInfo then
		self._verificationInfo.gainedPrizeIds:append(prizeId)
	end
end

function GoddesscollectorModel:verifyPetsRes(msg)
	self._verificationInfo.historyBestScore = msg.historyBestScore
	self._verifyPetInfos = msg.verifyPetInfos
	self._verifyCurScore = msg.curScore
	self._verifyHistoryBestScore = msg.historyBestScore
end

function GoddesscollectorModel:getVerifyCurrSore()
	return self._verifyCurScore
end

function GoddesscollectorModel:getVerifyHistoryBestScore()
	return self._verifyHistoryBestScore
end

function GoddesscollectorModel:getVerifyPetInfos()
	return self._verifyPetInfos
end

function GoddesscollectorModel:isGainVerifyPrize(prizeId)
	if self._verificationInfo then
		for i, v in ipairs(self._verificationInfo.gainedPrizeIds) do
			if v == prizeId then
				return true
			end
		end
	end
end

function GoddesscollectorModel:isCanGainVerifyPrize(prizeId)
	if not self:isGainVerifyPrize(prizeId) then
		local acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
		local pcfg = GoddesscollectorConfig.instance:getPrizeCfg(acfg.verificationPrizePlanId, prizeId)
		local curScore = self:getVerifyHistoryBestScore()

		return curScore >= pcfg.needScore
	end
end

function GoddesscollectorModel:resetVerify()
	self._verifyCurScore = 0
	self._verifyPetInfos = {}
end

function GoddesscollectorModel:checkWholeLifeDot()
	local value = GameUtil.getUserData(GoddesscollectorModel.WholeLife_Dot)

	return value ~= true
end

function GoddesscollectorModel:checkWholeLifeDot()
	local value = GameUtil.getUserData(GoddesscollectorModel.WholeLife_Dot)

	return value ~= true
end

function GoddesscollectorModel:clearWholeLifeDot()
	GameUtil.saveUserData(GoddesscollectorModel.WholeLife_Dot, true)
end

function GoddesscollectorModel:checkRedDotByType(type)
	if type == 1 then
		return self:checkPetCollectPrizeDot()
	elseif type == 2 then
		return self:checkSkinCollectPrizeDot()
	elseif type == 3 then
		return self:checkCollcultivatePrizeDot()
	end

	return false
end

function GoddesscollectorModel:checkPetCollectPrizeDot()
	local acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
	local pcfg = GoddesscollectorConfig.instance:getPrizeCfgs(acfg.petPrizePlanId)

	for k, v in pairs(pcfg) do
		if self:isCanGainPetCollectPrize(v.prizeId) then
			return true
		end
	end
end

function GoddesscollectorModel:checkSkinCollectPrizeDot()
	local acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
	local pcfg = GoddesscollectorConfig.instance:getPrizeCfgs(acfg.skinPrizePlanId)

	for k, v in pairs(pcfg) do
		if self:isCanGainSkinCollectPrize(v.prizeId) then
			return true
		end
	end
end

function GoddesscollectorModel:checkCollcultivatePrizeDot()
	local acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
	local pcfg = GoddesscollectorConfig.instance:getPrizeCfgs(acfg.verificationPrizePlanId)

	for k, v in pairs(pcfg) do
		if self:isCanGainVerifyPrize(v.prizeId) then
			return true
		end
	end
end

GoddesscollectorModel.instance = GoddesscollectorModel.New()

return GoddesscollectorModel
