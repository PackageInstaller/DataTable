-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/model/XingluoCustomFmtMo.lua

module("logic.extensions.lailisi.model.XingluoCustomFmtMo", package.seeall)

local XingluoCustomFmtMo = class("XingluoCustomFmtMo", ICustomFmtMo)

function XingluoCustomFmtMo:onReset()
	XingluoCustomFmtMo.super.onReset(self)
end

function XingluoCustomFmtMo:initFightHandler()
	local function handler()
		local curFmo = self:getCurFormation()

		BattleFacade.instance:startLailisiFight()
		LailisiController.instance:sendPM_ActorGainChallengeReq(self._curActId, self._curStageId, curFmo)
	end

	self:setFightHandler(handler, nil)
end

function XingluoCustomFmtMo:initPetList()
	local extremeMode = LailisiConfig.instance:isExtremeMode(self._curActId)
	local petList = XingluoFinghtMo.instance:GetAllPetList(self._curActId, self._curStageId)

	for i, petMo in ipairs(petList) do
		if extremeMode then
			self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
			print("lbc===============", petMo.name)
		else
			self:addPetToList(petMo)
		end
	end
end

function XingluoCustomFmtMo:refreshPetList(changePetMoMap)
	local extremeMode = LailisiConfig.instance:isExtremeMode(self._curActId)

	for petId, petMo in pairs(changePetMoMap) do
		if extremeMode then
			self:updatePetMo(FightingPowerPetMo.getMaxPetMoByData(petMo))
		else
			self:updatePetMo(petMo)
		end
	end
end

function XingluoCustomFmtMo:getMonsterConfigList()
	local cfg = LailisiConfig.instance:getTeamInfo(self._curActId, self._curStageId)

	return LailisiConfig.instance:getPetCreeps(cfg.creepsMasterId)
end

function XingluoCustomFmtMo:getFmtInfoConfig()
	return (LailisiConfig.instance:getTeamInfo(self._curActId, self._curStageId))
end

function XingluoCustomFmtMo:getActivityId(actiId, stageId)
	self._curActId = actiId
	self._curStageId = stageId
end

function XingluoCustomFmtMo:initFormationMo()
	return
end

function XingluoCustomFmtMo:updateData()
	local teamData = LailisiConfig.instance:getTeamInfo(self._curActId, self._curStageId)

	XingluoFinghtMo.instance:onResetInfo()

	self.needUpPetCount = 5
	self.topTitleStr = teamData.name
	self.ruleDescStr = teamData.levelDescription

	self:setFormCondition(teamData.formCondition)
	self:clearAllPetList()

	self.formationMo = XingluoFinghtMo.instance:GetCurFormation(self._curActId, FormationMO.New(GameUtil.handler(self.getPetMoById, self)))

	LailisiModel.instance:setSkipTime(teamData.skipTime)
end

return XingluoCustomFmtMo
