-- chunkname: @modules/logic/fight/view/FightQuitTipView.lua

module("modules.logic.fight.view.FightQuitTipView", package.seeall)

local FightQuitTipView = class("FightQuitTipView", BaseView)
local Status = {
	Tip = 1,
	Confirm = 2
}

function FightQuitTipView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "#go_quitshowview/center/layout/#simage_maskbg")
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#go_quittipview/#simage_tipbg")
	self._goquitshowview = gohelper.findChild(self.viewGO, "#go_quitshowview")
	self._goquittipview = gohelper.findChild(self.viewGO, "#go_quittipview")
	self._gopasstarget = gohelper.findChild(self.viewGO, "#go_quitshowview/center/layout/passtarget")
	self._goconditionitem = gohelper.findChild(self.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem")
	self._goconditionitemdesc = gohelper.findChild(self.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/desc")
	self._goquitfight = gohelper.findChild(self.viewGO, "#go_quittipview/tipcontent/#go_quitfight")
	self._goadditiondetail = gohelper.findChild(self.viewGO, "#go_quitshowview/#go_additiondetail")
	self._btncloserule = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/#go_additiondetail/#btn_closerule")
	self._goruleDescList = gohelper.findChild(self.viewGO, "#go_quitshowview/#go_additiondetail/bg/#go_ruleDescList")
	self._goruleitem = gohelper.findChild(self.viewGO, "#go_quitshowview/#go_additiondetail/bg/#go_ruleDescList/#go_ruleitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_restart")
	self._btnfighttechnical = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_fighttechnical")
	self._btnrouge = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_rouge")
	self._btnrouge2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_rouge2")
	self._gocareercontent = gohelper.findChild(self.viewGO, "#go_quitshowview/center/layout/careerContent/#go_careercontent")
	self._btncontinuegame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_continuegame")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quittipview/#btn_sure")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quittipview/#btn_no")
	self._simagenumline = gohelper.findChildSingleImage(self.viewGO, "#go_quittipview/num")
	self._btnProtectMode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_protectmode")
	self.goEyeModeOn = gohelper.findChild(self.viewGO, "#go_quitshowview/center/btn/#btn_protectmode/#go_on")
	self.goEyeModeOff = gohelper.findChild(self.viewGO, "#go_quitshowview/center/btn/#btn_protectmode/#go_off")
	self._btnbackherogroup = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_backherogroup")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightQuitTipView:addEvents()
	self._btnquitgame:AddClickListener(self._btnyesOnClick, self)
	self._btnrestart:AddClickListener(self._btnRestart, self)
	self._btnbackherogroup:AddClickListener(self._btnBackHeroGroup, self)
	self._btnfighttechnical:AddClickListener(self._btnfighttechnicalOnClick, self)
	self._btnrouge:AddClickListener(self._btnrougeOnClick, self)
	self._btnrouge2:AddClickListener(self._btnrouge2OnClick, self)
	self._btncontinuegame:AddClickListener(self._onBtnContinueGame, self)
	self._btncloserule:AddClickListener(self._onBtnContinueGame, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._btncloserule:AddClickListener(self._btncloseruleOnClick, self)
	self._btnProtectMode:AddClickListener(self._onClickProtectMode, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonCancel, self._btnnoOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonConfirm, self._onKeyExit, self)
end

function FightQuitTipView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnbackherogroup:RemoveClickListener()
	self._btnfighttechnical:RemoveClickListener()
	self._btnrouge:RemoveClickListener()
	self._btnrouge2:RemoveClickListener()
	self._btncontinuegame:RemoveClickListener()
	self._btnsure:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._btncloserule:RemoveClickListener()
	self._btnProtectMode:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonCancel, self._btnnoOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyCommonConfirm, self._onKeyExit, self)
end

function FightQuitTipView:_onClickProtectMode()
	EyeProtectionModeMgr.instance:changeEyeModeActive()
	self:refreshEyeModeUI()
end

function FightQuitTipView:refreshEyeModeUI()
	local active = EyeProtectionModeMgr.instance:getEyeModeActive()

	gohelper.setActive(self.goEyeModeOn, active)
	gohelper.setActive(self.goEyeModeOff, not active)
end

function FightQuitTipView:_btnBackHeroGroup()
	if not isDebugBuild then
		return
	end

	FightController.instance:setBackToHeroGroup(true)
	self:closeThis()

	if not FightModel.instance:getFightParam().isTestFight then
		DungeonFightController.instance:sendEndFightRequest(true, DungeonEnum.EndType.Exit)
	else
		FightRpc.instance:sendEndFightRequest(true)
	end
end

function FightQuitTipView:_onOpenView(viewName)
	if viewName == ViewName.GuideView then
		self:closeThis()
	end
end

function FightQuitTipView:_btnyesOnClick()
	self.status = Status.Confirm

	self:_refreshUI()
	gohelper.setActive(self._goquitshowview, false)
	self:_setQuitText()
end

function FightQuitTipView:_btnRestart()
	if FightDataHelper.stateMgr.isReplay then
		return false
	end

	if FightDataHelper.stateMgr.isFinish then
		ToastController.instance:showToast(-80)

		return
	end

	FightGameMgr.restartMgr:restart()
end

function FightQuitTipView:_setQuitText()
	if self._descTxt then
		return
	end

	self._descTxt = gohelper.findChildText(self._goquitfight, "desc")

	local config = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if config then
		if config.type == DungeonEnum.EpisodeType.WeekWalk or config.type == DungeonEnum.EpisodeType.Season then
			self._descTxt.text = luaLang("quit_fight_weekwalk")

			return
		elseif config.type == DungeonEnum.EpisodeType.Cachot then
			self._descTxt.text = luaLang("cachot_quit_fight")

			return
		elseif config.type == DungeonEnum.EpisodeType.Rouge then
			self._descTxt.text = luaLang("rouge_quit_fight_confirm")

			return
		end
	end

	if config then
		::label_10_0::

		local chapterConfig = DungeonConfig.instance:getChapterCO(config.chapterId)

		if chapterConfig and chapterConfig.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(chapterConfig.type) > 0 then
			self._descTxt.text = lua_language_coder.configDict.quit_fight_equip_1.lang

			return
		end

		local endBattleCost = tonumber(DungeonConfig.instance:getEndBattleCost(self._episodeId, false)) or 0

		if endBattleCost <= 0 then
			self._descTxt.text = lua_language_coder.configDict.quit_fight_weekwalk.lang

			return
		end

		if self._episodeId then
			local episodeInfo = DungeonModel.instance:getEpisodeInfo(self._episodeId)
			local fightParam = FightModel.instance:getFightParam()

			if fightParam then
				if not fightParam.multiplication then
					self._descTxt.text = luaLang("confirm_quit")
				end
			end
		end
	end
end

function FightQuitTipView:_onKeyExit()
	if self._goquitshowview and not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		self:_btnsureOnClick()
	end
end

function FightQuitTipView:_btnsureOnClick()
	self:closeThis()

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		FightSystem.instance:dispose()
		FightModel.instance:clearRecordMO()
		FightController.instance:exitFightScene()

		return
	end

	if not FightDataHelper.stateMgr.isFinish then
		if not FightModel.instance:getFightParam().isTestFight then
			DungeonFightController.instance:sendEndFightRequest(true, DungeonEnum.EndType.Exit)
		else
			FightRpc.instance:sendEndFightRequest(true)
		end
	end
end

function FightQuitTipView:_btnnoOnClick()
	self.status = Status.Tip

	self:_refreshUI()
	gohelper.setActive(self._goquitshowview, true)
end

function FightQuitTipView:_onBtnContinueGame()
	self:closeThis()
	FightController.instance:dispatchEvent(FightEvent.OnFightQuitTipViewClose)
end

function FightQuitTipView:_btncloseruleOnClick()
	gohelper.setActive(self._goadditiondetail, false)
end

function FightQuitTipView:_btnfighttechnicalOnClick()
	FightController.instance:openFightTechniqueView()
end

function FightQuitTipView:_btnrougeOnClick()
	FightController.instance:openFightTechniqueView()
end

function FightQuitTipView:_btnrouge2OnClick()
	ViewMgr.instance:openView(ViewName.FightRouge2TechniqueView)
end

function FightQuitTipView:_editableInitView()
	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
	self._simagemaskbg:LoadImage(ResUrl.getFightIcon("img_zanting_bg.png"))
	self._simagenumline:LoadImage(ResUrl.getMessageIcon("bg_num"))

	self._episodeId = DungeonModel.instance.curSendEpisodeId
	self._chapterId = DungeonModel.instance.curSendChapterId

	local chapterCo = DungeonConfig.instance:getChapterCO(self._chapterId)

	self._hardMode = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Hard
	self._weekwalkMode = chapterCo and chapterCo.type == DungeonEnum.ChapterType.WeekWalk
	self._rougeMode = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Rouge

	if self._hardMode then
		self._episodeId = DungeonConfig.instance:getHardEpisode(self._episodeId).id
	end

	gohelper.setActive(self._goruleitem, false)
	gohelper.setActive(self._goadditiondetail, false)

	self._ruleItemsImage = self:getUserDataTb_()
	self._ruleItemsDescImage = self:getUserDataTb_()

	for i = 1, 6 do
		local career = gohelper.findChildImage(self._gocareercontent, "career" .. i)

		UISpriteSetMgr.instance:setCommonSprite(career, "lssx_" .. i)
	end

	gohelper.addUIClickAudio(self._btnquitgame.gameObject, AudioEnum.UI.Play_UI_Rolesback)
	gohelper.addUIClickAudio(self._btncontinuegame.gameObject, AudioEnum.UI.Play_UI_Tags)
	gohelper.addUIClickAudio(self._btnsure.gameObject, AudioEnum.UI.Play_UI_Rolesout)
	gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.Play_UI_Tags)

	local btnsureTips = gohelper.findChild(self._btnsure.gameObject, "#go_pcbtn")
	local btnnoTips = gohelper.findChild(self._btnno.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(btnsureTips, nil, nil, "Return")
	PCInputController.instance:showkeyTips(btnnoTips, nil, nil, "Esc")
end

function FightQuitTipView:onUpdateParam()
	return
end

function FightQuitTipView:onOpen()
	gohelper.setActive(self._btnbackherogroup.gameObject, isDebugBuild)

	if self:episodeNeedHideRestart() then
		gohelper.setActive(self._btnrestart.gameObject, false)
	else
		gohelper.setActive(self._btnrestart.gameObject, not FightDataHelper.stateMgr.isReplay)
	end

	self.status = Status.Tip

	self:_loadCondition()
	self:_refreshUI()

	local isOpenShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightTechnique)

	gohelper.setActive(self._btnfighttechnical.gameObject, isOpenShow and not self._rougeMode)
	gohelper.setActive(self._btnrouge.gameObject, isOpenShow and self._rougeMode)
	gohelper.setActive(self._btnrouge2.gameObject, FightDataHelper.fieldMgr:isRouge2())
	NavigateMgr.instance:addEscape(ViewName.FightQuitTipView, self._onBtnContinueGame, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_fight_keeporquit)
	FightAudioMgr.instance:obscureBgm(true)
	self:refreshEyeModeUI()
