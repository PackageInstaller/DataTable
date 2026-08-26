-- chunkname: @modules/logic/fight/view/FightSuccView.lua

module("modules.logic.fight.view.FightSuccView", package.seeall)

local FightSuccView = class("FightSuccView", BaseView)

function FightSuccView:onInitView()
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
	self._txtLv = gohelper.findChildText(self.viewGO, "goalcontent/txtLv")
	self._txtExp = gohelper.findChildText(self.viewGO, "goalcontent/txtLv/txtExp")
	self._txtAddExp = gohelper.findChildText(self.viewGO, "goalcontent/txtLv/progress/txtAddExp")
	self._sliderExp = gohelper.findChildSlider(self.viewGO, "goalcontent/txtLv/progress")
	self._txtSayCn = gohelper.findChildText(self.viewGO, "layout/txtSayCn")
	self._txtSayCn.text = ""
	self._txtSayEn = gohelper.findChildText(self.viewGO, "layout/txtSayEn")
	self._txtSayEn.text = ""
	self._favorIcon = gohelper.findChild(self.viewGO, "scroll/viewport/content/favor")
	self._goCondition = gohelper.findChild(self.viewGO, "goalcontent/goallist/fightgoal")
	self._goPlatCondition = gohelper.findChild(self.viewGO, "goalcontent/goallist/platinum")
	self._goPlatCondition2 = gohelper.findChild(self.viewGO, "goalcontent/goallist/platinum2")
	self._goPlatConditionMaterial = gohelper.findChild(self.viewGO, "goalcontent/goallist/platinumMaterial")
	self._goalcontent = gohelper.findChild(self.viewGO, "goalcontent")
	self._goweekwalkgoalcontent = gohelper.findChild(self.viewGO, "weekwalkgoalcontent")
	self._goweekwalkcontentitem = gohelper.findChild(self.viewGO, "weekwalkgoalcontent/goallist/goalitem")
	self._bonusItemContainer = gohelper.findChild(self.viewGO, "scroll/viewport/content")
	self._goscroll = gohelper.findChild(self.viewGO, "scroll")
	self._bonusItemGo = gohelper.findChild(self.viewGO, "scroll/item")
	self._godemand = gohelper.findChild(self.viewGO, "#go_demand")
	self._txtdemand = gohelper.findChildText(self.viewGO, "#go_demand/#txt_demand")
	self._btnbacktosource = gohelper.findChildButtonWithAudio(self.viewGO, "#go_demand/#btn_backToSource")
	self._gocoverrecordpart = gohelper.findChild(self.viewGO, "#go_cover_record_part")
	self._btncoverrecord = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cover_record_part/#btn_cover_record")
	self._txtcurroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	self._txtmaxroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	self._goCoverLessThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	self._goCoverMuchThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	self._goCoverEqual = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	self._godetails = gohelper.findChild(self.viewGO, "#go_details")
	self._gogoallist = gohelper.findChild(self.viewGO, "goalcontent/goallist")
	self._goseason = gohelper.findChild(self.viewGO, "#go_season")
	self._txtseasongrade = gohelper.findChildText(self.viewGO, "#go_season/grade/#txt_grade")
	self._txtseasonlevel = gohelper.findChildText(self.viewGO, "#go_season/level/#txt_level")
	self._imagegradeicon = gohelper.findChildImage(self.viewGO, "#go_season/level/#image_gradeicon")
	self._txtgrademark = gohelper.findChildText(self.viewGO, "#go_season/grade/grade")
end

function FightSuccView:addEvents()
	self._click:AddClickListener(self._onClickClose, self)
	self._btnData:AddClickListener(self._onClickData, self)
	self._btnbacktosource:AddClickListener(self._onClickBackToSource, self)
	self.addClickCb(self, self._btncoverrecord, self._onBtnCoverRecordClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, self._onCoverDungeonRecordReply, self)
end

function FightSuccView:removeEvents()
	self._click:RemoveClickListener()
	self._btnData:RemoveClickListener()
	self._btnbacktosource:RemoveClickListener()
end

