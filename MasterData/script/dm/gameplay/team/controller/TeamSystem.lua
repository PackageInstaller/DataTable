-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/team/controller/TeamSystem.lua

require("dm.gameplay.stage.model.CommonStage")
require("dm.gameplay.stage.model.EliteStage")
require("dm.gameplay.stage.model.HeroStory")
require("dm.gameplay.stage.model.StageManager")
require("dm.gameplay.stage.model.KeySkillManager")

TeamSystem = class("TeamSystem", Facade, _M)

TeamSystem:has("_stageService", {
	is = "r"
}):injectWith("StageService")
TeamSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TeamSystem:has("_sortType", {
	is = "rw"
})
TeamSystem:has("_sortOrder", {
	is = "rw"
})
TeamSystem:has("_cardSortType", {
	is = "rw"
})
TeamSystem:has("_cardSortOrder", {
	is = "rw"
})
TeamSystem:has("_towerCardSortType", {
	is = "rw"
})
TeamSystem:has("_towerCardSortOrder", {
	is = "rw"
})
TeamSystem:has("_stagePresents", {
	is = "rw"
})
TeamSystem:has("_heroCardSortType", {
	is = "rw"
})
TeamSystem:has("_heroCardSortOrder", {
	is = "rw"
})
TeamSystem:has("_hasRequest", {
	is = "rw"
})
TeamSystem:has("_activityHeroStoryId", {
	is = "rw"
})
TeamSystem:has("_contentData", {
	is = "rw"
})
TeamSystem:has("_enterPoint", {
	is = "rw"
})
TeamSystem:has("_battleTeam", {
	is = "rw"
})
TeamSystem:has("_isPlayNewUnlockChapter", {
	is = "rw"
})

StageRewardType = {
	kStarBox = 2,
	kBoxPoint = 1
}
StageTypeStr = {
	kElite = 1,
	kNormal = 0
}
kStageTypeMap = {
	StoryPoint = 0,
	PracticePoint = 2,
	point = 1
}
StagePointType = {
	kHidden = "HIDDEN",
	kBoss = "BOSS",
	kNormal = "NORMAL"
}
SortType = {
	cost = 1,
	quality = 4,
	combat = 6,
	rareity = 2,
	star = 3,
	level = 5
}

local TEAM_SORTTYPE = "TEAM_SORTTYPE"
local TEAM_SORTORDER = "TEAM_SORTORDER"
local TEAM_CARD_SORTTYPE = "TEAM_CARD_SORTTYPE"
local TEAM_CARD_SORTORDER = "TEAM_CARD_SORTORDER"
local TEAM_HERO_CARD_SORTTYPE = "TEAM_HERO_CARD_SORTTYPE"
local TEAM_HERO_CARD_SORTORDER = "TEAM_HERO_CARD_SORTORDER"
local TEAM_TOWER_CARD_SORTTYPE = "TEAM_TOWER_CARD_SORTTYPE"
local TEAM_TOWER_CARD_SORTORDER = "TEAM_TOWER_CARD_SORTORDER"
local SortExtend = {}

kGuideComplexityList = {
	novice = 10,
	veteran = 5,
	none = 999
}

function TeamSystem:initialize()
	super.initialize(self)

	self._stageManager = StageManager:new()
	self._keySkillManager = KeySkillManager:new()

	self:initExtendParam()
	self:initSortType()
	self:initSortOrder()
	self:initCardSortType()
	self:initCardSortOrder()
	self:initHeroCardSortType()
	self:initHeroCardSortOrder()
	self:initTowerCardSortType()
	self:initTowerCardSortOrder()

	self._sortExtand = {}
	self._stagePresents = {}
	self._hasRequest = false
	self._commonStage = self._stageManager:getStage(StageType.kNormal)
	self._eliteStage = self._stageManager:getStage(StageType.kElite)
	self._isPlayNewUnlockChapter = false
end

function TeamSystem:userInject(injector)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROES_SYNC_SUCC, self, self.syncKeySkillCache)

	self._towerSystem = self:getInjector():getInstance(TowerSystem)
end

function TeamSystem:checkEnabled(data)
	if data.stageType == StageType.kElite then
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local unlock, tips = systemKeeper:isUnlock("Elite_Block")

		if not unlock then
			return unlock, tips
		end
	end

	if data.chapterId == nil then
		return true
	end

	local lastOpenChapterIndex = self:getLastOpenMapIndex(data.stageType)
	local curMapIndex = self:mapId2Index(data.chapterId, data.stageType)
	local pointUnLocked = true

	if data.pointId then
		pointUnLocked = self:isPointUnlock(data.pointId)
	end

	if curMapIndex == nil then
		return false, Strings:find("CUSTOM_POINT_NOT_OPEN")
	end

	local isUnlock = curMapIndex <= lastOpenChapterIndex and pointUnLocked
	local tips = Strings:find("CUSTOM_POINT_NOT_OPEN")
	local tips

	if isUnlock then
		tips = ""
	end

	return isUnlock, tips
end

