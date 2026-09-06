-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/model/ShenJiSelectCustomFmtMo.lua

module("logic.extensions.shenjichallenge.model.ShenJiSelectCustomFmtMo", package.seeall)

local ShenJiSelectCustomFmtMo = class("ShenJiSelectCustomFmtMo", ICustomFmtMo)

function ShenJiSelectCustomFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local cfgStage = ShenJiChallengeConfig.instance:getSelectStage(activityId, stageId)

	self._monsterCfg = ShenJiChallengeConfig.instance:getMaster(cfgStage.creepsMasterId)
	self._creepsCfgs = ShenJiChallengeConfig.instance:getCreeps(cfgStage.creepsMasterId)
end

function ShenJiSelectCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function ShenJiSelectCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function ShenJiSelectCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function ShenJiSelectCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		ShenJiChallengeAgent.instance:sendPM_ShenJiChallengeSelectClgReq(self._activityId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function ShenJiSelectCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function ShenJiSelectCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function ShenJiSelectCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

return ShenJiSelectCustomFmtMo
