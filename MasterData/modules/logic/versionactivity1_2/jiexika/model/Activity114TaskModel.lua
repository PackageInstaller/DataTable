-- chunkname: @modules/logic/versionactivity1_2/jiexika/model/Activity114TaskModel.lua

module("modules.logic.versionactivity1_2.jiexika.model.Activity114TaskModel", package.seeall)

local Activity114TaskModel = class("Activity114TaskModel", ListScrollModel)

function Activity114TaskModel:onGetTaskList(taskList)
	local list = {}

	for _, v in ipairs(taskList) do
		local mo = Activity114TaskMo.New()

		mo:update(v)
		table.insert(list, mo)
	end

	table.sort(list, self.sortFunc)
	self:setList(list)
end

function Activity114TaskModel.sortFunc(taskMo1, taskMo2)
	if taskMo1.finishStatus == taskMo2.finishStatus then
		return taskMo1.config.taskId < taskMo2.config.taskId
	else
		return taskMo1.finishStatus < taskMo2.finishStatus
	end
end

function Activity114TaskModel:onTaskListUpdate(updateList, deleteList)
	for _, v in ipairs(updateList) do
		local mo = self:getById(v.taskId)

		if mo then
			mo:update(v)
		else
			local mo = Activity114TaskMo.New()

			mo:update(v)
			self:addAtLast(mo)
		end
	end

	for _, v in ipairs(deleteList) do
		local mo = self:getById(v.taskId)

		if mo then
			self:remove(mo)
		end
	end

	self:sort(self.sortFunc)
end

Activity114TaskModel.instance = Activity114TaskModel.New()

return Activity114TaskModel
