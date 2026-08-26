-- chunkname: @modules/logic/dungeon/view/map/DungeonMapEpisode.lua

module("modules.logic.dungeon.view.map.DungeonMapEpisode", package.seeall)

local DungeonMapEpisode = class("DungeonMapEpisode", BaseView)

function DungeonMapEpisode:onInitView()
	self._gobgcanvas = gohelper.findChild(self.viewGO, "bgcanvas")
	self._gobgcontainerold = gohelper.findChild(self.viewGO, "bgcanvas/#go_bgcontainerold")
	self._gobgcontainer = gohelper.findChild(self.viewGO, "bgcanvas/#go_bgcontainer")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._gochaptercontentitem = gohelper.findChild(self.viewGO, "#scroll_content/#go_chaptercontentitem")
	self._gochapterlist = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist")
	self._gochapterlineItem = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem")
	self._goitemline = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_itemline")
	self._goBgCg = gohelper.findChild(self.viewGO, "bgcanvas/#go_bgcg")
	self.bgCgCtrl = self._goBgCg:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self.animBgCg = self._goBgCg:GetComponent(typeof(UnityEngine.Animator))
	self._goUnlockedBg = gohelper.findChild(self._goBgCg, "unlocked")
	self._unlocksimagecgbg = gohelper.findChildSingleImage(self._goUnlockedBg, "#simage_cgbg")
	self._unlockimagecgbg = gohelper.findChildImage(self._goUnlockedBg, "#simage_cgbg")
	self._goLockedBg = gohelper.findChild(self._goBgCg, "locked")
	self._locksimagecgbg = gohelper.findChildSingleImage(self._goLockedBg, "bgmask/#simage_cgbg")
	self._lockimagecgbg = gohelper.findChildImage(self._goLockedBg, "bgmask/#simage_cgbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapEpisode:addEvents()
	return
end

function DungeonMapEpisode:removeEvents()
	return
end

function DungeonMapEpisode:_editableInitView()
	DungeonModel.instance.chapterBgTweening = false
	self._chapterLineItemList = self:getUserDataTb_()
	self._chapterLineList = self:getUserDataTb_()
	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollcontent.gameObject, DungeonMapEpisodeAudio, self._scrollcontent)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollcontent.gameObject)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._scrollcontent.gameObject)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)

	local limitedScrollRect = self._scrollcontent:GetComponent(typeof(ZProj.LimitedScrollRect))

	limitedScrollRect.scrollSpeed = 0.5

	gohelper.setActive(self._gochaptercontentitem, false)

	self._bgCanvas = self._gobgcontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._olgBgCanvas = self._gobgcontainerold:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._realscrollcontent = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._fadeTime = 1
end

function DungeonMapEpisode:_onScrollValueChanged(x, y)
	self:_checkEpisodeVision(x, y)
end

function DungeonMapEpisode:_checkEpisodeVision(x, y)
	if not self._scrollPosX or math.abs(self._scrollPosX - x) >= 0.01 then
		if self._scrollPosX then
			self:_onCheckVision()
		end

		self._scrollPosX = x
	end

	TaskDispatcher.cancelTask(self._onEndScroll, self)
	TaskDispatcher.runDelay(self._onEndScroll, self, 0.1)
end

function DungeonMapEpisode:_onCheckVision()
	if self._chapterLayout then
		self._chapterLayout:CheckVision()
	end
end

function DungeonMapEpisode:_onEndScroll()
	self._scrollPosX = nil

	self:_onCheckVision()
end

function DungeonMapEpisode:_initChapterItem()
	self:_updateChapterList()
	self:changeChapter(DungeonModel.instance.curLookChapterId)
end

