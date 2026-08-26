-- chunkname: @modules/logic/tower/view/permanenttower/TowerPermanentView.lua

module("modules.logic.tower.view.permanenttower.TowerPermanentView", package.seeall)

local TowerPermanentView = class("TowerPermanentView", BaseView)

function TowerPermanentView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_category")
	self._goViewport = gohelper.findChild(self.viewGO, "Left/#scroll_category/Viewport")
	self._goContent = gohelper.findChild(self.viewGO, "Left/#scroll_category/Viewport/#go_Content")
	self._goStageInfo = gohelper.findChild(self.viewGO, "Left/#go_stageInfo")
	self._txtCurStage = gohelper.findChildText(self.viewGO, "Left/#go_stageInfo/#txt_curStage")
	self._btnCurStageFold = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_stageInfo/#btn_curStageFold")
	self._gonormalEpisode = gohelper.findChild(self.viewGO, "episode/#go_normalEpisode")
	self._gonormalItem = gohelper.findChild(self.viewGO, "episode/#go_normalEpisode/#go_normalItem")
	self._goeliteEpisode = gohelper.findChild(self.viewGO, "episode/#go_eliteEpisode")
	self._gocompleted = gohelper.findChild(self.viewGO, "episode/layout/#go_completed")
	self._animCompleted = self._gocompleted:GetComponent(gohelper.Type_Animator)
	self._goschedule = gohelper.findChild(self.viewGO, "episode/layout/#go_schedule")
	self._txtschedule = gohelper.findChildText(self.viewGO, "episode/layout/#go_schedule/bg/#txt_Schedule")
	self._goreward = gohelper.findChild(self.viewGO, "#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#go_reward/#go_rewardItem")
	self._simageEnterBg = gohelper.findChildSingleImage(self.viewGO, "#go_Enter/#simage_EnterBG")
	self._txtEnterTitle = gohelper.findChildText(self.viewGO, "#go_Enter/Title/txt_Title")
	self._txtEnterTitleEn = gohelper.findChildText(self.viewGO, "#go_Enter/Title/txt_TitleEn")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/txt_TitleEn")
	self._viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._godeep = gohelper.findChild(self.viewGO, "#go_deep")
	self._goepisode = gohelper.findChild(self.viewGO, "episode")
	self._gotitle = gohelper.findChild(self.viewGO, "Title")
	self._gorewardBg = gohelper.findChild(self.viewGO, "image_RewardBG")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goenterDeepGuide = gohelper.findChild(self.viewGO, "#go_EnterDeepGuide")
	self.enterDeepGuideAnim = self._goenterDeepGuide:GetComponent(gohelper.Type_Animator)
	self._godeepLayer = gohelper.findChild(self.viewGO, "Left/#go_deepLayer")
	self._godeepNormal = gohelper.findChild(self.viewGO, "Left/#go_deepLayer/#go_deepNormal")
	self._godeepSelect = gohelper.findChild(self.viewGO, "Left/#go_deepLayer/#go_deepSelect")
	self._btndeepLayer = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_deepLayer/#btn_deepLayer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerPermanentView:addEvents()
	self._scrollcategory:AddOnValueChanged(self._onScrollChange, self)
	self._btnCurStageFold:AddClickListener(self._btnCurStageFoldOnClick, self)
	self._btndeepLayer:AddClickListener(self._btndeepLayerOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.SelectPermanentAltitude, self.selectPermanentAltitude, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnSelectDeepLayer, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshEpisode, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.onDailyRefresh, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnCloseEnterDeepGuideView, self.enterDeepGuideFinish, self)
end

function TowerPermanentView:removeEvents()
	self._scrollcategory:RemoveOnValueChanged()
	self._btnCurStageFold:RemoveClickListener()
	self._btndeepLayer:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.SelectPermanentAltitude, self.selectPermanentAltitude, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnSelectDeepLayer, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshEpisode, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.onDailyRefresh, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnCloseEnterDeepGuideView, self.enterDeepGuideFinish, self)
