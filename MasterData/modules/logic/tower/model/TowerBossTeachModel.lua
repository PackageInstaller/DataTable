-- chunkname: @modules/logic/tower/model/TowerBossTeachModel.lua

module("modules.logic.tower.model.TowerBossTeachModel", package.seeall)

local TowerBossTeachModel = class("TowerBossTeachModel", BaseModel)

function TowerBossTeachModel:onInit()
	self.lastFightTeachId = 0
end

function TowerBossTeachModel:reInit()
	self.lastFightTeachId = 0
end

function TowerBossTeachModel:isAllEpisodeFinish(bossId)
	local bossConfig = TowerConfig.instance:getAssistBossConfig(bossId)
	local allTeachConfig = TowerConfig.instance:getAllBossTeachConfigList(bossConfig.towerId)
	local towerInfoMO = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Boss, bossConfig.towerId)

	for _, config in ipairs(allTeachConfig) do
		if towerInfoMO and not towerInfoMO:isPassBossTeach(config.teachId) then
			return false
		end
	end

	return true
end

function TowerBossTeachModel:getTeachFinishEffectSaveKey(bossId)
	return string.format("%s_%s", TowerEnum.LocalPrefsKey.TowerBossTeachFinishEffect, bossId)
end

function TowerBossTeachModel:setLastFightTeachId(teachId)
	self.lastFightTeachId = teachId
end

function TowerBossTeachModel:getLastFightTeachId()
	return self.lastFightTeachId
end

function TowerBossTeachModel:getFirstUnFinishTeachId(bossId)
	local bossConfig = TowerConfig.instance:getAssistBossConfig(bossId)
	local allTeachConfig = TowerConfig.instance:getAllBossTeachConfigList(bossConfig.towerId)
	local towerInfoMO = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Boss, bossConfig.towerId)

	for _, config in ipairs(allTeachConfig) do
		if towerInfoMO and not towerInfoMO:isPassBossTeach(config.teachId) then
			return config.teachId
		end
	end

	return allTeachConfig[1].teachId
end

TowerBossTeachModel.instance = TowerBossTeachModel.New()

return TowerBossTeachModel
