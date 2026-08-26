-- chunkname: @modules/logic/tower/view/permanenttower/TowerPermanentItem.lua

module("modules.logic.tower.view.permanenttower.TowerPermanentItem", package.seeall)

local TowerPermanentItem = class("TowerPermanentItem", ListScrollCellExtend)

function TowerPermanentItem:onInitView()
	self._gostage = gohelper.findChild(self.viewGO, "go_stage")
	self._txtstage = gohelper.findChildText(self.viewGO, "go_stage/txt_stage")
	self._btnunfold = gohelper.findChildButtonWithAudio(self.viewGO, "go_stage/btn_unfold")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "go_stage/btn_fold")
	self._golockTip = gohelper.findChild(self.viewGO, "go_locktip")
	self._txtlockTip = gohelper.findChildText(self.viewGO, "go_locktip/txt_lock")
	self._goaltitudeContent = gohelper.findChild(self.viewGO, "go_altitudeContent")
	self._goaltitudeItem = gohelper.findChild(self.viewGO, "go_altitudeContent/go_altitudeItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerPermanentItem:addEvents()
	self._btnunfold:AddClickListener(self._btnUnFoldOnClick, self)
	self._btnfold:AddClickListener(self._btnFoldOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.FoldCurStage, self.foldCurStage, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.UnFoldMaxStage, self.unfoldeMaxStage, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.PermanentTowerFinishLayer, self.playFinishEffect, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.PermanentSelectNextLayer, self.selectNextLayer, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnSelectDeepLayer, self.onSelectDeepLayer, self)
end

function TowerPermanentItem:removeEvents()
	self._btnunfold:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	TaskDispatcher.cancelTask(self.refreshLockTip, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.FoldCurStage, self.foldCurStage, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.UnFoldMaxStage, self.unfoldeMaxStage, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.PermanentTowerFinishLayer, self.playFinishEffect, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.PermanentSelectNextLayer, self.selectNextLayer, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnSelectDeepLayer, self.onSelectDeepLayer, self)
end

TowerPermanentItem.animFoldBlock = "TowerPermanentItemAnimFoldBlock"

function TowerPermanentItem:foldCurStage(stage)
	if self.mo.stage == stage then
		self:doFoldOnClick()
	end
end

function TowerPermanentItem:unfoldeMaxStage()
	if self.mo.stage == self.stageCount then
		self:doUnFoldOnClick()
	end
end

function TowerPermanentItem:_btnUnFoldOnClick()
	self:doUnFoldOnClick()
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(false)
end

function TowerPermanentItem:doUnFoldOnClick()
	if self.playingAnim then
		return
	end

	self.scrollRect.velocity = Vector2(0, 0)

	TowerPermanentModel.instance:setCurSelectStage(self.mo.stage)

	self.playingAnim = true

	UIBlockMgr.instance:startBlock(TowerPermanentItem.animFoldBlock)

	self.isUnFold = true

	TowerPermanentModel.instance:initStageUnFoldState(self.mo.stage)
	self:moveToTop()
	self:doUnFoldAnim()
end

function TowerPermanentItem:_btnFoldOnClick()
	self:doFoldOnClick()
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(false)
end

function TowerPermanentItem:doFoldOnClick()
	if self.playingAnim then
		return
	end

	self.scrollRect.velocity = Vector2(0, 0)
	self.isUnFold = false

	self.mo:setIsUnFold(false)
	self:doFoldAnim()
end

function TowerPermanentItem:_btnAltitudeItemClick(config)
	if self.altitudeItemTab[config.index].isSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_tab_switch)
	TowerPermanentModel.instance:setCurSelectLayer(config.index, self.mo.stage)

	for index, altitudeItem in pairs(self.altitudeItemTab) do
		local co = self.configList[index]

		self.altitudeItemTab[index].isSelect = index == config.index

		self:refreshSelectUI(altitudeItem, co)
	end

	TowerPermanentDeepModel.instance:setInDeepLayerState(false)
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(false)
	TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentAltitude)
end

function TowerPermanentItem:onSelectDeepLayer()
	if not self.altitudeItemTab or not next(self.altitudeItemTab) then
		return
	end

	for index, altitudeItem in pairs(self.altitudeItemTab) do
		local co = self.configList[index]

		self.altitudeItemTab[index].isSelect = false

		if co then
			self:refreshSelectUI(altitudeItem, co)
		end
	end
