-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/model/OriginKingMoYanClgModel.lua

module("logic.extensions.originkingmoyanclg.model.OriginKingMoYanClgModel", package.seeall)

local OriginKingMoYanClgModel = class("OriginKingMoYanClgModel", BaseModel)
local DRAG_TYPE_FLOWER = 1
local DRAG_TYPE_FIRE = 2

function OriginKingMoYanClgModel:ctor()
	return
end

function OriginKingMoYanClgModel:onInit()
	self:onReset()
end

function OriginKingMoYanClgModel:onReset()
	self._infos = {}
	self._floorInfo = {}
	self._fmtMo = nil
end

function OriginKingMoYanClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginKingMoYanClgFmtMo.New()

	return self._fmtMo
end

function OriginKingMoYanClgModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data

	local floorInfo = {}

	if data.phaseList then
		for i, v in ipairs(data.phaseList) do
			floorInfo[v.phaseId] = self:saveFloorInfo(v)
		end
	end

	self._floorInfo[data.activityId] = floorInfo
end

function OriginKingMoYanClgModel:saveFloorInfo(data)
	local info = {}

	info.passStageId = {}
	info.flowerPointId = {}
	info.firePointId = {}
	info.info = data

	if data.passStageIds then
		for i, id in ipairs(data.passStageIds) do
			info.passStageId[id] = true
		end
	end

	if data.flowerPointIds then
		for i, id in ipairs(data.flowerPointIds) do
			info.flowerPointId[id] = true
		end
	end

	if data.firePointIds then
		for i, id in ipairs(data.firePointIds) do
			info.firePointId[id] = true
		end
	end

	return info
end

function OriginKingMoYanClgModel:isFloorPass(activityId, floorId)
	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		return self._floorInfo[activityId][floorId].info.gainPrize
	end

	return false
end

function OriginKingMoYanClgModel:isStagePass(activityId, floorId, stageId)
	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		return self._floorInfo[activityId][floorId].passStageId[stageId]
	end

	return false
end

function OriginKingMoYanClgModel:isSetFlower(activityId, floorId, id)
	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		return self._floorInfo[activityId][floorId].flowerPointId[id]
	end

	return false
end

function OriginKingMoYanClgModel:getSetFlowerIds(activityId, floorId)
	local result = {}

	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		for k, v in pairs(self._floorInfo[activityId][floorId].flowerPointId) do
			if v == true then
				table.insert(result, k)
			end
		end
	end

	return result
end

function OriginKingMoYanClgModel:isSetFire(activityId, floorId, id)
	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		return self._floorInfo[activityId][floorId].firePointId[id]
	end

	return false
end

function OriginKingMoYanClgModel:getSetFireIds(activityId, floorId)
	local result = {}

	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		for k, v in pairs(self._floorInfo[activityId][floorId].firePointId) do
			if v == true then
				table.insert(result, k)
			end
		end
	end

	return result
end

function OriginKingMoYanClgModel:saveSetItem(msg)
	self._floorInfo[msg.activityId] = self._floorInfo[msg.activityId] or {}

	if not self._floorInfo[msg.activityId][msg.phaseId] then
		self._floorInfo[msg.activityId][msg.phaseId] = {}

		local info = self._floorInfo[msg.activityId][msg.phaseId]

		info.passStageId = {}
		info.flowerPointId = {}
		info.firePointId = {}
		info.info = {}
	end

	local floorInfo = self._floorInfo[msg.activityId][msg.phaseId]

	if msg.type == DRAG_TYPE_FLOWER then
		floorInfo.flowerPointId[msg.pointId] = true
	elseif msg.type == DRAG_TYPE_FIRE then
		floorInfo.firePointId[msg.pointId] = true
	end
end

function OriginKingMoYanClgModel:saveResetItem(msg)
	self._floorInfo[msg.activityId] = self._floorInfo[msg.activityId] or {}
	self._floorInfo[msg.activityId][msg.phaseId] = self:saveFloorInfo(msg.phaseInfo)
end

function OriginKingMoYanClgModel:saveResetFloor(msg)
	if self._floorInfo[msg.activityId] and self._floorInfo[msg.activityId][msg.phaseInfo.phaseId] then
		self._floorInfo[msg.activityId][msg.phaseInfo.phaseId] = self:saveFloorInfo(msg.phaseInfo)
	end
end

function OriginKingMoYanClgModel:saveBattleInfo(msg)
	self._floorInfo[msg.activityId] = self._floorInfo[msg.activityId] or {}
	self._floorInfo[msg.activityId][msg.phaseInfo.phaseId] = self:saveFloorInfo(msg.phaseInfo)
end

OriginKingMoYanClgModel.instance = OriginKingMoYanClgModel.New()

return OriginKingMoYanClgModel
