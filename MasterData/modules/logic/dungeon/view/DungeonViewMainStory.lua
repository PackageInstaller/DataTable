-- chunkname: @modules/logic/dungeon/view/DungeonViewMainStory.lua

module("modules.logic.dungeon.view.DungeonViewMainStory", package.seeall)

local DungeonViewMainStory = class("DungeonViewMainStory", BaseView)

function DungeonViewMainStory:onInitView()
	self._scrollchapter = gohelper.findChildScrollRect(self.viewGO, "#go_story/chapterlist/#scroll_chapter")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/content")
	self._gotip = gohelper.findChild(self.viewGO, "#go_story/#go_mainstorytip")
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_story/#go_mainstorytip/#btn_tip")
	self._btnfirst = gohelper.findChildButtonWithAudio(self.viewGO, "#go_story/#btn_first")
	self._txttipname = gohelper.findChildText(self.viewGO, "#go_story/#go_mainstorytip/#txt_tipname")
	self._txttipnameen = gohelper.findChildText(self.viewGO, "#go_story/#go_mainstorytip/#txt_tipname_en")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonViewMainStory:addEvents()
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnfirst:AddClickListener(self._btnfirstOnClick, self)
end

function DungeonViewMainStory:removeEvents()
	self._btntip:RemoveClickListener()
	self._btnfirst:RemoveClickListener()
end

function DungeonViewMainStory:_btnfirstOnClick()
	if self._previewChapterId then
		self:_onOnFocusNormalChapter(self._previewChapterId)
	end
end

function DungeonViewMainStory:_btntipOnClick()
	if self._curSelectedSectionItem then
		self._curSelectedSectionItem:externalClickTip()
	end
end

function DungeonViewMainStory:_setSelectedSectionItem(item)
	self._curSelectedSectionItem = item

	if not item then
		gohelper.setActive(self._gotip, false)
	else
		self:_updateNames()
	end
end

function DungeonViewMainStory:_updateNames()
	self._txttipname.text = self._curSelectedSectionItem:getSectionName()

	if self._txttipnameen then
		self._txttipnameen.text = self._curSelectedSectionItem:getSectionNameEn()
	end
end

function DungeonViewMainStory:_editableInitView()
	gohelper.addUIClickAudio(self._btntip.gameObject, AudioEnum.UI.Play_UI_Copies)

	self._tipAnimator = self._gotip:GetComponent("Animator")
	self._initTipPosX = recthelper.getAnchorX(self._gotip.transform)
	self._sectionList = self:getUserDataTb_()
	self._chapterList = self:getUserDataTb_()
	self._chapterPosMap = {}
	self._curSelectedSectionItem = nil
	self._showChapterItemList = self:getUserDataTb_()
	self._posX = 0
	self._anchorVec = Vector2(0, 1)
	self._targetSectionId = -1
	self._gocontenttransform = self._gocontent.transform

	local contentTrans = self._gocontenttransform
	local vec = self._anchorVec

	contentTrans.pivot = vec
	contentTrans.anchorMin = vec
	contentTrans.anchorMax = vec
	contentTrans.anchoredPosition = Vector2.zero

	recthelper.setHeight(contentTrans, 748)

	self._gotemplatecell = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/content/templatecell")

	gohelper.setActive(self._gotemplatecell, false)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.SelectMainStorySection, self._onSelectMainStorySection, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.UnfoldMainStorySection, self._onUnfoldMainStorySection, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.FakeUnfoldMainStorySection, self._onFakeUnfoldMainStorySection, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnFocusNormalChapter, self._onOnFocusNormalChapter, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCheckChapterUnlock, self._onCheckChapterUnlock, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnFocusLastEarlyAccessChapter, self._onFocusLastEarlyAccessChapter, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
	gohelper.setActive(self._btnfirst, false)
end

function DungeonViewMainStory:_onUpdateDungeonInfo()
	self:_refreshPreviewFlag()
end

function DungeonViewMainStory:_onRefreshActivity()
	self:_refreshPreviewFlag()
end

function DungeonViewMainStory:_refreshPreviewFlag()
	if not self._previewChapterPosX or not self._previewChapterId then
		return
	end

	if not DungeonMainStoryModel.instance:showPreviewChapterFlag(self._previewChapterId) then
		self._previewChapterPosX = nil
		self._previewChapterId = nil

		gohelper.setActive(self._btnfirst, false)
	end
end

