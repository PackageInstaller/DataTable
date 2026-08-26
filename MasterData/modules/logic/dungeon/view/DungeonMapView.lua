-- chunkname: @modules/logic/dungeon/view/DungeonMapView.lua

module("modules.logic.dungeon.view.DungeonMapView", package.seeall)

local DungeonMapView = class("DungeonMapView", BaseView)

function DungeonMapView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._gobgcontainerold = gohelper.findChild(self.viewGO, "bgcanvas/#go_bgcontainerold")
	self._gobgcontainer = gohelper.findChild(self.viewGO, "bgcanvas/#go_bgcontainer")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._gochaptercontentitem = gohelper.findChild(self.viewGO, "#scroll_content/#go_chaptercontentitem")
	self._gomain = gohelper.findChild(self.viewGO, "#go_main")
	self._btngifts = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_rightbtns/#btn_gifts")
	self._btneliminate = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_dungeontips/#btn_eliminate")
	self._btnteach = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_rightbtns/#btn_teach")
	self._gobaoxiang1 = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_teach/baoxiang/#go_baoxiang1")
	self._gobaoxiang2 = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_teach/baoxiang/#go_baoxiang2")
	self._goteachredpoint = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_teach/#go_teachredpoint")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#go_main/#go_rightbtns/#btn_gifts/#txt_progress")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")
	self._txtposition = gohelper.findChildText(self.viewGO, "#go_main/#go_toptipsbg/#txt_position")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_main/#go_toptipsbg/#txt_position/#txt_time")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#go_main/#go_toptipsbg/#txt_remaintime")
	self._godungeontips = gohelper.findChild(self.viewGO, "#go_main/#go_dungeontips")
	self._gotipepisode = gohelper.findChild(self.viewGO, "#go_main/#go_dungeontips/#go_tipepisode")
	self._btngotoEpisode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_dungeontips/#go_tipepisode/#btn_gotoEpisode")
	self._gotipmap = gohelper.findChild(self.viewGO, "#go_main/#go_dungeontips/#go_tipmap")
	self._btngotoMap = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_dungeontips/#go_tipmap/#btn_gotoMap")
	self._gores = gohelper.findChild(self.viewGO, "#go_res")
	self._goentryItem = gohelper.findChild(self.viewGO, "#go_res/entry/#go_entryItem")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_res/entry/#go_entryItem/#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_res/entry/#go_entryItem/#txt_num")
	self._imagefull = gohelper.findChildImage(self.viewGO, "#go_res/entry/#go_entryItem/progress/#image_full")
	self._txtprogressNum = gohelper.findChildText(self.viewGO, "#go_res/entry/#go_entryItem/progress/#txt_progressNum")
	self._gochapterlist = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist")
	self._gochapterlineItem = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem")
	self._gochoiceicon = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_choiceicon")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_choiceicon/#simage_icon1")
	self._gonormalicon = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_normalicon")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_normalicon/#simage_icon2")
	self._golockicon = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_lockicon")
	self._simageicon3 = gohelper.findChildSingleImage(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_lockicon/#simage_icon3")
	self._goitemline = gohelper.findChild(self.viewGO, "#go_res/chapter/#go_chapterlist/#go_itemline")
	self._gotasklist = gohelper.findChild(self.viewGO, "#go_tasklist")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_tasklist/#go_taskitem")
	self._gogiftredpoint = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_gifts/#go_giftredpoint")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapView:addEvents()
	self._btngifts:AddClickListener(self._btngiftsOnClick, self)
	self._btneliminate:AddClickListener(self._btneliminateOnClick, self)
	self._btnteach:AddClickListener(self._btnteachOnClick, self)
	self._btngotoEpisode:AddClickListener(self._btngotoEpisodeOnClick, self)
	self._btngotoMap:AddClickListener(self._btngotoMapOnClick, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
end

function DungeonMapView:removeEvents()
	self._btngifts:RemoveClickListener()
	self._btneliminate:RemoveClickListener()
	self._btnteach:RemoveClickListener()
	self._btngotoEpisode:RemoveClickListener()
	self._btngotoMap:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
end

function DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function DungeonMapView:_btngotoEpisodeOnClick()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, self._hardEpisode)
end

function DungeonMapView:_btngotoMapOnClick()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, self._mapEpisode)
end

