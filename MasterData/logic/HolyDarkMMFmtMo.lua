-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/model/HolyDarkMMFmtMo.lua

module("logic.extensions.holydarkmm.model.HolyDarkMMFmtMo", package.seeall)

local HolyDarkMMFmtMo = class("HolyDarkMMFmtMo", BaseCustomFmtMo)

function HolyDarkMMFmtMo:initParams(activityId, stageId, formPlanId, angleId, formationPosList, levelId)
	self._activityId = activityId
	self._stageId = stageId
	self._formPlanId = formPlanId
	self._angleId = angleId
	self._formationPosList = formationPosList
	self._levelId = levelId
end

function HolyDarkMMFmtMo:updateData()
	self.isShowOneKey = true

	local info = HolyDarkMMConfig.instance:getHolyDarkMMStageCfg(self._activityId, self._stageId)
	local cfg = HolyDarkMMConfig.instance:getHolyDarkMMMasterCfg(info.creepsMasterId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = info.description

	local formCfg = HolyDarkMMConfig.instance:getHolyDarkFormGroupCfg(self._formPlanId, self._angleId)

	self:setFormCondition(formCfg.formCondition)
end

function HolyDarkMMFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		HolyDarkMMController.instance:sendPM_HolyDarkMMChallengeReq(self._activityId, self._stageId, simpleForm, self._formPlanId, self._angleId)
	end

	self:setFightHandler(handler, nil)
end

function HolyDarkMMFmtMo:getMonsterConfigList()
	local info = HolyDarkMMConfig.instance:getHolyDarkMMStageCfg(self._activityId, self._stageId)

	return HolyDarkMMController.instance:filterCreepsCfg(info.creepsMasterId, self._formationPosList, self._levelId)
end

function HolyDarkMMFmtMo:getFmtInfoConfig()
	local info = HolyDarkMMConfig.instance:getHolyDarkMMStageCfg(self._activityId, self._stageId)

	return HolyDarkMMConfig.instance:getHolyDarkMMMasterCfg(info.creepsMasterId)
end

HolyDarkMMFmtMo.instance = HolyDarkMMFmtMo.New()

return HolyDarkMMFmtMo
