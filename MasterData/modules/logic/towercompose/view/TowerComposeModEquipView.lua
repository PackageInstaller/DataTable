-- chunkname: @modules/logic/towercompose/view/TowerComposeModEquipView.lua

module("modules.logic.towercompose.view.TowerComposeModEquipView", package.seeall)

local TowerComposeModEquipView = class("TowerComposeModEquipView", BaseView)

function TowerComposeModEquipView:onInitView()
	self._gobossPosContent = gohelper.findChild(self.viewGO, "left/boss/#go_bossPosContent")
	self._gobossPos = gohelper.findChild(self.viewGO, "left/boss/#go_bossPosContent/#go_bossPos")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "left/#image_career")
	self._btnenemyInfo = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_enemyInfo")
	self._imagegrade = gohelper.findChildImage(self.viewGO, "left/gradebg/#image_grade")
	self._txtlevel = gohelper.findChildText(self.viewGO, "left/gradebg/#txt_level")
	self._btnextraTips = gohelper.findChildButtonWithAudio(self.viewGO, "left/gradebg/#txt_level/#btn_extraTips")
	self._gobossLock = gohelper.findChild(self.viewGO, "left/gradebg/#go_bossLock")
	self._goextraTips = gohelper.findChild(self.viewGO, "#go_extraTips")
	self._txtbossPointBase = gohelper.findChildText(self.viewGO, "left/integralbase/#txt_bossPointBase")
	self._gorulelist = gohelper.findChild(self.viewGO, "left/buff/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "left/buff/#go_rulelist/#btn_additionRuleclick")
	self._goruletemp = gohelper.findChild(self.viewGO, "left/buff/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "left/buff/#go_ruletemp/#image_tagicon")
	self._btnplane1 = gohelper.findChildButtonWithAudio(self.viewGO, "right/top/#btn_plane1")
	self._btnplane2 = gohelper.findChildButtonWithAudio(self.viewGO, "right/top/#btn_plane2")
	self._gobodyModSelect = gohelper.findChild(self.viewGO, "right/middle/#go_bodyModSelect")
	self._gobodyModSlotContent = gohelper.findChild(self.viewGO, "right/middle/#go_bodyModSelect/#go_bodyModSlotContent")
	self._gobodyModSlotItem = gohelper.findChild(self.viewGO, "right/middle/#go_bodyModSelect/#go_bodyModSlotContent/#go_bodyModSlotItem")
	self._gowordModSelect = gohelper.findChild(self.viewGO, "right/middle/#go_wordModSelect")
	self._gowordModSlotContent = gohelper.findChild(self.viewGO, "right/middle/#go_wordModSelect/#go_wordModSlotContent")
	self._gowordModSlotItem = gohelper.findChild(self.viewGO, "right/middle/#go_wordModSelect/#go_wordModSlotContent/#go_wordModSlotItem")
	self._goenvModSelect = gohelper.findChild(self.viewGO, "right/middle/#go_envModSelect")
	self._btncloseModList = gohelper.findChildButtonWithAudio(self.viewGO, "right/middle/#btn_closeModList")
	self._scrollbodyModList = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_bodyModList")
	self._gobodyModContent = gohelper.findChild(self.viewGO, "right/#scroll_bodyModList/Viewport/#go_bodyModContent")
	self._gobodyModItem = gohelper.findChild(self.viewGO, "right/#scroll_bodyModList/Viewport/#go_bodyModContent/#go_bodyModItem")
	self._scrollwordModList = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_wordModList")
	self._gowordModContent = gohelper.findChild(self.viewGO, "right/#scroll_wordModList/Viewport/#go_wordModContent")
	self._gowordModItem = gohelper.findChild(self.viewGO, "right/#scroll_wordModList/Viewport/#go_wordModContent/#go_wordModItem")
	self._scrollenvModList = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_envModList")
	self._goenvContent = gohelper.findChild(self.viewGO, "right/#scroll_envModList/Viewport/#go_envContent")
	self._goenvModItem = gohelper.findChild(self.viewGO, "right/#scroll_envModList/Viewport/#go_envContent/#go_envModItem")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._btnresearch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_research")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_ok")
	self._btnexitLoad = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_exitLoad")
	self._btnload = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_load")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeModEquipView:addEvents()
	self._btnenemyInfo:AddClickListener(self._btnenemyInfoOnClick, self)
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleclickOnClick, self)
	self._btnplane1:AddClickListener(self._btnPlane1OnClick, self)
	self._btnplane2:AddClickListener(self._btnPlane2OnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnresearch:AddClickListener(self._btnresearchOnClick, self)
	self._btncloseModList:AddClickListener(self._btncloseModListOnClick, self)
	self._btnextraTips:AddClickListener(self._btnextraTipsOnClick, self)
	self._btnexitLoad:AddClickListener(self._btnexitLoadOnClick, self)
	self._btnload:AddClickListener(self._btnloadOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SetPlaneMods, self.refreshUI, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.refreshLoadStateReply, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.LoadRecordReply, self.onClickLoadBtnReply, self)
end

function TowerComposeModEquipView:removeEvents()
	self._btnenemyInfo:RemoveClickListener()
	self._btnadditionRuleclick:RemoveClickListener()
	self._btnplane1:RemoveClickListener()
	self._btnplane2:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btnresearch:RemoveClickListener()
	self._btncloseModList:RemoveClickListener()
	self._btnextraTips:RemoveClickListener()
	self._btnexitLoad:RemoveClickListener()
	self._btnload:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.SetPlaneMods, self.refreshUI, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.refreshLoadStateReply, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.LoadRecordReply, self.onClickLoadBtnReply, self)
end

function TowerComposeModEquipView:_btnexitLoadOnClick()
	TowerComposeRpc.instance:sendTowerComposeCancelReChallengeRequest(self.curThemeId)
end

function TowerComposeModEquipView:_btnloadOnClick()
	TowerComposeRpc.instance:sendTowerComposeLoadRecordRequest(self.curThemeId)
end

function TowerComposeModEquipView:_btnextraTipsOnClick()
	gohelper.setActive(self._goextraTips, true)

	local param = {}

	param.posGO = self._goextraTips

	TowerComposeController.instance:openTowerComposeExtraTips(param)
end

function TowerComposeModEquipView:_btnenemyInfoOnClick()
	if self.towerEpisodeConfig.plane > 0 then
		local planeId = TowerComposeModel.instance:getCurSelectPlaneId()

		EnemyInfoController.instance:openTowerComposeEnemyInfoView(self.dungeonEpisodeCo.battleId, self.curThemeId, planeId, self.towerEpisodeConfig.episodeId)
	else
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.dungeonEpisodeCo.battleId)
	end
end

function TowerComposeModEquipView:_btnadditionRuleclickOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self.ruleList,
		offSet = {
			0,
			-155
		}
	})
end

function TowerComposeModEquipView:_btnPlane1OnClick()
	if self.curSelectPlaneId == 1 then
		return
	end

	TowerComposeModel.instance:setCurSelectPlaneId(1)
	self._animRight:Play("switch", 0, 0)
	self._animRight:Update(0)
	TaskDispatcher.runDelay(self.refreshUI, self, 0.16)
end

function TowerComposeModEquipView:_btnPlane2OnClick()
	if self.curSelectPlaneId == 2 or not self.plane2Mo then
		return
	end

	TowerComposeModel.instance:setCurSelectPlaneId(2)
	self._animRight:Play("switch", 0, 0)
	self._animRight:Update(0)
	TaskDispatcher.runDelay(self.refreshUI, self, 0.16)
end

function TowerComposeModEquipView:_btncloseModListOnClick()
	TowerComposeModel.instance:sendSetModsRequest(self.curThemeId, self.towerEpisodeConfig.layerId)

	if self.curSelectModType == TowerComposeEnum.ModType.Word then
		self._animRight:Play("back", 0, 0)
		self._animRight:Update(0)
	end

	self.isShowModList = false
	self.curSlotId = 0
	self.curSelectSlotId = self.curSlotId
	self.curSelectModType = TowerComposeEnum.ModType.None

	self:refreshModListShowState()
	self:refreshSlotSelectState()
end

