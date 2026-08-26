-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaEquipMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaEquipMO", package.seeall)

local AiZiLaEquipMO = pureTable("AiZiLaEquipMO")

function AiZiLaEquipMO:init(id, equipId, actId)
	self.id = id
	self.typeId = id
	self._equipId = equipId or 0
	self.activityId = actId or VersionActivity1_5Enum.ActivityId.AiZiLa
	self._needUpdateConfig = true
end

function AiZiLaEquipMO:getConfig()
	if self._needUpdateConfig then
		self._needUpdateConfig = false
		self._config = AiZiLaConfig.instance:getEquipCo(self.activityId, self._equipId)
		self._nexConfig = AiZiLaConfig.instance:getEquipCoByPreId(self.activityId, self._equipId, self.typeId)
		self._costParams = AiZiLaHelper.getCostParams(self._nexConfig)
	end

	return self._config
end

function AiZiLaEquipMO:getNextConfig()
	self:getConfig()

	return self._nexConfig
end

function AiZiLaEquipMO:isMaxLevel()
	return self:getNextConfig() == nil
end

function AiZiLaEquipMO:isCanUpLevel()
	self:getConfig()

	if self:isMaxLevel() or self._costParams == nil then
		return false
	end

	return AiZiLaHelper.checkCostParams(self._costParams)
end

function AiZiLaEquipMO:getCostParams()
	self:getConfig()

	return self._costParams
end

function AiZiLaEquipMO:updateInfo(equipId)
	if self._equipId ~= equipId then
		self._equipId = equipId
		self._needUpdateConfig = true
	end
end

return AiZiLaEquipMO
