-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionOpenViewWithCondition.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewWithCondition", package.seeall)

local WaitGuideActionOpenViewWithCondition = class("WaitGuideActionOpenViewWithCondition", BaseGuideAction)

function WaitGuideActionOpenViewWithCondition:onStart(context)
	WaitGuideActionOpenViewWithCondition.super.onStart(self, context)

	local paramList = string.split(self.actionParam, "#")

	self._viewName = ViewName[paramList[1]]

	local funcName = paramList[2]

	self._conditionParam = paramList[3]
	self._conditionCheckFun = self[funcName]

	if ViewMgr.instance:isOpen(self._viewName) and self._conditionCheckFun(self._conditionParam) then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
end

function WaitGuideActionOpenViewWithCondition:_checkOpenView(viewName, viewParam)
	if self._viewName == viewName and self._conditionCheckFun(self._conditionParam) then
		self:clearWork()
		self:onDone(true)
	end
end

function WaitGuideActionOpenViewWithCondition:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
end

function WaitGuideActionOpenViewWithCondition.manyFailure()
	local doingGuideId = GuideModel.instance:getDoingGuideId()

	if doingGuideId then
		return
	end

	local episodeId = DungeonModel.instance.curLookEpisodeId
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

	if value < 3 then
		return
	end

	return true
end

function WaitGuideActionOpenViewWithCondition.enterFightSubEntity()
	local mySideList = FightDataHelper.entityMgr:getMyNormalList()

	if not mySideList or #mySideList < 3 then
		return
	end

	local mySideSub = FightDataHelper.entityMgr:getMySubList()

	if not mySideSub or #mySideSub == 0 then
		return
	end

	local doingGuideId = GuideModel.instance:getDoingGuideId()

	if doingGuideId then
		return
	end

	return true
end

function WaitGuideActionOpenViewWithCondition.clearedOneBattle()
	local mapInfo = WeekWalkModel.instance:getMapInfo(201)

	if not mapInfo then
		return
	end

	local cur, total = mapInfo:getCurStarInfo()

	return cur > 0
end

function WaitGuideActionOpenViewWithCondition.remainStars()
	local mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not mapInfo or mapInfo.isFinish <= 0 then
		return
	end

	local cur, total = mapInfo:getCurStarInfo()

	return cur ~= total
end

function WaitGuideActionOpenViewWithCondition.weekWalkFinishLayer()
	local mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not mapInfo or mapInfo.isFinish <= 0 then
		return
	end

	return true
end

function WaitGuideActionOpenViewWithCondition.checkFirstPosHasEquip()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = curGroupMO:getPosEquips(0).equipUid
	local equipId = equips and equips[1]

	if equipId then
		::label_9_0::

		local equipMO = EquipModel.instance:getEquip(equipId)

		if equipMO then
			return true
		end

		return false
	end
end

function WaitGuideActionOpenViewWithCondition.enterWeekWalkMap(id)
	return WeekWalkModel.instance:getCurMapId() == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.enterWeekWalkBattle(id)
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local isWeekWalk = chapterConfig.type == DungeonEnum.ChapterType.WeekWalk

	return isWeekWalk and WeekWalkModel.instance:getCurMapId() == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.checkBuildingPutInObMode(param)
	if not RoomController.instance:isObMode() then
		return
	end

	if RoomBuildingController.instance:isBuildingListShow() then
		return
	end

	if not RoomInventoryBuildingModel.instance:checkBuildingPut(param) then
		GameFacade.showToast(ToastEnum.WaitGuideActionOpen)

		return false
	end

	return true
end

function WaitGuideActionOpenViewWithCondition.isMainMode()
	local chapterId = DungeonModel.instance.curLookChapterId

	if not chapterId then
		return false
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	return chapterConfig.type == DungeonEnum.ChapterType.Normal
end

function WaitGuideActionOpenViewWithCondition.isHardMode()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	return chapterConfig.type == DungeonEnum.ChapterType.Hard
end

function WaitGuideActionOpenViewWithCondition.isEditMode()
	return RoomController.instance:isEditMode()
end

function WaitGuideActionOpenViewWithCondition.isObMode()
	return RoomController.instance:isObMode()
end

function WaitGuideActionOpenViewWithCondition.buildingStrengthen()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	local isObMode = RoomController.instance:isObMode()

	if not isObMode then
		return false
	end

	local itemCount = ItemModel.instance:getItemCount(190007)

	if itemCount <= 0 then
		return false
	end

	local buildingList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(buildingList) do
		if buildingMO.buildingId == 2002 then
			return true
		end
	end

	return false
