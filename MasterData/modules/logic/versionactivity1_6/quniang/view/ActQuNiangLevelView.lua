-- chunkname: @modules/logic/versionactivity1_6/quniang/view/ActQuNiangLevelView.lua

module("modules.logic.versionactivity1_6.quniang.view.ActQuNiangLevelView", package.seeall)

local ActQuNiangLevelView = class("ActQuNiangLevelView", BaseView)

function ActQuNiangLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._gofightPath = gohelper.findChild(self.viewGO, "#go_fightPath")
	self._gofightScroll = gohelper.findChild(self.viewGO, "#go_fightPath/#go_fightScroll")
	self._gofightStages = gohelper.findChild(self.viewGO, "#go_fightPath/#go_fightScroll/#go_fightStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnPlayBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Title/#btn_PlayBtn")
	self._btnStory = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Story")
	self._goStoryN = gohelper.findChild(self._btnStory.gameObject, "go_UnSelected")
	self._goStoryS = gohelper.findChild(self._btnStory.gameObject, "go_Selected")
	self._btnFight = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Fight")
	self._goFightN = gohelper.findChild(self._btnFight.gameObject, "go_UnSelected")
	self._goFightS = gohelper.findChild(self._btnFight.gameObject, "go_Selected")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	local goPath = gohelper.findChild(self._gostoryScroll, "path/path_2")

	self._animPath = goPath:GetComponent(gohelper.Type_Animator)

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._animTask = goTaskAnim:GetComponent(gohelper.Type_Animator)
	self._scrollStory = gohelper.findChildScrollRect(self._gostoryPath, "")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActQuNiangLevelView:addEvents()
	self._btnPlayBtn:AddClickListener(self._btnPlayBtnOnClick, self)
	self._btnStory:AddClickListener(self._btnStoryOnClick, self)
	self._btnFight:AddClickListener(self._btnFightOnClick, self)
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._animEvent:AddEventListener(ActQuNiangEnum.AnimEvt.OnStoryOpenEnd, self._onStoryOpenEnd, self)
	self._animEvent:AddEventListener(ActQuNiangEnum.AnimEvt.OnFightOpenEnd, self._onFightOpenEnd, self)
	self._animEvent:AddEventListener(ActQuNiangEnum.AnimEvt.OnGoStoryEnd, self._onGoStoryEnd, self)
end

function ActQuNiangLevelView:removeEvents()
	self._btnPlayBtn:RemoveClickListener()
	self._btnStory:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._btnTask:RemoveClickListener()
end

function ActQuNiangLevelView:_btnPlayBtnOnClick()
	if self.actConfig.storyId > 0 then
		StoryController.instance:playStory(self.actConfig.storyId)
	end
end

function ActQuNiangLevelView:_btnStoryOnClick(isOpen)
	if self._gostoryPath.activeInHierarchy then
		return
	end

	gohelper.setActive(self._goStoryN, false)
	gohelper.setActive(self._goStoryS, true)
	gohelper.setActive(self._goFightN, true)
	gohelper.setActive(self._goFightS, false)
	gohelper.setActive(self._btnPlayBtn, self.actConfig.storyId > 0)

	if isOpen then
		self._anim:Play("openstory", -1, 0)
	else
		self._anim:Play("gostory", -1, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_switch)
	end
end

function ActQuNiangLevelView:_btnFightOnClick(isOpen)
	if self._gofightPath.activeInHierarchy then
		return
	end

	gohelper.setActive(self._goStoryN, true)
	gohelper.setActive(self._goStoryS, false)
	gohelper.setActive(self._goFightN, false)
	gohelper.setActive(self._goFightS, true)
	gohelper.setActive(self._btnPlayBtn, false)

	if isOpen then
		self._anim:Play("openfight", -1, 0)
	else
		self._anim:Play("gofight", -1, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_switch)
	end
end

function ActQuNiangLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.ActQuNiangTaskView)
end

function ActQuNiangLevelView:_editableInitView()
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = -300

	self._offsetX = (width - rightOffsetX) / 2
	self.minContentAnchorX = -4660 + width
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)

	self._touch:AddClickDownListener(self._onClickDown, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)

	ActQuNiangModel.instance:initData()
	self:_initStageItems()

	self.enterConfig = RoleActivityConfig.instance:getActivityEnterInfo(ActQuNiangEnum.ActivityId)
	self.actConfig = ActivityConfig.instance:getActivityCo(ActQuNiangEnum.ActivityId)

	gohelper.setActive(self._gotime, false)
	gohelper.setActive(self._btnPlayBtn, self.actConfig.storyId > 0)
end

