-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/model/DivineMiMengLiClgTwoFmtMo.lua

module("logic.extensions.divinemimengliclg.model.DivineMiMengLiClgTwoFmtMo", package.seeall)

local DivineMiMengLiClgTwoFmtMo = class("DivineMiMengLiClgTwoFmtMo", BaseCustomFmtMo)

function DivineMiMengLiClgTwoFmtMo:onReset()
	DivineMiMengLiClgTwoFmtMo.super.onReset(self)
end

function DivineMiMengLiClgTwoFmtMo:updateCfg(activityId, stageId, teamId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamId = teamId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local teamData = DivineMiMengLiClgConfig.instance:getTeamData(activityId, stageId, teamId)

	self._creepsMasterId = teamData.creepsMasterId
	self._tagPosId = teamData.tagPosId
	self._masterData = DivineMiMengLiClgConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = DivineMiMengLiClgConfig.instance:getCreepsCfg(self._creepsMasterId)

	self:clearAllFixedEffects()

	if self._tagPosId > 0 then
		self:setFixedEffectRight(self._tagPosId, "fx_ui_jinglinggezi/fx_ui_buzhen_05.prefab")
	end
end

function DivineMiMengLiClgTwoFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineMiMengLiClgTwoFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, DivineMiMengLiClgController.instance:getActivityType(), self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineMiMengLiClgController.instance:sendPM_DivineMiMengLiClgFightReq(self._activityId, self._stageId, self._teamId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineMiMengLiClgTwoFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineMiMengLiClgTwoFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineMiMengLiClgTwoFmtMo:getTagPosId()
	return self._tagPosId
end

return DivineMiMengLiClgTwoFmtMo
