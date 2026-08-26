-- chunkname: @modules/logic/dungeon/controller/DungeonController.lua

module("modules.logic.dungeon.controller.DungeonController", package.seeall)

local DungeonController = class("DungeonController", BaseController)

function DungeonController:onInit()
	return
end

function DungeonController:onInitFinish()
	return
end

function DungeonController:addConstEvents()
	self.registerCallback(self, DungeonEvent.OnFocusEpisode, self._onFocusEpisode, self)
	self.registerCallback(self, DungeonEvent.OnSetResScrollPos, self._onSetResScrollPos, self)
	self.registerCallback(self, DungeonEvent.OnGuideUnlockNewChapter, self._onGuideUnlockNewChapter, self)
	self.registerCallback(self, DungeonEvent.OnGuideFocusNormalChapter, self._onGuideFocusNormalChapter, self)
	self.registerCallback(self, DungeonEvent.OnHideCircleMv, self._onHideCircleMv, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._pushEndFight, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self, LuaEventSystem.Low)
end

function DungeonController:_onOpenFullViewFinish(viewName)
	if viewName ~= ViewName.StoryBackgroundView then
		return
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.DungeonMapLevelView)

	if not viewContainer then
		return
	end

	if viewContainer._isVisible then
		local nameListStr = ""
		local openViewNameList = ViewMgr.instance:getOpenViewNameList()

		for i = #openViewNameList, 1, -1 do
			local oneViewName = openViewNameList[i]

			nameListStr = string.format("%s#%s", nameListStr, oneViewName)

			if viewName == oneViewName then
				break
			end
		end

		logError(string.format("剧情没有隐藏副本界面 list:%s", nameListStr))
	end

	self:_hideView(ViewName.DungeonMapLevelView)
	self:_hideView(ViewName.DungeonMapView)
	self:_hideView(ViewName.DungeonView)
	self:_hideView(ViewName.MainView)
end

function DungeonController:_hideView(viewName)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if viewContainer then
		viewContainer:setVisibleInternal(false)
	end
end

function DungeonController:_pushEndFight()
	local fightRecordMO = FightModel.instance:getRecordMO()

	if not fightRecordMO or fightRecordMO.fightResult == FightEnum.FightResult.Succ then
		return
	end

	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId
	local episodeCO = episodeId and lua_episode.configDict[episodeId]

	if not episodeCO then
		return
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeCO.chapterId)

	if chapterConfig.type ~= DungeonEnum.ChapterType.Normal then
		return
	end

	if DungeonModel.instance:hasPassLevel(episodeId) then
		return
	end

	local key = PlayerPrefsKey.DungeonFailure .. PlayerModel.instance:getPlayinfo().userId .. episodeId
	local value = PlayerPrefsHelper.getNumber(key, 0)

	PlayerPrefsHelper.setNumber(key, value + 1)
end

function DungeonController:reInit()
	return
end

function DungeonController:OnOpenNormalMapView()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenNormalMapView)
end

function DungeonController:_onDailyRefresh()
	DungeonRpc.instance:sendGetDungeonRequest()
end

function DungeonController:_onHideCircleMv()
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function DungeonController:_onGuideFocusNormalChapter(id)
	local chapterId = tonumber(id)

	if chapterId then
		DungeonMainStoryModel.instance:saveClickChapterId(chapterId)
	end
end

function DungeonController:_onGuideUnlockNewChapter(id)
	id = tonumber(id)

	if id ~= 101 then
		DungeonModel.instance.unlockNewChapterId = id
		DungeonModel.instance.chapterTriggerNewChapter = false

		return
	end

	local unlockEffectStr = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ChapterUnlockEffect)

	if not string.nilorempty(unlockEffectStr) then
		TaskDispatcher.runDelay(function()
			DungeonController.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
		end, nil, 0)

		return
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ChapterUnlockEffect, "1")

	DungeonModel.instance.chapterTriggerNewChapter = true
	DungeonModel.instance.unlockNewChapterId = id
end

function DungeonController:_onSetResScrollPos(x)
	DungeonModel.instance.resScrollPosX = x
end

function DungeonController:_onFocusEpisode(id)
	DungeonModel.instance:setLastSendEpisodeId(tonumber(id))
end

function DungeonController:enterDungeonView(initModel, fromMainView, advPlayJumpType)
	if initModel then
		DungeonModel.instance:initModel()
	end

	local params = {
		fromMainView = fromMainView,
		advPlayJumpType = advPlayJumpType
	}

	return self:openDungeonView(params, false)
end

