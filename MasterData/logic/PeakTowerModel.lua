-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/model/PeakTowerModel.lua

module("logic.extensions.peaktower.model.PeakTowerModel", package.seeall)

local PeakTowerModel = class("PeakTowerModel", BaseModel)

function PeakTowerModel:ctor()
	return
end

function PeakTowerModel:onInit()
	self:onReset()
end

function PeakTowerModel:onReset()
	self._infos = {}
	self._basicFloorInfo = {}
	self._legendFloorInfo = {}
	self._basicRankInfo = {}
	self._basicFmtMo = nil
	self._lengendFmtMo = nil
	self._maxBasicFloor = {}
	self._maxLegendFloor = {}
	self._legendRankInfo = {}
	self._verifyZdl = {}
end

function PeakTowerModel:getBasicFmtMo()
	self._basicFmtMo = self._basicFmtMo or PeakTowerBasicFmtMo.New()

	return self._basicFmtMo
end

function PeakTowerModel:getLegendFmtMo()
	self._lengendFmtMo = self._lengendFmtMo or PeakTowerLegendFmtMo.New()

	return self._lengendFmtMo
end

function PeakTowerModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data
	self._basicFloorInfo[data.activityId] = {}

	if data.basicFloorInfos then
		for i, floorInfo in ipairs(data.basicFloorInfos) do
			floorInfo.passStageMap = {}

			if floorInfo.passStageIds then
				for j, id in ipairs(floorInfo.passStageIds) do
					floorInfo.passStageMap[id] = true
				end
			else
				floorInfo.passStageIds = {}
			end

			floorInfo.banRaceMap = {}
			floorInfo.stageInfoMap = {}

			local curStageScore = 0

			if floorInfo.stageInfos then
				for j, stageInfo in ipairs(floorInfo.stageInfos) do
					floorInfo.stageInfoMap[stageInfo.stageId] = stageInfo

					for m, id in ipairs(stageInfo.banRaceIds or {}) do
						floorInfo.banRaceMap[id] = true
					end

					curStageScore = curStageScore + stageInfo.score
				end
			end

			if floorInfo.maxScore > 0 then
				floorInfo.gainPrize = true
			end

			self._basicFloorInfo[data.activityId][floorInfo.floorId] = floorInfo
		end
	end

	self._legendFloorInfo[data.activityId] = {}

	if data.legendFloorInfos then
		for i, floorInfo in ipairs(data.legendFloorInfos) do
			floorInfo.passStageMap = {}

			if floorInfo.passStageIds then
				for j, id in ipairs(floorInfo.passStageIds) do
					floorInfo.passStageMap[id] = true
				end
			else
				floorInfo.passStageIds = {}
			end

			floorInfo.banRaceMap = {}
			floorInfo.stageInfoMap = {}

			local curStageScore = 0

			if floorInfo.stageInfos then
				for j, stageInfo in ipairs(floorInfo.stageInfos) do
					floorInfo.stageInfoMap[stageInfo.stageId] = stageInfo

					for m, id in ipairs(stageInfo.banRaceIds or {}) do
						floorInfo.banRaceMap[id] = true
					end

					curStageScore = curStageScore + stageInfo.score
				end
			end

			if floorInfo.maxScore > 0 then
				floorInfo.gainPrize = true
			end

			self._legendFloorInfo[data.activityId][floorInfo.floorId] = floorInfo
		end
	end

	if data.raceIdToMaxVerifyPower then
		for i, v in ipairs(data.raceIdToMaxVerifyPower) do
			self:saveVerifyZdl(data.activityId, v.left, v.right)
		end
	end
end

function PeakTowerModel:saveBasicRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._basicRankInfo[data.activityId] = {}

	if data.infoList then
		for i, v in ipairs(data.infoList) do
			local rankInfo

			if v.infoList then
				for j, info in ipairs(v.infoList) do
					if checknumber(info.rank) == 1 then
						rankInfo = info

						break
					end
				end
			end

			if rankInfo then
				self._basicRankInfo[data.activityId][v.floorId] = rankInfo
			end
		end
	end
end

function PeakTowerModel:getBasicRankInfo(activityId, floorId)
	if self._basicRankInfo[activityId] then
		return self._basicRankInfo[activityId][floorId]
	end
end

function PeakTowerModel:getBasicFloorInfo(activityId, floorId)
	if self._basicFloorInfo[activityId] then
		return self._basicFloorInfo[activityId][floorId]
	end
end

function PeakTowerModel:saveLegendRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._legendRankInfo[data.activityId] = data
end

function PeakTowerModel:getLegendRankInfo(activityId)
	return self._legendRankInfo[activityId]
end

function PeakTowerModel:getLegendFloorInfo(activityId, floorId)
	if self._legendFloorInfo[activityId] then
		return self._legendFloorInfo[activityId][floorId]
	end
end

function PeakTowerModel:isBasicStagePass(activityId, floorId, stageId)
	if self._basicFloorInfo[activityId] and self._basicFloorInfo[activityId][floorId] then
		return self._basicFloorInfo[activityId][floorId].passStageMap[stageId] == true
	end

	return false
