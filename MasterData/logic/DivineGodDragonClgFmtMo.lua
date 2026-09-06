-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/model/DivineGodDragonClgFmtMo.lua

module("logic.extensions.divinegoddragonclg.model.DivineGodDragonClgFmtMo", package.seeall)

local DivineGodDragonClgFmtMo = class("DivineGodDragonClgFmtMo", ICustomFmtMo)

function DivineGodDragonClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = DivineGodDragonClgConfig.instance:getStageCfg(self.activityId, self.stageId)
	self._cfgEnemy = DivineGodDragonClgConfig.instance:getTeamCfg(self.stageCfg.creepsMasterId)
	self._masterList = DivineGodDragonClgConfig.instance:getCreepsCfg(self.stageCfg.creepsMasterId)
	self._supportPetCfg = DivineGodDragonClgConfig.instance:getSupportCfg(self.stageCfg.supportCreepsId)
end

function DivineGodDragonClgFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DivineGodDragonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.DivineGodDragonClgMainView, true, self.activityId)

		local simpleForm = self:getCurSimpleForm()

		DivineGodDragonClgAgent.instance:sendPM_DivineGodDragonChallengeReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineGodDragonClgFmtMo:initPetList()
	self:clearAllPetList()

	local supportCfgs = {}
	local cfgMaster = self._supportPetCfg

	table.insert(supportCfgs, cfgMaster)

	for i, v in ipairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(self:_changePetMo(petMo))
	end

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineGodDragonClgFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function DivineGodDragonClgFmtMo:_changePetMo(petMo)
	return petMo
end

function DivineGodDragonClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineGodDragonClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineGodDragonClgFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

return DivineGodDragonClgFmtMo