function FightSuccView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

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

	if curChapterConfig then
		if not curChapterConfig.type then
			local chapterType = DungeonEnum.ChapterType.Normal

			self._normalMode = chapterType == DungeonEnum.ChapterType.Normal
			self._hardMode = chapterType == DungeonEnum.ChapterType.Hard
			self._simpleMode = chapterType == DungeonEnum.ChapterType.Simple

			if curEpisodeConfig then
				if not curEpisodeConfig.type then
					self._curEpisodeId = FightResultModel.instance.episodeId
					self.hadHighRareProp = false

					self:_loadBonusItems()
					self:_hideGoDemand()

					local conditionText = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())
					local platConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(self._curEpisodeId, FightModel.instance:getBattleId())
					local starImage = self._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

					if string.nilorempty(conditionText) then
						gohelper.setActive(self._goCondition, false)
					else
						gohelper.findChildText(self._goCondition, "condition").text = conditionText

						local star = gohelper.findChildImage(self._goCondition, "star")

						UISpriteSetMgr.instance:setCommonSprite(star, starImage, true)
						SLFramework.UGUI.GuiHelper.SetColor(star, self._hardMode and "#FF4343" or "#F77040")
					end

					if curChapterConfig and curChapterConfig.type == DungeonEnum.ChapterType.Simple then
						gohelper.setActive(self._goPlatCondition, false)
					else
						self:_showPlatCondition(platConditionText, self._goPlatCondition, starImage, DungeonEnum.StarType.Advanced)
					end

					self:_showPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2Text(self._curEpisodeId, FightModel.instance:getBattleId()), self._goPlatCondition2, starImage, DungeonEnum.StarType.Ultra)

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

					local exps = PlayerModel.instance:getExpNowAndMax()

					self._txtLv.text = "<size=36>LV </size>" .. PlayerModel.instance:getPlayerLevel()

					self._sliderExp:SetValue(exps[1] / exps[2])

					self._txtExp.text = exps[1] .. "/" .. exps[2]

					local addExp = fightResultModel:getPlayerExp()

					if addExp and addExp > 0 then
						gohelper.setActive(self._txtAddExp.gameObject, true)

						self._txtAddExp.text = "EXP+" .. addExp
					else
						gohelper.setActive(self._txtAddExp.gameObject, false)
					end

					self:_setSpineVoice()
					NavigateMgr.instance:addEscape(ViewName.FightSuccView, self._onClickClose, self)

					self._canPlayVoice = false

					TaskDispatcher.runDelay(self._setCanPlayVoice, self, 0.9)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
					self:_checkNewRecord()
					self:_detectCoverRecord()
					self:_checkTypeDetails()
					self:showUnLockCurrentEpisodeNewMode()
					self:_show1_2DailyEpisodeEndNotice()
					self:_show1_6EpisodeMaterial()
					self:_showWeekWalk_2Condition()
					self:_playVictoryAudio_2_7()
				end
			end
		end
	end
end

function FightSuccView:_showPlatCondition(platConditionText, go, starImage, targetStarNum)
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

function FightSuccView:onClose()
	self._canPlayVoice = false

	TaskDispatcher.cancelTask(self._setCanPlayVoice, self)
	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	gohelper.setActive(self._gospine, false)

	if FightResultModel.instance.canUpdateDungeonRecord and not self._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end
end

function FightSuccView:_checkTypeDetails()
	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]
	local isSeason = curEpisodeConfig and curEpisodeConfig.type == DungeonEnum.EpisodeType.Season

	if not isSeason then
		return
	end

	gohelper.setActive(self._goseason, true)
	gohelper.setActive(self._txtLv.gameObject, false)
	gohelper.setActive(self._goscroll, false)
	gohelper.setActive(self._gogoallist, false)

	local newInfo = Activity104Model.instance:getNewUnlockInfo()

	gohelper.setActive(self._txtseasonlevel.gameObject, false)
	UISpriteSetMgr.instance:setSeasonSprite(self._imagegradeicon, "sjwf_nandudengji_" .. tostring(Activity104Model.instance:getEpisodeLv(newInfo.score)))

	self._txtseasongrade.text = newInfo.score
end

function FightSuccView:_detectCoverRecord()
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

function FightSuccView:_onBtnCoverRecordClick()
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function FightSuccView:_onCoverDungeonRecordReply(isCover)
	self._hasSendCoverRecord = true

	gohelper.setActive(self._gocoverrecordpart, false)

	if isCover then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function FightSuccView:_getRandomEntityMO()
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

function FightSuccView:_checkNewRecord()
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

function FightSuccView:_setCanPlayVoice()
	self._canPlayVoice = true

	self:_playSpineVoice()
end

function FightSuccView:_setFbName(episodeCO)
	local normalEpisodeId = DungeonConfig.instance:getNormalEpisodeId(episodeCO.id)
	local normalEpisodeCO = DungeonConfig.instance:getEpisodeCO(normalEpisodeId)
	local chapterCO = DungeonConfig.instance:getChapterCO(normalEpisodeCO.chapterId)
	local chapterIndex, _ = DungeonConfig.instance:getChapterIndex(chapterCO.type, normalEpisodeCO.chapterId)
	local episodeIndex, _ = DungeonConfig.instance:getChapterEpisodeIndexWithSP(normalEpisodeCO.chapterId, normalEpisodeId)

	if episodeCO.type == DungeonEnum.EpisodeType.Sp then
		local titleIndex = math.floor(episodeCO.id % 10000 / 100)

		episodeIndex = episodeCO.id % 100
		self._txtChapterIndex.text = TeachNoteModel.instance:isTeachNoteEpisode(episodeCO.id) and chapterCO.chapterIndex .. tostring(titleIndex) or chapterCO.id == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight and chapterCO.chapterIndex or "SP" .. tostring(titleIndex)
	else
		self._txtChapterIndex.text = chapterCO.chapterIndex
	end

	self:_setEpisodeName(episodeCO, episodeIndex, normalEpisodeCO)
	self:_setTag(episodeCO)
