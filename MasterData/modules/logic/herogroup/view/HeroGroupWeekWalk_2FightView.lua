-- chunkname: @modules/logic/herogroup/view/HeroGroupWeekWalk_2FightView.lua

module("modules.logic.herogroup.view.HeroGroupWeekWalk_2FightView", package.seeall)

local HeroGroupWeekWalk_2FightView = class("HeroGroupWeekWalk_2FightView", BaseView)
local MaxMultiplication = 4

function HeroGroupWeekWalk_2FightView:onInitView()
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
	self._btnTry = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_topbtns/btn_Try")
	self._goRecommendEffect = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_topbtns/btn_recommend/recommend")
	self._gocost = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_cost")
	self._gopower = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_cost/#go_power")
	self._simagepower = gohelper.findChildSingleImage(self.viewGO, "#go_container/btnContain/#go_cost/#go_power/#simage_power")
	self._txtusepower = gohelper.findChildText(self.viewGO, "#go_container/btnContain/#go_cost/#go_power/#txt_usepower")
	self._gopowercontent = gohelper.findChild(self.viewGO, "#go_righttop/#go_power")
	self._gofightCount = gohelper.findChild(self.viewGO, "#go_righttop/fightcount")
	self._txtfightCount = gohelper.findChildTextMesh(self.viewGO, "#go_righttop/fightcount/#txt_fightcount")
	self._gomask = gohelper.findChild(self.viewGO, "#go_container2/#go_mask")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "#go_container2")
	self._txtreplaycn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnStartReplay/#txt_replaycn")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_container/#go_topbtns")
	self._btnunpowerstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerStart")
	self._btnunpowerreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay")
	self._btnhardreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnHardReplay")
	self._txtreplayhardcn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnHardReplay/#txt_replayhardcn")
	self._txtreplayunpowercn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay/#txt_replayunpowercn")
	self._gonormallackpower = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_normallackpower")
	self._goreplaylackpower = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_replaylackpower")
	self._gospace = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_space")
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
	self._godoubledroptimes = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_doubletimes")
	self._txtdoubledroptimes = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/#go_doubletimes/#txt_doubletimes")
	self._gomemorytimes = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes")
	self._txtmemorytimes = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes/bg/#txt_memorytimes")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupWeekWalk_2FightView:addEvents()
	self._btnTrialTips:AddClickListener(self._switchTrialTips, self)
	self._btnSwitchBalance:AddClickListener(self._btnSwitchBalanceOnClick, self)
	self._btnstart:AddClickListener(self._onClickStart, self)
	self._btnstarthard:AddClickListener(self._onClickStart, self)
	self._btnstartreplay:AddClickListener(self._onClickStart, self)
	self._btnReplay:AddClickListener(self._onClickReplay, self)
	self._btncloth:AddClickListener(self._btnclothOnClock, self)
	self._btncareerrestrain:AddClickListener(self._btncareerrestrainOnClick, self)
	self._btnrecommend:AddClickListener(self._btnrecommendOnClick, self)

	if self._btnTry then
		self._btnTry:AddClickListener(self._btnTryOnClick, self)
	end

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

function HeroGroupWeekWalk_2FightView:removeEvents()
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

	if self._btnTry then
		self._btnTry:RemoveClickListener()
	end

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

function HeroGroupWeekWalk_2FightView:_openmultcontent()
	gohelper.setActive(self._gomultispeed, not self._gomultispeed.activeSelf)

	self._gomultispeed.transform.position = self._gomultPos.transform.position
end

function HeroGroupWeekWalk_2FightView:_closemultcontent()
	gohelper.setActive(self._gomultispeed, false)
end

function HeroGroupWeekWalk_2FightView:_btnSwitchBalanceOnClick()
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

