-- chunkname: @modules/logic/towercompose/view/TowerComposeResearchView.lua

module("modules.logic.towercompose.view.TowerComposeResearchView", package.seeall)

local TowerComposeResearchView = class("TowerComposeResearchView", BaseView)

function TowerComposeResearchView:onInitView()
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "root/left/#scroll_progress")
	self._goprogressContent = gohelper.findChild(self.viewGO, "root/left/#scroll_progress/Viewport/#go_progressContent")
	self._goprogressBarBg = gohelper.findChild(self.viewGO, "root/left/#scroll_progress/Viewport/#go_progressContent/progress/#go_progressBarBg")
	self._gobarBgIcon = gohelper.findChild(self.viewGO, "root/left/#scroll_progress/Viewport/#go_progressContent/progress/#go_progressBarBg/#go_barBgIcon")
	self._goprogressBar = gohelper.findChild(self.viewGO, "root/left/#scroll_progress/Viewport/#go_progressContent/progress/#go_progressBar")
	self._gobarIcon = gohelper.findChild(self.viewGO, "root/left/#scroll_progress/Viewport/#go_progressContent/progress/#go_progressBar/#go_barIcon")
	self._goprogressItem = gohelper.findChild(self.viewGO, "root/left/#scroll_progress/Viewport/#go_progressContent/#go_progressItem")
	self._txtcurProgress = gohelper.findChildText(self.viewGO, "root/left/progressinfo/#txt_curProgress")
	self._goeffectTargetPos = gohelper.findChild(self.viewGO, "root/left/#go_effectTargetPos")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_task")
	self._gotaskContent = gohelper.findChild(self.viewGO, "root/right/#scroll_task/Viewport/#go_taskContent")
	self._goblock = gohelper.findChild(self.viewGO, "root/#go_block")
	self._gomodTipPos = gohelper.findChild(self.viewGO, "root/#go_modTipPos")
	self._goflyEndPos = gohelper.findChild(self.viewGO, "root/#go_flyEndPos")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeResearchView:addEvents()
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.OnResearchTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.ResearchProgressUpdate, self.refreshProgressInfo, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.ShowModDescTip, self.showModDescTip, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.PlayResearchItemFlyAnim, self.playRewardPointFlyAnim, self)
end

function TowerComposeResearchView:removeEvents()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.OnResearchTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.ResearchProgressUpdate, self.refreshProgressInfo, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.ShowModDescTip, self.showModDescTip, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.PlayResearchItemFlyAnim, self.playRewardPointFlyAnim, self)
end

TowerComposeResearchView.TaskMaskTime = 0.65
TowerComposeResearchView.TaskGetAnimTime = 0.567
TowerComposeResearchView.progressItemH = 220
TowerComposeResearchView.barItemH = 1020

function TowerComposeResearchView:_editableInitView()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer.scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(TowerComposeResearchView.TaskMaskTime - TowerComposeResearchView.TaskGetAnimTime)

	self.removeIndexTab = {}
	self.progressItemMap = self:getUserDataTb_()
	self.barBgItemList = self:getUserDataTb_()

	gohelper.setActive(self._gobarBgIcon, false)
	gohelper.setActive(self._gobarIcon, false)
	gohelper.setActive(self._goprogressItem, false)
	gohelper.setActive(self._goblock, false)

	self.flyCompGO = gohelper.findChild(self.viewGO, "root/#fly")
	self.flyGO = gohelper.findChild(self.flyCompGO, "flyitem")
	self.flyComp = self.flyCompGO:GetComponent(typeof(UnityEngine.UI.UIFlying))

	self.flyComp:SetFlyItemObj(self.flyGO)
	gohelper.setActive(self.flyCompGO, false)
	gohelper.setActive(self.flyGO, false)

	self.lastUnlockItemIndex = -1
end

function TowerComposeResearchView:onUpdateParam()
	return
end