end

function FightSuccView:_setTag(episodeCO)
	local typeList = lua_const.configDict[ConstEnum.DungeonSuccessType].value
	local list = string.splitToNumber(typeList, "#")
	local visible = tabletool.indexOf(list, episodeCO.type)

	if episodeCO.chapterId == DungeonEnum.ChapterId.RoleDuDuGu then
		visible = false
	end

	gohelper.setActive(self._gonormaltag, visible)
	gohelper.setActive(self._goroletag, not visible)
end

function FightSuccView:_setEpisodeName(episodeCO, episodeIndex, normalEpisodeCO)
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
	elseif episodeCO.type == DungeonEnum.EpisodeType.WeekWalk_2 then
		local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()

		if mapInfo then
			self._txtFbName.text = mapInfo.sceneConfig.battleName
			self._txtFbNameEn.text = mapInfo.sceneConfig.name_en

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
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	if chapterConfig then
		if chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or chapterConfig.type == DungeonEnum.ChapterType.Activity1_2DungeonHard then
			episodeIndex = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		end

		if chapterConfig.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity1_3DungeonController.instance:getEpisodeIndex(episodeCO.id)
		end

		if chapterConfig.actId == VersionActivity1_5Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity1_5DungeonController.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivity1_6Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity1_6DungeonController.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivity1_8Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity1_8DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivity2_0Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity2_0DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivity2_1Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity2_1DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivity2_3Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity2_3DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivity2_4Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity2_4DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivity2_5Enum.ActivityId.Dungeon then
			episodeIndex = VersionActivity2_5DungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		elseif chapterConfig.actId == VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion).ActivityId.Dungeon then
			episodeIndex = VersionActivityFixedDungeonConfig.instance:getEpisodeIndex(episodeCO.id)
		end
	end

	if episodeCO.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard then
		episodeIndex = DungeonConfig.instance:getEpisodeLevelIndex(episodeCO)
	end

	self._txtFbName.text = normalEpisodeCO.name
	self._txtFbNameEn.text = normalEpisodeCO.name_En
	self._txtEpisodeIndex.text = episodeIndex
end

function FightSuccView:_getSkin(mo)
	local skinCO = FightConfig.instance:getSkinCO(mo.skin)
	local hasVerticalDrawing = skinCO and not string.nilorempty(skinCO.verticalDrawing)
	local hasLive2d = skinCO and not string.nilorempty(skinCO.live2d)

	if hasVerticalDrawing or hasLive2d then
		return skinCO
	end
end

function FightSuccView:_setSpineVoice()
	if not self._randomEntityMO then
		return
	end

	local skinCO = self:_getSkin(self._randomEntityMO)

	if skinCO then
		self._skinCO = skinCO
		self._spineLoaded = false

		self._uiSpine:setImgPos(0)
		self._uiSpine:setResPath(skinCO, function()
			self._spineLoaded = true

			self._uiSpine:setUIMask(true)
			self:_playSpineVoice()
			self._uiSpine:setAllLayer(UnityLayer.UI3D)
		end, self, CharacterVoiceEnum.NormalFullScreenEffectCameraSize)

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

function FightSuccView:_playSpineVoice()
	if not self._canPlayVoice then
		return
	end

	if not self._spineLoaded then
		return
	end

	if self._uiSpine:isLive2D() then
		self._uiSpine:setLive2dCameraLoadFinishCallback(self.onLive2dCameraLoadedCallback, self)

		return
	end

	self:_playVoice()
end

function FightSuccView:onLive2dCameraLoadedCallback()
	self._uiSpine:setLive2dCameraLoadFinishCallback()

	self._repeatNum = CharacterVoiceEnum.DelayFrame + 1
	self._repeatCount = 0

	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	TaskDispatcher.runRepeat(self._delayPlayVoice, self, 0, self._repeatNum)
	self:_adjustPos()
end

function FightSuccView:_adjustPos()
	if self._skinCO and self._uiSpine:isLive2D() and not CharacterVoiceEnum.SkipMesFightSuccPosAdjust then
		local skinId = self._skinCO.id

		if skinId ~= 312703 then
			return
		end

		local guiLive2d = self._uiSpine:_getLive2d()

		if not guiLive2d then
			return
		end

		local rawImg = guiLive2d._rawImageGo
		local spineGo = guiLive2d:getSpineGo()

		if not rawImg or not spineGo then
			return
		end

		recthelper.setAnchorX(rawImg.transform, 200)
		transformhelper.setLocalPosXY(spineGo.transform, -146, 0)
	end
end

