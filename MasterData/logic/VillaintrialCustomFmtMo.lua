-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/model/VillaintrialCustomFmtMo.lua

module("logic.extensions.villaintrial.model.VillaintrialCustomFmtMo", package.seeall)

local VillaintrialCustomFmtMo = class("VillaintrialCustomFmtMo", ICustomFmtMo)

function VillaintrialCustomFmtMo:onReset()
	VillaintrialCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function VillaintrialCustomFmtMo:initFightHandler()
	local function handler()
		local actId = VillaintrialConfig.instance:getOpenActivityId()
		local curFmo = VillaintrialModel.instance:GetCurFormation()
		local stageId = VillaintrialModel.instance:getCurStageId()

		VillaintrialController.instance:sendPM_VillainPetTrialChallengeReq(actId, stageId, curFmo)
	end

	self:setFightHandler(handler, nil)
end

function VillaintrialCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	local maxNum = self.needUpPetCount
	local petPoolNum = 0

	for _, petMo in pairs(petPool) do
		petPoolNum = petPoolNum + (petMo and 1 or 0)
	end

	local needAddPetNum = maxNum - petPoolNum

	if needAddPetNum == 0 then
		return posList, petPool
	elseif needAddPetNum < 0 then
		printError("错误,一键布阵意图上阵精灵数量超过限制,请务必检查( maxNum=%d, petPoolNum=%d )", maxNum, petPoolNum)

		return posList, petPool
	end

	local exPetMoList = {}
	local exPetNum = 0

	for _, petMo in ipairs(self:getAllShowPetList()) do
		local isFitCount = exPetNum < needAddPetNum

		if not isFitCount then
			break
		end

		local isRepeatRaceId = false
		local raceId = petMo:getDefineId()

		for _, v in pairs(petPool) do
			if v and v:getDefineId() == raceId then
				isRepeatRaceId = true

				break
			end
		end

		local isSummonedPet = petMo:isSummonedPet()

		if not isRepeatRaceId and not isSummonedPet then
			table.insert(exPetMoList, petMo)

			exPetNum = exPetNum + 1
		end
	end

	for idx, posId in ipairs(posList) do
		if petPool[idx] == nil then
			local exPetMo = exPetMoList[#exPetMoList]

			if exPetMo then
				petPool[idx] = exPetMo
				exPetMoList[#exPetMoList] = nil
			else
				break
			end
		end
	end

	return posList, petPool
end

function VillaintrialCustomFmtMo:initFormationMo()
	self.formationMo = VillaintrialModel.instance:GetCurFormation()
end

function VillaintrialCustomFmtMo:getFixedPosList()
	if VillaintrialModel.instance:isAboveThreeLevel() then
		return
	end

	return {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9
	}
end

function VillaintrialCustomFmtMo:initPetList()
	local petList = VillaintrialModel.instance:GetAllPetList()

	for i, petMo in ipairs(petList) do
		self:addPetToList(petMo)
		print("lbc================petId", petMo.petId)
	end
end

function VillaintrialCustomFmtMo:getIsBoundUseBagPet()
	return false
end

function VillaintrialCustomFmtMo:getMonsterConfigList()
	local creepsMasterId = VillaintrialModel.instance:getCreepsMasterId()

	return VillaintrialConfig.instance:getPetCreeps(creepsMasterId)
end

function VillaintrialCustomFmtMo:getFmtInfoConfig()
	local creepsMasterId = VillaintrialModel.instance:getCreepsMasterId()

	return VillaintrialConfig.instance:getPetCreeps(creepsMasterId)
end

function VillaintrialCustomFmtMo:getExtendViewName()
	return ViewName.VillaintrialMaskView
end

function VillaintrialCustomFmtMo:updateData()
	local activityId = VillaintrialConfig.instance:getOpenActivityId()
	local stageId = VillaintrialModel.instance:getCurStageId()
	local creepsMasterId = VillaintrialModel.instance:getCreepsMasterId()
	local teamData = VillaintrialConfig.instance:getPlCreepsCfg(creepsMasterId)
	local count = VillaintrialModel.instance:getMaxPetCount()

	VillaintrialModel.instance:onResetInfo()

	self.needUpPetCount = VillaintrialModel.instance:isAboveThreeLevel() and count or 5
	self.topTitleStr = teamData.name
	self.ruleDescStr = teamData.description
	self.isShowBtnBuffForm = false

	self:clearAllPetList()
	self:initFormationMo()

	if VillaintrialModel.instance:isAboveThreeLevel() then
		self:setFormCondition(nil)

		self.validatorDescStr = string.format("本关可最多上阵%s只精灵", count)
	else
		self.validatorDescStr = ""
	end
end

return VillaintrialCustomFmtMo
