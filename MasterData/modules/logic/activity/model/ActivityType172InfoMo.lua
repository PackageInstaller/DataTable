-- chunkname: @modules/logic/activity/model/ActivityType172InfoMo.lua

module("modules.logic.activity.model.ActivityType172InfoMo", package.seeall)

local ActivityType172InfoMo = pureTable("ActivityType172InfoMo")

function ActivityType172InfoMo:ctor()
	self.useItemTaskIds = {}
end

function ActivityType172InfoMo:init(taskIds)
	self.useItemTaskIds = {}

	for _, v in ipairs(taskIds) do
		table.insert(self.useItemTaskIds, v)
	end
end

function ActivityType172InfoMo:update(taskIds)
	self.useItemTaskIds = {}

	for _, v in ipairs(taskIds) do
		table.insert(self.useItemTaskIds, v)
	end
end

return ActivityType172InfoMo