function TowerComposeModEquipView:_btnBodyModSlotItemOnClick(bodyModSlotItem)
	if self:checkPlaneIsLock() then
		if bodyModSlotItem.modId > 0 then
			GameFacade.showToast(ToastEnum.TowerComposeRecordModLock)
			self:openTowerComposeModTipView(self.curSelectPlaneId, TowerComposeEnum.ModType.Body)
		else
			GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)
		end

		return
	end

	if self.curSlotId == bodyModSlotItem.slotId then
		self:_btncloseModListOnClick()

		return
	end

	self.curSlotId = bodyModSlotItem.slotId
	self.curSelectSlotId = self.curSlotId

	self:refreshBodyModList(bodyModSlotItem.slotId)

	self.curSelectModType = TowerComposeEnum.ModType.Body

	self:refreshModListShowState()
	self:refreshSlotSelectState()
end

function TowerComposeModEquipView:_btnBodyModItemOnClick(bodyModItem)
	self:modItemSelect(bodyModItem)
end

function TowerComposeModEquipView:_btnWordModSelectItemOnClick(wordModSlotItem)
	if self:checkPlaneIsLock() then
		if wordModSlotItem.modId > 0 then
			GameFacade.showToast(ToastEnum.TowerComposeRecordModLock)
			self:openTowerComposeModTipView(self.curSelectPlaneId, TowerComposeEnum.ModType.Word)
		else
			GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)
		end

		return
	end

	self:refreshWordModList(wordModSlotItem.slotId)

	self.curSelectModType = TowerComposeEnum.ModType.Word

	self:refreshModListShowState(true)

	self.curSelectSlotId = self:getCurWordModSlotId()

	self:refreshSlotSelectState()

	if not self.isShowModList then
		self._animRight:Play("word", 0, 0)
		self._animRight:Update(0)

		self.isShowModList = true
	else
		self:_btncloseModListOnClick()
	end
end

function TowerComposeModEquipView:_btnWordModItemOnClick(wordModItem)
	self:modItemSelect(wordModItem)
end

function TowerComposeModEquipView:_btnEnvModSelectItemOnClick(EnvModSlotItem)
	if self:checkPlaneIsLock() then
		if EnvModSlotItem.modId > 0 then
			GameFacade.showToast(ToastEnum.TowerComposeRecordModLock)
			self:openTowerComposeModTipView(self.curSelectPlaneId, TowerComposeEnum.ModType.Env)
		else
			GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)
		end

		return
	end

	self.curSlotId = EnvModSlotItem.slotId

	self:refreshEnvModList(EnvModSlotItem.slotId)

	self.curSelectModType = TowerComposeEnum.ModType.Env

	self:refreshModListShowState()
end

function TowerComposeModEquipView:_btnEnvModItemOnClick(envModItem)
	self:modItemSelect(envModItem)
end

function TowerComposeModEquipView:modItemSelect(modItem)
	local inPlaneId = modItem.inPlaneId

	self.curSlotId = self.curSelectModType == TowerComposeEnum.ModType.Word and self:getCurWordModSlotId() or self.curSlotId

	local needRefreshModList = false

	if inPlaneId > 0 and TowerComposeModel.instance:checkPlaneLock(self.curThemeId, inPlaneId) then
		GameFacade.showToast(ToastEnum.TowerComposeRecordModLock)

		return
	end

	if inPlaneId == 0 and modItem.initEnvModInfoMap then
		if modItem.initEnvModInfoMap[self.curPlaneMo.planeId] then
			self:planeSetEquipMod(self.curPlaneMo, self.curSelectModType, self.curSlotId, self.themeInitEnv)
		else
			self:planeSetEquipMod(self.curPlaneMo, self.curSelectModType, self.curSlotId, modItem.config.id)
		end

		self:refreshUI()

		needRefreshModList = true
	elseif inPlaneId > 0 and self.curPlaneMo.planeId ~= inPlaneId then
		if self.curSlotId == 0 then
			GameFacade.showToast(ToastEnum.TowerComposeModFull)

			return
		end

		self.curModItem = modItem

		GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeReplaceMod, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.replaceModTipCallBack, nil, nil, self)
	elseif inPlaneId > 0 and self.curPlaneMo.planeId == inPlaneId then
		local modInfo = modItem.modInfo

		if self.curSelectModType == TowerComposeEnum.ModType.Env then
			self:planeSetEquipMod(self.curPlaneMo, self.curSelectModType, modInfo.slot, self.themeInitEnv)
		else
			self:planeSetEquipMod(self.curPlaneMo, self.curSelectModType, modInfo.slot, 0)
		end

		self:refreshUI()

		needRefreshModList = true
	elseif inPlaneId == 0 then
		if not self.curSlotId or self.curSlotId == 0 then
			GameFacade.showToast(ToastEnum.TowerComposeModFull)

			return
		end

		self:planeSetEquipMod(self.curPlaneMo, self.curSelectModType, self.curSlotId, modItem.config.id)
		self:refreshUI()

		needRefreshModList = true
	end

	if needRefreshModList then
		if self.curSelectModType == TowerComposeEnum.ModType.Body then
			self:refreshBodyModList(self.curSlotId)

			local modId = self.curPlaneMo:getEquipModId(TowerComposeEnum.ModType.Body, self.curSlotId)

			if modId > 0 then
				self.bodyModSlotItemList[self.curSlotId].anim:Play("add", 0, 0)
				self.bodyModSlotItemList[self.curSlotId].anim:Update(0)
				AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_ripple_entry)
			end
		elseif self.curSelectModType == TowerComposeEnum.ModType.Word then
			self:refreshWordModList(self.curSlotId)

			local modId = self.curPlaneMo:getEquipModId(TowerComposeEnum.ModType.Word, self.curSlotId)

			if modId > 0 then
				self.wordModSlotItemList[self.curSlotId].anim:Play("add", 0, 0)
				self.wordModSlotItemList[self.curSlotId].anim:Update(0)
				AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_ripple_entry)
			end
		elseif self.curSelectModType == TowerComposeEnum.ModType.Env then
			self:refreshEnvModList(self.curSlotId)

			local modId = self.curPlaneMo:getEquipModId(TowerComposeEnum.ModType.Env, self.curSlotId)

			if modId > 0 then
				self.envModSlotItemList[self.curSlotId].anim:Play("add", 0, 0)
				self.envModSlotItemList[self.curSlotId].anim:Update(0)
			end
		end
	end

	if self.curSelectModType == TowerComposeEnum.ModType.Word then
		self.curSelectSlotId = self:getCurWordModSlotId()

		self:refreshSlotSelectState()
	end
end

function TowerComposeModEquipView:replaceModTipCallBack()
	local inPlaneId = self.curModItem.inPlaneId
	local inPlaneMo = self.themeMo:getPlaneMo(inPlaneId)
	local modInfo = self.curModItem.modInfo

	if self.curSelectModType == TowerComposeEnum.ModType.Env then
		inPlaneMo:setEquipModId(self.curSelectModType, modInfo.slot, self.themeInitEnv)
	else
		inPlaneMo:setEquipModId(self.curSelectModType, modInfo.slot, 0)
	end

	self.curPlaneMo:setEquipModId(self.curSelectModType, self.curSlotId, self.curModItem.config.id)
	self:refreshUI()

	if self.curSelectModType == TowerComposeEnum.ModType.Body then
		self:refreshBodyModList(self.curSlotId)
	elseif self.curSelectModType == TowerComposeEnum.ModType.Word then
		self:refreshWordModList(self.curSlotId)
	elseif self.curSelectModType == TowerComposeEnum.ModType.Env then
		self:refreshEnvModList(self.curSlotId)
	end
end

function TowerComposeModEquipView:planeSetEquipMod(planeMo, modType, slot, modId)
	if modId > 0 and self:checkModOverLockLevel(planeMo.planeId, modType, slot, modId) then
		GameFacade.showToast(ToastEnum.TowerComposeModOverLockLevel)

		return
	end

	planeMo:setEquipModId(modType, slot, modId)
end

function TowerComposeModEquipView:_btnokOnClick()
	local param = {}

	param.towerEpisodeConfig = self.towerEpisodeConfig

	TowerComposeController.instance:enterFight(param)
end

function TowerComposeModEquipView:_btnresearchOnClick()
	local param = {}

	param.themeId = TowerComposeModel.instance:getCurThemeIdAndLayer()

	TowerComposeController.instance:openTowerComposeResearchView(param)
end

