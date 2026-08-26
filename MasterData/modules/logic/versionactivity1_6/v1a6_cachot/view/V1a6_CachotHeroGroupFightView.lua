-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotHeroGroupFightView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupFightView", package.seeall)

local V1a6_CachotHeroGroupFightView = class("V1a6_CachotHeroGroupFightView", BaseView)
local MaxMultiplication = 4

function V1a6_CachotHeroGroupFightView:onInitView()
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnStart")
	self._btnBalanceStart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnBalance")
	self._btnUnPowerBalanceStart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerBalance")
	self._btnstarthard = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnStartHard")
	self._btnstartreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnStartReplay")
	self._goreplaybtnframe = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_replaybtnframe")
	self._goReplayBtn = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn")
	self._btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay")
	self._imagereplayicon = gohelper.findChildImage(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay/#image_replayicon")
	self._imgbtnReplayBg = gohelper.findChildImage(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay/#image_replaybg")
	self._goreplayready = gohelper.findChild(self.viewGO, "#go_container/#go_replayready")
	self._btnmultispeed = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed")
	self._txtmultispeed = gohelper.findChildTextMesh(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/Label")
	self._btnclosemult = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closemult")
	self._gomultPos = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/#go_multpos")
	self._gomultispeed = gohelper.findChild(self.viewGO, "#go_multispeed")
	self._gomultContent = gohelper.findChild(self.viewGO, "#go_multispeed/Viewport/Content")
	self._gomultitem = gohelper.findChild(self.viewGO, "#go_multispeed/Viewport/Content/#go_multitem")
	self._simagereplayframe = gohelper.findChildSingleImage(self.viewGO, "#go_container/#go_replayready/#simage_replayframe")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/btnCloth")
	self._txtclothname = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	self._txtclothnameen = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	self._btncareerrestrain = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_topbtns/#btn_RestraintInfo")
	self._btnrecommend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_topbtns/btn_recommend")
	self._goRecommendEffect = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_topbtns/btn_recommend/recommend")
	self._gocost = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_cost")
	self._gopower = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_cost/#go_power")
	self._simagepower = gohelper.findChildSingleImage(self.viewGO, "#go_container/btnContain/#go_cost/#go_power/#simage_power")
	self._txtusepower = gohelper.findChildText(self.viewGO, "#go_container/btnContain/#go_cost/#go_power/#txt_usepower")
	self._gocount = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_cost/#go_count")
	self._txtcostcount = gohelper.findChildText(self.viewGO, "#go_container/btnContain/#go_cost/#go_count/animroot/#txt_costCount")
	self._gopowercontent = gohelper.findChild(self.viewGO, "#go_righttop/#go_power")
	self._gofightCount = gohelper.findChild(self.viewGO, "#go_righttop/fightcount")
	self._txtfightCount = gohelper.findChildTextMesh(self.viewGO, "#go_righttop/fightcount/#txt_fightcount")
	self._gomask = gohelper.findChild(self.viewGO, "#go_container2/#go_mask")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "#go_container2")
	self._golevelchange = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_levelchange")
	self._txtreplaycn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnStartReplay/#txt_replaycn")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_container/#go_topbtns")
	self._btnunpowerstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerStart")
	self._btnunpowerreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay")
	self._btnhardreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnHardReplay")
	self._txtreplayhardcn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnHardReplay/#txt_replayhardcn")
	self._txtreplayunpowercn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay/#txt_replayunpowercn")
	self._gonormallackpower = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_normallackpower")
	self._goreplaylackpower = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_replaylackpower")
	self._goTrialTips = gohelper.findChild(self.viewGO, "#go_container/trialContainer/#go_trialTips")
	self._goTrialTipsBg = gohelper.findChild(self.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg")
	self._goTrialTipsItem = gohelper.findChild(self.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg/#go_tipsitem")
	self._btnTrialTips = gohelper.findChildButton(self.viewGO, "#go_container/trialContainer/#go_trialTips/#btn_tips")
	self._btnSwitchBalance = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance")
	self._goBalanceEnter = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance/#btn_enter")
	self._goBalanceExit = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance/#btn_exit")
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	self._btnmodifyname = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	self._dropherogrouparrow = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/arrow").transform
	self._btncoststart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnCostStart")
	self._txtCostNum = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnCostStart/#txt_num")
	self._btncostreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnCostReplay")
	self._txtreplaycostcn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnCostReplay/#txt_replaycostcn")
	self._txtReplayCostNum = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnCostReplay/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotHeroGroupFightView:addEvents()
	self._btnTrialTips:AddClickListener(self._switchTrialTips, self)
	self._btnSwitchBalance:AddClickListener(self._btnSwitchBalanceOnClick, self)
	self._btnstart:AddClickListener(self._onClickStart, self)
	self._btnstarthard:AddClickListener(self._onClickStart, self)
	self._btnstartreplay:AddClickListener(self._onClickStart, self)
	self._btnReplay:AddClickListener(self._onClickReplay, self)
	self._btncloth:AddClickListener(self._btnclothOnClock, self)
	self._btncareerrestrain:AddClickListener(self._btncareerrestrainOnClick, self)
	self._btnrecommend:AddClickListener(self._btnrecommendOnClick, self)
	self._btnunpowerstart:AddClickListener(self._onClickStart, self)
	self._btncoststart:AddClickListener(self._onClickStart, self)
	self._btnBalanceStart:AddClickListener(self._onClickStart, self)
	self._btnUnPowerBalanceStart:AddClickListener(self._onClickStart, self)
	self._btnunpowerreplay:AddClickListener(self._onClickStart, self)
	self._btncostreplay:AddClickListener(self._onClickStart, self)
	self._btnhardreplay:AddClickListener(self._onClickStart, self)
	self._btnmultispeed:AddClickListener(self._openmultcontent, self)
	self._btnclosemult:AddClickListener(self._closemultcontent, self)
	self._btnmodifyname:AddClickListener(self._modifyName, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouch, self)
	self._dropherogroup:AddOnValueChanged(self._groupDropValueChanged, self)
end

function V1a6_CachotHeroGroupFightView:removeEvents()
	self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouch, self)
	self._btnTrialTips:RemoveClickListener()
	self._btnSwitchBalance:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnBalanceStart:RemoveClickListener()
	self._btnUnPowerBalanceStart:RemoveClickListener()
	self._btnstarthard:RemoveClickListener()
	self._btnstartreplay:RemoveClickListener()
	self._btnReplay:RemoveClickListener()
	self._btncloth:RemoveClickListener()
	self._btncareerrestrain:RemoveClickListener()
	self._btnrecommend:RemoveClickListener()
	self._btnunpowerstart:RemoveClickListener()
	self._btnunpowerreplay:RemoveClickListener()
	self._btncoststart:RemoveClickListener()
	self._btncostreplay:RemoveClickListener()
	self._btnhardreplay:RemoveClickListener()
	self._btnmultispeed:RemoveClickListener()
	self._btnclosemult:RemoveClickListener()
	self._btnmodifyname:RemoveClickListener()
	self._dropherogroup:RemoveOnValueChanged()
	self.removeEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function V1a6_CachotHeroGroupFightView:_openmultcontent()
	gohelper.setActive(self._gomultispeed, not self._gomultispeed.activeSelf)

	self._gomultispeed.transform.position = self._gomultPos.transform.position
end

function V1a6_CachotHeroGroupFightView:_closemultcontent()
	gohelper.setActive(self._gomultispeed, false)
end

function V1a6_CachotHeroGroupFightView:_btnSwitchBalanceOnClick()
	HeroGroupBalanceHelper.switchBalanceMode()
	HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)
	self.viewContainer:dispatchEvent(HeroGroupEvent.SwitchBalance)
	gohelper.setActive(self._goBalanceEnter, not HeroGroupBalanceHelper.getIsBalanceMode())
	gohelper.setActive(self._goBalanceExit, HeroGroupBalanceHelper.getIsBalanceMode())

	if self._replayMode then
		self:_closemultcontent()

		self._replayMode = false
		self._multiplication = 1

		self:_refreshCost(true)
		self:_switchReplayGroup()
	else
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
		self:_refreshUI()
	end

	self.viewContainer:refreshHelpBtnIcon()
	self:isShowHelpBtnIcon()
	self:_initFightGroupDrop()

	if HeroGroupBalanceHelper.getIsBalanceMode() then
		ViewMgr.instance:openView(ViewName.HeroGroupBalanceTipView)
	end
end

function V1a6_CachotHeroGroupFightView:_btnclothOnClock()
	if V1a6_CachotHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local clothUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	if clothUnlock or PlayerClothModel.instance:getSpEpisodeClothID() then
		local groupModel = V1a6_CachotHeroGroupModel.instance

		ViewMgr.instance:openView(ViewName.PlayerClothView, {
			groupModel = groupModel,
			useCallback = groupModel.cachotSaveCurGroup,
			useCallbackObj = groupModel
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function V1a6_CachotHeroGroupFightView:_btncareerrestrainOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function V1a6_CachotHeroGroupFightView:_btnrecommendOnClick()
	FightFailRecommendController.instance:onClickRecommend()
	self:_udpateRecommendEffect()

	if self._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		local elementId = WeekWalkModel.instance:getBattleElementId()

		WeekwalkRpc.instance:sendWeekwalkHeroRecommendRequest(elementId, self._receiveRecommend, self)

		return
	end

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(self._episodeId, self._receiveRecommend, self)
end

function V1a6_CachotHeroGroupFightView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, msg)
end

function V1a6_CachotHeroGroupFightView:_editableInitView()
	MaxMultiplication = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or MaxMultiplication
	self._multiplication = 1
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._goBtnContain = gohelper.findChild(self.viewGO, "#go_container/btnContain")
	self._btnContainAnim = self._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gomask, false)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, self._initFightGroupDrop, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onModifySnapshot, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self.addEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.isShowHelpBtnIcon, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, self._onUseRecommendGroup, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, self._showGuideDragEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUpdateRecommendLevel, self._refreshTips, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, self._heroMoveForward, self)

	if BossRushController.instance:isInBossRushFight() then
		gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(self._btnstarthard.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(self._btnstartreplay.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
	else
		gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(self._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(self._btnstartreplay.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	end

	gohelper.addUIClickAudio(self._btnReplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)

	self._iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._btncloth.gameObject)

	recthelper.setAnchor(self._iconGO.transform, -100, 1)

	self._tweeningId = 0
	self._replayMode = false
	self._multSpeedItems = {}

	gohelper.CreateObjList(self, self._setMultSpeedItem, {
		4,
		3,
		2,
		1
	}, self._gomultContent, self._gomultitem)
	gohelper.setActive(self._gomultispeed, false)
	self._simagereplayframe:LoadImage(ResUrl.getHeroGroupBg("fuxian_zhegai"))
end

function V1a6_CachotHeroGroupFightView:_setMultSpeedItem(go, multispeed, index)
	local line = gohelper.findChild(go, "line")
	local num = gohelper.findChildTextMesh(go, "num")
	local selecticon = gohelper.findChild(go, "selecticon")

	self.addClickCb(self, gohelper.getClick(go), self.setMultSpeed, self, multispeed)

	num.text = luaLang("multiple") .. multispeed

	gohelper.setActive(line, multispeed ~= MaxMultiplication)

	self._multSpeedItems[multispeed] = self:getUserDataTb_()
	self._multSpeedItems[multispeed].num = num
	self._multSpeedItems[multispeed].selecticon = selecticon
end

local selectColor = GameUtil.parseColor("#efb785")
local unSelectColor = GameUtil.parseColor("#C3BEB6")

function V1a6_CachotHeroGroupFightView:setMultSpeed(speed)
	for i = 1, MaxMultiplication do
		if speed == i then
			self._multSpeedItems[i].num.color = selectColor or unSelectColor
		end

		gohelper.setActive(self._multSpeedItems[i].selecticon, speed == i)
	end

	self._txtmultispeed.text = luaLang("multiple") .. speed
	self._multiplication = speed

	PlayerPrefsHelper.setNumber(self:_getMultiplicationKey(), self._multiplication)
	self:_refreshUI()
	self:_refreshTips()

	local replayCn = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(self._multiplication))

	self._txtreplaycn.text = replayCn
	self._txtreplayhardcn.text = replayCn
	self._txtreplayunpowercn.text = replayCn
	self._txtreplaycostcn.text = replayCn

	self:_refreshPowerShow()
	self:_closemultcontent()
end

function V1a6_CachotHeroGroupFightView:_heroMoveForward(heroId)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(heroId))
end

function V1a6_CachotHeroGroupFightView:isReplayMode()
	return self._replayMode
end

function V1a6_CachotHeroGroupFightView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:_refreshCostPower()
end

function V1a6_CachotHeroGroupFightView:_respBeginFight()
	gohelper.setActive(self._gomask, true)
end

function V1a6_CachotHeroGroupFightView:_onOpenFullView(viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function V1a6_CachotHeroGroupFightView:_onCloseView(viewName)
	if viewName == ViewName.EquipInfoTeamShowView then
		self:_checkFirstPosHasEquip()
	end
end

function V1a6_CachotHeroGroupFightView:onOpen()
	if HeroGroupBalanceHelper.getIsBalanceMode() then
		ViewMgr.instance:openView(ViewName.HeroGroupBalanceTipView)
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
	self:_checkFirstPosHasEquip()
	self:_checkEquipClothSkill()
	gohelper.setActive(self._btnSwitchBalance, HeroGroupBalanceHelper.canShowBalanceSwitchBtn())
	gohelper.setActive(self._goBalanceEnter, not HeroGroupBalanceHelper.getIsBalanceMode())
	gohelper.setActive(self._goBalanceExit, HeroGroupBalanceHelper.getIsBalanceMode())
	self:_refreshUI()
	gohelper.addUIClickAudio(self._btncareerrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotHeroGroupFightView, self._onEscapeBtnClick, self)
	self:isShowHelpBtnIcon()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)

	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(self._episodeId)] and not self._replayMode then
			self._replayMode = true
			self._multiplication = PlayerPrefsHelper.getNumber(self:_getMultiplicationKey(), 1)

			self:_refreshCost(true)

			self._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

			if not self._replayFightGroupMO then
				self.addEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
				FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
			else
				self:_switchReplayGroup()
			end
		end
	end

	self:setMultSpeed(self._multiplication)
	gohelper.setActive(self._goreplaybtnframe, self._replayMode)

	local showNum = false
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if chapterConfig and chapterConfig.enterAfterFreeLimit > 0 then
		local num = DungeonModel.instance:getChapterRemainingNum(chapterConfig.type)

		if num > 0 then
			showNum = true
			self._txtfightCount.text = num
		end
	end

	gohelper.setActive(self._gofightCount, showNum)

	self._dropgroupchildcount = self._dropherogroup.transform.childCount

	self:_refreshReplay()
	self:_refreshTips()
	self:_refreshPowerShow()
	self:_udpateRecommendEffect()
	FightHelper.detectAttributeCounter()
	self:_initFightGroupDrop()

	if self._goTrialTips.activeSelf then
		gohelper.setActive(self._goTrialTipsBg, true)
	end
end

function V1a6_CachotHeroGroupFightView:onOpenFinish()
	self:_dispatchGuideEventOnOpenFinish()
end

function V1a6_CachotHeroGroupFightView:_setTrialNumTips()
	local _, battleCO = V1a6_CachotHeroGroupFightView._getEpisodeConfigAndBattleConfig()
	local tips = {}

	if battleCO and battleCO.trialLimit > 0 then
		tips[1] = battleCO.trialLimit >= 4 and luaLang("herogroup_trial_tip") or formatLuaLang("herogroup_trial_limit_tip", battleCO.trialLimit)
	end

	if battleCO and not string.nilorempty(battleCO.trialEquips) then
		table.insert(tips, luaLang("herogroup_trial_equip_tip"))
	end

	gohelper.setActive(self._goTrialTips, #tips > 0)

	if #tips > 0 then
		gohelper.CreateObjList(self, self._setTrialTipsTxt, tips, self._goTrialTipsBg, self._goTrialTipsItem)
	end
end

function V1a6_CachotHeroGroupFightView:_onTouch()
	if self._goTrialTips.activeSelf and self._clickTrialFrame ~= UnityEngine.Time.frameCount and not ViewMgr.instance:isOpen(ViewName.HeroGroupBalanceTipView) then
		gohelper.setActive(self._goTrialTipsBg, false)
	end
end

function V1a6_CachotHeroGroupFightView:_setTrialTipsTxt(obj, data, index)
	gohelper.findChildTextMesh(obj, "desc").text = data
end

function V1a6_CachotHeroGroupFightView:_switchTrialTips()
	gohelper.setActive(self._goTrialTipsBg, not self._goTrialTipsBg.activeSelf)

	self._clickTrialFrame = UnityEngine.Time.frameCount
end

function V1a6_CachotHeroGroupFightView:_refreshPowerShow()
	local showPower = true
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if chapterConfig and chapterConfig.enterAfterFreeLimit > 0 then
		local num = DungeonModel.instance:getChapterRemainingNum(chapterConfig.type)

		if num >= self._multiplication then
			showPower = false
		end
	end

	gohelper.setActive(self._gopowercontent, showPower)
	gohelper.setActive(self._gofightCount, not showPower)
end

function V1a6_CachotHeroGroupFightView:_getMultiplicationKey()
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), self._episodeId)
end