function DungeonMapEpisode:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function DungeonMapEpisode:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function DungeonMapEpisode:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function DungeonMapEpisode:_updateChapterList()
	self._chapterId = self.viewParam.chapterId

	local chapterConfig = DungeonConfig.instance:getChapterCO(self._chapterId)

	self._isResChapter = chapterConfig.type ~= DungeonEnum.ChapterType.Normal

	if not self._isResChapter then
		return
	end

	if self._isResChapter then
		gohelper.setActive(self._gochapterlist, false)

		return
	end

	for i = 1, #self._chapterLineItemList do
		self._chapterLineItemList[i]:destroyView()

		self._chapterLineItemList[i] = nil
	end

	for i = 1, #self._chapterLineList do
		gohelper.destroy(self._chapterLineList[i])

		self._chapterLineList[i] = nil
	end

	local fbList = DungeonChapterListModel.instance:getChapterList(self._chapterId)

	if #fbList <= 1 then
		return
	end

	for i = 1, #fbList do
		if i == 1 then
			self:_addLine()
		end

		self:_addChapterItem(i, fbList[i])
		self:_addLine()
	end
end

function DungeonMapEpisode:_addChapterItem(index, config)
	local child = gohelper.clone(self._gochapterlineItem, self._gochapterlist, "ChapterLineItem")

	gohelper.setActive(child, true)

	local item = DungeonMapChapterLineItem.New()

	item:initView(child, {
		index = index,
		config = config
	})
	table.insert(self._chapterLineItemList, item)
end

function DungeonMapEpisode:_addLine()
	local tempLine = gohelper.clone(self._goitemline, self._gochapterlist, "itemline")

	gohelper.setActive(tempLine, true)
	table.insert(self._chapterLineList, tempLine)
end

function DungeonMapEpisode:changeChapter(chapter)
	local sameChapter = self._curChapter == chapter

	self._curChapter = chapter
	DungeonModel.instance.curLookChapterId = chapter

	for i, v in ipairs(self._chapterLineItemList) do
		v:updateStatus()
	end

	if sameChapter then
		return
	end

	self:_clearEpisodeListTween()

	if chapter ~= self._curChapterId then
		if self._curChapterId then
			DungeonAudio.instance:closeChapterAmbientSound(self._curChapterId)
		end

		self._curChapterId = chapter

		DungeonAudio.instance:openChapterAmbientSound()
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)

	self._isResChapter = chapterConfig.type ~= DungeonEnum.ChapterType.Normal

	self:_switchLayout(chapter)

	if self._isResChapter then
		self:_switchBg(chapter)
	end

	self:_loadNewLayout(chapter)

	if self._isResChapter and chapterConfig.type ~= DungeonEnum.ChapterType.RoleStory then
		self:_loadNewBg(chapter)
	end

	self:refreshRoleStoryBg()
	gohelper.setActive(self._gobgcanvas, self._isResChapter)
end

function DungeonMapEpisode:refreshRoleStoryBg()
	local chapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)

	if chapterConfig.type ~= DungeonEnum.ChapterType.RoleStory then
		gohelper.setActive(self._goBgCg, false)

		return
	end

	gohelper.setActive(self._goBgCg, true)

	local storyId = RoleStoryModel.instance:getCurStoryId()
	local storyCo = RoleStoryConfig.instance:getStoryById(storyId)
	local unlockEpisodeId = storyCo.cgUnlockEpisodeId
	local unlock = unlockEpisodeId == 0 or DungeonModel.instance:hasPassLevel(unlockEpisodeId)

	if unlock and RoleStoryModel.instance:canPlayDungeonUnlockAnim(storyId) then
		if ViewMgr.instance:isOpen(ViewName.StoryView) then
			gohelper.setActive(self._goUnlockedBg, false)
			gohelper.setActive(self._goLockedBg, true)
			self.animBgCg:Play("idle")
			self:refreshRoleStoryLockBg(storyCo)
		else
			RoleStoryModel.instance:setPlayDungeonUnlockAnimFlag(storyId)
			gohelper.setActive(self._goUnlockedBg, true)
			gohelper.setActive(self._goLockedBg, true)
			self:refreshRoleStoryUnlockBg(storyCo)
			self:refreshRoleStoryLockBg(storyCo)
			self.animBgCg:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	else
		gohelper.setActive(self._goUnlockedBg, unlock)
		gohelper.setActive(self._goLockedBg, not unlock)
		self.animBgCg:Play("idle")

		if unlock then
			self:refreshRoleStoryUnlockBg(storyCo)
		else
			self:refreshRoleStoryLockBg(storyCo)
		end
	end
