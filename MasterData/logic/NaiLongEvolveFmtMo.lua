-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/model/NaiLongEvolveFmtMo.lua

module("logic.extensions.nailongevolve.model.NaiLongEvolveFmtMo", package.seeall)

local NaiLongEvolveFmtMo = class("NaiLongEvolveFmtMo", BaseCustomFmtMo)

function NaiLongEvolveFmtMo:onReset()
	NaiLongEvolveFmtMo.super.onReset(self)
end

function NaiLongEvolveFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._creepsMasterId = NaiLongEvolveConfig.instance:getCreepMasterId(activityId, stageId)
	self._masterData = NaiLongEvolveConfig.instance:getCreepMasterData(self._creepsMasterId)
	self._creepsCfg = NaiLongEvolveConfig.instance:getCreepsData(self._creepsMasterId)
	self._supportCfg = NaiLongEvolveConfig.instance:getSupportData(activityId)
	self._stageCfg = NaiLongEvolveConfig.instance:getStageDataByStageId(activityId, stageId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function NaiLongEvolveFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		NaiLongEvolveController.instance:sendPM_MilkDragonFightReq(self._activityId, simpleForm)
	end, nil)
end

function NaiLongEvolveFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local supportPetId = self._stageCfg.supportPetId
	local supportPetRaceId = self._supportCfg[supportPetId].raceId
	local formationMo = self:getCurFormation()

	if not formationMo:HasRace(supportPetRaceId) then
		FloatWordMgr.instance:show(string.format("%s必须上阵", self._supportCfg[supportPetId].creepsName))

		return true
	else
		return NaiLongEvolveFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

function NaiLongEvolveFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function NaiLongEvolveFmtMo:getFmtInfoConfig()
	return self._masterData
end

function NaiLongEvolveFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(bagPetMoList) do
		self:addPetToList(petMo)
	end

	if self._supportCfg then
		local fmo = self:_getFightPowerPetMo()
		local supportPetId = self._stageCfg.supportPetId
		local helpData = self._supportCfg[supportPetId]

		fmo:fromChallengeCreepCo(helpData)

		local petMo = fmo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end
end

function NaiLongEvolveFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

return NaiLongEvolveFmtMo
