-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/model/DivineInvincibleNormalFmtMo.lua

module("logic.extensions.divineinvincible.model.DivineInvincibleNormalFmtMo", package.seeall)

local DivineInvincibleNormalFmtMo = class("DivineInvincibleNormalFmtMo", BaseCustomFmtMo)

function DivineInvincibleNormalFmtMo:updateCfg(activityId, stageId, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId
	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)
	self._masterData = DivineInvincibleConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = DivineInvincibleConfig.instance:getCreepsCfg(self._creepsMasterId)

	local actData = DivineInvincibleConfig.instance:getActData(self._activityId)

	self._needUpRaceId = actData.normalRaceId
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.useMaxFightPower = true
end

function DivineInvincibleNormalFmtMo:initPetList()
	DivineInvincibleNormalFmtMo.super.initPetList(self)

	local newPetMoList = {}
	local cfg = DivineInvincibleConfig.instance:getSupportDataList()

	if cfg then
		local fmo = FightingPowerPetMo.New()

		for _, data in pairs(cfg) do
			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			table.insert(newPetMoList, petMo)
		end
	end

	for _, petMo in ipairs(newPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineInvincibleNormalFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineInvincibleController.instance:sendPM_DivineInvincibleClgNormalFightReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineInvincibleNormalFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineInvincibleNormalFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineInvincibleNormalFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local result = false

	if self._needUpRaceId > 0 then
		local formation = self:getCurFormation()

		if not formation:HasRace(self._needUpRaceId) then
			local petName = CharacterConfig.instance:getPetName(self._needUpRaceId)

			FloatWordMgr.instance:show(string.format("必须上阵精灵：%s", petName))

			result = true
		end
	else
		result = DivineKunLunExtFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end

	return result
end

return DivineInvincibleNormalFmtMo