function TeamSystem:tryEnter(data)
	local isUnlock, tips = self:checkEnabled(data)

	if isUnlock then
		local view = self:getInjector():getInstance("CommonStageMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, {}, data))
	else
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function TeamSystem:checkChapterViewAndPointEnable(data)
	local chapterId = data.chapterId

	if chapterId then
		local map = self:getMapById(chapterId)

		if data.enterPoint then
			local pointId = data.pointId
			local point = self:getPointById(pointId)

			if not point then
				return false, Strings:get("Tips_BlockUnopen")
			end

			local isUnlock, tips = point:isUnlock()

			return isUnlock
		else
			local isUnlock, tips = map:isUnlock()

			return isUnlock, tips
		end
	end

	return false
end

function TeamSystem:enterChapterViewAndPoint(data)
	local isUnlock, tips = self:checkChapterViewAndPointEnable(data)

	if isUnlock then
		local view = self:getInjector():getInstance("CommonStageChapterView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, {}, data))
	else
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function TeamSystem:checkHeroStoryEnable(data)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Hero_StoryPoint")

	if not unlock then
		return false, tips
	end

	local heroId = data.heroId
	local heroSystem = self._developSystem:getHeroSystem()

	if not heroSystem:hasHero(heroId) then
		return false, Strings:get("HeroStory_Hero_Locked")
	end

	local _hero = heroSystem:getHeroById(heroId)
	local heroInfo = {}

	heroInfo.heroId = _hero:getId()
	heroInfo.heroLove = _hero:getLoveLevel()
	heroInfo.heroQuality = _hero:getQuality()
	heroInfo.heroStar = _hero:getStar()

	local index = data.index

	if not index then
		return true
	end

	local mapId = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "HeroStoryMap")
	local map = self:getHeroStoryMapById(mapId)

	if index == 1 then
		if map then
			local point = map._indexToPoints[1]

			return point:isUnlock(heroInfo)
		else
			local pointId = ConfigReader:getDataByNameIdAndKey("HeroStoryMap", mapId, "SubPoint")
			local firstPointInfo = ConfigReader:getRecordById("HeroStoryPoint", pointId[1])
			local condition = true

			for k, v in pairs(firstPointInfo.Condition) do
				if k == "HeroLove" and heroInfo.heroLove < tonumber(v) then
					condition = false

					break
				end

				if k == "Quality" and heroInfo.heroQuality < tonumber(v) then
					condition = false

					break
				end

				if k == "HeroStar" and heroInfo.heroStar < tonumber(v) then
					condition = false

					break
				end
			end

			return condition
		end
	elseif not map then
		return false
	else
		local point = map._indexToPoints[index]

		return point:isUnlock(heroInfo)
	end
end

function TeamSystem:tryEnterHeroStory(data)
	local isUnlock, tips = self:checkHeroStoryEnable(data)

	if isUnlock then
		local viewData = {}

		viewData.heroId = data.heroId
		viewData.index = data.index

		local view = self:getInjector():getInstance("HeroStoryChapterView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, {}, viewData))
	else
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function TeamSystem:getHeroStoryMapById(mapId)
	local maps = self._stageManager:getStage(kHeroStroy)

	return maps:getMapById(mapId)
end

function TeamSystem:getHeroStoryPointById(pointId)
	local mapId = ConfigReader:getDataByNameIdAndKey("HeroStoryPoint", pointId, "Map")
	local _map = self:getHeroStoryMapById(mapId)

	if _map then
		return _map:getHeroStoryPointById(pointId)
	end
end

function TeamSystem:initSortType()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_SORTTYPE)

	self._sortType = value ~= 0 and value or 1
end

function TeamSystem:initSortOrder()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_SORTORDER)

	self._sortOrder = value ~= 0 and value or 2
end

function TeamSystem:initCardSortType()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_CARD_SORTTYPE)

	self._cardSortType = value ~= 0 and value or 1
end

function TeamSystem:initHeroCardSortType()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_HERO_CARD_SORTTYPE)

	self._heroCardSortType = value ~= 0 and value or 1
end

function TeamSystem:initCardSortOrder()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_CARD_SORTORDER)

	self._cardSortOrder = value ~= 0 and value or 2
end

function TeamSystem:initHeroCardSortOrder()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_HERO_CARD_SORTORDER)

	self._heroCardSortOrder = value ~= 0 and value or 2
end

function TeamSystem:setHeroSortType(type)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_HERO_CARD_SORTTYPE, type)
	self:initHeroCardSortType()
end

function TeamSystem:setSortType(type)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_SORTTYPE, type)
	self:initSortType()
end

function TeamSystem:setSortOrder(order)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_SORTORDER, order)
	self:initSortOrder()
end

function TeamSystem:setHeroSortOrder(order)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_HERO_CARD_SORTORDER, order)
	self:initHeroCardSortOrder()
end

function TeamSystem:setCardSortType(type)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_CARD_SORTTYPE, type)
	self:initCardSortType()
end

function TeamSystem:setCardSortOrder(order)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_CARD_SORTORDER, order)
	self:initCardSortOrder()
end

function TeamSystem:initTowerCardSortOrder()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_TOWER_CARD_SORTORDER)

	self._towerCardSortOrder = value ~= 0 and value or 2
end

function TeamSystem:setTowerSortOrder(order)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_TOWER_CARD_SORTORDER, order)
	self:initTowerCardSortOrder()
end

function TeamSystem:setTowerCardSortType(type)
	cc.UserDefault:getInstance():setIntegerForKey(TEAM_TOWER_CARD_SORTTYPE, type)
	self:initTowerCardSortType()
end

function TeamSystem:initTowerCardSortType()
	local value = cc.UserDefault:getInstance():getIntegerForKey(TEAM_TOWER_CARD_SORTTYPE)

	self._towerCardSortType = value ~= 0 and value or 1
end

function TeamSystem:syncStages(data, player)
	self._stageManager:sync(data)

	if player then
		self._stageManager:setPlayer(player)
	end

	self:dispatch(Event:new(EVT_RANK_OPNE_SYNC))
end

function TeamSystem:syncStagePresents(data)
	for k, v in pairs(data) do
		if self._stagePresents[k] then
			if v.gotRewards then
				self._stagePresents[k].gotRewards = v.gotRewards
			end

			if v.stageCount then
				self._stagePresents[k].stageCount = v.stageCount
			end

			if v.allGot then
				self._stagePresents[k].allGot = v.allGot
			end
		else
			self._stagePresents[k] = v
		end
	end
end

function TeamSystem:syncHeroStory(data)
	self._stageManager:syncHeroStory(data)
end

function TeamSystem:getStage(stageType)
	return self._stageManager:getStage(stageType)
end

function TeamSystem:getStageCount(stageType)
	local _stage = self:getStage(stageType)

	return (_stage:getMapCount())
end

function TeamSystem:getMainPassNum()
	local stage = self._stageManager:getStage(StageType.kMain)

	return stage and stage:getPassPointCount() or 0
end

function TeamSystem:getMapById(mapId)
	local config = ConfigReader:getRecordById("BlockMap", mapId)

	if config == nil then
		return
	end

	local stageType = config.Type
	local stage = self:getStage(stageType)

	return stage and stage:getMapById(mapId)
end

function TeamSystem:getPointById(pointId)
	local config = ConfigReader:getRecordById("BlockPoint", pointId)

	if config == nil then
		config = ConfigReader:getRecordById("StoryPoint", pointId)

		if config == nil then
			config = ConfigReader:getRecordById("BlockPracticePoint", pointId)

			if config == nil then
				if pointId and (DEBUG == 2 or app.pkgConfig.showLuaError == 1) then
					app.showMessageBox(pointId, "错误的pointId:")
				end

				return
			end
		end
	end

	if not config.Map then
		local mapId = config.BlockMapID
		local map = self:getMapById(mapId)

		if not map then
			return
		end

		local commonPoint = map:getPointById(pointId)

		if commonPoint then
			return commonPoint, kStageTypeMap.point
		end

		local storyPoint = map:getStoryPointById(pointId)

		if storyPoint then
			return storyPoint, kStageTypeMap.StoryPoint
		end

		local practicePoint = map:getPracticePointById(pointId)

		if practicePoint then
			return practicePoint, kStageTypeMap.PracticePoint
		end
	end
