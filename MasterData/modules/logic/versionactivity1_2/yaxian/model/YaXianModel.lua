-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/YaXianModel.lua

module("modules.logic.versionactivity1_2.yaxian.model.YaXianModel", package.seeall)

local YaXianModel = class("YaXianModel", BaseModel)

function YaXianModel:onInit()
	self.actId = nil
	self.hasGetBonusIdDict = nil
end

function YaXianModel:reInit()
	self.actId = nil
	self.hasGetBonusIdDict = nil
end

function YaXianModel:updateInfo(serverData)
	self.actId = serverData.activityId

	self:updateGetBonusId(serverData.hasGetBonusIds)
	self:updateEpisodeInfo(serverData.episodes)

	if serverData:HasField("map") then
		self:updateCurrentMapInfo(serverData.map)
	else
		self.currentMapMo = nil
	end
end

function YaXianModel:updateCurrentMapInfo(mapInfo)
	self.currentMapMo = YaXianMapMo.New()

	self.currentMapMo:init(self.actId, mapInfo)
end

function YaXianModel:getCurrentMapInfo()
	return self.currentMapMo
end

function YaXianModel.sortEpisodeMoFunc(episodeMoA, episodeMoB)
	return episodeMoA.id < episodeMoB.id
end

function YaXianModel:updateEpisodeInfo(episodeInfos)
	self.episodeList = self.episodeList or {}
	self.chapterId2EpisodeListDict = self.chapterId2EpisodeListDict or {}

	for _, episodeInfo in ipairs(episodeInfos) do
		local episodeMo = self:getEpisodeMo(episodeInfo.id)

		if episodeMo then
			episodeMo:updateData(episodeInfo)
		else
			episodeMo = YaXianEpisodeMo.New()

			episodeMo:init(self.actId, episodeInfo)
			self:addToChapterId2EpisodeListDict(episodeMo)
			table.insert(self.episodeList, episodeMo)
		end
	end

	table.sort(self.episodeList, YaXianModel.sortEpisodeMoFunc)

	for _, episodeList in pairs(self.chapterId2EpisodeListDict) do
		table.sort(episodeList, YaXianModel.sortEpisodeMoFunc)
	end

	self:updateScore()
	self:calculateLastCanFightEpisodeMo()
	self:updateTrialMaxTemplateId()
	YaXianController.instance:dispatchEvent(YaXianEvent.OnUpdateEpisodeInfo)
end

function YaXianModel:addToChapterId2EpisodeListDict(episodeMo)
	local chapterId = episodeMo.config.chapterId

	self.chapterId2EpisodeListDict[chapterId] = self.chapterId2EpisodeListDict[chapterId] or {}

	table.insert(self.chapterId2EpisodeListDict[chapterId], episodeMo)
end

function YaXianModel:calculateLastCanFightEpisodeMo()
	for _, episodeMo in ipairs(self.episodeList) do
		if episodeMo.star == 0 then
			self.lastCanFightEpisodeMo = episodeMo

			return
		end
	end

	self.lastCanFightEpisodeMo = self.episodeList[#self.episodeList]
end

function YaXianModel:getLastCanFightEpisodeMo(chapterId)
	if not chapterId then
		return self.lastCanFightEpisodeMo
	end

	local episodeList = self.chapterId2EpisodeListDict[chapterId]
	local preNotPassEpisode

	for i = #episodeList, 1, -1 do
		local episodeMo = episodeList[i]

		if episodeMo.star == 0 then
			preNotPassEpisode = episodeMo
		elseif preNotPassEpisode then
			return preNotPassEpisode
		else
			return episodeMo
		end
	end

	return preNotPassEpisode
end

function YaXianModel:getEpisodeMo(episodeId)
	for _, episodeMo in ipairs(self.episodeList) do
		if episodeMo.id == episodeId then
			return episodeMo
		end
	end
end

function YaXianModel:getEpisodeList(chapterId)
	return self.chapterId2EpisodeListDict[chapterId]
end

function YaXianModel:getChapterFirstEpisodeMo(chapterId)
	local episodeList = self:getEpisodeList(chapterId)

	return episodeList and episodeList[1]
end

function YaXianModel:chapterIsUnlock(chapterId)
	local episodeMoList = self:getEpisodeList(chapterId)

	return episodeMoList and self:getLastCanFightEpisodeMo().id >= episodeMoList[1].id
end

function YaXianModel:getScore()
	return self.score or 0
end

function YaXianModel:updateGetBonusId(bonusIdList)
	self.hasGetBonusIdDict = {}

	for _, bonusId in ipairs(bonusIdList) do
		self.hasGetBonusIdDict[bonusId] = true
	end

	YaXianController.instance:dispatchEvent(YaXianEvent.OnUpdateBonus)
end

function YaXianModel:hasGetBonus(bonusId)
	return self.hasGetBonusIdDict[bonusId]
end

function YaXianModel:updateScore()
	self.score = 0

	for _, episodeMo in ipairs(self.episodeList) do
		self.score = self.score + episodeMo.star
	end
end

function YaXianModel:updateTrialMaxTemplateId()
	self.maxTrialTemplateId = 1

	for _, episodeMo in ipairs(self.episodeList) do
		if episodeMo.star > 0 and episodeMo.config.trialTemplate > self.maxTrialTemplateId then
			self.maxTrialTemplateId = episodeMo.config.trialTemplate
		end
	end
end

function YaXianModel:getMaxTrialTemplateId()
	return self.maxTrialTemplateId
end

function YaXianModel:getHeroIdAndSkinId()
	local trialConfig = lua_hero_trial.configDict[YaXianEnum.HeroTrialId][self.maxTrialTemplateId]

	return trialConfig.heroId, trialConfig.skin
end

function YaXianModel:hadTooth(toothId)
	if toothId == 0 then
		return true
	end

	local unlockEpisodeId = YaXianConfig.instance:getToothUnlockEpisode(toothId)

	if not unlockEpisodeId then
		logError("ya xian tooth unlock episode id not exist")

		return true
	end

	local episodeMo = self:getEpisodeMo(unlockEpisodeId)

	if not episodeMo then
		return false
	end

	return episodeMo.star > 0
end

function YaXianModel:getHadToothCount()
	local count = 0

	for _, toothConfig in ipairs(lua_activity115_tooth.configList) do
		if self:hadTooth(toothConfig.id) then
			count = count + 1
		end
	end

	return count
end

function YaXianModel:isFirstEpisode(episodeId)
	for _, episodeList in pairs(self.chapterId2EpisodeListDict) do
		if episodeList[1].id == episodeId then
			return true
		end
	end

	return false
end

function YaXianModel:setPlayingClickAnimation(isPlaying)
	self.isPlayingClickAnimation = isPlaying

	YaXianController.instance:dispatchEvent(YaXianEvent.OnPlayingClickAnimationValueChange)
end

function YaXianModel:checkIsPlayingClickAnimation()
	return self.isPlayingClickAnimation
end

YaXianModel.instance = YaXianModel.New()

return YaXianModel
