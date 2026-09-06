-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/model/DualTrialFmtMo.lua

module("logic.extensions.dualtrial.model.DualTrialFmtMo", package.seeall)

local DualTrialFmtMo = class("DualTrialFmtMo", BaseCustomFmtMo)

function DualTrialFmtMo:initParams(activityId, creepsMasterId)
	self.activityId = activityId
	self.creepId = creepsMasterId
	self.creeps = DualTrialConfig.instance:getTeamCfg(self.creepId)
	self.masterCfg = DualTrialConfig.instance:getCreepCfgs(self.creepId)
	self.isHideFmtZdl = true

	self:setFormCondition(self.creeps.formCondition)
end

function DualTrialFmtMo:getMonsterConfigList()
	return self.masterCfg
end

function DualTrialFmtMo:getFmtInfoConfig()
	return self.creeps
end

function DualTrialFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DualTrialController.instance:fight(self.activityId, self:getCurSimpleForm())
	end, nil)
end

function DualTrialFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function DualTrialFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return DualTrialFmtMo
