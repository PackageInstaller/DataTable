-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/PerfectRuleModeModel.lua

module("logic.extensions.timelimitedchallenge.model.PerfectRuleModeModel", package.seeall)

local PerfectRuleModeModel = class("PerfectRuleModeModel", BaseModel)

function PerfectRuleModeModel:onInit()
	self:onReset()
end

function PerfectRuleModeModel:onReset()
	self._infos = {}
end

function PerfectRuleModeModel:getInfo(challengeId)
	local info = self._infos[challengeId]

	if info then
		return info
	end
end

function PerfectRuleModeModel:resetInfoFightState(challengeId)
	local info = self._infos[challengeId]

	if info then
		info.curModeId = nil
		info.curCreepId = nil
		info.curRuleId = nil
		info.isWin = nil
		info.isPerfectWin = nil
		info.CIList = nil
	end
end

function PerfectRuleModeModel:createInfo()
	local info = {}

	info.isHasGain = false
	info.isHasGainPet = false
	info.worldZdl = 0
	info.hasBuyTimes = 0
	info.hasUseTimes = 0
	info.curModeId = nil
	info.curCreepId = nil
	info.curRuleId = nil
	info.rankSize = 0
	info.isWin = nil
	info.isPerfectWin = nil
	info.CIList = nil

	return info
end

function PerfectRuleModeModel:getShowZDLByModeId(challengeId, modeId)
	local modeCfg = PerfectRuleModeConfig.instance:getModeCfgs(challengeId, modeId)
	local info = self._infos[challengeId]

	if modeCfg and info then
		local floorZDL = math.floor(info.worldZdl * modeCfg.showCoefficient / 10000)
		local floorCoefficient = modeCfg.floorCoefficient == 0 and 1 or modeCfg.floorCoefficient
		local floorZDLByCfg = floorZDL - floorZDL % floorCoefficient

		return math.max(floorZDLByCfg, modeCfg.fightMin)
	end

	return 0
end

function PerfectRuleModeModel:getModeIsOpen(challengeId, modeId)
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(challengeId)
	local isOpen = false
	local openTime = 0
	local modeCfg = PerfectRuleModeConfig.instance:getModeCfgs(challengeId, modeId)

	if challengeCfg.openTimeType == 1 then
		openTime = modeCfg.relativeOpenDays + challengeCfg.relativeOpenDay
		isOpen = GameUtil.isInOpenDaysByOpenDay(modeCfg.relativeOpenDays + challengeCfg.relativeOpenDay, challengeCfg.relativeEndDay)
		openTime = RoleModel.instance:getAreaOpenTimeSec() + (modeCfg.relativeOpenDays + challengeCfg.relativeOpenDay) * 86400
	elseif challengeCfg.openTimeType == 2 then
		openTime = GameUtil.string2time(challengeCfg.absoluteOpenDay) + modeCfg.relativeOpenDays * 86400
		isOpen = GameUtil.checkIsInTimePeriod(GameUtil.formatTimeStamp("%Y-%m-%d  %H:00:00", openTime), challengeCfg.absoluteEndDay)
	elseif challengeCfg.openTimeType == 4 then
		local startTimestamp, endTimestamp = TimeGateController.instance:getActTimestampByChallengeId(challengeId)

		openTime = startTimestamp + modeCfg.relativeOpenDays * 86400
		isOpen = startTimestamp + modeCfg.relativeOpenDays * 86400 <= ServerTime.now()
	else
		print("挑战开启类型未定义")
	end

	return isOpen, openTime
end

function PerfectRuleModeModel:onGetInfo(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].worldZdl = checkint(msg.worldZdl)
			self._infos[challengeId].isHasGain = checkbool(msg.todayPrizeGainBit)
			self._infos[challengeId].worldZdl = checkint(msg.worldZdl)

			if msg.timesInfo then
				self._infos[challengeId].hasUseTimes = checkint(msg.timesInfo.todayChallengeTimes)
				self._infos[challengeId].hasBuyTimes = checkint(msg.timesInfo.todayBuyChallengeTimes)
			end

			if msg.modeInfo then
				self._infos[challengeId].curModeId = checkint(msg.modeInfo.curChallengeModeId)
				self._infos[challengeId].curCreepId = checkint(msg.modeInfo.curChallengeMonsterId)
				self._infos[challengeId].curRuleId = checkint(msg.modeInfo.curChallengeRuleId)
			end

			self._infos[challengeId].rankSize = checkint(msg.rankSize)
			self._infos[challengeId].isWin = nil
			self._infos[challengeId].isPerfectWin = nil
			self._infos[challengeId].CIList = nil
			self._infos[challengeId].isHasGainPet = msg.hasGainPet

			if msg.score then
				self._infos[challengeId].score = checknumber(msg.score)
			end

			if msg.gainedProgressPrizeIds then
				self._infos[challengeId].gainedProgressPrizeIds = msg.gainedProgressPrizeIds
			end

			self._infos[challengeId] = self._infos[challengeId]
		end
	end