function HeroGroupWeekWalk_2FightView:_btnclothOnClock()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local clothUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	if clothUnlock or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function HeroGroupWeekWalk_2FightView:_btncareerrestrainOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function HeroGroupWeekWalk_2FightView:_btnrecommendOnClick()
	FightFailRecommendController.instance:onClickRecommend()
	self:_udpateRecommendEffect()

	if self._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		local elementId = WeekWalkModel.instance:getBattleElementId()

		WeekwalkRpc.instance:sendWeekwalkHeroRecommendRequest(elementId, self._receiveRecommend, self)

		return
	end

	if self._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk_2 then
		local elementId = WeekWalk_2Model.instance:getBattleElementId()

		Weekwalk_2Rpc.instance:sendWeekwalkVer2HeroRecommendRequest(elementId, WeekWalk_2Model.instance:getCurMapId(), self._receiveRecommend, self)

		return
	end

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(self._episodeId, self._receiveRecommend, self)
end

function HeroGroupWeekWalk_2FightView:_btnTryOnClick()
	local tryoutcharacter = self:_getTryoutCharacter()

	if not tryoutcharacter then
		return
	end

	ViewMgr.instance:openView(ViewName.CommonTrialHeroDetailView, {
		heroId = tryoutcharacter
	})
end

function HeroGroupWeekWalk_2FightView:_getTryoutCharacter()
	if self._chapterConfig.actId <= 0 then
		return
	end

	local actCo = ActivityConfig.instance:getActivityCo(self._chapterConfig.actId)

	if not actCo or actCo.tryoutcharacter <= 0 then
		return
	end

	return actCo.tryoutcharacter
end

function HeroGroupWeekWalk_2FightView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, msg)
end

function HeroGroupWeekWalk_2FightView:_editableInitView()
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
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, self.refreshDoubleDropTips, self)

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

	local parent = self._gomultContent.transform

	for i = 1, MaxMultiplication do
		local item = parent:GetChild(i - 1)

		self:_setMultSpeedItem(item.gameObject, MaxMultiplication - i + 1)
	end

	gohelper.setActive(self._gomultispeed, false)
	self._simagereplayframe:LoadImage(ResUrl.getHeroGroupBg("fuxian_zhegai"))
end

function HeroGroupWeekWalk_2FightView:_setMultSpeedItem(go, multispeed, index)
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

function HeroGroupWeekWalk_2FightView:setMultSpeed(speed)
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

function HeroGroupWeekWalk_2FightView:_heroMoveForward(heroId)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(heroId))
end

function HeroGroupWeekWalk_2FightView:isReplayMode()
	return self._replayMode
end

function HeroGroupWeekWalk_2FightView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:_refreshCostPower()
end

function HeroGroupWeekWalk_2FightView:_respBeginFight()
	gohelper.setActive(self._gomask, true)
end

function HeroGroupWeekWalk_2FightView:_onOpenFullView(viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function HeroGroupWeekWalk_2FightView:_onCloseView(viewName)
	if viewName == ViewName.EquipInfoTeamShowView then
		self:_checkFirstPosHasEquip()
	end
end

function HeroGroupWeekWalk_2FightView:onOpen()
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
	NavigateMgr.instance:addEscape(self.viewName, self._onEscapeBtnClick, self)
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
	self:_dispatchGuideEvent()

	self._dropgroupchildcount = self._dropherogroup.transform.childCount

	self:_refreshReplay()
	self:_refreshTips()
	self:_refreshPowerShow()
	self:_udpateRecommendEffect()
	FightHelper.detectAttributeCounter()
	self:_initFightGroupDrop()

	if self._goTrialTips.activeSelf and not BossRushModel.instance:isSpecialLayerCurBattle() then
		gohelper.setActive(self._goTrialTipsBg, true)
	end

	if self._chapterConfig.type == DungeonEnum.ChapterType.TrialHero then
		local tryoutcharacter = self:_getTryoutCharacter()

		if not tryoutcharacter then
			return
		end

		local alert = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.HeroGroupFightView_TrialHeroAlert .. tryoutcharacter, "0")

		if alert == "0" then
			GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.HeroGroupFightView_TrialHeroAlert .. tryoutcharacter, "1")
			TaskDispatcher.runDelay(self._btnTryOnClick, self, 0.5)
		end
	end
end

function HeroGroupWeekWalk_2FightView:refreshFightCount(showPower)
	local freeNum = self:_getfreeCount()

	if freeNum > 0 then
		local useTimes = math.min(freeNum, self._multiplication)

		self._txtfightCount.text = string.format("%s<color=#E45A57> -%s</color>", freeNum, useTimes)
	end

	gohelper.setActive(self._gofightCount, freeNum > 0)

	if showPower then
		recthelper.setAnchorX(self._gofightCount.transform, -410)
	else
		recthelper.setAnchorX(self._gofightCount.transform, -196)
	end