end

function FightQuitTipView:episodeNeedHideRestart()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeConfig and self:checkNeedHideRestartEpisodeType(episodeConfig.type) then
		return true
	end

	if episodeConfig then
		local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if not FightRestartSequence.RestartType2Type[chapterConfig.type] then
			if chapterConfig and not _G["FightRestartAbandonType" .. FightRestartSequence.RestartType2Type[chapterConfig.type]] then
				return true
			end
		end
	end

	return false
end

function FightQuitTipView:checkNeedHideRestartEpisodeType(episodeType)
	self._hideRestartEpisodeTypes = self._hideRestartEpisodeTypes or {
		[DungeonEnum.EpisodeType.Dog] = true,
		[DungeonEnum.EpisodeType.Act1_6DungeonBoss] = true
	}

	return self._hideRestartEpisodeTypes[episodeType]
end

function FightQuitTipView:_refreshUI()
	local isTiping = self.status == Status.Tip

	gohelper.setActive(self._goquitshowview, isTiping)
	gohelper.setActive(self._goquittipview, not isTiping)
end

function FightQuitTipView:_loadCondition()
	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.WeekwalkVer2] then
		self:_refreshWeekwalkVer2Condition()

		return
	end

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Odyssey]

	if customData and customData.elementId and customData.elementId ~= 0 and self:refreshOdysseyTask(customData) then
		return
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(self._episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeConfig then
		if episodeConfig.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
			gohelper.setActive(self._gopasstarget, false)

			return
		elseif SeasonFightHandler.loadSeasonCondition(episodeConfig.type, self._gopasstarget, self._goconditionitemdesc, self._goconditionitem) then
			return
		elseif VersionActivity2_9DungeonHelper.loadFightCondition(self, self._episodeId, self._gopasstarget) then
			return
		elseif AbyssHelper.loadFightCondition(self, episodeConfig.type, self._episodeId, self._gopasstarget, self._goconditionitemdesc, self._goconditionitem) then
			return
		end
	end

	local condition = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())

	if BossRushController.instance:isInBossRushInfiniteFight() then
		condition = luaLang("v1a4_bossrushleveldetail_txt_target")
	end

	local episodeId = FightDataHelper.fieldMgr.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	self:_setConditionText(self._goconditionitemdesc, (episodeConfig and episodeConfig.type == DungeonEnum.EpisodeType.V3_2ZongMao or nil) and luaLang("v1a4_bossrushleveldetail_txt_target"), false)
	self:_setStarStatus(self._goconditionitemdesc, false)

	if not episodeInfo or not episodeConfig then
		return
	end

	local chapterId = DungeonModel.instance.curSendChapterId

	if chapterId then
		local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

		if chapterCo and chapterCo.type == DungeonEnum.ChapterType.Simple then
			return
		end
	end

	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183] then
		self:refresh183Condition()

		return
	end

	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(self._episodeId, FightModel.instance:getBattleId())

	if not LuaUtil.isEmptyStr(advancedConditionText) then
		local conditionItem = gohelper.clone(self._goconditionitemdesc, self._goconditionitem, "platnumdesc")
		local platHighLight = self:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(self._episodeId, 1, FightModel.instance:getBattleId()))
		local progress = ""

		if not FightModel.instance.needFightReconnect then
			local platConditionId = DungeonConfig.instance:getEpisodeAdvancedCondition(self._episodeId, FightModel.instance:getBattleId())
			local conditionCO = lua_condition.configDict[tonumber(platConditionId)]
			local conditionType = conditionCO and tonumber(conditionCO.type)

			if conditionType and conditionType == 7 then
				progress = string.format(" (%d/%s)", self:_getPlatinumProgress7(), conditionCO.attr)
			elseif conditionType and conditionType == 8 then
				progress = string.format(" (%d/%s)", self:_getPlatinumProgress8(), conditionCO.attr)
			elseif conditionType and conditionType == 9 then
				progress = string.format(" (%d%%/%s%%)", self:_getPlatinumProgress9(), tostring(tonumber(conditionCO.attr) / 10))
			end
		end

		self:_setConditionText(conditionItem, advancedConditionText .. progress, platHighLight)
		self:_setStarStatus(conditionItem, platHighLight)
	end

	local advancedConditionText2 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(self._episodeId, FightModel.instance:getBattleId())

	if not LuaUtil.isEmptyStr(advancedConditionText2) then
		local conditionItem = gohelper.clone(self._goconditionitemdesc, self._goconditionitem, "platnumdesc2")
		local platHighLight = self:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(self._episodeId, 2, FightModel.instance:getBattleId()))

		self:_setConditionText(conditionItem, advancedConditionText2, platHighLight)
		self:_setStarStatus(conditionItem, platHighLight)
	end
