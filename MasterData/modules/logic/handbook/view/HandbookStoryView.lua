-- chunkname: @modules/logic/handbook/view/HandbookStoryView.lua

module("modules.logic.handbook.view.HandbookStoryView", package.seeall)

local HandbookStoryView = class("HandbookStoryView", BaseView)

function HandbookStoryView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goline = gohelper.findChild(self.viewGO, "#scroll_storylist/viewport/content/linelayout/#go_line")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_switch")
	self._gochapteritem = gohelper.findChild(self.viewGO, "#scroll_chapterlist/viewport/content/#go_chapteritem")
	self._scrollchapterlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_chapterlist")
	self._transcontentchapterlist = gohelper.findChild(self.viewGO, "#scroll_chapterlist/viewport/content").transform
	self._scrollstorylist = gohelper.findChildScrollRect(self.viewGO, "#scroll_storylist")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookStoryView:addEvents()
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
end

function HandbookStoryView:removeEvents()
	self._btnswitch:RemoveClickListener()
end

function HandbookStoryView:_btnswitchOnClick()
	HandbookController.instance:openCGView()
end

function HandbookStoryView:_editableInitView()
	self._goStoryListContent = gohelper.findChild(self.viewGO, "#scroll_storylist/viewport/content")

	gohelper.setActive(self._gochapteritem, false)

	self._chapterItemList = {}
	self._storyItemList = self:getUserDataTb_()
	self._delayStoryAnimList = self:getUserDataTb_()

	gohelper.setActive(self._goline.gameObject, false)

	self._lineSingleImageList = self:getUserDataTb_()
	self._lineAnimList = self:getUserDataTb_()

	self._simagebg:LoadImage(ResUrl.getStoryBg("story_bg/bg/huashengdunguangchang.jpg"))

	self.itemPrefab = self:_getStoryItemPrefab()

	gohelper.addUIClickAudio(self._btnswitch.gameObject, AudioEnum.UI.play_ui_screenplay_plot_switch)
end

function HandbookStoryView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._playLineAnim = true

	self:_refreshUI()

	if self.viewParam then
		self._selectChapter = self.viewParam

		self:_openselectItem()
		self:_focusItem()
	end
end

function HandbookStoryView:_openselectItem()
	local item = self._chapterItemList[self._selectChapter]

	self:_btnclickOnClick(item)
end

function HandbookStoryView:_focusItem()
	local height = recthelper.getHeight(self._scrollchapterlist.transform)
	local selectItemHeight = 150
	local unselectItemHeight = 120
	local itemcount = #self._chapterItemList
	local contentheight = (itemcount - 1) * unselectItemHeight + selectItemHeight
	local remainHeight = contentheight - height

	if remainHeight >= (self._selectChapter - 1) * unselectItemHeight then
		recthelper.setAnchorY(self._transcontentchapterlist, (self._selectChapter - 1) * unselectItemHeight)
	else
		recthelper.setAnchorY(self._transcontentchapterlist, remainHeight)
	end
end

function HandbookStoryView:_getStoryItemPrefab()
	local container = ViewMgr.instance:getContainer(ViewName.HandbookStoryView)
	local itemPrefabPath = container:getSetting().otherRes[1]

	return (container._abLoader:getAssetItem(itemPrefabPath):GetResource())
end

function HandbookStoryView:onOpenFinish()
	self._anim.enabled = true
end

function HandbookStoryView:_onOpenViewFinish(viewName)
	if viewName == ViewName.HandbookCGView then
		ViewMgr.instance:closeView(ViewName.HandbookStoryView, true)
	end
end

function HandbookStoryView:_refreshLine(storyGroupCount)
	local contentWidth = 170 + storyGroupCount * 480 - 58 * (storyGroupCount - 1)
	local lineWidth = recthelper.getWidth(self._goline.transform)
	local count = math.ceil(contentWidth / lineWidth)

	for i = 1, count do
		local simageline = self._lineSingleImageList[i]

		if not simageline then
			local go = gohelper.cloneInPlace(self._goline, "item" .. i)
			local lineAnim = go:GetComponent(typeof(UnityEngine.Animation))

			simageline = gohelper.getSingleImage(go)

			simageline:LoadImage(ResUrl.getHandbookBg("bg_timeline"))
			table.insert(self._lineSingleImageList, simageline)
			table.insert(self._lineAnimList, lineAnim)
		end

		gohelper.setActive(simageline.gameObject, true)

		if self._playLineAnim then
			self._lineAnimList[i]:Play()

			self._playLineAnim = false
		end
	end

	for i = count + 1, #self._lineSingleImageList do
		local simageline = self._lineSingleImageList[i]

		gohelper.setActive(simageline.gameObject, false)
		self._lineAnimList[i]:Stop()
	end
end

