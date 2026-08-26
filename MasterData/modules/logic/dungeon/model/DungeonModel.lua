-- chunkname: @modules/logic/dungeon/model/DungeonModel.lua

module("modules.logic.dungeon.model.DungeonModel", package.seeall)

local DungeonModel = class("DungeonModel", BaseModel)

function DungeonModel:onInit()
	self:reInit()
end

function DungeonModel:reInit()
	self._dungeonChapterDic = {}
	self._dungeonEpisodeDic = {}
	self.curLookChapterId = nil
	self.curSelectTicketId = 0
	self.curSpeed = 1
	self.curChapterType = nil
	self.curSendChapterId = nil
	self.curSendEpisodeId = nil
	self.curSendEpisodePrePass = false
	self.curSendEpisodePass = false
	self.lastSendEpisodeId = nil
	self.curLookEpisodeId = nil
	self.unlockNewChapterId = nil
	self.chapterTriggerNewChapter = nil
	self._lastSelectEpisodeId = nil
	self.chapterBgTweening = false
	self._chapterStatus = nil
	self._cacheChapterOpenHardDungeon = {}
	self._isDungeonStoryView = false
	self._chapterTypeNums = nil
	self._lastSelectChapterType = 0
	self.jumpEpisodeId = nil
	self.versionActivityChapterType = nil
	self.dungeonInfoCount = 0
	self.dungeonInfoCacheList = {}
	self.canGetDramaReward = false
	self.initAllDungeonInfo = false
	self.advPlayJumpType = nil
end

function DungeonModel:setLastSendEpisodeId(id)
	self.lastSendEpisodeId = id
end

function DungeonModel:setChapterTypeNums(list)
	self._chapterTypeNums = {}

	for i, v in ipairs(list) do
		if not self._chapterTypeNums[v.chapterType] then
			local mo = UserChapterTypeNumMO.New()

			self._chapterTypeNums[v.chapterType]:init(v)

			self._chapterTypeNums[v.chapterType] = self._chapterTypeNums[v.chapterType]
		end
	end
end

function DungeonModel:getChapterTypeNum(type)
	local mo = self._chapterTypeNums[type]

	return (mo or nil) and (mo.todayPassNum or 0)
end

function DungeonModel:getEquipRemainingNum()
	return self:getChapterRemainingNum(DungeonEnum.ChapterType.Equip)
end

function DungeonModel:getChapterRemainingNum(type)
	local maxCount = DungeonConfig.instance:getDungeonEveryDayCount(type)
	local curCount = DungeonModel.instance:getChapterTypeNum(type)
	local num = maxCount - curCount

	return math.max(num, 0)
end

function DungeonModel:resetSendChapterEpisodeId()
	self.curSendEpisodeId = nil
end

function DungeonModel:SetSendChapterEpisodeId(chapterId, episodeId)
	self.curSendEpisodeId = episodeId
	self.lastSendEpisodeId = episodeId

	if chapterId then
		self.curSendChapterId = chapterId
	else
		local co = DungeonConfig.instance:getEpisodeCO(episodeId)

		if co then
			self.curSendChapterId = co.chapterId
		end
	end

	self.curLookChapterId = self.curSendChapterId

	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCO then
		local chapterCO = DungeonConfig.instance:getChapterCO(episodeCO.chapterId)
		local normalEpisodeCO

		if chapterCO then
			if chapterCO.type == DungeonEnum.ChapterType.Hard then
				normalEpisodeCO = DungeonConfig.instance:getEpisodeCO(episodeCO.preEpisode)
			elseif chapterCO.type == DungeonEnum.ChapterType.Simple then
				normalEpisodeCO = DungeonConfig.instance:getEpisodeCO(episodeCO.normalEpisodeId)
			end

			if normalEpisodeCO then
				self.curLookChapterId = normalEpisodeCO.chapterId
				self.curSendEpisodeId = normalEpisodeCO.id
			end
		end
	end

	if not self.curChapterType then
		local co = DungeonConfig.instance:getChapterCO(self.curLookChapterId)

		self.curChapterType = co and co.type
	end

	local dungeonInfo = self:getEpisodeInfo(episodeId)

	self.curSendEpisodePrePass = dungeonInfo and dungeonInfo.star > 0
end

function DungeonModel:initDungeonInfoList(dungeonInfoList)
	local recvLen = #dungeonInfoList
	local nowLen = #self.dungeonInfoCacheList

	for i = 1, recvLen do
		self.dungeonInfoCacheList[nowLen + i] = dungeonInfoList[i]
	end

	self.dungeonInfoCount = self.dungeonInfoCount - recvLen

	if self.dungeonInfoCount > 0 then
		return
	end

	dungeonInfoList = self.dungeonInfoCacheList
	self.dungeonInfoCacheList = {}
	self.dungeonInfoCount = 0

	table.sort(dungeonInfoList, function(v1, v2)
		return v1.chapterId < v2.chapterId
	end)

	for i, dungeonInfo in ipairs(dungeonInfoList) do
		self:updateDungeonInfo(dungeonInfo)
	end

	self.initAllDungeonInfo = true

	return true