end

function FightQuitTipView:_getPlatinumProgress7()
	local roundDataMgr = FightDataHelper.roundMgr
	local roundDataList = roundDataMgr.dataList
	local maxUniqueSkillCount = 0

	for _, roundData in ipairs(roundDataList) do
		local uniqueSkillCount = 0

		for _, fightStepData in ipairs(roundData.fightStep) do
			if fightStepData.hasPlay and fightStepData.actType == FightEnum.ActType.SKILL then
				local entityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)

				if entityMO and entityMO.side == FightEnum.EntitySide.MySide and FightCardDataHelper.isBigSkill(fightStepData.actId) then
					uniqueSkillCount = uniqueSkillCount + 1
				end
			end
		end

		maxUniqueSkillCount = math.max(maxUniqueSkillCount, uniqueSkillCount)
	end

	return maxUniqueSkillCount
end

local DamageType = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.BEATBACK] = true,
	[FightEnum.EffectType.DAMAGEEXTRA] = true
}

function FightQuitTipView:_getPlatinumProgress8()
	local roundDataMgr = FightDataHelper.roundMgr
	local roundDataList = roundDataMgr.dataList
	local maxStepDamage = 0

	for _, roundData in ipairs(roundDataList) do
		for _, fightStepData in ipairs(roundData.fightStep) do
			local entityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)

			if fightStepData.hasPlay and entityMO and entityMO.side == FightEnum.EntitySide.MySide then
				local stepDamage = 0

				for _, actEffectData in ipairs(fightStepData.actEffect) do
					local targetEntityMO = FightDataHelper.entityMgr:getById(actEffectData.targetId)

					if targetEntityMO and targetEntityMO.side == FightEnum.EntitySide.EnemySide then
						if DamageType[actEffectData.effectType] then
							stepDamage = stepDamage + actEffectData.effectNum
						elseif actEffectData.effectType == FightEnum.EffectType.SHIELDDEL then
							stepDamage = stepDamage + actEffectData.effectNum
						elseif actEffectData.effectType == FightEnum.EffectType.SHIELD and actEffectData.entity then
							stepDamage = stepDamage + actEffectData.entity.shieldValue - actEffectData.effectNum
						end
					end
				end

				maxStepDamage = math.max(maxStepDamage, stepDamage)
			end
		end
	end

	return maxStepDamage
