-- chunkname: @modules/logic/sp01/act204/model/Activity204Model.lua

module("modules.logic.sp01.act204.model.Activity204Model", package.seeall)

local Activity204Model = class("Activity204Model", BaseModel)

function Activity204Model:onInit()
	self:reInit()
end

function Activity204Model:reInit()
	self.localPrefsDict = {}
end

function Activity204Model:getActId()
	return self._activityId
end

function Activity204Model:isActivityOnline()
	local actId = self:getActId()

	if not actId then
		return false
	end

	return ActivityModel.instance:isActOnLine(actId)
end

function Activity204Model:setActInfo(msg)
	local activityId = msg.activityId
	local info = msg.info
	local taskInfos = msg.taskInfos
	local mo = self:getActMo(activityId)

	mo:updateInfo(info, taskInfos)

	self._activityId = activityId
end

function Activity204Model:getActMo(activityId)
	local mo = self:getById(activityId)

	if not mo then
		mo = Activity204MO.New()

		mo:init(activityId)
		self:addAtLast(mo)
	end

	return mo
end

function Activity204Model:onFinishAct204Task(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:finishTask(info.taskId)
	end
end

function Activity204Model:onGetAct204MilestoneReward(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:acceptRewards(info.getMilestoneProgress)
	end
end

function Activity204Model:onGetAct204DailyCollection(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:onGetDailyCollection()
	end
end

function Activity204Model:onAct204TaskPush(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:pushTask(info.act204Tasks, info.deleteTasks)
	end
end

function Activity204Model:onGetOnceBonusReply(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:onGetOnceBonus(info)
	end
end

function Activity204Model:getLocalPrefsTab(key, activityId)
	local uniqueKey = self:prefabKeyPrefs(key, activityId)

	if not self.localPrefsDict[uniqueKey] then
		local tab = {}
		local saveStr = Activity204Controller.instance:getPlayerPrefs(uniqueKey)
		local saveStateList = GameUtil.splitString2(saveStr, true)

		if saveStateList then
			for _, param in ipairs(saveStateList) do
				local id = param[1]

				tab[id] = param[2]
			end
		end

		self.localPrefsDict[uniqueKey] = tab
	end

	return self.localPrefsDict[uniqueKey]
end

function Activity204Model:getLocalPrefsState(key, activityId, id, defaultState)
	local tab = self:getLocalPrefsTab(key, activityId)

	return tab[id] or defaultState
end

function Activity204Model:setLocalPrefsState(key, activityId, id, value)
	local tab = self:getLocalPrefsTab(key, activityId)

	if tab[id] == value then
		return
	end

	tab[id] = value

	local list = {}

	for k, v in pairs(tab) do
		table.insert(list, string.format("%s#%s", k, v))
	end

	local value = table.concat(list, "|")
	local uniqueKey = self:prefabKeyPrefs(key, activityId)

	Activity204Controller.instance:setPlayerPrefs(uniqueKey, value)
end

function Activity204Model:prefabKeyPrefs(key, activityId)
	if string.nilorempty(key) then
		return key
	end

	return (string.format("%s_%s", key, activityId))
end

function Activity204Model:checkReadTasks(taskIds)
	if taskIds then
		for k, v in pairs(taskIds) do
			self:checkReadTask(v)
		end
	end
end

function Activity204Model:checkReadTask(taskId)
	if not taskId then
		return
	end

	local mo = self:getActMo(self:getActId())

	if not mo then
		return
	end

	local taskInfo = mo:getTaskInfo(taskId)

	if not taskInfo then
		return
	end

	if taskInfo.hasGetBonus then
		return
	end

	if mo:checkTaskCanReward(taskInfo) then
		return
	end

	TaskRpc.instance:sendFinishReadTaskRequest(taskId)
end

function Activity204Model:hasNewTask(actId)
	local actMo = self:getActMo(actId)

	return actMo and actMo:hasNewTask()
end

function Activity204Model:recordHasReadNewTask(actId)
	local actMo = self:getActMo(actId)

	if actMo then
		actMo:recordHasReadNewTask()
	end
end

Activity204Model.instance = Activity204Model.New()

return Activity204Model
