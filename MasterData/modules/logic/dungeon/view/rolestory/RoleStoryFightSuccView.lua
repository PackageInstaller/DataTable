-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryFightSuccView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryFightSuccView", package.seeall)

local RoleStoryFightSuccView = class("RoleStoryFightSuccView", BaseView)

function RoleStoryFightSuccView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "btnData")
	self._simagecharacterbg = gohelper.findChildSingleImage(self.viewGO, "#simage_characterbg")
	self._simagemaskImage = gohelper.findChildSingleImage(self.viewGO, "#simage_maskImage")
	self._gospine = gohelper.findChild(self.viewGO, "spineContainer/spine")
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

	self._txtFbNameEn = gohelper.findChildText(self.viewGO, "txtFbNameen")

	self._uiSpine:useRT()

	self._txtFbName = gohelper.findChildText(self.viewGO, "txtFbName")
	self._txtChapterIndex = gohelper.findChildText(self.viewGO, "txtFbName/#go_normaltag/section")
	self._txtEpisodeIndex = gohelper.findChildText(self.viewGO, "txtFbName/#go_normaltag/unit")
	self._gonormaltag = gohelper.findChild(self.viewGO, "txtFbName/#go_normaltag")
	self._goroletag = gohelper.findChild(self.viewGO, "txtFbName/#go_roletag")
	self._txtSayCn = gohelper.findChildText(self.viewGO, "layout/txtSayCn")
	self._txtSayEn = gohelper.findChildText(self.viewGO, "layout/txtSayEn")
	self._gocoverrecordpart = gohelper.findChild(self.viewGO, "#go_cover_record_part")
	self._btncoverrecord = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cover_record_part/#btn_cover_record")
	self._txtcurroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	self._txtmaxroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	self._goCoverLessThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	self._goCoverMuchThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	self._goCoverEqual = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	self.txtScore = gohelper.findChildText(self.viewGO, "goRoleStorytips/#txt_num")
	self.txtScoreAdd = gohelper.findChildText(self.viewGO, "goRoleStorytips/#txt_num/#txt_add")
	self.gofightgoal = gohelper.findChild(self.viewGO, "fightgoal")
	self.txtCondition = gohelper.findChildText(self.gofightgoal, "condition")
	self.txtWave = gohelper.findChildText(self.gofightgoal, "count")
end

function RoleStoryFightSuccView:addEvents()
	self._click:AddClickListener(self._onClickClose, self)
	self._btnData:AddClickListener(self._onClickData, self)
	self.addClickCb(self, self._btncoverrecord, self._onBtnCoverRecordClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, self._onCoverDungeonRecordReply, self)
end

function RoleStoryFightSuccView:removeEvents()
	self._click:RemoveClickListener()
	self._btnData:RemoveClickListener()
end

function RoleStoryFightSuccView:onOpen()
	self._canClick = false
	self._animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	self._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	self._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(self._bonusItemGo, false)

	self._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	self._curChapterId = DungeonModel.instance.curSendChapterId

	local fightResultModel = FightResultModel.instance
	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]
	local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)

	self._hardMode = curChapterConfig and curChapterConfig.type == DungeonEnum.ChapterType.Hard

	if curEpisodeConfig then
		if not curEpisodeConfig.type then
			self._curEpisodeId = FightResultModel.instance.episodeId
			self.hadHighRareProp = false
			self._randomEntityMO = self:_getRandomEntityMO()

			self._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
			self._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

			local chapterCO = lua_chapter.configDict[fightResultModel:getChapterId()]
			local episodeCO = lua_episode.configDict[fightResultModel:getEpisodeId()]
			local needShowFbName = chapterCO ~= nil and episodeCO ~= nil

			gohelper.setActive(self._txtFbName.gameObject, needShowFbName)
			gohelper.setActive(self._txtFbNameEn.gameObject, needShowFbName)

			if needShowFbName then
				self:_setFbName(episodeCO)
			end

			self:_setSpineVoice()
			NavigateMgr.instance:addEscape(ViewName.RoleStoryFightSuccView, self._onClickClose, self)

			self._canPlayVoice = false

			TaskDispatcher.runDelay(self._setCanPlayVoice, self, 0.9)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
			self:_checkNewRecord()
			self:_detectCoverRecord()
			self:showWave()
			self:showScore()
		end
	end
