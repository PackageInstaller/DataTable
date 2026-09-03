-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/StoryContext.lua

module("story", package.seeall)

StoryContext = class("StoryContext")

StoryContext:has("_agent", {
	is = "rw"
})
StoryContext:has("_scene", {
	is = "rw"
})
StoryContext:has("_userData", {
	is = "rw"
})
StoryContext:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
StoryContext:has("_currentSceneMediator", {
	is = "r"
}):injectWith("BaseSceneMediator", "activeScene")
StoryContext:has("_complexNum", {
	is = "rw"
})

function StoryContext:initialize()
	super.initialize(self)

	self._variables = {
		["$"] = self
	}
	self._userData = {}
	self._condFunc = {}
end

function StoryContext:getDirector()
	return self._agent and self._agent:getDirector()
end

function StoryContext:getVariables()
	return self._variables
end

function StoryContext:setVar(name, value)
	self._variables[name] = value
end

function StoryContext:getVar(name)
	return self._variables[name]
end

function StoryContext:hasNewSystem(type)
	if type == UnlockAnimView.kHome and HIDE_HOME_POP then
		return false
	end

	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local systems = systemKeeper:getUnlockSystemsByType(type)

	if systems then
		return true
	end

	return false
end

function StoryContext:getGuideComplexNum()
	return self._agent:getGuideComplexNum()
end

function StoryContext:initGeneralVariables()
	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local stageSystem = self:getInjector():getInstance("StageSystem")
	local level = developSystem:getPlayer():getLevel()

	self._variables.level = level

	if self._variables.translate == nil then
		self._variables.translate = {}
	end

	local translate = self._variables.translate

	translate.level = level
	translate.stage = stageSystem:getMainPassNum()
end

function StoryContext:isSaved(scriptname)
	return self._agent:isSaved(scriptname)
end

function StoryContext:save(scriptname)
	self._agent:save(scriptname)
end

function StoryContext:setGuideCond(id, condFunc)
	self._condFunc[id] = condFunc
end

function StoryContext:getCondResult(id)
	local func = self._condFunc[id]

	if func then
		return not func()
	end

	return true
end

function StoryContext:getCurViewName()
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")

	return (scene:getTopViewName())
end

function StoryContext:isPlayerLevelUp()
	local developSystem = self:getInjector():getInstance(DevelopSystem)

	return developSystem:getPlayerLvUpViewShowSta()
end

function StoryContext:getMasterUpStar()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getMasterUpStar()
end

function StoryContext:getMasterUpSkill()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getMasterUpSkill()
end

function StoryContext:getUpStarHeroSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getUpStarHeroSta()
end

function StoryContext:getUpSkillHeroSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getUpSkillHeroSta()
end

function StoryContext:getHeroEquipWearSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getHeroEquipWearSta()
end

function StoryContext:getHeroEquipLvUpSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getHeroEquipLvUpSta()
end

function StoryContext:getHeroEquipQualitySta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getHeroEquipQualitySta()
end

function StoryContext:getChapterOneGetRewSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getChapterOneGetRewSta()
end

function StoryContext:getArenaChallengeSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getArenaChallengeSta()
end

function StoryContext:getArenaRewSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getArenaRewSta()
end

function StoryContext:getMasterAuraLvUpSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getMasterAuraLvUpSta()
end

function StoryContext:getMasterEmblemLvUpSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:getMasterEmblemLvUpSta()
end

function StoryContext:checkELITEChapterUnlockSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:checkELITEChapterUnlockSta()
end

function StoryContext:downloadRes()
	local settingSystem = self:getInjector():getInstance("SettingSystem")

	return (settingSystem:downloadPackage())
end

function StoryContext:showNewSystemUnlock(systemId, statisticPoint)
	local key = "GUIDE_NEWSYSTEM_UNLOCK_" .. systemId

	if self:isSaved(key) then
		return false
	end

	local config = ConfigReader:getRecordById("UnlockSystem", systemId)

	if config and config.UnlockAnima ~= "HOME" then
		return false
	end

	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topViewName = scene:getTopViewName()
	local topView = scene:getTopView()

	if topViewName == "homeView" and topView then
		local systemData = config
		local homeMediator = scene:getMediatorMap():retrieveMediator(topView)

		if homeMediator then
			local targetNode = homeMediator:getNewSyatemTarget(systemData)
			local targetPos = cc.p(0, 0)
			local view = self:getInjector():getInstance("NewSystemView")

			homeMediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				clearSta = 2,
				targetPos = (targetNode or nil) and targetNode:getParent():convertToWorldSpace(cc.p(targetNode:getPosition())),
				systemData = systemData,
				type = UnlockAnimView.kHome
			}))
			self:save(key)

			if statisticPoint then
				StatisticSystem:send({
					type = "loginpoint",
					point = statisticPoint
				})
			end

			return true
		end
	end

	return false