function TowerComposeModEquipView:_editableInitView()
	self.guiBossSpineList = self:getUserDataTb_()
	self.ruleItemList = self:getUserDataTb_()

	gohelper.setActive(self._goruletemp, false)

	self.planeItemList = self:getUserDataTb_()

	for planeId = 1, 2 do
		self.planeItemList[planeId] = {}
		self.planeItemList[planeId].normalGO = gohelper.findChild(self["_btnplane" .. planeId].gameObject, "normal")
		self.planeItemList[planeId].selectGO = gohelper.findChild(self["_btnplane" .. planeId].gameObject, "select")
		self.planeItemList[planeId].lockGO = gohelper.findChild(self["_btnplane" .. planeId].gameObject, "lock")
	end

	gohelper.setActive(self._gobodyModSlotItem, false)
	gohelper.setActive(self._gowordModSlotItem, false)
	gohelper.setActive(self._gobodyModItem, false)
	gohelper.setActive(self._gowordModItem, false)
	gohelper.setActive(self._goenvModItem, false)
	gohelper.setActive(self._goextraTips, false)

	self.curSelectModType = TowerComposeEnum.ModType.None
	self.bodyModSlotItemList = self:getUserDataTb_()
	self.bodyModItemList = self:getUserDataTb_()
	self.wordModSlotItemList = self:getUserDataTb_()
	self.wordModItemList = self:getUserDataTb_()
	self.envModSlotItemList = self:getUserDataTb_()
	self.envModItemList = self:getUserDataTb_()
	self._goBodyModSelectBg1 = gohelper.findChild(self._gobodyModSelect, "go_itembg1")
	self._goBodyModSelectBg2 = gohelper.findChild(self._gobodyModSelect, "go_itembg2")
	self._goBodyModSelectBgFrame1 = gohelper.findChild(self._gobodyModSelect, "go_itembg1/#select")
	self._goBodyModSelectBgFrame2 = gohelper.findChild(self._gobodyModSelect, "go_itembg2/#select")
	self._goWordModSelectBg1 = gohelper.findChild(self._gowordModSelect, "go_itembg1")
	self._goWordModSelectBg2 = gohelper.findChild(self._gowordModSelect, "go_itembg2")
	self._goWordModSelectBgFrame1 = gohelper.findChild(self._gowordModSelect, "go_itembg1/#select")
	self._goWordModSelectBgFrame2 = gohelper.findChild(self._gowordModSelect, "go_itembg2/#select")
	self._goEnvModSelectBg1 = gohelper.findChild(self._goenvModSelect, "go_itembg1")
	self._goEnvModSelectBg2 = gohelper.findChild(self._goenvModSelect, "go_itembg2")
	self._txtBodyModLevel = gohelper.findChildText(self._gobodyModSelect, "name/txt_curModLevel")
	self._txtWordModLevel = gohelper.findChildText(self._gowordModSelect, "name/txt_curModLevel")
	self._txtEnvModLevel = gohelper.findChildText(self._goenvModSelect, "name/txt_curModLevel")
	self._goTop = gohelper.findChild(self.viewGO, "right/top")
	self.lastBossLevel = -1
	self.lastBossPointBase = -1
	self._animView = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animGradebg = gohelper.findChild(self.viewGO, "left/gradebg"):GetComponent(typeof(UnityEngine.Animator))
	self._animRight = gohelper.findChild(self.viewGO, "right"):GetComponent(typeof(UnityEngine.Animator))
	self._animIntegralBase = gohelper.findChild(self.viewGO, "left/integralbase"):GetComponent(typeof(UnityEngine.Animator))
	self._canvasBodyModSelect = self._gobodyModSelect:GetComponent(gohelper.Type_CanvasGroup)
	self._animBottom = self._gobottom:GetComponent(typeof(UnityEngine.Animator))
	self.animBottomName = nil
	self.isShowModList = false
	self._canvasBodyModSelect.blocksRaycasts = true
	self.gradeLevelGOList = {}

	for i = 1, self._imagegrade.gameObject.transform.childCount do
		local gradeLevelGO = self._imagegrade.gameObject.transform:GetChild(i - 1).gameObject

		table.insert(self.gradeLevelGOList, gradeLevelGO)
	end
end

function TowerComposeModEquipView:onUpdateParam()
	return
end

function TowerComposeModEquipView:onOpen()
	self.towerEpisodeConfig = self.viewParam and self.viewParam.towerEpisodeConfig
	self.dungeonEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.towerEpisodeConfig.episodeId)
	self.curThemeId, self.curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	self.themeConfig = TowerComposeConfig.instance:getThemeConfig(self.curThemeId)
	self.modSlotNumMap = TowerComposeConfig.instance:getModSlotNumMap(self.curThemeId)
	self.themeInitEnv = TowerComposeConfig.instance:getThemeInitEnv(self.curThemeId)
	self.themeBossCareerInfo = string.splitToNumber(self.themeConfig.career, "#")

	self:checkEmptyEnvAndEquipInit()
	self:refreshUI()
	self:refreshModListShowState()
	self:refreshSlotSelectState()
end

function TowerComposeModEquipView:checkEmptyEnvAndEquipInit()
	self.themeMo = TowerComposeModel.instance:getThemeMo(self.curThemeId)

	for planeId = 1, self.towerEpisodeConfig.plane do
		local planeMo = self.themeMo:getPlaneMo(planeId)
		local modInfoList = planeMo:getModInfoList(TowerComposeEnum.ModType.Env)

		for index, modInfoData in ipairs(modInfoList) do
			if modInfoData.modId == 0 then
				planeMo:setEquipModId(TowerComposeEnum.ModType.Env, modInfoData.slot, self.themeInitEnv)
			end
		end
	end
end

function TowerComposeModEquipView:refreshUI()
	self.curSelectPlaneId = TowerComposeModel.instance:getCurSelectPlaneId()
	self.themeMo = TowerComposeModel.instance:getThemeMo(self.curThemeId)
	self.plane1Mo = self.themeMo:getPlaneMo(1)
	self.plane2Mo = self.themeMo:getPlaneMo(2)

	if self.curSelectPlaneId == 1 then
		self.curPlaneMo = self.plane1Mo or self.plane2Mo
	end

	gohelper.setActive(self._goTop, self.plane2Mo)
	self:refreshBossSpine()
	self:refreshPlaneModInfo()
	self:checkBossInfoChange()
	self:refreshBossCareer()
	self:refreshLoadState()
end

function TowerComposeModEquipView:refreshLoadStateReply()
	self._animView:Play("open", 0, 0)
	self._animView:Update(0)
	self:refreshUI()
end

function TowerComposeModEquipView:checkBossInfoChange()
	local bossLevel = TowerComposeModel.instance:getThemePlaneLevel(self.curThemeId, self.curSelectModType ~= TowerComposeEnum.ModType.None)
	local planeId = TowerComposeModel.instance:getCurSelectPlaneId()
	local totalPointBase = TowerComposeModel.instance:calModPointBaseScore(self.curThemeId, planeId)
	local needDelayRefresh = false

	if self.lastBossLevel == -1 and self.lastBossLevel ~= bossLevel or self.lastBossPointBase == -1 and self.lastBossPointBase ~= totalPointBase then
		self.lastBossLevel = bossLevel
		self.lastBossPointBase = totalPointBase

		self:refreshPlaneInfo()
	end

	if self.lastBossLevel ~= bossLevel then
		self.lastBossLevel = bossLevel

		self._animGradebg:Play("switch", 0, 0)
		self._animGradebg:Update(0)

		needDelayRefresh = true

		AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_level_up)
	end

	if self.lastBossPointBase ~= totalPointBase then
		self.lastBossPointBase = totalPointBase

		self._animIntegralBase:Play("switch", 0, 0)
		self._animIntegralBase:Update(0)

		needDelayRefresh = true
	end

	if needDelayRefresh then
		TaskDispatcher.runDelay(self.refreshPlaneInfo, self, 0.16)
	end
end

