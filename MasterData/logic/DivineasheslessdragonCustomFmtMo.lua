-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/model/DivineasheslessdragonCustomFmtMo.lua

module("logic.extensions.divineasheslessdragon.model.DivineasheslessdragonCustomFmtMo", package.seeall)

local DivineasheslessdragonCustomFmtMo = class("DivineasheslessdragonCustomFmtMo", ICustomFmtMo)

function DivineasheslessdragonCustomFmtMo:initParams(activityId, cfgStage)
	self._activityId = activityId
	self._cfgStage = cfgStage
	self._creepsCfgs = DivineasheslessdragonConfig.instance:getCreepsCfgs(cfgStage.creepsMasterId)
	self._masterCfg = DivineasheslessdragonConfig.instance:getMasterCfg(cfgStage.creepsMasterId)

	self:clearAllPetList()
end

function DivineasheslessdragonCustomFmtMo:updateData()
	self.topTitleStr = self._cfgStage.name
	self.ruleDescStr = self._cfgStage.winRule1
	self.isShowBtnFormation = true

	self:setFormCondition(self._masterCfg.formCondition)
end

function DivineasheslessdragonCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurFormation():createFormPb()

		DivineasheslessdragonController.instance:sendPM_DivineAsheslessDragonChallengeReq(self._activityId, self._cfgStage.stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineasheslessdragonCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivineasheslessdragonCustomFmtMo:initPetList()
	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function DivineasheslessdragonCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineasheslessdragonCustomFmtMo:getFmtInfoConfig()
	return self._masterCfg
end

return DivineasheslessdragonCustomFmtMo