end

function WaitGuideActionOpenViewWithCondition.openSeasonDiscount()
	return Activity104Model.instance:isEnterSpecial()
end

function WaitGuideActionOpenViewWithCondition.checkAct114CanGuide()
	return Activity114Model.instance:have114StoryFlow()
end

function WaitGuideActionOpenViewWithCondition.checkActivity1_2DungeonBuildingNum()
	local gainList = VersionActivity1_2DungeonModel.instance:getBuildingGainList()

	return gainList and #gainList > 0
end

function WaitGuideActionOpenViewWithCondition.checkActivity1_2DungeonTrapPutting()
	local curTrapId = VersionActivity1_2DungeonModel.instance:getTrapPutting()

	return curTrapId and curTrapId ~= 0
end

function WaitGuideActionOpenViewWithCondition.check1_2DungeonCollectAllNote()
	return VersionActivity1_2NoteModel.instance:isCollectedAllNote()
end

function WaitGuideActionOpenViewWithCondition.checkInEliminateEpisode(id)
	return EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.checkInWindows(id)
	return BootNativeUtil.isWindows() or BootNativeUtil.isMuMu()
end

function WaitGuideActionOpenViewWithCondition.enterWuErLiXiMap(id)
	return WuErLiXiMapModel.instance:getCurMapId() == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.enterFeiLinShiDuoMap(id)
	return FeiLinShiDuoGameModel.instance:getCurMapId() == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.isOpenEpisode(id)
	return LiangYueModel.instance:getCurEpisodeId() == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.isAutoChessInEpisodeAndRound(param)
	local data = string.splitToNumber(param, ",")
	local episodeId = data[1]

	if not AutoChessModel.instance.episodeId or AutoChessModel.instance.episodeId ~= episodeId then
		return
	end

	local mo = AutoChessModel.instance:getChessMo()

	if mo == nil or mo.sceneRound == nil then
		return false
	end

	local round = data[2]

	return mo.sceneRound == round
end

function WaitGuideActionOpenViewWithCondition.isUnlockEpisode(id)
	local actId = LiangYueModel.instance:getCurActId()

	return LiangYueModel.instance:isEpisodeFinish(actId, id) == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.checkAct191NodeType(checkParam)
	checkParam = tonumber(checkParam)

	local actInfo = Activity191Model.instance:getActInfo()

	if actInfo then
		local gameInfo = actInfo:getGameInfo()
		local nodeInfo = gameInfo:getNodeInfoById(gameInfo.curNode)

		if #nodeInfo.selectNodeStr ~= 0 then
			local mo = Act191NodeDetailMO.New()

			mo:init(nodeInfo.selectNodeStr[1])

			if checkParam == 1 and Activity191Helper.isPveBattle(mo.type) then
				return true
			elseif checkParam == 2 and Activity191Helper.isPvpBattle(mo.type) then
				return true
			end
		end
	end

	return false
end

function WaitGuideActionOpenViewWithCondition.checkAct191Stage(stageId)
	stageId = tonumber(stageId)

	local actInfo = Activity191Model.instance:getActInfo()

	if actInfo then
		local gameInfo = actInfo:getGameInfo()

		if gameInfo and gameInfo.curStage == stageId then
			return true
		end
	end

	return false
end

function WaitGuideActionOpenViewWithCondition.commonCheck(param)
	if not param then
		return false
	end

	local arr = string.split(param, "_")
	local cls = _G[arr[1]]

	if not cls then
		return false
	end

	local func = cls[arr[2]]

	if not func then
		return false
	end

	if cls.instance then
		return func(cls.instance, unpack(arr, 3))
	else
		return func(unpack(arr, 3))
	end
end

function WaitGuideActionOpenViewWithCondition.checkOdysseyPlayerLevel()
	local curLevel = OdysseyModel.instance:getHeroCurLevelAndExp()
	local curTalentPoint = OdysseyTalentModel.instance:getCurTalentPoint()

	return curLevel >= 2 and curTalentPoint > 0
end

function WaitGuideActionOpenViewWithCondition.checkReligionUnlock()
	local religionUnlockCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ReligionUnlock)

	return (OdysseyDungeonModel.instance:checkConditionCanUnlock(religionUnlockCo.value))
end