function TowerComposeModEquipView:refreshBossSpine()
	local spineOffsetList = string.splitToNumber(self.themeConfig.spineOffset, "#")
	local spineOderLayerList = string.splitToNumber(self.themeConfig.orderLayer, "|")

	recthelper.setAnchor(self._gobossPosContent.transform, spineOffsetList[1], spineOffsetList[2])
	transformhelper.setLocalScale(self._gobossPosContent.transform, spineOffsetList[3], spineOffsetList[3], spineOffsetList[3])

	local modOffsetList = GameUtil.splitString2(self.themeConfig.modOffset, true)

	self.bossSkinCoList = {}

	local bossMonsterGroupId = self.themeConfig.monsterGroupId
	local monsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[bossMonsterGroupId].monster, "#")

	for _, monsterId in ipairs(monsterIdList) do
		local monsterCo = lua_monster.configDict[monsterId]
		local skinCo = lua_monster_skin.configDict[monsterCo.skinId]

		table.insert(self.bossSkinCoList, skinCo)
	end

	local planeId = TowerComposeModel.instance:getCurSelectPlaneId()
	local curBossSkinCoList = TowerComposeModel.instance:getPlaneBossSkinCoList(self.curThemeId, planeId, self.bossSkinCoList)

	for index, bossSkinCo in ipairs(curBossSkinCoList) do
		local guiBossSpine = self.guiBossSpineList[index]

		if not guiBossSpine then
			guiBossSpine = {
				index = index,
				pos = gohelper.clone(self._gobossPos, self._gobossPosContent, "pos_" .. index)
			}
			guiBossSpine.comp = MonoHelper.addNoUpdateLuaComOnceToGo(guiBossSpine.pos, TowerComposeThemeSpineComp)
			self.guiBossSpineList[index] = guiBossSpine
		end

		guiBossSpine.bossSkinCo = bossSkinCo

		gohelper.setActive(guiBossSpine.pos, true)

		local param = {
			bossSkinCo = bossSkinCo,
			index = index,
			modOffsetList = modOffsetList
		}

		guiBossSpine.comp:refreshSpine(param)
	end

	for _, guiBossSpine in ipairs(self.guiBossSpineList) do
		guiBossSpine.pos.transform:SetSiblingIndex(spineOderLayerList[guiBossSpine.index])
	end

	for index = #self.bossSkinCoList + 1, #self.guiBossSpineList do
		gohelper.setActive(self.guiBossSpineList[index].pos, false)
	end
end

function TowerComposeModEquipView:refreshPlaneInfo()
	local planeId = TowerComposeModel.instance:getCurSelectPlaneId()

	self.curPlaneMo = self.themeMo:getPlaneMo(planeId)

	local bossLevel = TowerComposeModel.instance:getThemePlaneLevel(self.curThemeId, self.curSelectModType ~= TowerComposeEnum.ModType.None)

	self._txtlevel.text = string.format("Lv.%d", bossLevel)

	local bossLvCo = TowerComposeConfig.instance:getBossLevelCo(self.towerEpisodeConfig.episodeId, bossLevel)

	UISpriteSetMgr.instance:setTower2Sprite(self._imagegrade, "tower_new_level_" .. string.lower(bossLvCo.levelReq))

	local pointRoundCoList = TowerComposeConfig.instance:getPointRoundCoList()
	local maxRoundPointAdd = pointRoundCoList[#pointRoundCoList].bossPointAdd
	local totalPointBase = TowerComposeModel.instance:calModPointBaseScore(self.curThemeId, planeId)

	self._txtbossPointBase.text = self.curPlaneMo.isLock and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_recordScore"), self.curPlaneMo.curScore) or GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towercompose_pointlevel"), totalPointBase, Mathf.Floor(totalPointBase * (1 + maxRoundPointAdd / 1000)))

	for _, gradeLevelGO in ipairs(self.gradeLevelGOList) do
		gohelper.setActive(gradeLevelGO, gradeLevelGO.name == "#" .. string.lower(bossLvCo.levelReq))
	end

	local battleCo = lua_battle.configDict[self.dungeonEpisodeCo.battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""

			self.ruleList = FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#")

			for index, ruleData in ipairs(self.ruleList) do
				local targetId = ruleData[1]
				local ruleId = ruleData[2]
				local ruleCo = lua_rule.configDict[ruleId]

				if ruleCo then
					local ruleItem = self.ruleItemList[index]

					if not ruleItem then
						ruleItem = {
							config = ruleCo,
							go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)
						}
						ruleItem.tagicon = gohelper.findChildImage(ruleItem.go, "#image_tagicon")
						ruleItem.simage = gohelper.findChildImage(ruleItem.go, "")
						self.ruleItemList[index] = ruleItem
					end

					gohelper.setActive(ruleItem.go, true)
					UISpriteSetMgr.instance:setCommonSprite(ruleItem.tagicon, "wz_" .. targetId)
					UISpriteSetMgr.instance:setDungeonLevelRuleSprite(ruleItem.simage, ruleCo.icon)
				end
			end

			for index = #self.ruleList + 1, #self.ruleItemList do
				gohelper.setActive(self.ruleItemList[index].go, false)
			end
		end
	end
end

function TowerComposeModEquipView:refreshBossCareer()
	local bossMonsterGroupId = self.themeConfig.monsterGroupId
	local monsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[bossMonsterGroupId].monster, "#")
	local monsterConfig = lua_monster.configDict[monsterIdList[1]]
	local haveModCareer, modCareer = self:checkModCareer()
	local curBossCareer = haveModCareer and modCareer or monsterConfig.career

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(curBossCareer))
end

function TowerComposeModEquipView:checkModCareer()
	local checkType = self.themeBossCareerInfo[1]
	local checkSlot = self.themeBossCareerInfo[2]
	local modId = self.curPlaneMo:getEquipModId(checkType, checkSlot)

	if modId > 0 then
		local modconfig = TowerComposeConfig.instance:getComposeModConfig(modId)

		if modconfig.career > 0 then
			return true, modconfig.career
		end
	end

	return false
end

function TowerComposeModEquipView:refreshPlaneModInfo()
	for planeId, planeItem in ipairs(self.planeItemList) do
		gohelper.setActive(planeItem.normalGO, planeId ~= self.curSelectPlaneId)
		gohelper.setActive(planeItem.selectGO, planeId == self.curSelectPlaneId)
	end

	self:refreshBodySlotMod()
	self:refreshWordSlotMod()
	self:refreshEnvSlotMod()
end

function TowerComposeModEquipView:refreshModListShowState(isIgnoreWordSlot)
	self._canvasBodyModSelect.blocksRaycasts = not isIgnoreWordSlot

	gohelper.setActive(self._scrollbodyModList, self.curSelectModType == TowerComposeEnum.ModType.Body)
	gohelper.setActive(self._scrollwordModList, self.curSelectModType == TowerComposeEnum.ModType.Word)
	gohelper.setActive(self._scrollenvModList, self.curSelectModType == TowerComposeEnum.ModType.Env)
	gohelper.setActive(self._gobodyModSelect, self.curSelectModType == TowerComposeEnum.ModType.Body or self.curSelectModType == TowerComposeEnum.ModType.None or isIgnoreWordSlot)
	gohelper.setActive(self._gowordModSelect, self.curSelectModType == TowerComposeEnum.ModType.Word or self.curSelectModType == TowerComposeEnum.ModType.None or isIgnoreWordSlot)
	gohelper.setActive(self._goenvModSelect, self.curSelectModType == TowerComposeEnum.ModType.Env or self.curSelectModType == TowerComposeEnum.ModType.None)
	gohelper.setActive(self._btncloseModList, self.curSelectModType ~= TowerComposeEnum.ModType.None)
	gohelper.setActive(self._goBodyModSelectBgFrame1, self.curSelectModType == TowerComposeEnum.ModType.Body and self.curSelectPlaneId == 1)
	gohelper.setActive(self._goBodyModSelectBgFrame2, self.curSelectModType == TowerComposeEnum.ModType.Body and self.curSelectPlaneId == 2)
	gohelper.setActive(self._goWordModSelectBgFrame1, self.curSelectModType == TowerComposeEnum.ModType.Word and self.curSelectPlaneId == 1)
	gohelper.setActive(self._goWordModSelectBgFrame2, self.curSelectModType == TowerComposeEnum.ModType.Word and self.curSelectPlaneId == 2)

	local animName = self.curSelectModType == TowerComposeEnum.ModType.None and "open" or "close"

	if self.animBottomName then
		self.animBottomName = self.animBottomName or animName
	end

	if self.animBottomName ~= animName then
		self._animBottom:Play(animName, 0, 0)
		self._animBottom:Update(0)

		self.animBottomName = animName
	end

	self._scrollbodyModList.verticalNormalizedPosition = 1
	self._scrollwordModList.verticalNormalizedPosition = 1
	self._scrollenvModList.verticalNormalizedPosition = 1
end