function V1a6_CachotHeroGroupFightView:_udpateRecommendEffect()
	gohelper.setActive(self._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(self._episodeId))
end

function V1a6_CachotHeroGroupFightView:isShowHelpBtnIcon()
	local helpId = self.viewContainer:getHelpId()

	recthelper.setAnchorX(self._gotopbtns.transform, helpId and 568.56 or 419.88)
end

function V1a6_CachotHeroGroupFightView:_onEscapeBtnClick()
	if not self._gomask.gameObject.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function V1a6_CachotHeroGroupFightView:_getfreeCount()
	if not self._chapterConfig or self._chapterConfig.enterAfterFreeLimit <= 0 then
		return 0
	end

	return (DungeonModel.instance:getChapterRemainingNum(self._chapterConfig.type))
end

function V1a6_CachotHeroGroupFightView:_groupDropValueChanged(value)
	local selectIndex = V1a6_CachotHeroGroupModel.instance:getGroupTypeName() and value or value + 1

	gohelper.setActive(self._btnmodifyname, false)

	if V1a6_CachotHeroGroupModel.instance:setHeroGroupSelectIndex(selectIndex) then
		self:_checkEquipClothSkill()
		GameFacade.showToast(ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function V1a6_CachotHeroGroupFightView:_initFightGroupDrop()
	if not self:_noAidHero() then
		return
	end

	local list = {}

	for i = 1, 4 do
		list[i] = V1a6_CachotHeroGroupModel.instance:getCommonGroupName(i)
	end

	local selectIndex = V1a6_CachotHeroGroupModel.instance.curGroupSelectIndex

	gohelper.setActive(self._btnmodifyname, false)

	local name = V1a6_CachotHeroGroupModel.instance:getGroupTypeName()

	if name then
		table.insert(list, 1, name)
	else
		selectIndex = selectIndex - 1
	end

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(selectIndex)
end

function V1a6_CachotHeroGroupFightView:_modifyName()
	ViewMgr.instance:openView(ViewName.HeroGroupModifyNameView)
end

function V1a6_CachotHeroGroupFightView:_refreshUI()
	local heroGroupId = V1a6_CachotHeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)

	self._episodeId = HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	self._chapterConfig = DungeonConfig.instance:getChapterCO(self.episodeConfig.chapterId)

	local freeNum = self:_getfreeCount()

	if freeNum - self._multiplication >= 0 then
		self._enterAfterFreeLimit = freeNum - self._multiplication or false
	end

	gohelper.setActive(self._btnrecommend.gameObject, self._chapterConfig.isHeroRecommend == 1)
	self:_refreshCost(true)
	self:_refreshCloth()
	self:_setTrialNumTips()
	self.viewContainer:setNavigateOverrideClose()

	local var_35_0 = self._goReplayBtn

	gohelper.setActive(var_35_0, (not HeroGroupBalanceHelper.getIsBalanceMode() or nil) and self.episodeConfig and not (self.episodeConfig.canUseRecord ~= 1 or self._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk))
