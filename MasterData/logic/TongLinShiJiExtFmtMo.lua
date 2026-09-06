-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/model/TongLinShiJiExtFmtMo.lua

module("logic.extensions.tonglinshiji.model.TongLinShiJiExtFmtMo", package.seeall)

local TongLinShiJiExtFmtMo = class("TongLinShiJiExtFmtMo", BaseCustomFmtMo)

function TongLinShiJiExtFmtMo:updateCfg(activityId, raceType, stageId)
	self._activityId = activityId
	self._raceType = raceType
	self._stageId = stageId
	self._creepsMasterId = TongLinShiJiConfig.instance:GetExtCreepsId(self._activityId, self._raceType, self._stageId)
	self._masterData = TongLinShiJiConfig.instance:getJiMonsterData(self._creepsMasterId)
	self._creepsCfg = TongLinShiJiConfig.instance:getJiCreepsData(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function TongLinShiJiExtFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		TongLinShiJiController.instance:sendPM_JiClgExtremeStageReq(self._activityId, self._raceType, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function TongLinShiJiExtFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function TongLinShiJiExtFmtMo:getFmtInfoConfig()
	return self._masterData
end

return TongLinShiJiExtFmtMo