end

function HeroGroupWeekWalk_2FightView:onOpenFinish()
	self:_dispatchGuideEventOnOpenFinish()
end

function HeroGroupWeekWalk_2FightView:_setTrialNumTips()
	local _, battleCO = HeroGroupWeekWalk_2FightView._getEpisodeConfigAndBattleConfig()
	local tips = {}
	local limitNum = HeroGroupTrialModel.instance:getLimitNum() or 0

	if limitNum > 0 then
		tips[1] = limitNum >= 4 and luaLang("herogroup_trial_tip") or formatLuaLang("herogroup_trial_limit_tip", limitNum)
	end

	if battleCO and not string.nilorempty(battleCO.trialEquips) then
		table.insert(tips, luaLang("herogroup_trial_equip_tip"))
	end

	gohelper.setActive(self._goTrialTips, #tips > 0)

	if #tips > 0 then
		gohelper.CreateObjList(self, self._setTrialTipsTxt, tips, self._goTrialTipsBg, self._goTrialTipsItem)
	end
end

function HeroGroupWeekWalk_2FightView:_onTouch()
	if self._goTrialTips.activeSelf and self._clickTrialFrame ~= UnityEngine.Time.frameCount and not ViewMgr.instance:isOpen(ViewName.HeroGroupBalanceTipView) then
		gohelper.setActive(self._goTrialTipsBg, false)
	end
end

function HeroGroupWeekWalk_2FightView:_setTrialTipsTxt(obj, data, index)
	gohelper.findChildTextMesh(obj, "desc").text = data
end

function HeroGroupWeekWalk_2FightView:_switchTrialTips()
	gohelper.setActive(self._goTrialTipsBg, not self._goTrialTipsBg.activeSelf)

	self._clickTrialFrame = UnityEngine.Time.frameCount
end

function HeroGroupWeekWalk_2FightView:_refreshPowerShow()
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
	self:refreshFightCount(showPower)
end

function HeroGroupWeekWalk_2FightView:_getMultiplicationKey()
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), self._episodeId)
end

function HeroGroupWeekWalk_2FightView:_udpateRecommendEffect()
	gohelper.setActive(self._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(self._episodeId))
end

function HeroGroupWeekWalk_2FightView:isShowHelpBtnIcon()
	local helpId = self.viewContainer:getHelpId()

	recthelper.setAnchorX(self._gotopbtns.transform, helpId and 568.56 or 419.88)
end

function HeroGroupWeekWalk_2FightView:_onEscapeBtnClick()
	if not self._gomask.gameObject.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function HeroGroupWeekWalk_2FightView:_getfreeCount()
	if not self._chapterConfig or self._chapterConfig.enterAfterFreeLimit <= 0 then
		return 0
	end

	return (DungeonModel.instance:getChapterRemainingNum(self._chapterConfig.type))
end

function HeroGroupWeekWalk_2FightView:setGroupChangeToast(id)
	self._changeToastId = id
end

