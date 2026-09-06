-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/model/OriginDiShiTianModel.lua

module("logic.extensions.origindishitian.model.OriginDiShiTianModel", package.seeall)

local OriginDiShiTianModel = class("OriginDiShiTianModel", BaseModel)

function OriginDiShiTianModel:onInit()
	self:onReset()
end

function OriginDiShiTianModel:onReset()
	self._fmtMo = nil
	self._infos = {}
end

function OriginDiShiTianModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginDiShiTianFmtMo.New()

	return self._fmtMo
end

function OriginDiShiTianModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data
end

function OriginDiShiTianModel:getCurStageId(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].curStageId
	end

	return 0
end

function OriginDiShiTianModel:getMaxStageId(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].maxStageId
	end

	return 0
end

function OriginDiShiTianModel:getLockPetList(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].lockPetRaceIds or {}
	end

	return {}
end

function OriginDiShiTianModel:saveResetInfo(msg)
	if self._infos[msg.activityId] then
		self._infos[msg.activityId].curStageId = 0
		self._infos[msg.activityId].lockPetRaceIds = {}
	end
end

function OriginDiShiTianModel:saveBattleInfo(msg)
	if self._tempResult then
		self._infos[msg.activityId].curStageId = msg.stageId

		if self._infos[msg.activityId].maxStageId < self._infos[msg.activityId].curStageId then
			self._infos[msg.activityId].maxStageId = msg.stageId
		end

		self._infos[msg.activityId].lockPetRaceIds = self._infos[msg.activityId].lockPetRaceIds or {}

		for i, v in ipairs(self._tempResult.lockPetRaceIds or {}) do
			table.insert(self._infos[msg.activityId].lockPetRaceIds, v)
		end
	end
end

function OriginDiShiTianModel:saveTempBattleResult(msg)
	self._tempResult = GameUtil.pbToTable(msg)
end

function OriginDiShiTianModel:getTempBattleResult()
	return self._tempResult
end

function OriginDiShiTianModel:resestBattleResult()
	self._tempResult = nil
end

function OriginDiShiTianModel:saveTempPrizeChangeSet(changeSetId)
	self._tempChangeSetId = changeSetId
end

function OriginDiShiTianModel:getTempPrizeChangeSet()
	return self._tempChangeSetId
end

OriginDiShiTianModel.instance = OriginDiShiTianModel.New()

return OriginDiShiTianModel