function DungeonViewMainStory:onScrollChange()
	if not self._curSelectedSectionItem then
		self._showFlowTipBtn = false

		gohelper.setActive(self._gotip, false)

		return
	end

	local x = recthelper.getAnchorX(self._gocontenttransform)
	local sectionTipBtnPosX = self._curSelectedSectionItem:getPosX()
	local showFlowTipBtn = x <= -sectionTipBtnPosX

	if self._forceHideTip then
		showFlowTipBtn = false
	end

	if showFlowTipBtn then
		local deltaX = sectionTipBtnPosX + x
		local isSpringDevice = UnityEngine.Screen.width / UnityEngine.Screen.height > 2

		if isSpringDevice then
			local lineWidth = self._curSelectedSectionItem:getLineWidth() + deltaX + DungeonMainStoryEnum.FlowLineOffsetWidth + (DungeonMainStoryEnum.FlowTipOffsetX or 0)
			local leftOffset = lineWidth - DungeonMainStoryEnum.FlowLineMinWidth

			recthelper.setAnchorX(self._gotip.transform, (leftOffset < 0 or nil) and (self._initTipPosX + leftOffset or self._initTipPosX))
			recthelper.setWidth(self._btntip.transform, lineWidth)

			if self._lastFrameCount ~= Time.frameCount then
				if self._openSelectedSectionFrame then
					local playOpenAnim = Time.frameCount - self._openSelectedSectionFrame <= 3

					self._tipAnimator:Play(playOpenAnim and "open" or "idle", 0, 0)

					self._lastFrameCount = Time.frameCount
				end
			else
				return
			end
		end
	end

	gohelper.setActive(self._gotip, showFlowTipBtn)
	self._curSelectedSectionItem:setTipVisible(not showFlowTipBtn and not self._forceHideTip)

	if not self._forceHideTip then
		local showPreviewFlag = self:_checkFirstBtnShow()

		if showPreviewFlag then
			TaskDispatcher.cancelTask(self._checkFirstBtnShow, self)
			TaskDispatcher.runRepeat(self._checkFirstBtnShow, self, 0, 10)
		end
	end

	if not self._showFlowTipBtn then
		self._showFlowTipBtn = true

		self:_updateNames()
	end
end

function DungeonViewMainStory:_checkFirstBtnShow()
	local x = recthelper.getAnchorX(self._gocontenttransform)
	local screenWidth = self:_getScreenWidth()

	if self._previewChapterPosX then
		local showPreviewFlag = screenWidth < x + self._previewChapterPosX

		gohelper.setActive(self._btnfirst, showPreviewFlag)

		if not showPreviewFlag then
			TaskDispatcher.cancelTask(self._checkFirstBtnShow, self)
		end

		return showPreviewFlag
	end
end

function DungeonViewMainStory:_getScreenWidth()
	return recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
end

function DungeonViewMainStory:_onUnfoldMainStorySection()
	local sectionId = DungeonMainStoryModel.instance:getSelectedSectionId()

	if sectionId and sectionId ~= 0 then
		DungeonMainStoryModel.instance:setSectionSelected(nil)
		self:_onSelectMainStorySection()
	end
end

function DungeonViewMainStory:_onFakeUnfoldMainStorySection()
	local sectionId = DungeonMainStoryModel.instance:getSelectedSectionId()

	if sectionId and sectionId ~= 0 then
		DungeonMainStoryModel.instance:clearSectionSelected()

		self._isFakeUnfold = true

		self:_onSelectMainStorySection()

		self._isFakeUnfold = false

		DungeonMainStoryModel.instance:setSectionSelected(sectionId)
	end
end

