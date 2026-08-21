-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/power_challenge/PowerChallengeModel.lua

module("logic.extensions.welfare.model.power_challenge.PowerChallengeModel", package.seeall)

local M = class("PowerChallengeModel", BaseModel)
local TaskState = {
	Doing = 2,
	CanReceive = 3,
	IsReceived = 1
}

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._taskMoLst = {}
end

function M:isTaskViable()
	return TableUtil.getLen(self._taskMoLst) > 0
end

function M:getTaskMo(id)
	return self._taskMoLst[id]
end

function M:setActivityData(data)
	self._data = data
end

function M:getActivityData()
	return self._data
end

function M:updateTaskLst(taskLst)
	if taskLst and #taskLst > 0 then
		for _, taskNo in ipairs(taskLst) do
			self:updateTask(taskNo)
		end
	end
end

function M:updateTask(taskNo)
	local taskId = taskNo.id

	if not self._taskMoLst[taskId] then
		self._taskMoLst[taskId] = PowerChallengeMo.New()
	end

	local theMo = self:getTaskMo(taskId)

	theMo:updateFromServer(taskNo)
end

function M:getStatus(id)
	local taskMo = self:getTaskMo(id)

	if taskMo:getIsFinish() then
		return TaskState.IsReceived
	elseif taskMo:canGetReward() then
		return TaskState.CanReceive
	else
		return TaskState.Doing
	end
end

function M:getAllFinished()
	local count = 0

	for taskId, _ in pairs(self._taskMoLst) do
		if self:getTaskMo(taskId):getIsFinish() then
			count = count + 1
		end
	end

	return count == TableUtil.getLen(self._taskMoLst)
end

function M:getCanReceive()
	for taskId, _ in pairs(self._taskMoLst) do
		local taskMo = self:getTaskMo(taskId)

		if not taskMo:getIsFinish() and taskMo:canGetReward() then
			return true
		end
	end

	return false
end

function M:getTaskSignList(id)
	local res = {}
	local taskList = PowerChallengeConfig.instance:getChapterConfById(id)
	local signList = {}

	for _, taskGroup in ipairs(taskList) do
		res[taskGroup.chapterId] = {}

		table.insert(signList, taskGroup.name)

		for _, task in ipairs(taskGroup.tasks) do
			table.insert(res[taskGroup.chapterId], task)
			table.insert(signList, task)
		end
	end

	return res, signList
end

function M:setLastPageIndex(pageIndex, tabIndex)
	self._pageIndex = pageIndex
	self._tabIndex = tabIndex
end

function M:getLastPageIndex()
	return self._pageIndex, self._tabIndex
end

M.instance = M.New()

return M
