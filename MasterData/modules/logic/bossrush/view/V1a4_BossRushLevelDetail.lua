-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushLevelDetail.lua

module("modules.logic.bossrush.view.V1a4_BossRushLevelDetail", package.seeall)

local V1a4_BossRushLevelDetail = class("V1a4_BossRushLevelDetail", BaseView)

function V1a4_BossRushLevelDetail:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._gospines = gohelper.findChild(self.viewGO, "#go_spines")
	self._goLeftBGEndless = gohelper.findChild(self.viewGO, "#go_LeftBGEndless")
	self._goLeftBG = gohelper.findChild(self.viewGO, "#go_LeftBG")
	self._goRightBGEndless = gohelper.findChild(self.viewGO, "#go_RightBGEndless")
	self._goRightBGLayer4 = gohelper.findChild(self.viewGO, "#go_RightBGLayer4")
	self._goRightBG = gohelper.findChild(self.viewGO, "#go_RightBG")
	self._btnSimple = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Simple", AudioEnum.ui_activity.play_ui_activity_switch)
	self._btnHard = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Hard", AudioEnum.ui_activity.play_ui_activity_switch)
	self._btnEndless = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Endless", AudioEnum.ui_activity.play_ui_activity_switch)
	self._btnLayer4 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Layer4", AudioEnum.ui_activity.play_ui_activity_switch)
	self._btnbonus = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_bonus", AudioEnum.ui_task.play_ui_task_page)
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/#btn_bonus/#go_AssessIcon")
	self._goRedPoint1 = gohelper.findChild(self.viewGO, "Left/#btn_bonus/#go_RedPoint1")
	self._txtTitle = gohelper.findChildText(self.viewGO, "DetailPanel/Title/#txt_Title")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "DetailPanel/Title/#txt_Title/#simage_Title")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "DetailPanel/Title/#txt_Title/#image_IssxIcon")
	self._btnSearchIcon = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/Title/#txt_Title/#btn_SearchIcon")
	self._scrollDescr = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/#scroll_desc")
	self._txtDescr = gohelper.findChildText(self.viewGO, "DetailPanel/#scroll_desc/Viewport/#txt_Descr")
	self._txtScoreTotalNum = gohelper.findChildText(self.viewGO, "DetailPanel/Attention/Score/#txt_ScoreTotalNum")
	self._txtLvNum = gohelper.findChildText(self.viewGO, "DetailPanel/Attention/Lv/#txt_LvNum")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#btn_Go", AudioEnum.ui_action.play_ui_action_mainstart)
	self._txtDoubleTimes = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	self._gonormalbtn = gohelper.findChildImage(self.viewGO, "DetailPanel/#btn_Go/#img_normal")
	self._txtGoCn = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#img_normal/txt_Go")
	self._txtGoEn = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#img_normal/txt_GoEn")
	self._btnoffer = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#btn_Offer")
	self._vxreceive1 = gohelper.findChild(self.viewGO, "Left/vx_receive")
	self._imageSliderFG2 = gohelper.findChildImage(self.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG/vx_receive_eff")
	self._gomask = gohelper.findChild(self.viewGO, "mask")
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRushLevelDetail:addEvents()
	self._btnSimple:AddClickListener(self._btnSimpleOnClick, self)
	self._btnHard:AddClickListener(self._btnHardOnClick, self)
	self._btnEndless:AddClickListener(self._btnEndlessOnClick, self)
	self._btnLayer4:AddClickListener(self._btnLayer4OnClick, self)
	self._btnbonus:AddClickListener(self._btnbonusOnClick, self)
	self._btnSearchIcon:AddClickListener(self._btnSearchIconOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	self._btnoffer:AddClickListener(self._btnOfferOnClick, self)
	self._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, self._onBtnGoEnter, self)
end

function V1a4_BossRushLevelDetail:removeEvents()
	self._btnSimple:RemoveClickListener()
	self._btnHard:RemoveClickListener()
	self._btnEndless:RemoveClickListener()
	self._btnLayer4:RemoveClickListener()
	self._btnbonus:RemoveClickListener()
	self._btnSearchIcon:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnoffer:RemoveClickListener()
	self._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, self._onBtnGoEnter, self)