end

function RoleStoryFightSuccView:_showPlatCondition(platConditionText, go, starImage, targetStarNum)
	if string.nilorempty(platConditionText) then
		gohelper.setActive(go, false)
	else
		gohelper.setActive(go, true)

		local resultStar = tonumber(FightResultModel.instance.star) or 0

		gohelper.findChildText(go, "condition").text = resultStar < targetStarNum and gohelper.getRichColorText(platConditionText, "#6C6C6B") or gohelper.getRichColorText(platConditionText, "#C4C0BD")

		local star = gohelper.findChildImage(go, "star")
		local starColor = "#87898C"

		if targetStarNum <= resultStar then
			starColor = self._hardMode and "#FF4343" or "#F77040"
		end

		UISpriteSetMgr.instance:setCommonSprite(star, starImage, true)
		SLFramework.UGUI.GuiHelper.SetColor(star, starColor)
	end
end

function RoleStoryFightSuccView:onClose()
	self._canPlayVoice = false

	TaskDispatcher.cancelTask(self._setCanPlayVoice, self)
	gohelper.setActive(self._gospine, false)

	if FightResultModel.instance.canUpdateDungeonRecord and not self._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end
end

function RoleStoryFightSuccView:_detectCoverRecord()
	gohelper.setActive(self._gocoverrecordpart, FightResultModel.instance.canUpdateDungeonRecord or false)

	if FightResultModel.instance.canUpdateDungeonRecord then
		self._txtcurroundcount.text = FightResultModel.instance.newRecordRound or ""
		self._txtmaxroundcount.text = FightResultModel.instance.oldRecordRound or ""

		gohelper.setActive(self._goCoverLessThan, FightResultModel.instance.newRecordRound < FightResultModel.instance.oldRecordRound)
		gohelper.setActive(self._goCoverMuchThan, FightResultModel.instance.newRecordRound > FightResultModel.instance.oldRecordRound)
		gohelper.setActive(self._goCoverEqual, FightResultModel.instance.newRecordRound == FightResultModel.instance.oldRecordRound)

		self._txtcurroundcount.color = FightResultModel.instance.newRecordRound >= FightResultModel.instance.oldRecordRound and GameUtil.parseColor("#272525") or GameUtil.parseColor("#AC5320")
	end
end

