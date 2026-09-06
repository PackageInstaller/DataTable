-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/model/SuppressGameModel.lua

module("logic.extensions.suppressgame.model.SuppressGameModel", package.seeall)

local SuppressGameModel = class("SuppressGameModel", BaseModel)

function SuppressGameModel:ctor()
	return
end

function SuppressGameModel:onInit()
	self:onReset()
end

function SuppressGameModel:onReset()
	self._activityId = 0
	self._dailyGameTime = 0
	self._tabList = {}
	self._curGameId = 0
	self._clientKey = 0
	self._serverKey = 0
	self._taskList = {}
end

function SuppressGameModel:onHandleSuppressGameGetInfoRes(msg)
	self._activityId = msg.activityId
	self._dailyGameTime = msg.dailyGameTime
	self._tabList = msg.tabList
	self._curGameId = msg.curGameId
end

function SuppressGameModel:onHandleSuppressGameStartGameRes(msg)
	self._curGameId = msg.gameId
	self._clientKey = msg.clientKey
	self._serverKey = msg.serverKey
end

function SuppressGameModel:onHandleSuppressGameEndGameRes(msg)
	return
end

function SuppressGameModel:onHandleSuppressGameGetTaskInfoRes(msg)
	self._activityId = msg.activityId
	self._taskList = msg.taskList
end

function SuppressGameModel:onHandleSuppressGameGainPrizeRes(msg)
	return
end

function SuppressGameModel:getCurActivityId()
	return self._activityId
end

function SuppressGameModel:getCurGameId()
	return self._curGameId
end

function SuppressGameModel:getTabList()
	return self._tabList
end

function SuppressGameModel:getDailyGameTime()
	return self._dailyGameTime
end

function SuppressGameModel:getEncryptedKey(gameScore)
	return GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		gameScore
	})
end

function SuppressGameModel:getGameProgress(gameId)
	local tabList = self:getTabList()
	local progress = 0

	for _, tabInfo in ipairs(tabList) do
		if gameId == tabInfo.gameId then
			progress = tabInfo.progress

			break
		end
	end

	return progress
end

function SuppressGameModel:getTaskList()
	return self._taskList or {}
end

function SuppressGameModel:getTaskProgress(gameId)
	local taskList = self:getTaskList()
	local progress = 0

	for _, info in ipairs(taskList) do
		if info.gameId == gameId then
			progress = info.progress

			break
		end
	end

	return progress
end

function SuppressGameModel:isTaskHasGainPrize(gameId, taskId)
	local taskList = self:getTaskList()
	local isHasGain = false

	for _, info in ipairs(taskList) do
		if gameId == info.gameId then
			for _, id in ipairs(info.gainPrizeIds) do
				if id == taskId then
					isHasGain = true

					break
				end
			end
		end
	end

	return isHasGain
end

function SuppressGameModel:isTaskEnoughProgress(gameId, taskId)
	local curProgress = self:getTaskProgress(gameId)
	local activityId = self:getCurActivityId()
	local tabData = SuppressGameConfig.instance:getSgTabData(activityId, gameId)
	local taskData = SuppressGameConfig.instance:getSgTaskData(tabData.taskPlanId, taskId)

	return curProgress >= taskData.progress
end

SuppressGameModel.instance = SuppressGameModel.New()

return SuppressGameModel
