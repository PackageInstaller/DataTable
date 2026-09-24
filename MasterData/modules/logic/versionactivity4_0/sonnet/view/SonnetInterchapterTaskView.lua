-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterTaskView.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterTaskView", package.seeall)

local SonnetInterchapterTaskView = class("SonnetInterchapterTaskView", BaseView)

function SonnetInterchapterTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Left/dec/img_kuang/mask/#simage_icon")
	self._txttask = gohelper.findChildText(self.viewGO, "Left/txt/txtbg/#txt_task")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Btn/#btn_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "Left/Btn/#go_hasget")
	self._golock = gohelper.findChild(self.viewGO, "Left/Btn/#go_lock")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SonnetInterchapterTaskView:addEvents()
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
end

function SonnetInterchapterTaskView:removeEvents()
	self._btncanget:RemoveClickListener()
end

function SonnetInterchapterTaskView:_btncangetOnClick()
	local prizeTaskMo = SonnetInterchapterTaskListModel.instance:getGrandPrizeTaskMo()

	TaskRpc.instance:sendFinishTaskRequest(prizeTaskMo.config.id)
end

function SonnetInterchapterTaskView:_onFinishTask()
	self:_updateTask()
end

function SonnetInterchapterTaskView:_onAllTaskFinish()
	self:_updateTask()
end

function SonnetInterchapterTaskView:_editableInitView()
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onFinishTask, self)
	self.addEventCb(self, SonnetInterchapterController.instance, SonnetInterchapterEvent.OnClickAllTaskFinish, self._onAllTaskFinish, self)
end

function SonnetInterchapterTaskView:_updateTask()
	SonnetInterchapterTaskListModel.instance:refreshList()
	self:_updateProgress()
end

function SonnetInterchapterTaskView:_updateProgress()
	local prizeTaskMo = SonnetInterchapterTaskListModel.instance:getGrandPrizeTaskMo()
	local value1 = SonnetInterchapterTaskListModel.instance:getGetRewardTaskCount()
	local value2 = 6

	self._txttask.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("sonnet_task_progress"), value1, value2)

	local canGet = value2 <= value1
	local prizeHasFinished = prizeTaskMo and prizeTaskMo.finishCount > 0

	gohelper.setActive(self._btncanget, canGet and not prizeHasFinished)
	gohelper.setActive(self._gohasget, canGet and prizeHasFinished)
	gohelper.setActive(self._golock, not canGet)
end

function SonnetInterchapterTaskView:onOpen()
	SonnetInterchapterTaskListModel.instance:setTaskList()
	self:_updateProgress()
end

function SonnetInterchapterTaskView:onClose()
	return
end

function SonnetInterchapterTaskView:onDestroyView()
	return
end

return SonnetInterchapterTaskView
