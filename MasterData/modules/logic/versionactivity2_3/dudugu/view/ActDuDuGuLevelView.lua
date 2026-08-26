-- chunkname: @modules/logic/versionactivity2_3/dudugu/view/ActDuDuGuLevelView.lua

module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelView", package.seeall)

local ActDuDuGuLevelView = class("ActDuDuGuLevelView", BaseView)

function ActDuDuGuLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._golvpath = gohelper.findChild(self.viewGO, "#go_lvpath")
	self._golvScroll = gohelper.findChild(self.viewGO, "#go_lvpath/#go_lvScroll")
	self._golvstages = gohelper.findChild(self.viewGO, "#go_lvpath/#go_lvScroll/#go_lvstages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnPlayBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Title/#btn_PlayBtn")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self._goPath = gohelper.findChild(self._golvScroll, "path/path_2")
	self._animPath = self._goPath:GetComponent(gohelper.Type_Animator)

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._animTask = goTaskAnim:GetComponent(gohelper.Type_Animator)
	self._scrolllv = gohelper.findChildScrollRect(self._golvpath, "")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActDuDuGuLevelView:addEvents()
	self._btnPlayBtn:AddClickListener(self._btnPlayBtnOnClick, self)
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._animEvent:AddEventListener(RoleActivityEnum.AnimEvt.OnStoryOpenEnd, self._onStoryOpenEnd, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function ActDuDuGuLevelView:removeEvents()
	self._btnPlayBtn:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._animEvent:RemoveEventListener(RoleActivityEnum.AnimEvt.OnStoryOpenEnd)
	self._btnTrial:RemoveClickListener()
end

function ActDuDuGuLevelView:_btnPlayBtnOnClick()
	if self.actConfig.storyId > 0 then
		StoryController.instance:playStory(self.actConfig.storyId)
	end
end

function ActDuDuGuLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.ActDuDuGuTaskView)
end

function ActDuDuGuLevelView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actConfig.tryoutEpisode

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

function ActDuDuGuLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actConfig.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function ActDuDuGuLevelView:_addEvents()
	self.addEventCb(self, RoleActivityController.instance, RoleActivityEvent.StoryItemClick, self.OnLvItemClick, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self.OnStoryFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.OnEndDungeonPush, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self.OnDotChange, self)
end

function ActDuDuGuLevelView:_editableInitView()
	self.actId = VersionActivity2_3Enum.ActivityId.DuDuGu
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._golvpath)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._golvpath)

	self._touch:AddClickDownListener(self._onClickDown, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._golvpath, DungeonMapEpisodeAudio, self._scrolllv)
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")

	ActDuDuGuModel.instance:initData(self.actId)
	self:_initStageItems()
	gohelper.setActive(self._btnPlayBtn, self.actConfig.storyId > 0)
	self:_addEvents()
end

function ActDuDuGuLevelView:onOpen()
	local goreddot = gohelper.findChild(self._btnTask.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)
	self:_initPathStatus()
	self:OnDotChange()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)

	if self:_checkFirstEnter() then
		self:_lockScreen(true)
		self._lvItems[1]:lockStatus()
		TaskDispatcher.runDelay(self._playFirstUnlock, self, 0.8)
	end
end

function ActDuDuGuLevelView:_playStoryFinishAnim()
	local newFinishStoryLvlId = ActDuDuGuModel.instance:getNewFinishStoryLvl()

	if newFinishStoryLvlId then
		for k, storyItem in ipairs(self._lvItems) do
			if storyItem.id == newFinishStoryLvlId then
				self:_lockScreen(true)

				self.finishStoryIndex = k

				storyItem:playFinish()
				storyItem:playStarAnim()
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.34)

				break
			end
		end

		ActDuDuGuModel.instance:clearNewFinishStoryLvl()
	end
end

function ActDuDuGuLevelView:_checkFirstEnter()
	if not self._lvItems[2]:isUnlock() then
		local record = PlayerPrefsHelper.getNumber("ActDuDuGuFirstEnter", 0)

		if record == 0 then
			PlayerPrefsHelper.setNumber("ActDuDuGuFirstEnter", 1)

			return true
		end
	end

	return false
end