end

function FightQuitTipView:_getPlatinumProgress9()
	local mySideList = FightDataHelper.entityMgr:getMyNormalList()
	local mySideDeadCount = #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide)
	local totalPercent = 0

	for _, entityMO in ipairs(mySideList) do
		totalPercent = totalPercent + entityMO.currentHp / entityMO.attrMO.hp
	end

	local percent = totalPercent / (#mySideList + mySideDeadCount)

	return math.floor(percent * 100)
end

function FightQuitTipView:_setConditionText(go, text, highLight)
	local textCom = go:GetComponent(gohelper.Type_Text) or go:GetComponent(gohelper.Type_TextMesh)

	textCom.text = highLight and gohelper.getRichColorText(text, "#E6E2DF") or gohelper.getRichColorText(text, "#A7A6A6")
end

function FightQuitTipView:_setStarStatus(go, highLight)
	local star = gohelper.findChildImage(go, "star")
	local isSP02 = VersionActivity2_9DungeonHelper.isTargetActEpisode(self._episodeId, VersionActivity3_10Enum.ActivityId.Dungeon)

	if isSP02 then
		gohelper.setActive(star, false)

		local goProgressItem = gohelper.findChild(go, "#go_progressitem")

		gohelper.setActive(goProgressItem, true)

		local mode = ActivityConfig.instance:getChapterIdMode(self._chapterId)

		if mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
			mode = VersionActivityDungeonBaseEnum.DungeonMode.Story3
		end

		for i = 1, 3 do
			local goIcon = gohelper.findChild(goProgressItem, "image_icon" .. i)

			if i == mode then
				gohelper.setActive(goIcon, true)

				local img = gohelper.findChildImage(goIcon, "#image_fg")

				img.fillAmount = highLight and 1 or 0
			else
				gohelper.setActive(goIcon, false)
			end
		end

		return
	end

	local starImage = self._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"
	local starColor = "#87898C"

	if highLight then
		starColor = self._hardMode and "#FF4343" or "#F77040"
	end

	UISpriteSetMgr.instance:setCommonSprite(star, starImage)
	SLFramework.UGUI.GuiHelper.SetColor(star, starColor)
end

function FightQuitTipView:checkPlatCondition(platConditionId)
	local condition = lua_condition.configDict[tonumber(platConditionId)]

	if not condition then
		return true
	end

	local deadHeroCount = #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide)
	local curRound = FightModel.instance:getCurRoundId()

	if tonumber(condition.type) == 1 then
		return deadHeroCount < tonumber(condition.attr)
	elseif tonumber(condition.type) == 2 then
		return curRound <= tonumber(condition.attr)
	elseif tonumber(condition.type) == 3 then
		return deadHeroCount == 0 and curRound <= tonumber(condition.attr)
	elseif tonumber(condition.type) == 4 then
		return false
	elseif tonumber(condition.type) == 5 then
		return false
	elseif tonumber(condition.type) == 6 then
		return false
	elseif tonumber(condition.type) == 7 then
		return self:_getPlatinumProgress7() >= tonumber(condition.attr)
	elseif tonumber(condition.type) == 8 then
		return self:_getPlatinumProgress8() >= tonumber(condition.attr)
	elseif tonumber(condition.type) == 9 then
		return self:_getPlatinumProgress9() >= tonumber(condition.attr) / 10
	else
		return true
	end
end

function FightQuitTipView:_addEmptyRuleItem()
	local go = gohelper.clone(self._goruletemp, self._gorulelist, "none")

	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	gohelper.setActive(tagicon.gameObject, false)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, "none")