end

function TowerPermanentItem:selectNextLayer(permanentEpisodeCo)
	local layerIndex = permanentEpisodeCo.index
	local stageId = permanentEpisodeCo.stageId

	if self.mo.stage == stageId then
		self:_btnAltitudeItemClick(self.configList[layerIndex])
	end
end

TowerPermanentItem.selectFontSize = 40
TowerPermanentItem.unselectFontSize = 28
TowerPermanentItem.selectFontPos = Vector2.New(70, 5)
TowerPermanentItem.normalFontPos = Vector2.New(50, 0)
TowerPermanentItem.finishFontColor = "#D5E2ED"
TowerPermanentItem.selectFontColor = "#FFFFFF"
TowerPermanentItem.unFinishFontColor = "#7E8A95"

function TowerPermanentItem:_editableInitView()
	gohelper.setActive(self._goaltitudeItem, false)

	self.altitudeContentRect = self._goaltitudeContent:GetComponent(gohelper.Type_RectTransform)
	self.playingAnim = false

	UIBlockMgr.instance:endBlock(TowerPermanentItem.animFoldBlock)

	self.stageCount = TowerPermanentModel.instance:getStageCount()
end

function TowerPermanentItem:onUpdateMO(mo)
	self.mo = mo
	self.isUnFold = self.mo:getIsUnFold()

	local goScrollCategory = self._view._csMixScroll.gameObject

	self.scrollRect = goScrollCategory:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	if not self.goScrollContent then
		self.scrollCategory = gohelper.findChildScrollRect(goScrollCategory, "")
		self.rectViewPort = gohelper.findChild(goScrollCategory, "Viewport"):GetComponent(gohelper.Type_RectTransform)
		self.goScrollContent = gohelper.findChild(goScrollCategory, "Viewport/#go_Content")
		self.rectScrollContent = self.goScrollContent:GetComponent(gohelper.Type_RectTransform)
	end

	self.configList = self.mo.configList

	self:refreshUI()
	self:refreshAltitudeContentH()
end

function TowerPermanentItem:refreshUI()
	self.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()

	local timeTowerConfig = TowerConfig.instance:getTowerPermanentTimeCo(self.mo.stage)

	self._txtstage.text = timeTowerConfig.name
	self.stageCount = TowerPermanentModel.instance:getStageCount()

	gohelper.setActive(self._btnunfold.gameObject, not self.isUnFold)
	gohelper.setActive(self._btnfold.gameObject, self.isUnFold and self.mo.stage < self.stageCount)

	local isAltitudeEmpty = tabletool.len(self.configList) == 0

	gohelper.setActive(self._golockTip, isAltitudeEmpty)
	gohelper.setActive(self._gostage, not isAltitudeEmpty)
	gohelper.setActive(self._goaltitudeContent, not isAltitudeEmpty)
	TaskDispatcher.cancelTask(self.refreshLockTip, self)
	TaskDispatcher.runRepeat(self.refreshLockTip, self, 1)
	self:refreshLockTip()

	local curStage = TowerPermanentModel.instance:getCurSelectStage()

	if not isAltitudeEmpty and self.mo.stage == curStage then
		self:createOrRefreshAltitudeItem()
		self:moveToTop()
	end
end

function TowerPermanentItem:refreshLockTip()
	self._txtlockTip.text = ""

	local isOnlie, offsetTimeStamp = self.mo:checkIsOnline()
	local timeTowerConfig = TowerConfig.instance:getTowerPermanentTimeCo(self.mo.stage)
	local isAltitudeEmpty = tabletool.len(self.configList) == 0

	if isAltitudeEmpty then
		if isOnlie then
			local lastTimeTowerConfig = TowerConfig.instance:getTowerPermanentTimeCo(self.mo.stage - 1)

			self._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_stageunlocktip"), {
				lastTimeTowerConfig.name,
				timeTowerConfig.name
			})
		else
			local remainTime, dateformate = TimeUtil.secondToRoughTime2(offsetTimeStamp)

			self._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_timeunlocktip"), {
				remainTime,
				dateformate,
				timeTowerConfig.name
			})
		end
	end
end

