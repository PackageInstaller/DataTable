-- chunkname: @modules/logic/versionactivity1_4/acttask/model/VersionActivity1_4TaskListModel.lua

module("modules.logic.versionactivity1_4.acttask.model.VersionActivity1_4TaskListModel", package.seeall)

local VersionActivity1_4TaskListModel = class("VersionActivity1_4TaskListModel", ListScrollModel)

function VersionActivity1_4TaskListModel:onInit()
	return
end

function VersionActivity1_4TaskListModel:reInit()
	return
end

function VersionActivity1_4TaskListModel:sortTaskMoList(actId, tabIndex)
	self.actId = actId

	local taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, actId)
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	self.allTaskFinish = true

	for _, taskMo in ipairs(taskMoList) do
		if taskMo.config.page == tabIndex then
			local show = true

			if not string.nilorempty(taskMo.config.prepose) then
				local preposes = string.split(taskMo.config.prepose, "#")

				for _, prepose in ipairs(preposes) do
					if not TaskModel.instance:isTaskFinish(taskMo.type, tonumber(prepose)) then
						show = false

						break
					end
				end
			end

			if show then
				if taskMo.finishCount >= taskMo.config.maxFinishCount then
					table.insert(finishAndGetRewardMoList, taskMo)
				elseif taskMo.hasFinished then
					table.insert(finishNotGetRewardMoList, taskMo)
				else
					table.insert(notFinishMoList, taskMo)
				end
			end
		end

		if taskMo.finishCount < taskMo.config.maxFinishCount then
			self.allTaskFinish = false
		end
	end

	table.sort(finishNotGetRewardMoList, VersionActivity1_4TaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivity1_4TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivity1_4TaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
	self:refreshList()
end

function VersionActivity1_4TaskListModel:checkTaskRedByPage(actId, tabIndex)
	local taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, actId)

	for _, taskMo in ipairs(taskMoList) do
		if taskMo.config.page == tabIndex then
			local show = true

			if not string.nilorempty(taskMo.config.prepose) then
				local preposes = string.split(taskMo.config.prepose, "#")

				for _, prepose in ipairs(preposes) do
					if not TaskModel.instance:isTaskFinish(taskMo.type, tonumber(prepose)) then
						show = false

						break
					end
				end
			end

			if show and taskMo.finishCount < taskMo.config.maxFinishCount and taskMo.hasFinished then
				return true
			end
		end
	end

	return false
end

function VersionActivity1_4TaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity1_4TaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if finishTaskCount > 1 then
		local moList = tabletool.copy(self.taskMoList)

		table.insert(moList, 1, {
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self.taskMoList)
	end
end

function VersionActivity1_4TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity1_4TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivity1_4TaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity1_4TaskListModel:getKeyRewardMo()
	return
end

function VersionActivity1_4TaskListModel:getActId()
	return self.actId
end

VersionActivity1_4TaskListModel.instance = VersionActivity1_4TaskListModel.New()

return VersionActivity1_4TaskListModel
