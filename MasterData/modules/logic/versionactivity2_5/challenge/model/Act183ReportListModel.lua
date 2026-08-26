-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183ReportListModel.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183ReportListModel", package.seeall)

local Act183ReportListModel = class("Act183ReportListModel", MixScrollModel)

function Act183ReportListModel:init(activityId, groupList)
	self._activityId = activityId

	table.sort(groupList, self._recordSortFunc)
	self:setList(groupList)
end

function Act183ReportListModel._recordSortFunc(aRecordMo, bRecordMo)
	local aFinishedTime = aRecordMo:getFinishedTime()
	local bFinishedTime = bRecordMo:getFinishedTime()

	if aFinishedTime ~= bFinishedTime then
		return bFinishedTime < aFinishedTime
	end

	local aGroupId = aRecordMo:getGroupId()
	local bGroupId = bRecordMo:getGroupId()

	return aGroupId < bGroupId
end

function Act183ReportListModel:getActivityId()
	return self._activityId
end

Act183ReportListModel.instance = Act183ReportListModel.New()

return Act183ReportListModel
