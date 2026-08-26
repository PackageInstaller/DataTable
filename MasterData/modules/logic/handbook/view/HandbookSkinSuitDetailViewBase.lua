-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailViewBase.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailViewBase", package.seeall)

local HandbookSkinSuitDetailViewBase = class("HandbookSkinSuitDetailViewBase", BaseView)

HandbookSkinSuitDetailViewBase.scrollableDiff = 50

function HandbookSkinSuitDetailViewBase:onInitView()
	self:initImageBg()

	self._skinItemRoot = gohelper.findChild(self.viewGO, "#go_scroll/#go_storyStages")
	self._goscroll = gohelper.findChild(self.viewGO, "#go_scroll")
	self._scroll = self._goscroll:GetComponent(gohelper.Type_ScrollRect)
	self._textSkinThemeDescr = gohelper.findChildText(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#txt_Descr")
	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._bgTrans = self._imageBg.transform

	local bgWidth = recthelper.getWidth(self._bgTrans)

	for i = 1, self._bgTrans.childCount do
		local child = self._bgTrans:GetChild(i - 1)

		if child then
			bgWidth = bgWidth + recthelper.getWidth(child)
		end
	end

	local uiRoot = ViewMgr.instance:getUIRoot()
	local uiRootWidth = recthelper.getWidth(uiRoot.transform)

	if bgWidth - uiRootWidth < HandbookSkinSuitDetailViewBase.scrollableDiff then
		self._scroll.horizontal = false
		self._scroll.vertical = false
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinSuitDetailViewBase:initImageBg()
	self._imageBg = gohelper.findChildSingleImage(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#simage_FullBG")
end

function HandbookSkinSuitDetailViewBase:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenedFinish, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshSkinRedDot, self)
end

function HandbookSkinSuitDetailViewBase:removeEvents()
	self.removeEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshSkinRedDot, self)
end

function HandbookSkinSuitDetailViewBase:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._scrollRectWrap = SLFramework.UGUI.ScrollRectWrap.Get(self._goscroll)

	if self._scrollRectWrap then
		self._scrollRectWrap:AddOnValueChanged(self._onScrollValueChanged, self)
	end
end

function HandbookSkinSuitDetailViewBase:_getPhotoRootGo(photoCount)
	self._skinItemGoList = self:getUserDataTb_()

	for i = 1, photoCount do
		self._skinItemGoList[i] = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/handbookskinitem/photo" .. i)
	end
end

function HandbookSkinSuitDetailViewBase:onOpen()
	logNormal(string.format("[Handbook] onOpen time: %.3f, viewName: %s", Time.realtimeSinceStartup, tostring(self.viewContainer.viewName)))

	local viewParam = self.viewParam

	self._skinSuitId = viewParam and viewParam.skinThemeGroupId
	self._isSuitSwitch = viewParam and viewParam.suitSwitch
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._skinSuitId)
	self._skinSuitGroupId = self._skinSuitCfg.highId

	local skinIdStr = self._skinSuitCfg.skinContain

	self._skinIdList = string.splitToNumber(skinIdStr, "|")

	self:addSwitchSuitBtns()

	if self._isSuitSwitch and self._viewAnimator then
		if self._viewAnimator:HasState(0, UnityEngine.Animator.StringToHash(UIAnimationName.Open)) then
			self._viewAnimator:Play(UIAnimationName.Open, 0, 1)
		elseif self._viewAnimator:HasState(0, UnityEngine.Animator.StringToHash("skinsuitdetailview_open")) then
			self._viewAnimator:Play("skinsuitdetailview_open", 0, 1)
		end
	end

	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	TaskDispatcher.cancelTask(self._delayedScrollAndCheckVisible, self)
	TaskDispatcher.runDelay(self._delayedScrollAndCheckVisible, self, 0.01)
	self:_refreshDesc()
	self:_refreshBg()

	if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(self._skinSuitId) then
		HandbookController.instance:markHandbookSkinNewRedDotShow(self._skinSuitId)
	end
end

function HandbookSkinSuitDetailViewBase:refreshUI()
	return
end

function HandbookSkinSuitDetailViewBase:refreshBtnStatus()
	return
end

function HandbookSkinSuitDetailViewBase:_refreshDesc()
	self._textSkinThemeDescr.text = self._skinSuitCfg.des
end

function HandbookSkinSuitDetailViewBase:_refreshBg()
	return
end

function HandbookSkinSuitDetailViewBase:_refreshSkinItems()
	self._skinItemList = {}

	for i = 1, #self._skinIdList do
		local skinItemGo = self._skinItemGoList[i]

		if skinItemGo then
			local skinItem = MonoHelper.addNoUpdateLuaComOnceToGo(skinItemGo, HandbookSkinItem, self)

			skinItem:setData(self._skinSuitId)
			skinItem:refreshItem(self._skinIdList[i])
			table.insert(self._skinItemList, skinItem)
		end
	end
