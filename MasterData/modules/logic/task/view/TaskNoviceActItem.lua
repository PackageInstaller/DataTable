-- chunkname: @modules/logic/task/view/TaskNoviceActItem.lua

module("modules.logic.task.view.TaskNoviceActItem", package.seeall)

local TaskNoviceActItem = class("TaskNoviceActItem", LuaCompBase)

function TaskNoviceActItem:init(go, index)
	self.go = go
	self._tag = index
	self._gounselect = gohelper.findChild(go, "unselected")
	self._gounselecticon = gohelper.findChild(go, "unselected/icon")
	self._gounselectlock = gohelper.findChild(go, "unselected/lock")
	self._txtunselectTitle = gohelper.findChildText(self._gounselect, "act")
	self._goselect = gohelper.findChild(go, "selected")
	self._goselecticon = gohelper.findChild(go, "selected/icon")
	self._goselectlock = gohelper.findChild(go, "selected/lock")
	self._txtselectTitle = gohelper.findChildText(self._goselect, "act")

	local goclick = gohelper.findChild(go, "click")

	self._btnClick = gohelper.getClickWithAudio(goclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TaskNoviceActItem:_editableInitView()
	gohelper.setActive(self.go, true)
	gohelper.setActive(self._goselected, false)
	gohelper.setActive(self._gounselected, false)
	self._btnClick:AddClickListener(self._btnActItemOnClick, self)
	TaskController.instance:registerCallback(TaskEvent.RefreshActState, self._refreshItem, self)
	self:_refreshItem()
end

function TaskNoviceActItem:_btnActItemOnClick()
	if self._tag == TaskModel.instance:getNoviceTaskCurSelectStage() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_act)

	local maxStage = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	if maxStage >= self._tag then
		TaskModel.instance:setNoviceTaskCurStage(self._tag)
	end

	TaskModel.instance:setNoviceTaskCurSelectStage(self._tag)

	local count = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(count + 1)

	local data = {}

	data.isActClick = true

	TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem, data)

	local param = {}

	param.num = 0
	param.taskType = TaskEnum.TaskType.Novice
	param.force = maxStage >= self._tag

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, param)
end

function TaskNoviceActItem:_refreshItem(param)
	local maxStage = TaskModel.instance:getNoviceTaskMaxUnlockStage()
	local curStage = TaskModel.instance:getNoviceTaskCurStage()
	local curSelectStage = TaskModel.instance:getNoviceTaskCurSelectStage()

	gohelper.setActive(self._goselect, curSelectStage == self._tag)
	gohelper.setActive(self._gounselect, curSelectStage ~= self._tag)
	gohelper.setActive(self._goselectlock, maxStage < self._tag)
	gohelper.setActive(self._gounselectlock, maxStage < self._tag)
	gohelper.setActive(self._goselecticon, self._tag == maxStage)
	gohelper.setActive(self._gounselecticon, self._tag == maxStage)

	self._txtunselectTitle.text = "Act." .. tostring(self._tag)
	self._txtselectTitle.text = "Act." .. tostring(self._tag)

	ZProj.UGUIHelper.SetColorAlpha(self._txtunselectTitle, maxStage < self._tag and 0.6 or 0.7)
end

function TaskNoviceActItem:destroy()
	gohelper.destroy(self.go)
	self._btnClick:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.RefreshActState, self._refreshItem, self)
end

return TaskNoviceActItem
