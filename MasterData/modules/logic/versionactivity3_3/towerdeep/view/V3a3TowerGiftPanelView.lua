-- chunkname: @modules/logic/versionactivity3_3/towerdeep/view/V3a3TowerGiftPanelView.lua

module("modules.logic.versionactivity3_3.towerdeep.view.V3a3TowerGiftPanelView", package.seeall)

local V3a3TowerGiftPanelView = class("V3a3TowerGiftPanelView", BaseView)

V3a3TowerGiftPanelView.TaskId = 530010

function V3a3TowerGiftPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txttime = gohelper.findChildText(self.viewGO, "root/simage_fullbg/#txt_time")
	self._gotask1 = gohelper.findChild(self.viewGO, "root/#go_task1")
	self._gotask2 = gohelper.findChild(self.viewGO, "root/#go_task2")
	self._gotask3 = gohelper.findChild(self.viewGO, "root/#go_task3")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_goto")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/icon_bg/go_canget")
	self._golock = gohelper.findChild(self.viewGO, "root/#btn_goto/go_lock")
	self._gocanget = gohelper.findChild(self.viewGO, "root/icon_bg/go_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "root/icon_bg/go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a3TowerGiftPanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnclick:AddClickListener(self._btn1ClaimOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.checkBgm, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
end

function V3a3TowerGiftPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.checkBgm, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
end

function V3a3TowerGiftPanelView:_btncloseOnClick()
	self:closeThis()
end

function V3a3TowerGiftPanelView:_btn1ClaimOnClick()
	if not self:checkReceied(self._taskMo) and self:checkCanGet(self._taskMo) then
		TaskRpc.instance:sendFinishTaskRequest(self._taskMo.id)
	end
end

function V3a3TowerGiftPanelView:_btngotoOnClick()
	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		TowerComposeController.instance:openTowerComposeMainView()

		if not self:checkReceied(self._taskMo) then
			TaskRpc.instance:sendFinishReadTaskRequest(V3a3TowerGiftFullView.TaskId)
		end

		self._bgmId = BGMSwitchModel.instance:getCurBgm()
	else
		local canJump, toastId, toastParamList = JumpController.instance:canJumpNew(JumpEnum.JumpView.Tower)

		if not canJump then
			GameFacade.showToastWithTableParam(toastId, toastParamList)

			return false
		end
	end
end

function V3a3TowerGiftPanelView:refreshUI()
	self._taskMo = TaskModel.instance:getTaskById(V3a3TowerGiftPanelView.TaskId)

	local isopen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)

	gohelper.setActive(self._golock, not isopen)

	local received = self:checkReceied(self._taskMo)
	local canget = self:checkCanGet(self._taskMo)

	gohelper.setActive(self._gocanget, canget)
	gohelper.setActive(self._gohasget, received)

	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V3a3_TowerDeep)
end

function V3a3TowerGiftPanelView:checkCanGet(taskMo)
	if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
		return true
	end

	return false
end

function V3a3TowerGiftPanelView:checkReceied(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function V3a3TowerGiftPanelView:checkBgm(viewName)
	if viewName == ViewName.TowerMainView then
		if self._bgmId and self._bgmId ~= -1 then
			local bgmSwitchCO = BGMSwitchConfig.instance:getBGMSwitchCO(self._bgmId)
			local audioId = bgmSwitchCO and bgmSwitchCO.audio

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, audioId)
		else
			local usedBgmId = BGMSwitchModel.instance:getUsedBgmIdFromServer()

			if BGMSwitchModel.instance:isRandomBgmId(usedBgmId) then
				usedBgmId = BGMSwitchModel.instance:nextBgm(1, true)
			end

			local bgmSwitchCO = BGMSwitchConfig.instance:getBGMSwitchCO(usedBgmId)

			if bgmSwitchCO then
				if not bgmSwitchCO.audio then
					local audioId = AudioEnum.UI.Play_Replay_Music_Daytime

					AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, audioId)
				end
			end
		end
	end
end

function V3a3TowerGiftPanelView:_onFinishTask()
	self._taskMo = TaskModel.instance:getTaskById(V3a3TowerGiftPanelView.TaskId)

	local received = self:checkReceied(self._taskMo)
	local canget = self:checkCanGet(self._taskMo)

	gohelper.setActive(self._gocanget, canget)
	gohelper.setActive(self._gohasget, received)
end

function V3a3TowerGiftPanelView:_updateItem(id)
	if id == V3a3TowerGiftPanelView.TaskId then
		gohelper.setActive(self._gocanget, true)
	end
end

function V3a3TowerGiftPanelView:_editableInitView()
	return
end

function V3a3TowerGiftPanelView:onUpdateParam()
	return
end

function V3a3TowerGiftPanelView:onOpen()
	TaskRpc.instance:sendGetTaskInfoRequest({
		Activity189Config.instance:getTaskType()
	}, self.refreshUI, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function V3a3TowerGiftPanelView:onClose()
	return
end

function V3a3TowerGiftPanelView:onDestroyView()
	return
end

return V3a3TowerGiftPanelView
