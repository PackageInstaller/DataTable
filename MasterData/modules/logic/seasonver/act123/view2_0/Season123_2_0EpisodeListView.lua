-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EpisodeListView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EpisodeListView", package.seeall)

local Season123_2_0EpisodeListView = class("Season123_2_0EpisodeListView", BaseView)

function Season123_2_0EpisodeListView:onInitView()
	self._btnheroes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_heroes")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_details")
	self._gostageitem = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	self._btntipreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tipreward")
	self._gorewardRedDot = gohelper.findChild(self.viewGO, "#btn_tipreward/#go_rewardredpoint")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._goscrollstory = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter")
	self._btnadditionruledetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_additionruletips/tips/#btn_additionruledetail")
	self._goentranceitem = gohelper.findChild(self.viewGO, "#go_entrance_item")
	self._goframe = gohelper.findChild(self.viewGO, "selectframe")
	self._animTipReward = self._btntipreward:GetComponent(gohelper.Type_Animation)
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btnmask = gohelper.findChildButtonWithAudio(self.viewGO, "mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0EpisodeListView:addEvents()
	self._btnheroes:AddClickListener(self._btnheroesOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
	self._btntipreward:AddClickListener(self._btntiprewardOnClick, self)
	self._btnadditionruledetail:AddClickListener(self._btnadditionruleDetailOnClick, self)
	self._btnmask:AddClickListener(self._btnMaskOnClick, self)
end

function Season123_2_0EpisodeListView:removeEvents()
	self._btnheroes:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btndetails:RemoveClickListener()
	self._btntipreward:RemoveClickListener()
	self._btnadditionruledetail:RemoveClickListener()
	self._btnmask:RemoveClickListener()
end

function Season123_2_0EpisodeListView:_editableInitView()
	self._stageItems = {}
	self._scrollCanvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
	self._scrollStory = gohelper.findChildScrollRect(self._goscrollstory, "")
	self._goScroll = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content")
	self._rectScroll = self._goScroll.transform
	self._heightScroll = recthelper.getHeight(self._scrollStory.transform)
	self._heightItem = recthelper.getHeight(self._gostageitem.transform)
	self._heightSpace = 24
	self._goempty3 = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty3")
	self._goempty4 = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty4")

	gohelper.setActive(self._gorewards, false)
	gohelper.setActive(self._goframe, false)
	TaskDispatcher.runDelay(self.delayAddScrollAudio, self, 0.6)
end

function Season123_2_0EpisodeListView:onDestroyView()
	if self._stageItems then
		for _, item in pairs(self._stageItems) do
			item.btnSelf:RemoveClickListener()
			item.simagechaptericon:UnLoadImage()
		end

		self._stageItems = nil
	end

	Season123EpisodeListController.instance:onCloseView()
	UIBlockMgr.instance:endBlock(Season123_2_0EpisodeListView.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)

	if self._tweenIdScroll then
		ZProj.TweenHelper.KillById(self._tweenIdScroll)

		self._tweenIdScroll = nil
	end

	TaskDispatcher.cancelTask(self.handlePlayScrollAnimCompleted, self)

	if self._centerItem then
		self._centerItem:dispose()

		self._centerItem = nil
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

	TaskDispatcher.cancelTask(self.delayAddScrollAudio, self)
end

function Season123_2_0EpisodeListView:onOpen()
	local actId = self.viewParam.actId
	local stage = self.viewParam.stage

	logNormal(string.format("episode actId=%s, stage=%s", actId, stage))
	Season123EpisodeListController.instance:onOpenView(actId, stage)
	self.addEventCb(self, Season123Controller.instance, Season123Event.GetActInfo, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.EpisodeViewRefresh, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.StageInfoChanged, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.TaskUpdated, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.ResetCloseEpisodeList, self.closeThis, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.OnDotChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)

	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self:initCenter()
	self:refreshUI()

	local layerDatas = Season123EpisodeListModel.instance:getList()

	for i, layerData in ipairs(layerDatas) do
		if layerData.id == Season123EpisodeListModel.instance:getCurrentChallengeLayer() then
			local targetY = self:getScrollToIndexY(i)

			recthelper.setAnchorY(self._rectScroll, targetY)
		end
	end

	Season123EpisodeListController.instance:processJumpParam(self.viewParam)
	RedDotController.instance:addRedDot(self._gorewardRedDot, RedDotEnum.DotNode.Season123StageReward, self.viewParam.stage)
end

function Season123_2_0EpisodeListView:onClose()
	return
end

function Season123_2_0EpisodeListView:refreshUI()
	self:refreshStageList()
	self:refreshCenter()

	local inStage = Season123EpisodeListModel.instance:inCurrentStage() or Season123ProgressUtils.checkStageIsFinish(Season123EpisodeListModel.instance.activityId, Season123EpisodeListModel.instance.stage)

	gohelper.setActive(self._btnreset, inStage)
end

function Season123_2_0EpisodeListView:refreshStageList()
	local layerDatas = Season123EpisodeListModel.instance:getList()
	local processSet = {}

	for i, layerData in ipairs(layerDatas) do
		local item = self:getOrCreateLayerItem(i)

		self:refreshSingleItem(i, item, layerData)

		processSet[item] = true
	end

	for _, item in pairs(self._stageItems) do
		gohelper.setActive(item.go, processSet[item])
	end

	gohelper.setAsLastSibling(self._goempty3)
	gohelper.setAsLastSibling(self._goempty4)
end

function Season123_2_0EpisodeListView:getOrCreateLayerItem(index)
	local item = self._stageItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gostageitem, "stage_item" .. index)

		item = self:getUserDataTb_()
		item.go = go
		item.txtName = gohelper.findChildText(go, "#txt_name")
		item.gofinish = gohelper.findChild(go, "#go_done")
		item.goUnfinish = gohelper.findChild(go, "#go_unfinished")
		item.txtPassRound = gohelper.findChildText(go, "#go_done/#txt_num")
		item.goMark = gohelper.findChild(go, "#go_mark")
		item.golock = gohelper.findChild(go, "#go_locked")
		item.simagechaptericon = gohelper.findChildSingleImage(go, "#simage_chapterIcon")
		item.goselected = gohelper.findChild(go, "selectframe")
		item.goEnemyList = gohelper.findChild(go, "enemyList")
		item.goEnemyItem = gohelper.findChild(go, "enemyList/#go_enemyteam/enemyList/go_enemyitem")
		item.txtchapter = gohelper.findChildText(go, "#go_chpt/#txt_chpt")
		item.btnSelf = gohelper.findChildButtonWithAudio(go, "#btn_self")

		item.btnSelf:AddClickListener(self.onItemClick, self, index)
		gohelper.setActive(item.go, true)

		self._stageItems[index] = item
	end

	return item
end

function Season123_2_0EpisodeListView:refreshSingleItem(index, item, data)
	item.txtchapter.text = string.format("%02d", data.cfg.layer)

	local folder = Season123Model.instance:getSingleBgFolder()

	if not string.nilorempty(folder) then
		item.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(folder, data.cfg.stagePicture))
	end

	self:refreshSingleItemLock(index, item, data)
	self:refreshSingleItemFinished(index, item, data)

	local isSelect = data.cfg.layer == Season123EpisodeListModel.instance.curSelectLayer

	gohelper.setActive(item.goselected, isSelect)

	if isSelect then
		self._gocurrentselected = item.goselected
	end

	gohelper.setActive(item.goMark, data.cfg.displayMark == Activity123Enum.DisplayMark)