end

function TeamSystem:getMapIndexByPointId(pointId)
	local config = ConfigReader:getRecordById("BlockPoint", pointId)
	local mapId = config.Map

	return (ConfigReader:getDataByNameIdAndKey("BlockMap", mapId, "Order"))
end

function TeamSystem:getPointIndexById(pointId)
	local pointConfig = ConfigReader:getRecordById("BlockPoint", pointId)
	local mapConfig = ConfigReader:getRecordById("BlockMap", pointConfig.Map)

	for k, v in pairs(mapConfig.SubPoint) do
		if pointId == v then
			return k
		end
	end

	return 0
end

function TeamSystem:getNewMapUnlockIndex(stageType)
	local _stage = self._stageManager:getStage(stageType)

	return _stage:getNewOpenMapIndex()
end

function TeamSystem:setNewMapUnlockIndex(stageType, index)
	local _stage = self._stageManager:getStage(stageType)

	return _stage:setNewOpenMapIndex(index)
end

function TeamSystem:setBattleTeamInfo(team)
	local teamInfo = {
		teamHeroInfo = {}
	}
	local heroIds = team:getHeroes()

	for _, v in ipairs(heroIds) do
		local heroInfo = self._developSystem:getHeroSystem():getHeroById(v)

		teamInfo.teamHeroInfo[v] = {
			level = heroInfo:getLevel(),
			exp = heroInfo:getExp()
		}
	end

	self:setBattleTeam(teamInfo)
end

function TeamSystem:getChapterListInfo(stageType)
	local model = self:getModelByType(stageType)

	return model:getMapInfoList()
end

function TeamSystem:getSectionStageState()
	local stagePresents = self._stagePresents
	local sectionStateTab = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StagePresentOrder", "content")
	local tag = -1
	local toReachCount = -1
	local allDone = false

	for k, v in ipairs(sectionStateTab) do
		toReachCount = -1
		allDone = false

		if stagePresents[v.stageName] then
			tag = k

			if not stagePresents[v.stageName].allGot then
				toReachCount = stagePresents[v.stageName].stageCount

				break
			else
				allDone = true
			end
		else
			tag = k - 1

			break
		end
	end

	local curSectionInfo = sectionStateTab[tag]

	if not curSectionInfo or toReachCount == -1 or allDone then
		return false
	end

	local rewards = curSectionInfo.reward
	local hasGotNum = 0

	for k, v in ipairs(rewards) do
		if toReachCount >= tonumber(v.count) then
			hasGotNum = hasGotNum + 1
		end
	end

	return true, tag, hasGotNum > table.nums(stagePresents[curSectionInfo.stageName].gotRewards)
end

function TeamSystem:requestStageEnter(params, callback, blockUI)
	self._stageService:requestStageEnter(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			local function enterBattleFunc()
				if callback then
					callback(response.data)
				end
			end

			local storyLink = ConfigReader:getDataByNameIdAndKey("BlockPoint", params.pointId, "StoryLink")
			local storynames = storyLink and storyLink.enter
			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local storyAgent = storyDirector:getStoryAgent()

			storyAgent:setSkipCheckSave(false)
			storyAgent:trigger(storynames, nil, enterBattleFunc)
		elseif response.resCode == 1032 then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("CUSTOM_ENERGY_NOT_ENOUGH")
			}))
		end
	end)
end

function TeamSystem:requestEnterHeroStory(params, callback, blockUI)
	self._stageService:requestEnterHeroStory(params, function(response)
		if response.resCode == GS_SUCCESS then
			local function enterBattleFunc()
				if callback then
					callback(response.data)
				end
			end

			local storyLink = ConfigReader:getDataByNameIdAndKey("HeroStoryPoint", params.pointId, "StoryLink")
			local storynames = storyLink and storyLink.enter
			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local storyAgent = storyDirector:getStoryAgent()

			storyAgent:setSkipCheckSave(true)
			storyAgent:trigger(storynames, nil, enterBattleFunc)
		end
	end, blockUI)
end

function TeamSystem:requestStageProgress(callback, blockUI)
	self._stageManager:setPlayer(self:getDevelopSystem():getPlayer())
	self._stageService:requestStageProgress({}, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self._hasRequest = true

			self:syncStages(response.data)
		end

		if callback then
			callback()
		end
	end)
end

function TeamSystem:requestHeroStoryProgress(callback, blockUI)
	self._stageService:requestHeroStoryProgress({}, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:syncHeroStory(response.data)
		end

		if callback then
			callback(response)
		end
	end)
end

function TeamSystem:reset()
	self:requestHeroStoryProgress(function()
		self:dispatch(Event:new(EVT_REQUSET_HEROSTORY))
	end, true)
end

function TeamSystem:requestStoryPass(pointId, callback, blockUI)
	local parem = {
		pointId = pointId
	}

	self._stageService:requestStoryPass(parem, function(response)
		if response.resCode == GS_SUCCESS then
			local storyPoint = self:getPointById(pointId)

			storyPoint:getOwner():syncStoryPoint()
			self._commonStage:checkBindStoryPointState()

			if callback then
				callback(response)
			end
		end
	end, blockUI)
end

function TeamSystem:requestSectionReward(params, callback, blockUI)
	self._stageService:requestSectionReward(params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end, blockUI)
end

function TeamSystem:getMapByIndex(index, stageType)
	if stageType == nil or stageType == StageType.kNormal then
		return self._commonStage:getMapByIndex(index)
	elseif stageType == StageType.kElite then
		return self._eliteStage:getMapByIndex(index)
	end
end

function TeamSystem:getPointInfoByMapAndPointIndex(mapIndex, pointIndex, stageType)
	local mapInfo = self:getMapByIndex(mapIndex, stageType)

	if not mapInfo or not mapInfo._pointInfoList then
		return nil
	end

	return mapInfo._pointInfoList[pointIndex]
end

function TeamSystem:mapId2Index(mapId, stageType)
	if stageType == nil then
		local config = ConfigReader:getRecordById("BlockMap", mapId)

		if config == nil then
			return
		end

		stageType = config.Type
	end

	if stageType == StageType.kNormal then
		return self._commonStage:mapId2Index(mapId)
	elseif stageType == StageType.kElite then
		return self._eliteStage:mapId2Index(mapId)
	end
end

function TeamSystem:index2MapId(index, stageType)
	if stageType == nil or stageType == StageType.kNormal then
		return self._commonStage:index2MapId(index)
	elseif stageType == StageType.kElite then
		return self._eliteStage:index2MapId(index)
	end
end

