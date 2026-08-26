-- chunkname: @modules/logic/versionactivity3_6/yami/view/task/V3a6YaMiTaskView.lua

module("modules.logic.versionactivity3_6.yami.view.task.V3a6YaMiTaskView", package.seeall)

local V3a6YaMiTaskView = class("V3a6YaMiTaskView", BaseView)

function V3a6YaMiTaskView:onInitView()
	self._gofundingitem = gohelper.findChild(self.viewGO, "root/#go_fundingitem")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_TaskList")
	self._txtlevel = gohelper.findChildText(self.viewGO, "root/level/root/#txt_level")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "root/level/root/#image_progress")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/level/root/#btn_click")
	self._goreddot = gohelper.findChild(self.viewGO, "root/level/root/#go_reddot")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "root/level/txt/#btn_tips")
	self._gotips = gohelper.findChild(self.viewGO, "root/level/txt/#go_tips")
	self._txtinfo = gohelper.findChildText(self.viewGO, "root/level/txt/#go_tips/#txt_info")
	self._txtprogressNum = gohelper.findChildText(self.viewGO, "root/level/#txt_progressNum")
	self._gomaxtext = gohelper.findChild(self.viewGO, "root/level/#go_maxtext")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiTaskView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onFinishTask, self)
end

function V3a6YaMiTaskView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onFinishTask, self)
end

function V3a6YaMiTaskView:_btnclickOnClick()
	return
end

function V3a6YaMiTaskView:_btntipsOnClick()
	return
end

function V3a6YaMiTaskView:_onFinishTask()
	V3a6YaMiTaskListModel.instance:refreshList()
end

function V3a6YaMiTaskView:_editableInitView()
	local golevel = gohelper.findChild(self.viewGO, "root/level")

	self._levelComp = MonoHelper.addNoUpdateLuaComOnceToGo(golevel, V3a6YaMiLevelExpComp)

	local mo = {
		isCanOpenTask = false,
		viewName = self.viewName
	}

	self._levelComp:onUpdateMO(mo)
end

function V3a6YaMiTaskView:onUpdateParam()
	return
end

function V3a6YaMiTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_mission_open)
	V3a6YaMiTaskListModel.instance:setTaskList()
end

function V3a6YaMiTaskView:onClose()
	return
end

function V3a6YaMiTaskView:onDestroyView()
	return
end

return V3a6YaMiTaskView
