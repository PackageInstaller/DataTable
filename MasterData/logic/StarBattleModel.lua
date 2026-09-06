-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/model/StarBattleModel.lua

module("logic.extensions.starbattle.model.StarBattleModel", package.seeall)

local StarBattleModel = class("StarBattleModel", BaseModel)

function StarBattleModel:onInit()
	self:onReset()
end

function StarBattleModel:onReset()
	self._baseInfoMap = {}
	self._rankInfoMap = {}
end

function StarBattleModel:getBaseInfo(activityId, periodId)
	local key = StarBattleController.instance:getInfoKey(activityId, periodId)

	if key and self._baseInfoMap[key] then
		return self._baseInfoMap[key]
	else
		print(string.format("星球守护数据未初始化：%s_%s", activityId, periodId))
	end
end

function StarBattleModel:getRankInfo(activityId, periodId, typeId)
	local actId = checknumber(activityId)
	local perId = checknumber(periodId)
	local tId = checknumber(typeId)
	local key = string.format("%s_%s_%s", actId, perId, tId)
	local rankInfo = self._rankInfoMap[key]

	if rankInfo then
		return rankInfo
	else
		print(string.format("星球守护排行榜数据未初始化：%s", key))
	end
end

function StarBattleModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local key = StarBattleController.instance:getInfoKey(msg.activityId, msg.periodId)

	if key then
		self._baseInfoMap[key] = info
	end
end

function StarBattleModel:onSaveDefense(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(msg.activityId, msg.periodId)

	if baseInfo then
		-- block empty
	end
end

function StarBattleModel:onNotifyStageChallenge(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(msg.activityId, msg.periodId)

	if baseInfo then
		-- block empty
	end
end

function StarBattleModel:onNotifyBossChallenge(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(msg.activityId, msg.periodId)

	if baseInfo then
		-- block empty
	end
end

function StarBattleModel:onSignIn(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(msg.activityId, msg.periodId)

	if baseInfo then
		baseInfo.signInDays = info.signInDays
		baseInfo.isTodaySignIn = true
	end
end

function StarBattleModel:onGainProgressPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(msg.activityId, msg.periodId)

	if baseInfo then
		if not baseInfo.hasGainBossProgressIds then
			table.insert(baseInfo.hasGainBossProgressIds, msg.progressId)

			baseInfo.hasGainBossProgressIds = baseInfo.hasGainBossProgressIds
		end
	end
end

function StarBattleModel:onGetRankView(msg)
	local info = GameUtil.pbToTable(msg)
	local actId = checknumber(msg.activityId)
	local perId = checknumber(msg.periodId)
	local tId = checknumber(msg.rankId)
	local key = string.format("%s_%s_%s", actId, perId, tId)

	self._rankInfoMap[key] = info
end

function StarBattleModel:onVerifyRace(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(msg.activityId, msg.periodId)

	if baseInfo then
		baseInfo.verifiedRaceId = info.verifiedRaceId
		baseInfo.stageInfos = info.stageInfos
		baseInfo.maxBossScore = info.maxBossScore
		baseInfo.totalScore = info.totalScore
	end
end

function StarBattleModel:onOneClickGainDefensePrize(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(msg.activityId, msg.periodId)

	if baseInfo then
		if not info.prizeId then
			if not info.raceId then
				local raceId = 0

				if raceId > 0 then
					if not baseInfo.defenseRaceInfos then
						local defenseRaceInfos = {}
						local raceInfo

						for i, raceInfo in ipairs(defenseRaceInfos) do
							if raceInfo.raceId == raceId then
								break
							end
						end

						local isNeedAdd = false

						if not raceInfo then
							raceInfo = {
								raceId = raceId,
								hasGainDefenceRacePrizeIds = {}
							}
							raceInfo.maxZdl = baseInfo.curDefenseZdl or 0
							isNeedAdd = true
						end

						if not raceInfo.hasGainDefenceRacePrizeIds then
							local hasGainDefenceRacePrizeIds = {}

							for i, prizeId in ipairs(info.prizeId) do
								table.insert(hasGainDefenceRacePrizeIds, prizeId)
							end

							raceInfo.hasGainDefenceRacePrizeIds = hasGainDefenceRacePrizeIds

							if isNeedAdd then
								table.insert(defenseRaceInfos, raceInfo)

								baseInfo.defenseRaceInfos = defenseRaceInfos
							end
						end
					end
				elseif not baseInfo.hasGainDefencePrizeIds then
					local hasGainDefencePrizeIds = {}

					for i, prizeId in ipairs(info.prizeId) do
						table.insert(hasGainDefencePrizeIds, prizeId)
					end

					baseInfo.hasGainDefencePrizeIds = hasGainDefencePrizeIds
				end
			end
		end
	end
end

StarBattleModel.instance = StarBattleModel.New()

return StarBattleModel
