-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/guide/GuideSystem.lua

GuideSystem = class("GuideSystem", Facade, _M)

local ARENA_CHALLENGE_GUIDE_SIGN = "ARENA_CHALLENGE_GUIDE_SIGN"

function GuideSystem:initialize()
	super.initialize(self)
end

function GuideSystem:checkLevelUpGuide()
	if GameConfigs.closeGuide then
		return {}, ""
	end

	local playerLevel = self:getInjector():getInstance("DevelopSystem"):getPlayer():getLevel()
	local playerGuide = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_LevelOpen", "content") or {}

	for k, v in pairs(playerGuide) do
		if tostring(playerLevel) == k then
			return {
				v
			}, ""
		end
	end

	return {}, ""
end

function GuideSystem:checkGuideSwitchOpen(scriptName)
	local playerGuide = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuideSwitch", "content") or {}

	for k, v in pairs(playerGuide) do
		if tostring(scriptName) == k and v == 0 then
			return true
		end
	end

	return false
end

function GuideSystem:getRecruitHeroSta()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local heroCount = heroSystem:getHeroCount()

	if heroCount == 1 then
		return true
	end

	return false
end

function GuideSystem:check_guide_HeroLevelUp()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local heroList = heroSystem:getHeroList():getHeros()
	local heroData = heroList.ZTXChang

	if heroData and heroData:getLevel() < 5 then
		return true
	end

	return false
end

function GuideSystem:getUpStarHeroSta()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local heroList = heroSystem:getHeroList():getHeros()
	local heroData = heroList.FTLEShi
	local baseStar = ConfigReader:getDataByNameIdAndKey("HeroBase", "FTLEShi", "BaseStar")

	if heroData and heroData:getStar() == baseStar then
		return true
	end

	return false
end

function GuideSystem:getUpSkillHeroSta()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local heroList = heroSystem:getHeroList():getHeros()
	local heroData = heroList.FTLEShi

	if heroData then
		local skillIds = heroSystem:getShowSkillIds(heroData:getId())
		local skillId = skillIds[1]
		local skill = heroSystem:getSkillById(heroData:getId(), skillId)

		if skill:getLevel() == 1 then
			return true
		end
	end

	return false
end

function GuideSystem:getPassStory1_2()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("S01S02")

	if point and point:isPass() then
		return true
	end

	return false
end

function GuideSystem:checkPointIsNotPass(pointId)
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById(pointId)

	if point and not point:isPass() then
		return true
	end

	return false
end

function GuideSystem:checkComplexityNum(complexityNum)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getStoryAgent()
	local selfComplexityNum = tonumber(guideAgent:getGuideComplexNum())

	if complexityNum < selfComplexityNum then
		return true
	end

	return false
end

function GuideSystem:getResearchPracticeSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M02S01")

	if point and point:isPass() then
		return true
	end

	return false
end

function GuideSystem:getHeroLevelUpSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M02S03")

	if point and point:isPass() then
		return true
	end

	return false
end

function GuideSystem:getTaskDailySta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M03S06")

	if point and point:isPass() then
		return true
	end

	return false
end

function GuideSystem:getTaskStageSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M02S02")

	if point and point:isPass() then
		return true
	end

	return false
end

function GuideSystem:getMasterUpStar()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local masterSystem = developSystem:getMasterSystem()
	local showMasterList = masterSystem:getShowMasterList()
	local mastermodel = showMasterList[1]
	local star = mastermodel:getStar()
	local starPointData = mastermodel:getCurStarPointConfig()
	local starPointIds = mastermodel:getCurStarPoints()
	local pointId = starPointIds[1]
	local pointData = starPointData[pointId]

	if pointData:getState() == 2 and star == 1 then
		return true
	end

	return false
end

function GuideSystem:getMasterUpSkill()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local masterSystem = developSystem:getMasterSystem()
	local showMasterList = masterSystem:getShowMasterList()
	local mastermodel = showMasterList[1]
	local skills = masterSystem:getShowMasterSkillList(mastermodel:getId())
	local skill = skills[1]

	if skill:getLevel() == 1 then
		return true
	end

	return false
end

function GuideSystem:getMasterStarSkillSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M03S02")

	if point and point:isPass() and self:getMasterUpSkill() then
		return true
	end

	return false
end

