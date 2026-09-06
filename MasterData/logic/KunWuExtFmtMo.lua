-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/model/KunWuExtFmtMo.lua

module("logic.extensions.kunwu.model.KunWuExtFmtMo", package.seeall)

local KunWuExtFmtMo = class("KunWuExtFmtMo", BaseCustomFmtMo)

function KunWuExtFmtMo:onReset()
	KunWuExtFmtMo.super.onReset(self)
end

function KunWuExtFmtMo:updateCfg(activityId, phase, stageId)
	self._activityId = activityId
	self._phase = phase
	self._stageId = stageId
	self._creepsMasterId = KunWuConfig.instance:getExtCreepsId(activityId, phase, stageId)
	self._masterData = KunWuConfig.instance:getKunWuCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = KunWuConfig.instance:getKunWuCreepsData(self._creepsMasterId)
end

function KunWuExtFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function KunWuExtFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KunWuController.instance:sendPM_KunWuExtremeFightReq(self._activityId, self._phase, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KunWuExtFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KunWuExtFmtMo:getFmtInfoConfig()
	return self._masterData
end

return KunWuExtFmtMo
