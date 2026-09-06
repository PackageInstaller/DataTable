-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/model/NeweranuoyaFmtMo.lua

module("logic.extensions.neweranuoya.model.NeweranuoyaFmtMo", package.seeall)

local NeweranuoyaFmtMo = class("NeweranuoyaFmtMo", BaseCustomFmtMo)

function NeweranuoyaFmtMo:initParams(activityId, clgType, floorId, stageId)
	self._activityId = activityId
	self._clgType = clgType
	self._floorId = floorId
	self._stageId = stageId
	self._stageCfg = self._clgType == NeweranuoyaController.ClgType.Extreme and NeweranuoyaConfig.instance:getExtStageCfg(activityId, floorId, stageId) or NeweranuoyaConfig.instance:getNormalStageCfg(activityId, stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = NeweranuoyaConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = NeweranuoyaConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._lockPetRaceIdMap = nil

	local info = NeweranuoyaModel.instance:getInfo(self._activityId)

	if self._clgType == NeweranuoyaController.ClgType.Extreme then
		self._lockPetRaceIdMap = NeweranuoyaModel.instance:getBanRaceIdMap(activityId, self._floorId)
	end
end

function NeweranuoyaFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = ""
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function NeweranuoyaFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		if self._clgType == NeweranuoyaController.ClgType.Extreme then
			NewEraNuoYaAgent.instance:sendPM_NewEraNuoYaExtChallengeReq(self._activityId, form, self._floorId, self._stageId)
		else
			NewEraNuoYaAgent.instance:sendPM_NewEraNuoYaCommonChallengeReq(self._activityId, self._stageId, form)
		end
	end

	self:setFightHandler(handler, nil)
end

function NeweranuoyaFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function NeweranuoyaFmtMo:getFmtInfoConfig()
	return self._masterData
end

function NeweranuoyaFmtMo:getStageCfg()
	return self._stageCfg
end

function NeweranuoyaFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._lockPetRaceIdMap and self._lockPetRaceIdMap[petMo.raceId]
end

function NeweranuoyaFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("此精灵已锁定")
end

return NeweranuoyaFmtMo
