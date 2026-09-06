-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/model/OriginZhengliModel.lua

module("logic.extensions.originzhengli.model.OriginZhengliModel", package.seeall)

local OriginZhengliModel = class("OriginZhengliModel", BaseModel)

function OriginZhengliModel:onInit()
	self:onReset()
end

function OriginZhengliModel:onReset()
	self._infoMap = {}
	self._stageInfoMap = {}
	self._lastFightResult = nil
end

function OriginZhengliModel:getInfoByActId(activityId)
	local info = self._infoMap[activityId]

	if not info then
		printInfo("源起正理数据不存在，activityId=%d", activityId)
	end

	return info
end

function OriginZhengliModel:getStageInfoMap(activityId)
	return self._stageInfoMap[activityId]
end

function OriginZhengliModel:getStageInfoById(activityId, stageId)
	if self._stageInfoMap and self._stageInfoMap[activityId] then
		return self._stageInfoMap[activityId][stageId]
	end
end

function OriginZhengliModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._infoMap[activityId] = info

	local stageInfoMap = {}

	if not info.stageInfo then
		for _, stageInfo in ipairs(info.stageInfo) do
			stageInfoMap[stageInfo.stageId] = stageInfo
		end

		self._stageInfoMap[activityId] = stageInfoMap
	end
end

function OriginZhengliModel:onResetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._stageInfoMap[activityId] = {}

	local cacheInfo = self._infoMap[activityId]

	if cacheInfo then
		cacheInfo.curRoute = 0
		cacheInfo.curStageId = 0
		cacheInfo.hasPassRouteId = {}
		cacheInfo.stageInfo = {}
	end
end

function OriginZhengliModel:onSelectRoute(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local routeId = info.routeId
	local cacheInfo = self._infoMap[activityId]

	if cacheInfo then
		cacheInfo.curRoute = routeId
	end
end

function OriginZhengliModel:clearLastFightInfo()
	self._lastFightResult = nil
end

function OriginZhengliModel:onNotifyClgResult(msg)
	self._lastFightResult = GameUtil.pbToTable(msg)
end

function OriginZhengliModel:getLastFightInfo()
	return self._lastFightResult
end

function OriginZhengliModel:getCurPoints(activityId)
	local curPoint = 0

	if not self._stageInfoMap[activityId] then
		for _, stageInfo in pairs(self._stageInfoMap[activityId]) do
			curPoint = curPoint + (stageInfo.gainPoints or 0)
		end

		return curPoint
	end
end

function OriginZhengliModel:getCostPoints(activityId)
	local costPoint = 0

	if not self._stageInfoMap[activityId] then
		for _, stageInfo in pairs(self._stageInfoMap[activityId]) do
			if not stageInfo.activateBuff then
				local activateBuff = 0

				if activateBuff ~= 0 then
					local buffCfg = OriginZhengliConfig.instance:getBuffCfgById(activityId, activateBuff)

					if buffCfg then
						costPoint = costPoint + (buffCfg.activateNeedPoints or 0)
					end
				end
			end
		end

		return costPoint
	end
end

function OriginZhengliModel:getRemainPoints(activityId)
	return self:getCurPoints(activityId) - self:getCostPoints(activityId)
end

OriginZhengliModel.instance = OriginZhengliModel.New()

return OriginZhengliModel
