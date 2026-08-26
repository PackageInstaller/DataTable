-- chunkname: @modules/logic/season/model/Activity104TaskModel.lua

module("modules.logic.season.model.Activity104TaskModel", package.seeall)

local Activity104TaskModel = class("Activity104TaskModel", BaseModel)

function Activity104TaskModel:onInit()
	self:reInit()
end

function Activity104TaskModel:reInit()
	return
end

function Activity104TaskModel:getTaskSeasonList()
	local curSeasonId = Activity104Model.instance:getCurSeasonId()
	local list = {}
	local unlockTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season)

	for _, v in pairs(unlockTasks) do
		if v.config and v.config.seasonId == curSeasonId then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		local aValue = a.finishCount >= a.config.maxFinishCount and 3 or a.hasFinished and 1 or 2
		local bValue = b.finishCount >= b.config.maxFinishCount and 3 or b.hasFinished and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		elseif a.config.sortId ~= b.config.sortId then
			return a.config.sortId < b.config.sortId
		else
			return a.config.id < b.config.id
		end
	end)

	return list
end

Activity104TaskModel.instance = Activity104TaskModel.New()

return Activity104TaskModel
