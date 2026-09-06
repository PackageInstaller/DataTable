-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/model/KunWuNorFmtMo.lua

module("logic.extensions.kunwu.model.KunWuNorFmtMo", package.seeall)

local KunWuNorFmtMo = class("KunWuNorFmtMo", BaseCustomFmtMo)

function KunWuNorFmtMo:onReset()
	KunWuNorFmtMo.super.onReset(self)
end

function KunWuNorFmtMo:updateCfg(activityId, groupIdx, creepIdx)
	self._activityId = activityId
	self._creepIdx = creepIdx
	self._creepsMasterId = KunWuConfig.instance:getNorCreepsId(activityId, groupIdx, creepIdx)
	self._masterData = KunWuConfig.instance:getKunWuCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = KunWuConfig.instance:getKunWuCreepsData(self._creepsMasterId)
end

function KunWuNorFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.useMaxFightPower = true

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function KunWuNorFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KunWuController.instance:sendPM_KunWuNormalFightReq(self._activityId, self._creepIdx - 1, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KunWuNorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KunWuNorFmtMo:getFmtInfoConfig()
	return self._masterData
end

return KunWuNorFmtMo