function FightSuccView:_delayPlayVoice()
	self._repeatCount = self._repeatCount + 1

	if self._repeatCount < self._repeatNum then
		return
	end

	self:_playVoice()
end

function FightSuccView:_playVoice()
	local voiceCOList = HeroModel.instance:getVoiceConfig(self._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, self._randomEntityMO.skin)

	voiceCOList = voiceCOList or FightAudioMgr.instance:_getHeroVoiceCOs(self._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, self._randomEntityMO.skin)

	if voiceCOList and #voiceCOList > 0 then
		local firstVoiceCO = voiceCOList[1]

		self._uiSpine:playVoice(firstVoiceCO, nil, self._txtSayCn, self._txtSayEn)
	end
end

function FightSuccView:_getSayContent(contentStr)
	local temp = GameUtil.splitString2(contentStr, false, "|", "#")
	local ans = ""

	for _, temp2 in ipairs(temp) do
		ans = ans .. temp2[1]
	end

	return ans
end

function FightSuccView:onCloseFinish()
	self._simagecharacterbg:UnLoadImage()
	self._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	self._animEventWrap:RemoveAllEventListener()

	if self._farmTweenId then
		ZProj.TweenHelper.KillById(self._farmTweenId)
	end
end

function FightSuccView:_getHeroIconPath()
	if self._randomEntityMO then
		local skinCO = FightConfig.instance:getSkinCO(self._randomEntityMO.skin)

		if skinCO then
			return ResUrl.getHeadIconLarge(skinCO.largeIcon)
		end
	end
end

function FightSuccView:_onClickClose()
	if not self._canClick then
		return
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	self:closeThis()

	local storyId = FightModel.instance:getAfterStory()
	local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)
	local noCheckFinish = curChapterConfig.type == DungeonEnum.ChapterType.RoleStory or curChapterConfig.id == DungeonEnum.ChapterId.RoleDuDuGu

	if storyId > 0 and (noCheckFinish or not StoryModel.instance:isStoryFinished(storyId)) then
		FightSuccView._storyId = storyId
		FightSuccView._clientFinish = false
		FightSuccView._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, FightSuccView._finishStoryFromServer)

		local param = {}

		param.mark = true
		param.episodeId = DungeonModel.instance.curSendEpisodeId

		local sceneGo = FightGameMgr.sceneLevelMgr:getSceneGo()

		gohelper.setActive(sceneGo, false)
		StoryController.instance:playStory(storyId, param, function()
			TaskDispatcher.runDelay(FightSuccView.onStoryEnd, nil, 3)

			FightSuccView._clientFinish = true

			FightSuccView.checkStoryEnd()
		end)

		return
	end

	FightSuccView.onStoryEnd()
end

function FightSuccView._finishStoryFromServer(storyId)
	if FightSuccView._storyId == storyId then
		FightSuccView._serverFinish = true

		FightSuccView.checkStoryEnd()
	end
end

function FightSuccView.checkStoryEnd()
	local sceneGo = FightGameMgr.sceneLevelMgr:getSceneGo()

	gohelper.setActive(sceneGo, true)

	if FightSuccView._clientFinish and FightSuccView._serverFinish then
		FightSuccView.onStoryEnd()
	end
end

function FightSuccView.onStoryEnd()
	FightSuccView._storyId = nil
	FightSuccView._clientFinish = false
	FightSuccView._serverFinish = false

	TaskDispatcher.cancelTask(FightSuccView.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, FightSuccView._finishStoryFromServer)
	FightController.onResultViewClose()
end