function DungeonViewMainStory:_onSelectMainStorySection()
	local sectionId = DungeonMainStoryModel.instance:getSelectedSectionId()
	local chapterList = DungeonMainStoryModel.instance:getChapterList(sectionId)

	if chapterList and #chapterList > 0 then
		self:_selectFocusNormalChapter(chapterList[#chapterList].id)

		return
	end

	self:_selectFocusNormalChapter()
end

function DungeonViewMainStory:_selectFocusNormalChapter(chapterId)
	self:_beFocusChapter(chapterId)
end

function DungeonViewMainStory:onOpen()
	return
end

function DungeonViewMainStory:_onFocusLastEarlyAccessChapter()
	local chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()

	self:_onOnFocusNormalChapter(chapterId)
end

function DungeonViewMainStory:_onCheckChapterUnlock()
	DungeonMainStoryModel.instance:forceUpdateChapterList()
	self:_onSelectMainStorySection()
end

function DungeonViewMainStory:_onOnFocusNormalChapter(chapterId)
	if chapterId then
		::label_22_0::

		local sectionId = DungeonConfig.instance:getChapterDivideSectionId(chapterId)
		local sameSectionId = sectionId == self._targetSectionId

		if sameSectionId then
			local pos = chapterId and self._chapterPosMap[chapterId]

			if pos then
				self:_moveToChapterPos(pos)

				return
			end
		end

		if not sectionId then
			self:_onSelectMainStorySection()

			return
		end

		self:_beFocusChapter(chapterId)
	end
end

function DungeonViewMainStory:_beFocusChapter(chapterId)
	if chapterId then
		::label_23_0::

		local sectionId = DungeonConfig.instance:getChapterDivideSectionId(chapterId)

		self._sameSectionId = sectionId == self._targetSectionId
		self._beFocusChapterId = chapterId
		self._targetSectionId = sectionId

		self:_playChapterFocusEffect()
	end
end

function DungeonViewMainStory:_killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function DungeonViewMainStory:_tweenHorizontalPosition()
	self:_killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self._scrollchapter.horizontalNormalizedPosition, 0, DungeonMainStoryEnum.AnimTime, self._tweenFrameCallback, nil, self)
end

function DungeonViewMainStory:_tweenFrameCallback(value)
	self._scrollchapter.horizontalNormalizedPosition = value
end

function DungeonViewMainStory:_playChapterFocusEffect()
	self._previewChapterPosX = nil
	self._hasOldSelectedSectionItem = nil

	if #self._showChapterItemList > 0 then
		self:_tweenHorizontalPosition()

		for i, v in ipairs(self._showChapterItemList) do
			v:playCloseAnim()
		end

		for k, v in pairs(self._sectionList) do
			v:moveToUnFoldPosX()
		end

		if self._curSelectedSectionItem and not self._sameSectionId then
			self._hasOldSelectedSectionItem = true

			self._curSelectedSectionItem:playAnimName("close")
		end

		if self._isFakeUnfold then
			self._isFakeUnfold = false

			self:_applyFocusChapter()

			return
		end

		TaskDispatcher.cancelTask(self._applyFocusChapter, self)
		TaskDispatcher.runDelay(self._applyFocusChapter, self, DungeonMainStoryEnum.AnimTime)
		self:_startBlock(DungeonMainStoryEnum.AnimTime)

		return
	end

	self:_applyFocusChapter()
end

function DungeonViewMainStory:_applyFocusChapter()
	self:_focusNormalChapter(self._beFocusChapterId)
end

function DungeonViewMainStory:_focusNormalChapter(chapterId)
	self._curFocusChapterId = nil

	local isExpand = self._curSelectedSectionItem ~= nil

	if chapterId then
		local sectionId = DungeonConfig.instance:getChapterDivideSectionId(chapterId)

		if sectionId then
			DungeonMainStoryModel.instance:setSectionSelected(sectionId)

			self._curFocusChapterId = chapterId
		end
	end

	self:_showAllChapterList()

	if self._curFocusChapterId then
		local pos = self._chapterPosMap[self._curFocusChapterId]

		self:_moveToChapterPos(pos, isExpand)

		self._forceHideTip = true

		self:onScrollChange()

		self._forceHideTip = false
	end
end

function DungeonViewMainStory:_moveToChapterPos(pos, isExpand)
	if pos then
		self._scrollchapter.movementType = 2

		local width = pos - recthelper.getWidth(self._scrollchapter.transform) / 2
		local contentPos = -width

		self:_clearTween()
		TaskDispatcher.cancelTask(self._resetMovementType, self)
		TaskDispatcher.cancelTask(self._delaySetContentPos, self)

		local isSpringDevice = UnityEngine.Screen.width / UnityEngine.Screen.height > 2

		if not isSpringDevice and self._curSelectedSectionItem and self._curSelectedSectionItem:getSectionId() > DungeonMainStoryEnum.FirstSectionId then
			self._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, contentPos, DungeonMainStoryEnum.SectionAnimTime, self._moveDone, self)

			TaskDispatcher.cancelTask(self.onScrollChange, self)
			TaskDispatcher.runDelay(self.onScrollChange, self, 0)
		else
			self._contentPos = contentPos

			recthelper.setAnchorX(self._gocontent.transform, contentPos)
			TaskDispatcher.runDelay(self._delaySetContentPos, self, 0)
		end
	end
