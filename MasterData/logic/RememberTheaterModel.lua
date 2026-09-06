-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/remembertheater/model/RememberTheaterModel.lua

module("logic.extensions.remembertheater.model.RememberTheaterModel", package.seeall)

local RememberTheaterModel = class("RememberTheaterModel", BaseModel)

RememberTheaterModel.ReadFlag = "RememberTheaterModel.ReadFlag"

function RememberTheaterModel:ctor()
	self._tabId2ActIdTaskId = {}
	self.summaryId = 17042
end

function RememberTheaterModel:onInit()
	self:onReset()
end

function RememberTheaterModel:onReset()
	return
end

function RememberTheaterModel:getIsChapterRead(index)
	return GameUtil.getUserData(RememberTheaterModel.ReadFlag .. index)
end

function RememberTheaterModel:isLockChapter(index)
	local actId, taskId = self:_getActIdTaskIdByTabId(index)
	local taskInfo = OpSummaryModel.instance:getTaskInfo(taskId)

	if taskInfo and taskInfo.taskId then
		local taskCfg = OperationSummaryConfig.instance:getTaskDetailsCfgById(actId, taskId)

		return taskInfo.curProgress < taskCfg.maxProgress
	end

	return true
end

function RememberTheaterModel:isTastInfoNil()
	local actId, taskId = self:_getActIdTaskIdByTabId(1)
	local taskInfo = OpSummaryModel.instance:getTaskInfo(taskId)

	return taskInfo == nil
end

function RememberTheaterModel:setIsChapterRead(index)
	GameUtil.saveUserData(RememberTheaterModel.ReadFlag .. index, true)
end

function RememberTheaterModel:getIsGetPrize(index)
	local actId, taskId = self:_getActIdTaskIdByTabId(index)
	local taskInfo = OpSummaryModel.instance:getTaskInfo(taskId)

	return taskInfo and taskInfo.hasGainPrize
end

function RememberTheaterModel:isCanGainPrize(index)
	local actId, taskId = self:_getActIdTaskIdByTabId(index)
	local taskInfo = OpSummaryModel.instance:getTaskInfo(taskId)

	if taskInfo and taskInfo.taskId then
		local taskCfg = OperationSummaryConfig.instance:getTaskDetailsCfgById(actId, taskId)

		return not taskInfo.hasGainPrize and taskInfo.curProgress >= taskCfg.maxProgress
	end

	return false
end

function RememberTheaterModel:_getActIdTaskIdByTabId(tabId)
	if not self._tabId2ActIdTaskId[tabId] then
		local cfg = RememberTheaterConfig.instance:getTabCfg(tabId)
		local arr = string.split(cfg.taskParams, ",")
		local actId = checknumber(arr[1])
		local taskId = checknumber(arr[2])

		self._tabId2ActIdTaskId[tabId] = {
			actId = actId,
			taskId = taskId
		}
	end

	return self._tabId2ActIdTaskId[tabId].actId, self._tabId2ActIdTaskId[tabId].taskId
end

function RememberTheaterModel:haveRedPoint(tabId)
	return self:isCanGainPrize(tabId)
end

RememberTheaterModel.instance = RememberTheaterModel.New()

return RememberTheaterModel
