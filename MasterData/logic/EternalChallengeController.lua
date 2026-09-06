-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/controller/EternalChallengeController.lua

module("logic.extensions.eternalchallenge.controller.EternalChallengeController", package.seeall)

local EternalChallengeController = class("EternalChallengeController", BaseController)

function EternalChallengeController:ctor()
	return
end

function EternalChallengeController:onInit()
	self:onReset()
end

function EternalChallengeController:onReset()
	return
end

function EternalChallengeController:sendPM_EternalChallengeInfoReq(activityId)
	EternalChallengeAgent.instance:sendPM_EternalChallengeInfoReq(activityId)
end

function EternalChallengeController:handlePM_EternalChallengeInfoRes(msg)
	EternalChallengeModel.instance:handlePM_EternalChallengeInfoRes(msg)
	self:_updateBuffRed(msg.activityId)
	self:_updatePetRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalChallengeInfoRes)
end

function EternalChallengeController:sendPM_EternalChallengeBuyPetReq(activityId, raceId)
	EternalChallengeAgent.instance:sendPM_EternalChallengeBuyPetReq(activityId, raceId)
end

function EternalChallengeController:handlePM_EternalChallengeBuyPetRes(msg)
	EternalChallengeModel.instance:handlePM_EternalChallengeBuyPetRes(msg)
	self:_updatePetRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalChallengeBuyPetRes)
end

function EternalChallengeController:sendPM_EternalChallengeUpgradeBuffReq(activityId, buffId)
	EternalChallengeAgent.instance:sendPM_EternalChallengeUpgradeBuffReq(activityId, buffId)
end

function EternalChallengeController:handlePM_EternalChallengeUpgradeBuffRes(msg)
	EternalChallengeModel.instance:handlePM_EternalChallengeUpgradeBuffRes(msg)
	self:_updateBuffRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalChallengeUpgradeBuffRes)
end

function EternalChallengeController:sendPM_EternalChallengeFightReq(activityId, form)
	EternalChallengeAgent.instance:sendPM_EternalChallengeFightReq(activityId, form)
end

function EternalChallengeController:handlePM_EternalChallengeFightRes(status, msg)
	if status == 0 then
		EternalChallengeModel.instance:handlePM_EternalChallengeFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.EternalChallengeFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function EternalChallengeController:handlePM_NotifyEternalChallengeFightEndRes(msg)
	EternalChallengeModel.instance:handlePM_NotifyEternalChallengeFightEndRes(msg)

	local str = string.format("本次伤害<color=#eb4642>%s</color>", msg.damage)
	local params = {}

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.EternalChallenge, params)
	GlobalDispatcher:dispatch(GlobalNotify.EternalChallengeFightEndRes)
end

function EternalChallengeController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function EternalChallengeController:getActivityType()
	return GameEnum.ActivityType.EternalChallenge
end

function EternalChallengeController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function EternalChallengeController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function EternalChallengeController:getSkinId(activityId)
	return EternalChallengeConfig.instance:getEcClientCommonValue(activityId, "ETERNALCHALLENGE_PET_SKINID", true)
end

function EternalChallengeController:_updateBuffRed(activityId)
	activityId = checknumber(activityId)

	local redId = RedPointModel.ID_ETERNAL_CHALLENGE_BUFF

	RedPointController.instance:setRedPointInfo(redId, (self:isInActivityTime(activityId) and self:isHaveBuffCanUpdate(activityId) or nil) and true)
end

function EternalChallengeController:_updatePetRed(activityId)
	activityId = checknumber(activityId)

	local redId = RedPointModel.ID_ETERNAL_CHALLENGE_PET

	RedPointController.instance:setRedPointInfo(redId, (self:isInActivityTime(activityId) and self:isHavePetCanUpdate(activityId) or nil) and true)
end

function EternalChallengeController:getMaxDamage()
	return EternalChallengeModel.instance:getMaxDamage()
end