function GuideSystem:getHeroStarSkillSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M02S05")

	if point and point:isPass() and self:getUpSkillHeroSta() then
		return true
	end

	return false
end

function GuideSystem:getHeroGiftGivingSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local heroGalleryLockLevel = systemKeeper:getUnlockLevel("Hero_Gift")

	if heroGalleryLockLevel <= playerLevel then
		return true, heroGalleryLockLevel
	end

	return false, heroGalleryLockLevel
end

function GuideSystem:getHeroEquipWearSta()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local heroList = heroSystem:getHeroList():getHeros()
	local heroData = heroList.ZTXChang
	local equipId = heroData:getEquipIdByType(HeroEquipType.kWeapon)

	if not equipId then
		return true
	end

	return false
end

function GuideSystem:getHeroEquipLvUpSta()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local heroList = heroSystem:getHeroList():getHeros()
	local heroData = heroList.ZTXChang
	local equipId = heroData:getEquipIdByType(HeroEquipType.kWeapon)

	if equipId then
		local equipSystem = self:getInjector():getInstance("DevelopSystem"):getEquipSystem()
		local equip = equipSystem:getEquipById(equipId)

		if equip and equip:getLevel() == 1 then
			return true
		end
	end

	return false
end

function GuideSystem:getHeroEquipQualitySta()
	return true
end

function GuideSystem:getHeroEquipUpLvQualitySta()
	return false, 0
end

function GuideSystem:getHeroEquipUpStarSta()
	return false, 0
end

function GuideSystem:getChapterOneGetRewSta()
	if self:getPassStory1_2() == false then
		return true
	end

	local stageSystem = self:getInjector():getInstance(StageSystem)
	local chapterInfo = stageSystem:getMapByIndex(1, "NORMAL")
	local chapterConfig = stageSystem:getMapConfigByIndex(1, "NORMAL")

	if chapterConfig and chapterInfo then
		local curStarNum = chapterInfo:getCurrentStarCount() or 0
		local boxRewardList = stageSystem:boxReardToTable(chapterConfig.StarBoxReward)
		local reward = boxRewardList[1]

		if curStarNum >= reward.starNum and chapterInfo:getMapBoxState(reward.starNum) == StageBoxState.kCanReceive then
			return true
		end
	end

	return false
end

function GuideSystem:getArenaChallengeSta()
	return true
end

function GuideSystem:setArenaChallengeSta()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	guideAgent:save(ARENA_CHALLENGE_GUIDE_SIGN)
end

function GuideSystem:getArenaRewSta()
	return false
end

function GuideSystem:getArenaSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("Arena_System")

	if level <= playerLevel and (self:getArenaChallengeSta() or self:getArenaRewSta()) then
		return true, level
	end

	return false, level
end

function GuideSystem:getResearchExpSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("BlockSp_Exp")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getResearchIconSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("BlockSp_Gold")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getResearchCrystalSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("BlockSp_Crystal")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getPetRaceSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("KOF")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getClubSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("Club_System")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getChapterEliteSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("Elite_Block")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getExploreSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("Map_Explore")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getMasterEmblemLvUpSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local masterSystem = developSystem:getMasterSystem()
	local list = masterSystem:getEmblemList()

	if list and list[1] then
		local emblemData = list[1]

		if emblemData._level == 1 then
			return true
		end
	end

	return false
end

function GuideSystem:getMasterAuraLvUpSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local auraList = player:getMasterAura():getAuraData()
	local key = "ATK"

	if auraList and auraList[key] then
		local data = auraList[key]

		if data.Level == 1 then
			return true
		end
	end

	return false
end

function GuideSystem:getMasterEmblemAuraUpSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("Master_Auras")

	if level <= playerLevel and self:getMasterAuraLvUpSta() then
		return true, level
	end

	return false, level
end

function GuideSystem:getMazeSta()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local level = systemKeeper:getUnlockLevel("PansLabNormal")

	if level <= playerLevel then
		return true, level
	end

	return false, level
end

function GuideSystem:getVillageSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M03S04")

	if point and point:isPass() and self:getVillageGoldStorageSta() then
		return true
	end

	return false
end

function GuideSystem:getVillageGoldStorageSta()
	return false
end

function GuideSystem:getChapterOptionalSta(pointId)
	local contents = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Limit", "content")

	for k, v in pairs(contents) do
		if v == pointId then
			return true
		end
	end

	return false
end

function GuideSystem:checkELITEChapterUnlockSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local newMapChecker, isNewChapterPop = stageSystem:getNewMapUnlockIndex("ELITE")

	if newMapChecker < 1 then
		return true
	end

	return false
end

function GuideSystem:getAutoBattleButtonSta()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById("M03S04")

	if point and point:isPass() then
		return true
	end

	return false
end

function GuideSystem:checkRoomUnlockSta(roomName)
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)

	if buildingSystem:getRoomOpenSta(roomName) then
		return true
	end

	return false
end

function GuideSystem:checkVillageBuildingSta()
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)
	local roomId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_RoomId").content or ""
	local itemId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_ItemId1").content or ""
	local itemNum = 1

	if buildingSystem:getRoomOpenSta(roomId) then
		local room = buildingSystem:getRoom(roomId)

		if room then
			local num = room:getOwnNum(itemId)

			if num < itemNum then
				return true
			end
		end
	end

	return false
end

function GuideSystem:checkSta_ArenaTeamAttck()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local team = developSystem:getSpTeamByType(StageTeamType.ARENA_ATK)

	if team then
		local heros = team:getHeroes()

		if heros and #heros > 1 then
			return false
		end
	end

	return true
end

function GuideSystem:checkSta_ArenaTeamDef()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local team = developSystem:getSpTeamByType(StageTeamType.ARENA_DEF)

	if team then
		local heros = team:getHeroes()

		if heros and #heros > 1 then
			return false
		end
	end

	return true
end

function GuideSystem:checkSta_ArenaTeam()
	return self:checkSta_ArenaTeamAttck() or self:checkSta_ArenaTeamDef()
end

function GuideSystem:checkSta_ActivityToday()
	local monthSignInSystem = self:getInjector():getInstance(MonthSignInSystem)

	if not monthSignInSystem:todaySignInOver() then
		return true
	end

	return false
end

function GuideSystem:checkSta_ActivityEightDays()
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local flg = activitySystem:hasRedPointForActivity("EightDaysCheckIn")

	if flg then
		return true
	end

	return false
end

function GuideSystem:checkSta_Mail()
	return true
end

function GuideSystem:checkSta_Village2()
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)
	local roomId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_RoomId2").content or ""
	local itemId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_ItemId2").content or ""
	local itemNum = 1

	if buildingSystem:getRoomOpenSta(roomId) then
		local room = buildingSystem:getRoom(roomId)

		if room then
			local num = room:getOwnNum(itemId)

			if num < itemNum then
				return true
			end
		end
	end

	return false
end

function GuideSystem:checkSta_Village3()
	return true
end

function GuideSystem:checkSta_Village4()
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)
	local roomId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_RoomId4").content or ""
	local itemId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_ItemId4").content or ""
	local itemNum = 1

	if buildingSystem:getRoomOpenSta(roomId) then
		local room = buildingSystem:getRoom(roomId)

		if room then
			local num = room:getOwnNum(itemId)

			if num < itemNum then
				return true
			end
		end
	elseif buildingSystem:canUnlockRoom(roomId) then
		return true
	end

	return false
end

function GuideSystem:checkSta_Village5()
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)
	local roomId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_RoomId5").content or ""
	local itemId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_ItemId5").content or ""
	local itemNum = 1

	if buildingSystem:getRoomOpenSta(roomId) then
		local room = buildingSystem:getRoom(roomId)

		if room then
			local num = room:getOwnNum(itemId)

			if num < itemNum then
				return true
			end
		end
	end

	return false
end

function GuideSystem:checkSta_Village6()
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)
	local roomId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_RoomId4").content or ""
	local itemId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_ItemId4").content or ""

	if buildingSystem:getRoomOpenSta(roomId) then
		local room = buildingSystem:getRoom(roomId)

		if room then
			local items = room:getOwnList(itemId)

			if items and items[1] and items[1]:getLevel() == 1 then
				return true
			end
		end
	end

	return false
end

function GuideSystem:checkSta_Village7()
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)
	local roomId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_RoomId7").content or ""
	local itemId = ConfigReader:getRecordById("ConfigValue", "NewGuide_VillageBuilding_ItemId7").content or ""
	local itemNum = 1

	if buildingSystem:getRoomOpenSta(roomId) then
		local room = buildingSystem:getRoom(roomId)

		if room then
			local num = room:getOwnNum(itemId)

			if num < itemNum then
				return true
			end
		end
	end

	return false