end

function V1a6_CachotHeroGroupFightView:_refreshCost(visible)
	gohelper.setActive(self._gocost, visible)

	local remainCount = self:_getfreeCount()

	gohelper.setActive(self._gopower, not self._enterAfterFreeLimit)
	gohelper.setActive(self._gocount, not self._enterAfterFreeLimit and remainCount > 0)
	gohelper.setActive(self._gonormallackpower, false)
	gohelper.setActive(self._goreplaylackpower, false)

	if self._enterAfterFreeLimit or remainCount > 0 then
		local str = tostring(-1 * math.min(self._multiplication, remainCount))

		self._txtCostNum.text = str
		self._txtReplayCostNum.text = str

		if remainCount >= self._multiplication then
			self:_refreshBtns(false)

			return
		end
	end

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon .. "_btn")

	self._simagepower:LoadImage(powerIcon)
	self:_refreshCostPower()
end

function V1a6_CachotHeroGroupFightView:_refreshTips()
	local posX = self._enterAfterFreeLimit and -271.5 or -280
	local posY = self._enterAfterFreeLimit and 163 or 165.5

	recthelper.setAnchor(self._golevelchange.transform, posX, posY)

	if self._golevelchange.activeInHierarchy then
		local isShowLevelChangeUI = not self._replayMode

		recthelper.setAnchorY(self._gocount.transform, isShowLevelChangeUI and 0 or -41.11)
		recthelper.setAnchorX(self._gocount.transform, -72)
		gohelper.setActive(self._btnmultispeed.gameObject, self._replayMode)

		self._gomultispeed.transform.position = self._gomultPos.transform.position
	end
