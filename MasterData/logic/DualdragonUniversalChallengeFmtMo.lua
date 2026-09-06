-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/model/DualdragonUniversalChallengeFmtMo.lua

module("logic.extensions.dualdragonchallenge.model.DualdragonUniversalChallengeFmtMo", package.seeall)

local DualdragonUniversalChallengeFmtMo = class("DualdragonUniversalChallengeFmtMo", ICustomFmtMo)

function DualdragonUniversalChallengeFmtMo:initParams(activityId, creepsMasterId)
	self.isShowTab = false
	self._activityId = activityId
	self._creepsMasterId = creepsMasterId

	local cfg = DualdragonchallengeConfig.instance:getMasterCfg(creepsMasterId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.WinDesc
	self.isShowBtnCutePet = false
end

function DualdragonUniversalChallengeFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurFormation():createFormPb()

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DualDragonChallengeAgent.instance:sendPM_DualDragonUniversalChallengeReq(self._activityId, form)
	end

	self:setFightHandler(handler, nil)
end

function DualdragonUniversalChallengeFmtMo:initPetList()
	local supportCfgs = DualdragonchallengeConfig.instance:getUniversalSupportPetsCfgs(self._activityId)

	for k, v in pairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end
end

function DualdragonUniversalChallengeFmtMo:getMonsterConfigList()
	return DualdragonchallengeConfig.instance:getCreepCfgs(self._creepsMasterId)
end

function DualdragonUniversalChallengeFmtMo:getFmtInfoConfig()
	return DualdragonchallengeConfig.instance:getMasterCfg(self._creepsMasterId)
end

function DualdragonUniversalChallengeFmtMo:initSaveHandler()
	return
end

return DualdragonUniversalChallengeFmtMo