end

function Season123_2_0EpisodeListView:refreshSingleItemLock(index, item, data)
	local isUnlock = Season123EpisodeListModel.instance:isEpisodeUnlock(data.cfg.layer)

	gohelper.setActive(item.golock, not isUnlock)

	local color = isUnlock and "#FFFFFF" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(item.txtchapter, color)
end

function Season123_2_0EpisodeListView:refreshSingleItemFinished(index, item, data)
	local isUnlock = Season123EpisodeListModel.instance:isEpisodeUnlock(data.cfg.layer)
	local isFinished = data.isFinished

	gohelper.setActive(item.gofinish, isFinished)
	gohelper.setActive(item.txtPassRound, isFinished)
	gohelper.setActive(item.goUnfinish, not isFinished and isUnlock)

	if isFinished then
		local isReduceRound = Season123Controller.instance:isReduceRound(self.viewParam.actId, self.viewParam.stage, data.cfg.layer)
		local passRoundFormat = isReduceRound and "<color=#eecd8c>%s</color>" or "%s"

		item.txtPassRound.text = string.format(passRoundFormat, tostring(data.round))
	end
end

function Season123_2_0EpisodeListView:refreshCenter()
	if self._centerItem then
		self._centerItem:refreshUI()
	end
end

function Season123_2_0EpisodeListView:initCenter()
	self._centerItem = Season123_2_0EpisodeListCenter.New()

	self._centerItem:init(self._goentranceitem)
	self._centerItem:initData(self.viewParam.actId, self.viewParam.stage)
end

Season123_2_0EpisodeListView.OutOfBoundOffset = 280
Season123_2_0EpisodeListView.DelayEnterEpisodeTime = 0.2
Season123_2_0EpisodeListView.SCROLL_ANIM_BLOCK_KEY = "Season123_2_0EpisodeListView_scrollanim"