function TowerComposeModEquipView:refreshBodySlotMod()
	local bodyModSlotNum = self.modSlotNumMap[TowerComposeEnum.ModType.Body]

	for planeId = 1, 2 do
		gohelper.setActive(self["_goBodyModSelectBg" .. planeId], planeId == self.curSelectPlaneId)
	end

	for slotId = 1, bodyModSlotNum do
		local bodyModSlotItem = self.bodyModSlotItemList[slotId]

		if not bodyModSlotItem then
			bodyModSlotItem = {
				slotId = slotId,
				go = gohelper.clone(self._gobodyModSlotItem, self._gobodyModSlotContent, "bodyModSlot" .. slotId)
			}
			bodyModSlotItem.imageSelectBg1 = gohelper.findChildImage(bodyModSlotItem.go, "frame/go_select1")
			bodyModSlotItem.imageSelectBg2 = gohelper.findChildImage(bodyModSlotItem.go, "frame/go_select2")
			bodyModSlotItem.goSelectBg1 = gohelper.findChild(bodyModSlotItem.go, "frame/go_select1")
			bodyModSlotItem.goSelectBg2 = gohelper.findChild(bodyModSlotItem.go, "frame/go_select2")
			bodyModSlotItem.imageSelectFrame1 = gohelper.findChildImage(bodyModSlotItem.go, "frame/go_selectframe1")
			bodyModSlotItem.imageSelectFrame2 = gohelper.findChildImage(bodyModSlotItem.go, "frame/go_selectframe2")
			bodyModSlotItem.goSelectFrame1 = gohelper.findChild(bodyModSlotItem.go, "frame/go_selectframe1")
			bodyModSlotItem.goSelectFrame2 = gohelper.findChild(bodyModSlotItem.go, "frame/go_selectframe2")
			bodyModSlotItem.goEmpty = gohelper.findChild(bodyModSlotItem.go, "go_empty")
			bodyModSlotItem.goLockEmpty = gohelper.findChild(bodyModSlotItem.go, "go_lockEmpty")
			bodyModSlotItem.imageModIcon = gohelper.findChildImage(bodyModSlotItem.go, "image_modIcon")
			bodyModSlotItem.imageModColorIcon = gohelper.findChildImage(bodyModSlotItem.go, "image_modIcon_01")
			bodyModSlotItem.materialModIcon = UnityEngine.Object.Instantiate(bodyModSlotItem.imageModColorIcon.material)
			bodyModSlotItem.imageModLvColorIcon = gohelper.findChildImage(bodyModSlotItem.go, "image_modIcon_02")
			bodyModSlotItem.materialModLvIcon = UnityEngine.Object.Instantiate(bodyModSlotItem.imageModLvColorIcon.material)
			bodyModSlotItem.goLine = gohelper.findChild(bodyModSlotItem.go, "go_line")
			bodyModSlotItem.btnClick = gohelper.findChildButtonWithAudio(bodyModSlotItem.go, "btn_click")
			bodyModSlotItem.anim = bodyModSlotItem.go:GetComponent(typeof(UnityEngine.Animator))
			bodyModSlotItem.imageModColorIcon.material = bodyModSlotItem.materialModIcon
			bodyModSlotItem.imageModLvColorIcon.material = bodyModSlotItem.materialModLvIcon
			bodyModSlotItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(bodyModSlotItem.go, TowerComposeModIconComp)
			self.bodyModSlotItemList[slotId] = bodyModSlotItem
		end

		gohelper.setActive(bodyModSlotItem.go, true)
		bodyModSlotItem.btnClick:AddClickListener(self._btnBodyModSlotItemOnClick, self, bodyModSlotItem)

		bodyModSlotItem.modId = self.curPlaneMo:getEquipModId(TowerComposeEnum.ModType.Body, slotId)

		local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.curThemeId, self.curPlaneMo.planeId)

		gohelper.setActive(bodyModSlotItem.goEmpty, bodyModSlotItem.modId == 0 and not isPlaneLock)
		gohelper.setActive(bodyModSlotItem.goLockEmpty, bodyModSlotItem.modId == 0 and isPlaneLock)
		gohelper.setActive(bodyModSlotItem.imageModColorIcon.gameObject, bodyModSlotItem.modId > 0)
		bodyModSlotItem.modIconComp:refreshMod(bodyModSlotItem.modId, bodyModSlotItem.imageModIcon, bodyModSlotItem.imageModColorIcon, bodyModSlotItem.imageModLvColorIcon, bodyModSlotItem.materialModIcon, bodyModSlotItem.materialModLvIcon)
		gohelper.setActive(bodyModSlotItem.goLine, slotId < bodyModSlotNum)
		UISpriteSetMgr.instance:setTower2Sprite(bodyModSlotItem.imageSelectBg1, string.format("tower_new_frame%d_3", slotId))
		UISpriteSetMgr.instance:setTower2Sprite(bodyModSlotItem.imageSelectBg2, string.format("tower_new_frame%d_5", slotId))
		UISpriteSetMgr.instance:setTower2Sprite(bodyModSlotItem.imageSelectFrame1, string.format("tower_new_frame%d_4", slotId))
		UISpriteSetMgr.instance:setTower2Sprite(bodyModSlotItem.imageSelectFrame2, string.format("tower_new_frame%d_6", slotId))
		gohelper.setActive(bodyModSlotItem.goSelectBg1, self.curSelectPlaneId == 1)
		gohelper.setActive(bodyModSlotItem.goSelectBg2, self.curSelectPlaneId == 2)
	end

	local curModLevel = self.curPlaneMo:getEquipModLevel(TowerComposeEnum.ModType.Body)

	self._txtBodyModLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_modLevel"), curModLevel)
end

function TowerComposeModEquipView:refreshBodyModList(slotId)
	local modConfigList = TowerComposeModel.instance:getAllUnlockTypeModCoList(self.curThemeId, TowerComposeEnum.ModType.Body, slotId)

	modConfigList = self:modListSort(modConfigList, TowerComposeEnum.ModType.Body, self.curSelectPlaneId)

	for index, modConfig in ipairs(modConfigList) do
		local bodyModItem = self.bodyModItemList[index]

		if not bodyModItem then
			bodyModItem = {
				go = gohelper.clone(self._gobodyModItem, self._gobodyModContent, "modItem" .. modConfig.id)
			}
			bodyModItem.goNormal1 = gohelper.findChild(bodyModItem.go, "go_normal1")
			bodyModItem.goNormal2 = gohelper.findChild(bodyModItem.go, "go_normal2")
			bodyModItem.goSelect1 = gohelper.findChild(bodyModItem.go, "go_select1")
			bodyModItem.goSelect2 = gohelper.findChild(bodyModItem.go, "go_select2")
			bodyModItem.imageIcon = gohelper.findChildImage(bodyModItem.go, "image_icon")
			bodyModItem.imageModColorIcon = gohelper.findChildImage(bodyModItem.go, "image_icon_01")
			bodyModItem.materialModIcon = UnityEngine.Object.Instantiate(bodyModItem.imageModColorIcon.material)
			bodyModItem.imageModLvColorIcon = gohelper.findChildImage(bodyModItem.go, "image_icon_02")
			bodyModItem.materialModLvIcon = UnityEngine.Object.Instantiate(bodyModItem.imageModLvColorIcon.material)
			bodyModItem.imageModColorIcon.material = bodyModItem.materialModIcon
			bodyModItem.imageModLvColorIcon.material = bodyModItem.materialModLvIcon
			bodyModItem.txtDesc = gohelper.findChildText(bodyModItem.go, "txt_desc")

			SkillHelper.addHyperLinkClick(bodyModItem.txtDesc, self._onHyperLinkClick, self)

			bodyModItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(bodyModItem.txtDesc.gameObject, FixTmpBreakLine)
			bodyModItem.txtName = gohelper.findChildText(bodyModItem.go, "txt_desc/txt_name")
			bodyModItem.txtLv = gohelper.findChildText(bodyModItem.go, "txt_desc/txt_name/txt_lv")
			bodyModItem.goIsIn1 = gohelper.findChild(bodyModItem.go, "go_isIn1")
			bodyModItem.goIsIn2 = gohelper.findChild(bodyModItem.go, "go_isIn2")
			bodyModItem.btnClick = gohelper.findChildButtonWithAudio(bodyModItem.go, "btn_click")
			bodyModItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(bodyModItem.go, TowerComposeModIconComp)
			self.bodyModItemList[index] = bodyModItem
		end

		bodyModItem.config = modConfig

		bodyModItem.btnClick:AddClickListener(self._btnBodyModItemOnClick, self, bodyModItem)
		gohelper.setActive(bodyModItem.go, true)
		gohelper.setActive(bodyModItem.goNormal1, self.curSelectPlaneId == 1)
		gohelper.setActive(bodyModItem.goNormal2, self.curSelectPlaneId == 2)

		bodyModItem.inPlaneId, bodyModItem.modInfo = TowerComposeModel.instance:checkModIsInPlane(bodyModItem.config.id, TowerComposeEnum.ModType.Body)

		gohelper.setActive(bodyModItem.goIsIn1, bodyModItem.inPlaneId > 0 and bodyModItem.inPlaneId == 1)
		gohelper.setActive(bodyModItem.goIsIn2, bodyModItem.inPlaneId > 0 and bodyModItem.inPlaneId == 2)
		gohelper.setActive(bodyModItem.goSelect1, bodyModItem.inPlaneId > 0 and bodyModItem.inPlaneId == 1 and self.curSelectPlaneId == 1)
		gohelper.setActive(bodyModItem.goSelect2, bodyModItem.inPlaneId > 0 and bodyModItem.inPlaneId == 2 and self.curSelectPlaneId == 2)
		bodyModItem.modIconComp:refreshMod(bodyModItem.config.id, bodyModItem.imageIcon, bodyModItem.imageModColorIcon, bodyModItem.imageModLvColorIcon, bodyModItem.materialModIcon, bodyModItem.materialModLvIcon)

		bodyModItem.txtDesc.text = SkillHelper.buildDesc(bodyModItem.config.desc)

		bodyModItem.descFixTmpBreakLine:refreshTmpContent(bodyModItem.txtDesc)

		bodyModItem.txtName.text = bodyModItem.config.name
		bodyModItem.txtLv.text = string.format("Lv.%d", bodyModItem.config.level)
	end

	for index = #modConfigList + 1, #self.bodyModItemList do
		gohelper.setActive(self.bodyModItemList[index].go, false)
	end
