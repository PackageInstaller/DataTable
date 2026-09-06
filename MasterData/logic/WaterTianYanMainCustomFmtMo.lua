-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/model/WaterTianYanMainCustomFmtMo.lua

module("logic.extensions.watertianyan.model.WaterTianYanMainCustomFmtMo", package.seeall)

local WaterTianYanMainCustomFmtMo = class("WaterTianYanMainCustomFmtMo", ICustomFmtMo)

function WaterTianYanMainCustomFmtMo:initParams(activityId, stageId, buffItemIds)
	self._activityId = activityId
	self._stageId = stageId
	self._buffItemIds = buffItemIds

	local cfgStage = WaterTianYanConfig.instance:getMainStageCfg(activityId, stageId)

	self._monsterCfg = WaterTianYanConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = WaterTianYanConfig.instance:getCreepsCfgs(cfgStage.creepsMasterId)
end

function WaterTianYanMainCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function WaterTianYanMainCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function WaterTianYanMainCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function WaterTianYanMainCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		WaterTianYanAgent.instance:sendPM_WaterTianYanMainStageChallengeReq(self._activityId, self._stageId, self._buffItemIds, form)
	end

	self:setFightHandler(handler, nil)
end

function WaterTianYanMainCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function WaterTianYanMainCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function WaterTianYanMainCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

return WaterTianYanMainCustomFmtMo