end

function V1a4_BossRushLevelDetail:_btnbonusOnClick()
	BossRushController.instance:openBonusView(self.viewParam)
end

function V1a4_BossRushLevelDetail:_btnOfferOnClick()
	BossRushController.instance:openBossRushOfferRoleView()
end

local TabEnum = {
	Layer4 = 4,
	Simple = 1,
	Endless = 3,
	Hard = 2
}
local EAnimEvt = BossRushEnum.AnimEvtLevelDetail
local EDotNode = RedDotEnum.DotNode
local EAnimBtn = BossRushEnum.AnimLevelDetailBtn

function V1a4_BossRushLevelDetail:_btnSearchIconOnClick()
	local stage, layer = self:_getStageAndLayer()
	local actId = BossRushConfig.instance:getActivityId()

	EnemyInfoController.instance:openBossRushEnemyInfoView(actId, stage, layer)
end

function V1a4_BossRushLevelDetail:_btnSimpleOnClick()
	self:_setSelect(TabEnum.Simple, true)
end

function V1a4_BossRushLevelDetail:_btnHardOnClick()
	self:_setSelect(TabEnum.Hard, true)
end

function V1a4_BossRushLevelDetail:_btnEndlessOnClick()
	self:_setSelect(TabEnum.Endless, true)
end

function V1a4_BossRushLevelDetail:_btnLayer4OnClick()
	self:_setSelect(TabEnum.Layer4, true)
end

function V1a4_BossRushLevelDetail:_btnScheduleOnClick()
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ScheduleView, self.viewParam)
end

function V1a4_BossRushLevelDetail:_btnScoreOnClick()
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ScoreTaskAchievement, self.viewParam)
end

function V1a4_BossRushLevelDetail:_btnGoOnClick()
	local stage, layer = self:_getStageAndLayer()

	BossRushController.instance:enterFightScene(stage, layer)
end

function V1a4_BossRushLevelDetail:_btnBonusOnClick()
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_BonusView, self.viewParam)
end

function V1a4_BossRushLevelDetail:_editableInitView()
	local itemClass = V1a4_BossRushLevelDetailItem

	self._tabList = {
		MonoHelper.addNoUpdateLuaComOnceToGo(self._btnSimple.gameObject, itemClass),
		MonoHelper.addNoUpdateLuaComOnceToGo(self._btnHard.gameObject, itemClass),
		MonoHelper.addNoUpdateLuaComOnceToGo(self._btnEndless.gameObject, itemClass),
		(MonoHelper.addNoUpdateLuaComOnceToGo(self._btnLayer4.gameObject, itemClass))
	}

	self:_initAssessIcon()

	self._animSelf = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self._animSelf.enabled = false
	self._txtDoubleTimes.text = ""
	self._txtTitle.text = ""
	self._txtLvNum.text = ""

	self._animEvent:AddEventListener(EAnimEvt.onPlayCloseTransitionFinish, self._onPlayCloseTransitionFinish, self)
end

function V1a4_BossRushLevelDetail:_initAssessIcon()
	local itemClass = V1a4_BossRush_AssessIcon
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon, self._goAssessIcon, itemClass.__cname)

	self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._assessIcon:initData(self, false)
end

function V1a4_BossRushLevelDetail:onUpdateParam()
	return
end

function V1a4_BossRushLevelDetail:_tryLayer2TabIndex(layer)
	for i, v in ipairs(self._stageLayerInfos) do
		if v.layer == layer then
			local stage = self:_getStage()

			return BossRushModel.instance:isBossLayerOpen(stage, layer) and i or 1
		end
	end
end