end

function DungeonModel:updateDungeonInfo(dungeonInfo)
	local dungeonChapterDic = self._dungeonChapterDic

	if not dungeonChapterDic[dungeonInfo.chapterId] then
		if not dungeonChapterDic[dungeonInfo.chapterId][dungeonInfo.episodeId] then
			local mo = UserDungeonMO.New()

			mo:init(dungeonInfo)

			dungeonChapterDic[dungeonInfo.chapterId] = dungeonChapterDic[dungeonInfo.chapterId]
			dungeonChapterDic[dungeonInfo.chapterId][dungeonInfo.episodeId] = mo
			self._dungeonEpisodeDic[dungeonInfo.episodeId] = mo
		end
	end
end

function DungeonModel:resetEpisodeInfoByChapterId(chapterId)
	local list = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	for i, v in ipairs(list) do
		local info = self._dungeonEpisodeDic[v.id]

		if info then
			info.star = DungeonEnum.StarType.None
		end
	end
end

function DungeonModel:initModel()
	self:changeCategory(DungeonEnum.ChapterType.Normal)
end

function DungeonModel:changeCategory(chapterType, refreshModel)
	self.curChapterType = chapterType

	if refreshModel == false then
		return
	end

	DungeonChapterListModel.instance:setFbList()
end

function DungeonModel:getLastEpisodeConfigAndInfo()
	local chapterConfigList = DungeonConfig.instance:getChapterCOList()

	for i = #chapterConfigList, 1, -1 do
		local v = chapterConfigList[i]

		if self:chapterIsLock(v.id) == false and v.type == DungeonEnum.ChapterType.Normal then
			local episodeConfigList = DungeonConfig.instance:getChapterEpisodeCOList(v.id)

			if episodeConfigList then
				for j = #episodeConfigList, 1, -1 do
					local episodeConfig = episodeConfigList[j]
					local episodeInfo = self:getEpisodeInfo(episodeConfig.id)

					if episodeInfo then
						return episodeConfig, episodeInfo
					end
				end
			end
		end
	end
end

function DungeonModel:getLastEpisodeShowData()
	local chapterConfigList = DungeonConfig.instance:getChapterCOList()
	local prevEpisodeConfig

	for i = #chapterConfigList, 1, -1 do
		local v = chapterConfigList[i]

		if self:chapterIsLock(v.id) == false and v.type == DungeonEnum.ChapterType.Normal then
			local episodeConfigList = DungeonConfig.instance:getChapterEpisodeCOList(v.id)

			if episodeConfigList then
				for j = #episodeConfigList, 1, -1 do
					local episodeConfig = episodeConfigList[j]
					local episodeInfo = self:getEpisodeInfo(episodeConfig.id)

					if episodeInfo and self:isFinishElementList(episodeConfig) then
						if episodeConfig.type ~= DungeonEnum.EpisodeType.Sp then
							return episodeConfig, episodeInfo
						elseif prevEpisodeConfig and prevEpisodeConfig.type ~= DungeonEnum.EpisodeType.Sp and prevEpisodeConfig.preEpisode == episodeConfig.id then
							return episodeConfig, episodeInfo
						end
					end

					prevEpisodeConfig = episodeConfig
				end
			end
		end
	end
end

function DungeonModel:getEpisodeInfo(episodeId)
	local info = self._dungeonEpisodeDic[episodeId]

	if not info then
		local co = DungeonConfig.instance:getEpisodeCO(episodeId)

		if self:isUnlock(co) then
			info = UserDungeonMO.New()

			info:initFromManual(co.chapterId, co.id, 0, 0)

			self._dungeonEpisodeDic[episodeId] = info
		end
	end

	return info
end

function DungeonModel:getEpisodeChallengeCount(episodeId)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(config.chapterId)
	local limitType = -1
	local limitCount = -1

	if not string.nilorempty(chapterConfig.challengeCountLimit) then
		local params = string.split(chapterConfig.challengeCountLimit, "#")

		limitType = tonumber(params[1])
		limitCount = tonumber(params[2])
	end

	local info = self:getEpisodeInfo(episodeId)

	return limitType, limitCount, info.challengeCount
end

