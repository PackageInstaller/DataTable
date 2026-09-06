-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/model/PeakTowerBasicFmtMo.lua

module("logic.extensions.peaktower.model.PeakTowerBasicFmtMo", package.seeall)

local PeakTowerBasicFmtMo = class("PeakTowerBasicFmtMo", BaseCustomFmtMo)

function PeakTowerBasicFmtMo:onInit()
	PeakTowerBasicFmtMo.super.onInit(self)

	self.isOnlyUpdateExistPet = true
end

function PeakTowerBasicFmtMo:initParams(activityId, weekId, floorId, stageId)
	self.activityId = activityId
	self.floorId = floorId
	self.stageId = stageId
	self._stageCfg = PeakTowerConfig.instance:getBasicStageCfg(self.activityId, weekId, self.floorId, self.stageId)
	self._cfgEnemy = PeakTowerConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = PeakTowerConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function PeakTowerBasicFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		PeakTowerController.instance:sendPM_PeakTowerBasicClgReq(self.activityId, simpleForm, self.floorId, self.stageId)
	end

	self:setFightHandler(handler, nil)
end

function PeakTowerBasicFmtMo:initPetList()
	self:clearAllPetList()

	local supportCfgs = PeakTowerConfig.instance:getSupportPetCfgs(self.activityId)

	for i, cfgSupport in pairs(supportCfgs) do
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(cfgSupport)
		fmo:setSupportedPet(true)

		local supportPetMo = fmo:toBaseBagPetMo()

		self:addPetToList(supportPetMo)
	end
end

function PeakTowerBasicFmtMo:getMonsterConfigList()
	return self._masterList
end

function PeakTowerBasicFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function PeakTowerBasicFmtMo:checkPetIsForbit(petMo, baseCheck)
	if PeakTowerModel.instance:isBanPetInBasicFloor(self.activityId, self.floorId, petMo.raceId) == true then
		return true
	end

	return false
end

function PeakTowerBasicFmtMo:showForbitPetAlert(petMo)
	if PeakTowerModel.instance:isBanPetInBasicFloor(self.activityId, self.floorId, petMo.raceId) == true then
		FloatWordMgr.instance:show(lang("该精灵已被封印"))
	end
end

return PeakTowerBasicFmtMo
