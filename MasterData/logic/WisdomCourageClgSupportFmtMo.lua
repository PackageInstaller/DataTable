-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/model/WisdomCourageClgSupportFmtMo.lua

module("logic.extensions.wisdomcourageclg.model.WisdomCourageClgSupportFmtMo", package.seeall)

local WisdomCourageClgSupportFmtMo = class("WisdomCourageClgSupportFmtMo", BaseCustomFmtMo)

function WisdomCourageClgSupportFmtMo:onReset()
	WisdomCourageClgSupportFmtMo.super.onReset(self)
end

function WisdomCourageClgSupportFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._clgMo = WisdomCourageClgController.instance:getWisdomCourageClgMo(self._activityId)
	self._stageData = WisdomCourageClgConfig.instance:getSupportStageData(self._activityId, self._stageId)
	self._supportPetPlanId = self._stageData.supportPetPoolId
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = WisdomCourageClgConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = WisdomCourageClgConfig.instance:getCreepsCfg(self._creepsMasterId)
end

function WisdomCourageClgSupportFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:tryInitPetList()

	local removePetIdList = {}

	if self._lastSupportPetPlanId ~= self._supportPetPlanId then
		local cfg = WisdomCourageClgConfig.instance:getSupportPetCfg(self._activityId, self._lastSupportPetPlanId)

		if cfg then
			for _, data in pairs(cfg) do
				table.insert(removePetIdList, data.creepsId)
			end
		end
	end

	self:tryRemovePetByIds(removePetIdList)

	local newPetMoList = {}

	if self._lastSupportPetPlanId ~= self._supportPetPlanId then
		local cfg = WisdomCourageClgConfig.instance:getSupportPetCfg(self._activityId, self._supportPetPlanId)

		if cfg then
			local fmo = FightingPowerPetMo.New()

			for _, data in pairs(cfg) do
				fmo:fromChallengeCreepCo(data)

				local petMo = fmo:toBaseBagPetMo()

				petMo:setSupportedPet(true)
				table.insert(newPetMoList, petMo)
			end
		end

		self._lastSupportPetPlanId = self._supportPetPlanId
	end

	for _, petMo in ipairs(newPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function WisdomCourageClgSupportFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		WisdomCourageClgController.instance:sendPM_WisdomCourageClgSupportChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function WisdomCourageClgSupportFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function WisdomCourageClgSupportFmtMo:getFmtInfoConfig()
	return self._masterData
end

return WisdomCourageClgSupportFmtMo