end

function FightQuitTipView:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	gohelper.setActive(tagicon.gameObject, true)
	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function FightQuitTipView:_addRuleItemDesc(ruleCo, targetId, needLoadLine)
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local go = gohelper.clone(self._goruleitem, self._goruleDescList, ruleCo.id)
	local icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)

	local lineImg = gohelper.findChild(go, "#go_line")

	gohelper.setActive(lineImg, needLoadLine)

	local tag = gohelper.findChildImage(go, "tag")

	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	local desc = gohelper.findChildText(go, "desc")
	local descContent = string.gsub(ruleCo.desc, "%【(.-)%】", "<color=#6680bd>【%1】</color>")

	desc.text = string.format("<color=%s>[%s]</color>%s", tagColor[targetId], luaLang("dungeon_add_rule_target_" .. targetId), descContent)

	gohelper.setActive(go, true)
end

function FightQuitTipView:_showRuleDesc()
	local fightParam = FightModel.instance:getFightParam()
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

	if episode_config and not string.nilorempty(episode_config.battleDesc) then
		gohelper.setActive(self._goadditiontip, true)
		gohelper.setActive(self._goaddition, true)
		gohelper.setActive(self._goruledesc, true)
		gohelper.setActive(self._gorulelist, false)
		gohelper.setActive(self._ruleclick.gameObject, false)

		self._txtruledesc1.text = episode_config.battleDesc
	else
		gohelper.setActive(self._goaddition, false)
	end
