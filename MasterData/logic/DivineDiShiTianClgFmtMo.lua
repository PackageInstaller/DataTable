-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/model/DivineDiShiTianClgFmtMo.lua

module("logic.extensions.divinedishitianclg.model.DivineDiShiTianClgFmtMo", package.seeall)

local DivineDiShiTianClgFmtMo = class("DivineDiShiTianClgFmtMo", BaseCustomFmtMo)

function DivineDiShiTianClgFmtMo:initParams(activityId, index, creepsMasterId)
	self._activityId = activityId
	self._index = index
	self._creepsMasterId = creepsMasterId
	self._monsterCfg = DivineDiShiTianClgConfig.instance:getMonsterCfg(creepsMasterId)
	self._creepsCfgs = DivineDiShiTianClgConfig.instance:getCreeps(creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.description

	self:setFormCondition(self._monsterCfg.formCondition)

	self.isShowOneKey = false
	self.isShowBtnBuffForm = false
	self.isShowBtnFormationEdit = false
	self.isShowBtnFormationUse = false
end

function DivineDiShiTianClgFmtMo:updateData()
	if self._index ~= self._oldIndex then
		self:getCurFormation():ResetPosition(true)
	end

	self._oldIndex = self._index
end

function DivineDiShiTianClgFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianChallengeNormalReq(self._activityId, self._index, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineDiShiTianClgFmtMo:initPetList()
	self:clearAllPetList()

	local cfgs = DivineDiShiTianClgConfig.instance:getNormalSupportCreepsList()

	for i, cfg in pairs(cfgs) do
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(cfg)

		local petMo = FightingPowerPetMo.getMaxPetMoByData(fmo:toBaseBagPetMo())

		petMo:setSupportedPet(true)
		self:addPetToList(petMo)
	end
end

function DivineDiShiTianClgFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo, true)
	end
end

function DivineDiShiTianClgFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineDiShiTianClgFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function DivineDiShiTianClgFmtMo:getExtendViewName()
	return ViewName.DivineDiShiTianNormalFmtView
end

function DivineDiShiTianClgFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if self._formCondition then
		local isMatch = FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:getCurFormation(), isShowTip)

		if not isMatch then
			return false
		end
	end

	local poslimitInfo = DivineDiShiTianClgModel.instance:getPosLimitInfo(self._activityId, self._index, pos)

	if poslimitInfo then
		local petMo = self:getPetMoById(petId)

		if petMo then
			local isMatchJob = false
			local jobKeyList = PetSkinConfig.instance:getJobKeyList(petMo.curFaceId)

			for i, josStr in ipairs(jobKeyList) do
				if poslimitInfo.jobId == GameEnum.JobZh[josStr] then
					isMatchJob = true

					break
				end
			end

			local isMatchAttr = false
			local raceTypeId = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

			isMatchAttr = poslimitInfo.raceTypeId == raceTypeId

			if not isMatchJob or not isMatchAttr then
				local cfgSkin = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

				FloatWordMgr.instance:show(string.format("请选择符合条件的精灵 [职业：%s], [属性：%s]", ConstString.JobIdxToStr[poslimitInfo.jobId], ConstString.RaceIdToTxt[poslimitInfo.raceTypeId]))
			end

			return isMatchJob and isMatchAttr
		else
			return false
		end
	else
		return true
	end
end

function DivineDiShiTianClgFmtMo:onFormationChangeFinish()
	local formationMO = self:getCurFormation()
	local eleMap = formationMO:getCurElementRelationMap()

	if eleMap then
		local positions = formationMO:GetPositions()

		for pos, petId in ipairs(positions) do
			if petId > 0 then
				local petMo = self:getPetMoById(petId)

				if petMo and eleMap[petMo.petId] ~= nil then
					local race = eleMap[petMo.petId]

					race = race % 10

					local poslimitInfo = DivineDiShiTianClgModel.instance:getPosLimitInfo(self._activityId, self._index, pos)
					local isMatchAttr = poslimitInfo.raceTypeId == race

					if not isMatchAttr then
						formationMO:SetPosition(pos, 0)
					end

					break
				end
			end
		end
	end
end

function DivineDiShiTianClgFmtMo:getActivityId()
	return self._activityId
end

function DivineDiShiTianClgFmtMo:getIndexId()
	return self._index
end

return DivineDiShiTianClgFmtMo