end

function DungeonMapEpisode:refreshRoleStoryUnlockBg(storyCo)
	self._unlocksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", storyCo.cgBg), self._onLoadUnlockCgCallback, self)
	recthelper.setAnchor(self._unlockimagecgbg.transform, self._cgTargetPos or 0, 0)
	transformhelper.setLocalScale(self._unlockimagecgbg.transform, 1, 1, 1)
end

function DungeonMapEpisode:refreshRoleStoryLockBg(storyCo)
	self._locksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", storyCo.cgBg), self._onLoadLockCgCallback, self)

	local poss = string.splitToNumber(storyCo.cgPos, "#")

	recthelper.setAnchor(self._lockimagecgbg.transform, poss[1] or 0, poss[2] or 0)
	transformhelper.setLocalScale(self._lockimagecgbg.transform, tonumber(storyCo.cgScale) or 1, tonumber(storyCo.cgScale) or 1, 1)
end

function DungeonMapEpisode:_onLoadUnlockCgCallback()
	self._unlockimagecgbg:SetNativeSize()
end

function DungeonMapEpisode:_onLoadLockCgCallback()
	self._lockimagecgbg:SetNativeSize()
end

function DungeonMapEpisode:_switchLayout(chapter)
	self:_disposeOldLayout()

	if self._chapterLayout then
		self._oldChapterLayout = self._chapterLayout
		self._chapterLayout = nil
	end

	if self._gochaptercontent then
		self._oldChapterContent = self._gochaptercontent
		self._gochaptercontent = nil
		self._oldChapterContent.name = "old"
	end

	if self._uiLoader then
		self._prevUILoader = self._uiLoader
		self._uiLoader = nil
	end

	if self._layoutCanvas then
		self._oldLayoutCanvas = self._layoutCanvas
		self._oldLayoutCanvas.blocksRaycasts = false
		self._oldLayoutCanvas.interactable = false
		self._layoutCanvas = nil
	end
end

function DungeonMapEpisode:_loadNewLayout(chapter)
	self._uiLoader = MultiAbLoader.New()

	local url = "ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab"

	self._uiLoader:addPath(url)
	self._uiLoader:startLoad(function(multiAbLoader)
		local assetItem = self._uiLoader:getAssetItem(url)
		local mainPrefab = assetItem:GetResource(url)

		self._gochaptercontent = gohelper.cloneInPlace(self._gochaptercontentitem, "#go_chaptercontent")

		gohelper.setAsLastSibling(self._gochaptercontent)
		gohelper.setActive(self._gochaptercontent, true)

		self._realscrollcontent.content = self._gochaptercontent.transform
		self._realscrollcontent.velocity = Vector2(0, 0)
		self._scrollcontent.horizontalNormalizedPosition = 0

		local uiGO = gohelper.clone(mainPrefab, self._gochaptercontent)
		local chapterLayout = DungeonMapChapterLayout.New()

		chapterLayout:initView(uiGO, {
			self._gochaptercontent,
			self.viewContainer:getMapTaskInfo(),
			self._scrollcontent,
			self,
			self._curChapter
		})

		self._chapterLayout = chapterLayout

		self._chapterLayout:onRefresh(self._jumpEpisodeId)

		self._jumpEpisodeId = nil
		self._layoutCanvas = self._gochaptercontent:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._targetTrans = uiGO.transform

		self:_layoutTweenFinish()
	end)
end

function DungeonMapEpisode:_layoutTweenFrame(value)
	self._layoutCanvas.alpha = value > 0.4 and (value - 0.4) / 0.6 or 0

	if self._oldLayoutCanvas then
		self._oldLayoutCanvas.alpha = value >= 0.6 and 0 or (0.6 - value) / 0.6
	end
end

function DungeonMapEpisode:_layoutTweenFinish()
	self._layoutCanvas.alpha = 1

	self:_disposeOldLayout()
end