end

function StoryContext:villageToHome()
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local eventDispatcher = self:getEventDispatcher()
	local topView = scene:getTopView()
	local homeMediator = scene:getMediatorMap():retrieveMediator(topView)

	if homeMediator and homeMediator._viewOnHome == false then
		homeMediator:onMenuStateChange()

		return true
	end

	return false
end

function StoryContext:giudeVillageLookAt(posName)
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topViewName = scene:getTopViewName()

	if topViewName == "homeView" then
		local topView = scene:getTopView()
		local homeMediator = topView.mediator
		local villageMediator = homeMediator._villageMediator

		if villageMediator then
			if posName == "shopBtn" then
				villageMediator:setGuideLookAt()
			end

			return true
		end
	end

	return false
end

function StoryContext:checkRoomUnlockSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:checkRoomUnlockSta()
end

function StoryContext:checkStageTaskSta()
	local guideSystem = self:getInjector():getInstance(GuideSystem)

	return guideSystem:check_guide_stageTask()
end

function StoryContext:checkStageArenaOpen()
	local system = self:getInjector():getInstance(LeadStageArenaSystem)

	return system:stageArenaOpen()
end

function StoryContext:checkStageArenaState()
	local system = self:getInjector():getInstance(LeadStageArenaSystem)

	return system:stageArenaState()
end

function StoryContext:checkVillageBuildingSta()
	local GuideSystem = self:getInjector():getInstance(GuideSystem)

	return GuideSystem:checkVillageBuildingSta()
end

function StoryContext:checkGuideSta(funName, args)
	local guideSystem = self:getInjector():getInstance(GuideSystem)
	local fun = guideSystem["checkSta_" .. funName]

	assert(fun, "checkGuideSta fun is nil = " .. "checkSta_" .. funName)

	return fun(guideSystem, args)
end

function StoryContext:checkPointIsNotPass(pointId)
	local GuideSystem = self:getInjector():getInstance(GuideSystem)

	return GuideSystem:checkPointIsNotPass(pointId)
end

function StoryContext:checkComplexityNum(complexityNum)
	local GuideSystem = self:getInjector():getInstance(GuideSystem)

	return GuideSystem:checkComplexityNum(complexityNum)
end

function StoryContext:gotoStory(scriptname, complexityNum)
	if complexityNum and self:checkComplexityNum(complexityNum) == false then
		return false
	end

	local storyDirector = self:getDirector()
	local storyAgent = storyDirector:getStoryAgent()
	local succ, err = pcall(require, "stories." .. scriptname)

	if not succ then
		return false
	end

	storyAgent:setSkipCheckSave(true)
	storyAgent:trigger(scriptname, nil, function()
		storyAgent:setSkipCheckSave(false)
		storyDirector:notifyWaiting("goto_story_end")
	end)

	return true
end

function StoryContext:isPlayNewUnlockChapter()
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local newMapChecker, isNewChapterPop = stageSystem:getNewMapUnlockIndex(StageType.kNormal)

	return newMapChecker < 2
end

function StoryContext:playHomeVedioPV(strId)
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topViewName = scene:getTopViewName()
	local topView = scene:getTopView()

	if topViewName == "homeView" and topView then
		local homeMediator = scene:getMediatorMap():retrieveMediator(topView)

		if homeMediator then
			homeMediator:playVedioSprite(Strings:get(strId))
			StatisticSystem:send({
				point = "guide_main_play_logo_pv",
				type = "loginpoint"
			})

			return true
		end
	end

	return false
end

function StoryContext:sendStoryStatistic(stepName)
	local storyDirector = self:getDirector()
	local storyAgent = storyDirector:getStoryAgent()
	local scriptName = storyAgent:getCurrentScriptName()

	storyAgent:sendStoryStatistic(scriptName, stepName)
end

function StoryContext:openStoryStatistic(autoStepBase)
	local storyDirector = self:getDirector()
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:openStoryStatistic(autoStepBase)
end