function TeamSystem:pointId2Index(pointId)
	local pointCfg = self:getPointConfigById(pointId)
	local mapCfg = self:getMapConfigById(pointCfg.Map)

	for k, v in ipairs(mapCfg.SubPoint) do
		if v == pointId then
			return k
		end
	end
end

function TeamSystem:hasHomeRedPoint()
	local tab = self:queryRewardBox(StageType.kNormal)

	if #tab > 0 then
		return true
	else
		tab = self:queryRewardBox(StageType.kElite)

		return #tab > 0
	end
end

function TeamSystem:queryRewardBox(stageType)
	local stage = self:getStage(stageType)
	local mapCount = stage:getUnlockMapCount()
	local tab = {}

	for i = 1, mapCount do
		local map = stage:getMapByIndex(i)
		local mapBoxData = map:getMapBoxData()

		for index, boxData in ipairs(mapBoxData) do
			local boxState = boxData.boxState

			if boxState == StageBoxState.kCanReceive then
				tab[#tab + 1] = i

				break
			end
		end
	end

	return tab
end

function TeamSystem:boxReardToTable(boxReward)
	local tab = {}

	if not boxReward then
		return tab
	end

	for k, v in pairs(boxReward) do
		local item = {}

		item.starNum = tonumber(k)
		item.rewardId = v

		table.insert(tab, item)
	end

	table.sort(tab, function(t1, t2)
		if t1.starNum <= t2.starNum then
			return true
		else
			return false
		end
	end)

	return tab
end

function TeamSystem:getMapConfigById(mapId)
	return ConfigReader:getRecordById("BlockMap", mapId)
end

function TeamSystem:getMapConfigByIndex(index, stageType)
	return self:getMapConfigById(self:index2MapId(index, stageType))
end

function TeamSystem:getPointConfigById(pointId)
	return ConfigReader:getRecordById("BlockPoint", pointId)
end

function TeamSystem:getStoryPointConfigById(pointId)
	return ConfigReader:getRecordById("StoryPoint", pointId)
end

function TeamSystem:getStageTypeById(pointId)
	local pointConfig = self:getPointConfigById(pointId)

	return pointConfig.Type
end

function TeamSystem:getLastOpenMapIndex(stageType)
	local model = self:getModelByType(stageType)

	return model:getUnlockMapCount()
end

function TeamSystem:getLastOpenStageIndex(stageType)
	local index = self:getLastOpenMapIndex(stageType)
	local mapId = self:index2MapId(index, stageType)
	local stage = self:getStage(stageType)

	if stage then
		if index == 0 then
			return nil
		end

		local map = stage:getMapById(mapId)
		local mapCfg = map:getConfig()

		for i = #mapCfg.SubPoint, 1, -1 do
			local pointId = mapCfg.SubPoint[i]
			local point = map and map:getPointById(pointId)

			if point:isUnlock() then
				return point:getId()
			end
		end
	end
end

function TeamSystem:getLastPassStagePointId(stageType)
	local pointId
	local index = self:getLastOpenMapIndex(stageType)

	for j = 1, 2 do
		if index == 0 or pointId then
			break
		end

		local mapId = self:index2MapId(index, stageType)
		local stage = self:getStage(stageType)

		if stage then
			local map = stage:getMapById(mapId)
			local mapCfg = map:getConfig()

			for i = #mapCfg.SubPoint, 1, -1 do
				local point = map and map:getPointById(mapCfg.SubPoint[i])

				if point:isPass() then
					pointId = point:getId()

					break
				end
			end
		end

		index = index - 1
	end

	return pointId
end

function TeamSystem:parseStageIndex(pointId, stageType)
	if stageType == StageType.kNormal or stageType == nil then
		return self._commonStage:parseStageIndex(pointId)
	elseif stageType == StageType.kElite then
		return self._eliteStage:parseStageIndex(pointId)
	end
end

function TeamSystem:getLastPointIndexByMapIndex(mapIndex, stageType)
	if stageType == nil or stageType == StageType.kNormal then
		return self._commonStage:getLastPointIndexByMapIndex(mapIndex)
	elseif stageType == StageType.kElite then
		return self._eliteStage:getLastPointIndexByMapIndex(mapIndex)
	end
end

function TeamSystem:getOpenChapterList(stageType)
	local chapterList = self:getChapterListInfo(stageType)
	local openChapterList = {}

	for k, v in pairs(chapterList) do
		if v:isUnlock() then
			openChapterList[k] = v
		else
			break
		end
	end

	return openChapterList
end

function TeamSystem:isPointUnlock(pointId)
	local pointInfo = self:getPointById(pointId)

	return pointInfo and pointInfo:isUnlock()
end

function TeamSystem:getModelByType(stageType)
	if stageType == nil or stageType == StageType.kNormal then
		return self._commonStage
	elseif stageType == StageType.kElite then
		return self._eliteStage
	end

	return nil
end

function TeamSystem:battleResultCallBack(realData, mapData, winCallBack)
	self:requestPass(mapData.mapId, mapData.pointId, realData, function(response)
		local function finishCallBack()
			if response.pass then
				response.pointId = mapData.pointId

				local function endFunc()
					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageWinPopView"), {}, response, self))
				end

				local storyLink = ConfigReader:getDataByNameIdAndKey("BlockPoint", mapData.pointId, "StoryLink")
				local storynames = storyLink and storyLink.win
				local storyDirector = self:getInjector():getInstance(story.StoryDirector)
				local storyAgent = storyDirector:getStoryAgent()

				storyAgent:setSkipCheckSave(false)
				storyAgent:trigger(storynames, nil, endFunc)

				if winCallBack then
					winCallBack()
				end
			else
				local loseData = {
					mapId = mapData.mapId,
					pointId = mapData.pointId,
					roundCount = response.statist.roundCount,
					battleStatist = response.statist.players
				}

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageLosePopView"), {}, loseData, self))
			end
		end

		if response.reviewFailed then
			local data = {
				title = Strings:get("Tip_Remind"),
				title1 = Strings:get("UITitle_EN_Tishi"),
				content = Strings:get("FAC_Des"),
				sureBtn = {
					text1 = "FAC_Btn"
				}
			}
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				finishCallBack()
			end

			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		else
			finishCallBack()
		end
	end, false)
end

function TeamSystem:getCostInit()
	return (ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Player_Init_Cost", "content"))
end

function TeamSystem:getPlayerInit()
	return (ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content"))
end

function TeamSystem:checkIsShowRedPoint()
	local heroSystem = self._developSystem:getHeroSystem()
	local playerLevel = self._developSystem:getLevel()

	if playerLevel < 30 then
		local costMaxNum = self:getCostInit() + self._developSystem:getBuildingCostEffValue()
		local maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()
		local team = self._developSystem:getAllUnlockTeams()[1]
		local heroesNum = #team:getHeroes()
		local heroes = team:getHeroes()
		local petList = self:getNotOnTeamPetByIndex(team:getId())

		if heroesNum < maxTeamPetNum and #petList > 0 then
			return true
		end
	end

	return false
end

local TargetOccupation = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Team_TypeOrder", "content")
local heroShowSortList = {
	Strings:get("HEROS_UI49"),
	Strings:get("HEROS_UI31"),
	Strings:get("HEROS_UI30"),
	Strings:get("HEROS_UI29"),
	Strings:get("HEROS_UI5"),
	Strings:get("Force_Screen")
}
local SortOrder = {
	Strings:get("HEROS_UI32"),
	Strings:get("HEROS_UI33")
}
local SortExtendFunc = {
	{
		func = function(sortExtendType, hero)
			return hero:getRarity() == 16 - sortExtendType
		end
	},
	{
		func = function(sortExtendType, hero)
			return hero:getType() == TargetOccupation[sortExtendType]
		end
	},
	{
		func = function(sortExtendType, hero)
			return hero:getCost() == sortExtendType + 7
		end
	},
	{
		func = function(sortExtendType, hero)
			return hero:getParty() == SortExtend[4][sortExtendType]
		end
	}
}

function TeamSystem:setSortExtand(sortType, sortExtendType)
	if sortType == 0 then
		for i, v in ipairs(SortExtend) do
			self._sortExtand[i] = {}
		end

		return
	end

	self._sortExtand[sortType] = self._sortExtand[sortType] or {}

	if self:isSortExtendTypeExist(sortType, sortExtendType) then
		for i = 1, #self._sortExtand[sortType] do
			local v = self._sortExtand[sortType][i]

			if v == sortExtendType then
				table.remove(self._sortExtand[sortType], i)

				break
			end
		end
	else
		self._sortExtand[sortType][#self._sortExtand[sortType] + 1] = sortExtendType
	end
end

function TeamSystem:isSortExtendTypeExist(sortType, sortExtendType)
	for i = 1, #self._sortExtand[sortType] do
		local v = self._sortExtand[sortType][i]

		if v == sortExtendType then
			return true
		end
	end

	return false
end

function TeamSystem:getNotOnTeamPetByIndex(index)
	local onTeamPet = self:getDevelopSystem():getStageTeamById(index):getHeroes()

	return (self:getNotOnTeamPet(onTeamPet))
end

function TeamSystem:getNotOnTeamPet(ids)
	local heroSystem = self:getDevelopSystem():getHeroSystem()
	local allPet = heroSystem:getAllHeroIds()
	local notOnTeamPet = {}
	local checkIds = table.copy(ids, {})

	for i = 1, #allPet do
		local id = allPet[i]
		local index = table.indexof(checkIds, id)

		if index then
			table.remove(checkIds, index)
		else
			notOnTeamPet[#notOnTeamPet + 1] = id
		end
	end

	return notOnTeamPet
end

function TeamSystem:getSortExtendIds(ids)
	local list = {}

	for k = 1, #ids do
		if self:checkHasExtend() then
			if self:chooseHero(ids[k]) then
				list[#list + 1] = ids[k]
			end
		else
			list[#list + 1] = ids[k]
		end
	end

	return list
end

function TeamSystem:checkHasExtend()
	for i, v in ipairs(self._sortExtand) do
		if v and #v > 0 then
			return true
		end
	end

	return false
end

function TeamSystem:chooseHero(heroId)
	local heroSystem = self:getDevelopSystem():getHeroSystem()
	local checkMark = 0

	for sortType, sortExtend in ipairs(self._sortExtand) do
		if sortExtend and #sortExtend > 0 then
			for i = 1, #sortExtend do
				if SortExtendFunc[sortType] and SortExtendFunc[sortType].func(sortExtend[i], heroSystem:getHeroById(heroId)) then
					checkMark = checkMark + 1

					break
				end
			end
		elseif sortExtend and #sortExtend == 0 then
			checkMark = checkMark + 1
		end
	end

	if checkMark == #self._sortExtand then
		return true
	end

	return false
end

function TeamSystem:getSortTypeStr(type)
	return heroShowSortList[type]
end

function TeamSystem:getSortOrderStr()
	return SortOrder[self._sortOrder]
end

function TeamSystem:getCardSortOrderStr()
	return SortOrder[self._cardSortOrder]
end

function TeamSystem:getSortNum()
	return #heroShowSortList
end

function TeamSystem:getSortExtendNum()
	return #SortExtend
end

function TeamSystem:getSortExtandParam(sortType)
	return SortExtend[sortType]
end

function TeamSystem:getSortExtendMaxNum()
	local num = 0

	for i, v in ipairs(SortExtend) do
		num = math.max(num, #v)
	end

	return num
end

function TeamSystem:initExtendParam()
	SortExtend = SortExtend or {}
	SortExtend[1] = {
		"SP",
		"SSR",
		"SR",
		"R"
	}
	SortExtend[2] = {}
	SortExtend[3] = {}
	SortExtend[4] = {
		GalleryPartyType.kWNSXJ,
		GalleryPartyType.kXD,
		GalleryPartyType.kBSNCT,
		GalleryPartyType.kDWH,
		GalleryPartyType.kMNJH,
		GalleryPartyType.kSSZS,
		GalleryPartyType.kUNKNOWN
	}

	for i = 1, #TargetOccupation do
		local type = TargetOccupation[i]

		SortExtend[2][i] = GameStyle:getHeroOccupation(type)
	end

	for i = 8, 20 do
		table.insert(SortExtend[3], i)
	end
end

function TeamSystem:isHeroExcept(cardExcept, heroId)
	local heroSystem = self:getDevelopSystem():getHeroSystem()
	local cost = heroSystem:getHeroById(heroId):getCost()
	local type = heroSystem:getHeroById(heroId):getType()

	for i = 1, #cardExcept do
		local except = false
		local exceptCondition = cardExcept[i]

		if exceptCondition.Cost and table.indexof(exceptCondition.Cost, cost) then
			except = true
		end

		except = not except and exceptCondition.Cost or exceptCondition.Type and table.indexof(exceptCondition.Type, type) and true

		if except then
			return true
		end
	end

	return false
end

function TeamSystem:isStoryHeroExcept(cardExcept, heroId)
	if table.indexof(cardExcept, heroId) then
		return true
	end

	return false
end

function TeamSystem:syncKeySkillCache()
	self._keySkillManager._developSystem = self._developSystem
	self._keySkillManager._towerSystem = self._towerSystem

	self._keySkillManager:syncKeySkillCache()
end

function TeamSystem:checkIsKeySkillActive(conditions, targetIds, heroType)
	return self._keySkillManager:checkIsKeySkillActive(conditions, targetIds, {
		heroType = heroType
	})
end

function TeamSystem:hasStaminaBackEffect()
	local params = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", "SpFunc_BattleStaminaBack", "Parameter")

	if params and params.type then
		local value = self._developSystem:getPlayer():getEffectCenter():getSpEffectById(params.type)

		if value then
			return true
		end
	end

	return false
end

function TeamSystem:enterBattle(pointId, playerData, mapData, enemyBuff)
	Bdump("playerData:{}", playerData)

	local battleTypeKey = {
		NORMAL = SettingBattleTypes.kNormalStage,
		ELITE = SettingBattleTypes.kEliteStage
	}
	local isReplay = false
	local battleType = battleTypeKey[self:getStageTypeById(pointId)]
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("AutoFight")
	local outSelf, battleDelegate = self, {}
	local randomSeed = tonumber(tostring(os.time()):reverse():sub(1, 6))
	local battleSession = StageBattleSession:new({
		playerData = playerData,
		pointId = pointId,
		logicSeed = randomSeed,
		enemyBuff = enemyBuff
	})

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()
	local battlePassiveSkill = battleSession:getBattlePassiveSkill()
	local victoryConditions = ConfigReader:getDataByNameIdAndKey("BlockPoint", pointId, "VictoryConditions")
	local fleeInfo

	for k, v in pairs(victoryConditions) do
		if v.type == "KeyUnitsEscaped" then
			fleeInfo = v.factor
		end
	end

	local guide
	local stageGuideCustomKey = "Guide_" .. pointId
	local useGuide = false

	if not GameConfigs or not GameConfigs.closeGuide then
		require("dm.gameplay.stage.guide.StageGuide")

		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideSystem = self:getInjector():getInstance(GuideSystem)
		local guideAgent = storyDirector:getGuideAgent()
		local guideFile = ConfigReader:getDataByNameIdAndKey("BlockPoint", pointId, "StageGuide")
		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
		local guided = customDataSystem:getValue(PrefixType.kGlobal, stageGuideCustomKey)
		local point = self:getPointById(pointId)
		local skipAllSta = guideAgent:isSaved("GUIDE_SKIP_ALL")

		if guideFile and guideFile ~= "" and not guided and (point and point:isPass() or skipAllSta or nil) and false then
			guide = require("dm.gameplay.stage.guide." .. guideFile)
			isAuto = false
		elseif guideSystem:getChapterOptionalSta(pointId) then
			guide = require("dm.gameplay.stage.guide.StageGuideOptional")
		end

		if guide then
			guide:setInjector(self:getInjector())

			local guideLogic = GuideBattleLogic:new(bind1(guide.main, guide))

			guideLogic:attachBattleLogic(battleLogic)
			battleSimulator:setBattleLogic(guideLogic)

			useGuide = true
		end
	end

	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen(battleType)
	local logicInfo = {
		battleGuide = guide,
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			playerData.rid
		}
	}

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, isAuto)
	end

	function battleDelegate:onLeavingBattle()
		local realData = battleSession:getExitSummary()
		local data = {
			roundCount = 1,
			mapId = mapData.mapId,
			pointId = mapData.pointId,
			battleStatist = realData.statist.players
		}

		outSelf:requestLeaveStage(mapData.mapId, mapData.pointId, function(response)
			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("StageLosePopView"), {}, data, outSelf))
		end)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:onBattleStart(sender, event)
		BattleStoryExtension:new(pointId, event)
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		local function winCallBack()
			if useGuide then
				local customDataSystem = outSelf:getInjector():getInstance(CustomDataSystem)

				customDataSystem:setValue(PrefixType.kGlobal, stageGuideCustomKey, true)
			end
		end

		outSelf:battleResultCallBack(realData, mapData, winCallBack)
	end

	function battleDelegate:onDevWin()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				playerData.rid
			},
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3,
						unitSummary = {}
					},
					[pointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20
					}
				}
			}
		}

		outSelf:battleResultCallBack(realData, mapData)
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, nil, timeScale)
	end

	function battleDelegate:showHero(heroBaseId, pauseFunc, resumeCallback)
		if outSelf:getInjector():getInstance(SettingSystem):getSettingModel():getHeroShowed(heroBaseId) then
			return
		end

		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setHeroShowed(heroBaseId)

		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			resumeCallback()
		end

		local heroView = outSelf:getInjector():getInstance("battleShowHeroView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, heroView, {
			maskOpacity = 100
		}, {
			heroId = heroBaseId
		}, popupDelegate))
		pauseFunc()
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("battleBossComeView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local pointConfig = self:getPointConfigById(pointId)

	if not pointConfig.Background then
		local bgRes = "battle_scene_1"
		local loadingTypeKey = {
			NORMAL = LoadingType.KStageNormal,
			ELITE = LoadingType.KStageElite
		}
		local loadingType = loadingTypeKey[self:getStageTypeById(pointId)]
		local var_112_1 = {
			loadingId = ConfigReader:getRecordById("ConfigValue", "Block_Fix_Loading").content[pointId],
			battleType = battleSession:getBattleType(),
			battleData = battleData,
			battleConfig = battleConfig,
			isReplay = isReplay,
			logicInfo = logicInfo,
			delegate = battleDelegate
		}
		local var_112_2 = {
			finalHitShow = true,
			mainView = "battlePlayer",
			opPanelRes = "asset/ui/BattleUILayer.csb",
			canChangeSpeedLevel = true,
			opPanelClazz = "BattleUIMediator",
			finalTaskFinishShow = true,
			bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Main"),
			bgm = pointConfig.BGM,
			background = bgRes,
			fleeInfo = fleeInfo,
			refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content
		}

		var_112_2.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
		var_112_2.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
		var_112_2.battleSuppress = BattleDataHelper:getBattleSuppress()
		var_112_2.passiveSkill = battlePassiveSkill
		var_112_2.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
		var_112_2.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime(battleType)
		var_112_2.changeMaxNum = ConfigReader:getDataByNameIdAndKey("BlockPoint", pointId, "BossRound") or 1

		local var_112_3 = {}
		local var_112_4 = {}

		var_112_4.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
		var_112_4.lock = not unlockSpeed
		var_112_4.tip = tipsSpeed
		var_112_4.speedConfig = battleSpeed_Actual
		var_112_4.speedShowConfig = battleSpeed_Display
		var_112_4.timeScale = timeScale
		var_112_3.speed = var_112_4
		var_112_3.skip = {
			visible = false
		}

		local var_112_5 = {}

		var_112_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
		var_112_5.state = (not unlock or nil) and false
		var_112_5.lock = not systemKeeper:isUnlock("AutoFight")
		var_112_3.auto = var_112_5
		var_112_3.pause = {
			visible = true
		}

		local var_112_6 = {}

		var_112_6.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
		var_112_6.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
		var_112_3.restraint = var_112_6
		var_112_2.btnsShow = var_112_3
		var_112_1.viewConfig = var_112_2
		var_112_1.loadingType = loadingType

		local data = var_112_1

		BattleLoader:pushBattleView(self, data)
	end
end

function TeamSystem:enterHeroStoryBattle(pointId, mapId, playerData)
	local isReplay = false
	local guide
	local battleType = SettingBattleTypes.kHeroStory
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)
	local randomSeed = tonumber(tostring(os.time()):reverse():sub(1, 6))
	local outSelf, battleDelegate = self, {}
	local battleSession = HeroStoryBattleSession:new({
		playerData = playerData,
		pointId = pointId,
		logicSeed = randomSeed
	})

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()
	local battlePassiveSkill = battleSession:getBattlePassiveSkill()
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local logicInfo = {
		battleGuide = guide,
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			playerData.rid
		}
	}
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("herostory_battle")

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, isAuto)
	end

	function battleDelegate:onLeavingBattle()
		local heroId = ConfigReader:getDataByNameIdAndKey("HeroStoryMap", mapId, "Hero")
		local data = {
			pointId = pointId,
			SVPHeroId = heroId
		}

		outSelf:requestLeaveHeroStory(pointId, function(response)
			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("StageLosePopView"), {}, data, outSelf))
		end, true)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:onDevWin()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				playerData.rid
			},
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3,
						unitSummary = {}
					},
					[pointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20
					}
				}
			}
		}
		local mapData = {}

		mapData.pointId = pointId
		mapData.mapId = mapId

		outSelf:onHeroStoryBattleFinish(mapData, realData)
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		local function winCallBack()
			return
		end

		local mapData = {}

		mapData.pointId = pointId
		mapData.mapId = mapId

		outSelf:onHeroStoryBattleFinish(mapData, realData, winCallBack)
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, nil, timeScale)
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("battleBossComeView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local pointConfig = ConfigReader:getRecordById("HeroStoryPoint", pointId)

	if not pointConfig.Background then
		local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
		local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
		local loadingTypeKey = {
			NORMAL = LoadingType.KStageNormal,
			ELITE = LoadingType.KStageElite
		}
		local loadingType = loadingTypeKey[self:getStageTypeById(pointId)]
		local var_130_0 = {
			battleType = battleSession:getBattleType(),
			battleData = battleData,
			battleConfig = battleConfig,
			isReplay = isReplay,
			logicInfo = logicInfo,
			delegate = battleDelegate
		}
		local var_130_1 = {
			finalHitShow = true,
			mainView = "battlePlayer",
			opPanelRes = "asset/ui/BattleUILayer.csb",
			canChangeSpeedLevel = true,
			opPanelClazz = "BattleUIMediator",
			finalTaskFinishShow = true,
			bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Story"),
			bgm = pointConfig.BGM,
			background = pointConfig.Background,
			refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content
		}

		var_130_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
		var_130_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
		var_130_1.battleSuppress = BattleDataHelper:getBattleSuppress()
		var_130_1.passiveSkill = battlePassiveSkill
		var_130_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
		var_130_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("herostory_battle")

		local var_130_2 = {}
		local var_130_3 = {}

		var_130_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
		var_130_3.lock = not unlockSpeed
		var_130_3.tip = tipsSpeed
		var_130_3.speedConfig = battleSpeed_Actual
		var_130_3.speedShowConfig = battleSpeed_Display
		var_130_3.timeScale = timeScale
		var_130_2.speed = var_130_3
		var_130_2.skip = {
			visible = false
		}

		local var_130_4 = {}

		var_130_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
		var_130_4.state = isAuto
		var_130_4.lock = not systemKeeper:isUnlock("AutoFight")
		var_130_2.auto = var_130_4
		var_130_2.pause = {
			visible = true
		}

		local var_130_5 = {}

		var_130_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
		var_130_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
		var_130_2.restraint = var_130_5
		var_130_1.btnsShow = var_130_2
		var_130_0.viewConfig = var_130_1
		var_130_0.loadingType = loadingType

		local data = var_130_0

		BattleLoader:pushBattleView(self, data)
	end
end

function TeamSystem:onHeroStoryBattleFinish(mapData, realData, winCallBack)
	self:requestPassHeroStory(mapData.mapId, mapData.pointId, realData, function(response)
		local function finishCallBack()
			if response.pass then
				response.pointId = mapData.pointId
				response.MVPHeroId = ConfigReader:getDataByNameIdAndKey("HeroStoryMap", mapData.mapId, "Hero")

				local function endFunc()
					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("HeroStoryWinPopView"), {}, response, self))
				end

				local storyLink = ConfigReader:getDataByNameIdAndKey("HeroStoryPoint", mapData.pointId, "StoryLink")
				local storynames = storyLink and storyLink.win
				local storyDirector = self:getInjector():getInstance(story.StoryDirector)
				local storyAgent = storyDirector:getStoryAgent()

				storyAgent:setSkipCheckSave(true)
				storyAgent:trigger(storynames, nil, endFunc)

				if winCallBack then
					winCallBack()
				end
			else
				local heroId = ConfigReader:getDataByNameIdAndKey("HeroStoryMap", mapData.mapId, "Hero")
				local loseData = {
					mapId = mapData.mapId,
					pointId = mapData.pointId,
					SVPHeroId = heroId,
					roundCount = response.statist.roundCount,
					battleStatist = response.statist.players
				}

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageLosePopView"), {}, loseData, self))
			end
		end

		if response.reviewFailed then
			local data = {
				title = Strings:get("Tip_Remind"),
				title1 = Strings:get("UITitle_EN_Tishi"),
				content = Strings:get("FAC_Des"),
				sureBtn = {
					text1 = "FAC_Btn"
				}
			}
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				finishCallBack()
			end

			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		else
			finishCallBack()
		end
	end, false)