function DungeonMapView:_btnteachOnClick()
	TeachNoteController.instance:enterTeachNoteView()
end

function DungeonMapView:_btneliminateOnClick()
	EliminateMapController.instance:openEliminateMapView()
end

function DungeonMapView:_btngiftsOnClick()
	DungeonController.instance:openDungeonCumulativeRewardsView(self.viewParam)
end

function DungeonMapView:_editableInitView()
	self._playAudioCheck = {}
	self._topLeftGo = gohelper.findChild(self.viewGO, "top_left")
	self._topLeftElementGo = gohelper.findChild(self.viewGO, "top_left_element")
	self._tipDefaultX = recthelper.getAnchorX(self._godungeontips.transform)

	local go = self._btngifts.gameObject

	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._teachAnim = self._btnteach.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._baoxiang = gohelper.findChild(go, "baoxiang")
	self._addtxtprogress = gohelper.findChildText(self.viewGO, "#go_main/#go_rightbtns/#btn_gifts/txt_progress_effect")
	self._addGo = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_gifts/obtain")
	self._addtxtnum = gohelper.findChildText(self.viewGO, "#go_main/#go_rightbtns/#btn_gifts/obtain/zengjiatxt")
	self._goreceive = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_gifts/gifts_receive")

	gohelper.addUIClickAudio(self._btngifts.gameObject, AudioEnum.UI.play_ui_checkpoint_swath_open)
	self:_setEffectAudio()
	gohelper.setActive(self._btngifts.gameObject, self:_isShowBtnGift())
	gohelper.removeUIClickAudio(self._btncloseview.gameObject)

	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
end

function DungeonMapView:_setEffectAudio()
	self._tiggerCount = 9
	self._audioCount = 7

	local animationEventWrap = self._btngifts:GetComponent(typeof(ZProj.AnimationEventWrap))

	animationEventWrap:AddEventListener("audio", self._onEffectAudio, self)
end

function DungeonMapView:_onEffectAudio()
	self._audioCount = self._audioCount + 1

	if self:_needAudio() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_rewardgain)
	end
end

function DungeonMapView:_needAudio()
	if not self._progressPoint then
		return false
	end

	if self._playAudioCheck[self._progressPoint] then
		return false
	end

	self._playAudioCheck[self._progressPoint] = true

	return true
end

function DungeonMapView:_endShowRewardView()
	if self._isNormalChapter then
		-- block empty
	end
end

function DungeonMapView:_refreshPointReward(skipAnim)
	transformhelper.setLocalScale(self._baoxiang.transform, 1, 1, 1)

	self._anim.enabled = false

	local pointRewardCfg = DungeonConfig.instance:getChapterPointReward(self._chapterId)

	if not pointRewardCfg and not self._isNormalChapter then
		gohelper.setActive(self._btngifts.gameObject, false)

		return
	end

	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo()
	local targetReward = DungeonMapModel.instance:getUnfinishedTargetReward()

	self._txtprogress.text = string.format("%s/%s", pointRewardInfo.rewardPoint, targetReward.rewardPointNum)

	local rewards = DungeonMapModel.instance:canGetAllRewardsList()

	gohelper.setActive(self._gogiftredpoint, rewards and #rewards > 0)

	if not skipAnim and rewards and #rewards > 0 then
		self._anim.enabled = true

		self._anim:Play("dungeonmap_gifts_receive")

		self._progressPoint = pointRewardInfo.rewardPoint

		return
	end

	gohelper.setActive(self._goreceive, false)
end

function DungeonMapView:_OnAddRewardPoint(num)
	TaskDispatcher.cancelTask(self._obtainFinished, self)

	self._anim.enabled = false

	local pointRewardCfg = DungeonConfig.instance:getChapterPointReward(self._chapterId)

	if not pointRewardCfg then
		return
	end

	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo(self._chapterId)
	local lastConfig = DungeonMapModel.instance:getUnfinishedTargetReward()
	local maxNum = lastConfig.rewardPointNum

	self._addtxtnum.text = "+" .. tostring(num)

	gohelper.setActive(self._addGo, true)
	TaskDispatcher.runDelay(self._obtainFinished, self, 1.5)

	local rewards = DungeonMapModel.instance:canGetAllRewardsList()

	if rewards and #rewards > 0 then
		self:_refreshPointReward()

		return
	end

	if maxNum <= pointRewardInfo.rewardPoint then
		return
	end

	local progressStr = string.format("%s/%s", math.min(pointRewardInfo.rewardPoint, maxNum), maxNum)

	self._addtxtprogress.text = progressStr
	self._txtprogress.text = progressStr
	self._anim.enabled = true

	self._anim:Play("dungeonmap_gifts_obtain")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_rewardgain)

	self._audioCount = 0