function DungeonController:jumpDungeon(param)
	local remainViewNames = {}

	if not param then
		return remainViewNames
	end

	local chapterType, chapterId, episodeId = param.chapterType, param.chapterId, param.episodeId

	DungeonModel.instance.lastSendEpisodeId = episodeId

	if not chapterType then
		return remainViewNames
	end

	local hard

	if chapterType == DungeonEnum.ChapterType.Hard then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeConfig then
			logError("不能直接跳困难章节,可以配合困难关卡跳转")

			return remainViewNames
		end

		local normalEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)

		if not normalEpisodeConfig then
			return remainViewNames
		end

		local normalChapterConfig = DungeonConfig.instance:getChapterCO(normalEpisodeConfig.chapterId)

		episodeId = normalEpisodeConfig.id
		chapterId = normalEpisodeConfig.chapterId
		chapterType = normalChapterConfig.type
		hard = true
	end

	if chapterType == DungeonEnum.ChapterType.Newbie then
		logError("不能跳新手章节")

		return remainViewNames
	end

	DungeonModel.instance:changeCategory(chapterType)

	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterConfig then
		table.insert(remainViewNames, ViewName.DungeonView)
		self:openDungeonView()

		return remainViewNames
	end

	if DungeonModel.instance:chapterIsLock(chapterId) then
		table.insert(remainViewNames, ViewName.DungeonView)
		self:openDungeonView(nil)

		return remainViewNames
	end

	local dungeonChapterViewParam = {}

	dungeonChapterViewParam.chapterId = chapterId
	dungeonChapterViewParam.episodeId = episodeId

	table.insert(remainViewNames, self:getDungeonChapterViewName(chapterId))

	if episodeId then
		::label_17_0::

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeConfig then
			self:openDungeonChapterView(dungeonChapterViewParam)

			return remainViewNames
		end

		DungeonModel.instance.curLookChapterId = chapterId

		local moduleRemainViewName = self:jumpChapterAndLevel(chapterId, episodeConfig, dungeonChapterViewParam, hard, param.isNoShowMapLevel)

		if moduleRemainViewName then
			table.insert(remainViewNames, moduleRemainViewName)
		end

		return remainViewNames
	end
end

function DungeonController:jumpChapterAndLevel(chapterId, episodeConfig, dungeonChapterViewParam, hard, isNoShowMapLevel)
	local moduleRemainViewName = self:generateLevelViewParam(episodeConfig, hard, true)
	local openViewParamList = {}
	local openChapterViewParam = {}

	dungeonChapterViewParam = dungeonChapterViewParam or {}
	dungeonChapterViewParam.notOpenHelp = true
	DungeonModel.instance.jumpEpisodeId = dungeonChapterViewParam.episodeId

	function openChapterViewParam.openFunction()
		self:openDungeonChapterView(dungeonChapterViewParam, true)
	end

	openChapterViewParam.waitOpenViewName = self:getDungeonChapterViewName(chapterId)

	table.insert(openViewParamList, openChapterViewParam)

	if not isNoShowMapLevel then
		local openLevelViewParam = {}

		function openLevelViewParam.openFunction()
			self:generateLevelViewParam(episodeConfig, hard)
		end

		table.insert(openViewParamList, openLevelViewParam)
	end

	module_views_preloader.DungeonChapterAndLevelView(function()
		OpenMultiView.openView(openViewParamList)
	end, chapterId, moduleRemainViewName)

	return moduleRemainViewName
end

function DungeonController:generateLevelViewParam(episodeConfig, hard, getViewName)
	local remainViewName
	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeConfig.id) or nil

	if not episodeInfo then
		return remainViewName
	end

	local chapterIndex, _ = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)
	local levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(DungeonModel.instance.curLookChapterId, episodeConfig.id)

	remainViewName = self:enterLevelView({
		episodeConfig,
		episodeInfo,
		chapterIndex,
		levelIndex,
		hard,
		true
	}, getViewName)

	return remainViewName
end

function DungeonController:enterLevelView(param, getViewName)
	local remainViewName
	local config = param[1]

	if not config then
		logError("找不到配置")

		return remainViewName
	end

	if DungeonModel.isBattleEpisode(config) then
		if not getViewName then
			DungeonController.instance:openDungeonLevelView(param)
		end

		remainViewName = self:getDungeonLevelViewName(config.chapterId)
	elseif config.type == DungeonEnum.EpisodeType.Story then
		if not getViewName then
			DungeonController.instance:openDungeonLevelView(param)
		end

		remainViewName = self:getDungeonLevelViewName(config.chapterId)
	elseif config.type == DungeonEnum.EpisodeType.Decrypt and (getViewName or true) then
		remainViewName = ViewName.DungeonPuzzleChangeColorView
	end

	return remainViewName
end

