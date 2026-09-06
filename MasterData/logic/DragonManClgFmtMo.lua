-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/model/DragonManClgFmtMo.lua

module("logic.extensions.dragonmanclg.model.DragonManClgFmtMo", package.seeall)

local DragonManClgFmtMo = class("DragonManClgFmtMo", BaseCustomFmtMo)

function DragonManClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = DragonManClgConfig.instance:getStageCfgById(self.activityId, self.stageId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = DragonManClgConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = DragonManClgConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.validatorDescStr = self.stageCfg.fmtAddTips

	self:tryInitPetList()

	self._supportPetMoList = self._supportPetMoList or {}

	local supportPetPlanId = self.stageCfg.supportPlanId
	local removePetIdList = {}

	if self._lastSupportPetPlanId ~= supportPetPlanId then
		if not self._supportPetMoList[self._lastSupportPetPlanId] then
			for _, petMo in pairs(self._supportPetMoList[self._lastSupportPetPlanId]) do
				table.insert(removePetIdList, petMo:getPetId())
			end

			local moList = self._supportPetMoList[supportPetPlanId]

			if not moList then
				local helpCfgs = DragonManClgConfig.instance:getSupportPetCfgs(supportPetPlanId) or {}

				moList = {}

				for _, helpData in pairs(helpCfgs) do
					local fmo = self:_getFightPowerPetMo()

					fmo:fromChallengeCreepCo(helpData)

					local petMo = fmo:toBaseBagPetMo()

					petMo.isSupportedPet = true

					table.insert(moList, petMo)
				end

				self._supportPetMoList[supportPetPlanId] = moList
			end

			for _, petMo in ipairs(moList) do
				self:addPetToList(self:_changePetMo(petMo))
			end

			self:tryRemovePetByIds(removePetIdList)

			self._lastSupportPetPlanId = supportPetPlanId
		end
	end
end

function DragonManClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DragonManClgController.instance:startChallenge(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DragonManClgFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DragonManClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DragonManClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DragonManClgFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function DragonManClgFmtMo:getExtendViewName()
	return ViewName.DragonManClgFmtExView
end

function DragonManClgFmtMo:onFmoSetDown()
	GlobalDispatcher:dispatch(GlobalNotify.PM_DragonManClgFmtChangeRes)
end

return DragonManClgFmtMo
