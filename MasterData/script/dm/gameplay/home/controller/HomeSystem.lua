-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/controller/HomeSystem.lua

HomeSystem = class("HomeSystem", legs.Actor)

HomeSystem:has("_mailSystem", {
	is = "r"
}):injectWith("MailSystem")
HomeSystem:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
HomeSystem:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
HomeSystem:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
HomeSystem:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")
HomeSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HomeSystem:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
HomeSystem:has("_clubSystem", {
	is = "rw"
}):injectWith("ClubSystem")
HomeSystem:has("_shopSystem", {
	is = "rw"
}):injectWith("ShopSystem")
HomeSystem:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
HomeSystem:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
HomeSystem:has("_activitySystem", {
	is = "rw"
}):injectWith("ActivitySystem")
HomeSystem:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
HomeSystem:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
HomeSystem:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")
HomeSystem:has("_houseSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")
HomeSystem:has("_cooperateSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
HomeSystem:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
HomeSystem:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
HomeSystem:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
HomeSystem:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")
HomeSystem:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
HomeSystem:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
HomeSystem:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")
HomeSystem:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
HomeSystem:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
HomeSystem:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")
HomeSystem:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")
HomeSystem:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

function HomeSystem:initialize()
	super.initialize(self)
end

function HomeSystem:dispose()
	super.dispose(self)
end

function HomeSystem:chatRedPoint()
	return false
end

function HomeSystem:mailRedPoint()
	return self._mailSystem:queryRedPointState()
end

function HomeSystem:rankRedPoint()
	return self._rankSystem:getRewardRedPoint()
end

function HomeSystem:friendRedPoint()
	return self._friendSystem:queryRedPointState()
end

function HomeSystem:activityRedPoint()
	return self._activitySystem:getHomeRedPointSta()
end

function HomeSystem:firstRechargeRedPoint()
	local player = self._developSystem:getPlayer()
	local rechargeState = player:getFirstRecharge()

	return rechargeState == 1
end

function HomeSystem:arenaRedPoint()
	local unlock = self._systemKeeper:isUnlock("Arena_All")

	if not unlock then
		return false
	end

	return self._arenaSystem:checkAwardRed() or self._petRaceSystem:redPointShow() or self._cooperateSystem:redPointShow() or self._leadStageArenaSystem:checkShowRed() or self._arenaNewSystem:checkShowRed()
end

function HomeSystem:exploreRedPoint()
	return self._exploreSystem:checkIsShowRedPoint()
end

function HomeSystem:heroRedPoint()
	local heroSystem = self._developSystem:getHeroSystem()
	local pointFirstPassCheck1 = self._customDataSystem:getValue(PrefixType.kGlobal, "S02S02_FirstPassState", "false")
	local pointFirstPassCheck2 = self._customDataSystem:getValue(PrefixType.kGlobal, "M03S02_FirstPassState", "false")

	return pointFirstPassCheck1 == "true" or pointFirstPassCheck2 == "true" or heroSystem:checkIsShowRedPoint()
end

function HomeSystem:teamRedPoint()
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Group")

	if not unlock then
		return false
	end

	return self._stageSystem:checkIsShowRedPoint()
end

function HomeSystem:recruitRedPoint()
	local pointFirstPassCheck1 = self._customDataSystem:getValue(PrefixType.kGlobal, "M02S01_FirstPassState", "false")
	local pointFirstPassCheck2 = self._customDataSystem:getValue(PrefixType.kGlobal, "M03S04_FirstPassState", "false")

	return pointFirstPassCheck1 == "true" or pointFirstPassCheck2 == "true" or self._recruitSystem:checkIsShowRedPoint()
end

function HomeSystem:taskRedPoint()
	return self._taskSystem:checkIsShowRedPoint()
end

function HomeSystem:galleryRedPoint()
	return self._gallerySystem:checkIsShowRedPoint()
end

function HomeSystem:shopRedPoint()
	return self._shopSystem:getRedPoint()
end

function HomeSystem:bagRedPoint()
	return self._bagSystem:isBagRedPointShow()
end

function HomeSystem:challengeRedPoint()
	return self._spStageSystem:checkIsShowRedPoint() or self._stagePracticeSystem:checkAwardRed() or self._crusadeSystem:canCrusadeSweep() or self._dreamSystem:checkIsShowRedPoint() or self._houseSystem:checkIsShowRedPoint()
end

function HomeSystem:onMainChapterRedPoint()
	return self._stageSystem:hasHomeRedPoint()
end

function HomeSystem:masterRedPoint()
	local masterSystem = self._developSystem:getMasterSystem()

	return masterSystem:checkIsShowRedPoint()
end

function HomeSystem:onClubRedPoint()
	return self._clubSystem:hasHomeRedPoint() or self._clubSystem:hasHomeActivityRedPoint()
end

function HomeSystem:passRedPoint()
	return self._passSystem:checkRedPointForHome()
end

function HomeSystem:onBackFlowRedPoint()
	return self._activitySystem:activityReturnRedPointShow()
end

function HomeSystem:triggerNewerGuide()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local pointId = "S01S01"
	local storyLink = "story_choose"
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:setSkipCheckSave(true)

	local point = self._stageSystem:getPointById(pointId)
	local level = self._developSystem:getPlayer():getLevel()
	local complexNum = storyAgent:getGuideComplexNum()

	if level == 1 and point and not point:isPass() and complexNum == kGuideComplexityList.none then
		if GameConfigs.closeGuideChoose then
			self:checkGuide()
		else
			storyAgent:trigger(storyLink, nil, function()
				self:checkGuide()
			end)
		end
	else
		self:checkGuide()
	end
end

function HomeSystem:checkGuide()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local guideSaved = guideAgent:isSaved("GUIDE_SKIP_ALL")

	if guideSaved then
		GameConfigs.closeGuide = true

		return
	end

	local stageSystem = self._stageSystem
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local guideSystem = self:getInjector():getInstance(GuideSystem)
	local level = self._developSystem:getPlayer():getLevel()
	local scriptNames = {
		"guide_chapterOne1_4"
	}

	local function conditions(context)
		local function point1Cond()
			local point = stageSystem:getPointById("M01S01")

			if point and point:isPass() then
				return true
			end

			return false
		end

		local function point2Cond()
			local point = stageSystem:getPointById("M01S02")

			if point and point:isPass() then
				return true
			end

			return false
		end

		local function point3Cond()
			local point = stageSystem:getPointById("M01S03")

			if point and point:isPass() then
				return true
			end

			if point2Cond() == false then
				return true
			end

			return false
		end

		local function story2Cond()
			if guideSystem:getPassStory1_2() then
				return true
			end

			return false
		end

		local function recruitCond()
			if guideSystem:getRecruitHeroSta() == false then
				return true
			end

			return false
		end

		local function embattleCond()
			local team = self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL)

			if team:getHeroes()[2] then
				return true
			end

			return false
		end

		local function point4Cond()
			local point = stageSystem:getPointById("M01S04")

			if point and point:isPass() then
				return true
			end

			if point2Cond() == false then
				return true
			end

			return false
		end

		context:setGuideCond("guide_enter_stage", point2Cond)
		context:setGuideCond("guide_main_point_1_1", point1Cond)
		context:setGuideCond("guide_main_point_1_2", point2Cond)
		context:setGuideCond("guide_recruit_hero", recruitCond)
		context:setGuideCond("guide_main_point_1_3", point3Cond)
		context:setGuideCond("guide_main_story_2", story2Cond)
		context:setGuideCond("guide_main_embattle", embattleCond)
		context:setGuideCond("guide_main_point_1_4", point4Cond)
	end

	local function runGuide1to4()
		local guideSaved = guideAgent:isSaved(scriptNames)

		if not guideSaved then
			guideAgent:trigger(scriptNames, conditions, nil)
		end

		if not guideAgent:isGuiding() then
			guideSystem:runGuideByStage()
		end
	end

	local storyLink = "story01_1a"
	local pointId = "S01S01"
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:setSkipCheckSave(true)

	local point = stageSystem:getPointById(pointId)
	local level = developSystem:getPlayer():getLevel()

	if level == 1 and point and not point:isPass() then
		stageSystem:requestStoryPass(pointId, function()
			return
		end)
		storyAgent:trigger(storyLink, nil, function()
			runGuide1to4()
		end)
	else
		runGuide1to4()
	end
