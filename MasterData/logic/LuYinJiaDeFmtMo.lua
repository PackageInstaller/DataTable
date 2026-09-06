-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/model/LuYinJiaDeFmtMo.lua

module("logic.extensions.luyinjiade.model.LuYinJiaDeFmtMo", package.seeall)

local LuYinJiaDeFmtMo = class("LuYinJiaDeFmtMo", BaseCustomFmtMo)

function LuYinJiaDeFmtMo:onReset()
	LuYinJiaDeFmtMo.super.onReset(self)
end

function LuYinJiaDeFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = LuYinJiaDeConfig.instance:getCreepsMasterId(activityId, stageId)
	self._masterData = LuYinJiaDeConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = LuYinJiaDeConfig.instance:getCreepsData(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	local LuYinJiaDe_KEY = string.format("LuYinJiaDe_%d_%d", activityId, stageId)

	self.nEnterShowRuleFlag = GameUtil.getUserDayData(LuYinJiaDe_KEY) ~= nil and 0 or ICustomFmtMo.EEnterShowRuleFlag_Always

	GameUtil.saveUserDayData(LuYinJiaDe_KEY, 1)
	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function LuYinJiaDeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		LuYinJiaDeController.instance:sendPM_LuYinJiaDeClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function LuYinJiaDeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function LuYinJiaDeFmtMo:getFmtInfoConfig()
	return self._masterData
end

return LuYinJiaDeFmtMo
