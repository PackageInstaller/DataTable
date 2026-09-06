-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/model/GodStatuesWarFightNestCustomFmtMo.lua

module("logic.extensions.wudiclg.model.GodStatuesWarFightNestCustomFmtMo", package.seeall)

local GodStatuesWarFightNestCustomFmtMo = class("GodStatuesWarFightNestCustomFmtMo", BaseCustomFmtMo)

function GodStatuesWarFightNestCustomFmtMo:onReset()
	GodStatuesWarFightNestCustomFmtMo.super.onReset(self)
end

function GodStatuesWarFightNestCustomFmtMo:updateCfg(seasonId, nestPlanId, nestId)
	self._seasonId = seasonId
	self._nestPlanId = nestPlanId
	self._nestId = nestId
	self._nestData = GodStatuesWarConfig.instance:getNfbNestData(self._nestPlanId, self._nestId)
	self._creepsMasterId = self._nestData.creepsMasterId
	self._masterData = GodStatuesWarConfig.instance:getNfbMasterData(self._creepsMasterId)
	self._creepsCfg = GodStatuesWarConfig.instance:getNfbCreepsCfg(self._creepsMasterId)
end

function GodStatuesWarFightNestCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function GodStatuesWarFightNestCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		GodStatuesWarController.instance:sendPM_NewFamilyBattleChallengeNestReq(self._seasonId, simpleForm, self._nestPlanId, self._nestId)
	end

	self:setFightHandler(handler, nil)
end

function GodStatuesWarFightNestCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function GodStatuesWarFightNestCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

return GodStatuesWarFightNestCustomFmtMo
