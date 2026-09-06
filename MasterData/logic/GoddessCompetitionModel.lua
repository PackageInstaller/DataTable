-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/model/GoddessCompetitionModel.lua

module("logic.extensions.goddesscompetition.model.GoddessCompetitionModel", package.seeall)

local GoddessCompetitionModel = class("GoddessCompetitionModel", BaseModel)

function GoddessCompetitionModel:ctor()
	return
end

function GoddessCompetitionModel:onInit()
	self:onReset()
end

function GoddessCompetitionModel:onReset()
	self._baseInfo = {}
	self._rpRecordInfos = {}
	self._redPackListInfos = {}
	self._randSortMap = nil
	self._curActId = nil
	self._totalPopularityMap = {}
	self._gainPrizeIdsSet = {}

	self:resetRankInfo()
end

function GoddessCompetitionModel:setCurActId(curActId)
	self._curActId = curActId
end

function GoddessCompetitionModel:getCurActId()
	return self._curActId
end

function GoddessCompetitionModel:getBaseInfo(actId)
	if not self._baseInfo[actId] then
		printInfo("女神大赛数据未初始化")
	end

	return self._baseInfo[actId]
end

function GoddessCompetitionModel:getCurActBaseInfo()
	return self:getBaseInfo(self._curActId)
end

function GoddessCompetitionModel:getRpRecordInfo(actId)
	if not self._rpRecordInfos[actId] then
		printInfo("女神大赛紅包記錄数据為空")
	end

	return self._rpRecordInfos[actId]
end

function GoddessCompetitionModel:getRedPackListInfo(actId, redPackType)
	if self._redPackListInfos[actId] then
		if not self._redPackListInfos[actId] then
			printInfo("女神大赛紅包列表数据為空")
		end

		return self._redPackListInfos[actId]
	end
end

function GoddessCompetitionModel:getCurGoddessList(stepId)
	local baseInfo = self:getCurActBaseInfo()

	if not baseInfo.stepList then
		local stepType = GoddessCompetitionConfig.instance:getStepTypeByStepId(self._curActId, stepId)

		for _, stepInfo in ipairs(baseInfo.stepList) do
			if stepId == stepInfo.stepId then
				if stepType == GoddessCompetitionController.instance.Step_Preliminary then
					local goddessList = {}

					for _, goddessInfo in ipairs(stepInfo.goddessList) do
						table.insert(goddessList, goddessInfo)
					end

					return goddessList
				elseif stepType == GoddessCompetitionController.instance.Step_Group then
					local goddessList = {}

					for _, goddessInfo in ipairs(stepInfo.goddessList) do
						table.insert(goddessList, goddessInfo)
					end

					ArraySort.sortOn(goddessList, {
						"groupId",
						"faceId"
					}, {
						ArraySort.NUMERIC,
						ArraySort.NUMERIC
					})

					return goddessList
				elseif stepType == GoddessCompetitionController.instance.Step_finals then
					local goddessList = self:getCurGoddessList(stepId - 1)
					local map = {}
					local maxLength = 0

					for i, v in ipairs(stepInfo.goddessList) do
						for j, vv in ipairs(goddessList) do
							if vv.faceId == v.faceId then
								map[j] = v
								maxLength = math.max(maxLength, j)
							end
						end
					end

					local result = {}

					for i = 1, maxLength do
						local info = map[i]

						if info then
							table.insert(result, info)
						end
					end

					return result
				else
					return stepInfo.goddessList
				end
			end
		end

		return {}
	end
end

function GoddessCompetitionModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	info.packSendMap = {}

	for i, v in ipairs(info.sendTimesList) do
		info.packSendMap[v.redPackDefineId] = v.todayTimes
	end

	self._baseInfo[info.activityId] = info

	local tpMap = {}

	if info.totalPopularityList then
		for _, v in ipairs(info.totalPopularityList) do
			tpMap[v.faceId] = v.popularity
		end
	end

	self._totalPopularityMap[info.activityId] = tpMap

	local gpSet = {}

	if info.gainPrizeIds then
		for _, prizeId in ipairs(info.gainPrizeIds) do
			gpSet[prizeId] = true
		end
	end

	self._gainPrizeIdsSet[info.activityId] = gpSet
end

