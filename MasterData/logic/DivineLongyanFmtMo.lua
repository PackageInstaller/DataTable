-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/model/DivineLongyanFmtMo.lua

module("logic.extensions.divinelongyan.model.DivineLongyanFmtMo", package.seeall)

local DivineLongyanFmtMo = class("DivineLongyanFmtMo", BaseCustomFmtMo)

function DivineLongyanFmtMo:initParams(activityId, clgType, creepsMasterId, stageId)
	self._activityId = activityId
	self._clgType = clgType

	if self._clgType == GameEnum.DivineLongyanClgType.Power then
		self.useMaxFightPower = true
	elseif self._clgType == GameEnum.DivineLongyanClgType.Line then
		self.useMaxFightPower = false
	end

	self.creepsMasterId = creepsMasterId
	self._stageId = stageId
	self.masterCfg = DivinelongyanConfig.instance:getMasterCfgById(self.creepsMasterId)
	self.creeps = DivinelongyanConfig.instance:getCreepsCfgs(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
end

function DivineLongyanFmtMo:initFightHandler()
	self:setFightHandler(function()
		local form = self:getCurFormation():createFormPb()

		if self._clgType == GameEnum.DivineLongyanClgType.Power then
			DivineLongYanChallengeAgent.instance:sendPM_DivineLongYanPowerChallengeReq(self._activityId, self._stageId, form)
		elseif self._clgType == GameEnum.DivineLongyanClgType.Line then
			DivineLongYanChallengeAgent.instance:sendPM_DivineLongYanLineChallengeReq(self._activityId, form)
		end
	end)
end

function DivineLongyanFmtMo:updatePetListEachTime()
	if self._clgType == GameEnum.DivineLongyanClgType.Line then
		local petMo = DivinelongyanModel.instance:getCurSuppopPetMo(self._activityId)

		if petMo then
			self:updatePetMo(petMo)
		end
	end
end

function DivineLongyanFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineLongyanFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

return DivineLongyanFmtMo
