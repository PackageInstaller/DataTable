-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/model/WisdomCourageClgBossFmtMo.lua

module("logic.extensions.wisdomcourageclg.model.WisdomCourageClgBossFmtMo", package.seeall)

local WisdomCourageClgBossFmtMo = class("WisdomCourageClgBossFmtMo", BaseCustomFmtMo)

function WisdomCourageClgBossFmtMo:updateCfg(activityId, bossId, isSweep)
	self._activityId = activityId
	self._bossId = bossId
	self._isSweep = isSweep

	local bossData = WisdomCourageClgConfig.instance:getBossData(self._activityId, self._bossId)

	self._creepsMasterId = bossData.creepsMasterId
	self._masterData = WisdomCourageClgConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = WisdomCourageClgConfig.instance:getCreepsCfg(self._creepsMasterId)
end

function WisdomCourageClgBossFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function WisdomCourageClgBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		WisdomCourageClgController.instance:sendPM_WisdomCourageClgBossChallengeReq(self._activityId, self._bossId, self._isSweep, simpleForm)
	end, nil)
end

function WisdomCourageClgBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function WisdomCourageClgBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

return WisdomCourageClgBossFmtMo
