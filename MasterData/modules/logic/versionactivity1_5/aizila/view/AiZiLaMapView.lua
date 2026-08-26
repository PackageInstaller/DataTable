-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaMapView.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaMapView", package.seeall)

local AiZiLaMapView = class("AiZiLaMapView", BaseView)

function AiZiLaMapView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "LeftTop/#simage_Title")
	self._goLimitTime = gohelper.findChild(self.viewGO, "LeftTop/LimitTime")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LeftTop/LimitTime/#txt_LimitTime")
	self._btnPlayBtn = gohelper.findChildButtonWithAudio(self.viewGO, "LeftTop/#btn_PlayBtn")
	self._btnHandBookBtn = gohelper.findChildButtonWithAudio(self.viewGO, "LeftBottom/#btn_HandBookBtn")
	self._goredHandBook = gohelper.findChild(self.viewGO, "LeftBottom/#btn_HandBookBtn/#go_redHandBook")
	self._btnRecordBtn = gohelper.findChildButtonWithAudio(self.viewGO, "LeftBottom/#btn_RecordBtn")
	self._goredRecord = gohelper.findChild(self.viewGO, "LeftBottom/#btn_RecordBtn/#go_redRecord")
	self._btnEquipBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightBottom/#btn_EquipBtn")
	self._goredEquip = gohelper.findChild(self.viewGO, "RightBottom/#btn_EquipBtn/#go_redEquip")
	self._btnTaskBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightBottom/#btn_TaskBtn")
	self._goredTask = gohelper.findChild(self.viewGO, "RightBottom/#btn_TaskBtn/#go_redTask")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaMapView:addEvents()
	self._btnPlayBtn:AddClickListener(self._btnPlayBtnOnClick, self)
	self._btnHandBookBtn:AddClickListener(self._btnHandBookBtnOnClick, self)
	self._btnRecordBtn:AddClickListener(self._btnRecordBtnOnClick, self)
	self._btnEquipBtn:AddClickListener(self._btnEquipBtnOnClick, self)
	self._btnTaskBtn:AddClickListener(self._btnTaskBtnOnClick, self)
end

function AiZiLaMapView:removeEvents()
	self._btnPlayBtn:RemoveClickListener()
	self._btnHandBookBtn:RemoveClickListener()
	self._btnRecordBtn:RemoveClickListener()
	self._btnEquipBtn:RemoveClickListener()
	self._btnTaskBtn:RemoveClickListener()
end

function AiZiLaMapView:_btnRecordBtnOnClick()
	ViewMgr.instance:openView(ViewName.AiZiLaRecordView)
end

function AiZiLaMapView:_btnPlayBtnOnClick()
	AiZiLaController.instance:playOpenStory(AiZiLaEnum.OpenStoryEpisodeId)
end

function AiZiLaMapView:_btnHandBookBtnOnClick()
	ViewMgr.instance:openView(ViewName.AiZiLaHandbookView)
end

function AiZiLaMapView:_btnEquipBtnOnClick()
	ViewMgr.instance:openView(ViewName.AiZiLaEquipView)
end

function AiZiLaMapView:_btnTaskBtnOnClick()
	ViewMgr.instance:openView(ViewName.AiZiLaTaskView)
end

function AiZiLaMapView:_editableInitView()
	self._goTaskTips = gohelper.findChild(self.viewGO, "RightBottom/TaskTips")
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	local prefabPath = AiZiLaStageItem.prefabPath

	self._stageItemList = {}
	self._checkTaskMO = AiZiLaTaskMO.New()
	self._episodeCfgList = AiZiLaConfig.instance:getEpisodeList(VersionActivity1_5Enum.ActivityId.AiZiLa) or {}

	local num = math.min(4, #self._episodeCfgList)

	for i = 1, num do
		local cloneGo = self:getResInst(prefabPath, gohelper.findChild(self.viewGO, "Map/Stage" .. i))
		local stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, AiZiLaStageItem, self)

		stageItem:setCfg(self._episodeCfgList[i])
		table.insert(self._stageItemList, stageItem)
	end

	RedDotController.instance:addRedDot(self._goredRecord, RedDotEnum.DotNode.V1a5AiZiLaRecord)
	RedDotController.instance:addRedDot(self._goredHandBook, RedDotEnum.DotNode.V1a5AiZiLaHandbook)
	RedDotController.instance:addRedDot(self._goredEquip, RedDotEnum.DotNode.V1a5AiZiLaEquip)
	RedDotController.instance:addRedDot(self._goredTask, RedDotEnum.DotNode.V1a5AiZiLaTask)
	gohelper.setActive(self._goLimitTime, false)