end

function V1a6_CachotHeroGroupFightView:_refreshCostPower()
	local costs = string.split(self.episodeConfig.cost, "|")
	local cost1 = string.split(costs[1], "#")
	local value = tonumber((not cost1[3] or nil) and 0)
	local showPower = value > 0

	if self._enterAfterFreeLimit then
		showPower = false
	end

	gohelper.setActive(self._gopower, showPower)
	self:_refreshBtns(showPower)

	if not showPower then
		return
	end

	local multiCost = value * ((self._multiplication or 1) - self:_getfreeCount())

	self._txtusepower.text = string.format("-%s", multiCost)

	local isHardChapter = self._chapterConfig.type == DungeonEnum.ChapterType.Hard

	if multiCost <= CurrencyModel.instance:getPower() then
		local usePowerColor = isHardChapter and "#FFFFFF" or "#070706"

		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, self._replayMode and "#070706" or usePowerColor)
	else
		local usePowerColor = isHardChapter and "#C44945" or "#800015"

		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, self._replayMode and "#800015" or usePowerColor)
		gohelper.setActive(self._gonormallackpower, not self._replayMode)
		gohelper.setActive(self._goreplaylackpower, self._replayMode)
	end
end

function V1a6_CachotHeroGroupFightView:_dispatchGuideEvent()
	if self._replayMode then
		return
	end

	if not self:_isSpType(self._chapterConfig.type) then
		if not GuideInvalidCondition.checkAllGroupSetEquip() then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryEquipType)
		end

		self:_dispatchRecordEvent()
		self:_dispatchNoEquipEvent()
	end