function FightSuccView:_loadBonusItems()
	self._firstBonusGOList = self:getUserDataTb_()
	self._additionBonusGOList = self:getUserDataTb_()
	self._additionContainerGODict = self:getUserDataTb_()
	self._bonusGOList = self:getUserDataTb_()
	self._moveBonusGOList = self:getUserDataTb_()
	self._extraBonusGOList = self:getUserDataTb_()
	self._containerGODict = self:getUserDataTb_()
	self._extraContainerGODict = self:getUserDataTb_()
	self._delayTime = 0.06
	self._itemDelay = 0.5

	local cost = self._curEpisodeId and tonumber(DungeonConfig.instance:getEndBattleCost(self._curEpisodeId)) or 0

	if cost and cost > 0 then
		table.insert(self._bonusGOList, self._favorIcon)
	end

	gohelper.setActive(self._favorIcon, false)

	local canvasGroup = self._favorIcon:GetComponent(typeof(UnityEngine.CanvasGroup))

	canvasGroup.alpha = 0

	local materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getTimeFirstMaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for k, material in ipairs(materialList) do
			self:_addFirstItem(material)
		end

		self:checkHadHighRareProp(materialList)
	end

	materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getFirstMaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for k, material in ipairs(materialList) do
			self:_addFirstItem(material)
		end

		self:checkHadHighRareProp(materialList)
	end

	materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct155MaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for _, material in ipairs(materialList) do
			if material.materilType == MaterialEnum.MaterialType.Currency and material.materilId == CurrencyEnum.CurrencyType.V1a9Dungeon then
				self:_addFirstItem(material, self.onRefreshV1a7Currency)
			elseif material.materilType == MaterialEnum.MaterialType.PowerPotion and material.materilId == MaterialEnum.PowerId.ActPowerId then
				self:_addFirstItem(material, self.onRefreshV1a7Power)
			elseif material.materilType == MaterialEnum.MaterialType.Currency and material.materilId == CurrencyEnum.CurrencyType.V1a9ToughEnter then
				self:_addFirstItem(material, self.onRefreshToughBattle)
			elseif material.materilType == MaterialEnum.MaterialType.Currency and material.materilId == CurrencyEnum.CurrencyType.V2a2Dungeon then
				self:_addFirstItem(material, self.onRefreshV2a2Dungeon)
			elseif material.materilType == MaterialEnum.MaterialType.Currency and material.materilId == CurrencyEnum.CurrencyType.V2a6Dungeon then
				self:_addFirstItem(material, self.onRefreshV2a6Dungeon)
			elseif material.materilType == MaterialEnum.MaterialType.Currency and material.materilId == CurrencyEnum.CurrencyType.V2a8Dungeon then
				self:_addFirstItem(material, self.onRefreshV2a8Dungeon)
			else
				self:_addFirstItem(material)
			end
		end

		self:checkHadHighRareProp(materialList)
	end

	materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct153MaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for _, material in ipairs(materialList) do
			self:_addAdditionItem(material)
		end

		self:checkHadHighRareProp(materialList)

		if #materialList > 0 then
			local remainTimes, dailyLimit = DoubleDropModel.instance:getDailyRemainTimes()

			if remainTimes and dailyLimit then
				GameFacade.showToast(ToastEnum.DoubleDropTips, remainTimes, dailyLimit)
			end
		end
	end

	materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct217MaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for _, material in ipairs(materialList) do
			self:_addAdditionItem(material)
		end

		self:checkHadHighRareProp(materialList)

		if #materialList > 0 then
			local isMultiDrop, limit, total, magnification, isDaily = Activity217Model.instance:getShowTripleByChapter(self._curChapterId)

			if isMultiDrop and limit > 0 and total then
				local actName = Activity217Model.instance:getActName()

				if isDaily then
					GameFacade.showToast(ToastEnum.MutilDropDaily, actName, limit, total)
				else
					GameFacade.showToast(ToastEnum.MutilDrop, actName, limit, total)
				end
			end
		end
	end

	materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAdditionMaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for _, material in ipairs(materialList) do
			self:_addAdditionItem(material)
		end

		self:checkHadHighRareProp(materialList)
	end

	if FightModel.instance:isEnterUseFreeLimit() then
		local extraList = FightResultModel.instance:getExtraMaterialDataList()

		if extraList then
			local materialList = LuaUtil.deepCopy(ItemModel.instance:processRPCItemList(extraList))

			for k, material in ipairs(materialList) do
				material.bonusTag = FightEnum.FightBonusTag.EquipDailyFreeBonus

				self:_addExtraItem(material)
			end

			self:checkHadHighRareProp(materialList)
		end
	end

	materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getNormal2SimpleMaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for k, material in ipairs(materialList) do
			self:_addFirstItem(material)
		end

		self:checkHadHighRareProp(materialList)
	end

	materialDataList = ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())

	if materialDataList then
		local materialList = LuaUtil.deepCopy(materialDataList)

		for k, material in ipairs(materialList) do
			self:_addNormalItem(material)
		end

		self:checkHadHighRareProp(materialList)
	end

	self._animEventWrap:AddEventListener("bonus", self._showPlayerLevelUpView, self)
end

function FightSuccView:checkHadHighRareProp(materialDataList)
	if self.hadHighRareProp then
		return
	end

	local config

	for _, material in ipairs(materialDataList) do
		config = ItemModel.instance:getItemConfig(tonumber(material.materilType), tonumber(material.materilId))

		if not config or not config.rare then
			logNormal(string.format("[checkMaterialRare] type : %s, id : %s; getConfig error", material.materilType, material.materilId))
		elseif config.rare >= CommonPropListModel.HighRare then
			self.hadHighRareProp = true

			return
		end
	end
end

