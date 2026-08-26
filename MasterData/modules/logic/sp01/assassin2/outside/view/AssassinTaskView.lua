-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinTaskView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinTaskView", package.seeall)

local AssassinTaskView = class("AssassinTaskView", BaseView)

function AssassinTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinTaskView:addEvents()
	return
end

function AssassinTaskView:removeEvents()
	return
end

function AssassinTaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function AssassinTaskView:onUpdateParam()
	return
end

function AssassinTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	AssassinTaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function AssassinTaskView:refreshLeft()
	self:refreshRemainTime()
end

function AssassinTaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_9Enum.ActivityId.Outside]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function AssassinTaskView:refreshRight()
	AssassinTaskListModel.instance:sortTaskMoList()
	AssassinTaskListModel.instance:refreshList()
end

function AssassinTaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function AssassinTaskView:onDestroyView()
	return
end

return AssassinTaskView
