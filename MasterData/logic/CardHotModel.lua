-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/model/CardHotModel.lua

module("logic.extensions.cardhot.model.CardHotModel", package.seeall)

local CardHotModel = class("CardHotModel", BaseModel)

function CardHotModel:ctor()
	CardHotModel.super.ctor(self)
end

function CardHotModel:onInit()
	self:onReset()
end

function CardHotModel:onReset()
	self.taskInfos = {}
	self.totalScore = 0
	self.hasGainProgessPrize = {}
	self.taskId = nil
end

function CardHotModel:sendGetAllTask(activityId)
	DarkDragonPreheatAgent.instance:sendPM_DarkDragonPreheatGetInfoReq(activityId)
end

function CardHotModel:getGetAllTask(msg)
	self.taskInfos = {}

	for k, v in ipairs(msg.taskInfos) do
		self.taskInfos[v.taskId] = v
	end

	self.totalScore = msg.totalScore
	self.hasGainProgessPrize = msg.hasGainProgessPrize

	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkDragonPreheatGetInfo)
end

function CardHotModel:sendGetPrize(activityId, taskId)
	self.taskId = taskId

	DarkDragonPreheatAgent.instance:sendPM_DarkDragonPreheatGainProgressPrizeReq(activityId, taskId)
end

function CardHotModel:onGetPrize(msg)
	if self.taskId then
		table.insert(self.hasGainProgessPrize, self.taskId)

		self.taskId = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkDragonPreheatGetInfo)
end

function CardHotModel:sendGetTaskPrize(activityId, taskId)
	self.activityId = activityId
	self.taskId = taskId

	DarkDragonPreheatAgent.instance:sendPM_DarkDragonPreheatGainTaskPrizeReq(activityId, taskId)
end

function CardHotModel:onGetTaskPrize(msg)
	if self.taskId then
		local data = CardhotConfig.instance:getTaskDetailsCfg(self.activityId)[self.taskId] or {}

		self.totalScore = self.totalScore + checknumber(data.score)

		local taskInfo = self:getTaskInfo(self.taskId)

		taskInfo.curProgress = taskInfo.curProgress + 1
		taskInfo.hasGainPrize = true
		self.taskId = nil
		self.activityId = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkDragonPreheatGetInfo)
end

function CardHotModel:sendPlayStory(summaryId, taskId)
	DarkDragonPreheatAgent.instance:sendPM_DarkDragonPreheatFinishStoryReq(summaryId, taskId)
end

function CardHotModel:onPlayStory(msg)
	local taskInfo = msg.taskInfo

	self.taskInfos[taskInfo.taskId] = taskInfo

	GlobalDispatcher:dispatch(GlobalNotify.PM_ActivitySummaryGetTaskInfo)
end

function CardHotModel:getTaskInfo(taskId)
	if self.taskInfos then
		return self.taskInfos[taskId] or {}
	end

	return {}
end

CardHotModel.instance = CardHotModel.New()

return CardHotModel