end

function HandbookSkinSuitDetailViewBase:_scrollToFirstUnlockRedDotSkin()
	if not self._scroll or not self._scroll.horizontal then
		return
	end

	if not self._skinItemList then
		return
	end

	local targetSkinItem

	for i = 1, #self._skinItemList do
		local skinItem = self._skinItemList[i]

		if skinItem and skinItem._skinId and HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinItem._skinId) then
			targetSkinItem = skinItem

			break
		end
	end

	if not targetSkinItem then
		return
	end

	local content = self._scroll.content

	if not content then
		return
	end

	local viewport = self._scroll.viewport

	viewport = viewport or gohelper.findChild(self._goscroll, "Viewport").transform

	if not viewport then
		return
	end

	local contentWidth = recthelper.getWidth(content)
	local viewportWidth = recthelper.getWidth(viewport)
	local maxScroll = math.max(0, contentWidth - viewportWidth)

	if maxScroll <= 0 then
		return
	end

	local itemTrans = targetSkinItem.viewGO.transform
	local itemLocalPos = content:InverseTransformPoint(itemTrans.position)
	local itemLocalX = itemLocalPos.x
	local contentRect = content.rect
	local contentPivot = content.pivot
	local itemWidth = recthelper.getWidth(itemTrans)
	local itemPivot = itemTrans.pivot
	local targetLeftRelativeToPivot = itemLocalX - itemWidth * itemPivot.x
	local targetPosFromLeft = targetLeftRelativeToPivot + contentRect.width * contentPivot.x
	local targetPosFromCenter = targetPosFromLeft + itemWidth / 2 - viewportWidth / 2

	self._scroll.horizontalNormalizedPosition = GameUtil.saturate(targetPosFromCenter / maxScroll)
end

function HandbookSkinSuitDetailViewBase:_delayedScrollAndCheckVisible()
	self:_scrollToFirstUnlockRedDotSkin()
end

function HandbookSkinSuitDetailViewBase:_checkVisibleItemsUnlockVx()
	if not self._skinItemList then
		return
	end

	if not HandbookController.instance:isHandbookSkinSuitNewRedDotShow(self._skinSuitId) then
		return
	end

	for _, skinItem in ipairs(self._skinItemList) do
		if skinItem and skinItem.tryRefreshUnlockVx then
			skinItem:tryRefreshUnlockVx()
		end
	end
end

function HandbookSkinSuitDetailViewBase:_onScrollValueChanged()
	self:_checkVisibleItemsUnlockVx()
end

function HandbookSkinSuitDetailViewBase:addSwitchSuitBtns()
	local btnAsset = self.viewContainer:getSetting().otherRes[1]

	self.goBtns = self.viewContainer:getResInst(btnAsset, self.viewGO)
	self._btnLeftSuit = gohelper.findChildButton(self.goBtns, "#btn_Left")
	self._btnRightSuit = gohelper.findChildButton(self.goBtns, "#btn_Right")
	self._goRedDotLeft = gohelper.findChild(self.goBtns, "#btn_Left/#go_reddot")
	self._goRedDotRight = gohelper.findChild(self.goBtns, "#btn_Right/#go_reddot")
	self._handbookSkinRedDotLeft = RedDotController.instance:addNotEventRedDot(self._goRedDotLeft)

	self._handbookSkinRedDotLeft:setShowType(RedDotEnum.Style.Green)
	self._handbookSkinRedDotLeft:setCheckShowRedDotFunc(self.refreshRedDot, self)
	self._handbookSkinRedDotLeft:refreshRedDot()

	self._handbookSkinRedDotRight = RedDotController.instance:addNotEventRedDot(self._goRedDotRight)

	self._handbookSkinRedDotRight:setShowType(RedDotEnum.Style.Green)
	self._handbookSkinRedDotRight:setCheckShowRedDotFunc(self.refreshRedDot, self)
	self._handbookSkinRedDotRight:refreshRedDot()

	local suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(self._skinSuitGroupId, true)

	self._suitCount = #suitCfgList

	table.sort(suitCfgList, HandbookSkinSuitDetailViewBase._suitCfgSort)

	self.suitCfgList = suitCfgList

	for idx, suitCfg in ipairs(suitCfgList) do
		if suitCfg.id == self._skinSuitId then
			self._preSuitIdx = idx - 1
			self._curSuitIdx = idx
			self._nextSuitIdx = idx + 1

			break
		end
	end

	if self._preSuitIdx then
		local hasPreSuit = self._preSuitIdx >= 1

		if self._nextSuitIdx then
			local hasNextSuit = self._nextSuitIdx <= self._suitCount

			if hasPreSuit then
				self._btnLeftSuit:AddClickListener(self._onClickLeftSuit, self)
			else
				gohelper.setActive(self._btnLeftSuit.gameObject, false)

				self._btnLeftSuit = nil
			end

			if hasNextSuit then
				self._btnRightSuit:AddClickListener(self._onClickRightSuit, self)
			else
				gohelper.setActive(self._btnRightSuit.gameObject, false)

				self._btnRightSuit = nil
			end

			self:refreshSkinRedDot()
		end
	end