function FightSuccView:_addFirstItem(material, customRefreshCallback, customRefreshCallbackParam)
	local containerGO, go = self:_addItem(material, customRefreshCallback, customRefreshCallbackParam)

	self._containerGODict[self._delayTime * #self._bonusGOList + self._itemDelay] = containerGO

	table.insert(self._bonusGOList, go)
	table.insert(self._firstBonusGOList, go)
end

function FightSuccView:_addAdditionItem(material)
	local containerGO, go = self:_addItem(material)

	self._additionContainerGODict[self._delayTime * #self._additionBonusGOList + self._itemDelay] = containerGO

	table.insert(self._additionBonusGOList, go)
end

function FightSuccView:_addExtraItem(material)
	local containerGO, go = self:_addItem(material)

	self._extraContainerGODict[self._delayTime * #self._extraBonusGOList + self._itemDelay] = containerGO

	table.insert(self._extraBonusGOList, go)
end

function FightSuccView:_addNormalItem(material)
	local containerGO, go = self:_addItem(material)

	self._containerGODict[self._delayTime * #self._bonusGOList + self._itemDelay] = containerGO

	table.insert(self._bonusGOList, go)
	table.insert(self._moveBonusGOList, go)
end

function FightSuccView:_addItem(material, customRefreshCallback, customRefreshCallbackParam)
	local go = gohelper.clone(self._bonusItemGo, self._bonusItemContainer, material.id)
	local itemIconGO = gohelper.findChild(go, "container/itemIcon")
	local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemIconGO)
	local tagGO = gohelper.findChild(go, "container/tag")
	local imgFirstGO = gohelper.findChild(go, "container/tag/imgFirst")
	local imgFirstHardGO = gohelper.findChild(go, "container/tag/imgFirstHard")
	local imgFirstSimpleGO = gohelper.findChild(go, "container/tag/imgFirstSimple")
	local imgNormalGO = gohelper.findChild(go, "container/tag/imgNormal")
	local imgAdvanceGO = gohelper.findChild(go, "container/tag/imgAdvance")
	local imgEquipDailyGO = gohelper.findChild(go, "container/tag/imgEquipDaily")
	local imgTimeFirstGO = gohelper.findChild(go, "container/tag/limitfirstbg")
	local actTagGo = gohelper.findChild(go, "container/tag/imgact")
	local containerGO = gohelper.findChild(go, "container")

	gohelper.setActive(containerGO, false)
	gohelper.setActive(tagGO, material.bonusTag)

	if material.bonusTag then
		gohelper.setActive(imgFirstGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and self._normalMode)
		gohelper.setActive(imgFirstHardGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and self._hardMode)
		gohelper.setActive(imgNormalGO, false)
		gohelper.setActive(imgAdvanceGO, material.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(imgEquipDailyGO, material.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
		gohelper.setActive(imgTimeFirstGO, material.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus)
		gohelper.setActive(actTagGo, material.bonusTag == FightEnum.FightBonusTag.ActBonus)
		gohelper.setActive(imgFirstSimpleGO, material.bonusTag ~= FightEnum.FightBonusTag.SimpleBouns and FightEnum.FightBonusTag.FirstBonus and self._simpleMode or true)
	end

	material.isIcon = true

	itemIcon:onUpdateMO(material)
	itemIcon:setCantJump(true)
	itemIcon:setCountFontSize(40)
	itemIcon:setAutoPlay(true)
	itemIcon:isShowEquipRefineLv(true)
	itemIcon:isShowAddition((material.bonusTag and material.bonusTag == FightEnum.FightBonusTag.AdditionBonus or nil) and true)

	if customRefreshCallback then
		customRefreshCallback(self, itemIcon, customRefreshCallbackParam)
	end

	gohelper.setActive(go, false)

	local canvasGroup = tagGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	canvasGroup.alpha = 0

	self:applyBonusVfx(material, go)

	return containerGO, go
end

function FightSuccView:applyBonusVfx(material, go)
	local config = ItemModel.instance:getItemConfig(material.materilType, material.materilId)
	local rare = config.rare

	rare = material.materilType == MaterialEnum.MaterialType.PlayerCloth and (rare or 5) or rare or 1

	for i = 1, 6 do
		local vx = gohelper.findChild(go, "vx/" .. i)

		gohelper.setActive(vx, i == rare)
	end

	local canShowVfx = ItemModel.canShowVfx(material.materilType, config, rare)

	for i = 4, 5 do
		local spVfx = gohelper.findChild(go, "vx/" .. i .. "/#teshudaoju")

		if i == rare and canShowVfx then
			gohelper.setActive(spVfx, false)
			gohelper.setActive(spVfx, true)
		else
			gohelper.setActive(spVfx, false)
		end
	end
end

function FightSuccView:onRefreshV1a7Currency(iconComp)
	local itemIcon = iconComp._itemIcon

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function FightSuccView:onRefreshV1a7Power(iconComp)
	local itemIcon = iconComp._itemIcon

	itemIcon:setCanShowDeadLine(false)

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function FightSuccView:onRefreshToughBattle(iconComp)
	local itemIcon = iconComp._itemIcon

	itemIcon:setCanShowDeadLine(false)

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function FightSuccView:onRefreshV2a2Dungeon(iconComp)
	local itemIcon = iconComp._itemIcon

	itemIcon:setCanShowDeadLine(false)

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function FightSuccView:onRefreshV2a6Dungeon(iconComp)
	local itemIcon = iconComp._itemIcon

	itemIcon:setCanShowDeadLine(false)

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function FightSuccView:onRefreshV2a8Dungeon(iconComp)
	local itemIcon = iconComp._itemIcon

	itemIcon:setCanShowDeadLine(false)

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function FightSuccView:_showRecordFarmItem()
	local episodeId = FightResultModel.instance:getEpisodeId()
	local recordFarmItem = JumpModel.instance:getRecordFarmItem()
	local show = FightSuccView.checkRecordFarmItem(episodeId, recordFarmItem)

	gohelper.setActive(self._godemand, show)

	if show then
		local canvasGroup = self._godemand:GetComponent(typeof(UnityEngine.CanvasGroup))

		canvasGroup.alpha = 0
		self._farmTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self._godemand, 0, 1, 0.3, nil, nil, nil, EaseType.Linear)

		if recordFarmItem.special then
			self._txtdemand.text = recordFarmItem.desc

			gohelper.setActive(self._btnbacktosource.gameObject, true)
		else
			local config = ItemModel.instance:getItemConfig(recordFarmItem.type, recordFarmItem.id)
			local quantity = ItemModel.instance:getItemQuantity(recordFarmItem.type, recordFarmItem.id)

			if recordFarmItem.quantity then
				local enough = quantity >= recordFarmItem.quantity

				self._txtdemand.text = enough and string.format("%s %s <color=#81ce83>%s</color>/%s", luaLang("fightsuccview_demand"), config.name, GameUtil.numberDisplay(quantity), GameUtil.numberDisplay(recordFarmItem.quantity)) or string.format("%s %s <color=#cc492f>%s</color>/%s", luaLang("fightsuccview_demand"), config.name, GameUtil.numberDisplay(quantity), GameUtil.numberDisplay(recordFarmItem.quantity))

				gohelper.setActive(self._btnbacktosource.gameObject, true)
			else
				self._txtdemand.text = string.format("%s%s<color=#81ce83>%s</color>", config.name, luaLang("fightsuccview_quantity"), GameUtil.numberDisplay(quantity))

				gohelper.setActive(self._btnbacktosource.gameObject, true)
			end
		end
	else
		JumpModel.instance:clearRecordFarmItem()
	end
end

function FightSuccView.checkRecordFarmItem(episodeId, recordFarmItem)
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
		::label_48_0::

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeConfig then
			return false
		end

		if FightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeFirstBonus(episodeId), recordFarmItem) then
			return true
		end

		if FightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeAdvancedBonus(episodeId), recordFarmItem) then
			return true
		end

		if FightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeBonus(episodeId), recordFarmItem) then
			return true
		end

		if FightSuccView.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeRewardList(episodeId), recordFarmItem) then
			return true
		end

		return false
	end