end

function GuideSystem:checkSta_VillageCanUnlockRoom(roomId)
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)

	if not buildingSystem:getRoomOpenSta(roomId) and buildingSystem:canUnlockRoom(roomId) then
		return true
	end

	return false
end

function GuideSystem:runGuideByStage(inPointId)
	if GameConfigs.closeGuide then
		return false
	end

	if self:resetGuide() then
		return true
	end

	if self:checkGuideStageStory() then
		return true
	end

	if self:checkGuideStageNormal() then
		return true
	end

	if self:checkGuideStageElite() then
		return true
	end

	return false
end

function GuideSystem:isToHome(pointId)
	local guidePoints = {
		M02S04 = true,
		E01S01 = true
	}

	if guidePoints[pointId] then
		return false
	end

	return true
end

function GuideSystem:getBindGuideName(pointId)
	if not self._stageBindGuideName then
		self._stageBindGuideName = {}

		local playerGuide = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Open", "content") or {}

		for k, v in pairs(playerGuide) do
			self._stageBindGuideName[k] = v
		end
	end

	return self._stageBindGuideName[pointId]
end

function GuideSystem:checkGuideStageNormal()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local pointId = stageSystem:getLastPassStagePointId(StageType.kNormal)

	if not pointId then
		return
	end

	local guideName = self:getBindGuideName(pointId)

	if not guideName then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local guideSaved = guideAgent:isSaved(guideName)

	if not guideSaved and self:getGuideUnitState(guideName) then
		guideAgent:trigger(guideName, nil, nil)

		return true
	end
end

function GuideSystem:checkGuideStageElite()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local pointId = stageSystem:getLastPassStagePointId(StageType.kElite)

	if not pointId then
		return
	end

	local guideName = self:getBindGuideName(pointId)

	if not guideName then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local guideSaved = guideAgent:isSaved(guideName)

	if not guideSaved and self:getGuideUnitState(guideName) then
		guideAgent:trigger(guideName, nil, nil)

		return true
	end
end

function GuideSystem:checkGuideStageStory()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local pointId = stageSystem:getLastOpenStoryIndex(StageType.kNormal)

	if not pointId then
		return
	end

	local guideName = self:getBindGuideName(pointId)

	if not guideName then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local guideSaved = guideAgent:isSaved(guideName)

	if not guideSaved and self:getGuideUnitState(guideName) then
		guideAgent:trigger(guideName, nil, nil)

		return true
	end
end

function GuideSystem:getGuideUnitState(guideName)
	local stateFun = self["check_" .. guideName]

	if stateFun then
		local flg = stateFun(self)

		if flg == false then
			self:saveGuide(guideName)

			return false
		end
	end

	return true
end

function GuideSystem:resetGuide(guideName, callback)
	if DEBUG > 0 and GameConfigs.resetGuide then
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getGuideAgent()

		if guideName and string.len(guideName) > 3 then
			guideAgent:resetSaved(guideName, callback)
		elseif GameConfigs.resetGuide then
			guideName = GameConfigs.resetGuide

			if not guideAgent:isSaved(GameConfigs.resetGuide) then
				guideAgent:trigger(guideName, nil, nil)
			else
				guideAgent:resetSaved(guideName, function()
					guideAgent:trigger(guideName, nil, nil)
				end)
			end

			return true
		end
	end

	return false
end

function GuideSystem:saveGuide(guideName)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	guideAgent:save(guideName)
end

function GuideSystem:check_guide_Stage_Practice()
	return true
end

function GuideSystem:check_guide_Explore()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local mapKey = developSystem:getExplore():getCurPointId()

	if mapKey and #mapKey > 0 then
		return false
	end

	return true
end

function GuideSystem:check_guide_Hero_Quality()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local heroList = heroSystem:getHeroList():getHeros()
	local heroData = heroList.ZTXChang

	if heroData and heroData:getQuality() == 10 then
		return true
	end

	return false
end

function GuideSystem:check_guide_stageTask()
	local taskSystem = self:getInjector():getInstance(TaskSystem)
	local taskListModel = taskSystem:getTaskListModel()
	local mainTask = taskListModel:getStageMainTask()

	if mainTask then
		local index = mainTask:getSortId()

		if index <= 1 then
			return true
		end
	end

	return false
end
