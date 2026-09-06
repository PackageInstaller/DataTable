-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/model/OriginaruishiclgFmtMo.lua

module("logic.extensions.originaruishiclg.model.OriginaruishiclgFmtMo", package.seeall)

local OriginaruishiclgFmtMo = class("OriginaruishiclgFmtMo", BaseCustomFmtMo)
local BuffEffPaths = {
	[1] = "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab",
	[2] = "fx_ui_jinglinggezi/fx_ui_buzhen_05.prefab"
}

function OriginaruishiclgFmtMo:initParams(activityId, stageId, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId
	self._masterData = OriginaruishiclgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginaruishiclgConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First
	self.strShowRuleFlagKey = string.format("Originaruishiclg_Rule_%s_%s", self._activityId, self._creepsMasterId)

	for _, data in ipairs(self._creepsCfg) do
		if not data.buffType then
			local buffType = 0

			if data.posId > 0 and buffType > 0 then
				local path = BuffEffPaths[buffType]

				self:setFixedEffectRight(data.posId, path)
			end
		end
	end
end

function OriginaruishiclgFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginaruishiclgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginAruishiClgAgent.instance:sendPM_OriginAruishiClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginaruishiclgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginaruishiclgFmtMo:getFmtInfoConfig()
	return self._masterData
end

return OriginaruishiclgFmtMo
