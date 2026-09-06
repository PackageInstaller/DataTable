-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/model/LailisiCustomFmtMo.lua

module("logic.extensions.lailisi.model.LailisiCustomFmtMo", package.seeall)

local LailisiCustomFmtMo = class("LailisiCustomFmtMo", ICustomFmtMo)

function LailisiCustomFmtMo:onReset()
	LailisiCustomFmtMo.super.onReset(self)
end

function LailisiCustomFmtMo:initFightHandler()
	local function handler()
		local curFmo = LailisiModel.instance:GetCurFormation(self._curActId)

		BattleFacade.instance:startLailisiFight()
		LailisiController.instance:sendPM_ActorGainChallengeReq(self._curActId, self._curStageId, curFmo)
	end

	self:setFightHandler(handler, nil)
end

function LailisiCustomFmtMo:initPetList()
	local petList = LailisiModel.instance:GetAllPetList(self._curActId, self._curStageId)

	for i, petMo in ipairs(petList) do
		self:addPetToList(petMo)
	end
end

function LailisiCustomFmtMo:refreshPetList(changePetMoMap)
	local isCfg = LailisiModel.instance:isFinalAct(self._curActId)

	if not isCfg then
		for petId, petMo in pairs(changePetMoMap) do
			self:updatePetMo(petMo)
		end
	end
end

function LailisiCustomFmtMo:getMonsterConfigList()
	local cfg = LailisiConfig.instance:getTeamInfo(self._curActId, self._curStageId)

	return LailisiConfig.instance:getPetCreeps(cfg.creepsMasterId)
end

function LailisiCustomFmtMo:getFmtInfoConfig()
	local cfg = LailisiConfig.instance:getTeamInfo(self._curActId, self._curStageId)

	return LailisiConfig.instance:getPetCreeps(cfg.creepsMasterId)
end

function LailisiCustomFmtMo:getActivityId(actiId, stageId)
	self._curActId = actiId
	self._curStageId = stageId
end

function LailisiCustomFmtMo:updateData()
	local teamData = LailisiConfig.instance:getTeamInfo(self._curActId, self._curStageId)

	LailisiModel.instance:onResetInfo()

	local petList = LailisiModel.instance:GetAllPetList(self._curActId, self._curStageId)

	self.needUpPetCount = 5
	self.topTitleStr = teamData.name
	self.ruleDescStr = teamData.levelDescription

	self:setFormCondition(teamData.formCondition)
	self:clearAllPetList()

	self.formationMo = LailisiModel.instance:GetCurFormation(self._curActId, GameUtil.handler(self.getPetMoById, self))

	LailisiModel.instance:setSkipTime(teamData.skipTime)
end

return LailisiCustomFmtMo