end

function PeakTowerModel:isLegendStagePass(activityId, floorId, stageId)
	if self._legendFloorInfo[activityId] and self._legendFloorInfo[activityId][floorId] then
		return self._legendFloorInfo[activityId][floorId].passStageMap[stageId] == true
	end

	return false
end

function PeakTowerModel:setBasicMaxPassFloor(activityId, floorId)
	if self._infos[activityId] then
		self._infos[activityId].maxPassBasicFloorId = floorId
	end
end

function PeakTowerModel:getBasicMaxPassFloor(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].maxPassBasicFloorId or 0
	end

	return 0
end

function PeakTowerModel:setLegendMaxPassFloor(activityId, floorId)
	if self._infos[activityId] then
		self._infos[activityId].maxPassLegendFloorId = floorId
	end
end

function PeakTowerModel:getLegendMaxPassFloor(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].maxPassLegendFloorId or 0
	end

	return 0
end

function PeakTowerModel:getMaxGainBasicProgressId(activityId)
	if self._infos[activityId] then
		return checknumber(self._infos[activityId].maxGainBasicProgressId)
	end

	return 0
end

function PeakTowerModel:getMaxGainLegendProgressId(activityId)
	if self._infos[activityId] then
		return checknumber(self._infos[activityId].maxGainLegendProgressId)
	end

	return 0
end

function PeakTowerModel:saveVerifyZdl(activityId, raceId, zdl)
	self._verifyZdl[activityId] = self._verifyZdl[activityId] or {}
	self._verifyZdl[activityId][raceId] = zdl
end

function PeakTowerModel:getVerifyZdl(activityId, raceId)
	if self._verifyZdl[activityId] then
		return self._verifyZdl[activityId][raceId]
	end
end

function PeakTowerModel:getBasicStageBanPetIds(activityId, floorId, stageId)
	if self._basicFloorInfo[activityId] and self._basicFloorInfo[activityId][floorId] and self._basicFloorInfo[activityId][floorId].stageInfoMap[stageId] then
		return self._basicFloorInfo[activityId][floorId].stageInfoMap[stageId].banRaceIds
	end
end

function PeakTowerModel:getLegendStageBanPetIds(activityId, floorId, stageId)
	if self._legendFloorInfo[activityId] and self._legendFloorInfo[activityId][floorId] and self._legendFloorInfo[activityId][floorId].stageInfoMap[stageId] then
		return self._legendFloorInfo[activityId][floorId].stageInfoMap[stageId].banRaceIds
	end
end

function PeakTowerModel:isBanPetInBasicFloor(activityId, floorId, raceId)
	if self._basicFloorInfo[activityId] and self._basicFloorInfo[activityId][floorId] and self._basicFloorInfo[activityId][floorId] then
		return self._basicFloorInfo[activityId][floorId].banRaceMap[raceId] == true
	end

	return false
end

function PeakTowerModel:isBanPetInLegendFloor(activityId, floorId, raceId)
	if self._legendFloorInfo[activityId] and self._legendFloorInfo[activityId][floorId] and self._legendFloorInfo[activityId][floorId] then
		return self._legendFloorInfo[activityId][floorId].banRaceMap[raceId] == true
	end

	return false
end

function PeakTowerModel:saveBasicBattleInfo(msg)
	self._basicFloorInfo[msg.activityId] = self._basicFloorInfo[msg.activityId] or {}

	if not self._basicFloorInfo[msg.activityId][msg.floorId] then
		local floorInfo = {}

		floorInfo.floorId = msg.floorId
		floorInfo.floorType = 1
		floorInfo.passStageIds = {}
		floorInfo.maxScore = 0
		floorInfo.passStageMap = {}
		floorInfo.banRaceMap = {}
		floorInfo.stageInfoMap = {}
		self._basicFloorInfo[msg.activityId][msg.floorId] = floorInfo
	end

	local floorInfo = self._basicFloorInfo[msg.activityId][msg.floorId]

	table.insert(floorInfo.passStageIds, msg.stageId)

	floorInfo.passStageMap[msg.stageId] = true

	for i, id in ipairs(msg.banRaceIds or {}) do
		floorInfo.banRaceMap[id] = true
	end

	floorInfo.stageInfoMap[msg.stageId] = {
		stageId = msg.stageId,
		score = msg.score,
		banRaceIds = msg.banRaceIds
	}

	for i, id in ipairs(msg.banRaceIds or {}) do
		floorInfo.banRaceMap[id] = true
	end

	local curTotalScore = 0

	for i, v in pairs(floorInfo.stageInfoMap) do
		curTotalScore = curTotalScore + v.score
	end
end

function PeakTowerModel:setBasicMaxScore(activityId, floorId)
	if not self._basicFloorInfo[activityId] or not self._basicFloorInfo[activityId][floorId] then
		return
	end

	local floorInfo = self._basicFloorInfo[activityId][floorId]
	local curTotalScore = 0

	for i, v in pairs(floorInfo.stageInfoMap) do
		curTotalScore = curTotalScore + v.score
	end

	if curTotalScore > floorInfo.maxScore then
		floorInfo.maxScore = curTotalScore
	end
