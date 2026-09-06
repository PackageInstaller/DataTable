-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/model/OriginOrderDragonClgModel.lua

module("logic.extensions.originorderdragonclg.model.OriginOrderDragonClgModel", package.seeall)

local OriginOrderDragonClgModel = class("OriginOrderDragonClgModel", BaseModel)

function OriginOrderDragonClgModel:onInit()
	self:onReset()
end

function OriginOrderDragonClgModel:onReset()
	self._infoMap = {}
	self._stageInfoMap = {}
	self._lastFightResult = nil
end

function OriginOrderDragonClgModel:getInfoByActId(activityId)
	local info = self._infoMap[activityId]

	if not info then
		printInfo("源起秩序龙挑战数据不存在，activityId=%d", activityId)
	end

	return self._infoMap[activityId]
end

function OriginOrderDragonClgModel:getStageInfoMap(activityId)
	return self._stageInfoMap[activityId]
end

function OriginOrderDragonClgModel:getStageInfoById(activityId, stageId)
	if self._stageInfoMap and self._stageInfoMap[activityId] then
		return self._stageInfoMap[activityId][stageId]
	end
end

function OriginOrderDragonClgModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._infoMap[activityId] = info

	local stageInfoMap = {}

	if not info.stageList then
		for _, stageInfo in ipairs(info.stageList) do
			stageInfoMap[stageInfo.stageId] = stageInfo
		end

		self._stageInfoMap[activityId] = stageInfoMap
	end
end

function OriginOrderDragonClgModel:onResetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	if not info.stageList then
		local stageInfoMap = {}

		for _, stageInfo in ipairs(info.stageList) do
			stageInfoMap[stageInfo.stageId] = stageInfo
		end

		self._stageInfoMap[activityId] = stageInfoMap
	end
end

function OriginOrderDragonClgModel:onConfirmInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	if not self._stageInfoMap[activityId] then
		self._stageInfoMap[activityId][info.stageInfo.stageId] = info.stageInfo
		self._stageInfoMap[activityId] = self._stageInfoMap[activityId]
	end
end

function OriginOrderDragonClgModel:onNotifyFightResult(msg)
	self._lastFightResult = msg
end

function OriginOrderDragonClgModel:getLastFightInfo()
	return self._lastFightResult
end

OriginOrderDragonClgModel.instance = OriginOrderDragonClgModel.New()

return OriginOrderDragonClgModel