end

function TeamSystem:requestSPChangeTeam(data, callback, blockUI, params)
	self._stageService:requestSPChangeTeam(data, function(response)
		if response.resCode == GS_SUCCESS and (params and params and not params.ignoreTip and false or callback) then
			callback(response)
		end
	end, blockUI)
end

function TeamSystem:requestChangeTeam(data, callback, blockUI)
	self._stageService:requestChangeTeam(data, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_ARENA_CHANGE_TEAM_SUCC))

			if callback then
				callback(response)
			end
		end
	end, blockUI)
end

function TeamSystem:requestStageTeam(data, callback, blockUI)
	self._stageService:requestStageTeam(data, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_ARENA_CHANGE_TEAM_SUCC))

			if callback then
				callback(response)
			end
		end
	end, blockUI)
end

function TeamSystem:requestChangeTeamName(data, callback, blockUI)
	self._stageService:requestChangeTeamName(data, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Stage_UI2")
			}))
			self:dispatch(Event:new(EVT_STAGE_CHANGENAME_SUCC))

			if callback then
				callback()
			end
		end
	end, blockUI)
end

function TeamSystem:requestStageGetClearanceReward(mapId, pointId, callback, blockUI)
	local params = {
		mapId = mapId,
		pointId = pointId,
		params = {}
	}

	self._stageService:requestStageGetClearanceReward(params, function(response)
		if response.resCode == GS_SUCCESS then
			local point = self:getPointById(pointId)
			local box = point and point:getBox()

			if box then
				box:sync({
					boxType = "BOX",
					status = 1
				})
			end

			self:dispatch(Event:new(EVT_STAGE_RECEIVE_POINT_REWARD))

			if callback then
				callback(response.data)
			end
		end
	end, blockUI)