end

function FightSuccView.checkRecordFarmItemByReward(rewardList, recordFarmItem)
	for i, reward in ipairs(rewardList) do
		if tonumber(reward[1]) == recordFarmItem.type and tonumber(reward[2]) == recordFarmItem.id then
			return true
		end
	end

	return false
end

function FightSuccView:_showCharacterGetView()
	PopupController.instance:setPause("fightsuccess", false)

	self._canClick = true
end

function FightSuccView:_showBonus()
	if self.hadHighRareProp then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_resources)
	end

	local count = #self._bonusGOList

	if count <= 0 then
		self:_showRecordFarmItem()
		self:_showCharacterGetView()

		return
	end

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self.popupFlow = FlowSequence.New()

	self.popupFlow:addWork(FightSuccShowBonusWork.New(self._bonusGOList, self._containerGODict, self._delayTime, self._itemDelay))
	self.popupFlow:addWork(FightSuccShowExtraBonusWork.New(self._extraBonusGOList, self._extraContainerGODict, self._showBonusEffect, self, self._moveBonusGOList, self._bonusItemContainer, self._delayTime, self._itemDelay))
	self.popupFlow:addWork(FightSuccShowExtraBonusWork.New(self._additionBonusGOList, self._additionContainerGODict, self._showBonusEffect, self, self._moveBonusGOList, self._bonusItemContainer, self._delayTime, self._itemDelay))
	self.popupFlow:registerDoneListener(self._onAllTweenFinish, self)
	self.popupFlow:start()
end

function FightSuccView:_showBonusEffect()
	local effectGo = gohelper.findChild(self.viewGO, "#reward_vx")

	gohelper.setActive(effectGo, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_extrafall)

	if #self._firstBonusGOList > 0 then
		recthelper.setAnchorX(effectGo.transform, 169)
	end
end

function FightSuccView:_onAllTweenFinish()
	self:_showRecordFarmItem()
	self:_showCharacterGetView()

	if self.viewContainer.fightSuccActView then
		self.viewContainer.fightSuccActView:showReward()
	end
end

