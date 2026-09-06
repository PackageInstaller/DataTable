-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/controller/KingjichallengeController.lua

module("logic.extensions.kingjichallenge.controller.KingjichallengeController", package.seeall)

local KingjichallengeController = class("KingjichallengeController", BaseController)

function KingjichallengeController:ctor()
	return
end

function KingjichallengeController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("kingjichallenge", self._enterKingJiChallenge, self)
end

function KingjichallengeController:onReset()
	self:clearMixSaveMsg()

	self._currChallengeCourierStageId = nil
	self._courierDamageInfo = nil
end

function KingjichallengeController:isChallengePass(ctype)
	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return false
	end

	local allPass = false
	local activityId = KingjichallengeModel.instance:getActivityId()

	if ctype == GameEnum.KingjiChallengeType.Shizhe then
		allPass = true

		for i, v in ipairs(info.courierInfo.stageList) do
			if not v.isKillBoss then
				allPass = false

				break
			end
		end
	elseif ctype == GameEnum.KingjiChallengeType.Hun then
		allPass = true

		for i, v in ipairs(info.soulInfo.stageList) do
			local stageId = v.stageId
			local cfgs = KingjichallengeConfig.instance:getSoulStagePlanCfgs(activityId, stageId)

			if v.passMaxSmallStageId < #cfgs then
				allPass = false

				break
			end
		end
	elseif ctype == GameEnum.KingjiChallengeType.Ronghe then
		allPass = true

		for i, v in ipairs(info.mixInfo.stageList) do
			for _, master in ipairs(v.masterList) do
				if not master.isPass then
					allPass = false
				end
			end
		end
	end

	return allPass
end

function KingjichallengeController:isCanGet(prizeId, challengeType)
	local isGain = self:isGainPrize(prizeId, challengeType)

	if isGain then
		return false
	end

	local info = KingjichallengeModel.instance:getInfo()
	local activityId = KingjichallengeModel.instance:getActivityId()

	if challengeType == GameEnum.KingjiChallengeType.Shizhe then
		local currDamage = KingjichallengeModel.instance:getCourierTotalDamage()
		local cfg = KingjichallengeConfig.instance:getCourierPrizeCfg(activityId, prizeId)

		return currDamage >= cfg.damage
	elseif challengeType == GameEnum.KingjiChallengeType.Hun then
		local totalPass = 0

		for i, v in ipairs(info.soulInfo.stageList) do
			totalPass = totalPass + v.passMaxSmallStageId
		end

		local cfg = KingjichallengeConfig.instance:getSoulPrizeCfg(activityId, prizeId)

		return totalPass >= cfg.progress
	elseif challengeType == GameEnum.KingjiChallengeType.Ronghe then
		return self:isMixStagePass(prizeId)
	end
end

function KingjichallengeController:isGainPrize(prizeId, challengeType)
	local info = KingjichallengeModel.instance:getInfo()

	if challengeType == GameEnum.KingjiChallengeType.Shizhe then
		return TableUtil.isHad(info.courierInfo.gainPrizeIds, prizeId)
	elseif challengeType == GameEnum.KingjiChallengeType.Hun then
		return TableUtil.isHad(info.soulInfo.gainPrizeIds, prizeId)
	elseif challengeType == GameEnum.KingjiChallengeType.Ronghe then
		for i, v in ipairs(info.mixInfo.stageList) do
			if v.stageId == prizeId and not v.isGainPrize then
				return false
			end
		end

		return true
	end
end

function KingjichallengeController:isGainPrizeSoul(prizeId)
	local info = KingjichallengeModel.instance:getInfo()

	return TableUtil.isHad(info.soulInfo.gainPrizeIds, prizeId)
end

function KingjichallengeController:isCanGetSoul(prizeId)
	local currDamage = KingjichallengeModel.instance:getCourierTotalDamage()
	local activityId = KingjichallengeModel.instance:getActivityId()
	local cfg = KingjichallengeConfig.instance:getCourierPrizeCfg(activityId, prizeId)

	return currDamage >= cfg.damage and not self:isGainPrize(prizeId)
end

