-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity216InfoMO.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity216InfoMO", package.seeall)

local Activity216InfoMO = pureTable("Activity216InfoMO")

function Activity216InfoMO:ctor()
	self.getOnceBonus = false
	self.taskInfos = {}
	self.hasUseTalentItem = false
end

function Activity216InfoMO:init(info)
	self.getOnceBonus = info.getOnceBonus

	self:updateTaskList(info.taskInfos)

	self.hasUseTalentItem = info.hasUseTalentItem
end

function Activity216InfoMO:updateTaskList(taskInfos)
	for _, taskInfo in ipairs(taskInfos) do
		self.taskInfos[taskInfo.taskId] = self.taskInfos[taskInfo.taskId] or Activity216TaskInfoMO.New()

		self.taskInfos[taskInfo.taskId]:init(taskInfo)
	end
end

function Activity216InfoMO:updateGetBonusState(get)
	self.getOnceBonus = get
end

function Activity216InfoMO:updateUseItemState(use)
	self.hasUseTalentItem = use
end

function Activity216InfoMO:getTaskInfo(taskId)
	return self.taskInfos[taskId]
end

function Activity216InfoMO:isTaskFinished(taskId)
	if not self.taskInfos[taskId] then
		return false
	end

	return self.taskInfos[taskId].hasFinish
end

function Activity216InfoMO:isTaskCanGet(taskId)
	if not self.taskInfos[taskId] then
		return false
	end

	local taskCo = Activity216Config.instance:getTaskCO(taskId)

	return self.taskInfos[taskId].progress >= taskCo.maxProgress and not self:isTaskFinished(taskId)
end

return Activity216InfoMO