end

function HandbookSkinSuitDetailViewBase:refreshRedDot()
	return true
end

function HandbookSkinSuitDetailViewBase:_findNextRedDotSuitId(direction)
	local idx = self._curSuitIdx + direction

	while idx >= 1 and idx <= self._suitCount do
		local suitCfg = self.suitCfgList[idx]

		if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(suitCfg.id) then
			return suitCfg.id
		end

		idx = idx + direction
	end

	return nil
end

function HandbookSkinSuitDetailViewBase:_onClickLeftSuit()
	local var_20_0 = self._preRedDotSuitId

	if not self._preRedDotSuitId then
		var_20_0 = self.suitCfgList[self._preSuitIdx]

		if self.suitCfgList[self._preSuitIdx] then
			local suitId = self.suitCfgList[self._preSuitIdx].id

			if suitId then
				self:OpenOtherSuitView(suitId)
			end
		end
	end
end

function HandbookSkinSuitDetailViewBase:_onClickRightSuit()
	local var_21_0 = self._nextRedDotSuitId

	if not self._nextRedDotSuitId then
		var_21_0 = self.suitCfgList[self._nextSuitIdx]

		if self.suitCfgList[self._nextSuitIdx] then
			local suitId = self.suitCfgList[self._nextSuitIdx].id

			if suitId then
				self:OpenOtherSuitView(suitId)
			end
		end
	end
end

function HandbookSkinSuitDetailViewBase:refreshSkinRedDot()
	if self._preSuitIdx then
		local hasPreSuit = self._preSuitIdx >= 1

		if self._nextSuitIdx then
			local hasNextSuit = self._nextSuitIdx <= self._suitCount

			if hasPreSuit then
				self._preRedDotSuitId = self:_findNextRedDotSuitId(-1)

				gohelper.setActive(self._goRedDotLeft, self._preRedDotSuitId ~= nil)
			end

			if hasNextSuit then
				self._nextRedDotSuitId = self:_findNextRedDotSuitId(1)

				gohelper.setActive(self._goRedDotRight, self._nextRedDotSuitId ~= nil)
			end
		end
	end
end

function HandbookSkinSuitDetailViewBase:OpenOtherSuitView(suitId)
	local viewName = HandbookSkinScene.SkinSuitId2SuitView[suitId]

	if viewName then
		local viewParam = {
			suitSwitch = true,
			skinThemeGroupId = suitId
		}

		self._openOtherSuitView = viewName

		ViewMgr.instance:openView(viewName, viewParam, true)
	end
end

function HandbookSkinSuitDetailViewBase:onViewOpenedFinish(viewName)
	logNormal(string.format("[Handbook] onViewOpenedFinish time: %.3f, viewName: %s, self.viewName: %s, skinSuitId: %s", Time.realtimeSinceStartup, tostring(viewName), tostring(self.viewContainer.viewName), tostring(self._skinSuitId)))

	if self._openOtherSuitView == viewName then
		self:closeThis()
	end

	if viewName == self.viewContainer.viewName then
		logNormal(string.format("[Handbook] onViewOpenedFinish -> _checkVisibleItemsUnlockVx time: %.3f, skinSuitId: %s", Time.realtimeSinceStartup, tostring(self._skinSuitId)))
		self:_checkVisibleItemsUnlockVx()
	end
end

function HandbookSkinSuitDetailViewBase._suitCfgSort(cfg1, cfg2)
	if cfg1.show == 1 and cfg2.show == 0 then
		return true
	elseif cfg1.show == 0 and cfg2.show == 1 then
		return false
	else
		return cfg1.id > cfg2.id
	end
end

function HandbookSkinSuitDetailViewBase:onClose()
	TaskDispatcher.cancelTask(self._delayedScrollAndCheckVisible, self)

	if self._scrollRectWrap then
		self._scrollRectWrap:RemoveOnValueChanged()

		self._scrollRectWrap = nil
	end

	if self._btnRightSuit then
		self._btnRightSuit:RemoveClickListener()

		self._btnRightSuit = nil
	end

	if self._btnLeftSuit then
		self._btnLeftSuit:RemoveClickListener()

		self._btnLeftSuit = nil
	end
end

function HandbookSkinSuitDetailViewBase:onDestroyView()
	return
end

return HandbookSkinSuitDetailViewBase
