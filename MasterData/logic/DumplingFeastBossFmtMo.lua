-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/model/DumplingFeastBossFmtMo.lua

module("logic.extensions.dumplingfeast.model.DumplingFeastBossFmtMo", package.seeall)

local DumplingFeastBossFmtMo = class("DumplingFeastBossFmtMo", BaseCustomFmtMo)

function DumplingFeastBossFmtMo:onReset()
	DumplingFeastBossFmtMo.super.onReset(self)
end

function DumplingFeastBossFmtMo:updateCfg(activityId, isTrial)
	self._activityId = activityId
	self._isTrial = isTrial

	local actData = DumplingFeastConfig.instance:getActivityData(self._activityId)

	self._creepsMasterId = actData.bossCreepsMasterId
	self._subMo = DumplingFeastController.instance:getSubMo(self._activityId)
	self._creepsTeamData = DumplingFeastConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = DumplingFeastConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._creepsTeamData.name
	self.validatorDescStr = self._creepsTeamData.missionDesc
	self.ruleDescStr = self._creepsTeamData.ruleDesc

	self:setFormCondition(self._creepsTeamData.formCondition)
end

function DumplingFeastBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DumplingFeastController.instance:sendPM_DumplingFeastBossClgReq(self._activityId, simpleForm, self._isTrial)
	end

	self:setFightHandler(handler, nil)
end

function DumplingFeastBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DumplingFeastBossFmtMo:getFmtInfoConfig()
	return self._creepsTeamData
end

function DumplingFeastBossFmtMo:initPetList()
	DumplingFeastBossFmtMo.super.initPetList(self)

	local fMo = FightingPowerPetMo.New()
	local supportPetDatas = DumplingFeastConfig.instance:getSupportPetDatas(self._activityId) or {}

	for _, data in pairs(supportPetDatas) do
		fMo:fromChallengeCreepCo(data)

		local petMo = fMo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(petMo)
	end
end

return DumplingFeastBossFmtMo
