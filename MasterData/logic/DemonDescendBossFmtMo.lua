-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/model/DemonDescendBossFmtMo.lua

module("logic.extensions.demondescend.model.DemonDescendBossFmtMo", package.seeall)

local DemonDescendBossFmtMo = class("DemonDescendBossFmtMo", BaseCustomFmtMo)

function DemonDescendBossFmtMo:onReset()
	DemonDescendBossFmtMo.super.onReset(self)
end

function DemonDescendBossFmtMo:updateCfg(activityId, buffIdList, isTrial)
	self._activityId = activityId
	self._buffIdList = buffIdList
	self._isTrial = isTrial
	self._subMo = DemonDescendController.instance:getSubMo(self._activityId)

	local actData = DemonDescendConfig.instance:getActData(self._activityId)

	self._creepsMasterId = actData.creepsMasterId
	self._masterData = DemonDescendConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = DemonDescendConfig.instance:getCreepsCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self._lockedRaceIdMap = {}

	local lockRaceIds = self._subMo:getBanRaceIds()

	for k, v in pairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = true
	end
end

function DemonDescendBossFmtMo:initPetList()
	DemonDescendBossFmtMo.super.initPetList(self)

	local cfg = DemonDescendConfig.instance:getSupportCfg(self._activityId)

	if cfg then
		self._fmo = self._fmo or FightingPowerPetMo.New()

		for _, data in pairs(cfg) do
			self._fmo:fromChallengeCreepCo(data)

			local petMo = self._fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function DemonDescendBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DemonDescendController.instance:sendPM_DemonDescendBossChallengeReq(self._activityId, simpleForm, self._buffIdList, self._isTrial)
	end

	self:setFightHandler(handler, nil)
end

function DemonDescendBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DemonDescendBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DemonDescendBossFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function DemonDescendBossFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DemonDescendBossFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DemonDescendBossFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function DemonDescendBossFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId]
end

return DemonDescendBossFmtMo