function TowerPermanentItem:createOrRefreshAltitudeItem()
	self.altitudeItemTab = self:getUserDataTb_()

	local realSelectStage, realSelectLayerIndex = TowerPermanentModel.instance:getRealSelectStage()
	local isInDeepLayerState = TowerPermanentDeepModel.instance:getIsInDeepLayerState()

	for index, config in pairs(self.configList) do
		local altitudeItem = self._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(config, self._btnAltitudeItemClick, self)

		self.altitudeItemTab[index] = altitudeItem
		altitudeItem.isSelect = self.mo.stage == realSelectStage and index == realSelectLayerIndex and not isInDeepLayerState
		altitudeItem.txtNum.text = string.format("%sM", config.layerId * 10)

		self:refreshSelectUI(altitudeItem, config)
		gohelper.setActive(altitudeItem.go, true)
		altitudeItem.go.transform:SetParent(self._goaltitudeContent.transform, false)
		recthelper.setAnchor(altitudeItem.go.transform, 0, 0)
		ZProj.UGUIHelper.RebuildLayout(self._goaltitudeContent.transform)
	end

	self._view.viewContainer:getTowerPermanentPoolView():recycleAltitudeItem(self.configList)
end

function TowerPermanentItem:refreshSelectUI(altitudeItem, config)
	local isElite = config.isElite == 1
	local isFinish = config.layerId <= TowerPermanentModel.instance.curPassLayer

	gohelper.setActive(altitudeItem.goNormal, not isElite)
	gohelper.setActive(altitudeItem.goElite, isElite)
	gohelper.setActive(altitudeItem.goNormalSelect, altitudeItem.isSelect and not isElite)
	gohelper.setActive(altitudeItem.goEliteSelect, altitudeItem.isSelect and isElite)

	if altitudeItem.isSelect then
		altitudeItem.txtNum.fontSize = TowerPermanentItem.selectFontSize or TowerPermanentItem.unselectFontSize
	end

	if altitudeItem.isSelect then
		if not TowerPermanentItem.selectFontPos then
			local txtNumPos = TowerPermanentItem.normalFontPos
			local colorStr = "#FFFFFF"

			colorStr = altitudeItem.isSelect and TowerPermanentItem.selectFontColor or isFinish and TowerPermanentItem.finishFontColor or TowerPermanentItem.unFinishFontColor

			local isLayerUnlock = TowerPermanentModel.instance:checkLayerUnlock(config)

			altitudeItem.itemCanvasGroup.alpha = not isLayerUnlock and not altitudeItem.isSelect and 0.5 or 1

			SLFramework.UGUI.GuiHelper.SetColor(altitudeItem.txtNum, colorStr)
			recthelper.setAnchor(altitudeItem.txtNum.transform, txtNumPos.x, txtNumPos.y)
			gohelper.setActive(altitudeItem.goNormalUnFinish, not isFinish and not isElite and not altitudeItem.isSelect)
			gohelper.setActive(altitudeItem.goNormalFinish, isFinish and not isElite)
			gohelper.setActive(altitudeItem.goEliteUnFinish, not isFinish and isElite and not altitudeItem.isSelect)
			gohelper.setActive(altitudeItem.goEliteFinish, isFinish and isElite)
			gohelper.setActive(altitudeItem.goArrow, false)
			gohelper.setActive(altitudeItem.goNormalLock, not isLayerUnlock and not isElite and not altitudeItem.isSelect)
			gohelper.setActive(altitudeItem.goEliteLock, not isLayerUnlock and isElite and not altitudeItem.isSelect)

			if not string.nilorempty(config.spReward) then
				transformhelper.setLocalScale(altitudeItem.simageReward.gameObject.transform, 1, 1, 1)
				gohelper.setActive(altitudeItem.goReward, not altitudeItem.isSelect and not isFinish)

				local rewardData = string.splitToNumber(config.spReward, "#")
				local config, icon = ItemModel.instance:getItemConfigAndIcon(rewardData[1], rewardData[2])

				if config.subType == ItemEnum.SubType.Portrait then
					icon = ResUrl.getPlayerHeadIcon(config.icon)

					transformhelper.setLocalScale(altitudeItem.simageReward.gameObject.transform, 0.7, 0.7, 0.7)
				end

				altitudeItem.simageReward:LoadImage(icon)
			else
				gohelper.setActive(altitudeItem.goReward, false)
			end
		end
	end
end

