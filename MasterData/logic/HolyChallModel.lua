-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/model/HolyChallModel.lua

module("logic.extensions.kingway.model.HolyChallModel", package.seeall)

local HolyChallModel = class("HolyChallModel", BaseListModel)

function HolyChallModel:ctor()
	HolyChallModel.super.ctor(self)

	self.flBaseInfo = nil
	self.challPopupInfo = nil
end

function HolyChallModel:onInit()
	HolyChallModel.super.onInit(self)
	self:onReset()
end

function HolyChallModel:onReset()
	self.flBaseInfo = nil
	self.challPopupInfo = nil
	self._supportPet = {}
	self._formation = {}
	self._svrFormation = {}
	self._challengeId = nil
	self._teamId = 1
end

function HolyChallModel:GetFeilongData()
	if self.flBaseInfo == nil then
		local commCfgs = HolyChallConfig.instance:GetCommonCfgs()

		self.flBaseInfo = {
			isOpenFunc = false,
			accDamage = 0,
			isOpenTrial = false,
			totalEnergy = 0,
			isInit = false,
			isDailyEnergy = false,
			challList = {},
			allEnergy = commCfgs.totalEnergy
		}
	end

	return self.flBaseInfo
end

function HolyChallModel:SetFeilongData(msg)
	if self.flBaseInfo == nil then
		self:GetFeilongData()
	end

	if msg == nil then
		return
	end

	self.flBaseInfo.isInit = true
	self.flBaseInfo.totalEnergy = msg.totalEnergy
	self.flBaseInfo.isDailyEnergy = msg.hasGainDailyEnergy
	self.flBaseInfo.isOpenFunc = msg.everOpenFunc
	self.flBaseInfo.isOpenTrial = msg.isOpenTrial
	self.flBaseInfo.accDamage = 0
	self.flBaseInfo.trialBits = nil
	self.flBaseInfo.challList = nil

	if msg.isOpenTrial then
		self.flBaseInfo.trialBits = msg.trialBits
		self.flBaseInfo.accDamage = msg.accDamage
	else
		for _, info in pairs((not msg.challengeInfos or nil) and {}) do
			if info and checknumber(info.challengeId) > 0 then
				self.flBaseInfo.challList = self.flBaseInfo.challList or {}
				self.flBaseInfo.challList[info.challengeId] = info

				self:setFormation(info.challengeId, info)
			end
		end
	end

	if self.flBaseInfo.totalEnergy >= self.flBaseInfo.allEnergy then
		self.flBaseInfo.isOpenTrial = true
	end

	GlobalDispatcher:dispatch("UpdataFeilongInfo")
end

function HolyChallModel:SetReceiveTodayEnergy(all)
	self.flBaseInfo = self.flBaseInfo or {}
	self.flBaseInfo.isDailyEnergy = true
	self.flBaseInfo.isPlayThree = false

	if self.flBaseInfo.totalEnergy < self.flBaseInfo.allEnergy and all >= self.flBaseInfo.allEnergy then
		self.flBaseInfo.isPlayThree = true
	end

	self.flBaseInfo.totalEnergy = all

	if self.flBaseInfo.totalEnergy >= self.flBaseInfo.allEnergy then
		self.flBaseInfo.isOpenTrial = true
	end

	GlobalDispatcher:dispatch("UpdataFeilongInfo")
end

function HolyChallModel:SetSaveGuardForm(msg)
	return
end

function HolyChallModel:UpdataPlayOpenFunc(num)
	if self.flBaseInfo == nil then
		return
	end

	if num == 1 then
		self.flBaseInfo.isOpenFunc = true
	elseif num == 2 then
		self.flBaseInfo.isPlayTwo = false
	elseif num == 3 then
		self.flBaseInfo.isPlayThree = false
	end
end

function HolyChallModel:UpdataFirstOpenGuard(challId)
	if self.flBaseInfo == nil or self.flBaseInfo.challList == nil then
		return
	end

	if self.flBaseInfo.challList[challId] then
		self.flBaseInfo.challList[challId].everOpen = true
	end
end