function EternalChallengeController:enterBattleAsEternalChallenge(activityId)
	local customFmtMo = EternalChallengeModel.instance:getCustomFmtMoAsternalChallenge()

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function EternalChallengeController:isHavePetCanUpdate(activityId)
	local isHave = false
	local dataLists = EternalChallengeConfig.instance:getEcPetDataLists(activityId)

	for raceId, dataList in pairs(dataLists) do
		if self:isPetCanUpdate(activityId, raceId) then
			isHave = true

			break
		end
	end

	return isHave
end

function EternalChallengeController:isPetCanUpdate(activityId, raceId)
	local result = self:getTryUpdatePetResultAndTips(activityId, raceId)

	return result == GameEnum.ResultCode.Success
end

function EternalChallengeController:getTryUpdatePetResultAndTips(activityId, raceId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	result, tips = self:getTryPopUpdatePetWinResultAndTips(activityId, raceId)

	if result == GameEnum.ResultCode.Success and not self:isEnoughCostOfPet(activityId, raceId) then
		result = GameEnum.ResultCode.Error
		tips = "道具数量不足"
	end

	return result, tips
end

function EternalChallengeController:getTryPopUpdatePetWinResultAndTips(activityId, raceId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self:isPetFullLevel(activityId, raceId) then
		result = GameEnum.ResultCode.Error
		tips = "精灵已满级"
	end

	return result, tips
end

function EternalChallengeController:isEnoughCostOfPet(activityId, raceId)
	local costNum = self:getPetUpdateCostNum(activityId, raceId)
	local keepNum = self:getPetUpdateMatKeepNum(activityId, raceId)

	return costNum <= keepNum
end

function EternalChallengeController:getPetUpdateCostNum(activityId, raceId)
	local costNum = 0
	local isFullLevel = self:isPetFullLevel(activityId, raceId)

	if not isFullLevel then
		local nextLevel = self:getPetNextLevel(activityId, raceId)
		local nextPetData = EternalChallengeConfig.instance:getEcPetData(activityId, raceId, nextLevel)

		if not string.nilorempty(nextPetData.cost) then
			local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextPetData.cost)

			costNum = costMatNum
		end
	end

	return costNum
end

function EternalChallengeController:getPetUpdateMatKeepNum(activityId, raceId)
	local keepNum = 0
	local isFullLevel = self:isPetFullLevel(activityId, raceId)

	if not isFullLevel then
		local nextLevel = self:getPetNextLevel(activityId, raceId)
		local nextPetData = EternalChallengeConfig.instance:getEcPetData(activityId, raceId, nextLevel)

		if not string.nilorempty(nextPetData.cost) then
			local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextPetData.cost)

			keepNum = MaterialModel.instance:getMaterialsNumber(costMatType, costMatId)
		end
	end

	return keepNum
end

function EternalChallengeController:isPetFullLevel(activityId, raceId)
	local curLevel = self:getPetCurLevel(activityId, raceId)
	local maxLevel = self:getMaxLevel(activityId, raceId)

	return maxLevel <= curLevel
end

function EternalChallengeController:getPetCanFmt(activityId, raceId)
	local curLevel = self:getPetCurLevel(activityId, raceId)

	return curLevel > 0
end

function EternalChallengeController:getPetCurLevel(activityId, raceId)
	local mgr = EternalChallengeModel.instance:getPetInfoMgr(activityId)

	return (mgr or nil) and mgr:getCurLevel(raceId)
end

function EternalChallengeController:getPetNextLevel(activityId, raceId)
	local curLevel = self:getPetCurLevel(activityId, raceId)
	local maxLevel = self:getMaxLevel(activityId, raceId)

	return Mathf.Min(curLevel + 1, maxLevel)
end