end

TowerPermanentView.maxStageCount = 6
TowerPermanentView.showNextStageTitleTime = 0.4
TowerPermanentView.selectNextStageTime = 0.7
TowerPermanentView.selectNextLayerTime = 1
TowerPermanentView.animBlockName = "TowerPermanentViewAnimBlock"

function TowerPermanentView:_btnEliteEpisodeItemClick(episodeIndex, isAuto)
	if self.curSelectEpisodeIndex == episodeIndex then
		return
	end

	local selectEpisodeId = self.episodeIdList[episodeIndex]
	local eliteEpisodeList = self.eliteItemTab[self.layerConfig.layerId]

	self.curSelectEpisodeIndex = episodeIndex

	for index, episodeItem in pairs(eliteEpisodeList) do
		episodeItem.isSelect = index == episodeIndex

		gohelper.setActive(episodeItem.goSelect, episodeItem.isSelect)
		gohelper.setActive(episodeItem.imageSelectFinishIcon.gameObject, episodeItem.isFinish)
		gohelper.setActive(episodeItem.goFinish, episodeItem.isFinish and not episodeItem.isSelect)
	end

	TowerPermanentModel.instance:setCurSelectEpisodeId(selectEpisodeId)

	if not isAuto then
		self._viewAnim:Play("switchright", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple)
	else
		TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentEpisode)
	end
end

function TowerPermanentView:_btnNormalEpisodeItemClick(episodeId)
	self.normalEpisodeItem.isSelect = true

	gohelper.setActive(self.normalEpisodeItem.goSelect, self.normalEpisodeItem.isSelect)
	TowerPermanentModel.instance:setCurSelectEpisodeId(episodeId)
	TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentEpisode)
end

function TowerPermanentView:_btnCurStageFoldOnClick()
	self.scrollCategoryRect.velocity = Vector2(0, 0)

	local curStage = TowerPermanentModel.instance:getCurSelectStage()

	TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, curStage)
end

function TowerPermanentView:_btndeepLayerOnClick()
	local isSelectDeepCategory = TowerPermanentDeepModel.instance:getIsSelectDeepCategory()

	if isSelectDeepCategory then
		return
	end

	local isInDeepLayer = TowerPermanentDeepModel.instance:getIsInDeepLayerState()

	if not isInDeepLayer then
		self._viewAnim:Play("openenterdeep", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mingdi_boss_enter)
	end

	TowerPermanentDeepModel.instance:setInDeepLayerState(true)
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(true)
	TowerController.instance:dispatchEvent(TowerEvent.OnSelectDeepLayer)

	local curStage = TowerPermanentModel.instance:getCurUnfoldStage()
	local maxStage, maxLayerIndex = TowerPermanentModel.instance:getNewtStageAndLayer()

	if curStage == maxStage then
		self._scrollcategory.verticalNormalizedPosition = 0
	else
		self._scrollcategory.verticalNormalizedPosition = 1

		TowerPermanentModel.instance:onModelUpdate()
		TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, curStage)
	end
end

function TowerPermanentView:onDailyRefresh()
	if TowerPermanentModel.instance:isNewStage() then
		self._scrollcategory.verticalNormalizedPosition = 1

		TowerPermanentModel.instance:onModelUpdate()

		local curStage = TowerPermanentModel.instance:getCurUnfoldStage()

		TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, curStage)
	end

	self.scrollCategoryRect.velocity = Vector2(0, 0)

	self:refreshUI()
end

