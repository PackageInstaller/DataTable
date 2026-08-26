-- chunkname: @modules/logic/weekwalk/model/WeekWalkModel.lua

module("modules.logic.weekwalk.model.WeekWalkModel", package.seeall)

local WeekWalkModel = class("WeekWalkModel", BaseModel)

function WeekWalkModel:onInit()
	return
end

function WeekWalkModel:reInit()
	self._battleElementId = nil
	self._weekWalkInfo = nil
	self._curFinishMapId = nil
end

function WeekWalkModel.isShallowLayer(layer)
	return layer and layer <= 10
end

function WeekWalkModel.isShallowMap(mapId)
	return mapId and WeekWalkEnum.ShallowMapIds[mapId]
end

function WeekWalkModel:setFinishMapId(mapId)
	self._curFinishMapId = mapId
end

function WeekWalkModel:getFinishMapId()
	return self._curFinishMapId
end

function WeekWalkModel:setCurMapId(id)
	self._curMapId = id
end

function WeekWalkModel:getCurMapId()
	return self._curMapId
end

function WeekWalkModel:getCurMapConfig()
	return (WeekWalkConfig.instance:getMapConfig(self._curMapId))
end

function WeekWalkModel:getCurMapIsFinish()
	local mapInfo = self:getCurMapInfo()

	return mapInfo.isFinish > 0
end

function WeekWalkModel:getCurMapInfo()
	return self:getMapInfo(self._curMapId)
end

function WeekWalkModel:getOldOrNewCurMapInfo()
	return self._oldInfo and self._oldInfo:getMapInfo(self._curMapId) or self:getCurMapInfo()
end

function WeekWalkModel:getMapInfo(id)
	return self._weekWalkInfo and self._weekWalkInfo:getMapInfo(id)
end

function WeekWalkModel:setBattleElementId(id)
	self._battleElementId = id
end

function WeekWalkModel:getBattleElementId()
	return self._battleElementId
end

function WeekWalkModel:infoNeedUpdate()
	return self._oldInfo
end

function WeekWalkModel:updateHeroHpInfo(heroId, hp)
	self._weekWalkInfo:updateHeroHpInfo(heroId, hp)
end

function WeekWalkModel:updateInfo(info)
	self:initInfo(info)
end

function WeekWalkModel:initInfo(info, force)
	local infoMo = WeekwalkInfoMO.New()

	infoMo:init(info)

	self._weekWalkInfo = infoMo
end

function WeekWalkModel:getInfo()
	return self._weekWalkInfo
end

function WeekWalkModel:addOldInfo()
	if not self._curMapId or WeekWalkModel.isShallowMap(self._curMapId) then
		return
	end

	self._oldInfo = self._weekWalkInfo
end

function WeekWalkModel:clearOldInfo()
	self._oldInfo = nil
end

function WeekWalkModel:getMaxLayerId()
	return self._weekWalkInfo.maxLayer
end

function WeekWalkModel:getOldOrNewElementInfos(mapId)
	if self._oldInfo then
		if self._oldInfo then
			local mapInfo = self._oldInfo:getMapInfo(mapId)

			if self._oldInfo then
				return self._oldInfo.elementInfos
			end
		end
	end

	return self:getElementInfos(mapId)
end

function WeekWalkModel:getElementInfos(mapId)
	local mapInfo = self:getMapInfo(mapId)

	return mapInfo and mapInfo.elementInfos
end

function WeekWalkModel:getElementInfo(mapId, id)
	local mapInfo = self:getMapInfo(mapId)

	return mapInfo and mapInfo:getElementInfo(id)
end

function WeekWalkModel:getBattleInfo(mapId, id)
	local mapInfo = self:getMapInfo(mapId)

	return mapInfo and mapInfo:getBattleInfo(id)
end

function WeekWalkModel:getBattleInfoByLayerAndIndex(layer, index)
	if self._weekWalkInfo then
		local mapInfo = self._weekWalkInfo:getMapInfoByLayer(layer)

		return self._weekWalkInfo and self._weekWalkInfo:getBattleInfoByIndex(index)
	end
end

function WeekWalkModel:getCurMapHeroCd(heroId)
	return self:getHeroCd(self._curMapId, heroId)
end

function WeekWalkModel:getHeroCd(mapId, heroId)
	local mapInfo = self:getMapInfo(mapId)

	return mapInfo and mapInfo:getHeroCd(heroId) or 0
end

function WeekWalkModel:setSkipShowSettlementView(value)
	self._skipShowSettlementView = value
end

function WeekWalkModel:getSkipShowSettlementView()
	return self._skipShowSettlementView
end

WeekWalkModel.instance = WeekWalkModel.New()

return WeekWalkModel