function HeroGroupWeekWalk_2FightView:_groupDropValueChanged(value)
	local selectIndex = HeroGroupModel.instance:getGroupTypeName() and value or value + 1

	gohelper.setActive(self._btnmodifyname, selectIndex ~= 0)

	if HeroGroupModel.instance:setHeroGroupSelectIndex(selectIndex) then
		self:_checkEquipClothSkill()
		GameFacade.showToast(self._changeToastId or ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function HeroGroupWeekWalk_2FightView:_initFightGroupDrop()
	if not self:_noAidHero() then
		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if heroGroupType then
		self._dropherogroup.dropDown.enabled = false

		return
	end

	local list = {}

	for i = 1, 4 do
		list[i] = HeroGroupModel.instance:getCommonGroupName(i)
	end

	local selectIndex = HeroGroupModel.instance.curGroupSelectIndex

	gohelper.setActive(self._btnmodifyname, selectIndex ~= 0)

	local name = HeroGroupModel.instance:getGroupTypeName()

	if name then
		table.insert(list, 1, name)
	else
		selectIndex = selectIndex - 1
	end

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(selectIndex)
end

function HeroGroupWeekWalk_2FightView:_modifyName()
	ViewMgr.instance:openView(ViewName.HeroGroupModifyNameView)
end

function HeroGroupWeekWalk_2FightView:_refreshUI()
	local heroGroupId = HeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)

	self._episodeId = HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	self._chapterConfig = DungeonConfig.instance:getChapterCO(self.episodeConfig.chapterId)

	local freeNum = self:_getfreeCount()

	if freeNum - self._multiplication >= 0 then
		self._enterAfterFreeLimit = freeNum - self._multiplication or false
	end

	if self._btnTry then
		gohelper.setActive(self._btnTry, self._chapterConfig.type == DungeonEnum.ChapterType.TrialHero)
	end

	gohelper.setActive(self._btnrecommend.gameObject, self._chapterConfig.isHeroRecommend == 1)
	self:_refreshCost(true)
	self:_refreshCloth()
	self:_setTrialNumTips()
	self:refreshDoubleDropTips()
	self.viewContainer:setNavigateOverrideClose()

	local var_39_0 = self._goReplayBtn

	gohelper.setActive(var_39_0, (not HeroGroupBalanceHelper.getIsBalanceMode() or nil) and self.episodeConfig and not (self.episodeConfig.canUseRecord ~= 1 or self._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk))
end

function HeroGroupWeekWalk_2FightView:_refreshCost(visible)
	gohelper.setActive(self._gocost, visible)

	local remainCount = self:_getfreeCount()

	gohelper.setActive(self._gopower, not self._enterAfterFreeLimit)
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

function HeroGroupWeekWalk_2FightView:_refreshTips()
	gohelper.setActive(self._btnmultispeed.gameObject, self._replayMode)

	self._gomultispeed.transform.position = self._gomultPos.transform.position
end

function HeroGroupWeekWalk_2FightView:_refreshCostPower()
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
		gohelper.setActive(self._gonormallackpower, false)
		gohelper.setActive(self._goreplaylackpower, false)

		local usePowerColor = isHardChapter and "#FFFFFF" or "#070706"

		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, self._replayMode and "#070706" or usePowerColor)
	else
		local usePowerColor = isHardChapter and "#C44945" or "#800015"

		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, self._replayMode and "#800015" or usePowerColor)
		gohelper.setActive(self._gonormallackpower, not self._replayMode)
		gohelper.setActive(self._goreplaylackpower, self._replayMode)
	end
end

function HeroGroupWeekWalk_2FightView:_dispatchGuideEvent()
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

function HeroGroupWeekWalk_2FightView:_dispatchGuideEventOnOpenFinish()
	if self._episodeId then
		local chapterId = self.episodeConfig.chapterId
		local episodeType = self.episodeConfig.type

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithEpisodeId, self._episodeId)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithChapterId, chapterId)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithEpisodeType, episodeType)
	end
end

function HeroGroupWeekWalk_2FightView:_dispatchNoEquipEvent()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

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

function HeroGroupWeekWalk_2FightView:_isSpType(type)
	return type == DungeonEnum.ChapterType.Sp or type == DungeonEnum.ChapterType.TeachNote
end

function HeroGroupWeekWalk_2FightView:_dispatchRecordEvent()
	local showReplayBtn = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord

	if showReplayBtn and hasRecord then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
	end
end

function HeroGroupWeekWalk_2FightView:onClose()
	ViewMgr.instance:closeView(ViewName.CommonTrialHeroDetailView)
	TaskDispatcher.cancelTask(self._btnTryOnClick, self)
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

