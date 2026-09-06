-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/model/SummonMasterHopeClgCustomFmtMo.lua

module("logic.extensions.summonmasterhopeclg.model.SummonMasterHopeClgCustomFmtMo", package.seeall)

local SummonMasterHopeClgCustomFmtMo = class("SummonMasterHopeClgCustomFmtMo", ICustomFmtMo)

function SummonMasterHopeClgCustomFmtMo:onReset()
	SummonMasterHopeClgCustomFmtMo.super.onReset(self)
end

function SummonMasterHopeClgCustomFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = SummonMasterHopeClgConfig.instance:getCreepsMasterId(activityId, stageId)
	self._masterData = SummonMasterHopeClgConfig.instance:getSMHClgCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = SummonMasterHopeClgConfig.instance:getSMHClgCreepsData(self._creepsMasterId)
end

function SummonMasterHopeClgCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function SummonMasterHopeClgCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		SummonMasterHopeClgController.instance:sendPM_SummonMasterHopeClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function SummonMasterHopeClgCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function SummonMasterHopeClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function SummonMasterHopeClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function SummonMasterHopeClgCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return SummonMasterHopeClgCustomFmtMo
