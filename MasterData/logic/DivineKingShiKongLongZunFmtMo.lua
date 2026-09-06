-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/model/DivineKingShiKongLongZunFmtMo.lua

module("logic.extensions.divinekingshikongllongzun.model.DivineKingShiKongLongZunFmtMo", package.seeall)

local DivineKingShiKongLongZunFmtMo = class("DivineKingShiKongLongZunFmtMo", BaseCustomFmtMo)

function DivineKingShiKongLongZunFmtMo:updateCfg(activityId, floorId, stageId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)
	self._floorId = checknumber(floorId)
	self._stageId = checknumber(stageId)

	local stagePlanId = DivineKingShiKongLongZunConfig.instance:getStagePlanId(activityId, floorId)

	self._creepsMasterId = DivineKingShiKongLongZunConfig.instance:getCreepMasterId(stagePlanId, stageId)
	self._masterData = DivineKingShiKongLongZunConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineKingShiKongLongZunConfig.instance:getCreepCfg(self._creepsMasterId)
	self._stageCfg = DivineKingShiKongLongZunConfig.instance:getStageCfgByStageId(stagePlanId, stageId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = "只能上阵非神曜精灵，血量优先继承到敌阵二相同站位的精灵"
	self.ruleDescStr = self._masterData.ruleDesc
	self.isOnlyUpdateExistPet = true

	self:setFormCondition(self._masterData.formCondition)
end

function DivineKingShiKongLongZunFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineKingShiKongLongZunController.instance:sendPM_DivineKingSpaceDragonChallengeReq(self._activityId, simpleForm, self._floorId, self._stageId)
	end, nil)
end

function DivineKingShiKongLongZunFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineKingShiKongLongZunFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineKingShiKongLongZunFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		local faceId = petMo.curFaceId
		local hasShenYaoJob = PetSkinConfig.instance:checkHasJob(faceId, GameEnum.JobZhDefine.ShenYao)

		if not hasShenYaoJob then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

return DivineKingShiKongLongZunFmtMo
