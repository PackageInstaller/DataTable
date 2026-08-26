-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonbase/view/VersionActivity1_2DungeonMapEpisodeBaseView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapEpisodeBaseView", package.seeall)

local VersionActivity1_2DungeonMapEpisodeBaseView = class("VersionActivity1_2DungeonMapEpisodeBaseView", BaseView)

function VersionActivity1_2DungeonMapEpisodeBaseView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_versionActivityBg/#simage_bg")
	self._simagehardbg = gohelper.findChildSingleImage(self.viewGO, "#go_versionActivityBg/#simage_hardbg")
	self._gobgcanvas = gohelper.findChild(self.viewGO, "bgcanvas")
	self._gobgcontainerold = gohelper.findChild(self.viewGO, "bgcanvas/#go_bgcontainerold")
	self._gobgcontainer = gohelper.findChild(self.viewGO, "bgcanvas/#go_bgcontainer")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._gochaptercontentitem = gohelper.findChild(self.viewGO, "#scroll_content/#go_chaptercontentitem")
	self._btnstorymode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#btn_storyMode")
	self._btnhardmode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#btn_hardMode")
	self._imgstorymode = gohelper.findChildImage(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon")
	self._txtstorymodeCn = gohelper.findChildText(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/txt")
	self._txtstorymodeEn = gohelper.findChildText(self.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/txten")
	self._imghardmode = gohelper.findChildImage(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon")
	self._txthardmodeCn = gohelper.findChildText(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txt")
	self._txthardmodeEn = gohelper.findChildText(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txten")
	self._aniExcessive = gohelper.findChildComponent(self.viewGO, "#go_excessive", typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2DungeonMapEpisodeBaseView:addEvents()
	self._btnstorymode:AddClickListener(self.btnStoryModeClick, self)
	self._btnhardmode:AddClickListener(self.btnHardModeClick, self)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:removeEvents()
	self._btnstorymode:RemoveClickListener()
	self._btnhardmode:RemoveClickListener()
end

VersionActivity1_2DungeonMapEpisodeBaseView.ModeSelectColor = Color.white
VersionActivity1_2DungeonMapEpisodeBaseView.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)

function VersionActivity1_2DungeonMapEpisodeBaseView:btnStoryModeClick()
	self:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Story)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:btnHardModeClick()
	local isOpen, _ = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)

	if not isOpen then
		GameFacade.showToast(ToastEnum.ActivityHardDugeonLockedWithOpenTime)

		return
	end

	if not VersionActivityDungeonController.instance:isOpenHardModeFirstEpisode() then
		GameFacade.showToast(ToastEnum.ActivityHardDugeonLockedWithPassNormal)

		return
	end

	self:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:changeEpisodeMode(mode)
	if mode == self._mode then
		return
	end

	if self.waitChangeMode == mode then
		return
	end

	if not self._chapterLayout then
		return
	end

	self._aniExcessive:Play(mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "hard" or "story", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)

	self.waitChangeMode = mode

	TaskDispatcher.cancelTask(self._startChangeModel, self)
	TaskDispatcher.runDelay(self._startChangeModel, self, 0.4)

	return true
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_startChangeModel()
	if self.waitChangeMode then
		self._mode = self.waitChangeMode
		self._transferShowChapterId = self:getChangedModel2ChapterId()
		self._transferShowEpisodeId = VersionActivity1_2DungeonController.instance:_getDefaultFocusEpisode(self._transferShowChapterId)

		self._chapterLayout:onRefresh(self._transferShowChapterId, self._transferShowEpisodeId)
		self._chapterLayout:playAnimation("switch")
		self:refreshModeNode()
		self:refreshSceneMode()
		self.viewContainer.mapScene:changeMap(VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(self._transferShowEpisodeId), true)
		self:_directClickOneItem()

		self.waitChangeMode = nil
	end
end

function VersionActivity1_2DungeonMapEpisodeBaseView:getChangedModel2ChapterId()
	return VersionActivity1_2DungeonEnum.DungeonChapterIdChangeModel[self._transferShowChapterId]
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	self._simagehardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("lvjing_kunnan"))

	DungeonModel.instance.chapterBgTweening = false
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
	self.goVersionActivity = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity")
	self.animator = self.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	self._fadeTime = 1
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_initChapterItem()
	self:_loadNewLayout()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_loadNewLayout()
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
		local chapterLayout = self:getLayoutClass()

		chapterLayout.viewContainer = self.viewContainer

		chapterLayout:initView(uiGO, {
			self._gochaptercontent
		})

		self._chapterLayout = chapterLayout

		self._chapterLayout:onRefresh(self._transferShowChapterId, self._transferShowEpisodeId)
		self:playOnOpenAnimation()

		self._layoutCanvas = self._gochaptercontent:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._targetTrans = uiGO.transform

		self:_layoutTweenFinish()
		self:_directClickOneItem()

		local normalSelectConfig = DungeonConfig.instance:getEpisodeCO(self._transferShowEpisodeId)

		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, normalSelectConfig)
		self.viewContainer.mapScene:changeMap(VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(self._transferShowEpisodeId), true)
	end)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_directClickOneItem()
	if self.viewParam.showMapLevelView then
		self.viewParam.showMapLevelView = nil

		self._chapterLayout._episodeItemDict[self._transferShowEpisodeId]:onClick(self.viewParam.episodeId)
	end
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_onEnterFight(episodeId)
	VersionActivity1_2DungeonMapEpisodeBaseView.setlastBattleEpisodeId(self._transferShowChapterId, episodeId)
end

function VersionActivity1_2DungeonMapEpisodeBaseView.getlastBattleEpisodeId(chapterId)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleChapterId2EpisodeId .. "_" .. chapterId, 0)
end

