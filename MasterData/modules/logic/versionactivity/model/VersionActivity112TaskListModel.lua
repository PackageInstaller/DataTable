-- chunkname: @modules/logic/versionactivity/model/VersionActivity112TaskListModel.lua

module("modules.logic.versionactivity.model.VersionActivity112TaskListModel", package.seeall)

local VersionActivity112TaskListModel = class("VersionActivity112TaskListModel", ListScrollModel)

function VersionActivity112TaskListModel:onInit()
	self.taskDic = {}
end

function VersionActivity112TaskListModel:reInit()
	self:onInit()
end

function VersionActivity112TaskListModel:getActTask(actId)
	if self.taskDic[actId] == nil then
		self.taskDic[actId] = {}

		local all = VersionActivityConfig.instance:getActTaskDicConfig(actId)

		for i, v in ipairs(all) do
			if v.isOnline == 1 then
				local mo = VersionActivity112TaskMO.New()

				mo:init(v)

				self.taskDic[actId][v.taskId] = mo
			end
		end
	end

	return self.taskDic[actId]
end

function VersionActivity112TaskListModel:getTask(actId, taskId)
	local dic = self:getActTask(actId)

	return dic[taskId]
end

function VersionActivity112TaskListModel:refreshAlllTaskInfo(actId, Act112TaskInfos)
	self.taskDic[actId] = nil

	for i, v in ipairs(Act112TaskInfos) do
		local mo = self:getTask(actId, v.taskId)

		if mo then
			mo:update(v)
		end
	end

	self:sortTaksList()
end

function VersionActivity112TaskListModel:updateTaskInfo(actId, act112Tasks)
	for i, v in ipairs(act112Tasks) do
		local mo = self:getTask(actId, v.taskId)

		if mo then
			mo:update(v)
		end
	end

	self:sortTaksList()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112TaskUpdate)
end

function VersionActivity112TaskListModel:setGetBonus(actId, taskId)
	local mo = self:getTask(actId, taskId)

	if mo then
		mo.hasGetBonus = true
	end

	self:sortTaksList()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112TaskGetBonus, taskId)
end

function VersionActivity112TaskListModel:sortTaksList()
	local list = self:getList()

	table.sort(list, VersionActivity112TaskListModel.sort)
	self:setList(list)
end

function VersionActivity112TaskListModel:updateTaksList(actId, isDailyTaskType)
	local allTask = self:getActTask(actId)
	local list = {}

	for i, v in ipairs(allTask) do
		if isDailyTaskType == (v.config.minTypeId == 1) then
			table.insert(list, v)
		end
	end

	table.sort(list, VersionActivity112TaskListModel.sort)
	self:setList(list)
end

function VersionActivity112TaskListModel.sort(a, b)
	if a.hasGetBonus ~= b.hasGetBonus then
		return b.hasGetBonus
	end

	local aCanGetBonus = a:canGetBonus()
	local bCanGetBonus = b:canGetBonus()

	if aCanGetBonus ~= bCanGetBonus then
		return aCanGetBonus
	end

	return a.id < b.id
end

VersionActivity112TaskListModel.instance = VersionActivity112TaskListModel.New()

return VersionActivity112TaskListModel
