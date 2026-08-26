-- chunkname: @modules/logic/monthcard/view/VersionActivity3_8FreeMonthCardTaskView.lua

module("modules.logic.monthcard.view.VersionActivity3_8FreeMonthCardTaskView", package.seeall)

local VersionActivity3_8FreeMonthCardTaskView = class("VersionActivity3_8FreeMonthCardTaskView", BaseView)

function VersionActivity3_8FreeMonthCardTaskView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._golimittime = gohelper.findChild(self.viewGO, "#go_limittime")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_limittime/bg/#txt_limittime")
	self._gotaskitem = gohelper.findChild(self.viewGO, "scroll_tasks/Viewport/Content/#go_taskitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_8FreeMonthCardTaskView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity3_8FreeMonthCardTaskView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity3_8FreeMonthCardTaskView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity3_8FreeMonthCardTaskView:_editableInitView()
	self:_addSelfEvents()

	self._taskItems = self:getUserDataTb_()
end

function VersionActivity3_8FreeMonthCardTaskView:onClickModalMask()
	self:closeThis()
end

function VersionActivity3_8FreeMonthCardTaskView:_addSelfEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refreshUI, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refreshUI, self)
end

function VersionActivity3_8FreeMonthCardTaskView:_removeSelfEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refreshUI, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refreshUI, self)
end

function VersionActivity3_8FreeMonthCardTaskView:onOpen()
	self._actId = VersionActivity3_8Enum.ActivityId.FreeMonthCard

	gohelper.setActive(self._gotaskitem, false)
	self:_refreshTimeTick()
	self:_refreshUI()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function VersionActivity3_8FreeMonthCardTaskView:_refreshTimeTick()
	self._txtlimittime.text = self:_getRemainTimeStr()
end

function VersionActivity3_8FreeMonthCardTaskView:_getRemainTimeStr()
	local actRemainTime = ActivityModel.instance:getRemainTimeSec(self._actId) or 0

	if actRemainTime <= 0 then
		return luaLang("turnback_end")
	end

	local taskRemainTime = TaskModel.instance:getTaskTypeExpireTime(TaskEnum.TaskType.Weekly) - ServerTime.now()

	if taskRemainTime < actRemainTime then
		local date = TimeUtil.secondToRoughTime3(taskRemainTime, false)

		return formatLuaLang("refresh_remain_time", date)
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(actRemainTime)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function VersionActivity3_8FreeMonthCardTaskView:_refreshUI()
	local taskList = VersionActivity3_8FreeMonthCardModel.instance:getAllTasks(self._actId)

	for i, taskId in ipairs(taskList) do
		if not self._taskItems[i] then
			local go = gohelper.cloneInPlace(self._gotaskitem)
			local taskItem = VersionActivity3_8FreeMonthCardTaskItem.New()

			taskItem:init(go)
			table.insert(self._taskItems, taskItem)
		end

		self._taskItems[i]:refresh(taskId)
	end
end

function VersionActivity3_8FreeMonthCardTaskView:onClose()
	return
end

function VersionActivity3_8FreeMonthCardTaskView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	self:_removeSelfEvents()

	if self._taskItems then
		for _, taskItem in pairs(self._taskItems) do
			taskItem:destroy()
		end

		self._taskItems = nil
	end
end

return VersionActivity3_8FreeMonthCardTaskView
