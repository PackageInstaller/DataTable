-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/model/DivineNuoYaChallengeModel.lua

module("logic.extensions.divinenuoyachallenge.model.DivineNuoYaChallengeModel", package.seeall)

local DivineNuoYaChallengeModel = class("DivineNuoYaChallengeModel", BaseModel)

DivineNuoYaChallengeModel.SelectPet = 1
DivineNuoYaChallengeModel.LookOverPet = 2
DivineNuoYaChallengeModel.ResetPet = "resetpet"
DivineNuoYaChallengeModel.PassStage = "passstage"
DivineNuoYaChallengeModel.SortKey = "DivineNuoYaSelectView_SortKey"

function DivineNuoYaChallengeModel:onInit()
	self:onReset()
end

function DivineNuoYaChallengeModel:onReset()
	self._activityId = 0
	self._normalClgProgress = 0
	self._hasGainNormalClgPrize = false
	self._normalClgFightCountDaily = 0
	self._extremeClgStageProgress = 0
	self._extremeClgMonsterProgress = 0
	self._petHpInfo = {}
	self._hasGainExtremeClgPrize = false
	self._hasPassExtremeClgStageDaily = false
	self._battleExtremeBigStageId = 1
	self._battleExtremeSmallStageId = 1
	self._battlePetIds = nil
	self._passBigStage = nil
	self._tempPetHpInfo = {}
	self._normalCustomFmtMo = nil
	self._extremeCustomFmtMo = nil
end

function DivineNuoYaChallengeModel:getNormalCustomFmtMo()
	if self._normalCustomFmtMo == nil then
		self._normalCustomFmtMo = DivineNuoYaNormalCustomFmtMo.New()
	end

	return self._normalCustomFmtMo
end

function DivineNuoYaChallengeModel:getExtremeCustomFmtMo()
	if self._extremeCustomFmtMo == nil then
		self._extremeCustomFmtMo = DivineNuoYaExtremeCustomFmtMo.New()
	end

	return self._extremeCustomFmtMo
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgGetInfoRes(msg)
	self._normalClgProgress = msg.normalClgProgress
	self._hasGainNormalClgPrize = msg.hasGainNormalClgPrize
	self._normalClgFightCountDaily = msg.normalClgFightCountDaily
	self._extremeClgStageProgress = msg.extremeClgStageProgress
	self._extremeClgMonsterProgress = msg.extremeClgMonsterProgress
	self._petHpInfo = GameUtil.pbToTable(msg.petHpInfo) or {}

	for i, v in ipairs(self._petHpInfo) do
		if v.leftHp then
			v.leftHp = v.leftHp or -1
		end
	end

	self._hasGainExtremeClgPrize = msg.hasGainExtremeClgPrize
	self._hasPassExtremeClgStageDaily = msg.hasPassExtremeClgStageDaily
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgNormalFightRes(msg)
	return
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgNotifyNormalFightResultRes(msg)
	if msg.win and msg:HasField("normalClgProgress") then
		self._normalClgProgress = msg.normalClgProgress
		self._normalClgFightCountDaily = msg.normalClgFightCountDaily
	end
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgSelectPetsRes(msg, selectPets)
	self._petHpInfo = {}

	if selectPets then
		for i, v in ipairs(selectPets) do
			local element = {}

			element.petId = v
			element.leftHp = -1

			table.insert(self._petHpInfo, element)
		end
	end
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgExtremeFightRes(msg)
	return
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgNotifyExtremeFightResultRes(msg, battlePetIds)
	self._passBigStage = false
	self._tempPetHpInfo = nil

	if msg.win then
		self._battlePetIds = battlePetIds
		self._battleExtremeBigStageId = self._extremeClgStageProgress + 1
		self._battleExtremeSmallStageId = self._extremeClgMonsterProgress + 1

		if msg:HasField("passStage") and msg.passStage then
			self._hasPassExtremeClgStageDaily = true
			self._passBigStage = true
			self._extremeClgMonsterProgress = 0
			self._petHpInfo = {}
			self._tempPetHpInfo = GameUtil.pbToTable(msg.petHpInfo) or {}

			for i, v in ipairs(self._tempPetHpInfo) do
				if v.leftHp then
					v.leftHp = v.leftHp or -1
				end
			end

			if msg:HasField("stageProgress") then
				self._extremeClgStageProgress = msg.stageProgress
			end
		elseif msg:HasField("monsterProgress") then
			self._extremeClgMonsterProgress = msg.monsterProgress
			self._petHpInfo = GameUtil.pbToTable(msg.petHpInfo) or {}

			for i, v in ipairs(self._petHpInfo) do
				if v.leftHp then
					v.leftHp = v.leftHp or -1
				end
			end

			self._tempPetHpInfo = self._petHpInfo
		end
	end
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgGainNormalPrizeRes(msg)
	self._hasGainNormalClgPrize = true