end

function V1a6_CachotHeroGroupFightView:_dispatchGuideEventOnOpenFinish()
	if self._episodeId then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithEpisodeId, self._episodeId)
	end
end

function V1a6_CachotHeroGroupFightView:_dispatchNoEquipEvent()
	local curGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()

	for i = 1, 4 do
		local equips = curGroupMO:getPosEquips(i - 1).equipUid
		local equipId = equips[1]
		local equipMO = EquipModel.instance:getEquip(equipId)

		if equipMO then
			return
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryNormalType)
end

function V1a6_CachotHeroGroupFightView:_isSpType(type)
	return type == DungeonEnum.ChapterType.Sp or type == DungeonEnum.ChapterType.TeachNote
end

function V1a6_CachotHeroGroupFightView:_dispatchRecordEvent()
	local showReplayBtn = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord

	if showReplayBtn and hasRecord then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
	end
end

function V1a6_CachotHeroGroupFightView:onClose()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onModifySnapshot, self)
	self.removeEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.isShowHelpBtnIcon, self)
	TaskDispatcher.cancelTask(self._checkDropArrow, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	ZProj.TweenHelper.KillById(self._tweeningId)
	HeroGroupBalanceHelper.clearBalanceStatus()

	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end

	self.removeEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.isShowHelpBtnIcon, self)