function DungeonMapEpisode:_switchBg(chapter)
	local bgUrl = ResUrl.getDungeonChapterBg("chapter_" .. chapter)

	if not ((not self._bgUrl or self._bgUrl ~= bgUrl or nil) and true) then
		return
	end

	self:_disposeOldBg()

	DungeonModel.instance.chapterBgTweening = true
	self._olgBgCanvas.alpha = self._bgCanvas.alpha

	if self._bgGO then
		self._oldBgGO = self._bgGO
		self._bgGO = nil

		gohelper.addChild(self._gobgcontainerold, self._oldBgGO)
	end

	if self._bgCtrl then
		self._oldBgCtrl = self._bgCtrl
		self._bgCtrl = nil
	end

	if self._bgLoader then
		self._prevBgLoader = self._bgLoader
		self._bgLoader = nil
	end
end

function DungeonMapEpisode:_loadNewBg(chapter)
	local bgUrl = ResUrl.getDungeonChapterBg("chapter_" .. chapter)

	self._bgLoader = MultiAbLoader.New()

	self._bgLoader:addPath(bgUrl)
	self._bgLoader:startLoad(function(multiAbLoader)
		local bgItem = self._bgLoader:getAssetItem(bgUrl)
		local bgPrefab = bgItem:GetResource(bgUrl)

		self._bgGO = gohelper.clone(bgPrefab, self._gobgcontainer, "bg")
		self._bgCtrl = self._bgGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		self._bgUrl = bgUrl

		if self._oldBgGO then
			self._bgCanvas.alpha = 0
			self._bgTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._fadeTime, self._bgTweenFrame, self._bgTweenFinish, self, nil, EaseType.Linear)
		else
			self:_bgTweenFinish()
		end
	end)
end

function DungeonMapEpisode:_bgTweenFrame(value)
	self._bgCanvas.alpha = value > 0.4 and (value - 0.4) / 0.6 or 0
	self._olgBgCanvas.alpha = value >= 0.6 and 0 or (0.6 - value) / 0.6
end

function DungeonMapEpisode:_bgTweenFinish()
	DungeonModel.instance.chapterBgTweening = false
	self._bgCanvas.alpha = 1
	self._olgBgCanvas.alpha = 0

	self:_disposeOldBg()
end

function DungeonMapEpisode:_setEpisodeListVisible(value, sourceType)
	if not self._chapterLayout then
		return
	end

	if sourceType == DungeonEnum.EpisodeListVisibleSource.ToughBattle then
		return
	end

	self:_clearEpisodeListTween()

	local time = 0.2

	self._episodeListTweenId = value and ZProj.TweenHelper.DOAnchorPosY(self._chapterLayout.viewGO.transform, self._chapterLayout.defaultY, time) or ZProj.TweenHelper.DOAnchorPosY(self._chapterLayout.viewGO.transform, -260, time)
end

function DungeonMapEpisode:_clearEpisodeListTween()
	if self._episodeListTweenId then
		ZProj.TweenHelper.KillById(self._episodeListTweenId)

		self._episodeListTweenId = nil
	end
end

function DungeonMapEpisode:onUpdateParam()
	self._jumpEpisodeId = self.viewParam and self.viewParam.episodeId

	if self._chapterLayout then
		self._chapterLayout:setFocusEpisodeId(self._jumpEpisodeId, false, false)
	end

	self:_initChapterItem()
end

function DungeonMapEpisode:onOpen()
	self._chapterId = self.viewParam and self.viewParam.chapterId
	self._jumpEpisodeId = self.viewParam and self.viewParam.episodeId

	if not self._jumpEpisodeId and CommandStationController.instance:chapterInCommandStation(self._chapterId) then
		self._jumpEpisodeId = CommandStationController.instance:getRecordEpisodeId()

		CommandStationController.instance:setRecordEpisodeId(nil)
	end

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeChapter, self._onChangeChapter, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnJumpChangeFocusEpisodeItem, self._OnJumpChangeFocusEpisodeItem, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnClickFocusEpisode, self._onClickFocusEpisode, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUnlockNewChapter, self._startUnlockNewChapter, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnJumpEpisodeItemAndElement, self._OnJumpEpisodeItemAndElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeMap, self._OnChangeMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnNormalDungeonInitElements, self._initElements, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:_initChapterItem()
	self:_startUnlockNewChapter()
