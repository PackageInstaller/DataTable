-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/view/ZhiXinQuanErTaskView.lua

module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErTaskView", package.seeall)

local ZhiXinQuanErTaskView = class("ZhiXinQuanErTaskView", BaseView)

function ZhiXinQuanErTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ZhiXinQuanErTaskView:addEvents()
	return
end

function ZhiXinQuanErTaskView:removeEvents()
	return
end

function ZhiXinQuanErTaskView:_editableInitView()
	self.actId = VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr
end

function ZhiXinQuanErTaskView:onUpdateParam()
	return
end

function ZhiXinQuanErTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	RoleActivityTaskListModel.instance:init(self.actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ZhiXinQuanErTaskView:_oneClaimReward()
	RoleActivityTaskListModel.instance:refreshData()
end

function ZhiXinQuanErTaskView:_onFinishTask(taskId)
	if RoleActivityTaskListModel.instance:getById(taskId) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function ZhiXinQuanErTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ZhiXinQuanErTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	RoleActivityTaskListModel.instance:clearData()
end

function ZhiXinQuanErTaskView:onDestroyView()
	return
end

return ZhiXinQuanErTaskView