end

function V1a6_CachotHeroGroupFightView:_refreshReplay()
	if self._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		gohelper.setActive(self._goReplayBtn, false)
	else
		local showReplayBtn = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
		local replay_is_unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
		local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
		local hasRecord = userDungeonMO and userDungeonMO.hasRecord

		ZProj.UGUIHelper.SetColorAlpha(self._imgbtnReplayBg, replay_is_unlock and hasRecord and 1 or 0.75)

		local normalIcon = self._replayMode and "btn_replay_pause" or "btn_replay_play"

		UISpriteSetMgr.instance:setHeroGroupSprite(self._imagereplayicon, replay_is_unlock and hasRecord and normalIcon or "btn_replay_lack")
		recthelper.setWidth(self._goReplayBtn.transform, self._replayMode and 249.538 or 83)

		if showReplayBtn and hasRecord and not self._replayMode then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
		end
	end
end

function V1a6_CachotHeroGroupFightView:_refreshCloth()
	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local curGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
	local cloth_id = curGroupMO.clothId

	cloth_id = PlayerClothModel.instance:getSpEpisodeClothID() or cloth_id

	local clothMO = PlayerClothModel.instance:getById(cloth_id)

	gohelper.setActive(self._txtclothname.gameObject, clothMO)

	if clothMO then
		local clothConfig = lua_cloth.configDict[clothMO.clothId]

		if not clothMO.level then
			self._txtclothname.text = clothConfig.name
			self._txtclothnameen.text = clothConfig.enname
		end
	end

	for _, clothCO in ipairs(lua_cloth.configList) do
		local icon = gohelper.findChild(self._iconGO, tostring(clothCO.id))

		if not gohelper.isNil(icon) then
			gohelper.setActive(icon, clothCO.id == cloth_id)
		end
	end

	gohelper.setActive(self._btncloth.gameObject, V1a6_CachotHeroGroupFightView.showCloth())
end

function V1a6_CachotHeroGroupFightView:_checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			V1a6_CachotHeroGroupModel.instance:replaceCloth(clothMO.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()

			break
		end
	end
end

function V1a6_CachotHeroGroupFightView._getEpisodeConfigAndBattleConfig()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local battleCO

	return episodeCO, HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 and lua_battle.configDict[HeroGroupModel.instance.battleId] or DungeonConfig.instance:getBattleCo(HeroGroupModel.instance.episodeId)
end

function V1a6_CachotHeroGroupFightView.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)

	if not clothShow then
		return false
	end

	local episodeCO, battleCO = V1a6_CachotHeroGroupFightView._getEpisodeConfigAndBattleConfig()

	if battleCO and battleCO.noClothSkill == 1 then
		return false
	end

	local curGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
	local clothMO = PlayerClothModel.instance:getById(curGroupMO.clothId)
	local list = PlayerClothModel.instance:getList()
	local hasUnlock = false

	for _, clothMO in ipairs(list) do
		hasUnlock = true

		break
	end

	return hasUnlock
end

function V1a6_CachotHeroGroupFightView:_onModifyHeroGroup()
	self:_refreshCloth()
end

function V1a6_CachotHeroGroupFightView:_onModifySnapshot()
	self:_refreshCloth()
end

function V1a6_CachotHeroGroupFightView:_onClickHeroGroupItem(id)
	local heroGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid

	self._param = {}
	self._param.singleGroupMOId = id
	self._param.originalHeroUid = V1a6_CachotHeroSingleGroupModel.instance:getHeroUid(id)
	self._param.adventure = V1a6_CachotHeroGroupModel.instance:isAdventureOrWeekWalk()
	self._param.equips = equips
	self._param.heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Fight
	self._param.seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(id)

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, self._param)
end

