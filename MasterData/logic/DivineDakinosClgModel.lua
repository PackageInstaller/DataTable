-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/model/DivineDakinosClgModel.lua

module("logic.extensions.divinedakinosclg.model.DivineDakinosClgModel", package.seeall)

local DivineDakinosClgModel = class("DivineDakinosClgModel", BaseModel)

function DivineDakinosClgModel:ctor()
	return
end

function DivineDakinosClgModel:onInit()
	self:onReset()
end

function DivineDakinosClgModel:onReset()
	self._activityId = 0
	self._phaseList = {}
	self._phaseInfoMap = {}
	self._fmtMo = nil
	self._msgPool = {}
end

function DivineDakinosClgModel:_onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._activityId = info.activityId
	self._phaseList = info.phaseList
	self._phaseInfoMap = {}

	for i, info in ipairs(self._phaseList) do
		self._phaseInfoMap[info.phaseId] = info
	end

	self._msgPool[info.activityId] = info
end

function DivineDakinosClgModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function DivineDakinosClgModel:_onNotifyFight(msg)
	return
end

function DivineDakinosClgModel:getPhaseList()
	return self._phaseList or {}
end

function DivineDakinosClgModel:getPhaseInfo(activityId, phaseId)
	local pb = self:getInfo(activityId) or {}

	for i, phaseInfo in ipairs(pb.phaseList or {}) do
		if phaseInfo.phaseId == phaseId then
			return phaseInfo
		end
	end

	return nil
end

function DivineDakinosClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineDakinosClgFmtMo.New()

	return self._fmtMo
end

DivineDakinosClgModel.instance = DivineDakinosClgModel.New()

return DivineDakinosClgModel
