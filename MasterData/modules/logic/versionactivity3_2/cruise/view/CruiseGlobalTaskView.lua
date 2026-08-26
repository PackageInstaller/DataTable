-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseGlobalTaskView.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseGlobalTaskView", package.seeall)

local CruiseGlobalTaskView = class("CruiseGlobalTaskView", BaseView)

function CruiseGlobalTaskView:onInitView()
	self._gotime = gohelper.findChild(self.viewGO, "content/#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "content/#go_time/#txt_time")
	self._imagepersonmask = gohelper.findChildImage(self.viewGO, "content/middle/#image_personmask")
	self._gonamebg = gohelper.findChild(self.viewGO, "content/middle/#go_namebg")
	self._txtnamenum = gohelper.findChildText(self.viewGO, "content/middle/#go_namebg/#txt_namenum")
	self._goComplete = gohelper.findChild(self.viewGO, "content/middle/#image_complete")
	self._doll = gohelper.findChild(self.viewGO, "content/middle/#go_doll")
	self._gotaskitem = gohelper.findChild(self.viewGO, "content/#go_taskitem")
	self._gotask1 = gohelper.findChild(self.viewGO, "content/#go_task1")
	self._gotask2 = gohelper.findChild(self.viewGO, "content/#go_task2")
	self._gotask3 = gohelper.findChild(self.viewGO, "content/#go_task3")
	self._gotask4 = gohelper.findChild(self.viewGO, "content/#go_task4")
	self._btnbubble = gohelper.findChildButtonWithAudio(self.viewGO, "content/bottom/first/#btn_bubble")
	self._txtin = gohelper.findChildText(self.viewGO, "content/bottom/first/#btn_bubble/#txt_in")
	self._txtbubblenum = gohelper.findChildText(self.viewGO, "content/bottom/first/#btn_bubble/#txt_bubblenum")
	self._gonum = gohelper.findChild(self.viewGO, "content/bottom/first/#go_num")
	self._txtnum = gohelper.findChildText(self.viewGO, "content/bottom/first/#go_num/#txt_num")
	self._goGrayLine = gohelper.findChild(self.viewGO, "content/bottom/#go_GrayLine")
	self._imagenormalline = gohelper.findChildImage(self.viewGO, "content/bottom/#go_NormalLine")
	self._goprogressitem = gohelper.findChild(self.viewGO, "content/bottom/#scroll_reward/Viewport/#go_content/#go_progressitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CruiseGlobalTaskView:addEvents()
	self._btnbubble:AddClickListener(self._btnbubbleOnClick, self)
end

function CruiseGlobalTaskView:removeEvents()
	self._btnbubble:RemoveClickListener()
end

function CruiseGlobalTaskView:_addSelfEvents()
	self.addEventCb(self, Activity215Controller.instance, Activity215Event.onItemSubmitCountChange, self._refresh, self)
	self.addEventCb(self, Activity215Controller.instance, Activity215Event.onAcceptedRewardIdChange, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.addEventCb(self, Activity215Controller.instance, Activity215Event.OnInfoChanged, self._refresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseGlobalTaskView:_removeSelfEvents()
	self.removeEventCb(self, Activity215Controller.instance, Activity215Event.onItemSubmitCountChange, self._refresh, self)
	self.removeEventCb(self, Activity215Controller.instance, Activity215Event.onAcceptedRewardIdChange, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.removeEventCb(self, Activity215Controller.instance, Activity215Event.OnInfoChanged, self._refresh, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseGlobalTaskView:_onCheckActState()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseGlobalTask
	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	self:_refresh()
end

function CruiseGlobalTaskView:_btnbubbleOnClick()
	local itemCos = string.splitToNumber(Activity215Config.instance:getConstCO(1).value, "#")
	local itemCount = ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2])

	if itemCount < 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_shengyan_box_shijie_reward)
	self._bubbleAnim:Play("out", 0, 0)
	self._flowerAnim:Play("change", 0, 0)

	local delayTime = 1

	TaskDispatcher.runDelay(self._onOutFinished, self, delayTime)
	Activity215Rpc.instance:sendSubmitAct215ItemRequest(self._actId, itemCount)
end

function CruiseGlobalTaskView:_onOutFinished()
	gohelper.setActive(self._btnbubble.gameObject, false)
end

function CruiseGlobalTaskView:_editableInitView()
	self._bubbleAnim = self._btnbubble.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._flowerAnim = self._doll:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._btnbubble.gameObject, false)

	self._completeAnim = self._goComplete:GetComponent(typeof(UnityEngine.Animator))
	self._txttime.text = ""
	self._taskItems = self:getUserDataTb_()

	gohelper.setActive(self._gotaskitem, false)

	self._progressItems = self:getUserDataTb_()

	gohelper.setActive(self._goprogressitem, false)

	self._dollItem = self:getUserDataTb_()
	self._dollItem.lvGos = self:getUserDataTb_()
	self._dollItem.lvMaskGos = self:getUserDataTb_()

	for i = 1, 5 do
		local go = gohelper.findChild(self.viewGO, "content/middle/#go_doll/#go_level" .. tostring(i))

		table.insert(self._dollItem.lvGos, go)

		local maskGo = gohelper.findChild(self.viewGO, string.format("content/middle/#go_doll/#go_level%s/mask/image_dec6", i))

		table.insert(self._dollItem.lvMaskGos, maskGo)
	end

	self:_addSelfEvents()
end

function CruiseGlobalTaskView:onUpdateParam()
	return
end

function CruiseGlobalTaskView:onOpen()
	self._actId = VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	local isComplete = CruiseModel.instance:getCurDollStage() == 4

	if isComplete then
		AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_shengyan_box_shijie_complete)
	else
		AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_tangren_qiandao_open)
	end

	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh(true)
	Activity215Rpc.instance:sendRefreshAct215LastViewItemRequest(self._actId, self._onLastViewCallback, self)
