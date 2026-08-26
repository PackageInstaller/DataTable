-- chunkname: @modules/logic/seasonver/act166/model/Season166MO.lua

module("modules.logic.seasonver.act166.model.Season166MO", package.seeall)

local Season166MO = pureTable("Season166MO")

function Season166MO:updateInfo(info)
	self.activityId = info.activityId
	self.isFinishTeach = info.isFinishTeach

	self:updateSpotsInfo(info.bases)
	self:updateTrainsInfo(info.trains)
	self:updateTeachsInfo(info.teachs)
	self:updateInfomation(info.information)
	self:initTalentInfo(info.talents)

	self.spotHeroGroupSnapshot = Season166HeroGroupUtils.buildSnapshotHeroGroups(info.baseHeroGroupSnapshot)
	self.trainHeroGroupSnapshot = Season166HeroGroupUtils.buildSnapshotHeroGroups(info.trainHeroGroupSnapshot)
end

function Season166MO:updateInfomation(information)
	self.infoBonusDict = {}
	self.informationDict = {}

	for i = 1, #information.bonusIds do
		self.infoBonusDict[information.bonusIds[i]] = 1
	end

	self:updateInfos(information.infos)
end

function Season166MO:updateInfos(infos)
	local hasNewInfo = false

	for i = 1, #infos do
		local info = infos[i]
		local mo = self.informationDict[info.id]

		if not mo then
			mo = Season166InfoMO.New()

			mo:init(self.activityId)

			self.informationDict[info.id] = mo
			hasNewInfo = true
		end

		mo:setData(info)
	end

	return hasNewInfo
end

function Season166MO:updateAnalyInfoStage(infoId, stage)
	local mo = self.informationDict[infoId]

	if mo then
		mo.stage = stage
	end
end

function Season166MO:updateInfoBonus(infoId, bonusStage)
	local mo = self.informationDict[infoId]

	if mo then
		mo.bonusStage = bonusStage
	end
end

function Season166MO:onReceiveInformationBonus(bonusIds)
	for i = 1, #bonusIds do
		self.infoBonusDict[bonusIds[i]] = 1
	end
end

function Season166MO:updateSpotsInfo(baseSpotInfos)
	self.baseSpotInfoMap = {}

	for i = 1, #baseSpotInfos do
		local baseSpotData = baseSpotInfos[i]
		local baseSpotMO = Season166BaseSpotMO.New()

		baseSpotMO:setData(baseSpotData)

		self.baseSpotInfoMap[baseSpotData.id] = baseSpotMO
	end
end

function Season166MO:updateMaxScore(spotId, score)
	local baseSpotMO = self.baseSpotInfoMap[spotId]

	if baseSpotMO then
		baseSpotMO.maxScore = score
	end
end

function Season166MO:updateTrainsInfo(trainsInfo)
	self.trainInfoMap = {}

	for i = 1, #trainsInfo do
		local trainData = trainsInfo[i]
		local trainMO = Season166TrainMO.New()

		trainMO:setData(trainData)

		self.trainInfoMap[trainData.id] = trainMO
	end
end

function Season166MO:updateTeachsInfo(teachsInfo)
	self.teachInfoMap = {}

	for i = 1, #teachsInfo do
		local teachData = teachsInfo[i]
		local teachMO = Season166TeachMO.New()

		teachMO:setData(teachData)

		self.teachInfoMap[teachData.id] = teachMO
	end
end

function Season166MO:getHeroGroupSnapShot(episodeType)
	if episodeType == DungeonEnum.EpisodeType.Season166Base then
		return self.spotHeroGroupSnapshot
	elseif episodeType == DungeonEnum.EpisodeType.Season166Train then
		return self.trainHeroGroupSnapshot
	end
end

function Season166MO:getInformationMO(infoId)
	return self.informationDict[infoId]
end

function Season166MO:isBonusGet(bonusId)
	return self.infoBonusDict[bonusId] == 1
end

function Season166MO:getBonusNum()
	local list = Season166Config.instance:getSeasonInfoBonuss(self.activityId) or {}
	local bonusCount = #list
	local canGetBonusCount = 0
	local analyCount = self:getInfoAnalyCount()

	for i, v in ipairs(list) do
		if analyCount >= v.analyCount then
			canGetBonusCount = canGetBonusCount + 1
		end
	end

	return canGetBonusCount, bonusCount
end

function Season166MO:getInfoAnalyCount()
	local count = 0

	for k, v in pairs(self.informationDict) do
		if v:hasAnaly() then
			count = count + 1
		end
	end

	return count
end

function Season166MO:initTalentInfo(talentInfos)
	self.talentMap = {}

	for _, info in ipairs(talentInfos) do
		local talentMO = self.talentMap[info.id]

		talentMO = talentMO or Season166TalentMO.New()

		talentMO:setData(info)

		self.talentMap[info.id] = talentMO
	end
end

function Season166MO:updateTalentInfo(talentInfo)
	local talentMO = self.talentMap[talentInfo.id]

	if not talentMO then
		logError("talent not init" .. talentInfo.id)
	end

	talentMO:setData(talentInfo)
end

function Season166MO:setTalentSkillIds(talentId, skillIds)
	local talentMO = self:getTalentMO(talentId)
	local oldSkillCnt = #talentMO.skillIds

	talentMO:updateSkillIds(skillIds)

	return oldSkillCnt < #skillIds
end

function Season166MO:getTalentMO(talentId)
	local talentMO = self.talentMap[talentId]

	if not talentMO then
		logError("dont exist TalentMO" .. talentId)
	end

	return talentMO
end

function Season166MO:isTrainPass(trainId)
	local trainMO = self.trainInfoMap[trainId]

	if trainMO then
		return trainMO.passCount > 0
	end

	return false
end

function Season166MO:setSpotBaseEnter(spotId, isEnter)
	local baseSpotMO = self.baseSpotInfoMap[spotId]

	if baseSpotMO then
		baseSpotMO.isEnter = isEnter
	end
end

return Season166MO