function RoleStoryFightSuccView:_onBtnCoverRecordClick()
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function RoleStoryFightSuccView:_onCoverDungeonRecordReply(isCover)
	self._hasSendCoverRecord = true

	gohelper.setActive(self._gocoverrecordpart, false)

	if isCover then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function RoleStoryFightSuccView:_getRandomEntityMO()
	local mySide1 = FightDataHelper.entityMgr:getMyNormalList()
	local mySide2 = FightDataHelper.entityMgr:getMySubList()
	local mySide3 = FightDataHelper.entityMgr:getMyDeadList()
	local mySideMOList = {}

	tabletool.addValues(mySideMOList, mySide1)
	tabletool.addValues(mySideMOList, mySide2)
	tabletool.addValues(mySideMOList, mySide3)

	for i = #mySideMOList, 1, -1 do
		local entityMO = mySideMOList[i]

		if not self:_getSkin(entityMO) then
			table.remove(mySideMOList, i)
		end
	end

	local noMonsterMOList = {}

	tabletool.addValues(noMonsterMOList, mySideMOList)

	for i = #noMonsterMOList, 1, -1 do
		local entityMO = mySideMOList[i]
		local voice_list = FightAudioMgr.instance:_getHeroVoiceCOs(entityMO.modelId, CharacterEnum.VoiceType.FightResult)

		if voice_list and #voice_list > 0 then
			if entityMO:isMonster() then
				table.remove(noMonsterMOList, i)
			end
		else
			table.remove(noMonsterMOList, i)
		end
	end

	if #noMonsterMOList > 0 then
		return noMonsterMOList[math.random(#noMonsterMOList)]
	elseif #mySideMOList > 0 then
		return mySideMOList[math.random(#mySideMOList)]
	else
		logError("没有角色")
	end
end

function RoleStoryFightSuccView:_checkNewRecord()
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local episodeCO = DungeonConfig.instance:getEpisodeCO(self._curEpisodeId)
		local fightParam = FightModel.instance:getFightParam()
		local battleId = fightParam and fightParam.battleId

		if episodeCO and battleId and episodeCO.firstBattleId == battleId and not HeroGroupBalanceHelper.getIsBalanceMode() then
			GameFacade.showToast(ToastEnum.CantRecordReplay)
		end
	end
end

function RoleStoryFightSuccView:_setCanPlayVoice()
	self._canPlayVoice = true

	self:_playSpineVoice()
end

function RoleStoryFightSuccView:_setFbName(episodeCO)
	local normalEpisodeId = DungeonConfig.instance:getNormalEpisodeId(episodeCO.id)
	local normalEpisodeCO = DungeonConfig.instance:getEpisodeCO(normalEpisodeId)
	local chapterCO = DungeonConfig.instance:getChapterCO(normalEpisodeCO.chapterId)
	local chapterIndex, _ = DungeonConfig.instance:getChapterIndex(chapterCO.type, normalEpisodeCO.chapterId)
	local episodeIndex, _ = DungeonConfig.instance:getChapterEpisodeIndexWithSP(normalEpisodeCO.chapterId, normalEpisodeId)

	if episodeCO.type == DungeonEnum.EpisodeType.Sp then
		local titleIndex = math.floor(episodeCO.id % 10000 / 100)

		episodeIndex = episodeCO.id % 100
		self._txtChapterIndex.text = TeachNoteModel.instance:isTeachNoteEpisode(episodeCO.id) and chapterCO.chapterIndex .. tostring(titleIndex) or "SP" .. tostring(titleIndex)
	else
		self._txtChapterIndex.text = chapterCO.chapterIndex
	end

	self._txtFbNameEn.text = episodeCO.name_En

	self:_setEpisodeName(episodeCO, episodeIndex)
	self:_setTag(episodeCO)
end

function RoleStoryFightSuccView:_setTag(episodeCO)
	local typeList = lua_const.configDict[ConstEnum.DungeonSuccessType].value
	local list = string.splitToNumber(typeList, "#")
	local visible = tabletool.indexOf(list, episodeCO.type)

	gohelper.setActive(self._gonormaltag, visible)
	gohelper.setActive(self._goroletag, not visible)
end

function RoleStoryFightSuccView:_setEpisodeName(episodeCO, episodeIndex)
	if episodeCO.type == DungeonEnum.EpisodeType.WeekWalk then
		local fightParam = FightModel.instance:getFightParam()
		local battleId = fightParam.battleId
		local info = WeekWalkModel.instance:getInfo()
		local name, mapIndex = info:getNameIndexByBattleId(battleId)

		if mapIndex then
			self._txtFbName.text = name
			self._txtEpisodeIndex.text = mapIndex

			return
		end
	elseif episodeCO.type == DungeonEnum.EpisodeType.Season then
		local fightParam = FightModel.instance:getFightParam()
		local seasonId, seasonEpisodeId, diffcultId = Activity104Model.instance:getSeasonEpisodeDifficultByBattleId(fightParam.battleId)
		local seasonEpisodeCo = SeasonConfig.instance:getSeasonEpisodeConfig(seasonId, seasonEpisodeId)

		self._txtgrademark.text = seasonEpisodeId == 1 and luaLang("season_permanent_level_score") or luaLang("season_limit_level_score")
		self._txtFbName.text = seasonEpisodeCo.name
		self._txtEpisodeIndex.text = seasonEpisodeId

		return
	elseif episodeCO.type == DungeonEnum.EpisodeType.Dog then
		local actId, actEpisodeId = Activity109ChessController.instance:getFightSourceEpisode()

		if actId and actEpisodeId then
			local actEpisodeCo = Activity109Config.instance:getEpisodeCo(actId, actEpisodeId)

			if actEpisodeCo then
				self._txtFbName.text = episodeCO.name
				self._txtEpisodeIndex.text = actEpisodeCo.id

				return
			end
		end
	end

	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(episodeCO)

	if episodeList and #episodeList > 1 then
		episodeIndex = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(episodeList[1].id)
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeCO.chapterId)

	if chapterConfig then
		if chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonHard then
			episodeIndex = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		end

		if chapterConfig.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity1_3DungeonController.instance:getEpisodeIndex(episodeCO.id)
		end
	end

	self._txtFbName.text = episodeCO.name
	self._txtEpisodeIndex.text = episodeIndex
end

function RoleStoryFightSuccView:_getSkin(mo)
	local skinCO = FightConfig.instance:getSkinCO(mo.skin)
	local hasVerticalDrawing = skinCO and not string.nilorempty(skinCO.verticalDrawing)
	local hasLive2d = skinCO and not string.nilorempty(skinCO.live2d)

	if hasVerticalDrawing or hasLive2d then
		return skinCO
	end
end

function RoleStoryFightSuccView:_setSpineVoice()
	if not self._randomEntityMO then
		return
	end

	local skinCO = self:_getSkin(self._randomEntityMO)

	if skinCO then
		self._spineLoaded = false

		self._uiSpine:setImgPos(0)
		self._uiSpine:setResPath(skinCO, function()
			self._spineLoaded = true

			self._uiSpine:setUIMask(true)
			self:_playSpineVoice()
		end, self)

		local offsets, isNil = SkinConfig.instance:getSkinOffset(skinCO.fightSuccViewOffset)

		if isNil then
			offsets, _ = SkinConfig.instance:getSkinOffset(skinCO.characterViewOffset)
			offsets = SkinConfig.instance:getAfterRelativeOffset(504, offsets)
		end

		local scale = tonumber(offsets[3])
		local offsetX = tonumber(offsets[1])
		local offsetY = tonumber(offsets[2])

		CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._gospine.transform, scale, scale, scale)
	else
		gohelper.setActive(self._gospine, false)
	end
end

function RoleStoryFightSuccView:_playSpineVoice()
	if not self._canPlayVoice then
		return
	end

	if not self._spineLoaded then
		return
	end

	local voiceCOList = HeroModel.instance:getVoiceConfig(self._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, self._randomEntityMO.skin)

	voiceCOList = voiceCOList or FightAudioMgr.instance:_getHeroVoiceCOs(self._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, self._randomEntityMO.skin)

	if voiceCOList and #voiceCOList > 0 then
		local firstVoiceCO = voiceCOList[1]

		self._uiSpine:playVoice(firstVoiceCO, nil, self._txtSayCn, self._txtSayEn)
	end
end

function RoleStoryFightSuccView:_getSayContent(contentStr)
	local temp = GameUtil.splitString2(contentStr, false, "|", "#")
	local ans = ""

	for _, temp2 in ipairs(temp) do
		ans = ans .. temp2[1]
	end

	return ans
end

function RoleStoryFightSuccView:onCloseFinish()
	self._simagecharacterbg:UnLoadImage()
	self._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	self._animEventWrap:RemoveAllEventListener()

	if self._farmTweenId then
		ZProj.TweenHelper.KillById(self._farmTweenId)
	end
end

function RoleStoryFightSuccView:_getHeroIconPath()
	if self._randomEntityMO then
		local skinCO = FightConfig.instance:getSkinCO(self._randomEntityMO.skin)

		if skinCO then
			return ResUrl.getHeadIconLarge(skinCO.largeIcon)
		end
	end
end

function RoleStoryFightSuccView:_onClickClose()
	if not self._canClick then
		return
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	self:closeThis()

	local storyId = FightModel.instance:getAfterStory()

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		RoleStoryFightSuccView._storyId = storyId
		RoleStoryFightSuccView._clientFinish = false
		RoleStoryFightSuccView._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, RoleStoryFightSuccView._finishStoryFromServer)

		local param = {}

		param.mark = true
		param.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(storyId, param, function()
			TaskDispatcher.runDelay(RoleStoryFightSuccView.onStoryEnd, nil, 3)

			RoleStoryFightSuccView._clientFinish = true

			RoleStoryFightSuccView.checkStoryEnd()
		end)

		return
	end

	RoleStoryFightSuccView.onStoryEnd()
end

function RoleStoryFightSuccView._finishStoryFromServer(storyId)
	if RoleStoryFightSuccView._storyId == storyId then
		RoleStoryFightSuccView._serverFinish = true

		RoleStoryFightSuccView.checkStoryEnd()
	end
end

function RoleStoryFightSuccView.checkStoryEnd()
	if RoleStoryFightSuccView._clientFinish and RoleStoryFightSuccView._serverFinish then
		RoleStoryFightSuccView.onStoryEnd()
	end
end

function RoleStoryFightSuccView.onStoryEnd()
	RoleStoryFightSuccView._storyId = nil
	RoleStoryFightSuccView._clientFinish = false
	RoleStoryFightSuccView._serverFinish = false

	TaskDispatcher.cancelTask(RoleStoryFightSuccView.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, RoleStoryFightSuccView._finishStoryFromServer)
	FightController.onResultViewClose()
end

function RoleStoryFightSuccView.checkRecordFarmItem(episodeId, recordFarmItem)
	if not recordFarmItem then
		return false
	end

	if recordFarmItem.checkFunc then
		return recordFarmItem.checkFunc(recordFarmItem.checkFuncObj)
	end

	local materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())

	for i, materialData in ipairs(materialDataList) do
		if materialData.materilType == recordFarmItem.type and materialData.materilId == recordFarmItem.id then
			return true
		end
	end

	if episodeId then
		::label_28_0::

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeConfig then
			return false
		end

		if RoleStoryFightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeFirstBonus(episodeId), recordFarmItem) then
			return true
		end

		if RoleStoryFightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeAdvancedBonus(episodeId), recordFarmItem) then
			return true
		end

		if RoleStoryFightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeBonus(episodeId), recordFarmItem) then
			return true
		end

		if RoleStoryFightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeRewardList(episodeId), recordFarmItem) then
			return true
		end

		return false
	end
