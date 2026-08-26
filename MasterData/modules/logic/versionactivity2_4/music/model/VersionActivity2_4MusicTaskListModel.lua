-- chunkname: @modules/logic/versionactivity2_4/music/model/VersionActivity2_4MusicTaskListModel.lua

module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicTaskListModel", package.seeall)

local VersionActivity2_4MusicTaskListModel = class("VersionActivity2_4MusicTaskListModel", ListScrollModel)

function VersionActivity2_4MusicTaskListModel:onInit()
	return
end

function VersionActivity2_4MusicTaskListModel:reInit()
	return
end

function VersionActivity2_4MusicTaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity179)
end

function VersionActivity2_4MusicTaskListModel:sortTaskMoList()
	if not self.taskMoList then
		return
	end

	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in pairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if maxFinishCount <= taskMo.finishCount then
					table.insert(finishAndGetRewardMoList, taskMo)
				elseif taskMo.hasFinished then
					table.insert(finishNotGetRewardMoList, taskMo)
				else
					table.insert(notFinishMoList, taskMo)
				end
			end
		end
	end

	table.sort(finishNotGetRewardMoList, VersionActivity2_4MusicTaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivity2_4MusicTaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivity2_4MusicTaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivity2_4MusicTaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity2_4MusicTaskListModel:refreshList()
	if not self.taskMoList then
		return
	end

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

function VersionActivity2_4MusicTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if taskMo.hasFinished and maxFinishCount > taskMo.finishCount then
					count = count + 1
				end
			end
		end
	end

	return count
end

function VersionActivity2_4MusicTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if taskMo.hasFinished and maxFinishCount > taskMo.finishCount then
					count = count + taskMo.config.activity
				end
			end
		end
	end

	return count
end

function VersionActivity2_4MusicTaskListModel:getGetRewardTaskCount()
	local count = 0

	if not self.taskMoList then
		return 0
	end

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if maxFinishCount <= taskMo.finishCount then
					count = count + 1
				end
			end
		end
	end

	return count
end

VersionActivity2_4MusicTaskListModel.instance = VersionActivity2_4MusicTaskListModel.New()

return VersionActivity2_4MusicTaskListModel