function V1a4_BossRushLevelDetail:_getTabUnlockStates()
	local stage = self:_getStage()
	local res = {}

	for i, v in ipairs(self._stageLayerInfos) do
		local layer = v.layer

		res[i] = BossRushRedModel.instance:getIsNewUnlockStageLayer(stage, layer)
	end

	return res
end

function V1a4_BossRushLevelDetail:_tweenUnlockTabs()
	local stage = self:_getStage()
	local newUnlockStates = self:_getTabUnlockStates()

	self:_refreshTabs(newUnlockStates)

	for i, isNewUnlock in ipairs(newUnlockStates) do
		if isNewUnlock then
			local tabItem = self._tabList[i]
			local info = self._stageLayerInfos[i]
			local layer = info.layer

			tabItem:playUnlock()
			BossRushRedModel.instance:setIsNewUnlockStageLayer(stage, layer, false)
		end
	end
end

function V1a4_BossRushLevelDetail:onOpen()
	self._selectedIndex = nil

	local viewParam = self.viewParam
	local stage = viewParam.stage
	local selectedIndex = viewParam.selectedIndex
	local pointsInfo = BossRushModel.instance:getStagePointInfo(stage)

	self._stageLayerInfos = BossRushModel.instance:getStageLayersInfo(stage)

	if not selectedIndex then
		selectedIndex = self:_tryLayer2TabIndex(BossRushModel.instance:getLastMarkSelectedLayer(stage))
		viewParam.selectedIndex = selectedIndex
	end

	self:_tweenUnlockTabs()
	self:_setSelect(self.viewParam.selectedIndex or TabEnum.Simple)
	self:_refreshMonster()
	self:_refreshRedDot()

	local progress = pointsInfo.cur / pointsInfo.max

	self._imageSliderFG.fillAmount = progress
	self._imageSliderFG2.fillAmount = progress
	self._animSelf.enabled = true

	if selectedIndex == TabEnum.Endless then
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail_bossrush)
		self._animSelf:Play(BossRushEnum.AnimLevelDetail.EndlessEnter)
	elseif selectedIndex == TabEnum.Hard then
		self._animSelf:Play(BossRushEnum.AnimLevelDetail.HardEnter)
	elseif selectedIndex == TabEnum.Simple then
		self._animSelf:Play(BossRushEnum.AnimLevelDetail.NormalEnter)
	elseif selectedIndex == TabEnum.Layer4 then
		self._animSelf:Play(BossRushEnum.AnimLevelDetail.Layer4)
	end

	self:_refreshGoBtn(selectedIndex)
	gohelper.setActive(self._gomask, false)
	self:_checkOfferBtn()
end

function V1a4_BossRushLevelDetail:onOpenFinish()
	return
end

function V1a4_BossRushLevelDetail:playCloseTransition()
	self._animSelf:Play(BossRushEnum.AnimLevelDetail.CloseView)
	gohelper.setActive(self._gomask, true)
end

function V1a4_BossRushLevelDetail:_onPlayCloseTransitionFinish()
	self.viewContainer:onPlayCloseTransitionFinish()
end

function V1a4_BossRushLevelDetail:onClose()
	local viewParam = self.viewParam

	if viewParam then
		viewParam.selectedIndex = nil
	end
end

function V1a4_BossRushLevelDetail:onDestroyView()
	self._animEvent:RemoveEventListener(EAnimEvt.onPlayCloseTransitionFinish)
	self._simagefull:UnLoadImage()
	GameUtil.onDestroyViewMemberList(self, "_tabList")
	GameUtil.onDestroyViewMemberList(self, "_uiSpineList")
end

