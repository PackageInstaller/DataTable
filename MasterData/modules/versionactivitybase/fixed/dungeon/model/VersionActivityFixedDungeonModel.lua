-- chunkname: @modules/versionactivitybase/fixed/dungeon/model/VersionActivityFixedDungeonModel.lua

module("modules.versionactivitybase.fixed.dungeon.model.VersionActivityFixedDungeonModel", package.seeall)

local VersionActivityFixedDungeonModel = class("VersionActivityFixedDungeonModel", BaseModel)

function VersionActivityFixedDungeonModel:onInit()
	return
end

function VersionActivityFixedDungeonModel:reInit()
	self:init()
end

function VersionActivityFixedDungeonModel:init()
	self:setLastEpisodeId()
	self:setShowInteractView()
end

function VersionActivityFixedDungeonModel:setLastEpisodeId(episodeId)
	self.lastEpisodeId = episodeId
end

function VersionActivityFixedDungeonModel:getLastEpisodeId()
	return self.lastEpisodeId
end

function VersionActivityFixedDungeonModel:setShowInteractView(isShow)
	self.isShowInteractView = isShow
end

function VersionActivityFixedDungeonModel:checkIsShowInteractView()
	return self.isShowInteractView
end

function VersionActivityFixedDungeonModel:setIsNotShowNewElement(isNotShow)
	self.notShowNewElement = isNotShow
end

function VersionActivityFixedDungeonModel:isNotShowNewElement()
	return self.notShowNewElement
end

function VersionActivityFixedDungeonModel:setMapNeedTweenState(needState)
	self.isMapNeedTween = needState
end

function VersionActivityFixedDungeonModel:getMapNeedTweenState()
	return self.isMapNeedTween
end

function VersionActivityFixedDungeonModel:getElementCoList(mapId)
	local normalElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = elementCo and lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion).DungeonChapterId.Story and mapId == elementCo.mapId then
			table.insert(normalElementCoList, elementCo)
		end
	end

	return normalElementCoList
end

function VersionActivityFixedDungeonModel:getElementCoListWithFinish(mapId, episodeId)
	local finishElementCoList = {}
	local mapAllElementList = self:getAllNormalElementCoList(mapId, episodeId)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	for _, elementCo in pairs(mapAllElementList) do
		local elementId = elementCo.id
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion).DungeonChapterId.Story then
			local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)

			if mapId == elementCo.mapId and isFinish then
				table.insert(finishElementCoList, elementCo)
			end
		end
	end

	return finishElementCoList, mapAllElementList
end

function VersionActivityFixedDungeonModel:getAllNormalElementCoList(mapId, episodeId)
	local elements = {}
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

	if mapAllElementList then
		for _, elementCo in pairs(mapAllElementList) do
			if self:isElementInEpisode(elementCo, episodeId) then
				table.insert(elements, elementCo)
			end
		end
	end

	return elements
end

function VersionActivityFixedDungeonModel:isElementInEpisode(elementCo, episodeId)
	if episodeId == nil then
		return true
	end

	local elementEpisodeId = string.gsub(elementCo.condition, "EpisodeFinish=", "")

	elementEpisodeId = tonumber(elementEpisodeId)

	return elementEpisodeId == episodeId
end

function VersionActivityFixedDungeonModel:setDungeonBaseMo(dungeonMo)
	self.actDungeonBaseMo = dungeonMo
end

function VersionActivityFixedDungeonModel:getDungeonBaseMo()
	return self.actDungeonBaseMo
end