end

function DivineNuoYaChallengeModel:onDivineNuoYaClgGainExtremePrizeRes(msg)
	self._hasGainExtremeClgPrize = true
end

function DivineNuoYaChallengeModel:onDivineNuoYaExtremeClgResetStageRes(msg)
	self._extremeClgStageProgress = msg.stageProgress
	self._extremeClgMonsterProgress = 0
	self._petHpInfo = {}
end

function DivineNuoYaChallengeModel:getActivityId()
	if self._activityId > 0 then
		return self._activityId
	else
		local cfgActivity = ActivityDefineController.instance:getActivityCfgByType(self:getActivityType())

		if cfgActivity then
			self._activityId = cfgActivity.activityId or 316001
		end

		return self._activityId
	end
end

function DivineNuoYaChallengeModel:getActivityType()
	return GameEnum.ActivityType.DivineNuoYaChallenge
end

function DivineNuoYaChallengeModel:isGainNormalClgPrize()
	return self._hasGainNormalClgPrize
end

function DivineNuoYaChallengeModel:isGainExtremeClgPrize()
	return self._hasGainExtremeClgPrize
end

function DivineNuoYaChallengeModel:isPassNormalClgProgress(activityId)
	local isPass = false
	local cfgStages = DivineNuoYaChallengeConfig.instance:getNormalStageList(activityId)

	if cfgStages then
		local maxNum = #cfgStages
		local curNum = self._normalClgProgress

		isPass = maxNum <= curNum
	end

	return isPass
end

function DivineNuoYaChallengeModel:getNormalClgProgress()
	return self._normalClgProgress
end

function DivineNuoYaChallengeModel:isPassExtremeClgStageProgress(activityId)
	local isPass = false
	local cfgStages = DivineNuoYaChallengeConfig.instance:getExtremeStageList(activityId)

	if cfgStages then
		local maxNum = #cfgStages
		local curNum = self._extremeClgStageProgress

		isPass = maxNum <= curNum
	end

	return isPass
end

function DivineNuoYaChallengeModel:normalChallengeTimes()
	return self._normalClgFightCountDaily
end

function DivineNuoYaChallengeModel:getExtremeBigStageProgress()
	return self._extremeClgStageProgress
end

function DivineNuoYaChallengeModel:getExtremeSmallStageProgress()
	return self._extremeClgMonsterProgress
end

function DivineNuoYaChallengeModel:isExtremeSelectedPet()
	return self._petHpInfo and #self._petHpInfo > 0
end

function DivineNuoYaChallengeModel:getPetInfoList()
	local list = {}

	for i, v in ipairs(self._petHpInfo) do
		local petMo = BagPetsController.instance:getPet(v.petId)

		if petMo then
			local element = {}

			element.petMo = petMo
			element.leftHp = v.leftHp

			table.insert(list, element)
		end
	end

	return list
end

function DivineNuoYaChallengeModel:isPetLock(petId)
	local isLock = false

	for i, v in ipairs(self._petHpInfo) do
		if v.petId == petId and v.leftHp == 0 then
			isLock = true

			break
		end
	end

	return isLock
end

function DivineNuoYaChallengeModel:getPetHp(petId)
	for i, v in ipairs(self._petHpInfo) do
		if v.petId == petId then
			return v.leftHp
		end
	end

	return 0
end

function DivineNuoYaChallengeModel:getBattleExtremeBigStageId()
	return self._battleExtremeBigStageId
end

function DivineNuoYaChallengeModel:getBattleExtremeSmallStageId()
	return self._battleExtremeSmallStageId
end

function DivineNuoYaChallengeModel:getBattlePetHp(petId)
	for i, v in ipairs(self._tempPetHpInfo) do
		if v.petId == petId then
			return v.leftHp
		end
	end

	return 0
end

function DivineNuoYaChallengeModel:getBattleResultPetInfos()
	local list = {}

	for i, petId in ipairs(self._battlePetIds) do
		local item = {}

		item.petId = petId
		item.leftHp = self:getBattlePetHp(petId)

		table.insert(list, item)
	end

	return list
end

function DivineNuoYaChallengeModel:isBattlePassBigStage()
	return self._passBigStage
end

function DivineNuoYaChallengeModel:isPassExtremeClgStageDaily()
	return self._hasPassExtremeClgStageDaily
end

DivineNuoYaChallengeModel.instance = DivineNuoYaChallengeModel.New()

return DivineNuoYaChallengeModel
