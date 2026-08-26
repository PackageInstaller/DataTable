-- chunkname: @modules/logic/weekwalk_2/model/WeekWalk_2Model.lua

module("modules.logic.weekwalk_2.model.WeekWalk_2Model", package.seeall)

local WeekWalk_2Model = class("WeekWalk_2Model", BaseModel)

function WeekWalk_2Model:onInit()
	return
end

function WeekWalk_2Model:reInit()
	self._weekWalkInfo = nil
	self._weekWalkSettleInfo = nil
	self._isWin = nil
end

function WeekWalk_2Model:initFightSettleInfo(result, cupInfos)
	self._isWin = result == 1
	self._resultCupInfos = GameUtil.rpcInfosToMap(cupInfos, WeekwalkVer2CupInfoMO, "index")
end

function WeekWalk_2Model:isWin()
	return self._isWin
end

function WeekWalk_2Model:getResultCupInfos()
	return self._resultCupInfos
end

function WeekWalk_2Model:initSettleInfo(info)
	local infoMo = WeekwalkVer2SettleInfoMO.New()

	infoMo:init(info)

	self._weekWalkSettleInfo = infoMo
end

function WeekWalk_2Model:getSettleInfo()
	return self._weekWalkSettleInfo
end

function WeekWalk_2Model:clearSettleInfo()
	self._weekWalkSettleInfo = nil
end

function WeekWalk_2Model:updateInfo(info)
	self:initInfo(info)
end

function WeekWalk_2Model:initInfo(info)
	local infoMo = WeekwalkVer2InfoMO.New()

	callWithCatch(function()
		infoMo:init(info)
	end)

	self._weekWalkInfo = infoMo
end

function WeekWalk_2Model:getInfo()
	return self._weekWalkInfo
end

function WeekWalk_2Model:getTimeId()
	return self._weekWalkInfo and self._weekWalkInfo.timeId
end

function WeekWalk_2Model:getLayerInfo(id)
	return self._weekWalkInfo and self._weekWalkInfo:getLayerInfo(id)
end

function WeekWalk_2Model:getLayerInfoByLayerIndex(id)
	return self._weekWalkInfo and self._weekWalkInfo:getLayerInfoByLayerIndex(id)
end

function WeekWalk_2Model:setBattleElementId(id)
	self._battleElementId = id
end

function WeekWalk_2Model:getBattleElementId()
	return self._battleElementId
end

function WeekWalk_2Model:setCurMapId(id)
	self._curMapId = id
end

function WeekWalk_2Model:getCurMapId()
	return self._curMapId
end

function WeekWalk_2Model:getCurMapInfo()
	return self:getLayerInfo(self._curMapId)
end

function WeekWalk_2Model:getBattleInfo(mapId, id)
	local mapInfo = self:getLayerInfo(mapId)

	return mapInfo and mapInfo:getBattleInfoByBattleId(id)
end

function WeekWalk_2Model:getBattleInfoByLayerAndIndex(layer, index)
	if self._weekWalkInfo then
		local mapInfo = self._weekWalkInfo:getLayerInfoByLayerIndex(layer)

		return self._weekWalkInfo and self._weekWalkInfo:getBattleInfoByIndex(index)
	end
end

function WeekWalk_2Model:getBattleInfoByIdAndIndex(mapId, index)
	if self._weekWalkInfo then
		local mapInfo = self._weekWalkInfo:getLayerInfo(mapId)

		return self._weekWalkInfo and self._weekWalkInfo:getBattleInfoByIndex(index)
	end
end

function WeekWalk_2Model:getCurMapHeroCd(heroId)
	return self:getHeroCd(self._curMapId, heroId)
end

function WeekWalk_2Model:getHeroCd(mapId, heroId)
	local mapInfo = self:getLayerInfo(mapId)
	local inCD = mapInfo and mapInfo:heroInCD(heroId)

	return inCD and 1 or 0
end

function WeekWalk_2Model:getFightParam()
	local elementId = self:getBattleElementId()
	local layerId = self:getCurMapId()
	local obj = {
		elementId = elementId,
		layerId = layerId
	}
	local skillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

	if skillId then
		obj.chooseSkillIds = {
			skillId
		}
	end

	return cjson.encode(obj)
end

function WeekWalk_2Model:setFinishMapId(mapId)
	self._curFinishMapId = mapId
end

function WeekWalk_2Model:getFinishMapId()
	return self._curFinishMapId
end

WeekWalk_2Model.instance = WeekWalk_2Model.New()

return WeekWalk_2Model