function HolyChallModel:UpdataChallengeData(msg)
	self.flBaseInfo = self.flBaseInfo or {}
	self.flBaseInfo.isOpenTrial = true
	self.flBaseInfo.isPlayThree = false

	if msg.isWin then
		if self.flBaseInfo.totalEnergy < self.flBaseInfo.allEnergy and msg.newTotalEnergy >= self.flBaseInfo.allEnergy then
			self.flBaseInfo.isPlayThree = true
		end

		self.flBaseInfo.totalEnergy = msg.newTotalEnergy
	end

	if msg:HasField("newAccDamage") and msg.newTrialBits then
		self.flBaseInfo.isPlayTwo = false
		self.flBaseInfo.accDamage = msg.newAccDamage
		self.flBaseInfo.trialBits = msg.newTrialBits
		self.flBaseInfo.challList = nil
	else
		self.flBaseInfo.challList = self.flBaseInfo.challList or {}
		self.flBaseInfo.isPlayTwo = true
		self.flBaseInfo.trialBits = nil
		self.flBaseInfo.accDamage = 0

		if self.flBaseInfo.challList[msg.challengeId] then
			self.flBaseInfo.challList[msg.challengeId].passedStageId = msg.isWin and 1 or 0
			self.flBaseInfo.challList[msg.challengeId].everOpen = true
		end

		for _, info in pairs(self.flBaseInfo.challList or {}) do
			if info and checknumber(info.challengeId) > 0 and checknumber(info.passedStageId) < 1 then
				self.flBaseInfo.isOpenTrial = false
				self.flBaseInfo.isPlayTwo = false

				break
			end
		end

		if self.flBaseInfo.totalEnergy >= self.flBaseInfo.allEnergy then
			self.flBaseInfo.isOpenTrial = true
		end

		if self.flBaseInfo.isOpenTrial then
			self.flBaseInfo.challList = nil
		end
	end

	GlobalDispatcher:dispatch("UpdataFeilongInfo")
end

function HolyChallModel:GetCurrentFunctionStage()
	if self.flBaseInfo == nil or checknumber(self.flBaseInfo.totalEnergy) <= 0 then
		return 1
	end

	if self.flBaseInfo.totalEnergy >= self.flBaseInfo.allEnergy then
		return 3
	end

	if not self.flBaseInfo.isOpenTrial then
		return 1
	else
		return 2
	end
end

function HolyChallModel:GetTrialIntervalEnergy(now, new)
	if new <= now then
		return 0
	end

	local list = HolyChallConfig.instance:GetChallDamageCfgs()

	if list == nil or #list == 0 then
		return 0
	end

	local energy = 0

	for i = 1, #list do
		if list[i] and now < list[i].accDamage and new >= list[i].accDamage then
			energy = energy + list[i].prize
		end
	end

	return energy
end

function HolyChallModel:GetChallengeAllDamage()
	local list = HolyChallConfig.instance:GetChallDamageCfgs()
	local allCount = 0

	if list and #list > 0 then
		for i = 1, #list do
			if list[i] and allCount < list[i].accDamage then
				allCount = list[i].accDamage
			end
		end
	end

	local allStr = tostring(allCount)

	return (allCount >= 1000 or nil) and string.format("%.1f", allCount / 10000) .. "万"
end

function HolyChallModel:GetChallengePopupData()
	return self.challPopupInfo
end

function HolyChallModel:SetChallengePopupData(data)
	self.challPopupInfo = data
end

function HolyChallModel:getCreepsId()
	return self._creepsIds
end

function HolyChallModel:setCreepsId(CreepsIds)
	self._creepsIds = CreepsIds
end

function HolyChallModel:setCurChallengeId(challengeId)
	self._challengeId = challengeId
end

function HolyChallModel:getCurChallengeId()
	return self._challengeId
end

function HolyChallModel:getSupportPet(creepsId)
	if self._supportPet[creepsId] == nil then
		self._supportPet[creepsId] = self:createPet(creepsId)
	end

	return self._supportPet[creepsId]
end

function HolyChallModel:createPet(creepsId)
	local creepCfg = HolyChallConfig.instance:getSupportCreep(creepsId)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepCfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	petMo.creepsId = creepsId
	petMo.isSupportedPet = true

	return petMo
end

function HolyChallModel:setFormation(challengeId, msg)
	local form = {
		formId = 10,
		pos = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		extParams = {
			heroSkillId = 0
		}
	}

	if msg:HasField("form") then
		local creepId = HolyChallConfig.instance:GetChallGuardCfg(challengeId).supportPetId
		local supprotCfg = HolyChallConfig.instance:getSupportCreep(creepId)
		local targetPos = supprotCfg.posId

		form = msg.form

		for i = 1, 9 do
			if i == targetPos then
				form.pos[i] = creepId
			elseif form.pos[i] == creepId then
				form.pos[i] = 0
			end
		end
	end

	self._formation[challengeId] = HolyChallFormationMO.New()

	self._formation[challengeId]:SetData(form)
	self:_saveAsSvrFometion(form, challengeId)
end

function HolyChallModel:getCurFormationId()
	return self._formation[self._challengeId]:GetId()
end

