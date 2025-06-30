-- chunkname: @IQIGame\\Module\\Challenge\\ChallengeData.lua

ChallengeData = {}

local ChallengeLayerData = require("IQIGame.Module.Challenge.ChallengeLayerData")

function ChallengeData.New(cfgID, isOpen, pod, isNew, isOpenTime)
	local o = Clone(ChallengeData)

	o:Init(cfgID, isOpen, pod, isNew, isOpenTime)

	return o
end

function ChallengeData:Init(cfgID, isOpen, pod, isNew, isOpenTime)
	self.cfgID = cfgID
	self.cfgInfo = CfgDailyDupTable[cfgID]
	self.isOpen = isOpen
	self.isNew = isNew
	self.isOpenTime = isOpenTime
	self.week = self:IsExpire()

	if pod then
		self.challengeLayerDic = {}

		local layerData

		for cid, cfgChallengeLayerData in pairsCfg(CfgChallengeLayerTable) do
			if cfgChallengeLayerData.DailyDupId == self.cfgID then
				local isLv = PlayerModule.PlayerInfo.baseInfo.pLv >= cfgChallengeLayerData.LevelLimit
				local isFight

				if cfgChallengeLayerData.UnlockCondition ~= nil and cfgChallengeLayerData.UnlockCondition > 0 then
					local dailyDupPod = DailyDupModule.GetDailyDupPOD(self.cfgID)

					isFight = table.indexOf(dailyDupPod.challengePOD.difficult, cfgChallengeLayerData.UnlockCondition) ~= -1
				else
					isFight = true
				end

				local isLock = isLv and isFight

				layerData = ChallengeLayerData.New(cid, isLock)

				table.insert(self.challengeLayerDic, layerData)
			end
		end

		table.sort(self.challengeLayerDic, function(tb1, tb2)
			return tb1.cfgInfo.DisplayOrder < tb2.cfgInfo.DisplayOrder
		end)
	end

	self.cumulativeRewards = {}

	for i, cfgChallengeRewardData in pairsCfg(CfgChallengeRewardTable) do
		if cfgChallengeRewardData.DailyDupId == self.cfgID then
			table.insert(self.cumulativeRewards, cfgChallengeRewardData)
		end
	end

	table.sort(self.cumulativeRewards, function(tb1, tb2)
		return tb1.DamageNeed < tb2.DamageNeed
	end)
end

function ChallengeData:IsExpire()
	local week = getWeekText(PlayerModule.GetServerTime())

	if table.indexOf(self.cfgInfo.OpenWeekTime, week) ~= -1 then
		local t = os.date("!*t", PlayerModule.GetServerTime() + PlayerModule.TimeZone * 3600)
		local totalSecond = t.hour * 3600 + t.min

		if totalSecond > self.cfgInfo.OpenTime + self.cfgInfo.AccessibleTime then
			return true
		end
	end

	return false
end

function ChallengeData:UpdateChallengePOD(dailyDupPOD)
	self.isOpenTime = DailyDupModule.IsOpenTime(dailyDupPOD.common.cid)
	self.week = self:IsExpire()

	if self.challengeLayerDic then
		for i, challengeLayerData in pairs(self.challengeLayerDic) do
			if challengeLayerData.cfgInfo.DailyDupId == dailyDupPOD.common.cid then
				local isLv = PlayerModule.PlayerInfo.baseInfo.pLv >= challengeLayerData.cfgInfo.LevelLimit
				local isFight

				if challengeLayerData.cfgInfo.UnlockCondition ~= nil and challengeLayerData.cfgInfo.UnlockCondition > 0 then
					local dailyDupPod = DailyDupModule.GetDailyDupPOD(self.cfgID)

					isFight = table.indexOf(dailyDupPod.challengePOD.difficult, challengeLayerData.cfgInfo.UnlockCondition) ~= -1
				else
					isFight = true
				end

				challengeLayerData.isLock = isLv and isFight
			end
		end
	end
end

function ChallengeData:UpdateChallengeLayerByLv()
	local isOpenNew = false

	if self.challengeLayerDic then
		for i, challengeLayerData in pairs(self.challengeLayerDic) do
			if challengeLayerData.isLock == false then
				local isLv = PlayerModule.PlayerInfo.baseInfo.pLv >= challengeLayerData.cfgInfo.LevelLimit
				local isFight

				if challengeLayerData.cfgInfo.UnlockCondition ~= nil and challengeLayerData.cfgInfo.UnlockCondition > 0 then
					local dailyDupPod = DailyDupModule.GetDailyDupPOD(self.cfgID)

					isFight = table.indexOf(dailyDupPod.challengePOD.difficult, challengeLayerData.cfgInfo.UnlockCondition) ~= -1
				else
					isFight = true
				end

				challengeLayerData.isLock = isLv and isFight

				if isOpenNew == false then
					isOpenNew = isLv and isFight
				end
			end
		end
	end

	return isOpenNew
end

function ChallengeData:GetLockIndex()
	local index = 1

	if self.challengeLayerDic then
		for i = 1, #self.challengeLayerDic do
			local layerData = self.challengeLayerDic[i]

			if layerData.isLock then
				index = i
			end
		end
	end

	return index
end

function ChallengeData:GetChallengeTimes()
	local dailyDupPOD = DailyDupModule.GetDailyDupPOD(self.cfgID)
	local totalTimes = self.cfgInfo.Times

	return totalTimes + dailyDupPOD.buyCount - dailyDupPOD.enterCount
end

function ChallengeData:IsOpenFunction()
	local result = UnlockFunctionModule.IsUnlock(self.cfgInfo.OpenFunction)

	return result
end

return ChallengeData