function ActDuDuGuLevelView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._playFirstUnlock, self)
	TaskDispatcher.cancelTask(self._delayOpenStory, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._playPathAnim, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	self:_lockScreen(false)
end

function ActDuDuGuLevelView:onDestroyView()
	self._lvItems = nil

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end
end

function ActDuDuGuLevelView:OnLvItemClick(index)
	self:_focusLvItem(index, true)
end

function ActDuDuGuLevelView:OnStoryFinish()
	local newFinishStoryLvlId = ActDuDuGuModel.instance:getNewFinishStoryLvl()

	if newFinishStoryLvlId then
		if self._lvItems[self._curLvIndex + 1] then
			self._curLvIndex = self._curLvIndex + 1 or self._curLvIndex
		end

		self:_focusLvItem(self._curLvIndex, false)
	end

	TaskDispatcher.runDelay(self._delayOpenStory, self, 0.4)
end

function ActDuDuGuLevelView:OnEndDungeonPush()
	local newFinishStoryLvlId = ActDuDuGuModel.instance:getNewFinishStoryLvl()

	if newFinishStoryLvlId then
		if self._lvItems[self._curLvIndex + 1] then
			self._curLvIndex = self._curLvIndex + 1 or self._curLvIndex
		end

		self:_focusLvItem(self._curLvIndex, false)
	end

	ActDuDuGuModel.instance:updateData(self.actId)
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 0.73)
end

function ActDuDuGuLevelView:OnDotChange()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)

	if isDotShow then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function ActDuDuGuLevelView:_onStoryOpenEnd()
	self:_initPathStatus()

	local newFinishStoryLvlId = ActDuDuGuModel.instance:getNewFinishStoryLvl()

	if newFinishStoryLvlId then
		self:_playStoryFinishAnim()
		ActDuDuGuModel.instance:updateData(self.actId)
	end
end

function ActDuDuGuLevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function ActDuDuGuLevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function ActDuDuGuLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function ActDuDuGuLevelView:_initStageItems()
	local levelCount, path

	path = self.viewContainer:getSetting().otherRes[1]
	self._lvItems = {}

	local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(self.actId)

	for i = 1, #storyConfigList do
		local stageGo = gohelper.findChild(self._golvstages, "stage" .. i)
		local cloneGo = self:getResInst(path, stageGo)

		self._lvItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, ActDuDuGuLevelItem, self)

		self._lvItems[i]:setParam(storyConfigList[i], i, self.actId)

		if self._lvItems[i]:isUnlock() then
			self._curLvIndex = i
		end
	end

	local curLvIndex = ActDuDuGuModel.instance:getCurLvIndex()

	self._curLvIndex = curLvIndex > 0 and curLvIndex or self._curLvIndex

	self:_focusLvItem(self._curLvIndex)
end

function ActDuDuGuLevelView:_playFirstUnlock()
	self.finishStoryIndex = 0

	self._lvItems[1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 2)
end

function ActDuDuGuLevelView:_unlockLvEnd()
	self._lvItems[self.finishStoryIndex + 1]:refreshStatus()

	self.finishStoryIndex = nil

	self:_lockScreen(false)
end

function ActDuDuGuLevelView:_finishStoryEnd()
	if self.finishStoryIndex == #self._lvItems then
		self._curLvIndex = self.finishStoryIndex
		self.finishStoryIndex = nil

		self:_lockScreen(false)
	else
		self._curLvIndex = self.finishStoryIndex + 1

		self:_playPathAnim()
	end
end

function ActDuDuGuLevelView:_playPathAnim()
	local animName = "go" .. self.finishStoryIndex

	self._animPath.speed = 1

	self._animPath:Play(animName)
	TaskDispatcher.runDelay(self._unlockStory, self, 0.33)
end

function ActDuDuGuLevelView:_unlockStory()
	self._lvItems[self.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 2)
end

function ActDuDuGuLevelView:_delayOpenStory()
	self._anim:Play("openstory", 0, 0)
end

function ActDuDuGuLevelView:_showLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ActDuDuGuLevelView:_initPathStatus()
	if self._curLvIndex > 1 then
		self._animPath:Play("go" .. self._curLvIndex - 1, 0, 1)
	else
		self._animPath.speed = 0

		self._animPath:Play("go1", 0, 0)
	end
end

function ActDuDuGuLevelView:_focusLvItem(index, needPlay)
	local targetY = index < 3 and 540 or 540 + (index - 3) * 920 / 5

	if needPlay then
		ZProj.TweenHelper.DOLocalMoveY(self._golvScroll.transform, targetY, 0.26, self._onFocusEnd, self, index)
	else
		ZProj.TweenHelper.DOLocalMoveY(self._golvScroll.transform, targetY, 0.26)
	end

	ActDuDuGuModel.instance:setCurLvIndex(index)
end

function ActDuDuGuLevelView:_onFocusEnd(index)
	return
end

function ActDuDuGuLevelView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DuDuGuLock")
	else
		UIBlockMgr.instance:endBlock("DuDuGuLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return ActDuDuGuLevelView
