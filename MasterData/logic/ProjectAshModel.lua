-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/model/ProjectAshModel.lua

module("logic.extensions.projectash.model.ProjectAshModel", package.seeall)

local ProjectAshModel = class("ProjectAshModel", BaseModel)

ProjectAshModel.PrizeType = {
	stage2DamagePrize = 2,
	stage2WorldPrize = 3,
	stage1Prize = 1
}

function ProjectAshModel:ctor()
	return
end

function ProjectAshModel:onInit()
	self:onReset()
end

function ProjectAshModel:onReset()
	self._activityId = 265001
	self._stage1Info = {}
	self._stage1Info.hasLotteryTimes = {}
	self._stage1Info.progress = 0
	self._stage2Info = {}
	self._stage2Info.globalProgress = 0
	self._stage2Info.todayChallengeTimes = 0
	self._stage2Info.myDamage = 0
	self._stage2Info.topN = {}
	self._progressPrizeStates = {}
	self._rankInfos = {}
	self._myRank = -1
	self._myScore = 0
end

function ProjectAshModel:getStage2DefaultInfo()
	local stage2Info = {}

	stage2Info.globalProgress = 0
	stage2Info.todayChallengeTimes = 0
	stage2Info.myDamage = 0
	stage2Info.topN = {}

	for i = 1, 3 do
		local ProjectAshRankSimpleInfo = {}

		ProjectAshRankSimpleInfo.name = "无"
		ProjectAshRankSimpleInfo.score = 0

		table.insert(stage2Info.topN, ProjectAshRankSimpleInfo)
	end

	return stage2Info
end

function ProjectAshModel:onProjectAshInfoRes(msg)
	self._stage1Info = GameUtil.pbToTable(msg.stage1Info) or {}
	self._stage1Info.hasLotteryTimes = self._stage1Info.hasLotteryTimes or {}
	self._stage2Info = msg:HasField("stage2Info") and (GameUtil.pbToTable(msg.stage2Info) or self:getStage2DefaultInfo()) or self:getStage2DefaultInfo()
	self._progressPrizeStates = GameUtil.pbToTable(msg.progressPrizeStates) or {}
end

function ProjectAshModel:onProjectAshGainPrizeRes(msg)
	local isNew = true

	for i, v in ipairs(self._progressPrizeStates) do
		if v.prizeType == msg.prizeType then
			v.gainPrizeIds = v.gainPrizeIds or {}

			table.insert(v.gainPrizeIds, msg.prizeId)

			isNew = false

			break
		end
	end

	if isNew then
		local prizeInfo = {}

		prizeInfo.prizeType = msg.prizeType
		prizeInfo.gainPrizeIds = {}

		table.insert(prizeInfo.gainPrizeIds, msg.prizeId)
		table.insert(self._progressPrizeStates, prizeInfo)
	end
end

function ProjectAshModel:onProjectAshStage1LotteryRes(msg)
	if msg:HasField("id") then
		local isNew = true

		for i, v in ipairs(self._stage1Info.hasLotteryTimes) do
			if v.id == msg.id then
				v.times = v.times + 1
				isNew = false

				break
			end
		end

		if isNew then
			local lotteryInfo = {}

			lotteryInfo.id = msg.id
			lotteryInfo.times = 1

			table.insert(self._stage1Info.hasLotteryTimes, lotteryInfo)
		end
	end
end

function ProjectAshModel:onProjectAshStage2ChallengeRes(msg)
	return
end

function ProjectAshModel:onProjectAshStage2GetRankInfoRes(msg)
	self._rankInfos = GameUtil.pbToTable(msg.rankInfos) or {}
	self._myRank = msg.myRank
	self._myScore = msg.myScore
end

function ProjectAshModel:onNotifyProjectAshStage2ChallengeEndRes(msg)
	return
end

function ProjectAshModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = ProjectAshCustomFmtMo.New()
	end

	return self._customFmtMo
end

function ProjectAshModel:getActivityId()
	return self._activityId
end

function ProjectAshModel:getActivityType()
	return GameEnum.ActivityType.ProjectAsh
end

function ProjectAshModel:getRewardProgress()
	if self._stage1Info and self._stage1Info.progress then
		return checknumber(self._stage1Info.progress)
	end

	return 0
end

function ProjectAshModel:getWorldProgress()
	if self._stage2Info and self._stage2Info.globalProgress then
		return checknumber(self._stage2Info.globalProgress)
	end

	return 0
end

function ProjectAshModel:isPlayerRewardCanGet(prizeType, prizeId, progress)
	local isScoreEnough = false

	isScoreEnough = prizeType == ProjectAshModel.PrizeType.stage2WorldPrize and self:getWorldProgress() >= checknumber(progress) or self:getRewardProgress() >= checknumber(progress)

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGeted(prizeType, prizeId)

		return not isGeted
	else
		return false
	end
end

function ProjectAshModel:isPlayerRewardGeted(prizeType, prizeId)
	local gainPrizeIds = self:_getGainPrizeIds(prizeType)

	return TableUtil.isHad(gainPrizeIds, prizeId)
end

function ProjectAshModel:_getGainPrizeIds(prizeType)
	local gainPrizeIds = {}

	for i, infos in ipairs(self._progressPrizeStates) do
		if infos.prizeType == prizeType then
			gainPrizeIds = infos.gainPrizeIds or gainPrizeIds

			break
		end
	end

	return gainPrizeIds
end

function ProjectAshModel:getLotteryTimes(id)
	for i, v in ipairs(self._stage1Info.hasLotteryTimes) do
		if v.id == id then
			return v.times
		end
	end

	return 0
end

function ProjectAshModel:getTodayChallengeTimes()
	if self._stage2Info and self._stage2Info.todayChallengeTimes then
		return self._stage2Info.todayChallengeTimes
	end

	return 0
end

function ProjectAshModel:getMyDamage()
	if self._stage2Info and self._stage2Info.myDamage then
		return checknumber(self._stage2Info.myDamage)
	else
		return 0
	end
end

function ProjectAshModel:getTopNName(index)
	if self._stage2Info and self._stage2Info.topN and self._stage2Info.topN[index] then
		return self._stage2Info.topN[index].name
	else
		return ""
	end
end

function ProjectAshModel:getMyRank()
	return self._myRank
end

function ProjectAshModel:getMyScore()
	return self._myScore
end

function ProjectAshModel:getRankInfos()
	return self._rankInfos
end

ProjectAshModel.instance = ProjectAshModel.New()

return ProjectAshModel
