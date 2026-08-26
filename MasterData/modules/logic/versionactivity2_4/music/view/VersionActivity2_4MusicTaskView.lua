-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicTaskView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTaskView", package.seeall)

local VersionActivity2_4MusicTaskView = class("VersionActivity2_4MusicTaskView", BaseView)

function VersionActivity2_4MusicTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicTaskView:addEvents()
	return
end

function VersionActivity2_4MusicTaskView:removeEvents()
	return
end

function VersionActivity2_4MusicTaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity2_4MusicTaskView:onUpdateParam()
	return
end

function VersionActivity2_4MusicTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	self:refreshLeft()
	VersionActivity2_4MusicTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity179
	}, self._oneClaimReward, self)
end

function VersionActivity2_4MusicTaskView:_oneClaimReward()
	self:refreshRight()
end

function VersionActivity2_4MusicTaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity2_4MusicTaskView:refreshRemainTime()
	local activityId = Activity179Model.instance:getActivityId()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > 0 then
			self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			return
		end
	end

	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_4MusicTaskView:refreshRight()
	VersionActivity2_4MusicTaskListModel.instance:initTask()
	VersionActivity2_4MusicTaskListModel.instance:sortTaskMoList()
	VersionActivity2_4MusicTaskListModel.instance:refreshList()
end

function VersionActivity2_4MusicTaskView:_onOpenViewFinish(viewName)
	if viewName == ViewName.VersionActivity2_4MusicOpinionTabView then
		self:closeThis()
	end
end

function VersionActivity2_4MusicTaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_4MusicTaskView:onDestroyView()
	return
end

return VersionActivity2_4MusicTaskView