end

function HomeSystem:getBannerAct()
	local _table = self._activitySystem._bannerData
	local animName = {}
	local shopList = self._shopSystem:getPackageList()

	for _, bannerInfo in pairs(_table) do
		local bannerType = bannerInfo.Type

		if bannerType == ActivityBannerType.kPackageShop then
			local canBuyPackage = false
			local model

			for _, v in ipairs(shopList) do
				if v._id == bannerInfo.TypeId and v._leftCount > 0 then
					canBuyPackage = true
					model = v

					break
				end
			end

			if canBuyPackage then
				animName[#animName + 1] = {
					bannerInfo = bannerInfo,
					model = model
				}
			end
		elseif bannerType == ActivityBannerType.kActivity then
			local activityId = bannerInfo.TypeId

			if self._activitySystem:isActivityOpen(activityId) and not self._activitySystem:isActivityOver(activityId) then
				local bannerTime = bannerInfo.BannerTime
				local isOpen = true

				if bannerTime then
					local start = bannerTime.start[1]
					local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
					local mills = TimeUtil:timeByRemoteDate({
						year = y,
						month = mon,
						day = d,
						hour = h,
						min = m,
						sec = s
					})

					mills = mills * 1000
					isOpen = self._activitySystem:isActivityOpen(bannerInfo.TypeId, mills)
				end

				if isOpen then
					animName[#animName + 1] = {
						bannerInfo = bannerInfo,
						id = activityId
					}
				end
			end
		elseif bannerType == ActivityBannerType.kCooperateBoss and self._cooperateSystem:cooperateBossShow() then
			animName[#animName + 1] = {
				bannerInfo = bannerInfo
			}
		end
	end

	table.sort(animName, function(a, b)
		local aSortNum = a.bannerInfo.Sort
		local bSortNum = b.bannerInfo.Sort

		return aSortNum < bSortNum
	end)

	return animName, #animName
