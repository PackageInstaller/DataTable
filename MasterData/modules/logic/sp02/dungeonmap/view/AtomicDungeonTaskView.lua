-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonTaskView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonTaskView", package.seeall)

local AtomicDungeonTaskView = class("AtomicDungeonTaskView", BaseView)

function AtomicDungeonTaskView:onInitView()
	self._goLimitTime = gohelper.findChild(self.viewGO, "Left/LimitTime")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonTaskView:addEvents()
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseTaskView, self.closeThis, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnLoadSceneFinish, self.closeThis, self)
end

function AtomicDungeonTaskView:removeEvents()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseTaskView, self.closeThis, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnLoadSceneFinish, self.closeThis, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

AtomicDungeonTaskView.TaskMaskTime = 0.65
AtomicDungeonTaskView.TaskGetAnimTime = 0.567

function AtomicDungeonTaskView:_btncloseFullViewOnClick()
	self:closeThis()
end

function AtomicDungeonTaskView:_btncloseOnClick()
	self:closeThis()
end

function AtomicDungeonTaskView:_btnBigRewardClick(rewardData)
	MaterialTipController.instance:showMaterialInfo(rewardData[1], rewardData[2], false)
end

function AtomicDungeonTaskView:_editableInitView()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer.scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(AtomicDungeonTaskView.TaskMaskTime - AtomicDungeonTaskView.TaskGetAnimTime)

	self.removeIndexTab = {}
	self._btnRewardMap = self:getUserDataTb_()

	local bigRewardStr = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.TaskBigRewards)

	self.bigRewardDataList = GameUtil.splitString2(bigRewardStr, true)

	for index, rewardData in ipairs(self.bigRewardDataList) do
		local reward = {}

		reward.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Left/node_reward/#btn_reward" .. index)

		reward.btnReward:AddClickListener(self._btnBigRewardClick, self, rewardData)

		self._btnRewardMap[index] = reward
	end
end

function AtomicDungeonTaskView:onUpdateParam()
	return
end

function AtomicDungeonTaskView:onOpen()
	self._scrollTaskList.verticalNormalizedPosition = 1

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mission_open)
	self:refreshUI()
end

function AtomicDungeonTaskView:refreshUI()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function AtomicDungeonTaskView:refreshRemainTime()
	local timeStamp = ActivityModel.instance:getRemainTimeSec(VersionActivity3_10Enum.ActivityId.Outside)

	if timeStamp and timeStamp > 0 then
		self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(timeStamp)

		gohelper.setActive(self._goLimitTime, true)
	else
		self._txtLimitTime.text = ""

		gohelper.setActive(self._goLimitTime, false)
	end
end

function AtomicDungeonTaskView:_playGetRewardFinishAnim(index)
	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, AtomicDungeonTaskView.TaskGetAnimTime)
end

function AtomicDungeonTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function AtomicDungeonTaskView:onClose()
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)

	for _, reward in pairs(self._btnRewardMap) do
		reward.btnReward:RemoveClickListener()
	end
end

function AtomicDungeonTaskView:onDestroyView()
	return
end

return AtomicDungeonTaskView