function TowerPermanentView:_editableInitView()
	self._rectContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
	self._viewportMask2D = self._goViewport:GetComponent(gohelper.Type_RectMask2D)
	self.scrollCategoryRect = self._scrollcategory:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switch", self.refreshUI, self)

	self._bgAnim = gohelper.findChild(self.viewGO, "Bg"):GetComponent(gohelper.Type_Animator)
	self.deepLayerAnim = gohelper.findChildComponent(self.viewGO, "Left/#go_deepLayer/#go_deepNormal", gohelper.Type_Animation)
	self.eliteItemTab = self:getUserDataTb_()
	self.eliteItemPosTab = self:getUserDataTb_()
	self.rewardTab = self:getUserDataTb_()
	self.eliteBgAnimTab = self:getUserDataTb_()

	gohelper.setActive(self._goeliteItem, false)
	gohelper.setActive(self._gorewardItem, false)

	self.tempDeepGuideFinish = false

	for i = 1, TowerPermanentView.maxStageCount do
		local eliteAnimItem = {}

		eliteAnimItem.go = gohelper.findChild(self.viewGO, "Bg/" .. i .. "/#go_Elitebg")
		self.eliteBgAnimTab[i] = eliteAnimItem

		gohelper.setActive(eliteAnimItem.go, false)
	end

	for i = 2, TowerPermanentView.maxStageCount do
		local eliteItemPos = {}

		eliteItemPos.go = gohelper.findChild(self.viewGO, "episode/#go_eliteEpisode/#go_elite" .. i)
		eliteItemPos.posTab = {}

		for j = 1, i do
			eliteItemPos.posTab[j] = gohelper.findChild(eliteItemPos.go, "go_pos" .. j)
		end

		self.eliteItemPosTab[i] = eliteItemPos
	end

	self:initNormalEpisodeItem()
	TowerPermanentModel.instance:setCurSelectEpisodeId(0)

	self.deepGuideId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.FirstEnterDeepGuideId)
end

function TowerPermanentView:initNormalEpisodeItem()
	self.normalEpisodeItem = self:getUserDataTb_()
	self.normalEpisodeItem.go = self._gonormalItem
	self.normalEpisodeItem.imageIcon = gohelper.findChildImage(self.normalEpisodeItem.go, "image_icon")
	self.normalEpisodeItem.goSelect = gohelper.findChild(self.normalEpisodeItem.go, "go_select")
	self.normalEpisodeItem.imageSelectIcon = gohelper.findChildImage(self.normalEpisodeItem.go, "go_select/image_selectIcon")
	self.normalEpisodeItem.imageSelectFinishIcon = gohelper.findChildImage(self.normalEpisodeItem.go, "go_select/image_selectFinishIcon")
	self.normalEpisodeItem.goFinish = gohelper.findChild(self.normalEpisodeItem.go, "go_finish")
	self.normalEpisodeItem.imageFinishIcon = gohelper.findChildImage(self.normalEpisodeItem.go, "go_finish/image_finishIcon")
	self.normalEpisodeItem.txtName = gohelper.findChildText(self.normalEpisodeItem.go, "txt_name")
	self.normalEpisodeItem.btnClick = gohelper.findChildButtonWithAudio(self.normalEpisodeItem.go, "btn_click")
	self.normalEpisodeItem.goFinishEffect = gohelper.findChild(self.normalEpisodeItem.go, "go_finishEffect")
end

function TowerPermanentView:onUpdateParam()
	return
end

function TowerPermanentView:_onScrollChange(value)
	local curStage = TowerPermanentModel.instance:getCurSelectStage()
	local maxStage = TowerPermanentModel.instance:getStageCount()

	gohelper.setActive(self._btnCurStageFold.gameObject, curStage < maxStage)

	local curContentPosY = recthelper.getAnchorY(self._rectContent)
	local canShowStageInfo = curContentPosY > (curStage - 1) * TowerEnum.PermanentUI.StageTitleH

	gohelper.setActive(self._goStageInfo, canShowStageInfo)

	local timeTowerConfig = TowerConfig.instance:getTowerPermanentTimeCo(curStage)

	self._txtCurStage.text = timeTowerConfig.name

	if canShowStageInfo then
		if not TowerEnum.PermanentUI.StageTitleH then
			local maskTopPadding = 0

			self._viewportMask2D.padding = Vector4(0, 0, -150, maskTopPadding)
		end
	end
end