end

function DungeonViewMainStory:_moveDone()
	TaskDispatcher.cancelTask(self._resetMovementType, self)
	TaskDispatcher.runDelay(self._resetMovementType, self, 0)
end

function DungeonViewMainStory:_delaySetContentPos()
	recthelper.setAnchorX(self._gocontent.transform, self._contentPos)
	TaskDispatcher.runDelay(self._resetMovementType, self, 0)
	TaskDispatcher.runDelay(self.onScrollChange, self, 0)
end

function DungeonViewMainStory:_clearTween()
	if self._tweenPosX then
		ZProj.TweenHelper.KillById(self._tweenPosX)

		self._tweenPosX = nil
	end
end

local BlockKey = "DungeonViewMainStoryBlock"

function DungeonViewMainStory:_startBlock(time)
	TaskDispatcher.cancelTask(self._endBlock, self)
	TaskDispatcher.runDelay(self._endBlock, self, time + DungeonMainStoryEnum.SectionAnimTime)
	UIBlockMgr.instance:startBlock(BlockKey)
end

function DungeonViewMainStory:_endBlock()
	UIBlockMgr.instance:endBlock(BlockKey)
end

function DungeonViewMainStory:_resetMovementType()
	self._scrollchapter.movementType = 1
end

function DungeonViewMainStory:_showAllChapterList()
	tabletool.clear(self._showChapterItemList)
	tabletool.clear(self._chapterPosMap)
	self:_setSelectedSectionItem(nil)

	self._startPosX = 147.5
	self._posX = self._startPosX
	self._sectionPosX = self._startPosX
	self._previewChapterPosX = nil
	self._previewChapterId = nil

	gohelper.setActive(self._btnfirst, false)

	local chapterIndex = 0

	for i, v in ipairs(lua_chapter_divide.configList) do
		local sectionId = v.sectionId
		local chapterList = DungeonMainStoryModel.instance:getChapterList(sectionId)

		if chapterList and #chapterList > 0 then
			self:_showOneSectionChapterList(sectionId, chapterList, chapterIndex)

			local config = lua_chapter_divide.configDict[sectionId]

			chapterIndex = #config.chapterId
		end

		self._posX = self._posX + DungeonMainStoryEnum.SectionSpace
	end

	recthelper.setWidth(self._gocontent.transform, self._posX)
end

function DungeonViewMainStory:_getSectionItem(sectionId)
	local sectionItem = self._sectionList[sectionId]

	if not sectionItem then
		local path = self.viewContainer:getSetting().otherRes.section_item
		local cellGo = gohelper.cloneInPlace(self._gotemplatecell, "section")

		gohelper.setActive(cellGo, true)

		local child = self:getResInst(path, cellGo, tostring(sectionId))

		sectionItem = MonoHelper.addNoUpdateLuaComOnceToGo(child, DungeonSectionItem)
		self._sectionList[sectionId] = sectionItem

		local trans = sectionItem.viewGO.transform
		local vec = Vector2(0, 1)

		trans.pivot = vec
		trans.anchorMin = vec
		trans.anchorMax = vec

		recthelper.setWidth(trans, DungeonMainStoryEnum.ChapterWidth.Section)
	end

	return sectionItem
end