function DungeonModel:chapterIsLock(chapterId)
	local chapterOpen = true
	local toast, param
	local co = DungeonConfig.instance:getChapterCO(chapterId)

	if VersionValidator.instance:isInReviewing() then
		local allChapterIds = ResSplitConfig.instance:getAllChapterIds()

		if not allChapterIds[chapterId] then
			return true
		end
	end

	if not co then
		return true
	end

	if co.type == DungeonEnum.ChapterType.Gold then
		chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)
		toast, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GoldDungeon)
	elseif co.type == DungeonEnum.ChapterType.Exp then
		chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)
		toast, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ExperienceDungeon)
	elseif co.type == DungeonEnum.ChapterType.Buildings then
		chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)
		toast, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Buildings)
	elseif co.type == DungeonEnum.ChapterType.Equip then
		chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)
		toast, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.EquipDungeon)
	end

	if chapterId == DungeonEnum.ChapterId.HeroInvitation then
		chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HeroInvitation)
		toast, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HeroInvitation)
	end

	if not chapterOpen then
		return true, -4, toast
	end

	if self._dungeonChapterDic[chapterId] then
		local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

		if chapterConfig and chapterConfig.eaActivityId > 0 then
			if DungeonMainStoryModel.instance:isPreviewChapter(chapterId) then
				return false
			else
				return true, -1, 114
			end
		end

		return false
	end

	if DungeonMainStoryModel.instance:isPreviewChapter(chapterId) then
		return false
	end

	local preEpisodeFinish = false
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	if episodeList and #episodeList > 0 then
		for i, v in ipairs(episodeList) do
			if self:isUnlock(v) then
				preEpisodeFinish = true

				break
			end
		end
	elseif co.preChapter > 0 and not self:chapterIsLock(co.preChapter) then
		return false
	end

	if preEpisodeFinish == false then
		return true, -1, 114
	end

	if co.rewardPoint > 0 and co.preChapter > 0 then
		local value = DungeonMapModel.instance:getRewardPointValue(co.preChapter)

		if value < co.rewardPoint then
			return true, -3, 133, co.rewardPoint
		end
	end

	local playerinfo = PlayerModel.instance:getPlayinfo()
	local level = playerinfo.level

	if level < co.openLevel then
		return true, -2, 134, co.openLevel
	end

	return false
end

function DungeonModel:getCantChallengeToast(config)
	local isCanChallenge, challengeLockCode = self:isCanChallenge(config)

	if isCanChallenge then
		return nil
	end

	local episodeId

	if challengeLockCode == -1 then
		episodeId = config.preEpisode
	elseif challengeLockCode == -2 then
		episodeId = config.unlockEpisode
	end

	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if not chapterConfig then
		return
	end

	local chapterIndex = DungeonConfig.instance:getChapterIndex(chapterConfig.type, chapterConfig.id)
	local normalEpisodeConfig = episodeConfig
	local normalChapterConfig = chapterConfig

	if chapterConfig.type == DungeonEnum.ChapterType.Hard then
		normalEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
		normalChapterConfig = DungeonConfig.instance:getChapterCO(normalEpisodeConfig.chapterId)
	elseif chapterConfig.type == DungeonEnum.ChapterType.Simple then
		normalEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.normalEpisodeId)
		normalChapterConfig = DungeonConfig.instance:getChapterCO(normalEpisodeConfig.chapterId)
	end

	local episodeIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(normalChapterConfig.id, normalEpisodeConfig.id)
	local indexStr = ""

	indexStr = config.type == DungeonEnum.EpisodeType.Sp and string.format("SP-%s", episodeIndex) or string.format("%s-%s", GameUtil.getRomanNums(chapterIndex), episodeIndex)

	local preStr = ""

	if chapterConfig.type == DungeonEnum.ChapterType.Normal then
		preStr = luaLang("dungeon_lock_tips_normal")
	elseif chapterConfig.type == DungeonEnum.ChapterType.Hard then
		preStr = luaLang("dungeon_lock_tips_hard")
	elseif chapterConfig.type == DungeonEnum.ChapterType.Simple then
		preStr = luaLang("dungeon_simple_mode")
	end

	return string.format("%s%s", preStr, indexStr)
end

function DungeonModel:getChallengeUnlockText(config)
	local _, challengeLockCode = self:isCanChallenge(config)
	local episodeId

	if challengeLockCode == -1 then
		episodeId = config.preEpisode
	elseif challengeLockCode == -2 then
		episodeId = config.unlockEpisode
	end

	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if not chapterConfig then
		return
	end

	local chapterIndex = DungeonConfig.instance:getChapterIndex(chapterConfig.type, chapterConfig.id)
	local normalEpisodeConfig = episodeConfig
	local normalChapterConfig = chapterConfig

	if chapterConfig.type == DungeonEnum.ChapterType.Hard then
		normalEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
		normalChapterConfig = DungeonConfig.instance:getChapterCO(normalEpisodeConfig.chapterId)
	elseif chapterConfig.type == DungeonEnum.ChapterType.Simple then
		normalEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.normalEpisodeId)
		normalChapterConfig = DungeonConfig.instance:getChapterCO(normalEpisodeConfig.chapterId)
	end

	local episodeIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(normalChapterConfig.id, normalEpisodeConfig.id)
	local indexStr = ""

	indexStr = episodeConfig.type == DungeonEnum.EpisodeType.Sp and string.format("SP-%s", episodeIndex) or string.format("%s-%s", chapterIndex, episodeIndex)

	local preStr = ""

	if chapterConfig.type == DungeonEnum.ChapterType.Normal then
		preStr = luaLang("dungeon_story_mode")
	elseif chapterConfig.type == DungeonEnum.ChapterType.Hard then
		preStr = luaLang("dungeon_hard_mode")
	elseif chapterConfig.type == DungeonEnum.ChapterType.Simple then
		preStr = luaLang("dungeon_simple_mode")
	end

	return string.format("%s%s", preStr, indexStr)