function FightSuccView:_showPlayerLevelUpView()
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	local levelup = PlayerModel.instance:getAndResetPlayerLevelUp()

	if levelup > 0 then
		ViewMgr.instance:openView(ViewName.PlayerLevelUpView, levelup)
	else
		self:_showBonus()
	end
end

function FightSuccView:_onCloseView(viewName)
	if viewName == ViewName.PlayerLevelUpView or viewName == ViewName.SeasonLevelView then
		self:_showBonus()
	end
end

function FightSuccView:_onClickData()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function FightSuccView:_onClickBackToSource()
	local recordFarmItem = JumpModel.instance:getRecordFarmItem()

	if recordFarmItem then
		recordFarmItem.canBackSource = true
	end

	self:closeThis()
	FightSuccView.onStoryEnd()
end

function FightSuccView:showUnLockCurrentEpisodeNewMode()
	local actId = ActivityConfig.instance:getActIdByChapterId(self._curChapterId)

	if not actId then
		return
	end

	local activityCo = ActivityConfig.instance:getActivityDungeonConfig(actId)

	if not activityCo then
		return
	end

	if activityCo.story1ChapterId ~= self._curChapterId and activityCo.story2ChapterId ~= self._curChapterId then
		return
	end

	if not DungeonModel.instance.curSendEpisodePass then
		return
	end

	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(lua_episode.configDict[self._curEpisodeId])

	if not episodeList or #episodeList <= 1 then
		return
	end

	local chapterMode = ActivityConfig.instance:getChapterIdMode(self._curChapterId)

	GameFacade.showToast(ToastEnum.UnLockCurrentEpisode, luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[chapterMode + 1]))
end

function FightSuccView:_hideGoDemand()
	gohelper.setActive(self._godemand, false)
end

function FightSuccView:_show1_2DailyEpisodeEndNotice()
	local config = lua_activity116_episode_sp.configDict[self._curEpisodeId]

	if config then
		ToastController.instance:showToastWithString(config.endShow)
	end
end

function FightSuccView:_showWeekWalk_2Condition()
	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]
	local isWeekWalk_2 = curEpisodeConfig and curEpisodeConfig.type == DungeonEnum.EpisodeType.WeekWalk_2

	if not isWeekWalk_2 then
		return
	end

	local cupInfos = WeekWalk_2Model.instance:getResultCupInfos()

	if not cupInfos then
		return
	end

	for i, v in ipairs(cupInfos) do
		local conditionItem = gohelper.cloneInPlace(self._goweekwalkcontentitem)

		self:_showWeekWalkVer2OneTaskGroup(conditionItem, v, i)
	end

	gohelper.setActive(self._goalcontent, false)
	gohelper.setActive(self._goweekwalkgoalcontent, true)
end

function FightSuccView:_showWeekWalkVer2OneTaskGroup(obj, cupInfo, index)
	local config = cupInfo.config
	local text = gohelper.findChildText(obj, "condition")

	text.text = config["desc" .. cupInfo.result] or config.desc1

	local cupImage = gohelper.findChildImage(obj, "star")

	cupImage.enabled = false

	local iconEffect = self:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, cupImage.gameObject)

	WeekWalk_2Helper.setCupEffect(iconEffect, cupInfo)
	gohelper.setActive(obj, true)
end

function FightSuccView:_show1_6EpisodeMaterial()
	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]
	local is1_6Episode = curEpisodeConfig and curEpisodeConfig.type == DungeonEnum.EpisodeType.Act1_6Dungeon
	local isAct148Unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	if not is1_6Episode or not isAct148Unlock then
		gohelper.setActive(self._goPlatConditionMaterial, false)

		return
	end

	gohelper.setActive(self._goPlatConditionMaterial, true)

	local platConditionText, starImage, targetStarNum
	local icon = gohelper.findChildImage(self._goPlatConditionMaterial, "icon")
	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local currencyname = string.format("%s_1", currencyCfg and currencyCfg.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(icon, currencyname)

	local maxSkillPointNum = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local totalGotSkillPointNum = VersionActivity1_6DungeonSkillModel.instance:getAllSkillPoint()
	local totalGotSkillPointStr = string.format("<color=#EB5F34>%s</color>/%s", totalGotSkillPointNum or 0, maxSkillPointNum)
	local valueText = gohelper.findChildText(self._goPlatConditionMaterial, "value")

	valueText.text = totalGotSkillPointStr

	local titleText = gohelper.findChildText(self._goPlatConditionMaterial, "condition")

	titleText.text = luaLang("act1_6dungeonFightResultViewMaterialTitle")
end

function FightSuccView:_playVictoryAudio_2_7()
	if LuaUtil.tableContains(VersionActivity2_7DungeonEnum.DungeonChapterId, FightResultModel.instance:getChapterId()) then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString("Checkpointstate"), AudioMgr.instance:getIdFromString("Victory"))
	end
end

return FightSuccView