function DungeonViewMainStory:_getChapterItem(chapterId, chapterIndex)
	local chapterItem = self._chapterList[chapterId]

	if not chapterItem then
		local isSpecialMainPlot = DungeonModel.instance:isSpecialMainPlot(chapterId)

		if isSpecialMainPlot then
			local var_39_0 = self.viewContainer:getSetting().otherRes.mini_item

			if not var_39_0 then
				var_39_0 = self.viewContainer:getSetting().otherRes[1]

				local path = var_39_0
				local cellGo = gohelper.cloneInPlace(self._gotemplatecell, "cell" .. chapterIndex - 1)

				gohelper.setActive(cellGo, true)

				local child = self:getResInst(path, cellGo, isSpecialMainPlot and "mini_item" or LuaListScrollView.PrefabInstName)

				chapterItem = MonoHelper.addNoUpdateLuaComOnceToGo(child, (isSpecialMainPlot or nil) and (DungeonChapterMiniItem or DungeonChapterItem))
				self._chapterList[chapterId] = chapterItem

				if isSpecialMainPlot then
					recthelper.setWidth(cellGo.transform, DungeonMainStoryEnum.ChapterWidth.Special)
					recthelper.setWidth(chapterItem.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Special)
				else
					recthelper.setWidth(cellGo.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
					recthelper.setWidth(chapterItem.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
				end

				local trans = chapterItem.viewGO.transform
				local vec = self._anchorVec

				trans.pivot = vec
				trans.anchorMin = vec
				trans.anchorMax = vec
			end
		end
	end

	return chapterItem
end

function DungeonViewMainStory:_showSectionItem(sectionId)
	local sectionItem = self:_getSectionItem(sectionId)

	sectionItem:onUpdateMO(lua_chapter_divide.configDict[sectionId])

	if DungeonMainStoryModel.instance:sectionIsSelected(sectionId) then
		self:_setSelectedSectionItem(sectionItem)
		sectionItem:playAnimName("unfold")
	end

	local pos = self._posX
	local sectionPosX = self._sectionPosX

	recthelper.setAnchor(sectionItem.viewGO.transform.parent, pos, DungeonMainStoryEnum.ChapterPosY.Section)
	sectionItem:setPosX(pos)
	sectionItem:setUnFoldPosX(self._sectionPosX)

	self._posX = self._posX + DungeonMainStoryEnum.ChapterWidth.Section
	self._sectionPosX = self._sectionPosX + DungeonMainStoryEnum.ChapterWidth.Section + DungeonMainStoryEnum.SectionSpace

	if pos ~= sectionPosX then
		recthelper.setAnchor(sectionItem.viewGO.transform.parent, sectionPosX, DungeonMainStoryEnum.ChapterPosY.Section)
		sectionItem:moveToPosX()
	end
end

function DungeonViewMainStory:_hideChpaterList(chapterList)
	for i, v in ipairs(chapterList) do
		local chapterItem = self._chapterList[v.id]

		if chapterItem then
			recthelper.setAnchorY(chapterItem.viewGO.transform.parent, 2000)
		end
	end
end

function DungeonViewMainStory:_showOneSectionChapterList(sectionId, chapterList, chapterIndex)
	self:_showSectionItem(sectionId)

	if not DungeonMainStoryModel.instance:sectionIsSelected(sectionId) then
		self:_hideChpaterList(chapterList)

		return
	end

	self._openSelectedSectionFrame = Time.frameCount
	self._posX = self._posX + DungeonMainStoryEnum.ChapterStartPosX

	for i, v in ipairs(chapterList) do
		local isSpecialMainPlot = DungeonModel.instance:isSpecialMainPlot(v.id)
		local chapterItem = self:_getChapterItem(v.id, chapterIndex + i)

		chapterItem:onUpdateMO(v)

		self._showChapterItemList[i] = chapterItem

		if chapterItem:getIsPlayCloseAnim() then
			chapterItem:playIdleAnim()
		end

		local pos = self._posX

		self._chapterPosMap[v.id] = pos

		if DungeonMainStoryModel.instance:showPreviewChapterFlag(v.id) then
			self._previewChapterPosX = pos + DungeonMainStoryEnum.PreviewOffsetX
			self._previewChapterId = v.id
		end

		if isSpecialMainPlot then
			recthelper.setAnchor(chapterItem.viewGO.transform.parent, pos, DungeonMainStoryEnum.ChapterPosY.Special)

			self._posX = self._posX + DungeonMainStoryEnum.ChapterWidth.Special
		else
			recthelper.setAnchor(chapterItem.viewGO.transform.parent, pos, DungeonMainStoryEnum.ChapterPosY.Normal)

			self._posX = self._posX + DungeonMainStoryEnum.ChapterWidth.Normal
		end

		if i ~= #chapterList then
			self._posX = self._posX + DungeonMainStoryEnum.ChapterSpace
		end
	end
end

function DungeonViewMainStory:onClose()
	TaskDispatcher.cancelTask(self._delaySetContentPos, self)
	TaskDispatcher.cancelTask(self._resetMovementType, self)
	TaskDispatcher.cancelTask(self._applyFocusChapter, self)
	TaskDispatcher.cancelTask(self.onScrollChange, self)
	TaskDispatcher.cancelTask(self._checkFirstBtnShow, self)
	self:_endBlock()
	self:_killTween()
	self:_clearTween()
end

return DungeonViewMainStory