function HolyChallModel:_saveAsSvrFometion(form, challengeId)
	self._svrFormation[challengeId] = {}
	self._svrFormation[challengeId].formId = form.formId
	self._svrFormation[challengeId].pos = {}

	for k, j in ipairs(form.pos) do
		self._svrFormation[challengeId].pos[k] = j
	end

	self._svrFormation[challengeId].extParams = {}
	self._svrFormation[challengeId].extParams.heroSkillId = form.extParams.heroSkillId
	self._svrFormation[challengeId].extParams.psychicSkillId = form.extParams.psychicSkillId
	self._svrFormation[challengeId].extParams.elementalMasterId = form.extParams.elementalMasterId
	self._svrFormation[challengeId].extParams.elementalTargetId = form.extParams.elementalTargetId
	self._svrFormation[challengeId].extParams.cutePetId = form.extParams.cutePetId
	self._svrFormation[challengeId].extParams.cutePetRaceId = form.extParams.cutePetRaceId
	self._svrFormation[challengeId].extParams.cutePetQuality = form.extParams.cutePetQuality
end

function HolyChallModel:refreshForm(form, challengeId)
	if self._formation[challengeId] then
		self._formation[challengeId]:SetData(form)
	end
end

function HolyChallModel:saveCurrFormation()
	local isDirty = self._svrFormation[self._challengeId].extParams.heroSkillId ~= self._formation[self._challengeId]:GetHeroSkillId()

	if not isDirty and self._svrFormation[self._challengeId].extParams.psychicSkillId ~= self._formation[self._challengeId]:GetPsychicedSkillId() then
		isDirty = true
	end

	if not isDirty and (self._svrFormation[self._challengeId].extParams.elementalMasterId ~= self._formation[self._challengeId]:GetElementalMasterId() or self._svrFormation[self._challengeId].extParams.elementalTargetId ~= self._formation[self._challengeId]:GetElementalTargetId()) then
		isDirty = true
	end

	if not isDirty then
		local poses = self._formation[self._challengeId]:GetPositions()
		local svrPoses = self._svrFormation[self._challengeId].pos

		for i = 1, #poses do
			if poses[i] ~= svrPoses[i] then
				isDirty = true

				break
			end
		end
	end

	local form = self._formation[self._challengeId]:createFormPb()

	form.extParams.heroSkillId = 410027

	HolyChallController.instance:CSRequestSaveFormReq(self._challengeId, form)

	return isDirty
end

function HolyChallModel:getFormation()
	return self._formation[self._challengeId]
end

function HolyChallModel:getFormPetsHeroSkills()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()
	local heroskills = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))
			local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(pet.curFaceId))

			if petCo and petCo.heroSkillId > 0 and not TableUtil.isHad(heroskills, petCo.heroSkillId) then
				table.insert(heroskills, petCo.heroSkillId)
			end
		end
	end

	return heroskills
end

function HolyChallModel:getHeroSkillId()
	return self._formation[self._challengeId]:GetHeroSkillId()
end

function HolyChallModel:changeSkillId(id)
	self._formation[self._challengeId]:SetHeroSkillId(id)
end

function HolyChallModel:SetPosition(pos, value)
	return
end

function HolyChallModel:getAllPets(needSupportId)
	local allPets = BagPetsController.instance:getFightBagPet()

	if needSupportId then
		local creepId = self:getCreepsId()

		allPets[#allPets + 1] = self:getSupportPet(creepId)
	end

	return allPets
end

function HolyChallModel:getPet(petId)
	if checknumber(petId) <= 0 then
		return
	end

	local pet = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end

	return self:getSupportPet(petId)
end

function HolyChallModel:setTeamId(id)
	self._teamId = id
end

function HolyChallModel:getTeamId()
	return self._teamId
end

function HolyChallModel:diffRacePetCount()
	local allPets = self:getAllPets(true)

	ArraySort.sortOn(allPets, "raceId")

	local lastId = -1
	local num = 0

	for i, v in ipairs(allPets) do
		if lastId ~= v.raceId then
			lastId = v.raceId
			num = num + 1
		end
	end

	return num
end

function HolyChallModel:checkHasInTeamByRaceId(raceId)
	local creepId = self:getCreepsId()
	local suppportCfg = HolyChallConfig.instance:getSupportCreep(creepId)

	if raceId == suppportCfg.raceId then
		return true
	end

	local formation = self:getFormation()

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = BagPetsController.instance:getPet(petId)

			if pet and pet.raceId == raceId then
				return true
			end
		end
	end

	return false
end

HolyChallModel.instance = HolyChallModel.New()

return HolyChallModel
