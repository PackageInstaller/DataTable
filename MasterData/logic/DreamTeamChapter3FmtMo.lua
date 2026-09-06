-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/model/DreamTeamChapter3FmtMo.lua

module("logic.extensions.dreamteamchapter.model.DreamTeamChapter3FmtMo", package.seeall)

local DreamTeamChapter3FmtMo = class("DreamTeamChapter3FmtMo", BaseCustomFmtMo)

function DreamTeamChapter3FmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(activityId)
	self._creepsMasterId = self._actCfg.chapter3creepsMasterId
	self._masterData = DreamTeamChapterConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DreamTeamChapterConfig.instance:getCreepsCfg(self._creepsMasterId)

	if self._actCfg then
		if not self._actCfg.chapter3SupportPetPlan then
			local chapter3SupportPetPlan = 0

			self._extraPetCfgs = DreamTeamChapterConfig.instance:getSupportPetCfgs(chapter3SupportPetPlan)
			self.topTitleStr = self._masterData.name
			self.ruleDescStr = self._masterData.ruleDesc

			self:setFormCondition(self._masterData.formCondition)
		end
	end
end

function DreamTeamChapter3FmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DreamTeamChapterController.instance:sendPM_DreamTeamChapterChallengeBossReq(self._activityId, simpleForm)
	end, nil)
end

function DreamTeamChapter3FmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DreamTeamChapter3FmtMo:getFmtInfoConfig()
	return self._masterData
end

function DreamTeamChapter3FmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if self._extraPetCfgs then
		local fMo = FightingPowerPetMo.New()

		for _, supportCfg in pairs(self._extraPetCfgs or {}) do
			fMo:fromChallengeCreepCo(supportCfg)

			local petMo = fMo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

return DreamTeamChapter3FmtMo