end

function DungeonMapEpisode:onOpenFinish()
	self._scrollcontent:AddOnValueChanged(self._onScrollValueChanged, self)
end

function DungeonMapEpisode:_tryShowFirstHelp(close)
	if not close and self.viewParam and self.viewParam.notOpenHelp then
		return
	end

	local chapterType = DungeonModel.instance.curChapterType

	if chapterType == DungeonEnum.ChapterType.Normal then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.Dungeon)
	end
end

function DungeonMapEpisode:_startUnlockNewChapter()
	if DungeonModel.instance.chapterTriggerNewChapter then
		return
	end

	if DungeonModel.instance.unlockNewChapterId then
		TaskDispatcher.runDelay(self._readyUnlockNewChapter, self, 0.3)
	end
end

function DungeonMapEpisode:_readyUnlockNewChapter()
	DungeonModel.instance.chapterTriggerNewChapter = true
end

function DungeonMapEpisode:_OnUnlockNewChapter()
	return
end

function DungeonMapEpisode:onClose()
	self._scrollcontent:RemoveOnValueChanged()
	DungeonAudio.instance:closeChapterAmbientSound(self._curChapterId)

	if self.viewContainer:isManualClose() then
		DungeonAudio.instance:closeChapter()
	end

	self:_clearEpisodeListTween()
end

function DungeonMapEpisode:_onOpenView(viewName)
	return
end

function DungeonMapEpisode:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		TaskDispatcher.runDelay(self.refreshRoleStoryBg, self, 0.3)
	end
end

function DungeonMapEpisode:_onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonStoryEntranceView then
		-- block empty
	end
end

function DungeonMapEpisode:_OnJumpChangeFocusEpisodeItem(episodeId)
	if self._chapterLayout then
		self._chapterLayout:changeFocusEpisodeItem(episodeId)
	end
end

function DungeonMapEpisode:_OnJumpEpisodeItemAndElement(episodeId, elementId)
	self._clickElementId = elementId

	TaskDispatcher.cancelTask(self._delayClickElement, self)
	TaskDispatcher.runDelay(self._delayClickElement, self, 0.1)
	self:_OnJumpChangeFocusEpisodeItem(episodeId)
end

function DungeonMapEpisode:_delayClickElement()
	local elementId = self._clickElementId

	self._clickElementId = nil

	if elementId then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, elementId)
	end
end

function DungeonMapEpisode:_OnChangeMap()
	TaskDispatcher.cancelTask(self._delayClickElement, self)
end

function DungeonMapEpisode:_initElements()
	self:_delayClickElement()
end

function DungeonMapEpisode:_onChangeChapter(chapter)
	self:changeChapter(chapter)
end

function DungeonMapEpisode:_onUpdateDungeonInfo(dungeonInfo)
	if self._chapterLayout then
		if CommandStationController.instance:chapterInCommandStation(self._chapterId) then
			self._chapterLayout:skipFocusItem(true)
		end

		self._chapterLayout:onRefresh()
		self._chapterLayout:skipFocusItem(false)
	end

	self:refreshRoleStoryBg()
end

function DungeonMapEpisode:_onClickFocusEpisode(dungeonEpisodeItem)
	self._realscrollcontent.enabled = false
	self._realscrollcontent.enabled = true

	if self._chapterLayout then
		self._chapterLayout:setFocusEpisodeItem(dungeonEpisodeItem, true)
	end

	self:_onChangeFocusEpisodeItem(dungeonEpisodeItem, true)
end

function DungeonMapEpisode:_onChangeFocusEpisodeItem(dungeonEpisodeItem, tween)
	if not DungeonModel.instance:chapterListIsRoleStory() then
		return
	end

	if not dungeonEpisodeItem or not self._chapterLayout then
		return
	end

	self:setCgIndex(dungeonEpisodeItem:getIndex(), self._chapterLayout:getEpisodeCount(), tween)
end