end

function DungeonModel:isCanChallenge(co)
	if not self:isUnlock(co) then
		return false, -1
	end

	if co.unlockEpisode == 0 then
		return true
	end

	local unlockInfo = self._dungeonEpisodeDic[co.unlockEpisode]

	if unlockInfo and unlockInfo.star > 0 then
		return true
	end

	return false, -2
end

function DungeonModel:startCheckUnlockChapter()
	if self._chapterStatus then
		return
	end

	self._chapterStatus = {}
	self._otherChapterUnlock = {}

	local list = DungeonConfig.instance:getNormalChapterList()

	for i, v in ipairs(list) do
		self._chapterStatus[i] = self:chapterIsLock(v.id) == true
	end
end

function DungeonModel:endCheckUnlockChapter()
	if not self._chapterStatus then
		return
	end

	local list = DungeonConfig.instance:getNormalChapterList()

	for i, v in ipairs(self._chapterStatus) do
		local k = list[i].id

		if v and v ~= self:chapterIsLock(k) then
			self._chapterStatus[i] = false

			DungeonController.instance:dispatchEvent(DungeonEvent.OnCheckChapterUnlock)

			self.unlockNewChapterId = k
			self.chapterTriggerNewChapter = true

			local chpaterCo = DungeonConfig.instance:getChapterCO(k)

			if chpaterCo and chpaterCo.rewardPoint > 0 then
				GameFacade.showToast(ToastEnum.UnlockChapter)
			end

			break
		end
	end

	for i, v in ipairs(self._chapterStatus) do
		local k = list[i].id

		if v and v ~= self:chapterIsLock(k) then
			self._chapterStatus[i] = false
			self._otherChapterUnlock[k] = true
		end
	end
end

function DungeonModel:needUnlockChapterAnim(id)
	return self._otherChapterUnlock and self._otherChapterUnlock[id]
end

function DungeonModel:clearUnlockChapterAnim(id)
	if not self._otherChapterUnlock then
		return
	end

	self._otherChapterUnlock[id] = nil
end

function DungeonModel:clearUnlockNewChapterId(id)
	if id == self.unlockNewChapterId then
		self.chapterTriggerNewChapter = nil
		self.unlockNewChapterId = nil
	end
end

function DungeonModel:isFinishElementList(co)
	if not co then
		return false
	end

	if string.nilorempty(co.elementList) then
		return true
	end

	local list = string.splitToNumber(co.elementList, "#")

	for i, id in ipairs(list) do
		local element = DungeonMapModel.instance:getElementById(id)

		if element then
			return false
		end
	end

	return true
end

function DungeonModel:isUnlock(co)
	if not co then
		return false
	end

	if co.preEpisode2 == 0 then
		return true
	end

	if DungeonMainStoryModel.isUnlockInPreviewChapter(co.id) then
		return true
	end

	local elementId = DungeonConfig.instance:getEpisodeUnlockImplicitElement(co.id)

	if elementId and not DungeonMapModel.instance:elementIsFinished(elementId) then
		return false
	end

	local preInfo = self._dungeonEpisodeDic[co.preEpisode]

	if preInfo and preInfo.star > 0 then
		local preCo = DungeonConfig.instance:getEpisodeCO(co.preEpisode)

		if preCo.afterStory > 0 then
			if StoryModel.instance:isStoryFinished(preCo.afterStory) then
				return true
			end
		else
			return true
		end
	end

	local preSimpleInfo = self._dungeonEpisodeDic[co.preEpisode2]

	if preSimpleInfo and preSimpleInfo.star > 0 then
		local preSimpleCo = DungeonConfig.instance:getEpisodeCO(co.preEpisode2)

		if preSimpleCo.afterStory > 0 then
			if StoryModel.instance:isStoryFinished(preSimpleCo.afterStory) then
				return true
			end
		else
			return true
		end
	end

	return false
end