function KingjichallengeController:enterMission(challengeType, stageId, creepsMasterId, extStageId)
	local mo = KingjichallengeModel.instance:getCustomFmtMo()

	mo:initParams(challengeType, stageId, creepsMasterId, extStageId)
	CustomFmtController.instance:showMissionView(mo)
end

function KingjichallengeController:isCourierStagePass(stageId)
	local info = KingjichallengeModel.instance:getInfo()

	for i, v in ipairs(info.courierInfo.stageList) do
		if v.stageId == stageId and v.isKillBoss then
			return true
		end
	end
end

function KingjichallengeController:isSoulSmallPass(stageId, smallStageId)
	local activityId = KingjichallengeModel.instance:getActivityId()
	local info = KingjichallengeModel.instance:getInfo()

	for i, v in ipairs(info.soulInfo.stageList) do
		if v.stageId == stageId then
			return smallStageId <= v.passMaxSmallStageId
		end
	end
end

function KingjichallengeController:isMixStagePass(stageId)
	local activityId = KingjichallengeModel.instance:getActivityId()
	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return false
	end

	local pcfgs = KingjichallengeConfig.instance:getMixStagePlanCfgs(activityId, stageId)
	local needs = {}

	for i, v in ipairs(pcfgs) do
		needs[v.attribute] = v.needCount
	end

	local collects = {}

	for i, v in ipairs(info.mixInfo.stageList) do
		if v.stageId == stageId then
			for i, master in ipairs(v.masterList) do
				if not master.isPass then
					return false
				end

				for _, o in ipairs(master.itemList) do
					collects[o.attribute] = (collects[o.attribute] or 0) + o.collectCount
				end
			end

			for attribute, needCount in pairs(needs) do
				if not collects[attribute] or collects[attribute] < needs[attribute] then
					return false
				end
			end

			return true
		end
	end

	return false
end

function KingjichallengeController:isMixCreepPass(stageId, creepsMasterId)
	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return false
	end

	for i, v in ipairs(info.mixInfo.stageList) do
		if v.stageId == stageId then
			for _, master in ipairs(v.masterList) do
				if master.passCreepsMasterIds == creepsMasterId then
					return master.isPass
				end
			end
		end
	end
end

function KingjichallengeController:notifyChallengeRes(msg)
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.actId)
	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return
	end

	if not msg.isWin then
		return
	end

	if msg.type == GameEnum.KingjiChallengeType.Shizhe then
		info.courierInfo:ParseFromString(msg.courierInfo:SerializeToString())
	elseif msg.type == GameEnum.KingjiChallengeType.Hun then
		info.soulInfo:ParseFromString(msg.soulInfo:SerializeToString())
	elseif msg.type == GameEnum.KingjiChallengeType.Ronghe then
		self:clearMixSaveMsg()

		for i, v in ipairs(info.mixInfo.stageList) do
			if v.stageId == msg.stageId then
				for _, master in ipairs(v.masterList) do
					if master.passCreepsMasterIds == msg.mixInfo.passCreepsMasterIds then
						local data = {
							stageId = msg.stageId,
							passCreepsMasterIds = master.passCreepsMasterIds,
							masterInfo = msg.mixInfo
						}

						self:_saveMixMsg(data)

						if not isAoqiGodProcessType then
							return
						end
					end
				end
			end
		end
	end

	if isAoqiGodProcessType then
		local allPass = self:isChallengePass(GameEnum.KingjiChallengeType.Ronghe)

		if isAoqiGodProcessType and allPass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.KingJiChallenge, msg.actId)
		end
	end
end

function KingjichallengeController:getMixCollectNum(stageId, attr)
	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return 0
	end

	local num = 0

	for i, v in ipairs(info.mixInfo.stageList) do
		if v.stageId == stageId then
			for _, master in ipairs(v.masterList) do
				for _, item in ipairs(master.itemList) do
					if item.attribute == attr then
						num = num + item.collectCount
					end
				end
			end
		end
	end

	return num
end

function KingjichallengeController:clearMixSaveMsg()
	self._mixSaveMsg = nil
end

function KingjichallengeController:_saveMixMsg(data)
	self._mixSaveMsg = data
end

function KingjichallengeController:getMixSaveMsg()
	return self._mixSaveMsg
end

