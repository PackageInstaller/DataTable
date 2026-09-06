-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/model/DivineMiMengLiClgOneFmtMo.lua

module("logic.extensions.divinemimengliclg.model.DivineMiMengLiClgOneFmtMo", package.seeall)

local DivineMiMengLiClgOneFmtMo = class("DivineMiMengLiClgOneFmtMo", BaseCustomFmtMo)

function DivineMiMengLiClgOneFmtMo:onReset()
	DivineMiMengLiClgOneFmtMo.super.onReset(self)
end

function DivineMiMengLiClgOneFmtMo:updateCfg(activityId, stageId, teamId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamId = teamId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local teamData = DivineMiMengLiClgConfig.instance:getTeamData(activityId, stageId, teamId)

	self._creepsMasterId = teamData.creepsMasterId
	self._masterData = DivineMiMengLiClgConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = DivineMiMengLiClgConfig.instance:getCreepsCfg(self._creepsMasterId)
end

function DivineMiMengLiClgOneFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineMiMengLiClgOneFmtMo:initFightHandler()
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

function DivineMiMengLiClgOneFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineMiMengLiClgOneFmtMo:getFmtInfoConfig()
	return self._masterData
end

return DivineMiMengLiClgOneFmtMo