function V1a6_CachotHeroGroupFightView:_checkFirstPosHasEquip()
	local curGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
	local equips = curGroupMO:getPosEquips(0).equipUid
	local equipId = equips and equips[1]

	if equipId then
		::label_53_0::

		local equipMO = EquipModel.instance:getEquip(equipId)

		if equipMO then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
		end
	end
end

function V1a6_CachotHeroGroupFightView:_showGuideDragEffect(param)
	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end

	local visible = tonumber(param) == 1

	if visible then
		self._dragEffectLoader = PrefabInstantiate.Create(self.viewGO)

		self._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function V1a6_CachotHeroGroupFightView:_onClickStart()
	local costs = string.split(self.episodeConfig.cost, "|")
	local cost1 = string.split(costs[1], "#")
	local value = tonumber((not cost1[3] or nil) and 0)
	local remainCount = self:_getfreeCount()
	local multiCost = value * ((self._multiplication or 1) - remainCount)

	if multiCost > CurrencyModel.instance:getPower() then
		CurrencyController.instance:openPowerView()

		return
	end

	local guideEpisodeId = 10104

	if HeroGroupModel.instance.episodeId == guideEpisodeId and not DungeonModel.instance:hasPassLevel(guideEpisodeId) then
		local list = HeroSingleGroupModel.instance:getList()
		local count = 0

		for i, v in ipairs(list) do
			if not v:isEmpty() then
				count = count + 1
			end
		end

		if count < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	self:_closemultcontent()
	self:_enterFight()
end

function V1a6_CachotHeroGroupFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = V1a6_CachotController.instance:setFightHeroGroup()

		if result then
			self.viewContainer:beforeEnterFight()

			local fightParam = FightModel.instance:getFightParam()

			if self._replayMode then
				fightParam.isReplay = true
				fightParam.multiplication = self._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, self._multiplication, nil, true)
			else
				fightParam.isReplay = false
				fightParam.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function V1a6_CachotHeroGroupFightView:_onUseRecommendGroup()
	if self._replayMode then
		self:_closemultcontent()

		self._replayMode = false
		self._multiplication = 1

		self:_refreshCost(true)
		self:_switchReplayGroup()
	end
end

function V1a6_CachotHeroGroupFightView:_onClickReplay()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(desc, param)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord
	local hasPass = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced
	local hasFirstBattle = episodeConfig and episodeConfig.firstBattleId > 0

	if not hasRecord and hasPass and hasFirstBattle then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and not userDungeonMO.hasRecord then
		GameFacade.showToast(ToastEnum.HeroGroupStarAdvanced)

		return
	end

	if not userDungeonMO or userDungeonMO and userDungeonMO.star ~= DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.HeroGroupStarNoAdvanced)

		return
	end

	local lastRelayMode = self._replayMode

	if self._replayMode then
		self._replayMode = false
		self._multiplication = 1

		self._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
		gohelper.setActive(self._gomultispeed, false)
	else
		self._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		self._replayMode = true
		self._multiplication = 1
	end

	PlayerPrefsHelper.setNumber(self:_getMultiplicationKey(), self._multiplication)
	self:_refreshCost(true)

	if self._replayMode and not self._replayFightGroupMO then
		self.addEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	self:_switchReplayGroup(lastRelayMode)
end

function V1a6_CachotHeroGroupFightView:_switchReplayGroup(lastRelayMode)
	self:_switchReplayMul()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, self._replayMode and "swicth" or UIAnimationName.Open)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SwitchReplay, self._replayMode)

	if self._replayMode then
		self._goLevelChangePosX = self._goLevelChangePosX or recthelper.getAnchorX(self._golevelchange.transform)

		recthelper.setAnchorX(self._golevelchange.transform, 10000)
		self:_updateReplayHeroGorupList()

		local replayCn = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(self._multiplication))

		self._txtreplaycn.text = replayCn
		self._txtreplayhardcn.text = replayCn
		self._txtreplayunpowercn.text = replayCn
	else
		if self._goLevelChangePosX then
			recthelper.setAnchorX(self._golevelchange.transform, self._goLevelChangePosX)
		end

		V1a6_CachotHeroGroupModel.instance:setParam(V1a6_CachotHeroGroupModel.instance.battleId, V1a6_CachotHeroGroupModel.instance.episodeId, V1a6_CachotHeroGroupModel.instance.adventure)

		local heroGroupId = V1a6_CachotHeroGroupModel.instance:getCurGroupMO().id

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)
		self:_refreshCloth()
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
	end
end