end

function HomeSystem:getWonderfulActData()
	local bannerConfig = self._activitySystem._bannerData
	local sortBanner = {}

	for k, v in pairs(bannerConfig) do
		if v.Important == ActivityBannerImportant.kIsImportant and v.Switch and CommonUtils.GetSwitch(v.Switch) then
			if ActivityBannerType.kActivity == v.Type then
				if self._activitySystem:isActivityOpen(v.TypeId) then
					table.insert(sortBanner, v)
				end
			elseif ActivityBannerType.kCooperateBoss == v.Type and self._cooperateSystem:cooperateBossShow() then
				table.insert(sortBanner, v)
			end
		end
	end

	if next(sortBanner) then
		table.sort(sortBanner, function(a, b)
			return a.Sort > b.Sort
		end)

		return sortBanner[1], sortBanner[math.random(1, #sortBanner)]
	end

	return nil
end

function HomeSystem:wonderfulActRedPointShow(bannerData)
	if ActivityBannerType.kActivity == bannerData.Type then
		return self._activitySystem:hasRedPointForActivity(bannerData.TypeId)
	end

	if ActivityBannerType.kCooperateBoss == bannerData.Type then
		return self._cooperateSystem:redPointShow()
	end

	return false
end

function HomeSystem:urlEnter(url)
	if url then
		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

		if not entry then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Function_Not_Open")
			}))
		else
			entry:response(context, params)
		end
	end
end

function HomeSystem:getActivityCalenderBubble(activityBubbles)
	local bubbles = {}

	if activityBubbles and #activityBubbles > 0 then
		for i = 1, #activityBubbles do
			table.insert(bubbles, activityBubbles[i])
		end
	end

	local staticBubbles = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MainPage_Bubble", "content")

	for i = 1, #staticBubbles do
		table.insert(bubbles, staticBubbles[i])
	end

	return bubbles[math.random(1, #staticBubbles)]
end

function HomeSystem:getHomeBackgroundList()
	local config = ConfigReader:getDataTable("HomeBackground")
	local player = self._developSystem:getPlayer()
	local background = player:getBackground()
	local list = {}

	for id, v in pairs(config) do
		if v.Information then
			if background[id] then
				list[#list + 1] = v
			end
		elseif v.Unlook == 1 then
			list[#list + 1] = v
		end
	end

	table.sort(list, function(a, b)
		return a.Sort < b.Sort
	end)

	return list
end

function HomeSystem:getNewArenaRecordVis()
	return self._arenaNewSystem:getNewArenaRecordVis()
end

function HomeSystem:enterNewArenaRecord(state)
	self._arenaNewSystem:enterNewArenaRecord(state)
end

function HomeSystem:getBordHeroPos(heroId)
	local playerId = self:getDevelopSystem():getPlayer():getRid()

	if not cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.KSetBoardMovePos .. heroId) then
		local info = ""

		info = info == "" and {
			0,
			0,
			1
		} or string.split(info, "_")

		return info
	end
end

function HomeSystem:setBordHeroPos(heroId, posX, posY, scale)
	local playerId = self:getDevelopSystem():getPlayer():getRid()
	local str = posX .. "_" .. posY .. "_" .. scale

	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.KSetBoardMovePos .. heroId, str)
end