function ActQuNiangLevelView:onOpen()
	self.addEventCb(self, ActQuNiangController.instance, ActQuNiangEvent.StoryItemClick, self.OnStoryItemClick, self)
	self.addEventCb(self, ActQuNiangController.instance, ActQuNiangEvent.FightItemClick, self.OnFightItemClick, self)
	self.addEventCb(self, ActQuNiangController.instance, ActQuNiangEvent.TabSwitch, self.OnTabSwitch, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self.OnStoryFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.OnEndDungeonPush, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self.OnDotChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.OnCheckActEnd, self)

	local goreddot = gohelper.findChild(self._btnTask.gameObject, "#go_reddot")
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Role1)

	RedDotController.instance:addRedDot(goreddot, act1MO.redDotId, VersionActivity1_6Enum.ActivityId.Role1)
	self:OnDotChange()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)

	if self.viewParam and self.viewParam.needShowFight then
		local fightIndex = ActQuNiangModel.instance:getEnterFightIndex()

		if fightIndex then
			self.latestfightItem = fightIndex

			for _, fightItem in ipairs(self.fightItemList) do
				fightItem:refreshSelect(fightIndex)
			end
		end

		self:_btnFightOnClick(true)
		self:_lockScreen(true)
		TaskDispatcher.runDelay(self._delayOpenFight, self, 0.3)
	else
		self:_btnStoryOnClick(true)

		local firstEnter = ActQuNiangModel.instance:getFirstEnter()

		if firstEnter then
			ActQuNiangModel.instance:clearFirstEnter()
			self:_lockScreen(true)
			self.storyItemList[1]:lockStatus()
			TaskDispatcher.runDelay(self._playFirstUnlock, self, 0.8)
		end
	end
end

function ActQuNiangLevelView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._delayOpenFight, self)
	TaskDispatcher.cancelTask(self._playFirstUnlock, self)
	TaskDispatcher.cancelTask(self._delayOpenStory, self)
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._playPathAnim, self)
	TaskDispatcher.cancelTask(self._unlockFightEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._starShowEnd, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	self:_lockScreen(false)
end

function ActQuNiangLevelView:onDestroyView()
	self.storyItemList = nil
	self.fightItemList = nil

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

function ActQuNiangLevelView:OnStoryItemClick(index)
	self:_focusStoryItem(index, true)
end

function ActQuNiangLevelView:OnFightItemClick(_index)
	if self.latestfightItem == _index then
		return
	end

	self.latestfightItem = _index

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_click)

	for _, fightItem in ipairs(self.fightItemList) do
		fightItem:refreshSelect(_index)
	end
end

function ActQuNiangLevelView:OnTabSwitch(needShowFight)
	if needShowFight then
		self:_btnFightOnClick()
	else
		self:_btnStoryOnClick()
	end
end

function ActQuNiangLevelView:OnStoryFinish()
	TaskDispatcher.runDelay(self._delayOpenStory, self, 0.4)
end

function ActQuNiangLevelView:OnEndDungeonPush()
	ActQuNiangModel.instance:updateData()
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 0.73)
end

function ActQuNiangLevelView:OnDotChange()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V1a6RoleActivityTask, ActQuNiangEnum.ActivityId)

	if isDotShow then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function ActQuNiangLevelView:OnCheckActEnd(actId)
	if string.nilorempty(actId) or actId == 0 then
		return
	end

	if actId ~= ActQuNiangEnum.ActivityId then
		return
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, NavigateButtonsView.homeClick)
	end
end

function ActQuNiangLevelView:_onStoryOpenEnd()
	self:_initPathStatus()
end

function ActQuNiangLevelView:_onFightOpenEnd()
	self:_playFightFinishAnim()
end

function ActQuNiangLevelView:_onGoStoryEnd()
	self:_initPathStatus()
end

function ActQuNiangLevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function ActQuNiangLevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function ActQuNiangLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function ActQuNiangLevelView:_initStageItems()
	local levelCount, path

	path = self.viewContainer:getSetting().otherRes[1]
	self.storyItemList = {}

	local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(ActQuNiangEnum.ActivityId)

	levelCount = #storyConfigList

	for i = 1, #storyConfigList do
		local stageGo = gohelper.findChild(self._gostoryStages, "stage" .. i)
		local cloneGo = self:getResInst(path, stageGo)

		self.storyItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, QuNiangStoryItem, self)

		self.storyItemList[i]:setParam(storyConfigList[i], i)

		if self.storyItemList[i]:isUnlock() then
			self.latestStoryItem = i
		end
	end

	self:_focusStoryItem(self.latestStoryItem)

	path = self.viewContainer:getSetting().otherRes[2]
	self.fightItemList = {}

	local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(ActQuNiangEnum.ActivityId)

	for i = 1, #fightConfigList / 2 do
		local stageGo = gohelper.findChild(self._gofightStages, "stage" .. i)
		local cloneGo = self:getResInst(path, stageGo)

		self.fightItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, QuNiangFightItem, self)

		self.fightItemList[i]:setParam(fightConfigList[2 * i - 1], i)

		if self.fightItemList[i]:isUnlock() then
			self.latestfightItem = i
		end
	end

	self.fightItemList[self.latestfightItem]:refreshSelect()