function DungeonController:canJumpDungeonType(jumpChapterType)
	local chapterTypeOpen = true
	local chapterType = DungeonEnum.ChapterType.Normal

	if jumpChapterType == JumpEnum.DungeonChapterType.Gold then
		chapterType = DungeonEnum.ChapterType.Gold
		chapterTypeOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon)
	elseif jumpChapterType == JumpEnum.DungeonChapterType.Resource then
		chapterType = DungeonEnum.ChapterType.Break
		chapterTypeOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon)
	elseif jumpChapterType == JumpEnum.DungeonChapterType.WeekWalk then
		chapterType = DungeonEnum.ChapterType.WeekWalk
		chapterTypeOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk)
	elseif jumpChapterType == JumpEnum.DungeonChapterType.Explore then
		chapterType = DungeonEnum.ChapterType.Explore
		chapterTypeOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore)
	elseif jumpChapterType == JumpEnum.DungeonChapterType.AdvPlay then
		local isExploreOpen = ExploreSimpleModel.instance:isShowExplore()
		local isSurvivalOpen = SurvivalController.instance:isOpenSurvival()

		return isExploreOpen or isSurvivalOpen
	end

	if chapterTypeOpen and DungeonModel.instance:getChapterListOpenTimeValid(chapterType) then
		return true
	end

	return false
end

function DungeonController:canJumpDungeonChapter(chapterId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterConfig then
		return false
	end

	local chapterType = chapterConfig.type
	local jumpChapterType = JumpEnum.DungeonChapterType.Story
	local chapterOpen = true

	if chapterType == DungeonEnum.ChapterType.Gold or chapterType == DungeonEnum.ChapterType.Exp or chapterType == DungeonEnum.ChapterType.Equip then
		jumpChapterType = JumpEnum.DungeonChapterType.Gold

		if chapterType == DungeonEnum.ChapterType.Gold then
			chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)
		elseif chapterType == DungeonEnum.ChapterType.Exp then
			chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)
		elseif chapterType == DungeonEnum.ChapterType.Equip then
			chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)
		elseif chapterType == DungeonEnum.ChapterType.Buildings then
			chapterOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)
		end
	elseif chapterType == DungeonEnum.ChapterType.Break then
		jumpChapterType = JumpEnum.DungeonChapterType.Resource
	end

	local chapterTypeOpen = self:canJumpDungeonType(jumpChapterType)

	if chapterTypeOpen and chapterOpen and not DungeonModel.instance:chapterIsLock(chapterId) and DungeonModel.instance:getChapterOpenTimeValid(chapterConfig) then
		return true
	end

	return false
end

function DungeonController:openDungeonEquipEntryView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonEquipEntryView, param, isImmediate)

	return ViewName.DungeonEquipEntryView
end

function DungeonController:openDungeonView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonView, param, isImmediate)

	return ViewName.DungeonView
end

function DungeonController:openDungeonMapTaskView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonMapTaskView, param, isImmediate)

	return ViewName.DungeonMapTaskView
end

function DungeonController:openDungeonChapterView(param, isImmediate)
	if param and param.chapterId then
		DungeonModel.instance.curLookChapterId = param.chapterId
	end

	local chapterCfg = DungeonConfig.instance:getChapterCO(param.chapterId)

	if chapterCfg.type == DungeonEnum.ChapterType.WeekWalk then
		WeekWalkController.instance:openWeekWalkView(param, isImmediate)

		return ViewName.WeekWalkView
	elseif chapterCfg.type == DungeonEnum.ChapterType.WeekWalk_2 then
		WeekWalk_2Controller.instance:openWeekWalk_2HeartView(param, isImmediate)

		return ViewName.WeekWalk_2HeartView
	elseif chapterCfg.type == DungeonEnum.ChapterType.Season or chapterCfg.type == DungeonEnum.ChapterType.SeasonRetail or chapterCfg.type == DungeonEnum.ChapterType.SeasonSpecial then
		Activity104Controller.instance:openSeasonMainView()

		return ViewName.SeasonMainView
	elseif chapterCfg.type == DungeonEnum.ChapterType.Season123 or chapterCfg.type == DungeonEnum.ChapterType.Season123Retail then
		Season123Controller.instance:openMainViewFromFightScene()

		return Season123Controller.instance:getEpisodeListViewName()
	elseif chapterCfg.id == HeroInvitationEnum.ChapterId then
		self._lastChapterId = param.chapterId

		DungeonModel.instance:changeCategory(chapterCfg.type, false)
		HeroInvitationRpc.instance:sendGetHeroInvitationInfoRequest()
		ViewMgr.instance:openView(ViewName.HeroInvitationDungeonMapView, param, isImmediate)

		return ViewName.HeroInvitationDungeonMapView
	end

	self._lastChapterId = param.chapterId

	if param.chapterId and not param.episodeId then
		param.episodeId = CharacterRecommedModel.instance:getChapterTradeEpisodeId(param.chapterId)
	end

	DungeonModel.instance:changeCategory(chapterCfg.type, false)
	ViewMgr.instance:openView(ViewName.DungeonMapView, param, isImmediate)

	return ViewName.DungeonMapView