function GoddessCompetitionModel:onVote(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = checknumber(info.activityId)
	local faceId = checknumber(info.faceId)
	local incPopularity = checknumber(info.incPopularity)
	local voteCount = checknumber(info.voteCount)
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		local curStepId = checknumber(baseInfo.curStepId)

		if not baseInfo.stepList then
			local stepList = {}

			for _, stepInfo in ipairs(stepList) do
				if checknumber(stepInfo.stepId) == curStepId then
					if not stepInfo.goddessList then
						for _, goddessInfo in ipairs(stepInfo.goddessList) do
							if checknumber(goddessInfo.faceId) == faceId then
								goddessInfo.popularity = checknumber(goddessInfo.popularity) + incPopularity

								break
							end
						end

						break
					end
				end
			end
		end
	end

	self._totalPopularityMap[activityId] = self._totalPopularityMap[activityId] or {}

	local tpMap = self._totalPopularityMap[activityId]

	tpMap[faceId] = checknumber(tpMap[faceId]) + incPopularity

	local popularityRate = self:getVotePopularityRate(activityId, faceId)
	local basePopularity = self:calcVoteBasePopularity(voteCount, popularityRate)

	if baseInfo and baseInfo.doubleCard then
		local doubleCard = baseInfo.doubleCard
		local effectDoubleCardId = checknumber(doubleCard.effectDoubleCardId)
		local leftValue = checknumber(doubleCard.doubleCardLeftValue)
		local consumedValue = math.min(basePopularity, leftValue)

		doubleCard.doubleCardLeftValue = math.max(0, leftValue - consumedValue)

		if doubleCard.doubleCardLeftValue <= 0 then
			doubleCard.effectDoubleCardId = 0
		end
	end
end

function GoddessCompetitionModel:onUseDoubleCard(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(info.activityId)

	if baseInfo then
		baseInfo.doubleCard = info.doubleCard
	end
end

function GoddessCompetitionModel:onGainProgressPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local gpSet = self._gainPrizeIdsSet[info.activityId]

	if not gpSet then
		gpSet = {}
		self._gainPrizeIdsSet[info.activityId] = gpSet
	end

	if info.prizeIds then
		for _, prizeId in ipairs(info.prizeIds) do
			gpSet[prizeId] = true
		end
	end
end

function GoddessCompetitionModel:onDoubleCardNotify(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(info.activityId)

	if baseInfo then
		baseInfo.doubleCard = info.doubleCard
	end
end

function GoddessCompetitionModel:onGetRedPackRecord(msg)
	local info = GameUtil.pbToTable(msg)

	self._rpRecordInfos[info.activityId] = info
end

function GoddessCompetitionModel:onGetRedPackList(msg)
	local info = GameUtil.pbToTable(msg)

	self._redPackListInfos[info.activityId] = {}
	self._redPackListInfos[info.activityId][info.redPackType] = info
end

function GoddessCompetitionModel:saveRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self.rankInfoList = data.rankInfoList
	self.myRank = data.myRank
	self.myAddPopularity = data.myAddPopularity
end

function GoddessCompetitionModel:getRankInfo()
	return self.rankInfoList, self.myRank, self.myAddPopularity
end

function GoddessCompetitionModel:resetRankInfo()
	self.rankInfoList = nil
	self.myRank = -1
	self.myAddPopularity = 0
end

function GoddessCompetitionModel:getTotalPopularity()
	local total = 0
	local tpMap = self._totalPopularityMap[self._curActId]

	if tpMap then
		for _, popularity in pairs(tpMap) do
			total = total + popularity
		end
	end

	return total
end

function GoddessCompetitionModel:getTotalPopularityByFaceId(faceId)
	local tpMap = self._totalPopularityMap[self._curActId]

	return (tpMap or nil) and (tpMap[faceId] or 0)
end

function GoddessCompetitionModel:getDoubleCardInfo()
	local baseInfo = self:getCurActBaseInfo()

	return baseInfo and baseInfo.doubleCard
end

function GoddessCompetitionModel:calcPopularityWithDoubleCard(basePopularity)
	local base, double = self:calcPopularityWithDoubleCardButBaseAndCard(basePopularity)

	return base + double
end

function GoddessCompetitionModel:calcPopularityWithDoubleCardButBaseAndCard(basePopularity)
	local baseValue = checknumber(basePopularity)
	local doubleCard = self:getDoubleCardInfo()
	local effectDoubleCardId = doubleCard and checknumber(doubleCard.effectDoubleCardId) or 0
	local cfg = GoddessCompetitionConfig.instance:getDoubleCardCfg(self._curActId, effectDoubleCardId)
	local ratio = cfg and checknumber(cfg.ratio) or 1
	local leftValue = doubleCard and checknumber(doubleCard.doubleCardLeftValue) or 0
	local doubledValue = math.min(baseValue, leftValue)
	local basePopularity = baseValue - doubledValue
	local doublePopularity = doubledValue * ratio

	return basePopularity, doublePopularity
end

function GoddessCompetitionModel:calcVoteBasePopularity(voteCount, popularityRate)
	local count = checknumber(voteCount)
	local rate = checknumber(popularityRate)

	return count * rate
end

function GoddessCompetitionModel:getVotePopularityRate(activityId, faceId)
	local actCfg = GoddessCompetitionConfig.instance:getActCfg(activityId)
	local normalRate = checknumber(actCfg and actCfg.normalFanPopularityRate)
	local superRate = checknumber(actCfg and actCfg.superFanPopularityRate)
	local baseInfo = self:getBaseInfo(activityId)

	if not baseInfo then
		return normalRate
	end

	local curStepId = checknumber(baseInfo.curStepId)

	if not baseInfo.stepList then
		local myUserId = tostring(RoleModel.instance:getUserId())
		local targetFaceId = checknumber(faceId)

		for _, stepInfo in ipairs(baseInfo.stepList) do
			if checknumber(stepInfo.stepId) == curStepId then
				for _, goddessInfo in ipairs(stepInfo.goddessList or {}) do
					if checknumber(goddessInfo.faceId) == targetFaceId then
						for _, fanInfo in ipairs(goddessInfo.superFansList or {}) do
							if fanInfo.headInfo and tostring(fanInfo.headInfo.userId) == myUserId then
								return superRate
							end
						end

						return normalRate
					end
				end

				break
			end
		end

		return normalRate
	end
end

function GoddessCompetitionModel:calcVotePopularity(voteCount, isSuperFan)
	local actCfg = GoddessCompetitionConfig.instance:getActCfg(self._curActId)
	local basePopularity = self:calcVoteBasePopularity(voteCount, isSuperFan and checknumber(actCfg and actCfg.superFanPopularityRate) or checknumber(actCfg and actCfg.normalFanPopularityRate))

	return self:calcPopularityWithDoubleCard(basePopularity)
end

function GoddessCompetitionModel:isPrizeGained(prizeId)
	local gpSet = self._gainPrizeIdsSet[self._curActId]

	return gpSet and gpSet[prizeId] == true or false
end

function GoddessCompetitionModel:getAvailableProgressPrizes()
	local result = {}
	local totalPop = self:getTotalPopularity()
	local cfgs = GoddessCompetitionConfig.instance:getProgressPrizeCfgs(self._curActId)

	if cfgs then
		for _, cfg in ipairs(cfgs) do
			local progress = checknumber(cfg.progress)

			if progress <= totalPop and not self:isPrizeGained(cfg.prizeId) then
				table.insert(result, cfg)
			end
		end
	end

	return result
end

function GoddessCompetitionModel:canGrabRedPack(faceId)
	local actCfg = GoddessCompetitionConfig.instance:getActCfg(self._curActId)
	local threshold = checknumber(actCfg and actCfg.gainRedPackNeedPopularity)
	local myPopularity = self:getTotalPopularityByFaceId(faceId)

	return threshold <= myPopularity
end

function GoddessCompetitionModel:getRedPackSendCount(redPackId)
	local baseInfo = self:getCurActBaseInfo()

	return checknumber(baseInfo.packSendMap[redPackId])
end

function GoddessCompetitionModel:saveSendRedPack(msg)
	local baseInfo = self:getCurActBaseInfo()

	baseInfo.packSendMap[msg.redPackDefineId] = baseInfo.packSendMap[msg.redPackDefineId] and baseInfo.packSendMap[msg.redPackDefineId] + 1 or 1

	local redPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(msg.activityId, msg.redPackDefineId)
	local goddessList = self:getCurGoddessList(baseInfo.curStepId)
	local basePopularity = checknumber(redPackCfg.incPopularity)
	local actualIncPopularity = self:calcPopularityWithDoubleCard(basePopularity)

	if baseInfo and baseInfo.doubleCard then
		local doubleCard = baseInfo.doubleCard
		local effectDoubleCardId = checknumber(doubleCard.effectDoubleCardId)
		local leftValue = checknumber(doubleCard.doubleCardLeftValue)

		if effectDoubleCardId > 0 and leftValue > 0 then
			local consumedValue = math.min(basePopularity, leftValue)

			doubleCard.doubleCardLeftValue = math.max(0, leftValue - consumedValue)

			if doubleCard.doubleCardLeftValue <= 0 then
				doubleCard.effectDoubleCardId = 0
			end
		end
	end

	for i, v in ipairs(goddessList) do
		if v.faceId == msg.faceId then
			v.popularity = v.popularity + actualIncPopularity
			self._totalPopularityMap[msg.activityId] = self._totalPopularityMap[msg.activityId] or {}

			local tpMap = self._totalPopularityMap[msg.activityId]

			tpMap[msg.faceId] = (tpMap[msg.faceId] or 0) + actualIncPopularity
		end
	end
end

function GoddessCompetitionModel:setRandSortMap(activityId)
	self._randSortMap = {}

	local goddessCfgs = GoddessCompetitionConfig.instance:getGoddessCfgs(activityId)
	local goddessList = {}

	for i, v in ipairs(goddessCfgs) do
		table.insert(goddessList, v.goddessFaceId)
	end

	goddessList = GameUtil.permuteArray(goddessList)

	for i, v in ipairs(goddessList) do
		self._randSortMap[v] = i
	end

	return self._randSortMap
end

function GoddessCompetitionModel:getRandSortMap()
	return self._randSortMap
end

function GoddessCompetitionModel:resetRandSortMap()
	self._randSortMap = nil
end

GoddessCompetitionModel.instance = GoddessCompetitionModel.New()

return GoddessCompetitionModel
