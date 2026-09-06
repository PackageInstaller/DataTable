-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/model/DivineinfinitefutureclgFmtMo.lua

module("logic.extensions.divineinfinitefutureclg.model.DivineinfinitefutureclgFmtMo", package.seeall)

local DivineinfinitefutureclgFmtMo = class("DivineinfinitefutureclgFmtMo", BaseCustomFmtMo)

function DivineinfinitefutureclgFmtMo:initParams(activityId, gridId, creepsMasterId)
	self._activityId = activityId
	self._gridId = gridId
	self._creepsMasterId = creepsMasterId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._masterData = DivineinfinitefutureclgConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineinfinitefutureclgConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineinfinitefutureclgFmtMo:initFightHandler()
	local function handler()
		if not DivineinfinitefutureclgController.instance:checkIsInOpenTime(self._activityId) then
			local actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(self._activityId)

			FloatWordMgr.instance:show(string.format("挑战在%s开启", actCfg.openTime))
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end

		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, DivineinfinitefutureclgController.instance:getActivityType(), self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		local simpleForm = self:getCurSimpleForm()

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineInfiniteFutureClgAgent.instance:sendPM_DivineInfiniteFutureFightReq(self._activityId, self._gridId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineinfinitefutureclgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineinfinitefutureclgFmtMo:getFmtInfoConfig()
	return self._masterData
end

return DivineinfinitefutureclgFmtMo
