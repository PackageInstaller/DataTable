-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/model/IslandStationFmtMo.lua

module("logic.extensions.islandstation.model.IslandStationFmtMo", package.seeall)

local IslandStationFmtMo = class("IslandStationFmtMo", BaseCustomFmtMo)

function IslandStationFmtMo:onReset()
	IslandStationFmtMo.super.onReset(self)
end

function IslandStationFmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._creepsMasterId = IslandStationConfig.instance:getBossId(activityId)
	self._masterData = IslandStationConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = IslandStationConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._supportCfg = IslandStationConfig.instance:getSupportPetCfg(activityId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function IslandStationFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		UIJumper.instance:pushOneStack(ViewName.IslandStationGetMaterialView, false, self._activityId, true)

		local simpleForm = self:getCurSimpleForm()

		IslandStationController.instance:sendPM_IslandStationChallengeBossReq(self._activityId, simpleForm)
	end, nil)
end

function IslandStationFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function IslandStationFmtMo:getFmtInfoConfig()
	return self._masterData
end

function IslandStationFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(bagPetMoList) do
		self:addPetToList(petMo)
	end

	if self._supportCfg then
		for i, supportCfg in pairs(self._supportCfg) do
			local fmo = self:_getFightPowerPetMo()

			fmo:fromChallengeCreepCo(supportCfg)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function IslandStationFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

IslandStationFmtMo.instance = IslandStationFmtMo.New()

return IslandStationFmtMo
