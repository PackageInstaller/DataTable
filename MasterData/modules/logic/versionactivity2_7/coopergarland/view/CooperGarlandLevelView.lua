-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandLevelView.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelView", package.seeall)

local CooperGarlandLevelView = class("CooperGarlandLevelView", BaseView)
local RIGHT_OFFSET = -300
local PATH_ANIM_TIME = 0.15

function CooperGarlandLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._btnExtraEpisode = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ChallengeBtn")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CooperGarlandLevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._btnExtraEpisode:AddClickListener(self._btnExtraEpisodeOnClick, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._touch:AddClickDownListener(self._onClickDown, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, self._onInfoUpdate, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnClickEpisode, self._onClickEpisode, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.FirstFinishEpisode, self._onFirstFinishEpisode, self)
end

function CooperGarlandLevelView:removeEvents()
	self._btnTask:RemoveClickListener()
	self._btnExtraEpisode:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._touch:RemoveClickDownListener()
	self._btnTrial:RemoveClickListener()
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, self._onInfoUpdate, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnClickEpisode, self._onClickEpisode, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.FirstFinishEpisode, self._onFirstFinishEpisode, self)
end

function CooperGarlandLevelView:_btnTaskOnClick()
	CooperGarlandController.instance:openTaskView()
end

function CooperGarlandLevelView:_clickTrial()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function CooperGarlandLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function CooperGarlandLevelView:_btnExtraEpisodeOnClick()
	local extraEpisodeId = CooperGarlandConfig.instance:getExtraEpisode(self.actId, true)
	local isUnlock = CooperGarlandModel.instance:isUnlockEpisode(self.actId, extraEpisodeId)

	if isUnlock then
		CooperGarlandController.instance:clickEpisode(self.actId, extraEpisodeId)
	end
end

function CooperGarlandLevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function CooperGarlandLevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function CooperGarlandLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function CooperGarlandLevelView:_onInfoUpdate()
	self:refreshExtraEpisode()
end

function CooperGarlandLevelView:_onClickEpisode(actId, episodeId)
	if self.actId ~= actId then
		return
	end

	self:onFocusEnd(episodeId)
end

function CooperGarlandLevelView:_onFirstFinishEpisode(actId, episodeId)
	if self.actId ~= actId then
		return
	end

	self:focusNewestLevelItem()

	self._waitFinishAnimEpisode = episodeId

	self:playEpisodeFinishAnim()
end

function CooperGarlandLevelView:_editableInitView()
	self.actId = CooperGarlandModel.instance:getAct192Id()
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._taskAnimator = goTaskAnim:GetComponentInChildren(typeof(UnityEngine.Animator))
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)
	self._scrollStory = self._gostoryPath:GetComponent(gohelper.Type_ScrollRect)
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
	self._transstoryScroll = self._gostoryScroll.transform
	self._pathAnimator = gohelper.findChildAnim(self.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
	self.openAnimComplete = nil
	self._waitFinishAnimEpisode = nil
	self._finishEpisodeIndex = nil

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	self._offsetX = (width - RIGHT_OFFSET) / 2

	local scrollWidth = recthelper.getWidth(self._transstoryScroll)

	self.minContentAnchorX = -scrollWidth + width

	self:_initLevelItem()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a7CooperGarlandTask, nil, self._refreshRedDot, self)
end

function CooperGarlandLevelView:_initLevelItem()
	if self._levelItemList then
		return
	end

	self._levelItemList = {}

	local levelItemPath = self.viewContainer:getSetting().otherRes[1]
	local levelList = CooperGarlandConfig.instance:getEpisodeIdList(self.actId, true)
	local levelCount = #levelList
	local transStages = self._gostoryStages.transform
	local levelNodeCount = transStages.childCount

	if levelNodeCount < levelCount then
		logError(string.format("CooperGarlandLevelView:_initLevelItem error, level node not enough, has:%s, need:%s", levelNodeCount, levelCount))
	end

	local gameIndex = 1

	for i = 1, levelNodeCount do
		local episodeId = levelList[i]

		if episodeId then
			local levelItemNode = transStages:GetChild(i - 1)
			local name = string.format("levelItem_%s", i)
			local go = self:getResInst(levelItemPath, levelItemNode.gameObject, name)
			local levelItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, CooperGarlandLevelItem)
			local hasGame = CooperGarlandConfig.instance:isGameEpisode(self.actId, episodeId)

			if hasGame then
				levelItem:setData(self.actId, episodeId, i, gameIndex)

				gameIndex = gameIndex + 1
			else
				levelItem:setData(self.actId, episodeId, i)
			end

			table.insert(self._levelItemList, levelItem)
		end
	end