end

function RoleStoryFightSuccView.checkRecordFarmItemByReward(rewardList, recordFarmItem)
	for i, reward in ipairs(rewardList) do
		if tonumber(reward[1]) == recordFarmItem.type and tonumber(reward[2]) == recordFarmItem.id then
			return true
		end
	end

	return false
end

function RoleStoryFightSuccView:_showCharacterGetView()
	PopupController.instance:setPause("fightsuccess", false)

	self._canClick = true
end

function RoleStoryFightSuccView:showWave()
	local wave = FightModel.instance:getCurWaveId()
	local maxwave = FightModel.instance.maxWave

	self.txtCondition.text = luaLang("dungeon_beat_all")

	local list = FightDataHelper.entityMgr:getEnemyNormalList()

	if list and #list > 0 then
		wave = wave - 1
	end

	self.txtWave.text = string.format("<color=#E57937>%s</color>/%s", wave, maxwave)
end

function RoleStoryFightSuccView:showScore()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local mo = RoleStoryModel.instance:getById(storyId)
	local cur = mo and mo:getScore() or 0
	local add = mo and mo:getAddScore() or 0

	self.txtScore.text = cur
	self.txtScoreAdd.text = string.format("(+%s)", add)

	self:_onAllTweenFinish()
end

function RoleStoryFightSuccView:_onAllTweenFinish()
	self:_showCharacterGetView()
end

function RoleStoryFightSuccView:_onClickData()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

return RoleStoryFightSuccView
