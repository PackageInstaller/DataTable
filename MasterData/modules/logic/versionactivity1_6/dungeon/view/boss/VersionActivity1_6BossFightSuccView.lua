-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6BossFightSuccView.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossFightSuccView", package.seeall)

local VersionActivity1_6BossFightSuccView = class("VersionActivity1_6BossFightSuccView", BaseView)

function VersionActivity1_6BossFightSuccView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "btnData")
	self._simagecharacterbg = gohelper.findChildSingleImage(self.viewGO, "#simage_characterbg")
	self._simagemaskImage = gohelper.findChildSingleImage(self.viewGO, "#simage_maskImage")
	self._gospine = gohelper.findChild(self.viewGO, "spineContainer/spine")
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)
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
	self._txtcurroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	self._txtmaxroundcount = gohelper.findChildText(self.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	self._goCoverLessThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	self._goCoverMuchThan = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	self._goCoverEqual = gohelper.findChild(self.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	self.txtScore = gohelper.findChildText(self.viewGO, "goRoleStorytips/#txt_num")
	self._goscoreTips = gohelper.findChild(self.viewGO, "Tips")
	self._btnTips = gohelper.findChildButtonWithAudio(self.viewGO, "goRoleStorytips/txt_tips/icon")
	self.gofirstPass = gohelper.findChild(self.viewGO, "firstpass")
	self.txtFirstPassScore = gohelper.findChildText(self.gofirstPass, "count")
	self.txtHurtScore = gohelper.findChildText(self.gofirstPass, "Tips/image_TipsBG/layout/txt_tips/value")
	self.txtmultiple = gohelper.findChildText(self.gofirstPass, "Tips/image_TipsBG/layout/txt_tips1/value")
	self.totoalScore = gohelper.findChildText(self.gofirstPass, "Tips/image_TipsBG/layout/txt_tips2/value")
	self.gofightgoal = gohelper.findChild(self.viewGO, "fightgoal")
	self.txtCondition = gohelper.findChildText(self.gofightgoal, "condition")
	self.txtWave = gohelper.findChildText(self.gofightgoal, "count")
end

function VersionActivity1_6BossFightSuccView:addEvents()
	self._click:AddClickListener(self._onClickClose, self)
	self._btnData:AddClickListener(self._onClickData, self)
	self._btnTips:AddClickListener(self._onClickTips, self)
end

function VersionActivity1_6BossFightSuccView:removeEvents()
	self._click:RemoveClickListener()
	self._btnData:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function VersionActivity1_6BossFightSuccView:onOpen()
	self._canClick = false
	self._animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	self._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	self._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(self._bonusItemGo, false)
	gohelper.setActive(self._goscoreTips, false)
	gohelper.setActive(self.gofirstPass, false)
	gohelper.setActive(self._btnTips.gameObject, false)

	self._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	self._curChapterId = DungeonModel.instance.curSendChapterId

	local fightResultModel = FightResultModel.instance
	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]
	local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)

	if curEpisodeConfig then
		if not curEpisodeConfig.type then
			self._curEpisodeId = FightResultModel.instance.episodeId
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
			NavigateMgr.instance:addEscape(ViewName.VersionActivity1_6BossFightSuccView, self._onClickClose, self)

			self._canPlayVoice = false

			TaskDispatcher.runDelay(self._setCanPlayVoice, self, 0.9)
			TaskDispatcher.runDelay(self._playScoreSound, self, 1)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
			self:showWave()
			self:showScore()
			self:_refreshFirstPassTxt()
		end
	end
end

function VersionActivity1_6BossFightSuccView:onClose()
	self._canPlayVoice = false

	TaskDispatcher.cancelTask(self._setCanPlayVoice, self)
	TaskDispatcher.cancelTask(self._playScoreSound, self)
	gohelper.setActive(self._gospine, false)

	if FightResultModel.instance.canUpdateDungeonRecord and not self._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end
end

function VersionActivity1_6BossFightSuccView:onCloseFinish()
	self._simagecharacterbg:UnLoadImage()
	self._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	self._animEventWrap:RemoveAllEventListener()

	if self._farmTweenId then
		ZProj.TweenHelper.KillById(self._farmTweenId)
	end
end

function VersionActivity1_6BossFightSuccView:_setFbName(episodeCO)
	local normalEpisodeId = DungeonConfig.instance:getNormalEpisodeId(episodeCO.id)
	local normalEpisodeCO = DungeonConfig.instance:getEpisodeCO(normalEpisodeId)
	local chapterCO = DungeonConfig.instance:getChapterCO(normalEpisodeCO.chapterId)
	local chapterIndex, _ = DungeonConfig.instance:getChapterIndex(chapterCO.type, normalEpisodeCO.chapterId)
	local episodeIndex, _ = DungeonConfig.instance:getChapterEpisodeIndexWithSP(normalEpisodeCO.chapterId, normalEpisodeId)

	self._txtChapterIndex.text = chapterCO.chapterIndex
	self._txtFbNameEn.text = episodeCO.name_En

	self:_setEpisodeName(episodeCO, episodeIndex)
	self:_setTag(episodeCO)
end

function VersionActivity1_6BossFightSuccView:_setTag(episodeCO)
	local typeList = lua_const.configDict[ConstEnum.DungeonSuccessType].value
	local list = string.splitToNumber(typeList, "#")
	local visible = tabletool.indexOf(list, episodeCO.type)

	gohelper.setActive(self._gonormaltag, visible)
	gohelper.setActive(self._goroletag, not visible)
end