end

function CooperGarlandLevelView:onUpdateParam()
	return
end

function CooperGarlandLevelView:onOpen()
	self:refreshUI()
	self:focusNewestLevelItem()

	local pathIndex = 0

	for _, episodeItem in ipairs(self._levelItemList) do
		local isFinished = CooperGarlandModel.instance:isFinishedEpisode(self.actId, episodeItem.episodeId)

		if isFinished then
			pathIndex = episodeItem.index
		end
	end

	self:_playPathAnim(pathIndex, false)
end

function CooperGarlandLevelView:getNewestLevelItem()
	local result = self._levelItemList[1]
	local newestEpisodeId = CooperGarlandModel.instance:getNewestEpisodeId(self.actId)

	for _, episodeItem in ipairs(self._levelItemList) do
		if episodeItem.episodeId == newestEpisodeId then
			result = episodeItem

			break
		end
	end

	return result
end

function CooperGarlandLevelView:refreshUI()
	self:refreshExtraEpisode()
end

function CooperGarlandLevelView:refreshTime()
	local timeStr, isEnd = CooperGarlandModel.instance:getAct192RemainTimeStr(self.actId)

	self._txtlimittime.text = timeStr

	if isEnd then
		TaskDispatcher.cancelTask(self.refreshTime, self)
	end
end

function CooperGarlandLevelView:refreshExtraEpisode()
	local extraEpisodeId = CooperGarlandConfig.instance:getExtraEpisode(self.actId, true)
	local isUnlock = CooperGarlandModel.instance:isUnlockEpisode(self.actId, extraEpisodeId)

	gohelper.setActive(self._btnExtraEpisode, isUnlock)
end

function CooperGarlandLevelView:_refreshRedDot(reddot)
	reddot:defaultRefreshDot()

	local showRedDot = reddot.show

	self._taskAnimator:Play(showRedDot and "loop" or "idle")
end

function CooperGarlandLevelView:focusNewestLevelItem(moveTime)
	local levelItem = self:getNewestLevelItem()

	if not levelItem then
		return
	end

	local contentAnchorX = recthelper.getAnchorX(levelItem._go.transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	ZProj.TweenHelper.DOAnchorPosX(self._transstoryScroll, offsetX, moveTime or 0, self.onFocusEnd, self)
end

function CooperGarlandLevelView:onFocusEnd(episodeId)
	if not episodeId then
		return
	end

	CooperGarlandController.instance:afterClickEpisode(self.actId, episodeId)
end

function CooperGarlandLevelView:playEpisodeFinishAnim()
	if not self.openAnimComplete or not self._waitFinishAnimEpisode then
		return
	end

	for i, episodeItem in ipairs(self._levelItemList) do
		if episodeItem.episodeId == self._waitFinishAnimEpisode then
			self._finishEpisodeIndex = i

			episodeItem:refreshUI("finish")
			AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_lit)
			self:_playPathAnim(self._finishEpisodeIndex, true)
			TaskDispatcher.runDelay(self._playEpisodeUnlockAnim, self, PATH_ANIM_TIME)
		end
	end

	self.openAnimComplete = nil
	self._waitFinishAnimEpisode = nil
end

function CooperGarlandLevelView:_playPathAnim(index, needPlay)
	if index > 0 then
		self._pathAnimator.speed = 1

		local animName = string.format("go%s", Mathf.Clamp(index, 1, #self._levelItemList))

		self._pathAnimator:Play(animName, 0, needPlay and 0 or 1)
	else
		self._pathAnimator.speed = 0

		self._pathAnimator:Play("go1", -1, 0)
	end
end

function CooperGarlandLevelView:_playEpisodeUnlockAnim()
	if not self._finishEpisodeIndex then
		return
	end

	local nextEpisodeItem = self._levelItemList[self._finishEpisodeIndex + 1]

	if nextEpisodeItem then
		nextEpisodeItem:refreshUI("unlock")
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_unlock)
	end

	self._finishEpisodeIndex = nil
end

function CooperGarlandLevelView:onClose()
	self.openAnimComplete = nil
	self._waitFinishAnimEpisode = nil
	self._finishEpisodeIndex = nil

	TaskDispatcher.cancelTask(self._playEpisodeUnlockAnim, self)
end

function CooperGarlandLevelView:onDestroyView()
	return
end

return CooperGarlandLevelView