function V1a4_BossRushLevelDetail:_refreshContent()
	local viewParam = self.viewParam
	local stage = viewParam.stage
	local index = self._selectedIndex
	local stageLayerInfo = self._stageLayerInfos[index]
	local layerCO = stageLayerInfo.layerCO
	local layer = layerCO.layer
	local battleMaxPoints = BossRushConfig.instance:getBattleMaxPoints(stage, layer)
	local issxIconName = BossRushConfig.instance:getIssxIconName(stage, layer)
	local highestPoint = BossRushModel.instance:getHighestPoint(stage)
	local isInfinite = BossRushConfig.instance:isInfinite(stage, layer)
	local battleId = BossRushConfig.instance:getDungeonBattleId(stage, layer)

	UISpriteSetMgr.instance:setCommonSprite(self._imageIssxIcon, issxIconName)
	self._simagefull:LoadImage(BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(stage))

	local special = BossRushModel.instance:getLayer4HightScore(stage) == highestPoint

	if special then
		if not BossRushEnum.AssessType.Layer4 then
			local type = BossRushEnum.AssessType.Normal

			self._assessIcon:setData(stage, highestPoint, type)

			local spriteName = BossRushConfig.instance:getAssessSpriteName(stage, highestPoint, type)
			local isEmpty = string.nilorempty(spriteName)

			gohelper.setActive(self._vxreceive1, not isEmpty)

			self._txtTitle.text = ""

			if self._scrollDescr then
				self._scrollDescr.verticalNormalizedPosition = 1
			end

			self._txtDescr.text = layerCO.desc

			ZProj.UGUIHelper.RebuildLayout(self._txtDescr.transform)

			self._txtLvNum.text = layerCO.recommendLevelDesc

			self._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(stage))

			self._txtScoreTotalNum.text = battleMaxPoints == 0 and luaLang("v1a4_bossrushleveldetail_txt_scoretotalnum") or battleMaxPoints

			if isInfinite then
				local info = BossRushModel.instance:getDoubleTimesInfo(stage)
				local tag = {
					info.cur,
					info.max
				}

				self._txtDoubleTimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrushleveldetail_txt_doubletimes"), tag)
			else
				self._txtDoubleTimes.text = ""
			end

			local isSpecialLayer = BossRushModel.instance:isSpecialLayer(layer)

			gohelper.setActive(self._goLeftBGEndless, not isSpecialLayer and isInfinite)
			gohelper.setActive(self._goLeftBG, not isSpecialLayer and not isInfinite)
			gohelper.setActive(self._goRightBGEndless, not isSpecialLayer and isInfinite)
			gohelper.setActive(self._goRightBG, not isSpecialLayer and not isInfinite)
			gohelper.setActive(self._goRightBGLayer4, isSpecialLayer)
			self:_doUpdateSelectIcon(battleId)
		end
	end
end

function V1a4_BossRushLevelDetail:_refreshTabs(newUnlockStates)
	for i, v in ipairs(self._tabList) do
		v:setSelect(false)

		local stageLayerInfo = self._stageLayerInfos[i]

		if stageLayerInfo then
			v:setData(i, stageLayerInfo)

			if newUnlockStates then
				local isNewUnlock = newUnlockStates[i]

				if isNewUnlock then
					v:setIsLocked(true)
				end
			end
		else
			gohelper.setActive(v.go, false)
		end
	end
end

function V1a4_BossRushLevelDetail:_setSelect(index, isPlayAnim)
	if self._selectedIndex == index then
		return
	end

	local lastIndex = self._selectedIndex

	if not self:_isOpen(index) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)

		return
	end

	if isPlayAnim then
		if index == TabEnum.Endless then
			AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail_bossrush)
			self._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToEndless)
		elseif index == TabEnum.Hard then
			self._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToHard)
		elseif index == TabEnum.Simple then
			self._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToNormal)
		elseif index == TabEnum.Layer4 then
			self._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToLayer4)
		end
	end

	if lastIndex then
		local lastTab = self._tabList[lastIndex]

		lastTab:setSelect(false)
		lastTab:playIdle()
	end

	local curTab = self._tabList[index]

	curTab:setSelect(true)

	self._selectedIndex = index

	if isPlayAnim then
		curTab:plaAnim(EAnimBtn.Select, 0, 0)
	else
		self:_checkOfferBtn()
	end

	self:_refreshContent()

	local stage, layer = self:_getStageAndLayer()

	BossRushModel.instance:setLastMarkSelectedLayer(stage, layer)
