-- chunkname: @modules/logic/dungeon/view/DungeonSectionItem.lua

module("modules.logic.dungeon.view.DungeonSectionItem", package.seeall)

local DungeonSectionItem = class("DungeonSectionItem", ListScrollCellExtend)

function DungeonSectionItem:onInitView()
	self._simagechapterIcon = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon")
	self._gotip = gohelper.findChild(self.viewGO, "anim/#go_tip")
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#go_tip/#btn_tip")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#btn_play")
	self._goplayFinished = gohelper.findChild(self.viewGO, "anim/#btn_play/played")
	self._goplayNotFinished = gohelper.findChild(self.viewGO, "anim/#btn_play/unplay")
	self._goarrow = gohelper.findChild(self.viewGO, "anim/#go_arrow")
	self._golight = gohelper.findChild(self.viewGO, "anim/light")
	self._txttipnameen = gohelper.findChildText(self.viewGO, "anim/#go_tip/#txt_tipname_en")
	self._txttipname = gohelper.findChildText(self.viewGO, "anim/#go_tip/#txt_tipname")
	self._txtname = gohelper.findChildText(self.viewGO, "anim/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "anim/#txt_name_en")
	self._btncommandstation = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#btn_commandstation")
	self._gostorytrace = gohelper.findChild(self.viewGO, "anim/#go_trace")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonSectionItem:addEvents()
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
	self._btncommandstation:AddClickListener(self._btncommandstationOnClick, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonSectionItem:removeEvents()
	self._btntip:RemoveClickListener()
	self._btnplay:RemoveClickListener()
	self._btncommandstation:RemoveClickListener()
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonSectionItem:_btncommandstationOnClick()
	CommandStationController.instance:openCommandStationEnterView({
		fromDungeonSectionItem = true
	})
end

function DungeonSectionItem:setTipVisible(visible)
	self._showTip = visible

	gohelper.setActive(self._gotip, visible)
end

function DungeonSectionItem:_btnplayOnClick()
	StoryController.instance:playStory(self._mo.storyId, {
		mark = true,
		isVersionActivityPV = true
	}, self._updatePreviouslyOnStatus, self)
end

function DungeonSectionItem:externalClickTip()
	self:_btntipOnClick()
end

function DungeonSectionItem:_btntipOnClick()
	AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_close)
	DungeonMainStoryModel.instance:setSectionSelected((not self._isSelected or nil) and (self._mo.sectionId or nil), true)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function DungeonSectionItem:_btncategoryOnClick()
	if self._isSelected then
		AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_close)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_open)
	end

	DungeonMainStoryModel.instance:setSectionSelected((not self._isSelected or nil) and (self._mo.sectionId or nil), true)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function DungeonSectionItem:_editableInitView()
	gohelper.addUIClickAudio(self._btntip.gameObject, 0)

	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	local animGo = gohelper.findChild(self.viewGO, "anim")

	self._anim = SLFramework.AnimatorPlayer.Get(animGo)
	self._simagechapterIcon0 = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon/font")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon/bg")
	self._simagelight = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon/#simage_light")

	gohelper.setActive(self._btnplay, false)
	gohelper.setActive(self._btncommandstation, false)
end

function DungeonSectionItem:playOpenAnim()
	if self._hasPlayOpenAnim then
		return
	end

	self._hasPlayOpenAnim = true

	self:playAnimName("open")
end

function DungeonSectionItem:playAnimName(name)
	self._anim:Play(name, self._animDone, self)
end

function DungeonSectionItem:_animDone()
	return
end

function DungeonSectionItem:_editableAddEvents()
	self._click:AddClickListener(self._btncategoryOnClick, self)
	StoryController.instance:registerCallback(StoryEvent.Start, self._onStart, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._onFinish, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._newFuncUnlock, self)
end

function DungeonSectionItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.Start, self._onStart, self)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, self._onFinish, self)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, self._newFuncUnlock, self)
end

function DungeonSectionItem:_onStart(storyId)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		self._simagechapterIcon0:UnLoadImage()
		self._simagebg:UnLoadImage()
		self._simagelight:UnLoadImage()
	end
end

function DungeonSectionItem:_onFinish(storyId)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		self:_loadImgs()
	end
end

function DungeonSectionItem:_newFuncUnlock()
	self:_updateCommandStationStatus()
end

function DungeonSectionItem:_loadImgs()
	self._simagechapterIcon0:LoadImage(self._mo.resPage)
	self._simagebg:LoadImage(string.format("singlebg/dungeon/pic_section_backbg_%s.png", self._mo.sectionId))
	self._simagelight:LoadImage(string.format("singlebg/dungeon/pic_section_light_%s.png", self._mo.sectionId))
end

function DungeonSectionItem:onUpdateMO(mo)
	self._mo = mo
	self._isSelected = DungeonMainStoryModel.instance:sectionIsSelected(self._mo.sectionId)
	self._txtname.text = self._mo.name
	self._txttipname.text = self._mo.name
	self._txtnameen.text = self._mo.nameEn
	self._txttipnameen.text = self._mo.nameEn

	gohelper.setActive(self._txtname, not self._isSelected)
	gohelper.setActive(self._txtnameen, not self._isSelected)

	self._showTip = self._isSelected

	gohelper.setActive(self._gotip, false)

	if not self._isSetIcon then
		self._isSetIcon = true

		self:_loadImgs()
	end

	if self._isSelected then
		self:_calcTipLineWidth()
	end

	self:_updatePreviouslyOnStatus()
	self:_updateCommandStationStatus()
	gohelper.setActive(self._goarrow, self._isSelected)
	gohelper.setActive(self._simagelight, not self._isSelected)
	TaskDispatcher.cancelTask(self._delayShowTip, self)

	if self._showTip then
		TaskDispatcher.runDelay(self._delayShowTip, self, 0.1)
	end

	self:_initLight()
	self:_refreshTraced()