local BattleEpisodeTypes = {
	[DungeonEnum.EpisodeType.Sp] = true,
	[DungeonEnum.EpisodeType.Equip] = true,
	[DungeonEnum.EpisodeType.SpecialEquip] = true,
	[DungeonEnum.EpisodeType.WeekWalk] = true,
	[DungeonEnum.EpisodeType.WeekWalk_2] = true,
	[DungeonEnum.EpisodeType.Season] = true,
	[DungeonEnum.EpisodeType.SeasonRetail] = true,
	[DungeonEnum.EpisodeType.SeasonSpecial] = true,
	[DungeonEnum.EpisodeType.SeasonTrial] = true,
	[DungeonEnum.EpisodeType.Explore] = true,
	[DungeonEnum.EpisodeType.Meilanni] = true,
	[DungeonEnum.EpisodeType.Dog] = true,
	[DungeonEnum.EpisodeType.Jiexika] = true,
	[DungeonEnum.EpisodeType.YaXian] = true,
	[DungeonEnum.EpisodeType.Daily1_2] = true,
	[DungeonEnum.EpisodeType.DreamTailNormal] = true,
	[DungeonEnum.EpisodeType.DreamTailHard] = true,
	[DungeonEnum.EpisodeType.Act1_2Daily] = true,
	[DungeonEnum.EpisodeType.Act1_3Dungeon] = true,
	[DungeonEnum.EpisodeType.Act1_3Daily] = true,
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Operation] = true,
	[DungeonEnum.EpisodeType.BossRush] = true,
	[DungeonEnum.EpisodeType.Act1_4Role6] = true,
	[DungeonEnum.EpisodeType.RoleStoryChallenge] = true,
	[DungeonEnum.EpisodeType.Act1_5Dungeon] = true,
	[DungeonEnum.EpisodeType.Cachot] = true,
	[DungeonEnum.EpisodeType.RoleTryFight] = true,
	[DungeonEnum.EpisodeType.Act1_6Dungeon] = true,
	[DungeonEnum.EpisodeType.Act1_6DungeonBoss] = true,
	[DungeonEnum.EpisodeType.Season123] = true,
	[DungeonEnum.EpisodeType.Season123Retail] = true,
	[DungeonEnum.EpisodeType.Act1_8Dungeon] = true,
	[DungeonEnum.EpisodeType.ToughBattle] = true,
	[DungeonEnum.EpisodeType.ToughBattleStory] = true,
	[DungeonEnum.EpisodeType.Rouge] = true,
	[DungeonEnum.EpisodeType.Rouge2] = true,
	[DungeonEnum.EpisodeType.Rouge2Boss] = true,
	[DungeonEnum.EpisodeType.TrialHero] = true,
	[DungeonEnum.EpisodeType.Season166Base] = true,
	[DungeonEnum.EpisodeType.Season166Train] = true,
	[DungeonEnum.EpisodeType.Season166Teach] = true,
	[DungeonEnum.EpisodeType.TowerPermanent] = true,
	[DungeonEnum.EpisodeType.TowerBoss] = true,
	[DungeonEnum.EpisodeType.TowerLimited] = true,
	[DungeonEnum.EpisodeType.TowerBossTeach] = true,
	[DungeonEnum.EpisodeType.TowerDeep] = true,
	[DungeonEnum.EpisodeType.TowerCompose] = true,
	[DungeonEnum.EpisodeType.Act183] = true,
	[DungeonEnum.EpisodeType.Act191] = true,
	[DungeonEnum.EpisodeType.Odyssey] = true,
	[DungeonEnum.EpisodeType.Assassin2Outside] = true,
	[DungeonEnum.EpisodeType.Survival] = true,
	[DungeonEnum.EpisodeType.Shelter] = true,
	[DungeonEnum.EpisodeType.V2_8Boss] = true,
	[DungeonEnum.EpisodeType.V2_8BossAct] = true,
	[DungeonEnum.EpisodeType.V3_2SP] = true,
	[DungeonEnum.EpisodeType.GameJumpFight] = true,
	[DungeonEnum.EpisodeType.V3_2ZongMao] = true,
	[DungeonEnum.EpisodeType.Abyss] = true,
	[DungeonEnum.EpisodeType.Sodache] = true,
	[DungeonEnum.EpisodeType.AtomicDungeon] = true,
	[DungeonEnum.EpisodeType.SystemFightManual] = true,
	[DungeonEnum.EpisodeType.BossRushActMode] = true
}

function DungeonModel.isBattleEpisode(config)
	return config.type <= DungeonEnum.EpisodeType.Boss or BattleEpisodeTypes[config.type]
end

function DungeonModel:getEpisodeBonus(episodeId, isOnlyNew)
	local isReactivity = self:isReactivityEpisode(episodeId)
	local isPermanent = self:isPermanentEpisode(episodeId)
	local keyName = isPermanent and "permanentBonus" or isReactivity and "retroBonus" or "bonus"

	if isOnlyNew and not DungeonConfig.instance:isNewReward(episodeId, keyName) then
		return {}
	end

	return self:_getEpisodeBonusByType(episodeId, keyName)
end

function DungeonModel:getEpisodeFreeBonus(episodeId)
	return self:_getEpisodeBonusByType(episodeId, "freeBonus")
end

function DungeonModel:_getEpisodeBonusByType(episodeId, type)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)
	local bonusConfig = DungeonConfig.instance:getBonusCO(config[type])
	local result = {}

	if bonusConfig then
		local list = bonusConfig.fixBonus

		if not string.nilorempty(list) then
			local typeList = string.split(list, "|")

			for i, v in ipairs(typeList) do
				local valueList = string.split(v, "#")

				table.insert(result, valueList)
			end
		end
	end

	local newRewards = DungeonConfig.instance:getRewardItems(config[type])

	if newRewards then
		for _, reward in ipairs(newRewards) do
			table.insert(result, reward)
		end
	end

	return result
end

