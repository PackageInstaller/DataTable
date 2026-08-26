-- chunkname: @modules/logic/activity/model/ActivityType172Model.lua

module("modules.logic.activity.model.ActivityType172Model", package.seeall)

local ActivityType172Model = class("ActivityType172Model", BaseModel)

function ActivityType172Model:onInit()
	self:reInit()
end

function ActivityType172Model:reInit()
	self._type172Info = {}
end

function ActivityType172Model:setType172Info(activityId, info)
	local data = ActivityType172InfoMo.New()

	data:init(info.useItemTaskIds)

	self._type172Info[activityId] = data
end

function ActivityType172Model:updateType172Info(activityId, taskIds)
	if not self._type172Info[activityId] then
		local data = ActivityType172InfoMo.New()

		data:init(taskIds)

		self._type172Info[activityId] = data
	else
		self._type172Info[activityId]:update(taskIds)
	end
end

function ActivityType172Model:isTaskHasUsed(activityId, taskId)
	if not self._type172Info[activityId] then
		return false
	end

	for _, v in pairs(self._type172Info[activityId].useItemTaskIds) do
		if v == taskId then
			return true
		end
	end

	return false
end

ActivityType172Model.instance = ActivityType172Model.New()

return ActivityType172Model
