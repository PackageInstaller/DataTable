-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/EventTaskGroupChildView.lua

module("logic.extensions.eventtasksummary.view.tab.EventTaskGroupChildView", package.seeall)

local EventTaskGroupChildView = class("EventTaskGroupChildView", EventTaskTabChildView)

function EventTaskGroupChildView:onEnter()
	local params = self:getOpenParam()

	self._eventTaskMgr = params[1]
	self._pageId = checknumber(params[2])
	self._groupId = checknumber(params[3])
	self._viewParams = params[4]
	self._activityId = self._eventTaskMgr:getActivityId()
	self._activityType = checknumber(EventTaskSummaryConfig.instance:getActivityType(self._activityId))

	self.addGEvent(self, GlobalNotify.PM_EventTaskTabUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_EventTaskGroupUpdate, self._onUpdateGroupData, self)
	self:_onUpdate()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function EventTaskGroupChildView:_onUpdateGroupData(groupId)
	self._groupId = groupId

	self:_onUpdate()
end

function EventTaskGroupChildView:_onUpdateTaskData()
	local typeInfoList = {}
	local groupInfoList = {}
	local typeIdList = self._eventTaskMgr:getTypeIdList(self._pageId)

	for index, typeId in ipairs(typeIdList) do
		local taskInfoList = {}
		local taskIdList = self._eventTaskMgr:getTaskIdList(self._pageId, typeId)

		for _, taskId in ipairs(taskIdList) do
			local info = {}

			info.taskId = taskId
			info.state = self._eventTaskMgr:_getTaskState(taskId)

			table.insert(taskInfoList, info)
		end

		if #taskInfoList > 0 then
			table.sort(taskInfoList, function(a, b)
				if a.state == b.state then
					if a.taskId < b.taskId then
						return true
					end

					return false
				end

				return a.state < b.state
			end)
			table.insert(typeInfoList, taskInfoList)
		end
	end

	for i, info in pairs(typeInfoList) do
		if #info > 0 then
			local data = EventTaskSummaryConfig.instance:getTaskData(self._activityId, info[1].taskId)

			if data.groupId == self._groupId or data.groupId == 0 then
				table.insert(groupInfoList, info)
			end
		end
	end

	table.sort(groupInfoList, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.taskId < b.taskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)

	self._typeInfoList = groupInfoList
end

return EventTaskGroupChildView