function DungeonModel:getEpisodeReward(episodeId)
	local isReactivity = self:isReactivityEpisode(episodeId)
	local isPermanent = self:isPermanentEpisode(episodeId)
	local keyName = isPermanent and "permanentReward" or isReactivity and "retroReward" or "reward"
	local result = self:_getEpisodeBonusByType(episodeId, keyName)

	for _, v in pairs(result) do
		v.starType = DungeonEnum.StarType.Normal
	end

	return result
end

function DungeonModel:getEpisodeFirstBonus(episodeId)
	local isReactivity = self:isReactivityEpisode(episodeId)
	local isPermanent = self:isPermanentEpisode(episodeId)
	local keyName = isPermanent and "permanentFirstBonus" or isReactivity and "retroFirstBonus" or "firstBonus"
	local result = self:_getEpisodeBonusByType(episodeId, keyName)

	for _, v in pairs(result) do
		v.starType = DungeonEnum.StarType.Normal
	end

	return result
end

function DungeonModel:getEpisodeAdvancedBonus(episodeId)
	local isReactivity = self:isReactivityEpisode(episodeId)
	local isPermanent = self:isPermanentEpisode(episodeId)
	local keyName = isPermanent and "permanentAdvancedBonus" or isReactivity and "retroAdvancedBonus" or "advancedBonus"
	local result = self:_getEpisodeBonusByType(episodeId, keyName)

	for _, v in pairs(result) do
		v.starType = DungeonEnum.StarType.Advanced
	end

	return result
end

function DungeonModel:isReactivityEpisode(episodeId)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not config then
		return false
	end

	local chapterId = config.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterCo then
		return false
	end

	local actId = chapterCo.actId

	return ReactivityModel.instance:isReactivity(actId)
end

function DungeonModel:isPermanentEpisode(episodeId)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterCo = DungeonConfig.instance:getChapterCO(config.chapterId)
	local actId = chapterCo.actId

	if actId == 0 then
		return false
	end

	local actCo = ActivityConfig.instance:getActivityCo(actId)

	return actCo.isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function DungeonModel:getEpisodeRewardDisplayList(episodeId)
	local isReactivity = self:isReactivityEpisode(episodeId)
	local isPermanent = self:isPermanentEpisode(episodeId)
	local keyName = isPermanent and "permanentRewardDisplayList" or isReactivity and "retroRewardDisplayList" or "rewardDisplayList"

	return self:_getEpisodeDisplayList(episodeId, keyName)
end

function DungeonModel:getEpisodeRewardList(episodeId)
	local isReactivity = self:isReactivityEpisode(episodeId)
	local isPermanent = self:isPermanentEpisode(episodeId)
	local keyName = isPermanent and "permanentRewardList" or isReactivity and "retroRewardList" or "rewardList"

	return self:_getEpisodeDisplayList(episodeId, keyName)
end

function DungeonModel:getEpisodeFreeDisplayList(episodeId)
	return self:_getEpisodeDisplayList(episodeId, "freeDisplayList")
end

function DungeonModel:_getEpisodeDisplayList(episodeId, name)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)
	local result = {}
	local list = config[name]

	if string.nilorempty(list) then
		return result
	end

	local typeList = string.split(list, "|")

	for i, v in ipairs(typeList) do
		local valueList = string.split(v, "#")

		table.insert(result, valueList)
	end

	return result
end

function DungeonModel:getMonsterDisplayList(monsterDisplayList)
	local list = {}

	for _, monsterID in ipairs(string.splitToNumber(monsterDisplayList, "#")) do
		table.insert(list, lua_monster.configDict[monsterID])
	end

	return list
end

function DungeonModel:chapterListIsNormalType(type)
	local curChapterType = type or self.curChapterType

	return DungeonEnum.ChapterType.Normal == curChapterType
end

function DungeonModel:chapterListIsResType(type)
	local curChapterType = type or self.curChapterType

	return curChapterType >= DungeonEnum.ChapterType.Gold and curChapterType <= DungeonEnum.ChapterType.Equip or DungeonEnum.ChapterType.SpecialEquip == curChapterType or DungeonEnum.ChapterType.Buildings == curChapterType
end

function DungeonModel:chapterListIsBreakType(type)
	local curChapterType = type or self.curChapterType

	return DungeonEnum.ChapterType.Break == curChapterType
end

function DungeonModel:chapterListIsWeekWalkType(type)
	local curChapterType = type or self.curChapterType

	return curChapterType == DungeonEnum.ChapterType.WeekWalk or curChapterType == DungeonEnum.ChapterType.WeekWalk_2
end

function DungeonModel:chapterListIsSeasonType(type)
	local curChapterType = type or self.curChapterType

	return curChapterType == DungeonEnum.ChapterType.Season
end

function DungeonModel:chapterListIsExploreType(type)
	local curChapterType = type or self.curChapterType

	return curChapterType == DungeonEnum.ChapterType.Explore
end

function DungeonModel:chapterListIsRoleStory(type)
	local curChapterType = type or self.curChapterType

	return curChapterType == DungeonEnum.ChapterType.RoleStory
end