end

function FightQuitTipView:_ruleListClickFunc()
	gohelper.setActive(self._goadditiondetail, true)
end

function FightQuitTipView:refreshOdysseyTask(customData)
	local elementId = customData.elementId
	local config = lua_odyssey_fight_element.configDict[elementId]

	if not config then
		return
	end

	if config.type ~= 6 then
		return
	end

	local param = config.param
	local arr = GameUtil.splitString2(param, true)

	table.sort(arr, function(a, b)
		return a[1] < b[1]
	end)

	local taskList = {}

	for i, v in ipairs(arr) do
		local taskId = v[2]
		local taskConfig = lua_odyssey_fight_task_desc.configDict[taskId]

		if taskConfig then
			table.insert(taskList, taskConfig)
		end
	end

	for i, v in ipairs(taskList) do
		local conditionItem = gohelper.clone(self._goconditionitemdesc, self._goconditionitem, "platnumdesc")

		self:showOdysseyTask(conditionItem, v, i)
	end

	gohelper.setActive(self._goconditionitemdesc, false)

	local comp = gohelper.onceAddComponent(self._goconditionitem, gohelper.Type_VerticalLayoutGroup)

	comp.spacing = 60
	comp = gohelper.findChildComponent(self.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/passtargetTip", typeof(UnityEngine.UI.LayoutElement))
	comp.minHeight = 35

	return true
end

function FightQuitTipView:showOdysseyTask(obj, taskConfig, index)
	local text = gohelper.findChildText(obj, "")

	text.text = taskConfig.desc

	gohelper.setActive(gohelper.findChild(obj, "star"), false)

	local icon = gohelper.findChildImage(obj, "star_weekwalkheart")

	transformhelper.setLocalScale(icon.transform, 0.8, 0.8, 0.8)
	gohelper.setActive(icon.gameObject, true)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(icon, "pingji_x_" .. index)
end

function FightQuitTipView:_refreshWeekwalkVer2Condition()
	local cupJson = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.WeekwalkVer2]

	cupJson = cupJson and cjson.decode(cupJson)

	if not cupJson then
		return
	end

	if not cupJson.cupIds then
		return
	end

	local dataList = {}

	for k, v in ipairs(cupJson.cupIds) do
		table.insert(dataList, v)
	end

	table.sort(dataList, FightQuitTipView.sortWeekWalkVer2Task)

	for i, v in ipairs(dataList) do
		local conditionItem = gohelper.clone(self._goconditionitemdesc, self._goconditionitem, "platnumdesc")

		self:_showWeekWalkVer2OneTaskGroup(conditionItem, v, i)
	end

	gohelper.setActive(self._goconditionitemdesc, false)