function DungeonMapEpisode:setCgIndex(index, count, tween)
	if not count or count <= 1 then
		count = 2
	end

	local bgWidth = recthelper.getWidth(self._unlockimagecgbg.transform)
	local screenWidth = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local widthOffset = math.abs(bgWidth - screenWidth)
	local posX = math.max(widthOffset * ((index - 1) / (count - 1)), 0)
	local left = widthOffset / 2
	local goPosX = left - posX

	if goPosX == self._cgTargetPos then
		return
	end

	self._cgTargetPos = goPosX

	if self.cgTweenId then
		ZProj.TweenHelper.KillById(self.cgTweenId)

		self.cgTweenId = nil
	end

	local offsetX = math.max(0.35 * ((index - 1) / (count - 1)), 0)

	self.bgCgCtrl:GetIndexProp(0, 2)

	local vector = self.bgCgCtrl.vector_03

	self.bgCgCtrl.vector_03 = Vector4.New(vector.x, vector.y, -offsetX, vector.w)

	self.bgCgCtrl:SetIndexProp(0, 2)

	if tween then
		self.cgTweenId = ZProj.TweenHelper.DOAnchorPosX(self._unlockimagecgbg.transform, goPosX, 0.8)
	else
		recthelper.setAnchorX(self._unlockimagecgbg.transform, goPosX)
	end
end

function DungeonMapEpisode:onDestroyView()
	if self.cgTweenId then
		ZProj.TweenHelper.KillById(self.cgTweenId)

		self.cgTweenId = nil
	end

	if self._uiLoader then
		self._uiLoader:dispose()
	end

	if self._bgLoader then
		self._bgLoader:dispose()
	end

	if self._chapterLayout then
		self._chapterLayout:destroyView()

		self._chapterLayout = nil
	end

	if self._audioScroll then
		self._audioScroll:dispose()

		self._audioScroll = nil
	end

	self:_disposeOldLayout()
	self:_disposeOldBg()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end

	if self._scrollTouchEventMgr then
		self._scrollTouchEventMgr:ClearAllCallback()

		self._scrollTouchEventMgr = nil
	end

	for i, v in ipairs(self._chapterLineItemList) do
		v:destroyView()
	end

	TaskDispatcher.cancelTask(self._onCheckVision, self)
	TaskDispatcher.cancelTask(self._onEndScroll, self)
	TaskDispatcher.cancelTask(self.refreshRoleStoryBg, self)
	TaskDispatcher.cancelTask(self._delaySetMask2D, self)
	TaskDispatcher.cancelTask(self._delayClickElement, self)

	if self._unlocksimagecgbg then
		self._unlocksimagecgbg:UnLoadImage()
	end

	if self._locksimagecgbg then
		self._locksimagecgbg:UnLoadImage()
	end
end

function DungeonMapEpisode:_disposeOldLayout()
	self._rectmask2D.enabled = false

	if self._prevUILoader then
		self._prevUILoader:dispose()

		self._prevUILoader = nil
	end

	if self._oldChapterLayout then
		self._oldChapterLayout:destroyView()

		self._oldChapterLayout = nil
	end

	if self._layoutTweenId then
		ZProj.TweenHelper.KillById(self._layoutTweenId)
	end

	if self._oldChapterContent then
		gohelper.destroy(self._oldChapterContent)

		self._oldChapterContent = nil
	end

	TaskDispatcher.cancelTask(self._delaySetMask2D, self)
	TaskDispatcher.runDelay(self._delaySetMask2D, self, 0)
end

function DungeonMapEpisode:_delaySetMask2D()
	self._rectmask2D.enabled = true
end

function DungeonMapEpisode:_disposeOldBg()
	if self._prevBgLoader then
		self._prevBgLoader:dispose()

		self._prevBgLoader = nil
	end

	if self._oldBgGO then
		gohelper.destroy(self._oldBgGO)

		self._oldBgGO = nil
	end

	self._oldBgCtrl = nil

	if self._bgTweenId then
		ZProj.TweenHelper.KillById(self._bgTweenId)
	end
end

return DungeonMapEpisode