end

function ActQuNiangLevelView:_playFirstUnlock()
	self.finishStoryIndex = 0

	self.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 0.83)
end

function ActQuNiangLevelView:_playStoryFinishAnim()
	local newFinishStoryLvlId = ActQuNiangModel.instance:getNewFinishStoryLvl()

	if newFinishStoryLvlId then
		for k, storyItem in ipairs(self.storyItemList) do
			if storyItem.id == newFinishStoryLvlId then
				self:_lockScreen(true)

				self.finishStoryIndex = k

				storyItem:playFinish()
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)

				break
			end
		end

		ActQuNiangModel.instance:clearNewFinishStoryLvl()
	end
end

function ActQuNiangLevelView:_finishStoryEnd()
	self.storyItemList[self.finishStoryIndex]:refreshStatus()
	self.storyItemList[self.finishStoryIndex]:playStarAnim()

	if self.finishStoryIndex == #self.storyItemList then
		self.latestStoryItem = self.finishStoryIndex
		self.finishStoryIndex = nil

		self:_lockScreen(false)
	else
		self.latestStoryItem = self.finishStoryIndex + 1

		TaskDispatcher.runDelay(self._playPathAnim, self, 0.67)
	end
end

function ActQuNiangLevelView:_playPathAnim()
	local animName = "go" .. self.finishStoryIndex

	self._animPath.speed = 1

	self._animPath:Play(animName)
	TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
end

function ActQuNiangLevelView:_unlockStory()
	self.storyItemList[self.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1.7)
end

function ActQuNiangLevelView:_unlockStoryEnd()
	self.storyItemList[self.finishStoryIndex + 1]:refreshStatus()

	self.finishStoryIndex = nil

	self:_lockScreen(false)
end

function ActQuNiangLevelView:_playFightFinishAnim()
	ActQuNiangModel.instance:updateData()

	local newFinishFightLvlId = ActQuNiangModel.instance:getNewFinishFightLvl()

	if newFinishFightLvlId then
		for k, fightItem in ipairs(self.fightItemList) do
			if fightItem.id == newFinishFightLvlId then
				self.finishFightIndex = k

				fightItem:refreshStar()
				fightItem:playStarAnim(true)
				TaskDispatcher.runDelay(self._starShowEnd, self, 0.67)

				break
			elseif fightItem.hardConfig.id == newFinishFightLvlId then
				fightItem:refreshStar()
				fightItem:playStarAnim()
				self:_lockScreen(false)

				break
			end
		end

		ActQuNiangModel.instance:clearNewFinishFightLvl()

		return
	end

	self:_lockScreen(false)
end

function ActQuNiangLevelView:_starShowEnd()
	self.fightItemList[self.finishFightIndex]:playHardUnlock()
	TaskDispatcher.runDelay(self._unlockFightEnd, self, 1.7)

	if self.fightItemList[self.finishFightIndex + 1] then
		self.fightItemList[self.finishFightIndex + 1]:playUnlock()
	end
end

function ActQuNiangLevelView:_unlockFightEnd()
	self.fightItemList[self.finishFightIndex]:refreshStatus()

	if self.fightItemList[self.finishFightIndex + 1] then
		self.fightItemList[self.finishFightIndex + 1]:refreshStatus()
	end

	self.finishFightIndex = nil

	self:_lockScreen(false)
end

function ActQuNiangLevelView:_delayOpenStory()
	self._anim:Play("openstory", -1, 0)
end

function ActQuNiangLevelView:_delayOpenFight()
	self._anim:Play("openfight", -1, 0)
end

function ActQuNiangLevelView:_showLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(ActQuNiangEnum.ActivityId)
end

function ActQuNiangLevelView:_initPathStatus()
	if self.latestStoryItem > 1 then
		self._animPath:Play("go" .. self.latestStoryItem - 1, -1, 1)
	else
		self._animPath.speed = 0

		self._animPath:Play("go1", -1, 0)
	end
end

function ActQuNiangLevelView:_focusStoryItem(index, needPlay)
	local contentAnchorX = recthelper.getAnchorX(self.storyItemList[index].transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if needPlay then
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, 0.26, self._onFocusEnd, self, index)
	else
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, 0.26)
	end
end

function ActQuNiangLevelView:_onFocusEnd(index)
	self.storyItemList[index]:playStory()
end

function ActQuNiangLevelView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("finishAnim")
	else
		UIBlockMgr.instance:endBlock("finishAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return ActQuNiangLevelView