function KingjichallengeController:saveMixMsg(mixStage)
	self:clearMixSaveMsg()

	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return
	end

	for i, v in ipairs(info.mixInfo.stageList) do
		if v.stageId == mixStage.stageId then
			v:ParseFromString(mixStage:SerializeToString())

			break
		end
	end
end

function KingjichallengeController:setCurrChallengeCourierStageId(stageId)
	if not stageId then
		self._currChallengeCourierStageId = nil
		self._courierDamageInfo = nil

		return
	end

	self._currChallengeCourierStageId = stageId

	self:_cacheCourierLastDamageInfo()
end

function KingjichallengeController:_cacheCourierLastDamageInfo()
	local damage, bossCurHp = 0, 0
	local info = KingjichallengeModel.instance:getInfo()

	if info then
		for i, v in ipairs(info.courierInfo.stageList) do
			if v.stageId == self._currChallengeCourierStageId then
				bossCurHp = v.bossCurHp
				damage = v.damge

				break
			end
		end
	end

	self._courierDamageInfo = {
		damage = damage,
		bossCurHp = bossCurHp,
		stageId = self._currChallengeCourierStageId
	}
end

function KingjichallengeController:getCourierLastDamageInfo()
	return self._courierDamageInfo
end

function KingjichallengeController:getCourierCurrDamageInfo()
	local info = KingjichallengeModel.instance:getInfo()

	for i, v in ipairs(info.courierInfo.stageList) do
		if v.stageId == self._currChallengeCourierStageId then
			return {
				damage = v.damge,
				bossCurHp = v.bossCurHp
			}
		end
	end
end

function KingjichallengeController:checkRedpoint()
	local activityId = KingjichallengeModel.instance:getActivityId()
	local courierPoinit = false
	local soulPoinit = false
	local mixPoinit = false

	if activityId and activityId > 0 then
		courierPoinit = self:_checkCourierPoint(activityId)
		soulPoinit = self:_checkSoulPoint(activityId)
		mixPoinit = self:_checkMixPoint(activityId)
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Kingji_Courier, courierPoinit)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Kingji_Soul, soulPoinit)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Kingji_Mix, mixPoinit)
end

function KingjichallengeController:_checkCourierPoint(activityId)
	local redPoint = false
	local isCanGain = false
	local isGainAll = true
	local cfgs = KingjichallengeConfig.instance:getCourierPrizeCfgs(activityId)

	for i, v in ipairs(cfgs) do
		isCanGain = self:isCanGet(v.prizeId, GameEnum.KingjiChallengeType.Shizhe)

		if not self:isGainPrize(v.prizeId, GameEnum.KingjiChallengeType.Shizhe) then
			isGainAll = false
		end

		if isCanGain then
			redPoint = true

			break
		end
	end

	if not isGainAll and not redPoint then
		local time = KingjichallengeModel.instance:getCourierChallengeTime()
		local cfg = KingjichallengeConfig.instance:getActivityCfg(activityId)

		redPoint = time < cfg.courierDailyChallengeTimes
	end

	return redPoint
end

function KingjichallengeController:_checkSoulPoint(activityId)
	local redPoint = false
	local cfgs = KingjichallengeConfig.instance:getSoulPrizeCfgs(activityId)

	for i, v in ipairs(cfgs) do
		if self:isCanGet(v.prizeId, GameEnum.KingjiChallengeType.Hun) then
			redPoint = true

			break
		end
	end

	return redPoint
end

function KingjichallengeController:_checkMixPoint(activityId)
	local redPoint = false
	local cfgs = KingjichallengeConfig.instance:getMixStageCfgs(activityId)

	for i, v in ipairs(cfgs) do
		if self:isCanGet(v.stageId, GameEnum.KingjiChallengeType.Ronghe) then
			redPoint = true

			break
		end
	end

	return redPoint
end

function KingjichallengeController:_enterKingJiChallenge(params)
	self:enterKingJiChallenge(checknumber(params[1]))
end

function KingjichallengeController:enterKingJiChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = KingjichallengeModel.instance:getActivityId()
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local isInActivityTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.KingJiChallenge, activityId)

	if not isInActivityTime then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.KingjichallengemainView, activityId)
end

KingjichallengeController.instance = KingjichallengeController.New()

return KingjichallengeController
