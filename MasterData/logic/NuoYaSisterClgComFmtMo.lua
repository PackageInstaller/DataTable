-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/model/NuoYaSisterClgComFmtMo.lua

module("logic.extensions.wuwenchallenge.model.NuoYaSisterClgComFmtMo", package.seeall)

local NuoYaSisterClgComFmtMo = class("NuoYaSisterClgComFmtMo", ICustomFmtMo)

function NuoYaSisterClgComFmtMo:initParams(activityId, day, bossType)
	self.activityId = activityId
	self.stageCfg = NuoYaSisterClgConfig.instance:getCommonBossCfg(self.activityId, day)

	local creepsMasterId

	self.bossId = bossType
	creepsMasterId = self.bossId == NuoYaSisterClgModel.BOSSA_ID and self.stageCfg.bossA or self.stageCfg.bossB
	self._cfgEnemy = NuoYaSisterClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = NuoYaSisterClgConfig.instance:getCreepsCfg(creepsMasterId)
end

function NuoYaSisterClgComFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function NuoYaSisterClgComFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.NuoYaSisterClgMainView, true, self.activityId)
		UIJumper.instance:pushOneStack(ViewName.NuoYaSisterClgCommonView, true, self.activityId)

		local simpleForm = self:getCurSimpleForm()

		NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterCommonClgReq(self.activityId, self.bossId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function NuoYaSisterClgComFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function NuoYaSisterClgComFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function NuoYaSisterClgComFmtMo:_changePetMo(petMo)
	return FightingPowerPetMo.getMaxPetMoByData(petMo)
end

function NuoYaSisterClgComFmtMo:getMonsterConfigList()
	return self._masterList
end

function NuoYaSisterClgComFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return NuoYaSisterClgComFmtMo