end

function V1a4_BossRushLevelDetail:_refreshMonster()
	local stage = self:_getStage()
	local skinIdList = BossRushConfig.instance:getMonsterSkinIdList(stage)
	local skinScaleList = BossRushConfig.instance:getMonsterSkinScaleList(stage)
	local skinOffsetXYs = BossRushConfig.instance:getMonsterSkinOffsetXYs(stage)

	self:_initMonsterSpines(#skinIdList)

	for i, item in ipairs(self._uiSpineList) do
		local skinId = skinIdList[i]
		local scale = skinScaleList[i]
		local offsetXY = skinOffsetXYs[i]

		item:setData(skinId)
		item:setScale(scale)
		item:setOffsetXY(offsetXY[1], offsetXY[2])
	end
end

function V1a4_BossRushLevelDetail:_initMonsterSpines(skinCount)
	local itemClass = V1a4_BossRushLevelDetail_Spine

	if not self._uiSpineList or skinCount > #self._uiSpineList then
		self._uiSpineList = self._uiSpineList or {}

		local st = #self._uiSpineList + 1

		for i = st, skinCount do
			local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine, self._gospines, itemClass.__name)

			self._uiSpineList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
		end
	end
end

function V1a4_BossRushLevelDetail:_refreshRedDot()
	local stage = self:_getStage()
	local defineId, uid

	RedDotController.instance:addRedDot(self._goRedPoint1, EDotNode.BossRushBossReward, (BossRushRedModel.instance:getUId(EDotNode.BossRushBossReward, stage)))
end

function V1a4_BossRushLevelDetail:_getStage()
	return self.viewParam.stage
end

function V1a4_BossRushLevelDetail:_getLayer()
	local index = self._selectedIndex
	local stageLayerInfo = self._stageLayerInfos[index or 1]
	local layerCO = stageLayerInfo.layerCO

	return layerCO.layer
end

function V1a4_BossRushLevelDetail:_getStageAndLayer()
	return self:_getStage(), self:_getLayer()
end

function V1a4_BossRushLevelDetail:_isOpen(eTabEnum)
	local stageLayerInfo = self._stageLayerInfos[eTabEnum]

	return stageLayerInfo.isOpen
end

function V1a4_BossRushLevelDetail:_doUpdateSelectIcon(battleId)
	local ruleView = self.viewContainer:getBossRushViewRule()

	ruleView:refreshUI(battleId)
end

function V1a4_BossRushLevelDetail:_refreshGoBtn(layer)
	local res = BossRushEnum.LayerRes.EnterLevelBtn

	if not res[layer] then
		UISpriteSetMgr.instance:setV1a4BossRushSprite(self._gonormalbtn, res[layer])

		local color = BossRushEnum.LayerRes.EnterLevelBtnTxtColor

		if not color[layer] then
			local colorHex = color[1]
			local txtColor = GameUtil.parseColor(colorHex)

			self._txtGoCn.color = txtColor
			self._txtGoEn.color = Color(txtColor.r, txtColor.g, txtColor.b, 0.5)
		end
	end
end

function V1a4_BossRushLevelDetail:_onBtnGoEnter()
	self:_refreshGoBtn(self._selectedIndex)
	self:_checkOfferBtn()
end

function V1a4_BossRushLevelDetail:_checkOfferBtn()
	local stage, layer = self:_getStageAndLayer()
	local isEnhanceRole = BossRushModel.instance:isEnhanceRole(stage, layer)

	gohelper.setActive(self._btnoffer.gameObject, isEnhanceRole)
end

return V1a4_BossRushLevelDetail