function TowerPermanentItem:playFinishEffect(layerId)
	local permanentEpisodeCo = TowerConfig.instance:getPermanentEpisodeCo(layerId)
	local altitudeItem

	for index, config in pairs(self.configList) do
		if config.layerId == layerId then
			altitudeItem = self._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(config, self._btnAltitudeItemClick, self)

			break
		end
	end

	if not altitudeItem then
		return
	end

	if permanentEpisodeCo.isElite == 1 then
		altitudeItem.animEliteFinish:Play("in", 0, 0)
	else
		altitudeItem.animNormalFinish:Play("in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_single_star)
end

function TowerPermanentItem:refreshAltitudeContentH()
	if self.playingAnim then
		return
	end

	self.altitudeContentH = self.mo:getAltitudeHeight(self.isUnFold)

	recthelper.setHeight(self.altitudeContentRect, self.altitudeContentH)
end

function TowerPermanentItem:doUnFoldAnim()
	UIBlockMgr.instance:startBlock(TowerPermanentItem.animFoldBlock)

	self.scrollCategory.movementType = 2
	self.altitudeContentH = self.mo:getAltitudeHeight(self.isUnFold)
	self._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0, self.altitudeContentH, self.altitudeContentH * 0.0003, self._onFoldTweenFrameCallback, self._onUnFoldTweenFinishCallback, self, nil)
end

function TowerPermanentItem:doFoldAnim()
	UIBlockMgr.instance:startBlock(TowerPermanentItem.animFoldBlock)

	self.scrollCategory.movementType = 2
	self._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(self.altitudeContentH, 0, self.altitudeContentH * 0.0001, self._onFoldTweenFrameCallback, self._onFoldTweenFinishCallback, self, nil)
end

function TowerPermanentItem:_onFoldTweenFrameCallback(value)
	self.playingAnim = true

	self:moveToTop()

	local hasLockTip = TowerPermanentModel.instance:checkhasLockTip()

	if hasLockTip then
		if not TowerEnum.PermanentUI.LockTipH then
			local lockTipH = 0
			local stageCount = self.stageCount - self.mo.stage + 1

			if self.isDeepLayerUnlock then
				local viewPortH = Mathf.Min(TowerEnum.PermanentUI.StageTitleH * stageCount + lockTipH + value, TowerEnum.PermanentUI.DeepScrollH or TowerEnum.PermanentUI.ScrollH)

				recthelper.setHeight(self.rectViewPort, viewPortH)
				self.mo:overrideStageHeight(value)
				recthelper.setHeight(self.altitudeContentRect, value)
				TowerPermanentModel.instance:onModelUpdate()
			end
		end
	end
end

function TowerPermanentItem:_onFoldTweenFinishCallback()
	self.playingAnim = false

	UIBlockMgr.instance:endBlock(TowerPermanentItem.animFoldBlock)
	TowerPermanentModel.instance:setCurSelectStage(self.stageCount)
	TowerController.instance:dispatchEvent(TowerEvent.UnFoldMaxStage)
end

function TowerPermanentItem:moveToTop()
	local moveToPos = TowerEnum.PermanentUI.StageTitleH * Mathf.Max(self.mo.stage - 2, 0)

	recthelper.setAnchorY(self.rectScrollContent, moveToPos)
end

function TowerPermanentItem:_onUnFoldTweenFinishCallback()
	self.playingAnim = false

	UIBlockMgr.instance:endBlock(TowerPermanentItem.animFoldBlock)
	self:moveToTop()
	self.mo:cleanCurUnFoldingH()
	self:refreshAltitudeContentH()
	TowerPermanentModel.instance:onModelUpdate()

	self.scrollCategory.movementType = 1

	local isSelectDeepCategory = TowerPermanentDeepModel.instance:getIsSelectDeepCategory()

	if isSelectDeepCategory then
		self.scrollCategory.verticalNormalizedPosition = 0
	end
end

function TowerPermanentItem:onDestroy()
	if self._foldAnimTweenId then
		ZProj.TweenHelper.KillById(self._foldAnimTweenId)

		self._foldAnimTweenId = nil
	end

	TaskDispatcher.cancelTask(self.refreshLockTip, self)
	UIBlockMgr.instance:endBlock(TowerPermanentItem.animFoldBlock)
end

return TowerPermanentItem