function WaitGuideActionOpenViewWithCondition.checkMercenaryUnlock()
	local mercenaryUnlockCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryUnlock)

	return (OdysseyDungeonModel.instance:checkConditionCanUnlock(mercenaryUnlockCo.value))
end

function WaitGuideActionOpenViewWithCondition.checkMythUnlock()
	return OdysseyDungeonModel.instance:checkHasFightTypeElement(OdysseyEnum.FightType.Myth)
end

function WaitGuideActionOpenViewWithCondition.checkOpenConquerView()
	local curInElementId = OdysseyDungeonModel.instance:getCurInElementId()
	local elementConfig = OdysseyConfig.instance:getElementFightConfig(curInElementId)

	return elementConfig and elementConfig.type == OdysseyEnum.FightType.Conquer
end

function WaitGuideActionOpenViewWithCondition.isMoLiDeErInEpisode(param)
	if string.nilorempty(param) then
		return false
	end

	local episodeId = tonumber(param)

	if not episodeId or episodeId == 0 then
		return false
	end

	local curEpisodeId = MoLiDeErModel.instance:getCurEpisodeId()

	return episodeId == curEpisodeId
end

function WaitGuideActionOpenViewWithCondition.isNuoDiKaEpisode(param)
	if string.nilorempty(param) then
		return false
	end

	local episodeId = tonumber(param)

	if not episodeId or episodeId == 0 then
		return false
	end

	local curEpisodeId = NuoDiKaModel.instance:getCurEpisode()

	return episodeId == curEpisodeId
end

function WaitGuideActionOpenViewWithCondition.enterHuiDiaoLanEpisodeId(id)
	local curEpisodeId = HuiDiaoLanModel.instance:getCurEpisodeId()

	return curEpisodeId == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.enterHuiDiaoLanSpEpisode()
	local curEpisodeId = HuiDiaoLanModel.instance:getCurEpisodeId()
	local episodeConfig = HuiDiaoLanConfig.instance:getEpisodeConfig(curEpisodeId)

	return episodeConfig.type == HuiDiaoLanEnum.SpEpisodeType
end

function WaitGuideActionOpenViewWithCondition.enterBeiLiErEpisodeId(id)
	local curEpisodeId = BeiLiErModel.instance:getCurEpisode()

	return curEpisodeId == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition:checkAttrDropHasEffectHero()
	return Rouge2_AttrDropController.instance:checkAttrDropHasEffectHero()
end

function WaitGuideActionOpenViewWithCondition.checkFinishRouge(param)
	if param == nil then
		return false
	end

	local lastTime = TimeUtil.stringToTimestamp(param) * TimeUtil.OneSecondMilliSecond
	local reviewInfo = Rouge2_OutsideModel.instance:getReviewInfoList()

	if not reviewInfo or next(reviewInfo) == nil then
		return false
	end

	for _, info in ipairs(reviewInfo) do
		if lastTime <= tonumber(info.finishTime) then
			return not Rouge2_Model.instance:inRouge()
		end
	end

	return false
end

function WaitGuideActionOpenViewWithCondition.checkSinglePartyGame()
	local curGame = PartyGameController.instance:getCurPartyGame()

	return not curGame or curGame:getIsLocal()
end

function WaitGuideActionOpenViewWithCondition.checkAbyssStateFinish()
	local actId = AbyssModel.instance:getCurActId()

	if not actId or not ActivityModel.instance:isActOnLine(actId) then
		return false
	end

	local info = AbyssModel.instance:getInfoMo(actId)

	if info.stageInfoList and next(info.stageInfoList) then
		for _, stageInfo in ipairs(info.stageInfoList) do
			if stageInfo:isChallenged() and stageInfo.star > 0 then
				return true
			end
		end
	end

	return false
end

function WaitGuideActionOpenViewWithCondition.enterTowerFirstMap()
	return TowerV3a7Model.instance:inFirstMap()
end

function WaitGuideActionOpenViewWithCondition.enterEchoSong(id)
	return V3a8EchoSongModel.instance:getGameId() == tonumber(id)
end

function WaitGuideActionOpenViewWithCondition.checkAtomicDungeonUnlock()
	return AtomicDungeonController.instance:isUnlockDungeon()
end

function WaitGuideActionOpenViewWithCondition.checkNaxisuoxiGameId(id)
	local curGameId = NaxisuosiPipeModel.instance:getGameId()

	return curGameId ~= nil and curGameId == tonumber(id)
end

return WaitGuideActionOpenViewWithCondition
