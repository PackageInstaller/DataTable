-- chunkname: @modules/logic/meilanni/model/MeilanniModel.lua

module("modules.logic.meilanni.model.MeilanniModel", package.seeall)

local MeilanniModel = class("MeilanniModel", BaseModel)

function MeilanniModel:onInit()
	self:_clear()
end

function MeilanniModel:reInit()
	self:_clear()
end

function MeilanniModel:_clear()
	self._mapInfoList = {}
	self._curMapId = nil
end

function MeilanniModel:setCurMapId(id)
	self._curMapId = id
end

function MeilanniModel:getCurMapId()
	return self._curMapId
end

function MeilanniModel:setBattleElementId(id)
	self._battleElementId = id
end

function MeilanniModel:getBattleElementId()
	return self._battleElementId
end

function MeilanniModel:updateMapList(infos)
	for i, v in ipairs(infos) do
		self:updateMapInfo(v)
	end
end

function MeilanniModel:updateMapInfo(v)
	if not self._mapInfoList[v.mapId] then
		local info = MeilanniMapInfoMO.New()

		self._mapInfoList[v.mapId]:init(v)

		self._mapInfoList[v.mapId] = self._mapInfoList[v.mapId]
	end
end

function MeilanniModel:updateMapExcludeRules(v)
	local info = self._mapInfoList[v.mapId]

	if info then
		info:updateExcludeRules(v)
	end
end

function MeilanniModel:getMapInfo(mapId)
	return self._mapInfoList[mapId]
end

function MeilanniModel:getMapHighestScore(mapId)
	local mapInfo = self._mapInfoList[mapId]

	return (mapInfo or nil) and (mapInfo.highestScore or 0)
end

function MeilanniModel:updateEpisodeInfo(info)
	local mapId = info.mapId
	local mapInfo = self:getMapInfo(mapId)

	if mapInfo then
		mapInfo:updateEpisodeInfo(info)
	end
end

function MeilanniModel:getEventInfo(mapId, id)
	local mapInfo = self:getMapInfo(mapId)

	return mapInfo and mapInfo:getEventInfo(id)
end

function MeilanniModel:getMapIdByBattleId(id)
	for k, v in pairs(self._mapInfoList) do
		if v:getEpisodeByBattleId(id) then
			return v.mapId
		end
	end
end

function MeilanniModel:setDialogItemFadeIndex(value)
	self._dialogItemFadeIndex = value
end

function MeilanniModel:getDialogItemFadeIndex()
	if self._dialogItemFadeIndex and self._dialogItemFadeIndex >= 0 then
		self._dialogItemFadeIndex = self._dialogItemFadeIndex + 1
	end

	return self._dialogItemFadeIndex
end

function MeilanniModel:setStatResult(statResult)
	self.statResult = statResult
end

function MeilanniModel:getStatResult()
	return self.statResult
end

MeilanniModel.instance = MeilanniModel.New()

return MeilanniModel