end

function PerfectRuleModeModel:onGainDailyPrize(msg)
	local challengeId = checkint(msg.challengeId)

	if self._infos[challengeId] then
		self._infos[challengeId].isHasGain = true
	end
end

function PerfectRuleModeModel:onBuyTime(msg)
	local challengeId = checkint(msg.challengeId)
	local info = self._infos[challengeId]

	if info then
		info.hasBuyTimes = checkint(msg.todayBuyChallengeTimes)
	end
end

function PerfectRuleModeModel:onChooseMode(msg)
	local challengeId = checkint(msg.challengeId)
	local info = self._infos[challengeId]

	if info and msg.modeInfo then
		info.curModeId = checkint(msg.modeInfo.curChallengeModeId)
		info.curCreepId = checkint(msg.modeInfo.curChallengeMonsterId)
		info.curRuleId = checkint(msg.modeInfo.curChallengeRuleId)
	end
end

function PerfectRuleModeModel:onReChooseMode(msg)
	local challengeId = checkint(msg.challengeId)
	local info = self._infos[challengeId]

	if info and msg.modeInfo then
		info.curModeId = checkint(msg.modeInfo.curChallengeModeId)
		info.curCreepId = checkint(msg.modeInfo.curChallengeMonsterId)
		info.curRuleId = checkint(msg.modeInfo.curChallengeRuleId)
	end
end

function PerfectRuleModeModel:onStartFight(msg)
	return
end

function PerfectRuleModeModel:onConfirmResult(msg)
	local challengeId = checkint(msg.challengeId)
	local info = self._infos[challengeId]

	if info then
		info.hasUseTimes = checkint(msg.todayChallengeTimes)
		info.curModeId = nil
		info.curCreepId = nil
		info.curRuleId = nil

		if msg.changeSetId then
			info.CIList = msg.changeSetId

			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		end
	end
end

function PerfectRuleModeModel:onGiveUpFight(msg)
	local challengeId = checkint(msg.challengeId)
	local info = self._infos[challengeId]

	if info then
		info.hasUseTimes = checkint(msg.todayChallengeTimes)
		info.curModeId = nil
		info.curCreepId = nil
		info.curRuleId = nil
	end
end

function PerfectRuleModeModel:onChallengeEnd(msg)
	local challengeId = checkint(msg.challengeId)
	local info = self._infos[challengeId]

	if info then
		if msg.modeInfo then
			info.curModeId = checkint(msg.modeInfo.curChallengeModeId)
			info.curCreepId = checkint(msg.modeInfo.curChallengeMonsterId)
			info.curRuleId = checkint(msg.modeInfo.curChallengeRuleId)
		end

		if msg.todayChallengeTimes then
			info.hasUseTimes = checkint(msg.todayChallengeTimes)
		end

		if msg.changeSetId then
			info.CIList = msg.changeSetId

			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		end

		info.isWin = checkbool(msg.isWin)
		info.isPerfectWin = checkbool(msg.isPerfectWin)
	end
end

function PerfectRuleModeModel:showCI(challengeId)
	local info = self._infos[challengeId]

	if info then
		local ci = checknumber(info.CIList)

		MaterialController.instance:showChangeSetInTemp(ci)

		info.CIList = nil
	end
end

function PerfectRuleModeModel:isPlayerRewardCanGet(challengeId, prizeId, needScore)
	if not self._infos[challengeId] or not self._infos[challengeId].score then
		return false
	end

	local isScoreEnough = needScore <= self._infos[challengeId].score

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGeted(challengeId, prizeId)

		return not isGeted
	else
		return false
	end
end

function PerfectRuleModeModel:updateRewardGeted(challengeId, prizeId)
	if self._infos[challengeId] then
		if not self._infos[challengeId].gainedProgressPrizeIds then
			table.insert(self._infos[challengeId].gainedProgressPrizeIds, prizeId)

			self._infos[challengeId].gainedProgressPrizeIds = self._infos[challengeId].gainedProgressPrizeIds
		end
	end
end

function PerfectRuleModeModel:isPlayerRewardGeted(challengeId, prizeId)
	if self._infos[challengeId] then
		local cfg = self._infos[challengeId].gainedProgressPrizeIds

		return TableUtil.isHad(cfg, prizeId)
	end

	return false
end

PerfectRuleModeModel.instance = PerfectRuleModeModel.New()

return PerfectRuleModeModel
