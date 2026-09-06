-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/model/PsychicedTowerFmtMo.lua

module("logic.extensions.psychicedtower.model.PsychicedTowerFmtMo", package.seeall)

local PsychicedTowerFmtMo = class("PsychicedTowerFmtMo", ICustomFmtMo)

function PsychicedTowerFmtMo:initParams(activityId, towerId, stageId)
	self.activityId = activityId
	self.towerId = towerId
	self.stageId = stageId
	self._stageCfg = PsychicedTowerConfig.instance:getStageCfg(self.activityId, self.towerId, self.stageId)
	self._cfgEnemy = PsychicedTowerConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = PsychicedTowerConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
	self._mustAssistPetMap = {}
	self._addtionAssistPetMap = {}

	local towerCfg = PsychicedTowerConfig.instance:getTowerCfg(activityId, towerId)

	for i, v in ipairs(towerCfg.supportPetIds) do
		self._addtionAssistPetMap[v] = v
	end

	local passStageId = PsychicedTowerModel.instance:getPassStage(self.activityId, self.towerId)

	for i = 1, passStageId do
		local stageCfg = PsychicedTowerConfig.instance:getStageCfg(self.activityId, self.towerId, i)

		if checknumber(stageCfg.openSupportPetId) > 0 then
			self._addtionAssistPetMap[stageCfg.openSupportPetId] = stageCfg.openSupportPetId
		end
	end
end

function PsychicedTowerFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()

	self.formationMo.fixPetIds = self._mustAssistPetMap
	self.isShowOneKey = false

	local posId = 1

	for i, v in pairs(self._mustAssistPetMap) do
		self:getCurFormation():SetPosition(posId, v)

		posId = posId + 1
	end
end

function PsychicedTowerFmtMo:initFightHandler()
	local function handler()
		if PsychicedTowerConfig.instance:getTowerCfg(self.activityId, 2) then
			UIJumper.instance:pushOneStack(ViewName.PsychicedTowerMainView, true, self.activityId)
		end

		UIJumper.instance:pushOneStack(ViewName.PsychicedTowerLevelView, true, self.activityId, self.towerId)

		local simpleForm = self:getCurSimpleForm()

		PsychicedTowerController.instance:sendPM_PsychicedTowerChallengeReq(self.activityId, self.towerId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function PsychicedTowerFmtMo:initPetList()
	self:clearAllPetList()

	for petId, v in pairs(self._mustAssistPetMap) do
		local cfg = PsychicedTowerConfig.instance:getSupportPetCfg(petId)
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(cfg)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end

	for petId, v in pairs(self._addtionAssistPetMap) do
		local cfg = PsychicedTowerConfig.instance:getSupportPetCfg(petId)
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(cfg)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function PsychicedTowerFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function PsychicedTowerFmtMo:_changePetMo(petMo)
	return petMo
end

function PsychicedTowerFmtMo:getMonsterConfigList()
	return self._masterList
end

function PsychicedTowerFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function PsychicedTowerFmtMo:getExtendViewName()
	return ViewName.PsychicedTowerFmtView
end

function PsychicedTowerFmtMo:clearCellTop(cell)
	MaterialMgr.resetAll(cell)
end

function PsychicedTowerFmtMo:initFormationMo()
	self.formationMo = PsychicedTowerFormationMo.New(GameUtil.handler(self.getPetMoById, self))
end

function PsychicedTowerFmtMo:isPetUnableToLeve(oldPetId, newPetId)
	if self._mustAssistPetMap[oldPetId] then
		return true
	end

	return false
end

return PsychicedTowerFmtMo