function TowerComposeResearchView:onOpen()
	self._scrolltask.verticalNormalizedPosition = 1
	self.curThemeId = self.viewParam.themeId or TowerComposeModel.instance:getCurThemeIdAndLayer()

	self:refreshUI()
end

function TowerComposeResearchView:refreshUI()
	self:refreshProgressBarBg()
	self:refreshProgressInfo()
end

function TowerComposeResearchView:refreshProgressBarBg()
	local allResearchCoList = TowerComposeConfig.instance:getAllResearchCoList(self.curThemeId)
	local barBgH = #allResearchCoList * TowerComposeResearchView.progressItemH

	recthelper.setHeight(self._goprogressBarBg.transform, barBgH)

	local bgItemCount = Mathf.Ceil(barBgH / TowerComposeResearchView.barItemH)

	for index = 1, bgItemCount do
		local bgItem = self.barBgItemList[index]

		if not bgItem then
			bgItem = {
				index = index,
				bgItemGO = gohelper.clone(self._gobarBgIcon, self._goprogressBarBg, "bgGO" .. index),
				barItemGO = gohelper.clone(self._gobarIcon, self._goprogressBar, "barGO" .. index)
			}
			self.barBgItemList[index] = bgItem
		end

		gohelper.setActive(bgItem.bgItemGO, true)
		gohelper.setActive(bgItem.barItemGO, true)
	end
end

function TowerComposeResearchView:refreshProgressInfo()
	self.curThemeMo = TowerComposeModel.instance:getThemeMo(self.curThemeId)

	local allResearchNum = TowerComposeConfig.instance:getMaxResearchNum(self.curThemeId)
	local curProgress = Mathf.Min(self.curThemeMo.researchProgress, allResearchNum)

	self._txtcurProgress.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towercomposetheme_progress"), curProgress, allResearchNum)

	self:createAndRefreshProgressItem()
	self:refreshProgressBar()
	self:playProgressItemUnlockAnim()
end

