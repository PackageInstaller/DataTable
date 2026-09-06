-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/config/TaskConfig.lua

module("logic.extensions.task.config.TaskConfig", package.seeall)

local TaskConfig = class("TaskConfig", BaseConfig)

TaskConfig.maxChapterId = 0

function TaskConfig:onInit()
	TaskConfig.super.onInit(self)

	self._taskStepsConfig = nil
	self._taskesConfig = nil
	self._taskesStepStart = nil
	self._taskDialogText = nil
	self._taskButtonText = nil
	self._taskStepBonus = nil
	self._wushenshouTaskes = nil
	self._taskSummarizeConfig = nil
end

function TaskConfig:getNames()
	return {
		"taskdefine",
		"taskstarter",
		"taskdialogtext",
		"taskbuttontext",
		"tasktargettext",
		"taskbonus",
		"task_chapters",
		"task_panel_icon",
		"task_summarize"
	}
end

function TaskConfig:handleConfig(name, content)
	if name == "taskdefine" then
		self:_handleTaskes(content)
		self:_handleBranches()
		self:_handleWuShenShou()
	elseif name == "taskstarter" then
		self._taskesConfig = content

		self:_handleBranches()
		self:_handleWuShenShou()
		self:_handleTaskChapters()
	elseif name == "taskdialogtext" then
		self._taskDialogText = content
	elseif name == "taskbuttontext" then
		self._taskButtonText = content
	elseif name == "tasktargettext" then
		self._taskTargetText = content
	elseif name == "taskbonus" then
		self._taskStepBonus = content
	elseif name == "task_chapters" then
		self._taskChapters = content

		self:_handleTaskChapters()
	elseif name == "task_panel_icon" then
		self._taskPanelIcon = content
	elseif name == "task_summarize" then
		self._taskSummarizeConfig = content
	end
end

function TaskConfig:getChapterCo(chapterId)
	return self._taskChapters[chapterId]
end

function TaskConfig:getPanelIconCo(chapterId)
	return self._taskPanelIcon[chapterId]
end

function TaskConfig:getStepCo(taskId, stepId)
	local taskes = self._taskStepsConfig[taskId]

	if taskes then
		return taskes[stepId]
	end
end

function TaskConfig:getContentText(ctxId)
	local ctx = self._taskDialogText[ctxId]

	if not ctx then
		return ""
	end

	return ctx.text
end

function TaskConfig:getTaskInstruction(id)
	local ctx = self._taskTargetText[id]

	if not ctx then
		return ""
	end

	return ctx.text
end

function TaskConfig:getButtonText(ctxId)
	local ctx = self._taskButtonText[ctxId]

	if not ctx then
		return ""
	end

	return cnt.text
end

function TaskConfig:getTaskCo(id)
	return self._taskesConfig[id]
end

function TaskConfig:getAllTaskCoes()
	if not self._taskesConfig then
		return nil
	end

	local taskes = {}
	local i = 1

	for k, v in pairs(self._taskesConfig) do
		if k ~= "dataList" then
			taskes[i] = v
			i = i + 1
		end
	end

	return taskes
end

function TaskConfig:getAllTaskStepCoes(taskId)
	local taskes = self._taskStepsConfig[taskId]

	if taskes then
		return taskes
	end
end

function TaskConfig:getTaskes()
	return self._taskesConfig
end

function TaskConfig:getTaskeStepBonus(taskId, stepId)
	if self._taskStepBonus then
		local taskes = self._taskStepBonus[taskId]

		if taskes then
			local bonusCo = taskes[stepId]

			if bonusCo then
				return bonusCo.bonus, bonusCo.bonusType
			end
		end
	end
end

function TaskConfig:getTaskeStepLaterBonus(taskId, stepId)
	local allCos = self:getAllTaskStepCoes(taskId)

	for i = stepId, #allCos do
		local bonus, bonusType = self:getTaskeStepBonus(taskId, i)

		if bonus and #bonus > 0 then
			return bonus, bonusType
		end
	end
end

function TaskConfig:_handleBranches()
	return
end

function TaskConfig:getStepStart(taskId)
	if self._taskesStepStart then
		return self._taskesStepStart[taskId] or 0
	end

	return 0
end

function TaskConfig:getStepEnd(taskId)
	if self._taskesStepEnd then
		return self._taskesStepEnd[taskId] or 0
	end

	return 0
end

function TaskConfig:_handleWuShenShou()
	if self._taskStepsConfig and self._taskesConfig and not self._wushenshouTaskes then
		local configs = self._taskStepsConfig
		local pveTy = TaskConst.TSTEP_TARGET_PVE

		self._wushenshouTaskes = {}

		for k, v in pairs(configs) do
			if k ~= "dataList" then
				local taskCo = self:getTaskCo(k)

				if taskCo.taskStarterState == TaskConst.TASK_S_ONLINE then
					for i = 1, #v do
						local step = v[i]
						local targets = step.target

						if targets then
							local cnt = #targets

							for j = 1, cnt do
								local pt = tonumber(targets[j][1])

								if pt == pveTy then
									local pveId = tonumber(targets[j][2])

									self._wushenshouTaskes[pveId] = {
										step.taskId,
										step.stepId
									}
								end
							end
						end
					end
				end
			end
		end
	end
end

function TaskConfig:_handleTaskChapters()
	if self._taskChapters and self._taskesConfig then
		for k, v in pairs(self._taskesConfig) do
			if k ~= "dataList" then
				v.chapterId = 0
				v.chapterOrder = 0
			end
		end

		for k, v in pairs(self._taskChapters) do
			if k ~= "dataList" then
				for i = 1, #v.taskes do
					local taskCo = self:getTaskCo(v.taskes[i])

					taskCo.chapterId = v.id
					taskCo.chapterOrder = i
				end

				if v.id > TaskConfig.maxChapterId then
					TaskConfig.maxChapterId = v.id
				end
			end
		end
	end
end

function TaskConfig:getWuShenShouTaskId(pveId)
	if self._wushenshouTaskes[pveId] then
		return self._wushenshouTaskes[pveId][1], self._wushenshouTaskes[pveId][2]
	end
end

function TaskConfig:_handleTaskes(content)
	local configs = content

	self._taskStepsConfig = content
	self._taskesStepStart = {}
	self._taskesStepEnd = {}

	for k, v in pairs(configs) do
		if k ~= "dataList" then
			table.sort(v, function(first, second)
				if first == second then
					return false
				end

				local stepIdF = first.stepId
				local stepIdS = second.stepId

				if stepIdF < stepIdS then
					return true
				end

				return false
			end)

			for i = 1, #v do
				local step = v[i]
				local nextStep = v[i + 1]

				step.nextStep = not step.isEndStep and nextStep and nextStep.stepId or 0
			end

			self._taskesStepStart[k] = self._taskesStepStart[k] or v[1].stepId
			self._taskesStepEnd[k] = self._taskesStepEnd[k] or v[#v].stepId
		end
	end
end

function TaskConfig:getTaskSummarizeCfgById(id)
	return self._taskSummarizeConfig[id]
end

function TaskConfig:getAllTaskSummarizeCfg()
	return self._taskSummarizeConfig
end

TaskConfig.instance = TaskConfig.New()

return TaskConfig
