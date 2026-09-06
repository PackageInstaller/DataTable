-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/eternalchallenge/EternalChallengeTaskChildView.lua

module("logic.extensions.eventtasksummary.view.tab.eternalchallenge.EternalChallengeTaskChildView", package.seeall)

local EternalChallengeTaskChildView = class("EternalChallengeTaskChildView", EventTaskTabChildView)

function EternalChallengeTaskChildView:_onUpdateTaskData()
	local typeInfoList = {}
	local typeIdList = self._eventTaskMgr:getTypeIdList(self._pageId)

	for index, typeId in ipairs(typeIdList) do
		local taskInfoList = {}
		local taskIdList = self._eventTaskMgr:getTaskIdList(self._pageId, typeId)

		for _, taskId in ipairs(taskIdList) do
			if self:_isMatchTime(taskId) then
				local info = {}

				info.taskId = taskId
				info.state = self._eventTaskMgr:_getTaskState(taskId)

				table.insert(taskInfoList, info)
			end
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

			typeInfoList[index] = taskInfoList
		end
	end

	table.sort(typeInfoList, function(listA, listB)
		if listA and listB then
			local a = listA[1]
			local b = listB[1]

			if a.state == b.state then
				if a.taskId < b.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		else
			return false
		end
	end)

	self._typeInfoList = typeInfoList
end

function EternalChallengeTaskChildView:_updateTaskScrollerList()
	local list = {}

	for _, taskInfoList in pairs(self._typeInfoList) do
		if taskInfoList[1].state == GameEnum.PrizeState.IsHasGain then
			table.insert(list, taskInfoList[#taskInfoList])
		else
			table.insert(list, taskInfoList[1])
		end
	end

	self._taskScrollList:reloadData(list)
end

function EternalChallengeTaskChildView:_isMatchTime(taskId)
	local cfg = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)

	if not string.nilorempty(cfg.startTime) and not string.nilorempty(cfg.endTime) then
		local startTimestamp = GameUtil.string2time(cfg.startTime)
		local endTimestamp = GameUtil.string2time(cfg.endTime)
		local curTime = ServerTime.now()

		return startTimestamp <= curTime and curTime <= endTimestamp
	else
		return true
	end
end

return EternalChallengeTaskChildView