end

function TeamSystem:requestPass(mapId, pointId, resultData, callback, blockUI)
	local params = {
		mapId = mapId,
		pointId = pointId,
		resultData = resultData
	}
	local pointInfo = self:getPointById(pointId)

	pointInfo:recordOldStar()
	Bdump("requestPass:{}", params)
	self._stageService:requestPass(params, function(response)
		if response.resCode == GS_SUCCESS and (not response.data.pointData or true) then
			self:dispatch(Event:new(EVT_STAGE_FIGHT_SUCC, {}))

			if callback then
				callback(response.data)
			end
		end
	end, blockUI)
end

function TeamSystem:requestPassHeroStory(mapId, pointId, resultData, callback, blockUI)
	local params = {
		mapId = mapId,
		pointId = pointId,
		resultData = resultData
	}

	self._stageService:requestPassHeroStory(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_STAGE_FIGHT_SUCC, {}))

			if callback then
				callback(response.data)
			end
		end
	end, blockUI)
end

function TeamSystem:requestStageStarsReward(mapId, stars, callback, blockUI)
	local params = {
		mapId = mapId,
		star = stars
	}

	self._stageService:requestStageStarsReward(params, function(response)
		if response.resCode == GS_SUCCESS then
			local map = self:getMapById(mapId)

			map:setMapBoxReceived(stars)

			if callback then
				callback(response.data)
			end
		end
	end, blockUI)