function Season123_2_0EpisodeListView:playScrollAnim(index)
	UIBlockMgr.instance:startBlock(Season123_2_0EpisodeListView.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(false)

	self._scrollCanvasGroup.interactable = false
	self._scrollCanvasGroup.blocksRaycasts = false
	self._scrollStory.movementType = 0

	if self._tweenIdScroll then
		ZProj.TweenHelper.KillById(self._tweenIdScroll)
	end

	TaskDispatcher.cancelTask(self.handlePlayScrollAnimCompleted, self)

	local targetY = self:getScrollToIndexY(index)
	local curY = recthelper.getAnchorY(self._rectScroll)
	local deltaY = curY - targetY

	if deltaY > Season123_2_0EpisodeListView.OutOfBoundOffset then
		self._tweenIdScroll = ZProj.TweenHelper.DOAnchorPosY(self._rectScroll, targetY + Season123_2_0EpisodeListView.OutOfBoundOffset, Season123_2_0EpisodeListView.DelayEnterEpisodeTime, self.handlePlayScrollAnimCompleted, self)
	elseif deltaY < -Season123_2_0EpisodeListView.OutOfBoundOffset then
		self._tweenIdScroll = ZProj.TweenHelper.DOAnchorPosY(self._rectScroll, targetY - Season123_2_0EpisodeListView.OutOfBoundOffset, Season123_2_0EpisodeListView.DelayEnterEpisodeTime, self.handlePlayScrollAnimCompleted, self)
	else
		self._viewAnimator:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(self.handlePlayScrollAnimCompleted, self, Season123_2_0EpisodeListView.DelayEnterEpisodeTime)
	end
end

function Season123_2_0EpisodeListView:handlePlayScrollAnimCompleted()
	self._scrollCanvasGroup.interactable = true
	self._scrollCanvasGroup.blocksRaycasts = true

	UIBlockMgr.instance:endBlock(Season123_2_0EpisodeListView.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
	Season123EpisodeListController.instance:enterEpisode(true)

	self._scrollStory.movementType = 1
end

function Season123_2_0EpisodeListView:getScrollToIndexY(index)
	local decorateCount = 1

	return (index - 0.5 + decorateCount) * self._heightItem + (index - 1 + decorateCount) * self._heightSpace - self._heightScroll * 0.5
end

function Season123_2_0EpisodeListView:onItemClick(index)
	local data = Season123EpisodeListModel.instance:getByIndex(index)

	if not data then
		return
	end

	local isUnlock = Season123EpisodeListModel.instance:isEpisodeUnlock(data.cfg.layer)

	if isUnlock then
		local layer = data.cfg.layer

		if self._gocurrentselected then
			gohelper.setActive(self._gocurrentselected, false)
		end

		Season123EpisodeListController.instance:setSelectLayer(layer)
		self:playScrollAnim(index)
	else
		GameFacade.showToast(ToastEnum.SeasonEpisodeIsLock)

		return
	end
end

function Season123_2_0EpisodeListView:_btnheroesOnClick()
	local actId = self.viewParam.actId
	local actMO = Season123Model.instance:getActInfo(actId)

	if not actMO then
		return
	end

	local layer = Season123EpisodeListModel.instance.curSelectLayer

	if layer == 0 then
		return
	end

	ViewMgr.instance:openView(Season123Controller.instance:getShowHeroViewName(), {
		actId = actId,
		stage = Season123EpisodeListModel.instance.stage,
		layer = layer
	})
end

function Season123_2_0EpisodeListView:_btnresetOnClick()
	Season123Controller.instance:openResetView({
		actId = Season123EpisodeListModel.instance.activityId,
		stage = Season123EpisodeListModel.instance.stage,
		layer = Season123ResetModel.EmptySelect
	})
end

function Season123_2_0EpisodeListView:_btndetailsOnClick()
	local layer = Season123EpisodeListModel.instance:getCurrentChallengeLayer()

	if layer == 0 then
		return
	end

	Season123EpisodeListController.instance:openDetails()
end

function Season123_2_0EpisodeListView:_btntiprewardOnClick()
	Season123Controller.instance:openSeasonTaskView({
		actId = Season123EpisodeListModel.instance.activityId,
		stage = Season123EpisodeListModel.instance.stage
	})
end

function Season123_2_0EpisodeListView:_btnadditionruleDetailOnClick()
	local actId = Season123EpisodeListModel.instance.activityId
	local stage = Season123EpisodeListModel.instance.stage
	local param = {
		actId = actId,
		stage = stage
	}

	Season123Controller.instance:openSeasonAdditionRuleTipView(param)
end

function Season123_2_0EpisodeListView:_btnMaskOnClick()
	self.viewContainer:_overrideCloseFunc()
end

function Season123_2_0EpisodeListView:OnDotChange()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Season123StageReward, self.viewParam.stage)

	if isDotShow then
		self._animTipReward:Play("btn_tipreward_loop")
	else
		self._animTipReward:Play("btn_tipreward")
	end
end

function Season123_2_0EpisodeListView:onCloseView(viewName)
	if viewName == ViewName.Season123_2_0EpisodeDetailView then
		self:refreshStageList()
		self._viewAnimator:Play(UIAnimationName.Open, 0, 0)
	end
end

function Season123_2_0EpisodeListView:delayAddScrollAudio()
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._goscrollstory, Season123_2_0EpisodeListScrollAudio, self._scrollStory)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goscrollstory)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._goscrollstory)

	self._touch:AddClickDownListener(self._onClickDown, self)
end

function Season123_2_0EpisodeListView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function Season123_2_0EpisodeListView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function Season123_2_0EpisodeListView:_onClickDown()
	self._audioScroll:onClickDown()
end

return Season123_2_0EpisodeListView
