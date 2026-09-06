-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/TimedPointRaceModeModel.lua

module("logic.extensions.timelimitedchallenge.model.TimedPointRaceModeModel", package.seeall)

local TimedPointRaceModeModel = class("TimedPointRaceModeModel", BaseModel)

function TimedPointRaceModeModel:onInit()
	self:onReset()
end

function TimedPointRaceModeModel:onReset()
	self._infos = {}
end

function TimedPointRaceModeModel:getInfo(challengeId)
	local info = self._infos[challengeId]

	if info then
		return info
	else
		printError("限时挑战积分排位数据不存在")
	end
end

function TimedPointRaceModeModel:createInfo()
	local info = {}

	info.CIList = nil
	info.useBossTimes = 0
	info.buyBossTimes = 0
	info.useBuffTimes = 0
	info.buyBuffTimes = 0
	info.withBuffs = {}
	info.gainPrizes = {}
	info.totalScore = 0
	info.totalRankInfo = {}
	info.totalMyRank = -1
	info.dailyRankInfo = {}
	info.dailyMyRnak = -1
	info.lastDamage = 0
	info.lastScore = 0
	info.dailyMaxScore = 0

	return info
end

function TimedPointRaceModeModel:onGetInfo(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].totalScore = checkint(msg.totalScore)
			self._infos[challengeId].useBossTimes = checkint(msg.fightBossTimes)
			self._infos[challengeId].buyBossTimes = checkint(msg.buyBossTimes)
			self._infos[challengeId].useBuffTimes = checkint(msg.fightBuffTimes)
			self._infos[challengeId].buyBuffTimes = checkint(msg.useBuffTimes)
			self._infos[challengeId].dailyMaxScore = checkint(msg.dailyMaxScore)
			self._infos[challengeId].withBuffs = {}

			if not msg.buffProgresses then
				for _, buffLv in ipairs(msg.buffProgresses) do
					table.insert(self._infos[challengeId].withBuffs, checkint(buffLv))
				end

				self._infos[challengeId].gainPrizes = {}

				if not msg.scorePrizeState then
					for _, state in ipairs(msg.scorePrizeState) do
						table.insert(self._infos[challengeId].gainPrizes, checkbool(state))
					end

					if msg.changeSetId and checkint(msg.changeSetId) > 0 then
						self._infos[challengeId].CIList = msg.changeSetId

						MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
					end

					self._infos[challengeId] = self._infos[challengeId]
				end
			end
		end
	end
end

function TimedPointRaceModeModel:showCI(challengeId)
	local info = self._infos[challengeId]

	if info then
		local ci = checknumber(info.CIList)

		MaterialController.instance:showChangeSetInTemp(ci)

		info.CIList = nil
	end
end

function TimedPointRaceModeModel:onBossChallenge(msg)
	return
end

function TimedPointRaceModeModel:onBuffChallenge(msg)
	return
end

function TimedPointRaceModeModel:onBuyBossChallengeTime(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].buyBossTimes = self._infos[challengeId].buyBossTimes + 1
		end
	end
end

function TimedPointRaceModeModel:onBuyBuffChallengeTime(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].buyBuffTimes = self._infos[challengeId].buyBuffTimes + 1
		end
	end
end

function TimedPointRaceModeModel:onGainPrize(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].gainPrizes[checkint(msg.prizeId)] = true
		end
	end
end

function TimedPointRaceModeModel:onGainTotalRankInfo(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].totalRankInfo = {}

			if not msg.rankInfoList then
				for _, info in ipairs(msg.rankInfoList) do
					table.insert(info.totalRankInfo, info)
				end

				self._infos[challengeId].totalMyRank = checkint(msg.myRank)
			end
		end
	end
end

function TimedPointRaceModeModel:onGainDailyRankInfo(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].dailyRankInfo = {}

			if not msg.rankInfoList then
				for _, info in ipairs(msg.rankInfoList) do
					table.insert(info.dailyRankInfo, info)
				end

				self._infos[challengeId].dailyMyRnak = checkint(msg.myRank)
			end
		end
	end
end

function TimedPointRaceModeModel:onBossBattleSuc(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].totalScore = checkint(msg.totalScore)
			self._infos[challengeId].lastDamage = checkint(msg.damage)
			self._infos[challengeId].lastScore = checkint(msg.score)
			self._infos[challengeId].useBossTimes = self._infos[challengeId].useBossTimes + 1
		end
	end
end

function TimedPointRaceModeModel:onBuffBattleSuc(msg)
	local challengeId = checkint(msg.challengeId)

	if challengeId > 0 then
		if not self._infos[challengeId] then
			local info = self:createInfo()

			self._infos[challengeId].withBuffs = {}
			self._infos[challengeId].withBuffs[checkint(msg.buffType)] = checkint(msg.buffProgress)
		end
	end
end

TimedPointRaceModeModel.instance = TimedPointRaceModeModel.New()

return TimedPointRaceModeModel
