-- chunkname: @modules/logic/versionactivity1_8/windsong/view/ActWindSongTaskView.lua

module("modules.logic.versionactivity1_8.windsong.view.ActWindSongTaskView", package.seeall)

local ActWindSongTaskView = class("ActWindSongTaskView", BaseView)

function ActWindSongTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._goLimitTime = gohelper.findChild(self.viewGO, "Left/LimitTime/image_LimitTimeBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActWindSongTaskView:addEvents()
	return
end

function ActWindSongTaskView:removeEvents()
	return
end

function ActWindSongTaskView:_editableInitView()
	return
end

function ActWindSongTaskView:onUpdateParam()
	return
end

function ActWindSongTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	ActWindSongTaskListModel.instance:init()

	local actId = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.WindSong)
	local isRetroAcitivity = actId and actId.isRetroAcitivity == 2

	gohelper.setActive(self._goLimitTime.gameObject, not isRetroAcitivity)

	if not isRetroAcitivity then
		TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
		self:_showLeftTime()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActWindSongTaskView:_oneClaimReward()
	ActWindSongTaskListModel.instance:refreshData()
end

function ActWindSongTaskView:_onFinishTask(taskId)
	if ActWindSongTaskListModel.instance:getById(taskId) then
		ActWindSongTaskListModel.instance:refreshData()
	end
end

function ActWindSongTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity1_8Enum.ActivityId.WindSong)
end

function ActWindSongTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	ActWindSongTaskListModel.instance:clear()
end

function ActWindSongTaskView:onDestroyView()
	return
end

return ActWindSongTaskView
