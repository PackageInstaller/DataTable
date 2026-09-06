-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/model/WaterTianYanBuildCustomFmtMo.lua

module("logic.extensions.watertianyan.model.WaterTianYanBuildCustomFmtMo", package.seeall)

local WaterTianYanBuildCustomFmtMo = class("WaterTianYanBuildCustomFmtMo", ICustomFmtMo)

function WaterTianYanBuildCustomFmtMo:initParams(activityId, stageId, index)
	self._activityId = activityId
	self._stageId = stageId
	self._index = index

	local cfgStage = WaterTianYanConfig.instance:getBuildingStageCfg(activityId, stageId)

	self._cfgType = WaterTianYanConfig.instance:getBuildingTypeCfg(activityId, cfgStage.typeId)
	self._monsterCfg = WaterTianYanConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = WaterTianYanConfig.instance:getCreepsCfgs(cfgStage.creepsMasterId)
end

function WaterTianYanBuildCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._cfgType.formConditionId)
end

function WaterTianYanBuildCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function WaterTianYanBuildCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		local mo = FightingPowerPetMo.getMaxPetMoByData(petMo)

		self:updatePetMo(mo)
	end
end

function WaterTianYanBuildCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		WaterTianYanAgent.instance:sendPM_WaterTianYanBuildingStageChallengeReq(self._activityId, self._index - 1, form)
	end

	self:setFightHandler(handler, nil)
end

function WaterTianYanBuildCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function WaterTianYanBuildCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function WaterTianYanBuildCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		local mo = FightingPowerPetMo.getMaxPetMoByData(petMo)

		self:addPetToList(mo)
	end
end

return WaterTianYanBuildCustomFmtMo
