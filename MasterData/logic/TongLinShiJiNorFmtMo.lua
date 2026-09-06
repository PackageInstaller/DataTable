-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/model/TongLinShiJiNorFmtMo.lua

module("logic.extensions.tonglinshiji.model.TongLinShiJiNorFmtMo", package.seeall)

local TongLinShiJiNorFmtMo = class("TongLinShiJiNorFmtMo", BaseCustomFmtMo)

function TongLinShiJiNorFmtMo:onReset()
	TongLinShiJiNorFmtMo.super.onReset(self)
end

function TongLinShiJiNorFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = TongLinShiJiConfig.instance:GetNorCreepsId(activityId, stageId)
	self._masterData = TongLinShiJiConfig.instance:getJiMonsterData(self._creepsMasterId)
	self._creepsCfg = TongLinShiJiConfig.instance:getJiCreepsData(self._creepsMasterId)
end

function TongLinShiJiNorFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.useMaxFightPower = true

	self:setFormCondition(self._masterData.formCondition)
end

function TongLinShiJiNorFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		TongLinShiJiController.instance:sendPM_JiClgNormalStageReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function TongLinShiJiNorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function TongLinShiJiNorFmtMo:getFmtInfoConfig()
	return self._masterData
end

return TongLinShiJiNorFmtMo