function VersionActivity1_2DungeonMapEpisodeBaseView.setlastBattleEpisodeId(chapterId, episodeId)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleChapterId2EpisodeId .. "_" .. chapterId, episodeId)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:getLayoutClass()
	return VersionActivity1_2DungeonMapChapterBaseLayout.New()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_layoutTweenFrame(value)
	self._layoutCanvas.alpha = value > 0.4 and (value - 0.4) / 0.6 or 0

	if self._oldLayoutCanvas then
		self._oldLayoutCanvas.alpha = value >= 0.6 and 0 or (0.6 - value) / 0.6
	end
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_layoutTweenFinish()
	self._layoutCanvas.alpha = 1
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_bgTweenFrame(value)
	self._bgCanvas.alpha = value > 0.4 and (value - 0.4) / 0.6 or 0
	self._olgBgCanvas.alpha = value >= 0.6 and 0 or (0.6 - value) / 0.6
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_bgTweenFinish()
	DungeonModel.instance.chapterBgTweening = false
	self._bgCanvas.alpha = 1
	self._olgBgCanvas.alpha = 0
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_setEpisodeListVisible(value)
	if not self._chapterLayout then
		return
	end

	local time = 0.2

	self._episodeListTweenId = value and ZProj.TweenHelper.DOAnchorPosY(self._chapterLayout.viewGO.transform, self._chapterLayout.defaultY, time) or ZProj.TweenHelper.DOAnchorPosY(self._chapterLayout.viewGO.transform, -260, time)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:playOnOpenAnimation()
	if not self.viewParam.isBgView then
		self._chapterLayout:playAnimation("open")
		self._chapterLayout:playEpisodeItemAnimation("in")
		self.animator:Play("versionactivity_story_open", 0, 0)
	end
end

function VersionActivity1_2DungeonMapEpisodeBaseView:onUpdateParam()
	self:playOnOpenAnimation()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:reopenViewParamPrecessed()
	if not self:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[self.viewParam.chapterId]) then
		self._transferShowEpisodeId = DungeonConfig.instance:get1_2VersionActivityFirstLevelEpisodeId(self.viewParam.episodeId)

		self:_directClickOneItem()
	end
end

function VersionActivity1_2DungeonMapEpisodeBaseView:onOpen()
	self._transferShowChapterId = VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[self.viewParam.chapterId] or self.viewParam.chapterId
	self._transferShowEpisodeId = DungeonConfig.instance:get1_2VersionActivityFirstLevelEpisodeId(self.viewParam.episodeId)
	self._mode = VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[self._transferShowChapterId]

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self:_initChapterItem()
	self:refreshModeNode()
	self:refreshSceneMode()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:refreshModeNode()
	if self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story then
		self._imgstorymode.color = VersionActivity1_2DungeonMapEpisodeBaseView.ModeSelectColor or VersionActivity1_2DungeonMapEpisodeBaseView.ModeDisSelectColor
	end

	if self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		self._imghardmode.color = VersionActivity1_2DungeonMapEpisodeBaseView.ModeSelectColor or VersionActivity1_2DungeonMapEpisodeBaseView.ModeDisSelectColor
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._txtstorymodeCn, self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and "#ACD087" or "#556644")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtstorymodeEn, self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and "#ACD087" or "#556644")
	SLFramework.UGUI.GuiHelper.SetColor(self._txthardmodeCn, self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "#EBB7B6" or "#6F5252")
	SLFramework.UGUI.GuiHelper.SetColor(self._txthardmodeEn, self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "#EBB7B6" or "#6F5252")
	gohelper.setActive(self._simagehardbg.gameObject, self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:refreshSceneMode()
	self.viewContainer.mapScene:changeDungeonMode(self._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function VersionActivity1_2DungeonMapEpisodeBaseView:_onUpdateDungeonInfo(dungeonInfo)
	if self._chapterLayout then
		self._chapterLayout:onRefresh(self._transferShowChapterId, VersionActivity1_2DungeonController.instance:getDungeonSelectedEpisodeId())
	end
end

function VersionActivity1_2DungeonMapEpisodeBaseView:onClose()
	TaskDispatcher.cancelTask(self._startChangeModel, self)
	self._scrollcontent:RemoveOnValueChanged()
end

function VersionActivity1_2DungeonMapEpisodeBaseView:onDestroyView()
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

	self._simagebg:UnLoadImage()
	self._simagehardbg:UnLoadImage()
end

return VersionActivity1_2DungeonMapEpisodeBaseView
