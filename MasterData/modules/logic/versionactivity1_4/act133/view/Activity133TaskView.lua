-- chunkname: @modules/logic/versionactivity1_4/act133/view/Activity133TaskView.lua

module("modules.logic.versionactivity1_4.act133.view.Activity133TaskView", package.seeall)

local Activity133TaskView = class("Activity133TaskView", BaseView)

function Activity133TaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "main/#simage_bg")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "main/#scroll_view")
	self._gotaskitem = gohelper.findChild(self.viewGO, "main/#scroll_view/Viewport/Content/#go_taskitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity133TaskView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._initTaskMoList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._initTaskMoList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._initTaskMoList, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function Activity133TaskView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._initTaskMoList, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._initTaskMoList, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._initTaskMoList, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function Activity133TaskView:_btncloseOnClick()
	self:closeThis()
end

function Activity133TaskView:onClickModalMask()
	self:closeThis()
end

function Activity133TaskView:_editableInitView()
	return
end

function Activity133TaskView:onUpdateParam()
	return
end

function Activity133TaskView:onOpen()
	self.actId = self.viewParam.actId[1]

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
	self:_initTaskMoList()
end

function Activity133TaskView:_initTaskMoList()
	Activity133TaskListModel.instance:sortTaskMoList()
end

function Activity133TaskView:onDailyRefresh()
	Activity133Rpc.instance:sendGet133InfosRequest(VersionActivity1_4Enum.ActivityId.ShipRepair, self._initTaskMoList, self)
end

function Activity133TaskView:onClose()
	return
end

function Activity133TaskView:onDestroyView()
	return
end

return Activity133TaskView