end

function DungeonController:getDungeonChapterViewName(chapterId)
	if chapterId == HeroInvitationEnum.ChapterId then
		return ViewName.HeroInvitationDungeonMapView
	end

	return ViewName.DungeonMapView
end

function DungeonController:getDungeonLevelViewName(chapterId)
	return ViewName.DungeonMapLevelView
end

function DungeonController:openDungeonCumulativeRewardsView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonCumulativeRewardsView, param, isImmediate)
end

function DungeonController:openDungeonLevelView(param, isImmediate)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowDungeonMapLevelView) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.SkipShowDungeonMapLevelView, nil)

		return
	end

	local config = param[1]

	DungeonModel.instance.curLookEpisodeId = config.id

	ViewMgr.instance:openView(ViewName.DungeonMapLevelView, param, isImmediate)
end

function DungeonController:openDungeonMonsterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonMonsterView, param, isImmediate)
end

function DungeonController:openDungeonRewardView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonRewardView, param, isImmediate)
end

function DungeonController:openDungeonElementRewardView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonElementRewardView, param, isImmediate)
end

function DungeonController:openDungeonStoryView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.DungeonStoryView, param, isImmediate)
end

function DungeonController:openDungeonCumulativeRewardsTipsView(param, isImmediate)
	local episodeList, elementList = DungeonCumulativeRewardsTipsView.getEpisodeList()

	if #episodeList == 0 and #elementList == 0 then
		GameFacade.showToast(ToastEnum.RewardPointAllCollected)

		return
	end

	ViewMgr.instance:openView(ViewName.DungeonCumulativeRewardsTipsView, {
		episodeList = episodeList,
		elementList = elementList
	}, isImmediate)
end

function DungeonController:onStartLevelOrStoryChange()
	DungeonModel.instance:startCheckUnlockChapter()
	self:_onStartCheckUnlockContent()
end

function DungeonController:onEndLevelOrStoryChange()
	DungeonModel.instance:endCheckUnlockChapter()
	self:_onEndCheckUnlockContent()
end

function DungeonController:_onStartCheckUnlockContent()
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	self._hasAllPass = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)
end

function DungeonController:_onEndCheckUnlockContent()
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local allPass = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)

	if allPass and allPass ~= self._hasAllPass then
		DungeonController.instance:showUnlockContentToast(DungeonModel.instance.curSendEpisodeId)
	end
end

function DungeonController:showUnlockContentToast(episodeId)
	local list = DungeonChapterUnlockItem.getUnlockContentList(episodeId, true)

	for i, v in ipairs(list) do
		local chapterCo = DungeonConfig.instance:getChapterCO(lua_episode.configDict[episodeId].chapterId)

		if chapterCo.type ~= DungeonEnum.ChapterType.TeachNote then
			GameFacade.showToast(ToastEnum.IconId, v)
		end
	end
end

function DungeonController:needShowDungeonView()
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local teachingNeedOpenView = TeachingModel.instance:getNeedOpenView()

	if teachingNeedOpenView then
		DungeonModel.instance.curSendEpisodeId = nil

		return
	end

	local co = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if co then
		local chapterCO = DungeonConfig.instance:getChapterCO(co.chapterId)

		if chapterCO and chapterCO.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightBackSkipDungeonView) then
			DungeonModel.instance.curSendEpisodeId = nil

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightBackSkipDungeonView, nil)

			return
		end

		if chapterCO.type == DungeonEnum.ChapterType.DreamTailNormal or chapterCO.type == DungeonEnum.ChapterType.DreamTailHard then
			return true
		end

		if TeachNoteModel.instance:isJumpEnter() then
			DungeonModel.instance.curSendEpisodeId = nil

			return
		end

		if co.type == DungeonEnum.EpisodeType.Dog then
			return
		end

		if co.type == DungeonEnum.EpisodeType.RoleStoryChallenge and not RoleStoryModel.instance:checkActStoryOpen() then
			return
		end

		return true
	end
end

function DungeonController:enterTeachNote(episodeId)
	if not episodeId then
		return nil
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return nil
	end

	local chapterCO = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if chapterCO.type ~= DungeonEnum.ChapterType.TeachNote then
		return nil
	end

	if not TeachNoteModel.instance:isTeachNoteEnterFight() then
		return
	else
		if TeachNoteModel.instance:isDetailEnter() and DungeonModel.instance:hasPassLevel(episodeId) then
			return
		end

		DungeonModel.instance.curLookChapterId = episodeConfig.chapterId
	end

	self:enterDungeonView(true)

	if TeachNoteModel.instance:isTeachNoteChapter(DungeonModel.instance.curLookChapterId) then
		DungeonModel.instance.curSendEpisodeId = DungeonModel.instance.curLookEpisodeIdId

		if TeachNoteModel.instance:isTeachNoteEnterFight() then
			self:openDungeonChapterView({
				chapterId = self._lastChapterId
			}, true)

			if TeachNoteModel.instance:isDetailEnter() then
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteDetailView(episodeId)
			else
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteView(episodeId)
			end
		else
			self._lastChapterId = self._lastChapterId or 101

			return self:openDungeonChapterView({
				chapterId = self._lastChapterId
			}, true)
		end
	else
		return self:openDungeonChapterView({
			chapterId = DungeonModel.instance.curLookChapterId
		}, true)
	end