function HeroGroupWeekWalk_2FightView:_refreshReplay()
	if self._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		gohelper.setActive(self._goReplayBtn, false)
		gohelper.setActive(self._gomemorytimes, false)
	else
		gohelper.setActive(self._gomemorytimes, self._replayMode)

		local showReplayBtn = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
		local replay_is_unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
		local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
		local hasRecord = userDungeonMO and userDungeonMO.hasRecord

		ZProj.UGUIHelper.SetColorAlpha(self._imgbtnReplayBg, replay_is_unlock and hasRecord and 1 or 0.75)

		local normalIcon = self._replayMode and "btn_replay_pause" or "btn_replay_play"

		UISpriteSetMgr.instance:setHeroGroupSprite(self._imagereplayicon, replay_is_unlock and hasRecord and normalIcon or "btn_replay_lack")
		recthelper.setWidth(self._goReplayBtn.transform, self._replayMode and 416 or 83)

		if showReplayBtn and hasRecord and not self._replayMode then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
		end
	end
end

function HeroGroupWeekWalk_2FightView:_refreshCloth()
	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
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

	gohelper.setActive(self._btncloth.gameObject, HeroGroupWeekWalk_2FightView.showCloth())
end

function HeroGroupWeekWalk_2FightView:_checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			HeroGroupModel.instance:replaceCloth(clothMO.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function HeroGroupWeekWalk_2FightView._getEpisodeConfigAndBattleConfig()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local battleCO

	return episodeCO, HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 and lua_battle.configDict[HeroGroupModel.instance.battleId] or DungeonConfig.instance:getBattleCo(HeroGroupModel.instance.episodeId)
end

function HeroGroupWeekWalk_2FightView.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)

	if not clothShow then
		return false
	end

	local episodeCO, battleCO = HeroGroupWeekWalk_2FightView._getEpisodeConfigAndBattleConfig()

	if battleCO and battleCO.noClothSkill == 1 then
		return false
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local clothMO = PlayerClothModel.instance:getById(curGroupMO.clothId)
	local list = PlayerClothModel.instance:getList()
	local hasUnlock = false

	for _, clothMO in ipairs(list) do
		hasUnlock = true

		break
	end

	return hasUnlock
end

function HeroGroupWeekWalk_2FightView:_onModifyHeroGroup()
	self:_refreshCloth()
end

function HeroGroupWeekWalk_2FightView:_onModifySnapshot()
	self:_refreshCloth()
end

function HeroGroupWeekWalk_2FightView:_onClickHeroGroupItem(id)
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid

	self._param = {}
	self._param.singleGroupMOId = id
	self._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(id)
	self._param.adventure = HeroGroupModel.instance:isAdventureOrWeekWalk()
	self._param.equips = equips

	self:openHeroGroupEditView()
end

function HeroGroupWeekWalk_2FightView:openHeroGroupEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupEditView, self._param)
end

function HeroGroupWeekWalk_2FightView:_checkFirstPosHasEquip()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = curGroupMO:getPosEquips(0).equipUid
	local equipId = equips and equips[1]

	if equipId then
		::label_58_0::

		local equipMO = EquipModel.instance:getEquip(equipId)

		if equipMO then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
		end
	end
end

function HeroGroupWeekWalk_2FightView:_showGuideDragEffect(param)
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

function HeroGroupWeekWalk_2FightView:_onClickStart()
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
	self:_checkEnterFight()
end

function HeroGroupWeekWalk_2FightView:_checkEnterFight()
	local result = FightController.instance:setFightHeroSingleGroup()

	if not result then
		return
	end

	local selectedSkillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

	if not selectedSkillId then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.WeekWalk_2NoBuff, MsgBoxEnum.BoxType.Yes_No, self._enterFight, nil, nil, self)

		return
	end

	self:_enterFight()
end

function HeroGroupWeekWalk_2FightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = FightController.instance:setFightHeroSingleGroup()

		if result then
			self.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

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

function HeroGroupWeekWalk_2FightView:_onUseRecommendGroup()
	if self._replayMode then
		self:_closemultcontent()

		self._replayMode = false
		self._multiplication = 1

		self:_refreshCost(true)
		self:_switchReplayGroup()
	end
end

function HeroGroupWeekWalk_2FightView:_onClickReplay()
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