function EternalChallengeController:getMaxLevel(activityId, raceId)
	local dataList = EternalChallengeConfig.instance:getEcPetDataList(activityId, raceId)
	local data = dataList[#dataList]

	return data.level
end

function EternalChallengeController:getPetCreepsId(activityId, raceId)
	local mgr = EternalChallengeModel.instance:getPetInfoMgr(activityId)

	return (mgr or nil) and mgr:getCreepsId(raceId)
end

function EternalChallengeController:getPetMo(activityId, raceId)
	local mgr = EternalChallengeModel.instance:getPetInfoMgr(activityId)

	return mgr and mgr:getPetMo(raceId)
end

function EternalChallengeController:getRaceIdList(activityId)
	local mgr = EternalChallengeModel.instance:getPetInfoMgr(activityId)

	return mgr and mgr:getRaceIdList() or {}
end

function EternalChallengeController:isHaveBuffCanUpdate(activityId)
	local isHave = false
	local dataLists = EternalChallengeConfig.instance:getEcBuffDataLists(activityId)

	for buffId, dataList in pairs(dataLists) do
		if self:isBuffCanUpdate(activityId, buffId) then
			isHave = true

			break
		end
	end

	return isHave
end

function EternalChallengeController:isBuffCanUpdate(activityId, buffId)
	local result = self:getTryUpdateBuffResultAndTips(activityId, buffId)

	return result == GameEnum.ResultCode.Success
end

function EternalChallengeController:getTryUpdateBuffResultAndTips(activityId, buffId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	result, tips = self:getTryPopUpdateBuffWinResultAndTips(activityId, buffId)

	if result == GameEnum.ResultCode.Success and not self:isEnoughCostOfBuff(activityId, buffId) then
		result = GameEnum.ResultCode.Error
		tips = "道具数量不足"
	end

	return result, tips
end

function EternalChallengeController:getTryPopUpdateBuffWinResultAndTips(activityId, buffId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self:isFullBuffLevel(activityId, buffId) then
		result = GameEnum.ResultCode.Error
		tips = "Buff已满级"
	end

	return result, tips
end

function EternalChallengeController:isEnoughCostOfBuff(activityId, buffId)
	local costNum = self:getBuffUpdateCostNum(activityId, buffId)
	local keepNum = self:getBuffUpdateMatKeepNum(activityId, buffId)

	return costNum <= keepNum
end

function EternalChallengeController:getBuffUpdateCostNum(activityId, buffId)
	local cost = 0
	local isFullLevel = self:isFullBuffLevel(activityId, buffId)

	if not isFullLevel then
		local nextLevel = self:getNextBuffLevel(activityId, buffId)
		local nextBuffData = EternalChallengeConfig.instance:getEcBuffData(activityId, buffId, nextLevel)

		if not string.nilorempty(nextBuffData.cost) then
			local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextBuffData.cost)

			cost = costMatNum
		end
	end

	return cost
end

function EternalChallengeController:getBuffUpdateMatKeepNum(activityId, buffId)
	local keepNum = 0
	local isFullLevel = self:isFullBuffLevel(activityId, buffId)

	if not isFullLevel then
		local nextLevel = self:getNextBuffLevel(activityId, buffId)
		local nextBuffData = EternalChallengeConfig.instance:getEcBuffData(activityId, buffId, nextLevel)

		if not string.nilorempty(nextBuffData.cost) then
			local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextBuffData.cost)

			keepNum = MaterialModel.instance:getMaterialsNumber(costMatType, costMatId)
		end
	end

	return keepNum
end

function EternalChallengeController:isFullBuffLevel(activityId, buffId)
	local curBuffLevel = self:getCurBuffLevel(buffId)
	local maxBuffLevel = self:getMaxBuffLevel(activityId, buffId)

	return maxBuffLevel <= curBuffLevel
end

function EternalChallengeController:getCurBuffLevel(buffId)
	return EternalChallengeModel.instance:getCurBuffLevel(buffId)
end

function EternalChallengeController:getNextBuffLevel(activityId, buffId)
	local curBuffLevel = self:getCurBuffLevel(buffId)
	local maxBuffLevel = self:getMaxBuffLevel(activityId, buffId)

	return Mathf.Min(curBuffLevel + 1, maxBuffLevel)
end

function EternalChallengeController:getMaxBuffLevel(activityId, buffId)
	local dataList = EternalChallengeConfig.instance:getEcBuffDataList(activityId, buffId)
	local data = dataList[#dataList]

	return (data or nil) and data.level
end

EternalChallengeController.instance = EternalChallengeController.New()

return EternalChallengeController