end

function FightQuitTipView:_showWeekWalkVer2OneTaskGroup(obj, data, index)
	local config = lua_weekwalk_ver2_cup.configDict[data]
	local text = gohelper.findChildText(obj, "")
	local cupTask = GameUtil.splitString2(config.cupTask, true)

	table.sort(cupTask, FightQuitTipView.sortWeekWalkVer2CupList)

	local curCup, lastCup
	local fightTaskBox = FightDataHelper.fieldMgr.fightTaskBox
	local tasks = fightTaskBox.tasks

	for i, list in ipairs(cupTask) do
		local finishCount = 0

		for index = 2, #list do
			local taskId = list[index]
			local task = tasks[taskId]

			if task then
				if task.status ~= FightTaskBoxData.TaskStatus.Finished then
					curCup = list[1]

					break
				end

				if task.status == FightTaskBoxData.TaskStatus.Finished then
					finishCount = finishCount + 1
				end
			end
		end

		if finishCount == #list - 1 then
			lastCup = list[1]
		end

		if curCup then
			break
		end
	end

	local progressDesc = FightQuitTipView._getWeekWalkVer2CupProgressDesc(curCup, config) or ""

	text.text = config.desc .. progressDesc

	gohelper.setActive(gohelper.findChild(obj, "star"), false)

	local star_weekwalkheart = gohelper.findChild(obj, "star_weekwalkheart")

	gohelper.setActive(star_weekwalkheart, true)

	local cupImage = gohelper.findChildImage(obj, "star_weekwalkheart")

	lastCup = lastCup or 0
	cupImage.enabled = false

	local iconEffect = self:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, cupImage.gameObject)

	WeekWalk_2Helper.setCupEffectByResult(iconEffect, lastCup)