end

function TowerComposeModEquipView:refreshWordSlotMod()
	local wordModSlotNum = self.modSlotNumMap[TowerComposeEnum.ModType.Word]

	for planeId = 1, 2 do
		gohelper.setActive(self["_goWordModSelectBg" .. planeId], planeId == self.curSelectPlaneId)
	end

	for slotId = 1, wordModSlotNum do
		local wordModSlotItem = self.wordModSlotItemList[slotId]

		if not wordModSlotItem then
			wordModSlotItem = {
				slotId = slotId,
				go = gohelper.clone(self._gowordModSlotItem, self._gowordModSlotContent, "wordModSlot" .. slotId)
			}
			wordModSlotItem.goSelectBg1 = gohelper.findChild(wordModSlotItem.go, "frame/go_select1")
			wordModSlotItem.goSelectBg2 = gohelper.findChild(wordModSlotItem.go, "frame/go_select2")
			wordModSlotItem.goSelectFrame1 = gohelper.findChild(wordModSlotItem.go, "frame/go_selectframe1")
			wordModSlotItem.goSelectFrame2 = gohelper.findChild(wordModSlotItem.go, "frame/go_selectframe2")
			wordModSlotItem.goEmpty = gohelper.findChild(wordModSlotItem.go, "go_empty")
			wordModSlotItem.goLockEmpty = gohelper.findChild(wordModSlotItem.go, "go_lockEmpty")
			wordModSlotItem.imageModIcon = gohelper.findChildImage(wordModSlotItem.go, "image_modIcon")
			wordModSlotItem.imageModColorIcon = gohelper.findChildImage(wordModSlotItem.go, "image_modIcon_01")
			wordModSlotItem.materialModIcon = UnityEngine.Object.Instantiate(wordModSlotItem.imageModColorIcon.material)
			wordModSlotItem.imageModLvColorIcon = gohelper.findChildImage(wordModSlotItem.go, "image_modIcon_02")
			wordModSlotItem.materialModLvIcon = UnityEngine.Object.Instantiate(wordModSlotItem.imageModLvColorIcon.material)
			wordModSlotItem.imageModColorIcon.material = wordModSlotItem.materialModIcon
			wordModSlotItem.imageModLvColorIcon.material = wordModSlotItem.materialModLvIcon
			wordModSlotItem.goLine = gohelper.findChild(wordModSlotItem.go, "go_line")
			wordModSlotItem.btnClick = gohelper.findChildButtonWithAudio(wordModSlotItem.go, "btn_click")
			wordModSlotItem.anim = wordModSlotItem.go:GetComponent(typeof(UnityEngine.Animator))
			wordModSlotItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(wordModSlotItem.go, TowerComposeModIconComp)
			self.wordModSlotItemList[slotId] = wordModSlotItem
		end

		gohelper.setActive(wordModSlotItem.go, true)
		wordModSlotItem.btnClick:AddClickListener(self._btnWordModSelectItemOnClick, self, wordModSlotItem)

		wordModSlotItem.modId = self.curPlaneMo:getEquipModId(TowerComposeEnum.ModType.Word, slotId)

		local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.curThemeId, self.curPlaneMo.planeId)

		gohelper.setActive(wordModSlotItem.goEmpty, wordModSlotItem.modId == 0 and not isPlaneLock)
		gohelper.setActive(wordModSlotItem.goLockEmpty, wordModSlotItem.modId == 0 and isPlaneLock)
		gohelper.setActive(wordModSlotItem.imageModColorIcon.gameObject, wordModSlotItem.modId > 0)
		wordModSlotItem.modIconComp:refreshMod(wordModSlotItem.modId, wordModSlotItem.imageModIcon, wordModSlotItem.imageModColorIcon, wordModSlotItem.imageModLvColorIcon, wordModSlotItem.materialModIcon, wordModSlotItem.materialModLvIcon)
		gohelper.setActive(wordModSlotItem.goLine, slotId < wordModSlotNum)
		gohelper.setActive(wordModSlotItem.goSelectBg1, self.curSelectPlaneId == 1)
		gohelper.setActive(wordModSlotItem.goSelectBg2, self.curSelectPlaneId == 2)
	end

	local curModLevel = self.curPlaneMo:getEquipModLevel(TowerComposeEnum.ModType.Word)

	self._txtWordModLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_modLevel"), curModLevel)
end