function VersionActivity1_6BossFightSuccView:_setEpisodeName(episodeCO, episodeIndex)
	local fightParam = FightModel.instance:getFightParam()
	local bossEpisodeCfg = Activity149Config.instance:getAct149EpisodeCfgByEpisodeId(episodeCO.id)

	self._txtFbName.text = episodeCO.name
	self._txtEpisodeIndex.text = bossEpisodeCfg.order
end

function VersionActivity1_6BossFightSuccView:_refreshFirstPassTxt()
	local isFirstPass = FightResultModel.instance.firstPass

	gohelper.setActive(self.gofirstPass, isFirstPass)

	if not isFirstPass then
		return
	end

	local episodeId = self._curEpisodeId
	local bossEpisodeCfg = Activity149Config.instance:getAct149EpisodeCfgByEpisodeId(episodeId)

	self.txtFirstPassScore.text = bossEpisodeCfg.firstPassScore
end

function VersionActivity1_6BossFightSuccView:_getRandomEntityMO()
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

function VersionActivity1_6BossFightSuccView:_getSkin(mo)
	local skinCO = FightConfig.instance:getSkinCO(mo.skin)
	local hasVerticalDrawing = skinCO and not string.nilorempty(skinCO.verticalDrawing)
	local hasLive2d = skinCO and not string.nilorempty(skinCO.live2d)

	if hasVerticalDrawing or hasLive2d then
		return skinCO
	end
end

function VersionActivity1_6BossFightSuccView:_setSpineVoice()
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

		recthelper.setAnchor(self._gospine.transform, offsetX, offsetY)
		transformhelper.setLocalScale(self._gospine.transform, scale, scale, scale)
	else
		gohelper.setActive(self._gospine, false)
	end
end

function VersionActivity1_6BossFightSuccView:_playSpineVoice()
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

function VersionActivity1_6BossFightSuccView:_getSayContent(contentStr)
	local temp = GameUtil.splitString2(contentStr, false, "|", "#")
	local ans = ""

	for _, temp2 in ipairs(temp) do
		ans = ans .. temp2[1]
	end

	return ans
end

function VersionActivity1_6BossFightSuccView:_setCanPlayVoice()
	self._canPlayVoice = true

	self:_playSpineVoice()
end

function VersionActivity1_6BossFightSuccView._finishStoryFromServer(storyId)
	if VersionActivity1_6BossFightSuccView._storyId == storyId then
		VersionActivity1_6BossFightSuccView._serverFinish = true

		VersionActivity1_6BossFightSuccView.checkStoryEnd()
	end
end

function VersionActivity1_6BossFightSuccView.checkStoryEnd()
	if VersionActivity1_6BossFightSuccView._clientFinish and VersionActivity1_6BossFightSuccView._serverFinish then
		VersionActivity1_6BossFightSuccView.onStoryEnd()
	end
end

function VersionActivity1_6BossFightSuccView.onStoryEnd()
	VersionActivity1_6BossFightSuccView._storyId = nil
	VersionActivity1_6BossFightSuccView._clientFinish = false
	VersionActivity1_6BossFightSuccView._serverFinish = false

	TaskDispatcher.cancelTask(VersionActivity1_6BossFightSuccView.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, VersionActivity1_6BossFightSuccView._finishStoryFromServer)
	FightController.onResultViewClose()
end

function VersionActivity1_6BossFightSuccView:_showCharacterGetView()
	PopupController.instance:setPause("fightsuccess", false)

	self._canClick = true
end

function VersionActivity1_6BossFightSuccView:showWave()
	local wave = FightModel.instance:getCurWaveId()
	local maxwave = FightModel.instance.maxWave

	self.txtCondition.text = luaLang("dungeon_beat_all")

	local list = FightDataHelper.entityMgr:getEnemyNormalList()

	if list and #list > 0 then
		wave = wave - 1
	end

	self.txtWave.text = string.format("<color=#E57937>%s</color>/%s", wave, maxwave)
end

function VersionActivity1_6BossFightSuccView:showScore()
	self.txtScore.text = VersionActivity1_6DungeonBossModel.instance:getFightScore()

	self:_onAllTweenFinish()
end

function VersionActivity1_6BossFightSuccView:_onAllTweenFinish()
	self:_showCharacterGetView()
end

function VersionActivity1_6BossFightSuccView:_onClickClose()
	if not self._canClick then
		return
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	self:closeThis()

	local storyId = FightModel.instance:getAfterStory()

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		VersionActivity1_6BossFightSuccView._storyId = storyId
		VersionActivity1_6BossFightSuccView._clientFinish = false
		VersionActivity1_6BossFightSuccView._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, VersionActivity1_6BossFightSuccView._finishStoryFromServer)

		local param = {}

		param.mark = true
		param.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(storyId, param, function()
			TaskDispatcher.runDelay(VersionActivity1_6BossFightSuccView.onStoryEnd, nil, 3)

			VersionActivity1_6BossFightSuccView._clientFinish = true

			VersionActivity1_6BossFightSuccView.checkStoryEnd()
		end)

		return
	end

	VersionActivity1_6BossFightSuccView.onStoryEnd()
end

function VersionActivity1_6BossFightSuccView:_onClickData()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function VersionActivity1_6BossFightSuccView:_onClickTips()
	gohelper.setActive(self._goscoreTips, true)
end

function VersionActivity1_6BossFightSuccView:_onClickTipsClose()
	gohelper.setActive(self._goscoreTips, false)
end

function VersionActivity1_6BossFightSuccView:_playScoreSound()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossFightResultScore)
end

return VersionActivity1_6BossFightSuccView