end

function TeamSystem:requestHeroStoryStarsReward(mapId, stars, callback, blockUI)
	local params = {
		mapId = mapId,
		star = stars
	}

	self._stageService:requestHeroStoryStarsReward(params, function(response)
		if response.resCode == GS_SUCCESS then
			local map = self:getHeroStoryMapById(mapId)

			map:setMapBoxReceived(stars)

			if callback then
				callback(response.data)
			end
		end
	end, blockUI)
end

function TeamSystem:requestStageSweep(mapId, pointId, wipeTimes, wipeTarget, callback, blockUI)
	local params = {
		mapId = mapId,
		pointId = pointId,
		wipeTimes = wipeTimes
	}

	if wipeTarget then
		params.wipeTarget = wipeTarget
	end

	self._stageService:requestStageSweep(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_STAGE_RESETTIMES))

			if callback then
				callback(response.data)
			end
		elseif response.resCode == 11167 then
			-- block empty
		end
	end, blockUI)
end

function TeamSystem:requestHeroStageSweep(pointId, wipeTimes, wipeTarget, callback, blockUI)
	local params = {
		pointId = pointId,
		wipeTimes = wipeTimes
	}

	if wipeTarget then
		params.wipeTarget = wipeTarget
	end

	self._stageService:requestHeroStageSweep(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_HEROSTAGE_RESETTIMES))

			if callback then
				callback(response.data)
			end
		end
	end, blockUI)