end

function DungeonMapView:_obtainFinished()
	gohelper.setActive(self._addGo, false)
end

function DungeonMapView:onUpdateParam()
	self.viewContainer:refreshHelp()
	self:refreshUI()
end

function DungeonMapView:_OnCheckVision(param)
	self._hardEpisode = param[1]
	self._mapEpisode = param[2]

	gohelper.setActive(self._gotipepisode, false)
end

function DungeonMapView:_onEscBtnClick()
	if self._topLeftGo.activeInHierarchy then
		self.viewContainer:overrideClose()
	elseif self._topLeftElementGo.activeInHierarchy then
		self.viewContainer:overrideCloseElement()
	end
end

function DungeonMapView:onOpen()
	self:refreshUI()
end

function DungeonMapView:onOpenFinish()
	local chapterId = self.viewParam.chapterId

	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, chapterId)
end

function DungeonMapView:refreshUI()
	self._chapterId = self.viewParam.chapterId

	local chapterConfig = DungeonConfig.instance:getChapterCO(self._chapterId)

	self._isNormalChapter = chapterConfig.type == DungeonEnum.ChapterType.Normal

	DungeonModel.instance:clearUnlockNewChapterId(self._chapterId)
	self:setGiftIn()
	self:_setTeachBtn()
	gohelper.setActive(self._btneliminate.gameObject, self:_isShowBtnEliminate())
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnGetPointReward, self._refreshPointReward, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnAddRewardPoint, self._OnAddRewardPoint, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCheckVision, self._OnCheckVision, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, self._setTeachBtn, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self._onFuncUnlockRefresh, self)
	self:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, self.viewContainer.refreshHelp, self.viewContainer)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self._OnChangeMap, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapView, self._onEscBtnClick, self)
	gohelper.setActive(self._gomain, self._isNormalChapter)
	gohelper.setActive(self._gores, not self._isNormalChapter)

	if self._isNormalChapter then
		DungeonController.instance:OnOpenNormalMapView()
	end

	local pointRewardCfg = DungeonConfig.instance:getChapterPointReward(self._chapterId)

	if pointRewardCfg and ViewMgr.instance:isOpen(ViewName.MainView) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_point)
	end

	gohelper.setActive(self._btncloseview, ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView))
end

function DungeonMapView:_OnChangeMap()
	return
end

function DungeonMapView:_setEpisodeListVisible(value, source)
	if source == DungeonEnum.EpisodeListVisibleSource.ToughBattle then
		return
	end

	gohelper.setActive(self._gofullscreen, value)
	self:_clearTipTween()

	local time = 0.2

	if value then
		self._tipTweenId = ZProj.TweenHelper.DOAnchorPosX(self._godungeontips.transform, self._tipDefaultX, time)

		self:_onCloseHandler()
	else
		self._tipTweenId = ZProj.TweenHelper.DOAnchorPosX(self._godungeontips.transform, -140, time)

		self:_onOpenHandler()
	end
end

function DungeonMapView:_clearTipTween()
	if self._tipTweenId then
		ZProj.TweenHelper.KillById(self._tipTweenId)

		self._tipTweenId = nil
	end
