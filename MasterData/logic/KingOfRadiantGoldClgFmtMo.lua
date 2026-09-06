-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/model/KingOfRadiantGoldClgFmtMo.lua

module("logic.extensions.kingofradiantgoldclg.model.KingOfRadiantGoldClgFmtMo", package.seeall)

local KingOfRadiantGoldClgFmtMo = class("KingOfRadiantGoldClgFmtMo", BaseCustomFmtMo)

function KingOfRadiantGoldClgFmtMo:updateCfg(activityId, challengeId, stageId)
	self._activityId = activityId
	self._challengeId = challengeId
	self._stageId = stageId
	self._clgMo = KingOfRadiantGoldClgController.instance:getClgMo(self._activityId)

	local stageData = KingOfRadiantGoldClgConfig.instance:getStageData(activityId, challengeId, stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._masterData = KingOfRadiantGoldClgConfig.instance:getTeamData(self._creepsMasterId)
	self._creepsCfg = KingOfRadiantGoldClgConfig.instance:getCreepsCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	for _, data in ipairs(self._creepsCfg) do
		if data.isBuff and data.posId > 0 then
			self:setFixedEffectRight(data.posId, "fx_ui_jinglinggezi/fx_buff_canjinchallenge01.prefab")
		end
	end
end

function KingOfRadiantGoldClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		local result = self._clgMo:getTryResultAndTipsStartStageClg(true, self._challengeId, self._stageId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KingOfRadiantGoldClgController.instance:sendPM_KingOfRadiantGoldClgChallengeReq(self._activityId, self._challengeId, self._stageId, simpleForm)
	end, nil)
end

function KingOfRadiantGoldClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KingOfRadiantGoldClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

return KingOfRadiantGoldClgFmtMo
