-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/model/OriginFightFmtMo.lua

module("logic.extensions.originfight.model.OriginFightFmtMo", package.seeall)

local OriginFightFmtMo = class("OriginFightFmtMo", BaseCustomFmtMo)

function OriginFightFmtMo:updateCfg(activityId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)

	local godFavorCfg = OriginFightConfig.instance:getGodFavorCfgById(activityId, OriginFightController.GOD_FAVOR_ENUM.ZHI_XU)

	self._creepsMasterId = godFavorCfg.creepsMasterId
	self._masterData = OriginFightConfig.instance:getCreepMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginFightConfig.instance:getCreepsCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginFightFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginFightController.instance:sendPM_OriginFightBattleReq(self._activityId, simpleForm, OriginFightController.GOD_FAVOR_ENUM.ZHI_XU)
	end, nil)
end

function OriginFightFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginFightFmtMo:getFmtInfoConfig()
	return self._masterData
end

return OriginFightFmtMo
