-- chunkname: @modules/versionactivitybase/fixed/dungeon/model/VersionActivityFixedTaskListModel.lua

module("modules.versionactivitybase.fixed.dungeon.model.VersionActivityFixedTaskListModel", package.seeall)

local VersionActivityFixedTaskListModel = class("VersionActivityFixedTaskListModel", ListScrollModel)

function VersionActivityFixedTaskListModel:onInit()
	return
end

function VersionActivityFixedTaskListModel:reInit()
	return
end

function VersionActivityFixedTaskListModel:initTask()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion).ActivityId.Dungeon)
end

function VersionActivityFixedTaskListModel:sortTaskMoList()
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			table.insert(finishAndGetRewardMoList, taskMo)
		elseif taskMo.hasFinished then
			table.insert(finishNotGetRewardMoList, taskMo)
		else
			table.insert(notFinishMoList, taskMo)
		end
	end

	table.sort(finishNotGetRewardMoList, VersionActivityFixedTaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivityFixedTaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivityFixedTaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivityFixedTaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivityFixedTaskListModel:refreshList()
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

function VersionActivityFixedTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivityFixedTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivityFixedTaskListModel:getGetRewardTaskCount()
	local count = 0

	if not self.taskMoList then
		return 0
	end

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

VersionActivityFixedTaskListModel.instance = VersionActivityFixedTaskListModel.New()

return VersionActivityFixedTaskListModel