function HandbookStoryView:_refreshUI()
	local storyChapterIdList = {}
	local storyChapterList = HandbookConfig.instance:getStoryChapterList()

	for _, storyChapterConfig in pairs(storyChapterList) do
		local storyGroupCount = HandbookModel.instance:getStoryGroupUnlockCount(storyChapterConfig.id)

		if storyGroupCount > 0 then
			table.insert(storyChapterIdList, storyChapterConfig.id)
		end
	end

	for i = 1, #storyChapterIdList do
		local storyChapterId = storyChapterIdList[i]
		local chapterItem = self._chapterItemList[i]

		if not chapterItem then
			chapterItem = self:getUserDataTb_()
			chapterItem.go = gohelper.cloneInPlace(self._gochapteritem, "item" .. i)
			chapterItem.gobeselected = gohelper.findChild(chapterItem.go, "beselected")
			chapterItem.gounselected = gohelper.findChild(chapterItem.go, "unselected")
			chapterItem.chapternamecn1 = gohelper.findChildText(chapterItem.go, "beselected/chapternamecn")
			chapterItem.chapternameen1 = gohelper.findChildText(chapterItem.go, "beselected/chapternameen")
			chapterItem.chapternamecn2 = gohelper.findChildText(chapterItem.go, "unselected/chapternamecn")
			chapterItem.chapternameen2 = gohelper.findChildText(chapterItem.go, "unselected/chapternameen")
			chapterItem.btnclick = gohelper.findChildButtonWithAudio(chapterItem.go, "btnclick", AudioEnum.UI.Play_UI_Universal_Click)

			chapterItem.btnclick:AddClickListener(self._btnclickOnClick, self, chapterItem)
			table.insert(self._chapterItemList, chapterItem)
		end

		chapterItem.storyChapterId = storyChapterId

		local storyChapterConfig = HandbookConfig.instance:getStoryChapterConfig(storyChapterId)

		chapterItem.chapternamecn1.text = storyChapterConfig.name
		chapterItem.chapternamecn2.text = storyChapterConfig.name
		chapterItem.chapternameen1.text = storyChapterConfig.nameEn
		chapterItem.chapternameen2.text = storyChapterConfig.nameEn

		gohelper.setActive(chapterItem.go, true)
	end

	for i = #storyChapterIdList + 1, #self._chapterItemList do
		local chapterItem = self._chapterItemList[i]

		gohelper.setActive(chapterItem.go, false)
	end

	if #self._chapterItemList > 0 then
		self:_btnclickOnClick(self._chapterItemList[1])
	else
		HandbookStoryListModel.instance:clearStoryList()
	end
end

function HandbookStoryView:_btnclickOnClick(chapterItem)
	local storyChapterId = chapterItem.storyChapterId
	local storyGroupList = HandbookConfig.instance:getStoryGroupList()

	HandbookStoryListModel.instance:setStoryList(storyGroupList, storyChapterId)

	for _, chapterItem in ipairs(self._chapterItemList) do
		gohelper.setActive(chapterItem.gobeselected, storyChapterId == chapterItem.storyChapterId)
		gohelper.setActive(chapterItem.gounselected, storyChapterId ~= chapterItem.storyChapterId)
	end

	local storyGroupCount = HandbookModel.instance:getStoryGroupUnlockCount(storyChapterId)

	self:_refreshLine(storyGroupCount)

	self._scrollstorylist.horizontalNormalizedPosition = 0

	self:_cloneStoryItem()
end

function HandbookStoryView:_cloneStoryItem()
	self:_stopStoryItemEnterAnim()

	local storyItemMoList = HandbookStoryListModel.instance:getStoryList()

	self.storyItemMoList = storyItemMoList

	for k, v in ipairs(storyItemMoList) do
		local storyItemGO = self._storyItemList[k]

		if not storyItemGO then
			storyItemGO = {
				go = gohelper.clone(self.itemPrefab, self._goStoryListContent, "item" .. k)
			}
			storyItemGO.anim = storyItemGO.go:GetComponent(typeof(UnityEngine.Animator))
			storyItemGO.item = MonoHelper.addNoUpdateLuaComOnceToGo(storyItemGO.go, HandbookStoryItem, self)
			storyItemGO.anim.enabled = false

			table.insert(self._storyItemList, storyItemGO)
		end

		gohelper.setActive(storyItemGO.go, false)
		storyItemGO.item:onInitView(storyItemGO.go)
		storyItemGO.item:onUpdateMO(v)
	end

	self.playedAnimIndex = 0

	self:_showStoryItemEnterAnim()
end

function HandbookStoryView:_stopStoryItemEnterAnim()
	TaskDispatcher.cancelTask(self._showStoryItemEnterAnim, self)

	for _, storyItem in ipairs(self._storyItemList) do
		storyItem.anim.enabled = false

		gohelper.setActive(storyItem.go, false)
	end
end

function HandbookStoryView:_showStoryItemEnterAnim()
	if self.playedAnimIndex >= #self.storyItemMoList then
		return
	end

	self.playedAnimIndex = self.playedAnimIndex + 1

	gohelper.setActive(self._storyItemList[self.playedAnimIndex].go, true)

	self._storyItemList[self.playedAnimIndex].anim.enabled = true

	TaskDispatcher.runDelay(self._showStoryItemEnterAnim, self, 0.03)
end

function HandbookStoryView:onClose()
	TaskDispatcher.cancelTask(self._showStoryItemEnterAnim, self)
end

function HandbookStoryView:onDestroyView()
	for _, simageline in ipairs(self._lineSingleImageList) do
		simageline:UnLoadImage()
	end

	for _, chapterItem in ipairs(self._chapterItemList) do
		chapterItem.btnclick:RemoveClickListener()
	end

	self._simagebg:UnLoadImage()
end

return HandbookStoryView
