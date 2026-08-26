-- chunkname: @modules/logic/versionactivity/model/PushBoxTaskListModel.lua

module("modules.logic.versionactivity.model.PushBoxTaskListModel", package.seeall)

local PushBoxTaskListModel = class("PushBoxTaskListModel", ListScrollModel)

function PushBoxTaskListModel:onInit()
	return
end

function PushBoxTaskListModel:reInit()
	return
end

function PushBoxTaskListModel:initData(task_config_list)
	self.data = {}

	for i, v in ipairs(task_config_list) do
		local tab = {}

		tab.id = v.taskId
		tab.config = v

		table.insert(self.data, tab)
	end
end

function PushBoxTaskListModel:sortData()
	table.sort(self.data, PushBoxTaskListModel.sortList)
end

function PushBoxTaskListModel.sortList(item1, item2)
	local task1 = PushBoxModel.instance:getTaskData(item1.config.taskId)
	local task2 = PushBoxModel.instance:getTaskData(item2.config.taskId)

	if task1.hasGetBonus and not task2.hasGetBonus then
		return false
	elseif not task1.hasGetBonus and task2.hasGetBonus then
		return true
	else
		local can_get_reward1 = task1.progress >= item1.config.maxProgress
		local can_get_reward2 = task2.progress >= item2.config.maxProgress

		if can_get_reward1 and not can_get_reward2 then
			return true
		elseif not can_get_reward1 and can_get_reward2 then
			return false
		else
			return item1.config.sort < item2.config.sort
		end
	end
end

function PushBoxTaskListModel:refreshData()
	self:setList(self.data)
end

function PushBoxTaskListModel:clearData()
	self:clear()

	self.data = nil
end

PushBoxTaskListModel.instance = PushBoxTaskListModel.New()

return PushBoxTaskListModel