function TowerPermanentView:onOpen()
	self.jumpParam = self.viewParam or {}

	gohelper.setActive(self._goStageInfo, false)
	self:refreshUI()

	if self.canShowDeep then
		local realSelectStage, realSelectLayerIndex = TowerPermanentModel.instance:getRealSelectStage()

		self:scrollMoveToTargetLayer(realSelectStage, realSelectLayerIndex)
	else
		self:scrollMoveToTargetLayer()
	end

	if tabletool.len(self.jumpParam) > 0 then
		self._viewAnim:Play("opennormal", 0, 0)
	elseif self.isDeepLayerUnlock and not self.isEnterDeepGuideFinish then
		-- block empty
	else
		self._viewAnim:Play(self.canShowDeep and "openenterdeep" or "openenter", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)

		if self.canShowDeep then
			AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mingdi_boss_enter)
		end
	end

	local curPermanentMo = TowerModel.instance:getCurPermanentMo()
	local localPassLayer = TowerPermanentModel.instance:getLocalPassLayer()

	if not localPassLayer or localPassLayer == -1 then
		TowerPermanentModel.instance:setLocalPassLayer(curPermanentMo.passLayerId)
	end

	if self.jumpParam and self.jumpParam.episodeId and self.layerConfig and self.layerConfig.isElite == 1 then
		for index, episodeId in ipairs(self.episodeIdList) do
			if episodeId == self.jumpParam.episodeId then
				self:_btnEliteEpisodeItemClick(index, true)

				break
			end
		end

		local unfinishEpisodeMo = TowerPermanentModel.instance:getFirstUnFinishEipsode(self.jumpParam.layerId)

		if unfinishEpisodeMo then
			self.nextUnfinishEpisodeId = unfinishEpisodeMo.episodeId

			TaskDispatcher.runDelay(self.selectNextEpisode, self, 1)
			UIBlockMgr.instance:startBlock(TowerPermanentView.animBlockName)
			UIBlockMgrExtend.setNeedCircleMv(false)
		end
	end

	if self.jumpParam and self.jumpParam.episodeId and TowerPermanentModel.instance:isNewPassLayer() then
		UIBlockMgr.instance:startBlock(TowerPermanentView.animBlockName)
		UIBlockMgrExtend.setNeedCircleMv(false)
		gohelper.setActive(self._gocompleted, false)

		local isNewStage, maxStage, lastStage = TowerPermanentModel.instance:isNewStage()

		if lastStage == maxStage and lastStage > 1 then
			self._bgAnim:Play(lastStage - 1 .. "to" .. lastStage, 0, 1)
		end

		for index, rewardItem in pairs(self.rewardTab) do
			gohelper.setActive(rewardItem.goHasGet, false)
		end

		TaskDispatcher.runDelay(self.playFinishEffect, self, 1)
	end
end

