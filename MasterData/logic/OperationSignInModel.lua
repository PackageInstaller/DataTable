-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/model/OperationSignInModel.lua

module("logic.extensions.operationsignin.model.OperationSignInModel", package.seeall)

local OperationSignInModel = class("OperationSignInModel", BaseModel)

function OperationSignInModel:ctor()
	return
end

function OperationSignInModel:onInit()
	self:onReset()
end

function OperationSignInModel:onReset()
	self._onlineDay = nil
	self._daysList = {}
	self._hasGetData = false
	self._timeStamp = nil
	self._activityId = nil
end

function OperationSignInModel:getHasGetData()
	return self._hasGetData
end

function OperationSignInModel:setHasGetData(torf)
	self._hasGetData = torf
end

function OperationSignInModel:setData(msg)
	self._onlineDay = msg.onlineDay

	local cfg = OperationSignInConfig.instance:getSignInCfgList(self._activityId)

	for k, v in pairs(cfg) do
		table.insert(self._daysList, false)
	end

	if msg.hasGainPrizeDays then
		for k, v in pairs(msg.hasGainPrizeDays) do
			self._daysList[v] = true
		end
	end

	self._hasGetData = true
end

function OperationSignInModel:setDaysList(day)
	self._daysList[day] = true
end

function OperationSignInModel:getDaysList()
	return self._daysList
end

function OperationSignInModel:getDaysListByDay(day)
	return self._daysList[day]
end

function OperationSignInModel:getOnlineDay()
	return self._onlineDay
end

function OperationSignInModel:setActivityId(activityId)
	self._activityId = activityId
end

function OperationSignInModel:getActivityId()
	return self._activityId
end

function OperationSignInModel:setLastTimeStamp()
	self._timeStamp = ServerTime.now()
end

function OperationSignInModel:getLastTimeStamp()
	return self._timeStamp
end

function OperationSignInModel:getCurActicityId()
	local cfg = self:getCurActicityCfg()

	return cfg and cfg.activityId
end

function OperationSignInModel:getCurActicityCfg()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn)

	if cfg then
		return cfg
	else
		return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn2)
	end
end

OperationSignInModel.instance = OperationSignInModel.New()

return OperationSignInModel
