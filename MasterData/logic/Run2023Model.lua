-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/model/Run2023Model.lua

module("logic.extensions.run2023.model.Run2023Model", package.seeall)

local Run2023Model = class("Run2023Model", BaseModel)

function Run2023Model:ctor()
	return
end

function Run2023Model:onInit()
	self:onReset()
end

function Run2023Model:onReset()
	self._activityId = 0
	self._todayUseTimes = 0
	self._todayBest = 0
	self._historyBest = 0
	self._clientKey = 0
	self._serverKey = 0
	self._useTime = 0
	self._unlockedLabelId = {}
end

function Run2023Model:getActivityId()
	return self._activityId
end

function Run2023Model:getTodayUseTimes()
	return self._todayUseTimes
end

function Run2023Model:getLeftUseTimes()
	return Run2023Config.instance:getGameCfgsByActId(self:getActivityId()).dailyGameTimes - self:getTodayUseTimes()
end

function Run2023Model:getMaxUseTimes()
	local data = Run2023Config.instance:getGameCfgsByActId(self:getActivityId())

	return (data or nil) and (data.dailyGameTimes or 0)
end

function Run2023Model:getTodayBest()
	return self._todayBest
end

function Run2023Model:getHistoryBest()
	return self._historyBest
end

function Run2023Model:getUseTime()
	return self._historyBest
end

function Run2023Model:handleGameInfoRes(msg)
	self._activityId = msg.activityId
	self._todayUseTimes = msg.todayUseTimes
	self._todayBest = msg.todayBest
	self._historyBest = msg.historyBest

	local labelPlanId = Run2023Config.instance:getGameCfgsByActId(self._activityId).labelPlanId
	local _cfgList = Run2023Config.instance:getGameLabelCfgs(labelPlanId) or {}

	for k, v in pairs(_cfgList) do
		table.insert(self._unlockedLabelId, false)
	end

	if msg.unlockedLabelId then
		for k, v in ipairs(msg.unlockedLabelId) do
			self._unlockedLabelId[v] = true
		end
	end

	local leftUseTimes = self:getLeftUseTimes()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_RUN_GAME_CAN_PLAY, leftUseTimes > 0)
end

function Run2023Model:beforeStartGame()
	self._clientKey = math.random(1, 99)

	return self._clientKey
end

function Run2023Model:beforeEndGame(useTime)
	self._cacheUseTime = useTime

	return self:getEncryptedKey(useTime)
end

function Run2023Model:getEncryptedKey(...)
	local nums = {
		...
	}
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, nums)

	return tostring(encryptedKey)
end

function Run2023Model:handleStartGameRes(msg)
	self._serverKey = msg.serverKey
end

function Run2023Model:handleEndGameRes(msg)
	if self._cacheUseTime ~= nil then
		self._useTime = self._cacheUseTime
	end
end

function Run2023Model:handlePM_IntoTheCarSweepGameRes(msg)
	self._todayUseTimes = self._todayUseTimes + msg.sweepTimes
end

function Run2023Model:setUnlockedLabelId(msg)
	self._unlockedLabelId[msg.unlockedLabelId] = true
end

function Run2023Model:getUnlockedLabelList()
	return self._unlockedLabelId
end

Run2023Model.instance = Run2023Model.New()

return Run2023Model