end

function AiZiLaMapView:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaMapView:onUpdateParam()
	return
end

function AiZiLaMapView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTaskUI, self)
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.EpisodePush, self._refreshStageItemList, self)
	self.addEventCb(self, AiZiLaGameController.instance, AiZiLaEvent.GameStoryPlayFinish, self._refreshStageItemList, self)
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.ExitGame, self._onExitGame, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:_refreshStageItemList()
	self:_showLeftTime()
	self:_refreshTaskUI()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self:_delayUnlockAnim(AiZiLaEnum.AnimatorTime.MapViewOpen)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_open)
end

function AiZiLaMapView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._onRefreshUnlockAnim, self)
	TaskDispatcher.cancelTask(self._onRefreshFinishAnim, self)
end

function AiZiLaMapView:onDestroyView()
	return
end

function AiZiLaMapView:_refreshStageItemList()
	for i = 1, #self._stageItemList do
		local item = self._stageItemList[i]

		item:refreshUI()
	end
end

function AiZiLaMapView:_onExitGame()
	local delay = 0.5

	if AiZiLaGameModel.instance:getIsFirstPass() then
		self._clearNewEpisodeId = AiZiLaGameModel.instance:getEpisodeId()

		TaskDispatcher.cancelTask(self._onRefreshFinishAnim, self)
		TaskDispatcher.runDelay(self._onRefreshFinishAnim, self, delay)

		delay = delay + 0.67
	end

	self:_delayUnlockAnim(delay)
end

function AiZiLaMapView:_onCloseViewFinish(viewName)
	if viewName == ViewName.StoryFrontView then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.V1a5AiZiLa)
	end
end

function AiZiLaMapView:_onClearNewEpisode(episodeId)
	return
end

function AiZiLaMapView:_delayUnlockAnim(delay)
	TaskDispatcher.cancelTask(self._onRefreshUnlockAnim, self)
	TaskDispatcher.runDelay(self._onRefreshUnlockAnim, self, delay)
end

function AiZiLaMapView:_onRefreshUnlockAnim()
	for i = 1, #self._stageItemList do
		local item = self._stageItemList[i]

		item:playUnlockAnim()
	end
end

function AiZiLaMapView:_onRefreshFinishAnim()
	for i = 1, #self._stageItemList do
		local item = self._stageItemList[i]

		if self._clearNewEpisodeId and item:getEpisodeId() == self._clearNewEpisodeId then
			self._clearNewEpisodeId = nil

			item:playFinish()
			item:refreshUI()
		end
	end
end

function AiZiLaMapView:_showLeftTime()
	self._txtLimitTime.text = AiZiLaHelper.getLimitTimeStr()
end

function AiZiLaMapView:_refreshTaskUI()
	gohelper.setActive(self._goTaskTips, self:_isNotFinishMainTask())
end

function AiZiLaMapView:_isNotFinishMainTask()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleAiZiLa)
	local taskCfgList = AiZiLaConfig.instance:getTaskList(VersionActivity1_5Enum.ActivityId.AiZiLa)
	local mo = self._checkTaskMO

	for _, taskCfg in ipairs(taskCfgList) do
		mo:init(taskCfg, taskDict and taskDict[taskCfg.id])

		if mo:isMainTask() and not mo:isFinished() then
			return true
		end
	end

	return false
end

return AiZiLaMapView