function V1a6_CachotHeroGroupFightView:_switchReplayMul()
	if self._replayMode then
		self:setMultSpeed(self._multiplication)
	else
		self:_refreshUI()
		self:_refreshTips()
	end

	self:_refreshCost(true)
	self:_refreshPowerShow()
	gohelper.setActive(self._goreplayready, self._replayMode)

	local haveRecord = self:_haveRecord()

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imagereplayicon, not haveRecord and "btn_replay_lack" or self._replayMode and "btn_replay_pause" or "btn_replay_play")
	recthelper.setWidth(self._goReplayBtn.transform, self._replayMode and 249.538 or 83)
	ZProj.UGUIHelper.RebuildLayout(self._goReplayBtn.transform.parent)
	gohelper.setActive(self._goreplaybtnframe, self._replayMode)
end

function V1a6_CachotHeroGroupFightView:_haveRecord()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		return false
	end

	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)

	if userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and not userDungeonMO.hasRecord then
		return false
	end

	if not userDungeonMO or userDungeonMO and userDungeonMO.star ~= DungeonEnum.StarType.Advanced then
		return false
	end

	return true
end

function V1a6_CachotHeroGroupFightView:_refreshBtns(isCostPower)
	local isBlance = HeroGroupBalanceHelper.getIsBalanceMode()

	gohelper.setActive(self._btnBalanceStart, isBlance and not self._replayMode and self._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._btnUnPowerBalanceStart, isBlance and not self._replayMode and self._chapterConfig.type == DungeonEnum.ChapterType.Hard)

	if not self._enterAfterFreeLimit then
		local hasLimitCount = true

		if self:_getfreeCount() <= 0 then
			hasLimitCount = false

			goto label_62_0
		end

		local var_62_1

		if isCostPower then
			::label_62_1::

			var_62_1 = self._replayMode and self._chapterConfig.type ~= DungeonEnum.ChapterType.Hard
		end

		gohelper.setActive(self._btnstartreplay.gameObject, var_62_1)
		gohelper.setActive(self._btnunpowerreplay.gameObject, not isCostPower and not hasLimitCount and self._replayMode)
		gohelper.setActive(self._btnunpowerstart.gameObject, not isBlance and not isCostPower and not hasLimitCount and not self._replayMode)
		gohelper.setActive(self._btncostreplay.gameObject, not isCostPower and hasLimitCount and self._replayMode)
		gohelper.setActive(self._btncoststart.gameObject, not isBlance and not isCostPower and hasLimitCount and not self._replayMode)

		local var_62_2

		if isCostPower then
			::label_62_2::

			var_62_2 = self._replayMode and self._chapterConfig.type == DungeonEnum.ChapterType.Hard
		end

		gohelper.setActive(self._btnhardreplay.gameObject, var_62_2)
		gohelper.setActive(self._btnstart.gameObject, not isBlance and isCostPower and not self._replayMode and self._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
		gohelper.setActive(self._btnstarthard.gameObject, not isBlance and isCostPower and not self._replayMode and self._chapterConfig.type == DungeonEnum.ChapterType.Hard)

		local showDrop = not self._replayMode and self:_noAidHero()

		gohelper.setActive(self._dropherogroup, showDrop)

		if showDrop then
			TaskDispatcher.runRepeat(self._checkDropArrow, self, 0)
		else
			TaskDispatcher.cancelTask(self._checkDropArrow, self)
		end
	end
end

function V1a6_CachotHeroGroupFightView:_checkDropArrow()
	if not self._dropherogrouparrow then
		TaskDispatcher.cancelTask(self._checkDropArrow, self)

		return
	end

	local childCount = self._dropherogroup.transform.childCount

	if childCount ~= self._dropDownChildCount then
		self._dropDownChildCount = childCount

		local isOpen = self._dropgroupchildcount ~= childCount

		transformhelper.setLocalScale(self._dropherogrouparrow, 1, isOpen and -1 or 1, 1)
	end
end

function V1a6_CachotHeroGroupFightView:_noAidHero()
	local battleId = HeroGroupModel.instance.battleId
	local battleCo = lua_battle.configDict[battleId]

	if not battleCo then
		return
	end

	return battleCo.trialLimit <= 0 and string.nilorempty(battleCo.aid) and string.nilorempty(battleCo.trialHeros) and string.nilorempty(battleCo.trialEquips)
end

function V1a6_CachotHeroGroupFightView:_onGetFightRecordGroupReply(fightGroupMO)
	self.removeEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)

	self._replayFightGroupMO = fightGroupMO

	if not self._replayMode then
		return
	end

	self:_switchReplayGroup()
	self:_updateReplayHeroGorupList()
end

function V1a6_CachotHeroGroupFightView:_updateReplayHeroGorupList()
	V1a6_CachotHeroGroupModel.instance:setReplayParam(self._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, self._replayFightGroupMO.id)
	self:_refreshCloth()
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
end

return V1a6_CachotHeroGroupFightView