end

function TeamSystem:requestResetPointTimes(mapId, pointId, notShowWaiting)
	local params = {
		mapId = mapId,
		pointId = pointId
	}

	self._stageService:requestResetPointTimes(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_STAGE_RESETTIMES))
		end
	end, notShowWaiting)
end

function TeamSystem:requestRunBoxClick(mapId, pointId, param, notShowWaiting)
	local params = {
		mapId = mapId,
		pointId = pointId
	}

	self._stageService:requestRunBox(params, function(response)
		if response.resCode == GS_SUCCESS then
			-- block empty
		elseif response.resCode == 10170 then
			-- block empty
		end
	end, notShowWaiting)
end

function TeamSystem:requestMapDiamond(mapId, callback, notShowWaiting)
	local params = {
		mapId = mapId
	}

	self._stageService:requestMapDiamond(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data.rewards)
			end
		elseif response.resCode == 10170 then
			-- block empty
		end
	end, notShowWaiting)
end

function TeamSystem:requestLeaveStage(mapId, pointId, callback)
	local params = {
		mapId = mapId,
		pointId = pointId
	}

	self._stageService:requestLeaveStage(params, function(response)
		if callback then
			callback(response)
		end
	end)
end

function TeamSystem:requestLeaveHeroStory(pointId, callback, blockUI)
	local params = {
		pointId = pointId
	}

	self._stageService:requestLeaveHeroStory(params, function(response)
		if callback then
			callback(response)
		end
	end, blockUI)
end

function TeamSystem:debugStoryAutoFinish()
	local mapList = self:getChapterListInfo()

	for _, map in ipairs(mapList) do
		if not map:isBattlePointPass() then
			break
		end

		local StoryPoints = map._index2StoryPoint

		for _, point in ipairs(StoryPoints) do
			if not point:isPass() then
				local spid = point:getId()

				self:requestStoryPass(spid, function()
					print("StoryLink=", spid)
				end)
			end
		end
	end
end

function TeamSystem:getLastOpenStoryIndex(stageType)
	local mapIndex = self:getLastOpenMapIndex(stageType)

	if mapIndex then
		while mapIndex > 0 do
			local map = self:getMapByIndex(mapIndex, stageType)

			if map then
				local index2StoryPoint = map._index2StoryPoint

				if index2StoryPoint then
					for i = #index2StoryPoint, 1, -1 do
						local point = index2StoryPoint[i]

						if point:isPass() then
							return point:getId()
						end
					end
				end
			end

			mapIndex = mapIndex - 1
		end
	end
end