function DungeonModel:chapterListIsPermanent(type)
	local curChapterType = type or self.curChapterType

	return curChapterType == DungeonEnum.ChapterType.PermanentActivity
end

function DungeonModel:chapterListIsAdvPlay(type)
	local curChapterType = type or self.curChapterType

	return curChapterType == DungeonEnum.ChapterType.AdvPlay
end

function DungeonModel:chapterListIsTower(type)
	local curChapterType = type or self.curChapterType
	local result = curChapterType == DungeonEnum.ChapterType.TowerPermanent

	result = result or curChapterType == DungeonEnum.ChapterType.TowerBoss
	result = result or curChapterType == DungeonEnum.ChapterType.TowerLimited

	return result
end

function DungeonModel:chapterListIsRouge(type)
	local curChapterType = type or self.curChapterType
	local result = curChapterType == DungeonEnum.ChapterType.Rouge

	result = result or curChapterType == DungeonEnum.ChapterType.Rouge2
	result = result or curChapterType == DungeonEnum.ChapterType.Rouge2Boss

	return result
end

function DungeonModel:getChapterListTypes(type)
	return self:chapterListIsNormalType(type), self:chapterListIsResType(type), self:chapterListIsBreakType(type), self:chapterListIsWeekWalkType(type), self:chapterListIsSeasonType(type), self:chapterListIsExploreType(type)
end

function DungeonModel:getChapterListOpenTimeValid(type)
	local resultList = {}
	local isNormalType, isResourceType, isBreakType, isWeekWalkType, isSeasonType, isExploreType = self:getChapterListTypes(type)

	if isNormalType then
		resultList = DungeonConfig.instance:getChapterCOListByType(type)
	elseif isResourceType then
		local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold)

		tabletool.addValues(resultList, list)

		list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp)

		tabletool.addValues(resultList, list)

		list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip)

		tabletool.addValues(resultList, list)
	elseif isBreakType then
		resultList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
	elseif isWeekWalkType then
		resultList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.WeekWalk)
	elseif isExploreType then
		resultList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Explore)
	end

	for i, chapterCO in ipairs(resultList) do
		if self:getChapterOpenTimeValid(chapterCO) then
			return true
		end
	end

	return false
end

function DungeonModel:getChapterOpenTimeValid(chapterCo)
	if LuaUtil.isEmptyStr(chapterCo.openDay) then
		return true
	end

	local serverDay = ServerTime.weekDayInServerLocal()
	local dayList = GameUtil.splitString2(chapterCo.openDay, true, "|", "#")

	for _, data in ipairs(dayList) do
		for i, v in ipairs(data) do
			local day = tonumber(v)

			if day == serverDay then
				return true
			end
		end
	end

	return false
end

function DungeonModel:isOpenHardDungeon(chapterId, normalEpisodeId)
	local open = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon)

	if not open then
		return false
	end

	if normalEpisodeId then
		local episodeInfo = self:getEpisodeInfo(normalEpisodeId)

		if not episodeInfo or episodeInfo.star < DungeonEnum.StarType.Advanced then
			return false
		end
	end

	return true
end