end

function PeakTowerModel:saveLegendBattleInfo(msg)
	self._legendFloorInfo[msg.activityId] = self._legendFloorInfo[msg.activityId] or {}

	if not self._legendFloorInfo[msg.activityId][msg.floorId] then
		local floorInfo = {}

		floorInfo.floorId = msg.floorId
		floorInfo.floorType = 1
		floorInfo.maxScore = 0
		floorInfo.passStageIds = {}
		floorInfo.passStageMap = {}
		floorInfo.banRaceMap = {}
		floorInfo.stageInfoMap = {}
		self._legendFloorInfo[msg.activityId][msg.floorId] = floorInfo
	end

	local floorInfo = self._legendFloorInfo[msg.activityId][msg.floorId]

	table.insert(floorInfo.passStageIds, msg.stageId)

	floorInfo.passStageMap[msg.stageId] = true

	for i, id in ipairs(msg.banRaceIds or {}) do
		floorInfo.banRaceMap[id] = true
	end

	floorInfo.stageInfoMap[msg.stageId] = {
		stageId = msg.stageId,
		score = msg.score,
		banRaceIds = msg.banRaceIds
	}

	for i, id in ipairs(msg.banRaceIds or {}) do
		floorInfo.banRaceMap[id] = true
	end

	local curTotalScore = 0

	for i, v in pairs(floorInfo.stageInfoMap) do
		curTotalScore = curTotalScore + v.score
	end
end

function PeakTowerModel:setLegendMaxScore(activityId, floorId)
	if not self._legendFloorInfo[activityId] or not self._legendFloorInfo[activityId][floorId] then
		return
	end

	local floorInfo = self._legendFloorInfo[activityId][floorId]
	local curTotalScore = 0

	for i, v in pairs(floorInfo.stageInfoMap) do
		curTotalScore = curTotalScore + v.score
	end

	if curTotalScore > floorInfo.maxScore then
		floorInfo.maxScore = curTotalScore
	end
end

function PeakTowerModel:saveResetBasicFloorInfo(msg)
	local floorInfo = self._basicFloorInfo[msg.activityId][msg.floorId]

	floorInfo.passStageIds = {}
	floorInfo.passStageMap = {}
	floorInfo.banRaceMap = {}
	floorInfo.stageInfoMap = {}
end

function PeakTowerModel:saveResetLegendFloorInfo(msg)
	local floorInfo = self._legendFloorInfo[msg.activityId][msg.floorId]

	floorInfo.passStageIds = {}
	floorInfo.passStageMap = {}
	floorInfo.banRaceMap = {}
	floorInfo.stageInfoMap = {}
end

function PeakTowerModel:saveGainPrizeInfo(msg)
	local info = self._infos[msg.activityId]

	if msg.type == 1 then
		local maxId = 0

		for i, v in ipairs(msg.gainProgressIds) do
			if maxId < v then
				maxId = v
			end
		end

		info.maxGainBasicProgressId = maxId
	elseif msg.type == 2 then
		local maxId = 0

		for i, v in ipairs(msg.gainProgressIds) do
			if maxId < v then
				maxId = v
			end
		end

		info.maxGainLegendProgressId = maxId
	end
end

function PeakTowerModel:getBasicStageInfo(activityId, floorId, stageId)
	if self._basicFloorInfo[activityId] and self._basicFloorInfo[activityId][floorId] then
		return self._basicFloorInfo[activityId][floorId].stageInfoMap[stageId]
	end
end

function PeakTowerModel:getLegendStageInfo(activityId, floorId, stageId)
	if self._legendFloorInfo[activityId] and self._legendFloorInfo[activityId][floorId] then
		return self._legendFloorInfo[activityId][floorId].stageInfoMap[stageId]
	end
end

function PeakTowerModel:setBasicGainPass(activityId, floorId, isGain)
	if self._basicFloorInfo[activityId] and self._basicFloorInfo[activityId][floorId] then
		self._basicFloorInfo[activityId][floorId].gainPrize = isGain
	end
end

function PeakTowerModel:getBasicGainPass(activityId, floorId)
	if self._basicFloorInfo[activityId] and self._basicFloorInfo[activityId][floorId] then
		return self._basicFloorInfo[activityId][floorId].gainPrize
	end
end

function PeakTowerModel:setLegendGainPass(activityId, floorId, isGain)
	if self._legendFloorInfo[activityId] and self._legendFloorInfo[activityId][floorId] then
		self._legendFloorInfo[activityId][floorId].gainPrize = isGain
	end
end

function PeakTowerModel:getLegendGainPass(activityId, floorId)
	if self._legendFloorInfo[activityId] and self._legendFloorInfo[activityId][floorId] then
		return self._legendFloorInfo[activityId][floorId].gainPrize
	end
end

PeakTowerModel.instance = PeakTowerModel.New()

return PeakTowerModel
