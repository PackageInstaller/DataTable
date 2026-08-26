-- chunkname: @modules/logic/activitywelfare/subview/newinsight/VersionActivity3_9InsightShowView.lua

module("modules.logic.activitywelfare.subview.newinsight.VersionActivity3_9InsightShowView", package.seeall)

local VersionActivity3_9InsightShowView = class("VersionActivity3_9InsightShowView", BaseView)

function VersionActivity3_9InsightShowView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#simage_logo")
	self._simagelogo2 = gohelper.findChildSingleImage(self.viewGO, "#simage_logo2")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "timebg/#txt_remainTime")
	self._gotaskitem1 = gohelper.findChild(self.viewGO, "#go_taskitem1")
	self._gotaskitem2 = gohelper.findChild(self.viewGO, "#go_taskitem2")
	self._gotaskitem3 = gohelper.findChild(self.viewGO, "#go_taskitem3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_9InsightShowView:addEvents()
	return
end

function VersionActivity3_9InsightShowView:removeEvents()
	return
end

function VersionActivity3_9InsightShowView:_editableInitView()
	self._taskItems = {}

	for i = 1, 3 do
		local item = VersionActivity3_9InsightShowTaskItem.New()

		item:init(self["_gotaskitem" .. i], i)

		self._taskItems[i] = item
	end

	self:_addEvents()
end

function VersionActivity3_9InsightShowView:_addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTask, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.Act172TaskUpdate, self._refreshTask, self)
end

function VersionActivity3_9InsightShowView:_removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTask, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.Act172TaskUpdate, self._refreshTask, self)
end

function VersionActivity3_9InsightShowView:onUpdateParam()
	return
end

function VersionActivity3_9InsightShowView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId
	self._config = ActivityConfig.instance:getActivityCo(self._actId)
	self._txtdesc.text = self._config.actDesc

	self:_refreshRemainTime()
	TaskDispatcher.runRepeat(self._refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity172
	}, self._getInfoSuccess, self)
end

function VersionActivity3_9InsightShowView:_refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self._actId)

	self._txtremainTime.text = string.format(luaLang("remain"), actInfoMo:getRemainTimeStr2ByEndTime())
end

function VersionActivity3_9InsightShowView:_getInfoSuccess()
	for k, v in ipairs(self._taskItems) do
		local taskId = 100 * self._actId + k

		v:setTask(taskId)
	end

	self:_refreshTask()
end

function VersionActivity3_9InsightShowView:_refreshTask()
	for _, v in ipairs(self._taskItems) do
		v:refresh()
	end
end

function VersionActivity3_9InsightShowView:onClose()
	return
end

function VersionActivity3_9InsightShowView:onDestroyView()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)

	if self._taskItems then
		for _, v in pairs(self._taskItems) do
			v:destroy()
		end

		self._taskItems = nil
	end
end

return VersionActivity3_9InsightShowView