function DungeonModel:chapterIsPass(chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	if episodeList then
		for i, v in ipairs(episodeList) do
			if not self:hasPassLevelAndStory(v.id) then
				return false
			end
		end
	end

	return true
end

function DungeonModel:chapterLastEpisodeIsFinished(chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	if episodeList then
		local lastConfig = episodeList[#episodeList]

		if lastConfig and self:hasPassLevelAndStory(lastConfig.id) then
			return true
		end
	end

	return false
end

function DungeonModel:hasPassLevel(episodeId)
	local episodeInfo = self:getEpisodeInfo(episodeId)

	return episodeInfo and episodeInfo.star > DungeonEnum.StarType.None
end

function DungeonModel:onlyCheckPassLevel(episodeId)
	local episodeInfo = self._dungeonEpisodeDic[episodeId]

	return episodeInfo and episodeInfo.star > DungeonEnum.StarType.None
end

function DungeonModel:hasPassLevelAndStory(episodeId)
	if not self:hasPassLevel(episodeId) then
		return false
	end

	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCO.afterStory > 0 and not StoryModel.instance:isStoryFinished(episodeCO.afterStory) then
		return false
	end

	if not DungeonMapModel.instance:checkStoryElementFinished(episodeCO.beforeStory) or not DungeonMapModel.instance:checkStoryElementFinished(episodeCO.afterStory) then
		return false
	end

	return true
end

function DungeonModel:getUnlockContentList(id)
	local list = {}
	local openList = OpenConfig.instance:getOpenShowInEpisode(id)

	if openList then
		for i, v in ipairs(openList) do
			local openCo = lua_open.configDict[v]
			local actId = openCo.bindActivityId

			if actId ~= 0 then
				local status = ActivityHelper.getActivityStatus(actId)

				if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
					local content = self:getUnlockContent(DungeonEnum.UnlockContentType.Open, v)

					if content then
						table.insert(list, content)
					end
				end
			else
				local content = self:getUnlockContent(DungeonEnum.UnlockContentType.Open, v)

				if content then
					table.insert(list, content)
				end
			end
		end
	end

	local unlockEpisodeList = DungeonConfig.instance:getUnlockEpisodeList(id)

	if unlockEpisodeList then
		for i, v in ipairs(unlockEpisodeList) do
			local content = self:getUnlockContent(DungeonEnum.UnlockContentType.Episode, v)

			if content then
				table.insert(list, content)
			end
		end
	end

	local openGroupList = OpenConfig.instance:getOpenGroupShowInEpisode(id)

	if openGroupList then
		for i, v in ipairs(openGroupList) do
			local content = self:getUnlockContent(DungeonEnum.UnlockContentType.OpenGroup, v)

			if content then
				table.insert(list, content)
			end
		end
	end

	return list
end

function DungeonModel:getUnlockContent(type, value)
	if type == DungeonEnum.UnlockContentType.Open then
		return string.format(luaLang("dungeon_unlock_content_1"), lua_open.configDict[value].name)
	elseif type == DungeonEnum.UnlockContentType.Episode then
		local episodeCfg = DungeonConfig.instance:getEpisodeCO(value)

		return string.format(luaLang("dungeon_unlock_content_2"), string.format("%s %s", DungeonController.getEpisodeName(episodeCfg), episodeCfg.name))
	elseif type == DungeonEnum.UnlockContentType.OpenGroup then
		return string.format(luaLang("dungeon_unlock_content_3"), value)
	elseif type == DungeonEnum.UnlockContentType.ActivityOpen then
		return string.format(luaLang("dungeon_unlock_content_4"), lua_open.configDict[value].name)
	end
end

function DungeonModel:setDungeonStoryviewState(isStoryview)
	self._isDungeonStoryView = isStoryview
end

function DungeonModel:getDungeonStoryState()
	return self._isDungeonStoryView
end

function DungeonModel:setLastSelectMode(chapterType, episodeId)
	self._lastSelectEpisodeId = episodeId
	self._lastSelectChapterType = chapterType
end

function DungeonModel:getLastSelectMode()
	return self._lastSelectChapterType, self._lastSelectEpisodeId
end

function DungeonModel:hasPassAllChapterEpisode(chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	for _, episodeCo in ipairs(episodeList) do
		if not self:hasPassLevelAndStory(episodeCo.id) then
			return false
		end
	end

	return true
end

function DungeonModel:chapterIsUnLock(chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	if episodeList and #episodeList > 0 then
		return self:hasPassLevelAndStory(episodeList[1].preEpisode), episodeList[1].preEpisode
	end

	return false, nil
end

function DungeonModel:episodeIsInLockTime(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo or string.nilorempty(episodeCo.lockTime) then
		return false
	end

	local nowTime = ServerTime.now() * 1000
	local timeParam = string.splitToNumber(episodeCo.lockTime, "#")

	if timeParam[1] and timeParam[2] then
		return nowTime > timeParam[1] and nowTime < timeParam[2]
	end

	return false
end

function DungeonModel:getMapElementReward(elementId)
	local config = lua_chapter_map_element.configDict[elementId]

	if not config then
		return
	end

	local mapConfig = lua_chapter_map.configDict[config.mapId]
	local chapterId = mapConfig.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local isReactivity = chapterCo and ReactivityModel.instance:isReactivity(chapterCo.actId) or false

	if chapterCo.actId ~= 0 and ActivityConfig.instance:isPermanent(chapterCo.actId) then
		return config.permanentReward
	else
		return (isReactivity or nil) and (config.retroReward or config.reward)
	end
end

function DungeonModel:isSpecialMainPlot(chapterId)
	return DungeonEnum.SpecialMainPlot[chapterId] ~= nil
end

function DungeonModel:getChapterRedId(chapterId)
	if chapterId == DungeonEnum.ChapterId.HeroInvitation then
		return RedDotEnum.DotNode.HeroInvitationReward
	end
end

function DungeonModel:setCanGetDramaReward(canget)
	self.canGetDramaReward = canget
end

function DungeonModel:isCanGetDramaReward()
	return self.canGetDramaReward
end

function DungeonModel:getLastFightEpisodePassMode(episodeConfig)
	local preEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
	local sameChapter = episodeConfig.chapterId == preEpisodeConfig.chapterId

	while preEpisodeConfig.type == DungeonEnum.EpisodeType.Story and sameChapter do
		preEpisodeConfig = DungeonConfig.instance:getEpisodeCO(preEpisodeConfig.preEpisode)
		sameChapter = episodeConfig.chapterId == preEpisodeConfig.chapterId
	end

	if sameChapter then
		local passNormal = self:hasPassLevel(preEpisodeConfig.id)

		if not passNormal then
			return DungeonEnum.ChapterType.Simple
		end
	end

	return DungeonEnum.ChapterType.Normal
end

function DungeonModel:setAdvPlayJumpType(type)
	self.advPlayJumpType = type
end

DungeonModel.instance = DungeonModel.New()

return DungeonModel
