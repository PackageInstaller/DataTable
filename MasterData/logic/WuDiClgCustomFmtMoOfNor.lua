-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/model/WuDiClgCustomFmtMoOfNor.lua

module("logic.extensions.wudiclg.model.WuDiClgCustomFmtMoOfNor", package.seeall)

local WuDiClgCustomFmtMoOfNor = class("WuDiClgCustomFmtMoOfNor", ICustomFmtMo)

function WuDiClgCustomFmtMoOfNor:onReset()
	WuDiClgCustomFmtMoOfNor.super.onReset(self)
end

function WuDiClgCustomFmtMoOfNor:updateCfg(activityId, groupId, dataBitId)
	self._activityId = activityId
	self._groupId = groupId
	self._dataBitId = dataBitId
	self._groupData = WuDiClgConfig.instance:getWdcNorStageGroupData(self._activityId, self._groupId, self._dataBitId)
	self._creepsMasterId = self._groupData.creepsMasterId
	self._masterData = WuDiClgConfig.instance:getWdcCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = WuDiClgConfig.instance:getWdcCreepsCfg(self._creepsMasterId)
	self._supportCfg = WuDiClgConfig.instance:getWdcSupportCfg(self._activityId)
end

function WuDiClgCustomFmtMoOfNor:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function WuDiClgCustomFmtMoOfNor:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		WuDiClgController.instance:sendPM_WuDiClgNormalFightReq(self._activityId, self._dataBitId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function WuDiClgCustomFmtMoOfNor:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end

	if self._supportCfg then
		local fmo = FightingPowerPetMo.New()

		for _, data in pairs(self._supportCfg) do
			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function WuDiClgCustomFmtMoOfNor:getMonsterConfigList()
	return self._creepsCfg
end

function WuDiClgCustomFmtMoOfNor:getFmtInfoConfig()
	return self._masterData
end

function WuDiClgCustomFmtMoOfNor:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end
end

return WuDiClgCustomFmtMoOfNor