end

function DungeonController:enterSpecialEquipEpisode(episodeId)
	if not episodeId then
		return nil
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return nil
	end

	if episodeConfig.type ~= DungeonEnum.EpisodeType.SpecialEquip then
		return nil
	end

	local chapterId = DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId()
	local chapterCO = DungeonConfig.instance:getChapterCO(chapterId)
	local type = chapterCO.type

	DungeonModel.instance:changeCategory(type, true)

	local viewName = self:enterDungeonView()

	if DungeonModel.instance:getChapterOpenTimeValid(chapterCO) then
		viewName = self:openDungeonChapterView({
			chapterId = chapterId
		}, true)

		if DungeonMapModel.instance:isUnlockSpChapter(episodeConfig.chapterId) then
			viewName = self:openDungeonEquipEntryView(episodeConfig.chapterId)
		end
	end

	return viewName
end

function DungeonController:enterVerisonActivity(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return nil
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.Meilanni then
		if MeilanniController.instance:activityIsEnd() then
			ViewMgr.instance:openView(ViewName.MainView)

			return ViewName.MainView
		end

		ViewMgr.instance:openView(ViewName.MainView)
		PermanentController.instance:jump2Activity(VersionActivityEnum.ActivityId.Act105)
		MeilanniController.instance:immediateOpenMeilanniMainView()
		MeilanniController.instance:openMeilanniView()

		return ViewName.MeilanniView
	end
end

function DungeonController:enterRoleStoryChallenge(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return nil
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
		RoleStoryController.instance:openRoleStoryDispatchMainView({
			1
		})

		return ViewName.RoleStoryDispatchMainView
	end

	local chapterCO = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if chapterCO.type == DungeonEnum.ChapterType.RoleStory then
		local storyId = RoleStoryConfig.instance:getStoryIdByChapterId(episodeConfig.chapterId)

		if not RoleStoryModel.instance:isInResident(storyId) then
			RoleStoryController.instance:openRoleStoryDispatchMainView({
				clickItem = true
			})

			return ViewName.DungeonMapView
		end
	end
end

function DungeonController:showDungeonView()
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local curSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.curSendEpisodeId = nil

	local viewName = self:enterSpecialEquipEpisode(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterTeachNote(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterVerisonActivity(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterRoleStoryChallenge(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterFairyLandView(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterBossStoryView(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterTowerView(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterTowerComposeView(curSendEpisodeId)

	if viewName then
		return viewName
	end

	viewName = self:enterAbyssView(curSendEpisodeId)

	if viewName then
		return viewName
	end

	if curSendEpisodeId then
		::label_49_0::

		local elementEpisodeId = DungeonConfig.instance:getElementEpisode(curSendEpisodeId)
		local isElementEpisode = false

		if elementEpisodeId then
			DungeonMapModel.instance.lastElementBattleId = curSendEpisodeId
			curSendEpisodeId = elementEpisodeId
			isElementEpisode = true
		end

		DungeonModel.instance.lastSendEpisodeId = curSendEpisodeId

		local co = DungeonConfig.instance:getEpisodeCO(curSendEpisodeId)

		if co then
			local chapterCO = DungeonConfig.instance:getChapterCO(co.chapterId)

			if chapterCO and chapterCO.type == DungeonEnum.ChapterType.Newbie then
				return
			end

			if chapterCO.type == DungeonEnum.ChapterType.Explore then
				return self:enterDungeonView()
			end

			local type = chapterCO.type

			if type == DungeonEnum.ChapterType.Hard then
				type = DungeonEnum.ChapterType.Normal
			end

			DungeonModel.instance:changeCategory(type, true)

			viewName = self:enterDungeonView()

			if DungeonModel.instance:getChapterOpenTimeValid(chapterCO) then
				viewName = self:openDungeonChapterView({
					chapterId = chapterCO.id
				}, true)

				if DungeonModel.instance.curSendEpisodePass or GuideController.instance:isGuiding() then
					-- block empty
				elseif not isElementEpisode and self:_showLevelView(type) then
					viewName = DungeonController.instance:generateLevelViewParam(co, nil)
				end
			end

			return viewName
		end
	end
end

function DungeonController:_showLevelView(chapterType)
	return chapterType ~= DungeonEnum.ChapterType.WeekWalk and chapterType ~= DungeonEnum.ChapterType.Season and chapterType ~= DungeonEnum.ChapterType.WeekWalk_2
end

function DungeonController:onReceiveEndDungeonReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local newMsg = {}

	newMsg.dataList = msg.firstBonus

	if self:isStoryDungeonType(msg.episodeId) and #msg.firstBonus > 0 then
		MaterialRpc.instance:onReceiveMaterialChangePush(resultCode, newMsg)
	end
end

function DungeonController:isStoryDungeonType(episodeId)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if config and config.type == DungeonEnum.EpisodeType.Story then
		return true
	end

	return false
end

function DungeonController.getEpisodeName(episodeConfig)
	local chapterId = episodeConfig.chapterId
	local chapterConfig = lua_chapter.configDict[chapterId]
	local episodeId = episodeConfig.id
	local episodeIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterId, episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.Sp then
		return "SP-" .. episodeIndex
	else
		return (string.format("%s-%s", chapterConfig.chapterIndex, episodeIndex))
	end
end

function DungeonController.openStoryElementView(storyId)
	local elementConfig = storyId and lua_story_element.configDict[storyId]
	local elementId = elementConfig and elementConfig.elementId

	if not elementId then
		logError("openStoryElementView elementId is nil storyId:", tostring(storyId))

		return
	end

	local elementConfig = lua_chapter_map_element.configDict[elementId]

	if not elementConfig then
		logError("openStoryElementView elementConfig is nil elementId:", tostring(elementId))

		return
	end

	if elementConfig.type == DungeonEnum.ElementType.V3a7Tower then
		TowerV3a7Controller.instance:openTowerV3a7MapView({
			elementId = elementId
		})

		return
	end

	logError("openStoryElementView invalid type elementId:", tostring(elementId))
end

function DungeonController:openDungeonChangeMapStatusView(param)
	ViewMgr.instance:openView(ViewName.DungeonChangeMapStatusView, param)
end

function DungeonController:openPutCubeGameView(config)
	ViewMgr.instance:openView(ViewName.PutCubeGameView, config)
end

function DungeonController:openOuijaGameView(config)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleOuijaView, config)
end

function DungeonController.queryBgm(target, bgmUsage)
	local isNormalType, isResourceType, isBreakType, isWeekWalkType, isSeasonType = DungeonModel.instance:getChapterListTypes()

	if isWeekWalkType then
		bgmUsage:setClearPauseBgm(true)

		return AudioBgmEnum.Layer.DungeonWeekWalk
	end

	bgmUsage:setClearPauseBgm(false)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music, AudioEnum.UI.Stop_UIMusic)

	return AudioBgmEnum.Layer.Dungeon
end

function DungeonController:enterFairyLandView(episodeId)
	if DungeonModel.instance.curSendEpisodePass and (episodeId == 10712 or episodeId == 718) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FairyLand) then
		if DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
			return
		end

		self:enterDungeonView()

		local co = DungeonConfig.instance:getEpisodeCO(episodeId)
		local chapterCO = DungeonConfig.instance:getChapterCO(co.chapterId)

		self:openDungeonChapterView({
			chapterId = chapterCO.id
		}, true)
		FairyLandController.instance:openFairyLandView()

		if not FairyLandModel.instance:isFinishFairyLand() then
			return ViewName.FairyLandView
		end
	end
end

function DungeonController:enterBossStoryView(episodeId)
	local co = DungeonConfig.instance:getEpisodeCO(episodeId)

	if co and co.chapterId == DungeonEnum.ChapterId.BossStory then
		local openEpisodeId = 11023

		DungeonModel.instance.lastSendEpisodeId = openEpisodeId

		self:enterDungeonView()

		local co = DungeonConfig.instance:getEpisodeCO(openEpisodeId)
		local chapterCO = DungeonConfig.instance:getChapterCO(co.chapterId)
		local mapViewName = self:openDungeonChapterView({
			chapterId = chapterCO.id
		}, true)

		if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) then
			return mapViewName
		end

		return VersionActivity2_8DungeonBossController.instance:openVersionActivity2_8BossStoryEnterView()
	end
end

function DungeonController:enterTowerView(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return nil
	end

	local viewParam

	if episodeConfig.type == DungeonEnum.EpisodeType.TowerPermanent or episodeConfig.type == DungeonEnum.EpisodeType.TowerDeep then
		viewParam = {
			jumpId = TowerEnum.JumpId.TowerPermanent
		}
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.TowerBoss then
		viewParam = {
			jumpId = TowerEnum.JumpId.TowerBoss
		}

		local fightParam = TowerModel.instance:getRecordFightParam()

		viewParam.towerId = fightParam and fightParam.towerId

		local finishParam = TowerModel.instance:getFightFinishParam()

		if finishParam and finishParam.towerType == TowerEnum.TowerType.Boss then
			viewParam.passLayerId = finishParam and finishParam.layerId
		end
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.TowerLimited then
		viewParam = {
			jumpId = TowerEnum.JumpId.TowerLimited
		}
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.TowerBossTeach then
		viewParam = {
			jumpId = TowerEnum.JumpId.TowerBossTeach
		}

		local fightParam = TowerModel.instance:getRecordFightParam()

		viewParam.towerId = fightParam and fightParam.towerId
	end

	if viewParam then
		TowerModel.instance:clearFightFinishParam()
		DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
		self:enterDungeonView()
		TowerController.instance:openMainView(viewParam)

		return ViewName.TowerMainView
	end
end

function DungeonController:enterTowerComposeView(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return nil
	end

	local viewParam

	if episodeConfig.type == DungeonEnum.EpisodeType.TowerCompose then
		viewParam = {}

		local fightParam = TowerComposeModel.instance:getRecordFightParam()
		local fightFinishParam = TowerComposeModel.instance:getFightFinishParam()
		local themeMo = TowerComposeModel.instance:getThemeMo(fightParam.themeId)
		local curBossMo = themeMo:getCurBossMo()
		local isWin = fightFinishParam and fightFinishParam.result == 1

		viewParam.themeId = fightParam.themeId
		viewParam.layerId = fightParam.layerId

		local var_62_0

		if curBossMo then
			::label_62_0::

			var_62_0 = curBossMo.lock and (not fightFinishParam or not fightFinishParam.result or fightFinishParam.result == TowerComposeEnum.FightResult.None)
		end

		viewParam.isNotReset = var_62_0

		local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(fightParam.themeId, fightParam.layerId)

		if towerEpisodeConfig.plane > 0 and not isWin then
			viewParam.jumpId = TowerComposeEnum.JumpId.TowerComposeModEquip or TowerComposeEnum.JumpId.TowerComposeTheme
		end
	end

	if viewParam then
		DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
		self:enterDungeonView()
		TowerComposeController.instance:openTowerComposeMainView(viewParam)

		return ViewName.TowerComposeMainView
	end
end

function DungeonController:enterAbyssView(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return nil
	end

	if episodeConfig.type ~= DungeonEnum.EpisodeType.Abyss then
		return nil
	end

	ViewMgr.instance:openView(ViewName.MainView)

	local actId = AbyssModel.instance:getCurActId()

	if actId == nil or not ActivityModel.instance:isActOnLine(actId) then
		return ViewName.MainView
	end

	AbyssController.instance:openMainView(actId, true)

	return ViewName.AbyssMainView
end

function DungeonController.closePreviewChapterDungeonMapViewActEnd(actId, viewName)
	if viewName ~= ViewName.DungeonMapView then
		return true
	end

	local chapterId = DungeonModel.instance.curLookChapterId

	if not chapterId then
		return false
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local isPreview = chapterConfig and chapterConfig.eaActivityId ~= 0

	if isPreview and not DungeonMainStoryModel.instance:isPreviewChapter(chapterId) then
		return true
	end

	return false
end

function DungeonController.closePreviewChapterViewActEnd(actId, chapterId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local isPreview = chapterConfig and chapterConfig.eaActivityId ~= 0

	if not isPreview then
		return false
	end

	if chapterConfig.eaActivityId ~= actId then
		return false
	end

	if DungeonMainStoryModel.instance:isPreviewChapter(chapterId) then
		return false
	end

	return true
end

function DungeonController.checkEpisodeFiveHero(episodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterCO = episodeCO and lua_chapter.configDict[episodeCO.chapterId]
	local isMainChapter = chapterCO and (chapterCO.type == DungeonEnum.ChapterType.Normal or chapterCO.type == DungeonEnum.ChapterType.Hard or chapterCO.type == DungeonEnum.ChapterType.Simple)

	if not isMainChapter then
		return false
	end

	local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]

	if battleCO and battleCO.roleNum == ModuleEnum.FiveHeroEnum.MaxHeroNum then
		return true
	end

	return false
end

function DungeonController.saveFiveHeroGroupData(heroGroupMO, heroGroupType, episodeId, callback, callbackObj)
	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips())

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.FiveHero
	local snapshotSubId = 1

	if heroGroupType == ModuleEnum.HeroGroupType.General then
		snapshotId = HeroGroupSnapshotModel.instance:getCurSnapshotId()
		snapshotSubId = HeroGroupSnapshotModel.instance:getCurGroupId()
	end

	if snapshotId and snapshotSubId then
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req, callback, callbackObj)
	else
		logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", snapshotId, snapshotSubId))
	end
end

function DungeonController:isShowEntrance()
	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Explore)

	if not isOpen then
		return false
	end

	local isForbid = GuideController.instance:isForbidGuides()

	if isForbid then
		return true
	end
end

function DungeonController:needShowDungeonViewByAdvPlay()
	return DungeonModel.instance.advPlayJumpType
end

function DungeonController:showDungeonViewByAdvPlay()
	local advPlayJumpType = DungeonModel.instance.advPlayJumpType

	DungeonModel.instance.advPlayJumpType = nil

	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.AdvPlay)
	self:enterDungeonView(nil, nil, advPlayJumpType)

	local viewName

	if advPlayJumpType == DungeonEnum.AdvPlayType.Survival then
		SurvivalController.instance:openSurvivalView(true)

		viewName = "SurvivalView"
	elseif advPlayJumpType == DungeonEnum.AdvPlayType.Explore then
		ViewMgr.instance:openView(ViewName.DungeonExploreView)

		viewName = "DungeonExploreView"
	end

	return viewName
end

function DungeonController:openRecheckElementView(chapterId, isAll, isGM)
	local param = {
		chapterId = chapterId,
		isAll = isAll,
		isGM = isGM
	}

	ViewMgr.instance:openView(ViewName.DungeonRecheckElementsView, param)
end

function DungeonController:onRecheckElement(elementId, chapterId, interactiveItem, pos, isGM)
	if not elementId then
		return
	end

	local elementCo = lua_chapter_map_element.configDict[elementId]

	if not elementCo then
		return
	end

	local mapCfg = lua_chapter_map.configDict[elementCo.mapId]

	if mapCfg.chapterId ~= chapterId then
		logError(string.format("该元件不在此章节 elementId=%s 所在章节 chapterId=%s  当前章节 chapterId=%s ", elementId, mapCfg.chapterId, chapterId))

		if not isGM then
			return
		end
	end

	if elementCo.type == DungeonEnum.ElementType.V3a4BBS then
		local postId = tonumber(elementCo.param)

		V3a4BBSController.instance:openV3a4BBSView(postId, nil, elementCo.id, self.onAgainOpenRecheckView, self, elementCo.id)
	else
		if self:isNeedRecheckInteractive(elementCo) and interactiveItem and interactiveItem.onRecheck then
			interactiveItem:onRecheck(elementCo, -pos.x, -pos.y + 2)
			DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnRecheckInteractive, false)

			return
		end

		self:onRecheckFragmentInfoView(elementCo)
	end
end

function DungeonController:isNeedRecheckInteractive(elementCo)
	if not elementCo then
		return
	end

	if elementCo.type == DungeonEnum.ElementType.V3a4BBS then
		return
	end

	self._needRecheckInteractiveElementType = self._needRecheckInteractiveElementType or {
		[DungeonEnum.ElementType.None] = true,
		[DungeonEnum.ElementType.Story] = true,
		[DungeonEnum.ElementType.EnterDialogue] = true,
		[DungeonEnum.ElementType.V3a2Note] = true,
		[DungeonEnum.ElementType.V3a2Dialogue] = true
	}

	return self._needRecheckInteractiveElementType[elementCo.type]
end

function DungeonController:onRecheckFragmentInfoView(elementCo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnRecheckInteractive, true)

	local fragmentId = elementCo.fragment

	if not fragmentId or fragmentId == 0 then
		self:onAgainOpenRecheckView(elementCo.id)

		return
	end

	local viewName
	local fragmentCo = lua_chapter_map_fragment.configDict[fragmentId]

	if fragmentCo and fragmentCo.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
		viewName = ViewName.VersionActivityNewsView
	elseif elementCo.type == DungeonEnum.ElementType.SpStory then
		-- block empty
	else
		viewName = elementCo.type == DungeonEnum.ElementType.Investigate and ViewName.InvestigateTipsView or (elementCo.type == DungeonEnum.ElementType.V3a2Note or elementCo.type == DungeonEnum.ElementType.V3a2Option or elementCo.type == DungeonEnum.ElementType.V3a2Dialogue or elementCo.type == DungeonEnum.ElementType.V3a2OptionFinish) and ViewName.VersionActivity3_2DungeonFragmentInfoView or ViewName.DungeonFragmentInfoView
	end

	local dialogIdList = HandbookModel.instance:getFragmentDialogIdList(fragmentId) or {}
	local param = {
		isRecheck = true,
		notShowToast = true,
		isFromRecheck = true,
		fragmentId = fragmentId,
		dialogIdList = dialogIdList,
		elementId = elementCo.id
	}

	PopupController.instance:addPopupView(PopupEnum.PriorityType.DungeonFragmentInfoView, viewName, param)
end

function DungeonController:onAgainOpenRecheckView(elementId)
	local elementCo = elementId and lua_chapter_map_element.configDict[elementId]

	if elementCo then
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo then
			local chapterId = mapCo.chapterId

			self:openRecheckElementView(chapterId, false)
		end
	end
end

DungeonController.instance = DungeonController.New()

return DungeonController