end

function CruiseGlobalTaskView:_onLastViewCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.lastViewTotalItem < msg.currentViewTotalItem then
		local count = msg.currentViewTotalItem - msg.lastViewTotalItem
		local itemCos = string.splitToNumber(Activity215Config.instance:getConstCO(1).value, "#")
		local co = {}
		local o = MaterialDataMO.New()

		o:initValue(itemCos[1], itemCos[2], count)
		table.insert(co, o)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
	end
end

function CruiseGlobalTaskView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function CruiseGlobalTaskView:_refresh(isOpen)
	self:_refreshUI()
	self:_refreshDoll()
	self:_refreshTasks(isOpen)
	self:_refreshProgresses(isOpen)
end

function CruiseGlobalTaskView:_refreshUI()
	local itemCos = string.splitToNumber(Activity215Config.instance:getConstCO(1).value, "#")
	local itemCount = ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2])

	if itemCount > 0 then
		self._txtbubblenum.text = itemCount

		if not self._btnbubble.gameObject.activeSelf then
			self._bubbleAnim:Play("in", 0, 0)
		end
	end

	local currentMainStage = Activity215Model.instance:getCurrentMainStage()
	local showBubble = currentMainStage == 1 and itemCount > 0

	gohelper.setActive(self._btnbubble.gameObject, showBubble)

	local submitCount = Activity215Model.instance:getItemSubmitCount(self._actId)
	local maxRewardId = Activity215Model.instance:getMaxRewardId(self._actId)
	local bonusCo = Activity215Config.instance:getMileStoneBonusCO(maxRewardId, self._actId)

	self._txtnum.text = string.format("%s/%s", submitCount, bonusCo.coinNum)
	self._imagenormalline.fillAmount = submitCount / Activity215Config.instance:getMileStoneBonusCO(maxRewardId, self._actId).coinNum
end

local maskPos = {
	{
		100,
		670
	},
	{
		92,
		680
	},
	{
		22,
		634
	},
	{
		25,
		633
	},
	{
		23,
		740
	}
}

function CruiseGlobalTaskView:_refreshDoll()
	local stage = CruiseModel.instance:getCurDollStage()

	self._stage = self._stage or stage

	local isComplete = stage == 4

	if isComplete and stage > self._stage then
		AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_shengyan_box_shijie_complete)
		self._completeAnim:Play("complete", 0, 0)
	end

	gohelper.setActive(self._goComplete, isComplete)
	gohelper.setActive(self._gonamebg, not isComplete)

	local showStage = isComplete and 5 or stage + 2

	for i = 1, 5 do
		gohelper.setActive(self._dollItem.lvGos[i], i == showStage)
	end

	if isComplete then
		gohelper.setActive(self._dollItem.lvMaskGos[5], false)
	else
		local curTaskId = Activity215Config.instance:getStageCO(stage + 1).globalTaskId
		local curTaskCo = Activity173Config.instance:getTaskConfig(curTaskId)
		local curTaskMO = TaskModel.instance:getTaskById(curTaskCo.id)

		if curTaskMO then
			if not (curTaskMO.progress / curTaskCo.maxProgress) then
				local scale = 0
				local posY = maskPos[showStage][1] + scale * (maskPos[showStage][2] - maskPos[showStage][1])
				local posX, _, _ = transformhelper.getLocalPos(self._dollItem.lvMaskGos[showStage].transform)

				transformhelper.setLocalPosXY(self._dollItem.lvMaskGos[showStage].transform, posX, posY)

				if stage > self._stage then
					gohelper.setActive(self._dollItem.lvMaskGos[showStage], false)
					TaskDispatcher.runDelay(function()
						gohelper.setActive(self._dollItem.lvMaskGos[showStage], true)
					end, nil, 0.001)
				else
					gohelper.setActive(self._dollItem.lvMaskGos[showStage], true)
				end
			end
		end
	end

	self._stage = stage
end

function CruiseGlobalTaskView:_refreshTasks(isOpen)
	local taskCos = Activity215Config.instance:getStageCos(self._actId)

	for index, taskCo in ipairs(taskCos) do
		if not self._taskItems[taskCo.stageId] then
			self._taskItems[taskCo.stageId] = CruiseGlobalTaskItem.New()

			local go = gohelper.clone(self._gotaskitem, self["_gotask" .. index])

			self._taskItems[taskCo.stageId]:init(go, index)
		end

		self._taskItems[taskCo.stageId]:refresh(taskCo)
	end
end

function CruiseGlobalTaskView:_refreshProgresses(isOpen)
	local bonusCos = Activity215Config.instance:getMileStoneBonusCos(self._actId)

	for index, bonusCo in ipairs(bonusCos) do
		if not self._progressItems[bonusCo.rewardId] then
			self._progressItems[bonusCo.rewardId] = CruiseGlobalTaskProgressItem.New()

			local go = gohelper.cloneInPlace(self._goprogressitem)

			self._progressItems[bonusCo.rewardId]:init(go, index)
		end

		self._progressItems[bonusCo.rewardId]:refresh(bonusCo)
	end
end

function CruiseGlobalTaskView:onClose()
	return
end

function CruiseGlobalTaskView:onDestroyView()
	TaskDispatcher.cancelTask(self._onCheckRefreshTaskInfo, self)
	self:_removeSelfEvents()

	if self._taskItems then
		for _, taskItem in pairs(self._taskItems) do
			taskItem:destroy()
		end

		self._taskItems = nil
	end

	if self._progressItems then
		for _, progressItem in pairs(self._progressItems) do
			progressItem:destroy()
		end

		self._progressItems = nil
	end

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

return CruiseGlobalTaskView
