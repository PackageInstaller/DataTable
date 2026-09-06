-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcardspack/model/MonthCardPackModel.lua

module("logic.extensions.model.agent.MonthCardPackModel", package.seeall)

local MonthCardPackModel = class("MonthCardPackModel", BaseModel)

function MonthCardPackModel:onInit()
	self:onReset()
end

function MonthCardPackModel:onReset()
	self._curActivityId = 0
	self._curActivityInfo = nil
end

function MonthCardPackModel:getActivityId()
	return self._curActivityId
end

function MonthCardPackModel:setActivityId(curActivityId)
	self._curActivityId = curActivityId
end

function MonthCardPackModel:setActivityInfo(acInfo)
	self._curActivityInfo = acInfo
end

function MonthCardPackModel:getActivityInfo()
	return self._curActivityInfo
end

function MonthCardPackModel:getRemainTimes()
	if self._curActivityInfo then
		return self._curActivityInfo.remainTimes
	end

	return 0
end

function MonthCardPackModel:getWholeLimitNums()
	if self._curActivityInfo then
		return self._curActivityInfo.limitNums
	end

	return 0
end

MonthCardPackModel.instance = MonthCardPackModel.New()

return MonthCardPackModel
