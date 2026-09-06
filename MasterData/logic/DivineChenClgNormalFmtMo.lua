-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/model/DivineChenClgNormalFmtMo.lua

module("logic.extensions.divinechenclg.model.DivineChenClgNormalFmtMo", package.seeall)

local DivineChenClgNormalFmtMo = class("DivineChenClgNormalFmtMo", BaseCustomFmtMo)

function DivineChenClgNormalFmtMo:initParams(activityId, stageId, creepId)
	self.activityId = activityId
	self.stageId = stageId
	self.creepId = creepId
	self.creeps = DivineChenClgConfig.instance:getTeamCfg(self.creepId)
	self.masterCfg = DivineChenClgConfig.instance:getCreepCfgs(self.creepId)

	self:setFormCondition(self.creeps.formCondition)

	local info = DivineChenClgModel.instance:getNormalInfoByActId(self.activityId)

	self._lockedRaceMap = {}

	if info then
		self.supportPetIds = info.supportPetIds or {}
	end

	if not info.passStages then
		local passStages = {}

		for i, passInfo in ipairs(passStages) do
			for _, petId in ipairs(passInfo.lockedPetIds) do
				local cfg = DivineChenClgConfig.instance:getSupportPetCfg(self.activityId, petId)

				self._lockedRaceMap[cfg.creepsId] = true
			end
		end

		self:clearAllPetList()

		self.isOnlyUpdateExistPet = true
	end
end

function DivineChenClgNormalFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()

	for _, creepsId in ipairs(self.supportPetIds) do
		local data = DivineChenClgConfig.instance:getSupportPetCfg(self.activityId, creepsId)

		if data then
			fMo:fromChallengeCreepCo(data)

			local petMo = fMo:toBaseBagPetMo()

			self:addPetToList(petMo)
		end
	end
end

function DivineChenClgNormalFmtMo:getMonsterConfigList()
	return self.masterCfg
end

function DivineChenClgNormalFmtMo:getFmtInfoConfig()
	return self.creeps
end

function DivineChenClgNormalFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo, true)
	end
end

function DivineChenClgNormalFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineChenClgController.instance:startNormalClg(self.activityId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function DivineChenClgNormalFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.petId])
end

function DivineChenClgNormalFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return DivineChenClgNormalFmtMo