function HeroGroupWeekWalk_2FightView:_switchReplayGroup(lastRelayMode)
	self:_switchReplayMul()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, self._replayMode and "swicth" or UIAnimationName.Open)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SwitchReplay, self._replayMode)
	gohelper.setActive(self._gomemorytimes, self._replayMode)

	if self._replayMode then
		self:_updateReplayHeroGorupList()

		local replayCn = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(self._multiplication))

		self._txtreplaycn.text = replayCn
		self._txtreplayhardcn.text = replayCn
		self._txtreplayunpowercn.text = replayCn
		self._txtmemorytimes.text = self._replayFightGroupMO.recordRound
	else
		HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)

		local heroGroupId = HeroGroupModel.instance:getCurGroupMO().id

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)
		self:_refreshCloth()
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
	end
end

function HeroGroupWeekWalk_2FightView:_switchReplayMul()
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
	recthelper.setWidth(self._goReplayBtn.transform, self._replayMode and 416 or 83)
	ZProj.UGUIHelper.RebuildLayout(self._goReplayBtn.transform.parent)
	gohelper.setActive(self._goreplaybtnframe, self._replayMode)
end

function HeroGroupWeekWalk_2FightView:_haveRecord()
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

function HeroGroupWeekWalk_2FightView:_refreshBtns(isCostPower)
	local isBlance = HeroGroupBalanceHelper.getIsBalanceMode()

	gohelper.setActive(self._btnBalanceStart, isBlance and not self._replayMode and self._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._btnUnPowerBalanceStart, isBlance and not self._replayMode and self._chapterConfig.type == DungeonEnum.ChapterType.Hard)

	if not self._enterAfterFreeLimit then
		local hasLimitCount = true

		if self:_getfreeCount() <= 0 then
			hasLimitCount = false

			goto label_68_0
		end

		local var_68_1

		if isCostPower then
			::label_68_1::

			var_68_1 = self._replayMode and self._chapterConfig.type ~= DungeonEnum.ChapterType.Hard
		end

		gohelper.setActive(self._btnstartreplay.gameObject, var_68_1)
		gohelper.setActive(self._btnunpowerreplay.gameObject, not isCostPower and not hasLimitCount and self._replayMode)
		gohelper.setActive(self._btnunpowerstart.gameObject, not isBlance and not isCostPower and not hasLimitCount and not self._replayMode)
		gohelper.setActive(self._btncostreplay.gameObject, not isCostPower and hasLimitCount and self._replayMode)
		gohelper.setActive(self._btncoststart.gameObject, not isBlance and not isCostPower and hasLimitCount and not self._replayMode)
		gohelper.setActive(self._gospace, not self._replayMode and isCostPower)

		local var_68_2

		if isCostPower then
			::label_68_2::

			var_68_2 = self._replayMode and self._chapterConfig.type == DungeonEnum.ChapterType.Hard
		end

		gohelper.setActive(self._btnhardreplay.gameObject, var_68_2)
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

function HeroGroupWeekWalk_2FightView:_checkDropArrow()
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

function HeroGroupWeekWalk_2FightView:_noAidHero()
	local battleId = HeroGroupModel.instance.battleId
	local battleCo = lua_battle.configDict[battleId]

	if not battleCo then
		return
	end

	if ToughBattleModel.instance:getEpisodeId() then
		return
	end

	return battleCo.trialLimit <= 0 and string.nilorempty(battleCo.aid) and string.nilorempty(battleCo.trialHeros) and string.nilorempty(battleCo.trialEquips)
end

function HeroGroupWeekWalk_2FightView:_onGetFightRecordGroupReply(fightGroupMO)
	self.removeEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)

	self._replayFightGroupMO = fightGroupMO

	if not self._replayMode then
		return
	end

	self:_switchReplayGroup()
	self:_updateReplayHeroGorupList()
end

function HeroGroupWeekWalk_2FightView:_updateReplayHeroGorupList()
	HeroGroupModel.instance:setReplayParam(self._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, self._replayFightGroupMO.id)
	self:_refreshCloth()
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
end

function HeroGroupWeekWalk_2FightView:refreshDoubleDropTips()
	local episodeShow, remainTimes, dailyLimit = DoubleDropModel.instance:isShowDoubleByEpisode(self._episodeId, true)

	gohelper.setActive(self._godoubledroptimes, episodeShow)

	if episodeShow then
		local tag = {
			remainTimes,
			dailyLimit
		}

		self._txtdoubledroptimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), tag)
	end
end

return HeroGroupWeekWalk_2FightView
