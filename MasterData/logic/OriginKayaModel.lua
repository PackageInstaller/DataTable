-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/model/OriginKayaModel.lua

module("logic.extensions.originkaya.model.OriginKayaModel", package.seeall)

local OriginKayaModel = class("OriginKayaModel", BaseModel)

function OriginKayaModel:ctor()
	return
end

function OriginKayaModel:onInit()
	self:onReset()
end

function OriginKayaModel:onReset()
	self._infos = {}
	self._floorInfo = {}
	self._fmtMo = nil
end

function OriginKayaModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginKayaFmtMo.New()

	return self._fmtMo
end

function OriginKayaModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local floorInfos = {}

	for i, v in ipairs(data.floorInfos or {}) do
		floorInfos[v.floorId] = v

		local floorInfo = floorInfos[v.floorId]
		local seedInfo = {}

		for j, stageInfo in ipairs(v.stageInfos or {}) do
			for m, seedId in ipairs(stageInfo.seedId or {}) do
				seedInfo[seedId] = {
					attr = stageInfo.attributeId,
					stageId = v.stageId
				}
			end
		end

		floorInfo.seedInfo = seedInfo
	end

	self._infos[msg.activityId] = data
	self._floorInfo[msg.activityId] = floorInfos
end

function OriginKayaModel:isPassFloor(activityId, floorId)
	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		return self._floorInfo[activityId][floorId].hasPass or false
	end

	return false
end

function OriginKayaModel:getPassStage(activityId, floorId)
	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		return self._floorInfo[activityId][floorId].maxPassStageId
	end

	return 0
end

function OriginKayaModel:getSeedInfo(activityId, floorId, seedId)
	if self._floorInfo[activityId] and self._floorInfo[activityId][floorId] then
		return self._floorInfo[activityId][floorId].seedInfo[seedId]
	end
end

function OriginKayaModel:saveResetInfo(msg)
	if self._floorInfo[msg.activityId] and self._floorInfo[msg.activityId][msg.floorId] then
		self._floorInfo[msg.activityId][msg.floorId].maxPassStageId = 0
		self._floorInfo[msg.activityId][msg.floorId].seedInfo = {}
	end
end

function OriginKayaModel:saveBattleEndInfo(msg)
	if self._floorInfo[msg.activityId] then
		self._floorInfo[msg.activityId][msg.floorId] = self._floorInfo[msg.activityId][msg.floorId] or {}

		local floorInfo = self._floorInfo[msg.activityId][msg.floorId]

		floorInfo.floorId = msg.floorId

		if checknumber(msg.changeSetId) > 0 then
			floorInfo.hasPass = true
		end

		floorInfo.maxPassStageId = msg.stageId
		floorInfo.seedInfo = floorInfo.seedInfo or {}

		for i, v in ipairs(msg.useSeed) do
			floorInfo.seedInfo[v] = {
				attr = msg.gainAttributeId,
				stageId = msg.stageId
			}
		end
	end
end

OriginKayaModel.instance = OriginKayaModel.New()

return OriginKayaModel
