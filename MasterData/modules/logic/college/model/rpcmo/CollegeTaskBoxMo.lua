-- chunkname: @modules/logic/college/model/rpcmo/CollegeTaskBoxMo.lua

module("modules.logic.college.model.rpcmo.CollegeTaskBoxMo", package.seeall)

local CollegeTaskBoxMo = pureTable("CollegeTaskBoxMo")

function CollegeTaskBoxMo:init(data)
	self.tasks, self.tasksMap = GameUtil.rpcInfosToListAndMap(data.tasks, CollegeTaskMo, "id", self.tasksMap)
end

function CollegeTaskBoxMo:getTaskMo(id)
	return self.tasksMap[id]
end

function CollegeTaskBoxMo:updateTask(data)
	local taskMo = self.tasksMap[data.id]

	if not taskMo then
		taskMo = CollegeTaskMo.New()
		self.tasksMap[data.id] = taskMo

		table.insert(self.tasks, taskMo)
	end

	local preStatus = taskMo.state

	taskMo:init(data)

	if preStatus ~= taskMo.state and taskMo.state == CollegeEnum.TaskState.Reward then
		CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_taskfinish"), taskMo.co.description))
		CollegeController.instance:dispatchEvent(CollegeEvent.TaskFinish, taskMo.id)
	end
end

function CollegeTaskBoxMo:getTaskList()
	return self.tasks
end

function CollegeTaskBoxMo:getDoingTasks()
	local doingTasks = {}
	local curStage = CollegeModel.instance:getSceneMo().prop.stage

	for _, taskMo in ipairs(self.tasks) do
		if taskMo.co.stageId == curStage and taskMo.state == CollegeEnum.TaskState.Doing then
			table.insert(doingTasks, taskMo)
		end
	end

	table.sort(doingTasks, function(aTaskMo, bTaskMo)
		return aTaskMo.id < bTaskMo.id
	end)

	return doingTasks
end

function CollegeTaskBoxMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeTaskBoxMo" then
		return false
	end

	local isSame = true

	if #self.tasks ~= #otherMo.tasks then
		isSame = false

		logError(string.format("CollegeTaskBoxMo compareWith tasks count not same: %s >> %s", #self.tasks, #otherMo.tasks))
	else
		for i = 1, #self.tasks do
			local otherTaskMo = otherMo.tasksMap[self.tasks[i].id]

			if not otherTaskMo or not self.tasks[i]:compareWith(otherTaskMo) then
				isSame = false

				logError(string.format("CollegeTaskBoxMo compareWith tasks not same: id=%s", self.tasks[i].id))

				break
			end
		end
	end

	return isSame
end

return CollegeTaskBoxMo