function VersionActivityFixedDungeonModel:getInitEpisodeId()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(dungeonEnum.DungeonChapterId.Story)
	local minUnlockEpisodeId = 0
	local maxBattleEpisodeId = 0

	for _, epCo in ipairs(episodeList) do
		local isUnlock = DungeonModel.instance:isUnlock(epCo)
		local isBattleEpisode = DungeonModel.instance.isBattleEpisode(epCo)

		if isBattleEpisode then
			maxBattleEpisodeId = maxBattleEpisodeId > epCo.id and maxBattleEpisodeId or epCo.id
		end

		if isUnlock and minUnlockEpisodeId < epCo.id then
			minUnlockEpisodeId = epCo.id
		end
	end

	local isChapterPass = DungeonModel.instance:chapterIsPass(dungeonEnum.DungeonChapterId.Story)

	if isChapterPass then
		minUnlockEpisodeId = maxBattleEpisodeId
	end

	return minUnlockEpisodeId
end

local HAVE_PLAYED = 1
local NOT_PLAYED = 0

function VersionActivityFixedDungeonModel:isNeedPlayHardModeUnlockAnimation(dungeonActId)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)

	if not dungeonEnum or not dungeonEnum.PlayerPrefsKey then
		return
	end

	local prefsKey = dungeonEnum.PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(bigVersion, smallVersion)
	local value = dungeonController.instance:getPlayerPrefs(prefsKey, NOT_PLAYED)

	if value ~= HAVE_PLAYED then
		local dungeonActId = dungeonActId or VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion).ActivityId.Dungeon

		return (VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(dungeonActId))
	end
end

function VersionActivityFixedDungeonModel:savePlayerPrefsPlayHardModeUnlockAnimation()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)

	if not dungeonEnum or not dungeonEnum.PlayerPrefsKey then
		return
	end

	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(bigVersion, smallVersion)
	local prefsKey = dungeonEnum.PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim

	dungeonController.instance:savePlayerPrefs(prefsKey, HAVE_PLAYED)
end

function VersionActivityFixedDungeonModel:isTipHardModeUnlockOpen(dungeonActId)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local _dungeonActId = VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion).ActivityId.Dungeon

	if dungeonActId ~= _dungeonActId then
		return
	end

	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)

	if not dungeonEnum or not dungeonEnum.PlayerPrefsKey then
		return
	end

	local prefsKey = dungeonEnum.PlayerPrefsKey.OpenHardModeUnlockTip
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(bigVersion, smallVersion)
	local value = dungeonController.instance:getPlayerPrefs(prefsKey, NOT_PLAYED)

	if value ~= HAVE_PLAYED then
		return (VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(dungeonActId))
	end
end

function VersionActivityFixedDungeonModel:setTipHardModeUnlockOpen()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)

	if not dungeonEnum or not dungeonEnum.PlayerPrefsKey then
		return
	end

	local prefsKey = dungeonEnum.PlayerPrefsKey.OpenHardModeUnlockTip

	VersionActivityFixedHelper.getVersionActivityDungeonController(bigVersion, smallVersion).instance:savePlayerPrefs(prefsKey, HAVE_PLAYED)
	self:refreshVersionActivityEnterRedDot()
end

function VersionActivityFixedDungeonModel:refreshVersionActivityEnterRedDot()
	local refreshlist = {
		[RedDotEnum.DotNode.VersionActivityEnterRedDot] = true
	}

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
end

function VersionActivityFixedDungeonModel:getHardModeCurrenyNum(chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)
	local rewardNum = 0
	local totalNum = 0

	for _, co in ipairs(episodeList) do
		local episodeInfo = DungeonModel.instance:getEpisodeInfo(co.id)
		local rewards = DungeonModel.instance:getEpisodeFirstBonus(co.id)

		if rewards then
			for _, reward in ipairs(rewards) do
				if tonumber(reward[1]) == MaterialEnum.MaterialType.Currency and tonumber(reward[2]) == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
					if episodeInfo and episodeInfo.star ~= DungeonEnum.StarType.None then
						rewardNum = rewardNum + tonumber(reward[3])
					end

					totalNum = totalNum + tonumber(reward[3])
				end
			end
		end
	end

	return rewardNum, totalNum
end

VersionActivityFixedDungeonModel.instance = VersionActivityFixedDungeonModel.New()

return VersionActivityFixedDungeonModel
