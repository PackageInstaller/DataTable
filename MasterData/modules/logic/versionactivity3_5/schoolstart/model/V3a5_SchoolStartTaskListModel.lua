-- chunkname: @modules/logic/versionactivity3_5/schoolstart/model/V3a5_SchoolStartTaskListModel.lua

module("modules.logic.versionactivity3_5.schoolstart.model.V3a5_SchoolStartTaskListModel", package.seeall)

local V3a5_SchoolStartTaskListModel = class("V3a5_SchoolStartTaskListModel", ListScrollModel)

function V3a5_SchoolStartTaskListModel:setTaskList()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.SchoolStart)

	self._taskMoList = {}

	if taskDict ~= nil then
		local taskCfgList = V3a5_SchoolStartConfig.instance:getTaskList()

		for _, taskCfg in ipairs(taskCfgList) do
			if taskDict[taskCfg.id] then
				local mo = TaskMo.New()

				mo:init(taskDict[taskCfg.id], taskCfg)
				table.insert(self._taskMoList, mo)
			end
		end
	end

	table.sort(self._taskMoList, V3a5_SchoolStartTaskListModel.sortMO)
	self:setList(self._taskMoList)
end

function V3a5_SchoolStartTaskListModel.sortMO(a, b)
	local valueA = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
	local valueB = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

	if valueA == valueB then
		if a.config.sortId == b.config.sortId then
			return a.id < b.id
		else
			return a.config.sortId < b.config.sortId
		end
	else
		return valueA < valueB
	end
end

function V3a5_SchoolStartTaskListModel:sortList()
	self.tempTaskModel:sort(function(a, b)
		return
	end)
end

function V3a5_SchoolStartTaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if false and finishTaskCount > 1 then
		local moList = tabletool.copy(self._taskMoList)

		table.insert(moList, 1, {
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self._taskMoList)
	end
end

V3a5_SchoolStartTaskListModel.instance = V3a5_SchoolStartTaskListModel.New()

return V3a5_SchoolStartTaskListModel