function TowerPermanentView:playFinishEffect()
	gohelper.setActive(self._gocompleted, self.isAllFinish)
	gohelper.setActive(self._goschedule, self.layerConfig.isElite == 1 and not self.isAllFinish)
	self._animCompleted:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)

	for index, rewardItem in pairs(self.rewardTab) do
		gohelper.setActive(rewardItem.goHasGet, true)
		rewardItem.animHasGet:Play("go_hasget_in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_award)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentTowerFinishLayer, self.jumpParam.layerId)

	if self.isDeepLayerUnlock and not self.isEnterDeepGuideFinish then
		gohelper.setActive(self._godeepLayer, true)
		self.deepLayerAnim:Play()
		TaskDispatcher.runDelay(self.enterDeepGuide, self, 1)
	else
		local isNewStage, maxStage, lastStage = TowerPermanentModel.instance:isNewStage()

		self.isNewStageInfo = {
			isNewStage = isNewStage,
			maxStage = maxStage
		}

		if isNewStage then
			self._bgAnim:Play(lastStage .. "to" .. maxStage, 0, 0)

			local permanentEpisodeCo = TowerConfig.instance:getPermanentEpisodeCo(self.jumpParam.layerId)

			if permanentEpisodeCo.isElite == 1 then
				gohelper.setActive(self.eliteBgAnimTab[lastStage].go, true)
			end
		elseif lastStage == maxStage and lastStage > 1 then
			self._bgAnim:Play(lastStage - 1 .. "to" .. lastStage, 0, 1)
		end

		self:setNewStageAndLayer(isNewStage)

		local curPermanentMo = TowerModel.instance:getCurPermanentMo()

		TowerPermanentModel.instance:setLocalPassLayer(curPermanentMo.passLayerId)
	end
end

function TowerPermanentView:enterDeepGuide()
	self:doEnterDeepGuide(true)
end

function TowerPermanentView:setNewStageAndLayer(isNewStage)
	local maxStage, maxLayerIndex = TowerPermanentModel.instance:getNewtStageAndLayer()

	self.animPermanentEpisodeCo = TowerConfig.instance:getPermanentEpisodeLayerCo(maxStage, maxLayerIndex)

	if isNewStage then
		self:refreshEnterTitle(maxStage)
		TaskDispatcher.runDelay(self.showNextStageTitleAnim, self, TowerPermanentView.showNextStageTitleTime)
		TaskDispatcher.runDelay(self._btnCurStageFoldOnClick, self, TowerPermanentView.selectNextStageTime)
		TaskDispatcher.runDelay(self.permanentSelectNextLayer, self, TowerPermanentView.selectNextStageTime + TowerPermanentView.selectNextLayerTime)
	else
		TaskDispatcher.runDelay(self.permanentSelectNextLayer, self, TowerPermanentView.selectNextLayerTime)
	end
end

function TowerPermanentView:showNextStageTitleAnim()
	if self.isNewStageInfo and self.isNewStageInfo.isNewStage then
		self._viewAnim:Play("switchfloor", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	end
end

function TowerPermanentView:selectNextEpisode()
	if self.nextUnfinishEpisodeId > 0 then
		for index, episodeId in ipairs(self.episodeIdList) do
			if episodeId == self.nextUnfinishEpisodeId then
				self:_btnEliteEpisodeItemClick(index, false)

				break
			end
		end
	end

	UIBlockMgr.instance:endBlock(TowerPermanentView.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function TowerPermanentView:permanentSelectNextLayer()
	UIBlockMgr.instance:endBlock(TowerPermanentView.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentSelectNextLayer, self.animPermanentEpisodeCo)
end

function TowerPermanentView:selectPermanentAltitude()
	self.curSelectEpisodeIndex = 0

	if not self.isNewStageInfo or tabletool.len(self.isNewStageInfo) == 0 or not self.isNewStageInfo.isNewStage then
		self._viewAnim:Play(UIAnimationName.Switch, 0, 0)
	else
		self.isNewStageInfo = nil

		self:refreshUI()
	end
end

function TowerPermanentView:selectUnfinishEpisode()
	if self.layerConfig.isElite == 1 then
		local unfinishEpisodeMo = TowerPermanentModel.instance:getFirstUnFinishEipsode(self.layerConfig.layerId)

		if unfinishEpisodeMo then
			for index, episodeId in ipairs(self.episodeIdList) do
				if episodeId == unfinishEpisodeMo.episodeId then
					self:_btnEliteEpisodeItemClick(index, true)

					break
				end
			end
		end
	end
end

function TowerPermanentView:refreshUI()
	self:refreshDeepLayer()

	if not self.canShowDeep then
		self:refreshEpisode()
		self:refreshReward()
		self:selectUnfinishEpisode()
		self:refreshStageItemEffect()
		self:refreshEnterTitle()
		self:doEnterDeepGuide()
	end
end

function TowerPermanentView:refreshDeepLayer()
	self.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()
	self.isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish() or self.tempDeepGuideFinish
	self.isInDeepLayer = TowerPermanentDeepModel.instance:getIsInDeepLayerState()
	self.canShowDeep = self.isDeepLayerUnlock and self.isEnterDeepGuideFinish and self.isInDeepLayer

	gohelper.setActive(self._godeep, self.canShowDeep)
	gohelper.setActive(self._goepisode, not self.canShowDeep)
	gohelper.setActive(self._gotitle, not self.canShowDeep)
	gohelper.setActive(self._gorewardBg, not self.canShowDeep)
	gohelper.setActive(self._goreward, not self.canShowDeep)
	gohelper.setActive(self._goright, not self.canShowDeep)

	local isSelectDeepCategory = TowerPermanentDeepModel.instance:getIsSelectDeepCategory()

	gohelper.setActive(self._godeepSelect, isSelectDeepCategory)
	gohelper.setActive(self._godeepNormal, not isSelectDeepCategory)
end

function TowerPermanentView:doEnterDeepGuide(isForceGuide)
	self.isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish()

	if self.isDeepLayerUnlock and not self.isEnterDeepGuideFinish and (not self.jumpParam or not self.jumpParam.episodeId or isForceGuide) then
		self:_btndeepLayerOnClick()
		TaskDispatcher.runDelay(self.realEnterDeepGuide, self, 1.5)
	end
end

function TowerPermanentView:realEnterDeepGuide()
	gohelper.setActive(self._goenterDeepGuide, true)
	UIBlockMgr.instance:endBlock(TowerPermanentView.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.runDelay(self.sendOnEnterDeepGuide, self, 0.2)
end

function TowerPermanentView:sendOnEnterDeepGuide()
	TowerController.instance:dispatchEvent(TowerEvent.OnEnterDeepGuide)
end

function TowerPermanentView:enterDeepGuideFinish()
	self.enterDeepGuideAnim:Play("close", 0, 0)
	self.enterDeepGuideAnim:Update(0)
	TaskDispatcher.runDelay(self.hideEnterDeepGuide, self, 0.5)

	self.tempDeepGuideFinish = true

	self:refreshUI()
end

function TowerPermanentView:hideEnterDeepGuide()
	gohelper.setActive(self._goenterDeepGuide, false)
end

function TowerPermanentView:refreshStageItemEffect()
	for i = 1, TowerPermanentView.maxStageCount do
		gohelper.setActive(self.eliteBgAnimTab[i].go, i == self.curStage and self.layerConfig.isElite == 1)
	end
end

function TowerPermanentView:refreshEnterTitle(stage)
	local showStage = stage or self.curStage
	local timeTowerConfig = TowerConfig.instance:getTowerPermanentTimeCo(showStage)

	self._txtEnterTitle.text = timeTowerConfig.name
	self._txtEnterTitleEn.text = timeTowerConfig.nameEn

	self._simageEnterBg:LoadImage(ResUrl.getTowerIcon("permanent/towerpermanent_bg" .. Mathf.Min(showStage, TowerDeepEnum.MaxNormalBgStage)))
end

function TowerPermanentView:refreshEpisode()
	local realSelectStage, realSelectLayerIndex = TowerPermanentModel.instance:getRealSelectStage()

	self.curStage = TowerPermanentModel.instance:getCurSelectStage()
	self.curLayerIndex = TowerPermanentModel.instance:getCurSelectLayer()
	self.realSelectLayerIndex = realSelectLayerIndex
	self.realselectStage = realSelectStage
	self.layerConfig = TowerConfig.instance:getPermanentEpisodeLayerCo(self.realselectStage, self.realSelectLayerIndex)
	self.isAllFinish = self.layerConfig.layerId <= TowerPermanentModel.instance.curPassLayer
	self.episodeIdList = string.splitToNumber(self.layerConfig.episodeIds, "|")

	local episodeCount = #self.episodeIdList
	local isElite = self.layerConfig.isElite == 1

	gohelper.setActive(self._gonormalEpisode, not isElite)
	gohelper.setActive(self._goeliteEpisode, isElite)
	gohelper.setActive(self._goschedule, isElite and not self.isAllFinish)

	local timeTowerConfig = TowerConfig.instance:getTowerPermanentTimeCo(self.curStage)

	self._txtTitle.text = timeTowerConfig.name
	self._txtTitleEn.text = timeTowerConfig.nameEn

	if self.curStage > 1 then
		self._bgAnim:Play(self.curStage - 1 .. "to" .. self.curStage, 0, 1)
	else
		self._bgAnim:Play("1idle", 0, 1)
	end

	if isElite then
		local curPermanentMo = TowerModel.instance:getCurPermanentMo()
		local passCount = curPermanentMo:getSubEpisodePassCount(self.layerConfig.layerId)

		self._txtschedule.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerpermanentresultview_schedule"), passCount, #self.episodeIdList)

		for index, episodeId in ipairs(self.episodeIdList) do
			local episodeItem = self.viewContainer:getTowerPermanentPoolView():createOrGetEliteEpisodeItem(index, self._btnEliteEpisodeItemClick, self)

			self.eliteItemTab[self.layerConfig.layerId] = self.eliteItemTab[self.layerConfig.layerId] or {}
			self.eliteItemTab[self.layerConfig.layerId][index] = episodeItem

			gohelper.setActive(episodeItem.go, true)

			local parentGO = self.eliteItemPosTab[episodeCount].posTab[index]

			episodeItem.go.transform:SetParent(parentGO.transform, false)
			recthelper.setAnchor(episodeItem.go.transform, 0, 0)

			local subEpisodeMo = curPermanentMo:getSubEpisodeMoByEpisodeId(episodeId)

			episodeItem.isFinish = subEpisodeMo and subEpisodeMo.status == TowerEnum.PassEpisodeState.Pass

			gohelper.setActive(episodeItem.goFinish, episodeItem.isFinish)

			episodeItem.txtName.text = GameUtil.getRomanNums(index)

			gohelper.setActive(episodeItem.imageSelectIcon.gameObject, not episodeItem.isFinish)
			gohelper.setActive(episodeItem.imageSelectFinishIcon.gameObject, episodeItem.isFinish)
			gohelper.setActive(episodeItem.goFinishEffect, episodeItem.isFinish)
			UISpriteSetMgr.instance:setTowerPermanentSprite(episodeItem.imageIcon, self:getEliteEpisodeIconName(index, TowerEnum.PermanentEliteEpisodeState.Normal), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(episodeItem.imageSelectIcon, self:getEliteEpisodeIconName(index, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(episodeItem.imageSelectFinishIcon, self:getEliteEpisodeIconName(index, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(episodeItem.imageFinishIcon, self:getEliteEpisodeIconName(index, TowerEnum.PermanentEliteEpisodeState.Finish), true)
		end

		self.viewContainer:getTowerPermanentPoolView():recycleEliteEpisodeItem(self.episodeIdList)

		for i = 2, 5 do
			gohelper.setActive(self.eliteItemPosTab[i].go, i == episodeCount)
		end

		if self.curSelectEpisodeIndex and self.curSelectEpisodeIndex > 0 then
			self:_btnEliteEpisodeItemClick(self.curSelectEpisodeIndex, true)
		else
			self:_btnEliteEpisodeItemClick(1, true)
		end
	else
		UISpriteSetMgr.instance:setTowerPermanentSprite(self.normalEpisodeItem.imageIcon, self:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Normal), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(self.normalEpisodeItem.imageSelectIcon, self:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(self.normalEpisodeItem.imageSelectFinishIcon, self:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(self.normalEpisodeItem.imageFinishIcon, self:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Finish), true)

		self.normalEpisodeItem.txtName.text = "ST - " .. self.realSelectLayerIndex

		gohelper.setActive(self.normalEpisodeItem.goSelect, true)
		gohelper.setActive(self.normalEpisodeItem.imageSelectIcon.gameObject, not self.isAllFinish)
		gohelper.setActive(self.normalEpisodeItem.imageSelectFinishIcon.gameObject, self.isAllFinish)
		gohelper.setActive(self.normalEpisodeItem.goFinishEffect, self.isAllFinish)
		gohelper.setActive(self.normalEpisodeItem.goFinish, false)
		self.normalEpisodeItem.btnClick:AddClickListener(self._btnNormalEpisodeItemClick, self, self.episodeIdList[1])
		self:_btnNormalEpisodeItemClick(self.episodeIdList[1])
	end

	gohelper.setActive(self._gocompleted, self.isAllFinish)
end

function TowerPermanentView:getEliteEpisodeIconName(index, state)
	return string.format("towerpermanent_stage_%d_%d", index, state)
end

function TowerPermanentView:refreshReward()
	local rewardList = string.split(self.layerConfig.firstReward, "|")

	gohelper.CreateObjList(self, self.rewardItemShow, rewardList, self._goreward, self._gorewardItem)
end

function TowerPermanentView:rewardItemShow(obj, data, index)
	local rewardItem = self.rewardTab[index]

	if not rewardItem then
		rewardItem = {
			itemPos = gohelper.findChild(obj, "go_rewardPos"),
			goHasGet = gohelper.findChild(obj, "go_rewardGet")
		}
		rewardItem.animHasGet = gohelper.findChild(obj, "go_rewardGet/icon/go_hasget"):GetComponent(gohelper.Type_Animator)
		rewardItem.item = IconMgr.instance:getCommonPropItemIcon(rewardItem.itemPos)
		self.rewardTab[index] = rewardItem
	end

	local itemCo = string.splitToNumber(data, "#")

	rewardItem.item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	rewardItem.item:setHideLvAndBreakFlag(true)
	rewardItem.item:hideEquipLvAndBreak(true)
	rewardItem.item:setCountFontSize(51)
	gohelper.setActive(rewardItem.goHasGet, self.isAllFinish)
end

function TowerPermanentView:scrollMoveToTargetLayer(stage, layerIndex)
	local targetStage = stage or self.realselectStage
	local targetLayerIndex = layerIndex or self.realSelectLayerIndex
	local moveAnchorY = (targetStage - 1) * TowerEnum.PermanentUI.StageTitleH + (targetLayerIndex - 1) * (TowerEnum.PermanentUI.SingleItemH + TowerEnum.PermanentUI.ItemSpaceH)
	local contentH = TowerPermanentModel.instance:getCurContentTotalHeight()

	if self.isDeepLayerUnlock then
		local MaxMoveY = contentH - (TowerEnum.PermanentUI.DeepScrollH or TowerEnum.PermanentUI.ScrollH) + 1

		moveAnchorY = Mathf.Min(moveAnchorY, MaxMoveY)

		recthelper.setAnchorY(self._goContent.transform, moveAnchorY)
		self:_onScrollChange()
	end
end

function TowerPermanentView:onClose()
	if self.normalEpisodeItem.btnClick then
		self.normalEpisodeItem.btnClick:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self.showNextStageTitleAnim, self)
	TaskDispatcher.cancelTask(self._btnCurStageFoldOnClick, self)
	TaskDispatcher.cancelTask(self.permanentSelectNextLayer, self)
	TaskDispatcher.cancelTask(self.playFinishEffect, self)
	TaskDispatcher.cancelTask(self.selectNextEpisode, self)
	TaskDispatcher.cancelTask(self.sendOnEnterDeepGuide, self)
	TaskDispatcher.cancelTask(self.enterDeepGuide, self)
	TaskDispatcher.cancelTask(self.realEnterDeepGuide, self)
	TaskDispatcher.cancelTask(self.hideEnterDeepGuide, self)
	UIBlockMgr.instance:endBlock(TowerPermanentView.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function TowerPermanentView:onDestroyView()
	TowerPermanentModel.instance:cleanData()
	self._simageEnterBg:UnLoadImage()
	self._animEventWrap:RemoveAllEventListener()
	TowerModel.instance:cleanTrialData()
end

return TowerPermanentView