end

function FightQuitTipView._getWeekWalkVer2CupProgressDesc(curCup, config)
	if not curCup then
		return
	end

	local progressDesc = config.progressDesc

	if string.nilorempty(progressDesc) then
		return
	end

	local arr = GameUtil.splitString2(progressDesc)
	local progressStr

	for i, v in ipairs(arr) do
		if tonumber(v[1]) == curCup then
			progressStr = v[2]

			break
		end
	end

	if not progressStr then
		return
	end

	local paramOfProgressDesc = config.paramOfProgressDesc

	if string.nilorempty(paramOfProgressDesc) then
		return
	end

	local progressArr = GameUtil.splitString2(paramOfProgressDesc)
	local progressParam

	for index, param in ipairs(progressArr) do
		if tonumber(param[1]) == curCup then
			progressParam = param

			break
		end
	end

	if not progressParam then
		return
	end

	local fightTaskBox = FightDataHelper.fieldMgr.fightTaskBox
	local tasks = fightTaskBox.tasks
	local paramList = {}
	local checkTaskList = GameUtil.splitString2(progressParam[2], true, "_", "&")

	for _, list in ipairs(checkTaskList) do
		local taskId = list[1]
		local task = tasks[taskId]

		if task then
			for i, value in ipairs(task.values) do
				if value.index == list[2] then
					if list[3] == 1 then
						local progress = math.ceil(value.progress / value.maxProgress * 100)

						table.insert(paramList, progress .. "%")
					elseif list[3] == 2 then
						local progress = math.floor(value.progress / value.maxProgress * 100)

						table.insert(paramList, progress .. "%")
					else
						table.insert(paramList, value.progress)
					end
				end
			end
		end
	end

	progressStr = GameUtil.getSubPlaceholderLuaLang(progressStr, paramList)

	return progressStr
end

function FightQuitTipView.sortWeekWalkVer2CupList(item1, item2)
	return item1[1] < item2[1]
end

function FightQuitTipView.sortWeekWalkVer2Task(item1, item2)
	local config1 = lua_weekwalk_ver2_cup.configDict[item1]
	local config2 = lua_weekwalk_ver2_cup.configDict[item2]

	return config1.cupNo < config2.cupNo
end

function FightQuitTipView:refresh183Condition()
	local layoutGroup = gohelper.onceAddComponent(self._gopasstarget, gohelper.Type_VerticalLayoutGroup)
	local padding = layoutGroup.padding

	padding.bottom = -60

	local episodeId = FightDataHelper.fieldMgr.episodeId
	local advancedCondition = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)

	if LuaUtil.isEmptyStr(advancedCondition) == false then
		local conditionList = string.splitToNumber(advancedCondition, "|")

		for _, conditionId in ipairs(conditionList) do
			local conditionConfig = lua_condition.configDict[conditionId]
			local conditionItem = gohelper.clone(self._goconditionitemdesc, self._goconditionitem, "platnumdesc")
			local platHighLight = self:checkPlatCondition(conditionId)

			self:_setConditionText(conditionItem, conditionConfig.desc, platHighLight)
			self:_setStarStatus(conditionItem, platHighLight)
		end
	end
end

function FightQuitTipView:onClose()
	FightAudioMgr.instance:obscureBgm(false)
end

function FightQuitTipView:onDestroyView()
	self._simagetipbg:UnLoadImage()
	self._simagemaskbg:UnLoadImage()
	self._simagenumline:UnLoadImage()
end

return FightQuitTipView
