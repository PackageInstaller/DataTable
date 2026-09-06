-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/model/DivineteshamuclgFmtMo.lua

module("logic.extensions.divineteshamuclg.model.DivineteshamuclgFmtMo", package.seeall)

local DivineteshamuclgFmtMo = class("DivineteshamuclgFmtMo", BaseCustomFmtMo)

function DivineteshamuclgFmtMo:initParams(activityId, floorId, stageId)
	self._activityId = activityId
	self._floorId = floorId
	self._stageId = stageId
	self._stageCfg = DivineteshamuclgConfig.instance:getStageCfg(activityId, floorId, stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = DivineteshamuclgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineteshamuclgConfig.instance:getCreepsCfgs(self._creepsMasterId)
end

function DivineteshamuclgFmtMo:updateData()
	self.topTitleStr = self._masterData.name

	local count = DivineteshamuclgModel.instance:getSoldierCount(self._activityId, self._floorId)
	local value = count - self._stageCfg.soldierCount
	local buffCfg = DivineteshamuclgConfig.instance:getBuffCfgByValue(self._activityId, math.abs(value))

	self.validatorDescStr = buffCfg and string.format("%s激活压制效果，%s", (value > 0 or nil) and "己阵", buffCfg.buffDesc) or "无激活压制效果"
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)

	local supportCfg = DivineteshamuclgConfig.instance:getSupportPetCfg(self._activityId, self._stageCfg.supportPetCreepsId)
	local positions = self:getCurFormation():GetPositions()

	for i, oldPetId in ipairs(positions) do
		if oldPetId ~= 0 and oldPetId ~= self._stageCfg.supportPetCreepsId then
			local sCfg = DivineteshamuclgConfig.instance:getSupportPetCfg(self._activityId, oldPetId)

			if sCfg then
				if sCfg.raceId == supportCfg.raceId then
					self:getCurFormation():SetPosition(i, 0)
				end
			else
				local petMo = BagPetsController.instance:getPet(oldPetId)

				if petMo and petMo.raceId == supportCfg.raceId then
					self:getCurFormation():SetPosition(i, 0)
				end
			end
		end
	end

	self:getCurFormation():SetPosition(self._stageCfg.supportPetPosition, self._stageCfg.supportPetCreepsId)
end

function DivineteshamuclgFmtMo:initPetList()
	self:clearAllPetList()

	local pets = self:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	local cfgs = DivineteshamuclgConfig.instance:getSupportPetCfgs(self._activityId)

	for k, petCo in pairs(cfgs) do
		local fPowerPet = FightingPowerPetMo.New()

		fPowerPet:fromChallengeCreepCo(petCo)

		petMo = fPowerPet:toBaseBagPetMo()
		petMo.isSupportedPet = true

		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineteshamuclgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineTeshamuAgent.instance:sendPM_DivineTeshamuChallengeReq(self._activityId, simpleForm, self._floorId, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

function DivineteshamuclgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineteshamuclgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineteshamuclgFmtMo:getFixedPosList()
	return {
		self._stageCfg.supportPetPosition
	}
end

return DivineteshamuclgFmtMo
