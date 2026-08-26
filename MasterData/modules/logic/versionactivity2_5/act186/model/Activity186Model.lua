-- chunkname: @modules/logic/versionactivity2_5/act186/model/Activity186Model.lua

module("modules.logic.versionactivity2_5.act186.model.Activity186Model", package.seeall)

local Activity186Model = class("Activity186Model", BaseModel)

function Activity186Model:onInit()
	self:reInit()
end

function Activity186Model:reInit()
	self.localPrefsDict = {}
end

function Activity186Model:getActId()
	local list = ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.Act186)

	return list and list[1]
end

function Activity186Model:isActivityOnline()
	local actId = self:getActId()

	if not actId then
		return false
	end

	return ActivityModel.instance:isActOnLine(actId)
end

function Activity186Model:setActInfo(info)
	local mo = self:getActMo(info.activityId)

	mo:updateInfo(info)
end

function Activity186Model:getActMo(activityId)
	local mo = self:getById(activityId)

	if not mo then
		mo = Activity186MO.New()

		mo:init(activityId)
		self:addAtLast(mo)
	end

	return mo
end

function Activity186Model:onFinishAct186Task(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:finishTask(info.taskId)
	end
end

function Activity186Model:onFinishAllAct186Task(info)
	local mo = self:getById(info.activityId)
	local taskIds = info.taskIds

	if mo and taskIds then
		for _, taskId in ipairs(taskIds) do
			mo:finishTask(taskId)
		end
	end
end

function Activity186Model:onGetAct186MilestoneReward(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:acceptRewards(info.getMilestoneProgress)
	end
end

function Activity186Model:onGetAct186DailyCollection(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:onGetDailyCollection()
	end
end

function Activity186Model:onAct186TaskPush(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:pushTask(info.act186Tasks, info.deleteTasks)
	end
end

function Activity186Model:onAct186LikePush(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:pushLike(info.likeInfos)
	end
end

function Activity186Model:onFinishAct186Game(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:finishGame(info)
	end
end

function Activity186Model:onBTypeGamePlay(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:playBTypeGame(info)
	end
end

function Activity186Model:onGetAct186SpBonusInfo(info)
	local mo = self:getActMo(info.act186ActivityId)

	mo:setSpBonusStage(info.spBonusStage)
end

function Activity186Model:onAcceptAct186SpBonus(info)
	local mo = self:getActMo(info.act186ActivityId)

	mo:setSpBonusStage(2)
end

function Activity186Model:onGetOnceBonusReply(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:onGetOnceBonus(info)
	end
end

function Activity186Model:getLocalPrefsTab(key, activityId)
	local uniqueKey = self:prefabKeyPrefs(key, activityId)

	if not self.localPrefsDict[uniqueKey] then
		local tab = {}
		local saveStr = Activity186Controller.instance:getPlayerPrefs(uniqueKey)
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

function Activity186Model:getLocalPrefsState(key, activityId, id, defaultState)
	local tab = self:getLocalPrefsTab(key, activityId)

	return tab[id] or defaultState
end

function Activity186Model:setLocalPrefsState(key, activityId, id, value)
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

	Activity186Controller.instance:setPlayerPrefs(uniqueKey, value)
end

function Activity186Model:prefabKeyPrefs(key, activityId)
	if string.nilorempty(key) then
		return key
	end

	return (string.format("%s_%s", key, activityId))
end

function Activity186Model:checkReadTasks(taskIds)
	if taskIds then
		for k, v in pairs(taskIds) do
			self:checkReadTask(v)
		end
	end
end

function Activity186Model:checkReadTask(taskId)
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

function Activity186Model:isShowSignRed()
	local signActId = ActivityEnum.Activity.V2a5_Act186Sign
	local status = ActivityHelper.getActivityStatus(signActId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local isShow = false
	local actId = self:getActId()
	local mo = self:getById(actId)

	if mo then
		isShow = mo.spBonusStage == 1
	end

	isShow = isShow or ActivityType101Model.instance:isType101RewardCouldGetAnyOne(signActId)

	return isShow
end

Activity186Model.instance = Activity186Model.New()

return Activity186Model
