-- chunkname: @modules/logic/turnback/view/new/view/TurnbackReviewView.lua

module("modules.logic.turnback.view.new.view.TurnbackReviewView", package.seeall)

local TurnbackReviewView = class("TurnbackReviewView", BaseView)

function TurnbackReviewView:onInitView()
	self._scrollTabList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TabList")
	self._gotabitem = gohelper.findChild(self.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem")
	self._trstabitemContent = gohelper.findChild(self.viewGO, "#scroll_TabList/Viewport/Content").transform
	self._txtunlocktab = gohelper.findChildText(self.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/Unlock/#txt_unlocktab")
	self._txtlockedtab = gohelper.findChildText(self.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/Locked/#txt_lockedtab")
	self._goreddot = gohelper.findChild(self.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/#go_reddot")
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagecgold = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#simage_cgold")
	self._simagezoneold = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#simage_cgold/masknode/#simage_zoneold")
	self._gomasknodeold = gohelper.findChild(self.viewGO, "#go_ui/#simage_cgold/masknode")
	self._simagecg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#simage_cg")
	self._simagezone = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#simage_cg/masknode/#simage_zone")
	self._gomasknode = gohelper.findChild(self.viewGO, "#go_ui/#simage_cg/masknode")
	self._godrag = gohelper.findChild(self.viewGO, "#go_ui/#btn_click/#go_drag")
	self._btnprev = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_prev")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_next")
	self._txtchapter = gohelper.findChildText(self.viewGO, "#go_ui/desc/#txt_chapter")
	self._txttitleName = gohelper.findChildText(self.viewGO, "#go_ui/desc/#txt_titleName")
	self._txttitleNameEn = gohelper.findChildText(self.viewGO, "#go_ui/desc/#txt_titleNameEn")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_ui/desc/#txt_desc")
	self._btnpage = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/page/btn")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_ui/page/#txt_curindex")
	self._txttotalpage = gohelper.findChildText(self.viewGO, "#go_ui/page/#txt_curindex/#txt_totalpage")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_goto")
	self._txtcurchapter = gohelper.findChildText(self.viewGO, "#go_ui/#btn_goto/#txt_curchapter")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_ui/#go_btns")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._cgType = HandbookEnum.CGType.Dungeon
	self._topItemList = {}
	self._selectChapter = 1
	self.centerBannerPosX = 0

	if self._editableInitView then
		self:_editableInitView()
	end
end

TurnbackReviewView.bannerWidth = 1420
TurnbackReviewView.moveDistance = 100
TurnbackReviewView.LayoutSpace = 100

function TurnbackReviewView:addEvents()
	self._btnprev:AddClickListener(self._btnprevOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnpage:AddClickListener(self._btnpageOnClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.onDungeonUpdate, self)
end

function TurnbackReviewView:removeEvents()
	self._btnprev:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btnpage:RemoveClickListener()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.onDungeonUpdate, self)
end

function TurnbackReviewView:_btnpageOnClick()
	if not string.nilorempty(self._lastEpisodeId) then
		local str = "17#3#" .. self._selectChapter

		JumpController.instance:jumpTo(str)
	end
end

function TurnbackReviewView:_btngotoOnClick()
	if not string.nilorempty(self._jumpEpisodeId) then
		local str = JumpEnum.JumpView.DungeonViewWithEpisode .. "#" .. self._jumpEpisodeId

		JumpController.instance:jumpTo(str)
		TaskDispatcher.cancelTask(self.autoSwitch, self)
	end
end

function TurnbackReviewView:_editableInitView()
	self._cimagecg = self._simagecg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	self._imageZone = gohelper.findChildImage(self.viewGO, "#go_ui/#simage_cg/masknode/#simage_zone")
	self._cimagecgold = self._simagecgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	self._imageZoneOld = gohelper.findChildImage(self.viewGO, "#go_ui/#simage_cgold/masknode/#simage_zoneold")

	gohelper.setActive(self._simagecg.gameObject, false)
	gohelper.setActive(self._simagecgold.gameObject, false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	gohelper.addUIClickAudio(self._btnprev.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
	gohelper.addUIClickAudio(self._btnnext.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	self.loadedCgList = {}
end

function TurnbackReviewView:_onDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x
end

function TurnbackReviewView:_onDragEnd(param, pointerEventData)
	local endPos = pointerEventData.position.x

	if endPos > self._startPos and endPos - self._startPos >= 100 then
		self:_btnprevOnClick(true)
	elseif endPos < self._startPos and self._startPos - endPos >= 100 then
		self:_btnnextOnClick(true)
	end
end

function TurnbackReviewView:_focusItem()
	local width = recthelper.getWidth(self._scrollTabList.transform)
	local itemWidth = 428
	local itemcount = #self._topItemList
	local contentWidth = itemcount * itemWidth
	local remainWidth = contentWidth - width

	if remainWidth < 0 then
		return
	end

	if remainWidth >= (self._selectChapter - 1) * itemWidth then
		ZProj.TweenHelper.DOAnchorPosX(self._trstabitemContent, -(self._selectChapter - 1) * itemWidth, 0.26)
	else
		ZProj.TweenHelper.DOAnchorPosX(self._trstabitemContent, -remainWidth, 0.26)
	end
end

function TurnbackReviewView:_btnprevOnClick(isDrag)
	local firstCGId, _ = self:getFirstCGIdAndEpisodeId(self._selectChapter)

	if firstCGId == self._cgId then
		if self._selectChapter ~= self._unlockChapterList[1] then
			self._selectChapter = self._selectChapter - 1

			if self._selectChapter == 7 then
				self._selectChapter = self._selectChapter - 1
			end
		else
			self._selectChapter = self._unlockChapterList[#self._unlockChapterList]
		end

		self:_focusItem()
	end

	local prevCGConfig = HandbookModel.instance:getPrevCG(self._cgId, self._cgType)

	if not prevCGConfig then
		return
	end

	self._cgId = prevCGConfig.id
	self._episodeId = prevCGConfig.episodeId
	self._cimagecg.enabled = false
	self._cimagecgold.enabled = false

	gohelper.setActive(self._gomasknode, false)
	gohelper.setActive(self._gomasknodeold, false)
	self:_refreshTop()

	if isDrag then
		self._animator:Play("switch_right", 0, 0)
	else
		self._animator:Play("switch_left", 0, 0)
	end

	TaskDispatcher.runDelay(self._afterPlayAnim, self, 0.16)
end

function TurnbackReviewView:_afterPlayAnim()
	TaskDispatcher.cancelTask(self.autoSwitch, self)
	TaskDispatcher.cancelTask(self._afterPlayAnim, self)

	self._cimagecg.enabled = true
	self._cimagecgold.enabled = true

	gohelper.setActive(self._gomasknode, true)
	gohelper.setActive(self._gomasknodeold, true)
	self:_refreshUI()
	self:autoMoveBanner()
end

function TurnbackReviewView:_btnnextOnClick(isDrag)
	local currentChapterList = HandbookConfig.instance:getCGDictByChapter(self._selectChapter, self._cgType)
	local lastCGId = currentChapterList[#currentChapterList].id
	local isLast = false

	if self._selectChapter ~= self._unlockChapterList[#self._unlockChapterList] then
		if lastCGId == self._cgId then
			self._selectChapter = self._selectChapter + 1

			if self._selectChapter == 7 then
				self._selectChapter = self._selectChapter + 1
			end

			self:_focusItem()
		end
	else
		local unlockcount = HandbookModel.instance:getCGUnlockCount(self._selectChapter, self._cgType)
		local curIndex = HandbookModel.instance:getCGUnlockIndexInChapter(self._selectChapter, self._cgId, self._cgType)

		if unlockcount == curIndex then
			isLast = true
			self._selectChapter = 1
			currentChapterList = HandbookConfig.instance:getCGDictByChapter(self._selectChapter, self._cgType)
			self._cgId = currentChapterList[1].id

			self:_focusItem()
		end
	end

	local nextCGConfig = HandbookModel.instance:getNextCG(self._cgId, self._cgType)

	if isLast then
		nextCGConfig = HandbookConfig.instance:getCGConfig(self._cgId)
	end

	if not nextCGConfig then
		return
	end

	self._cgId = nextCGConfig.id
	self._episodeId = nextCGConfig.episodeId
	self._cimagecg.enabled = false
	self._cimagecgold.enabled = false

	gohelper.setActive(self._gomasknode, false)
	gohelper.setActive(self._gomasknodeold, false)
	self:_refreshTop()

	if isDrag then
		self._animator:Play("switch_left", 0, 0)
	else
		self._animator:Play("switch_right", 0, 0)
	end

	TaskDispatcher.runDelay(self._afterPlayAnim, self, 0.16)
end

function TurnbackReviewView:_initTop()
	self._chapterList = {}
	self._cgConfigList = HandbookConfig.instance:getCGList(self._cgType)
	self._unlockChapterList = {}
	self._dungeonChapterList = {}
	self._dungeonChapterDict = HandbookConfig.instance:getCGDict(self._cgType)

	for i, config in ipairs(self._cgConfigList) do
		if HandbookModel.instance:isCGUnlock(config.id) then
			local storyChapterId = config.storyChapterId

			if not tabletool.indexOf(self._unlockChapterList, storyChapterId) then
				table.insert(self._unlockChapterList, storyChapterId)

				if #self._unlockChapterList == tabletool.len(self._dungeonChapterDict) then
					break
				end
			end
		end
	end

	for _, storyChapterId in pairs(self._unlockChapterList) do
		local config = HandbookConfig.instance:getStoryChapterConfig(storyChapterId)

		table.insert(self._dungeonChapterList, config)
	end

	self._selectChapter = self._unlockChapterList[#self._unlockChapterList]
	self._cgId, self._episodeId = self:getFirstCGIdAndEpisodeId(self._selectChapter)

	for index, co in ipairs(self._dungeonChapterList) do
		local item = self._topItemList[index]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._gotabitem, "chapter" .. co.id)

			gohelper.setActive(item.go, true)

			item.config = co
			item.chapterId = co.id
			item.golock = gohelper.findChild(item.go, "Locked")
			item.txtlockname = gohelper.findChildText(item.go, "Locked/#txt_lockedtab")
			item.gounlock = gohelper.findChild(item.go, "Unlock")
			item.goselected = gohelper.findChild(item.go, "Unlock/image_Selected")
			item.gonormal = gohelper.findChild(item.go, "Unlock/image_Normal")
			item.txtunlockname = gohelper.findChildText(item.go, "Unlock/#txt_unlocktab")
			item.btn = gohelper.findChildButton(item.go, "btn_click")

			item.btn:AddClickListener(self._btnTopOnClick, self, item)
			table.insert(self._topItemList, item)
		end

		item.txtlockname.text = co.name
		item.txtunlockname.text = co.name
		item.unlock = self:checkDungeonUnlock(item.chapterId)

		gohelper.setActive(item.gounlock, item.unlock)
		gohelper.setActive(item.golock, not item.unlock)

		local isSelect = item.chapterId == self._selectChapter

		gohelper.setActive(item.goselected, isSelect)
		gohelper.setActive(item.gonormal, not isSelect)
	end
end

function TurnbackReviewView:_btnTopOnClick(item)
	if not item.unlock then
		return
	end

	local chapter = item.chapterId

	self._selectChapter = chapter
	self._cgId, self._episodeId = self:getFirstCGIdAndEpisodeId(chapter)

	self:_refreshTop()
	self:_refreshUI()
	self:_focusItem()
	self:autoMoveBanner()
end

function TurnbackReviewView:getEpisodeName(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig then
		::label_15_0::

		local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if not episodeConfig or not chapterConfig then
			return nil
		end

		local name = episodeConfig.name

		if string.nilorempty(name) then
			local chainEpisodeDict = DungeonConfig.instance:getChainEpisodeDict()

			for chainEpisodeId, id in pairs(chainEpisodeDict) do
				if chainEpisodeId == episodeId then
					episodeConfig = DungeonConfig.instance:getEpisodeCO(id)
					chapterConfig = episodeConfig and DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
				end
			end
		end

		local chapterIndex = chapterConfig.chapterIndex
		local episodeIndex, type = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)

		self._jumpEpisodeId = not self._jumpEpisodeId and episodeConfig.id or self._lastEpisodeId

		return string.format("%s-%s %s", chapterIndex, episodeIndex, episodeConfig.name)
	end
end

function TurnbackReviewView:getFirstCGIdAndEpisodeId(chapter)
	local configList = HandbookConfig.instance:getCGDictByChapter(chapter, self._cgType)
	local cgId = configList[1].id
	local episodeId = configList[1].episodeId

	return cgId, episodeId
end

function TurnbackReviewView:checkDungeonUnlock(chapterId)
	for index, unlockId in ipairs(self._unlockChapterList) do
		if unlockId == chapterId then
			return true
		end
	end

	return false
end

function TurnbackReviewView:_refreshTop()
	for index, item in ipairs(self._topItemList) do
		local isSelect = item.chapterId == self._selectChapter

		gohelper.setActive(item.goselected, isSelect)
		gohelper.setActive(item.gonormal, not isSelect)
	end
end

function TurnbackReviewView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:_initTop()
	self:_refreshUI()
	self:_initRightBtn()
	self:_focusItem()
	self:autoMoveBanner()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_paiqian_open)
end

function TurnbackReviewView:_initRightBtn()
	self._jumpEpisodeId = nil
	self.playerInfo = PlayerModel.instance:getPlayinfo()
	self._lastEpisodeId = self.playerInfo.lastEpisodeId
	self._txtcurchapter.text = self:getEpisodeName(self._lastEpisodeId)
end

function TurnbackReviewView:_refreshUI()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	UIBlockMgr.instance:startBlock("loadZone")

	if bgZoneMo then
		self._simagezone:LoadImage(ResUrl.getStoryRes(bgZoneMo.path), self._onZoneImageLoaded, self)
	else
		gohelper.setActive(self._simagezone.gameObject, false)

		self._cimagecg.vecInSide = Vector4.zero

		self:_startLoadOriginImg()
	end

	self._txttitleName.text = cgConfig.name
	self._txttitleNameEn.text = cgConfig.nameEn
	self._txtdesc.text = cgConfig.desc
	self._txtcurindex.text = HandbookModel.instance:getCGUnlockIndexInChapter(self._selectChapter, self._cgId, self._cgType)
	self._txttotalpage.text = "/" .. HandbookModel.instance:getCGUnlockCount(self._selectChapter, self._cgType)
	self._txtchapter.text = self:getEpisodeName(self._episodeId)
end

function TurnbackReviewView:_startLoadOriginImg()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)

	self._simagecg:LoadImage(self:getImageName(cgConfig), self.onLoadedImage, self)
end

function TurnbackReviewView:_onZoneImageLoaded()
	self._imageZone:SetNativeSize()
	self:_startLoadOriginImg()
end

function TurnbackReviewView:getImageName(cgConfig)
	if not tabletool.indexOf(self.loadedCgList, cgConfig.id) then
		table.insert(self.loadedCgList, cgConfig.id)
	end

	self.lastLoadImageId = cgConfig.id

	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		return ResUrl.getStoryRes(bgZoneMo.sourcePath)
	end

	return ResUrl.getStoryBg(cgConfig.image)
end

function TurnbackReviewView:onLoadedImage()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		gohelper.setActive(self._simagezone.gameObject, true)
		transformhelper.setLocalPosXY(self._simagezone.gameObject.transform, bgZoneMo.offsetX, bgZoneMo.offsetY)

		local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
		local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

		self._cimagecg.vecInSide = Vector4(recthelper.getWidth(self._imageZone.transform), recthelper.getHeight(self._imageZone.transform), bgZoneMo.offsetX, bgZoneMo.offsetY)

		self:_loadOldZoneImage()
	else
		gohelper.setActive(self._simagezoneold.gameObject, false)
		self:_startLoadOldImg()
	end

	gohelper.setActive(self._simagecg.gameObject, true)

	if #self.loadedCgList <= 10 then
		return
	end

	self.loadedCgList = {
		self.lastLoadImageId
	}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)
end

function TurnbackReviewView:_loadOldZoneImage()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		self._simagezoneold:LoadImage(ResUrl.getStoryRes(bgZoneMo.path), self._onZoneImageOldLoaded, self)
	else
		gohelper.setActive(self._simagezoneold.gameObject, false)

		self._cimagecgold.vecInSide = Vector4.zero

		self:_startLoadOldImg()
	end
end

function TurnbackReviewView:_onZoneImageOldLoaded()
	self._imageZoneOld:SetNativeSize()
	self:_startLoadOldImg()
end

function TurnbackReviewView:_startLoadOldImg()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)

	self._simagecgold:LoadImage(self:getImageName(cgConfig), self._onLoadOldFinished, self)
end

function TurnbackReviewView:_onLoadOldFinished()
	UIBlockMgr.instance:endBlock("loadZone")

	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		gohelper.setActive(self._simagezoneold.gameObject, true)
		transformhelper.setLocalPosXY(self._simagezoneold.gameObject.transform, bgZoneMo.offsetX, bgZoneMo.offsetY)

		local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
		local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

		self._cimagecgold.vecInSide = Vector4(recthelper.getWidth(self._imageZoneOld.transform), recthelper.getHeight(self._imageZoneOld.transform), bgZoneMo.offsetX, bgZoneMo.offsetY)
	end

	gohelper.setActive(self._simagecg.gameObject, false)
	gohelper.setActive(self._simagecgold.gameObject, true)
end

function TurnbackReviewView:autoMoveBanner()
	TaskDispatcher.cancelTask(self.autoSwitch, self)
	TaskDispatcher.runRepeat(self.autoSwitch, self, 3)
end

function TurnbackReviewView:autoSwitch()
	self:_btnnextOnClick()
end

function TurnbackReviewView:onDungeonUpdate()
	self:_initTop()
	self:_refreshUI()
	self:_initRightBtn()
	self:_focusItem()
	self:autoMoveBanner()
end

function TurnbackReviewView:onClose()
	UIBlockMgr.instance:endBlock("loadZone")
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()

	for index, item in ipairs(self._topItemList) do
		item.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self._afterPlayAnim, self)
end

function TurnbackReviewView:onDestroyView()
	self._simagecg:UnLoadImage()
	TaskDispatcher.cancelTask(self.autoSwitch, self)
	TaskDispatcher.cancelTask(self._afterPlayAnim, self)
end

return TurnbackReviewView