function TowerComposeModEquipView:refreshWordModList(slotId)
	local modConfigList = TowerComposeModel.instance:getAllUnlockTypeModCoList(self.curThemeId, TowerComposeEnum.ModType.Word, slotId)

	modConfigList = self:modListSort(modConfigList, TowerComposeEnum.ModType.Word, self.curSelectPlaneId)

	for index, modConfig in ipairs(modConfigList) do
		local wordModItem = self.wordModItemList[index]

		if not wordModItem then
			wordModItem = {
				go = gohelper.clone(self._gowordModItem, self._gowordModContent, "modItem" .. modConfig.id)
			}
			wordModItem.goNormal1 = gohelper.findChild(wordModItem.go, "go_normal1")
			wordModItem.goNormal2 = gohelper.findChild(wordModItem.go, "go_normal2")
			wordModItem.goSelect1 = gohelper.findChild(wordModItem.go, "go_select1")
			wordModItem.goSelect2 = gohelper.findChild(wordModItem.go, "go_select2")
			wordModItem.imageIcon = gohelper.findChildImage(wordModItem.go, "image_icon")
			wordModItem.imageModColorIcon = gohelper.findChildImage(wordModItem.go, "image_icon_01")
			wordModItem.materialModIcon = UnityEngine.Object.Instantiate(wordModItem.imageModColorIcon.material)
			wordModItem.imageModLvColorIcon = gohelper.findChildImage(wordModItem.go, "image_icon_02")
			wordModItem.materialModLvIcon = UnityEngine.Object.Instantiate(wordModItem.imageModLvColorIcon.material)
			wordModItem.imageModColorIcon.material = wordModItem.materialModIcon
			wordModItem.imageModLvColorIcon.material = wordModItem.materialModLvIcon
			wordModItem.txtDesc = gohelper.findChildText(wordModItem.go, "txt_desc")

			SkillHelper.addHyperLinkClick(wordModItem.txtDesc, self._onHyperLinkClick, self)

			wordModItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(wordModItem.txtDesc.gameObject, FixTmpBreakLine)
			wordModItem.txtName = gohelper.findChildText(wordModItem.go, "txt_name")
			wordModItem.txtLv = gohelper.findChildText(wordModItem.go, "txt_name/txt_lv")
			wordModItem.goIsIn1 = gohelper.findChild(wordModItem.go, "go_isIn1")
			wordModItem.goIsIn2 = gohelper.findChild(wordModItem.go, "go_isIn2")
			wordModItem.btnClick = gohelper.findChildButtonWithAudio(wordModItem.go, "btn_click")
			wordModItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(wordModItem.go, TowerComposeModIconComp)
			self.wordModItemList[index] = wordModItem
		end

		wordModItem.config = modConfig

		wordModItem.btnClick:AddClickListener(self._btnWordModItemOnClick, self, wordModItem)
		gohelper.setActive(wordModItem.go, true)
		gohelper.setActive(wordModItem.goNormal1, self.curSelectPlaneId == 1)
		gohelper.setActive(wordModItem.goNormal2, self.curSelectPlaneId == 2)

		wordModItem.inPlaneId, wordModItem.modInfo = TowerComposeModel.instance:checkModIsInPlane(wordModItem.config.id, TowerComposeEnum.ModType.Word)

		gohelper.setActive(wordModItem.goIsIn1, wordModItem.inPlaneId > 0 and wordModItem.inPlaneId == 1)
		gohelper.setActive(wordModItem.goIsIn2, wordModItem.inPlaneId > 0 and wordModItem.inPlaneId == 2)
		gohelper.setActive(wordModItem.goSelect1, wordModItem.inPlaneId > 0 and wordModItem.inPlaneId == 1 and self.curSelectPlaneId == 1)
		gohelper.setActive(wordModItem.goSelect2, wordModItem.inPlaneId > 0 and wordModItem.inPlaneId == 2 and self.curSelectPlaneId == 2)
		wordModItem.modIconComp:refreshMod(wordModItem.config.id, wordModItem.imageIcon, wordModItem.imageModColorIcon, wordModItem.imageModLvColorIcon, wordModItem.materialModIcon, wordModItem.materialModLvIcon)

		wordModItem.txtDesc.text = SkillHelper.buildDesc(wordModItem.config.desc)

		wordModItem.descFixTmpBreakLine:refreshTmpContent(wordModItem.txtDesc)

		wordModItem.txtName.text = wordModItem.config.name
		wordModItem.txtLv.text = string.format("Lv.%d", wordModItem.config.level)
	end

	for index = #modConfigList + 1, #self.wordModItemList do
		gohelper.setActive(self.wordModItemList[index].go, false)
	end
end

function TowerComposeModEquipView:refreshEnvSlotMod()
	local envModSlotNum = self.modSlotNumMap[TowerComposeEnum.ModType.Env]

	for planeId = 1, 2 do
		gohelper.setActive(self["_goEnvModSelectBg" .. planeId], planeId == self.curSelectPlaneId)
	end

	for slotId = 1, envModSlotNum do
		local envModSlotItem = self.envModSlotItemList[slotId]

		if not envModSlotItem then
			envModSlotItem = {
				slotId = slotId,
				go = self._goenvModSelect
			}
			envModSlotItem.goHas = gohelper.findChild(envModSlotItem.go, "go_has")
			envModSlotItem.imageModIcon = gohelper.findChildImage(envModSlotItem.go, "go_has/image_icon")
			envModSlotItem.txtName = gohelper.findChildText(envModSlotItem.go, "go_has/txt_name")
			envModSlotItem.txtDesc = gohelper.findChildText(envModSlotItem.go, "go_has/scroll_desc/viewport/txt_desc")

			SkillHelper.addHyperLinkClick(envModSlotItem.txtDesc, self._onHyperLinkClick, self)

			envModSlotItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(envModSlotItem.txtDesc.gameObject, FixTmpBreakLine)
			envModSlotItem.simagePic = gohelper.findChildSingleImage(envModSlotItem.go, "go_has/simage_pic")
			envModSlotItem.goIconBg1 = gohelper.findChild(envModSlotItem.go, "go_has/go_iconbg1")
			envModSlotItem.goIconBg2 = gohelper.findChild(envModSlotItem.go, "go_has/go_iconbg2")
			envModSlotItem.goSwitchIcon = gohelper.findChild(envModSlotItem.go, "go_has/go_switchIcon")
			envModSlotItem.goEmpty = gohelper.findChild(envModSlotItem.go, "go_empty")
			envModSlotItem.btnClick = gohelper.findChildButtonWithAudio(envModSlotItem.go, "btn_click")
			envModSlotItem.anim = envModSlotItem.go:GetComponent(typeof(UnityEngine.Animator))
			self.envModSlotItemList[slotId] = envModSlotItem

			gohelper.setActive(envModSlotItem.go, true)
		end

		envModSlotItem.btnClick:AddClickListener(self._btnEnvModSelectItemOnClick, self, envModSlotItem)

		envModSlotItem.modId = self.curPlaneMo:getEquipModId(TowerComposeEnum.ModType.Env, slotId)

		local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.curThemeId, self.curPlaneMo.planeId)

		gohelper.setActive(envModSlotItem.goEmpty, envModSlotItem.modId == 0)
		gohelper.setActive(envModSlotItem.goHas, envModSlotItem.modId > 0)
		gohelper.setActive(envModSlotItem.goIconBg1, self.curSelectPlaneId == 1 and not isPlaneLock)
		gohelper.setActive(envModSlotItem.goIconBg2, self.curSelectPlaneId == 2 and not isPlaneLock)
		gohelper.setActive(envModSlotItem.goSwitchIcon, not isPlaneLock)

		if envModSlotItem.modId > 0 then
			local modconfig = TowerComposeConfig.instance:getComposeModConfig(envModSlotItem.modId)

			UISpriteSetMgr.instance:setTower2Sprite(envModSlotItem.imageModIcon, modconfig.icon)
			envModSlotItem.simagePic:LoadImage(modconfig.image)

			envModSlotItem.txtName.text = modconfig.name
			envModSlotItem.txtDesc.text = SkillHelper.buildDesc(modconfig.desc)

			envModSlotItem.descFixTmpBreakLine:refreshTmpContent(envModSlotItem.txtDesc)
		end
	end

	local curModLevel = self.curPlaneMo:getEquipModLevel(TowerComposeEnum.ModType.Env)

	self._txtEnvModLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_modLevel"), curModLevel)
end