end

function DungeonMapView:_isShowBtnGift()
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward) and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
end

function DungeonMapView:_isShowBtnEliminate()
	return self._chapterId == DungeonEnum.ChapterId.Main1_8 and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Eliminate) and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
end

function DungeonMapView:_onFuncUnlockRefresh()
	gohelper.setActive(self._btngifts.gameObject, self:_isShowBtnGift())
	gohelper.setActive(self._btneliminate.gameObject, self:_isShowBtnEliminate())
end

function DungeonMapView:_onOpenHandler()
	gohelper.setActive(self._btngifts.gameObject, false)
	gohelper.setActive(self._btneliminate.gameObject, false)
	gohelper.setActive(self._btnteach.gameObject, false)
	gohelper.setActive(self._topLeftGo.gameObject, false)
	gohelper.setActive(self._topLeftElementGo.gameObject, true)
end

function DungeonMapView:_onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView or viewName == ViewName.DungeonMapTaskView or viewName == ViewName.TeachNoteDetailView then
		self:_onOpenHandler()
	end

	if viewName == ViewName.DungeonMapLevelView then
		gohelper.setActive(self._btncloseview, true)

		self._rectmask2D.padding = Vector4(0, 0, 600, 0)
	end
end

function DungeonMapView:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapLevelView or viewName == ViewName.DungeonMapTaskView then
		self:_onCloseHandler(false)
	end

	if viewName == ViewName.TeachNoteDetailView then
		self:_onCloseHandler(true)
	end

	if viewName == ViewName.DungeonMapLevelView then
		gohelper.setActive(self._btncloseview, false)

		self._rectmask2D.padding = Vector4(0, 0, 0, 0)
	end
end

function DungeonMapView:_onCloseHandler(isTeachNote)
	gohelper.setActive(self._btngifts.gameObject, self:_isShowBtnGift())
	gohelper.setActive(self._btneliminate.gameObject, self:_isShowBtnEliminate())
	gohelper.setActive(self._topLeftGo.gameObject, true)
	gohelper.setActive(self._topLeftElementGo.gameObject, false)
	self:_setTeachBtn()
	self:setGiftIn()
end

function DungeonMapView:setGiftIn()
	TaskDispatcher.cancelTask(self._refreshPointReward, self)
	self:_refreshPointReward(true)

	self._anim.enabled = true

	self._anim:Play("dungeonmap_gifts_in")
	gohelper.setActive(self._gogiftredpoint, false)
	TaskDispatcher.runDelay(self._refreshPointReward, self, 1)
end

function DungeonMapView:_setTeachBtn()
	if not TeachNoteModel.instance:isTeachNoteUnlock() or ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		gohelper.setActive(self._btnteach.gameObject, false)

		return
	end

	gohelper.setActive(self._btnteach.gameObject, true)

	self._teachAnim.enabled = true

	local hasReward, hasNewTopic = TeachNoteModel.instance:hasRewardCouldGet(), #TeachNoteModel.instance:getNewOpenTopics() > 0

	gohelper.setActive(self._goteachredpoint, hasReward)
	gohelper.setActive(self._gobaoxiang1, not hasNewTopic and not hasReward)
	gohelper.setActive(self._gobaoxiang2, hasNewTopic or hasReward)
	self._teachAnim:SetBool("unlock", hasReward)
	self._teachAnim:Play(UIAnimationName.Open, 0, 0)
end

function DungeonMapView:_onOpenFullView(viewName)
	if viewName == ViewName.EliminateLevelView then
		gohelper.setActive(self.viewGO, false)
	end
end

function DungeonMapView:_onCloseFullView(viewName)
	if viewName == ViewName.EliminateLevelView then
		gohelper.setActive(self.viewGO, true)
	end
end

function DungeonMapView:onClose()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function DungeonMapView:onDestroyView()
	TaskDispatcher.cancelTask(self._obtainFinished, self)
	TaskDispatcher.cancelTask(self._refreshPointReward, self)
end

return DungeonMapView