function TowerComposeResearchView:createAndRefreshProgressItem()
	self.allResearchCoList = TowerComposeConfig.instance:getAllResearchCoList(self.curThemeId)

	for index, researchCo in ipairs(self.allResearchCoList) do
		local progressItem = self.progressItemMap[index]

		if not progressItem then
			progressItem = {
				index = index,
				itemGO = gohelper.clone(self._goprogressItem, self._goprogressContent, "progressItem_" .. index)
			}
			progressItem.goUnlock = gohelper.findChild(progressItem.itemGO, "left/go_unlock")
			progressItem.imageUnlockIcon = gohelper.findChildImage(progressItem.itemGO, "left/go_unlock/image_icon")
			progressItem.goLock = gohelper.findChild(progressItem.itemGO, "left/go_lock")
			progressItem.imageLockIcon = gohelper.findChildImage(progressItem.itemGO, "left/go_lock/image_icon")
			progressItem.goLine = gohelper.findChild(progressItem.itemGO, "go_line")
			progressItem.txtReqPointNum = gohelper.findChildText(progressItem.itemGO, "reqPoint/txt_reqPointNum")
			progressItem.txtAddDesc = gohelper.findChildText(progressItem.itemGO, "descContent/txt_addDesc")
			progressItem.txtDesc = gohelper.findChildText(progressItem.itemGO, "descContent/txt_desc")
			progressItem.anim = progressItem.itemGO:GetComponent(typeof(UnityEngine.Animator))
			self.progressItemMap[index] = progressItem
		end

		progressItem.config = researchCo

		gohelper.setActive(progressItem.itemGO, true)

		local isUnlock = self.curThemeMo.researchProgress >= researchCo.req

		gohelper.setActive(progressItem.goUnlock, isUnlock)
		gohelper.setActive(progressItem.goLock, not isUnlock)

		progressItem.txtReqPointNum.text = researchCo.req
		progressItem.txtDesc.text = researchCo.desc

		SLFramework.UGUI.GuiHelper.SetColor(progressItem.txtDesc, isUnlock and "#E5E5E5" or "#A5A8AC")

		local exLevelInfoList = GameUtil.splitString2(researchCo.exLevel, true) or {}

		UISpriteSetMgr.instance:setTower2Sprite(progressItem.imageUnlockIcon, researchCo.icon)
		UISpriteSetMgr.instance:setTower2Sprite(progressItem.imageLockIcon, researchCo.icon)

		if #exLevelInfoList == 1 then
			local addDesc = TowerComposeConfig.instance:getConstValue(TowerComposeEnum.ConstId.ResearchExLevel1, false, true)

			progressItem.txtAddDesc.text = GameUtil.getSubPlaceholderLuaLang(addDesc, {
				exLevelInfoList[1][1],
				exLevelInfoList[1][2]
			})
		elseif #exLevelInfoList == 2 then
			local addDesc = TowerComposeConfig.instance:getConstValue(TowerComposeEnum.ConstId.ResearchExLevel2, false, true)

			progressItem.txtAddDesc.text = GameUtil.getSubPlaceholderLuaLang(addDesc, {
				exLevelInfoList[1][1],
				exLevelInfoList[1][2],
				exLevelInfoList[2][1],
				exLevelInfoList[2][2]
			})
		else
			progressItem.txtAddDesc.text = ""
		end

		gohelper.setActive(progressItem.goLine, index < #self.allResearchCoList)
		SLFramework.UGUI.GuiHelper.SetColor(progressItem.txtReqPointNum, isUnlock and "#DDE4EF" or "#7F8CA7")
		ZProj.UGUIHelper.SetColorAlpha(progressItem.txtAddDesc, isUnlock and 1 or 0.5)
		ZProj.UGUIHelper.SetColorAlpha(progressItem.txtDesc, isUnlock and 1 or 0.5)
		gohelper.setActive(progressItem.txtAddDesc.gameObject, false)
	end
end

function TowerComposeResearchView:refreshProgressBar()
	local progressBarH, unlockIndex = self:getTargetProgressBarH()

	recthelper.setHeight(self._goprogressBar.transform, (self.curProgressBarH and self.curProgressBarH > 0 or nil) and (self.curProgressBarH or progressBarH))
	recthelper.setAnchorY(self._goprogressContent.transform, (self.curUnlockIndex and self.curUnlockIndex > 0 or nil) and ((self.curUnlockIndex - 1) * TowerComposeResearchView.progressItemH or (unlockIndex - 1) * TowerComposeResearchView.progressItemH))

	if self.curProgressBarH and self.curProgressBarH ~= progressBarH then
		if not self.curProgressBarH then
			do
				local curBarH = 0

				self.tweenHeightId = ZProj.TweenHelper.DOTweenFloat(curBarH, progressBarH, 0.3, self.setProgressBarHTween, self.setProgressBarHTweenDone, self)

				gohelper.setActive(self._goblock, true)
			end

			if self.curUnlockIndex and self.curUnlockIndex ~= unlockIndex then
				if not self.curUnlockIndex then
					local curIndex = 0
					local curMoveY = (curIndex - 1) * TowerComposeResearchView.progressItemH
					local targetMoveY = (unlockIndex - 1) * TowerComposeResearchView.progressItemH

					self.tweenMoveId = ZProj.TweenHelper.DOTweenFloat(curMoveY, targetMoveY, 0.3, self.setProgressMoveTween, self.setProgressMoveTweenDone, self)

					gohelper.setActive(self._goblock, true)
				end
			end
		end
	end

	self.curProgressBarH = progressBarH
	self.curUnlockIndex = unlockIndex

	if self.lastUnlockItemIndex == -1 then
		self.lastUnlockItemIndex = self.curUnlockIndex or self.lastUnlockItemIndex
	end
end

function TowerComposeResearchView:playProgressItemUnlockAnim()
	if self.lastUnlockItemIndex ~= self.curUnlockIndex and self.curUnlockIndex > self.lastUnlockItemIndex then
		for index = self.lastUnlockItemIndex + 1, self.curUnlockIndex do
			local progressItem = self.progressItemMap[index]

			if progressItem then
				progressItem.anim:Play("unlock")
				progressItem.anim:Update(0)
			end
		end

		self.lastUnlockItemIndex = self.curUnlockIndex
	end
end

function TowerComposeResearchView:setProgressBarHTween(value)
	recthelper.setHeight(self._goprogressBar.transform, value)
end

function TowerComposeResearchView:setProgressBarHTweenDone()
	self.curProgressBarH = self:getTargetProgressBarH()

	gohelper.setActive(self._goblock, false)
end

function TowerComposeResearchView:setProgressMoveTween(value)
	recthelper.setAnchorY(self._goprogressContent.transform, value)
end

function TowerComposeResearchView:setProgressMoveTweenDone()
	gohelper.setActive(self._goblock, false)
end

function TowerComposeResearchView:getTargetProgressBarH()
	local firstPartH = 131
	local tagH = 62
	local normalPartH = 158
	local endH = 83
	local nowIndex = 0
	local nowIndexValue = 0
	local nextIndexValue = 0
	local offsetValue = 0
	local processH = 0
	local allResearchNum = TowerComposeConfig.instance:getMaxResearchNum(self.curThemeId)
	local curProgress = Mathf.Min(self.curThemeMo.researchProgress, allResearchNum)

	for index, progressItem in ipairs(self.progressItemMap) do
		if curProgress >= progressItem.config.req then
			nowIndex = index
			nowIndexValue = progressItem.config.req
			nextIndexValue = progressItem.config.req
		else
			nextIndexValue = progressItem.config.req

			break
		end
	end

	if nextIndexValue ~= nowIndexValue then
		offsetValue = (curProgress - nowIndexValue) / (nextIndexValue - nowIndexValue)
	end

	processH = nowIndex == 0 and firstPartH * offsetValue or firstPartH + nowIndex * tagH + (nowIndex - 1) * normalPartH + offsetValue * normalPartH

	if nowIndex == #self.allResearchCoList then
		processH = processH + endH
	end

	recthelper.setHeight(self._goprogressContent.transform, firstPartH + #self.allResearchCoList * tagH + (#self.allResearchCoList - 1) * normalPartH + endH)

	return processH, nowIndex
end

function TowerComposeResearchView:showModDescTip(modIdList)
	local param = {}

	param.modIdList = modIdList
	param.parentGO = self._gomodTipPos
	param.pivot = Vector2(0.5, 1)

	TowerComposeController.instance:openTowerComposeModDescTipView(param)
end

function TowerComposeResearchView:_playGetRewardFinishAnim(removeIndexList)
	if #removeIndexList > 0 then
		self.removeIndexTab = removeIndexList
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, TowerComposeResearchView.TaskGetAnimTime)
end

function TowerComposeResearchView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function TowerComposeResearchView:playRewardPointFlyAnim(taskCanGetBtnGO)
	gohelper.setActive(self.flyCompGO, true)

	local startPosX, startPosY = recthelper.rectToRelativeAnchorPos2(taskCanGetBtnGO.transform.position, self.viewGO.transform)
	local endPosX, endPosY = recthelper.rectToRelativeAnchorPos2(self._goflyEndPos.transform.position, self.viewGO.transform)

	self.flyComp:SetOneFlyItemDoneAndRecycleDoneCallback(self.onFlyDone, self)

	self.flyComp.startPosition = Vector2(startPosX, startPosY)
	self.flyComp.endPosition = Vector2(endPosX, endPosY)

	self.flyComp:StartFlying()
end

function TowerComposeResearchView:onFlyDone()
	return
end

function TowerComposeResearchView:onClose()
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)

	if self.tweenHeightId then
		ZProj.TweenHelper.KillById(self.tweenHeightId)

		self.tweenHeightId = nil
	end

	if self.tweenMoveId then
		ZProj.TweenHelper.KillById(self.tweenMoveId)

		self.tweenMoveId = nil
	end
end

function TowerComposeResearchView:onDestroyView()
	return
end

return TowerComposeResearchView