function TowerComposeModEquipView:refreshEnvModList(slotId)
	local modConfigList = TowerComposeModel.instance:getAllUnlockTypeModCoList(self.curThemeId, TowerComposeEnum.ModType.Env, slotId)

	modConfigList = self:modListSort(modConfigList, TowerComposeEnum.ModType.Env, self.curSelectPlaneId)

	for index, modConfig in ipairs(modConfigList) do
		local envModItem = self.envModItemList[index]

		if not envModItem then
			envModItem = {
				go = gohelper.clone(self._goenvModItem, self._goenvContent, "modItem" .. modConfig.id)
			}
			envModItem.goSelect1 = gohelper.findChild(envModItem.go, "go_select1")
			envModItem.goSelect2 = gohelper.findChild(envModItem.go, "go_select2")
			envModItem.simagePic = gohelper.findChildSingleImage(envModItem.go, "simage_pic")
			envModItem.imageIcon = gohelper.findChildImage(envModItem.go, "image_icon")
			envModItem.txtDesc = gohelper.findChildText(envModItem.go, "txt_desc")

			SkillHelper.addHyperLinkClick(envModItem.txtDesc, self._onHyperLinkClick, self)

			envModItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(envModItem.txtDesc.gameObject, FixTmpBreakLine)
			envModItem.txtName = gohelper.findChildText(envModItem.go, "txt_name")
			envModItem.txtLv = gohelper.findChildText(envModItem.go, "txt_name/txt_lv")
			envModItem.goIsIn1 = gohelper.findChild(envModItem.go, "isIn/go_isIn1")
			envModItem.goIsIn2 = gohelper.findChild(envModItem.go, "isIn/go_isIn2")
			envModItem.goLine = gohelper.findChild(envModItem.go, "line")
			envModItem.btnClick = gohelper.findChildButtonWithAudio(envModItem.go, "btn_click")
			self.envModItemList[index] = envModItem
		end

		envModItem.config = modConfig

		envModItem.btnClick:AddClickListener(self._btnEnvModItemOnClick, self, envModItem)
		gohelper.setActive(envModItem.go, true)

		envModItem.inPlaneId, envModItem.modInfo, envModItem.initEnvModInfoMap = TowerComposeModel.instance:checkModIsInPlane(envModItem.config.id, TowerComposeEnum.ModType.Env)

		gohelper.setActive(envModItem.goIsIn1, (envModItem.inPlaneId <= 0 or envModItem.inPlaneId ~= 1) and (envModItem.inPlaneId == 0 and envModItem.initEnvModInfoMap and envModItem.initEnvModInfoMap[1] or false) or true)
		gohelper.setActive(envModItem.goIsIn2, (envModItem.inPlaneId <= 0 or envModItem.inPlaneId ~= 2) and (envModItem.inPlaneId == 0 and envModItem.initEnvModInfoMap and envModItem.initEnvModInfoMap[2] or false) or true)

		if envModItem.inPlaneId <= 0 or envModItem.inPlaneId ~= 1 or self.curSelectPlaneId ~= 1 then
			local var_41_2

			if envModItem.inPlaneId == 0 then
				var_41_2 = envModItem.initEnvModInfoMap and envModItem.initEnvModInfoMap[1] and not (self.curPlaneMo.planeId ~= 1 or self.curSelectPlaneId ~= 1)
			end
		end

		gohelper.setActive(envModItem.goSelect1, var_41_2)

		if envModItem.inPlaneId <= 0 or envModItem.inPlaneId ~= 2 or self.curSelectPlaneId ~= 2 then
			local var_41_3

			if envModItem.inPlaneId == 0 then
				var_41_3 = envModItem.initEnvModInfoMap and envModItem.initEnvModInfoMap[2] and not (self.curPlaneMo.planeId ~= 2 or self.curSelectPlaneId ~= 2)
			end
		end

		gohelper.setActive(envModItem.goSelect2, var_41_3)
		gohelper.setActive(envModItem.goLine, index < #modConfigList)
		UISpriteSetMgr.instance:setTower2Sprite(envModItem.imageIcon, envModItem.config.icon)
		envModItem.simagePic:LoadImage(envModItem.config.image)
		envModItem.descFixTmpBreakLine:refreshTmpContent(envModItem.txtDesc)

		envModItem.txtDesc.text = SkillHelper.buildDesc(envModItem.config.desc)
		envModItem.txtName.text = envModItem.config.name
		envModItem.txtLv.text = string.format("Lv.%d", envModItem.config.level)
	end

	for index = #modConfigList + 1, #self.envModItemList do
		gohelper.setActive(self.envModItemList[index].go, false)
	end
end

function TowerComposeModEquipView:refreshSlotSelectState()
	for _, bodyModSlotItem in ipairs(self.bodyModSlotItemList) do
		gohelper.setActive(bodyModSlotItem.goSelectFrame1, self.curSelectPlaneId == 1 and self.curSelectSlotId == bodyModSlotItem.slotId and self.curSelectModType == TowerComposeEnum.ModType.Body)
		gohelper.setActive(bodyModSlotItem.goSelectFrame2, self.curSelectPlaneId == 2 and self.curSelectSlotId == bodyModSlotItem.slotId and self.curSelectModType == TowerComposeEnum.ModType.Body)
	end

	for _, wordModSlotItem in ipairs(self.wordModSlotItemList) do
		gohelper.setActive(wordModSlotItem.goSelectFrame1, self.curSelectPlaneId == 1 and self.curSelectSlotId == wordModSlotItem.slotId and self.curSelectModType == TowerComposeEnum.ModType.Word)
		gohelper.setActive(wordModSlotItem.goSelectFrame2, self.curSelectPlaneId == 2 and self.curSelectSlotId == wordModSlotItem.slotId and self.curSelectModType == TowerComposeEnum.ModType.Word)
	end
end

function TowerComposeModEquipView:modListSort(modList, modType, curSelectPlaneId)
	local curModCoList = tabletool.copy(modList)

	table.sort(curModCoList, function(configA, configB)
		local inPlaneIdA = TowerComposeModel.instance:checkModIsInPlane(configA.id, modType)
		local inPlaneIdB = TowerComposeModel.instance:checkModIsInPlane(configB.id, modType)
		local valueA = (inPlaneIdA == curSelectPlaneId or inPlaneIdA == 0) and 1 or 2
		local valueB = (inPlaneIdB == curSelectPlaneId or inPlaneIdB == 0) and 1 or 2

		if valueA ~= valueB then
			return valueA < valueB
		else
			if configA.level ~= configB.level then
				return configA.level < configB.level
			end

			return configA.id < configB.id
		end
	end)

	return curModCoList
end

function TowerComposeModEquipView:getCurWordModSlotId()
	for _, wordModSlotItem in pairs(self.wordModSlotItemList) do
		if wordModSlotItem.modId == 0 then
			return wordModSlotItem.slotId
		end
	end

	return 0
end

function TowerComposeModEquipView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function TowerComposeModEquipView:refreshLoadState()
	local bossRecordInfoData = self.themeMo:getBossRecordInfoData()
	local curBossMo = self.themeMo:getCurBossMo()

	gohelper.setActive(self._btnload.gameObject, bossRecordInfoData and not curBossMo.lock)
	gohelper.setActive(self._btnexitLoad.gameObject, bossRecordInfoData and curBossMo.lock)
	gohelper.setActive(self._gobossLock, bossRecordInfoData and curBossMo.lock)

	for planeId, planeItem in pairs(self.planeItemList) do
		planeItem.isLock = TowerComposeModel.instance:checkPlaneLock(self.curThemeId, planeId)

		gohelper.setActive(planeItem.lockGO, planeItem.isLock)
	end
end

function TowerComposeModEquipView:onClickLoadBtnReply()
	local bossRecordInfoData = self.themeMo:getBossRecordInfoData()

	if bossRecordInfoData then
		local param = {}

		param.operateType = TowerComposeEnum.TeamOperateType.Load
		param.themeId = self.curThemeId

		TowerComposeController.instance:openTowerComposeSaveView(param)
	else
		GameFacade.showToast(ToastEnum.TowerComposeRecordExpired)
	end

	self:refreshLoadState()
end

function TowerComposeModEquipView:checkPlaneIsLock()
	self.curSelectPlaneId = TowerComposeModel.instance:getCurSelectPlaneId()

	return TowerComposeModel.instance:checkPlaneLock(self.curThemeId, self.curSelectPlaneId)
end

function TowerComposeModEquipView:checkModOverLockLevel(planeId, modType, slot, modId)
	local curBossMo = self.themeMo:getCurBossMo()

	if not curBossMo or not curBossMo.lock or modId == 0 then
		return false
	end

	local lockBossLevel = self.themeMo:getCurBossLevel()
	local planeMo = self.themeMo:getPlaneMo(planeId)
	local tempLevel = planeMo:getPlaneLevelByEquipMod(modType, slot, modId)

	return lockBossLevel < tempLevel
end

function TowerComposeModEquipView:openTowerComposeModTipView(planeId, modType)
	local param = {}

	param.themeId = self.curThemeId
	param.planeId = planeId
	param.modType = modType
	param.offsetPos = {
		-550,
		0
	}

	TowerComposeController.instance:openTowerComposeModTipView(param)
end

function TowerComposeModEquipView:onClose()
	if self.curSelectModType ~= TowerComposeEnum.ModType.None then
		self:_btncloseModListOnClick()
	end

	TaskDispatcher.cancelTask(self.refreshPlaneInfo, self)
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

function TowerComposeModEquipView:onDestroyView()
	for _, bodyModSlotItem in pairs(self.bodyModSlotItemList) do
		bodyModSlotItem.btnClick:RemoveClickListener()
	end

	for _, bodyModItem in pairs(self.bodyModItemList) do
		bodyModItem.btnClick:RemoveClickListener()
	end

	for _, wordModSlotItem in pairs(self.wordModSlotItemList) do
		wordModSlotItem.btnClick:RemoveClickListener()
	end

	for _, wordModItem in pairs(self.wordModItemList) do
		wordModItem.btnClick:RemoveClickListener()
	end

	for _, envModSlotItem in pairs(self.envModSlotItemList) do
		envModSlotItem.btnClick:RemoveClickListener()
		envModSlotItem.simagePic:UnLoadImage()
	end

	for _, envModItem in pairs(self.envModItemList) do
		envModItem.btnClick:RemoveClickListener()
		envModItem.simagePic:UnLoadImage()
	end
end

return TowerComposeModEquipView
