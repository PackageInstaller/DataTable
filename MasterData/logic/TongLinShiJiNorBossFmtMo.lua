-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/model/TongLinShiJiNorBossFmtMo.lua

module("logic.extensions.tonglinshiji.model.TongLinShiJiNorBossFmtMo", package.seeall)

local TongLinShiJiNorBossFmtMo = class("TongLinShiJiNorBossFmtMo", BaseCustomFmtMo)

function TongLinShiJiNorBossFmtMo:onReset()
	TongLinShiJiNorBossFmtMo.super.onReset(self)
end

function TongLinShiJiNorBossFmtMo:updateCfg(activityId, practice)
	self._activityId = activityId
	self._practice = practice
	self._creepsMasterId = TongLinShiJiConfig.instance:GetNorBossCreepsId(activityId)
	self._masterData = TongLinShiJiConfig.instance:getJiMonsterData(self._creepsMasterId)
	self._creepsCfg = TongLinShiJiConfig.instance:getJiCreepsData(self._creepsMasterId)
	self._creepsIds = TongLinShiJiModel.instance:CurNorBuffsCreepsId(activityId)
end

function TongLinShiJiNorBossFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:_checkAndAddSupportPet()
end

function TongLinShiJiNorBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		TongLinShiJiController.instance:sendPM_JiClgNormalBossReq(self._activityId, self._practice, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function TongLinShiJiNorBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function TongLinShiJiNorBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function TongLinShiJiNorBossFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function TongLinShiJiNorBossFmtMo:_changePetMo(petMo)
	return FightingPowerPetMo.getMaxPetMoByData(petMo)
end

function TongLinShiJiNorBossFmtMo:_checkAndAddSupportPet()
	local buffs = TongLinShiJiModel.instance:CurNorBuffsCreepsId(self._activityId)
	local fMo = FightingPowerPetMo.New()

	if #buffs == 0 then
		return
	end

	self:tryInitPetList()

	for k, creepsId in pairs(buffs) do
		if self._rightPetMap and self._rightPetMap[creepsId] == nil then
			local cfg = TongLinShiJiConfig.instance:getJiSupportPetData(creepsId)

			fMo:fromChallengeCreepCo(cfg)

			local petMo = fMo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

return TongLinShiJiNorBossFmtMo