end

function DungeonSectionItem:_initLight()
	local transform = self._golight.transform
	local itemCount = transform.childCount

	for i = 1, itemCount do
		local child = transform:GetChild(i - 1)

		gohelper.setActive(child.gameObject, i == self._mo.sectionId)
	end
end

function DungeonSectionItem:_delayShowTip()
	self:setTipVisible(self._showTip)
end

function DungeonSectionItem:_updatePreviouslyOnStatus()
	local show = self._mo.storyId ~= 0 and DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1)

	gohelper.setActive(self._btnplay, show)

	if not show then
		return
	end

	local isFinished = StoryModel.instance:isStoryFinished(self._mo.storyId)

	gohelper.setActive(self._goplayNotFinished, not isFinished)
	gohelper.setActive(self._goplayFinished, isFinished)
end

function DungeonSectionItem:_updateCommandStationStatus()
	local showCommandStation = self._mo.sectionId == 3 and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation)

	gohelper.setActive(self._btncommandstation, showCommandStation)
end

function DungeonSectionItem:_addChapterIcon()
	if self._hasAddChapterIcon then
		return
	end

	self._hasAddChapterIcon = true
	self._simagechapterIcon1 = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon/1")
	self._simagechapterIcon2 = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon/2")
	self._simagechapterIcon3 = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_chapterIcon/3")

	local chapterList = DungeonMainStoryModel.instance:getChapterList(self._mo.sectionId)
	local index = 1

	for i = #chapterList, 1, -1 do
		local chapterConfig = chapterList[i]
		local isSpecialMainPlot = DungeonModel.instance:isSpecialMainPlot(chapterConfig.id)

		if not isSpecialMainPlot then
			local icon = self["_simagechapterIcon" .. index]

			if icon then
				icon:LoadImage(ResUrl.getDungeonIcon(chapterConfig.chapterpic))

				index = index + 1
			else
				break
			end
		end
	end

	for i = index, 3 do
		local icon = self["_simagechapterIcon" .. index]

		if icon then
			-- block empty
		else
			break
		end
	end
end

function DungeonSectionItem:_calcTipLineWidth()
	local sectionId = self._mo.sectionId
	local chapterList = DungeonMainStoryModel.instance:getChapterList(sectionId)
	local width = DungeonMainStoryEnum.ChapterWidth.Section + DungeonMainStoryEnum.ChapterStartPosX + DungeonMainStoryEnum.TipLineWidthOffsetX

	for i, v in ipairs(chapterList) do
		local isSpecialMainPlot = DungeonModel.instance:isSpecialMainPlot(v.id)

		width = width + ((isSpecialMainPlot or nil) and (DungeonMainStoryEnum.ChapterWidth.Special or DungeonMainStoryEnum.ChapterWidth.Normal))
	end

	recthelper.setWidth(self._btntip.transform, width)

	self._lineWidth = width
end

function DungeonSectionItem:getLineWidth()
	return self._lineWidth
end

function DungeonSectionItem:getSectionId()
	return self._mo.sectionId
end

function DungeonSectionItem:getSectionName()
	return self._mo.name
end

function DungeonSectionItem:getSectionNameEn()
	return self._mo.nameEn
end

function DungeonSectionItem:setPosX(posX)
	self._posX = posX
end

function DungeonSectionItem:getPosX()
	return self._posX
end

function DungeonSectionItem:setUnFoldPosX(posX)
	self._unfoldPosX = posX
end

function DungeonSectionItem:getUnFoldPosX()
	return self._unfoldPosX
end

function DungeonSectionItem:moveToUnFoldPosX()
	self:_clearTween()

	local posX = recthelper.getAnchorX(self.viewGO.transform.parent)

	if posX ~= self._unfoldPosX then
		self._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(self.viewGO.transform.parent, self._unfoldPosX, DungeonMainStoryEnum.SectionAnimTime)
	end
end

function DungeonSectionItem:moveToPosX()
	self:_clearTween()

	local posX = recthelper.getAnchorX(self.viewGO.transform.parent)

	if posX ~= self._posX then
		self._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(self.viewGO.transform.parent, self._posX, DungeonMainStoryEnum.SectionAnimTime)
	end
end

function DungeonSectionItem:_clearTween()
	if self._tweenPosX then
		ZProj.TweenHelper.KillById(self._tweenPosX)

		self._tweenPosX = nil
	end
end

function DungeonSectionItem:onSelect(isSelect)
	return
end

function DungeonSectionItem:onDestroyView()
	self:_clearTween()
	TaskDispatcher.cancelTask(self._delayShowTip, self)
end

function DungeonSectionItem:_refreshTraced()
	self:_refreshTracedIcon()
end

function DungeonSectionItem:_refreshTracedIcon()
	if not self._mo then
		return
	end

	local isTrade = CharacterRecommedModel.instance:isTradeSection(self._mo.sectionId)

	if isTrade then
		local tradeIconPrefab = CharacterRecommedController.instance:getTradeIcon()

		if not tradeIconPrefab then
			return
		end

		self._tracedIcon = self._tracedIcon or gohelper.clone(tradeIconPrefab, self._gostorytrace)
	end

	if self._tracedIcon then
		gohelper.setActive(self._tracedIcon, isTrade)
	end
end

return DungeonSectionItem
