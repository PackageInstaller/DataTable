-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/model/OriginKayaFmtMo.lua

module("logic.extensions.originkaya.model.OriginKayaFmtMo", package.seeall)

local OriginKayaFmtMo = class("OriginKayaFmtMo", BaseCustomFmtMo)

function OriginKayaFmtMo:initParams(activityId, floorId, stageId)
	self.activityId = activityId
	self.floorId = floorId
	self.stageId = stageId

	local stageCfg = OriginKayaConfig.instance:getStageCfg(self.activityId, self.floorId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self.selectSeedMap = {}
	self._cfgEnemy = OriginKayaConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginKayaConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function OriginKayaFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local useSeed = {}

		for k, v in pairs(self.selectSeedMap) do
			if v == true then
				table.insert(useSeed, k)
			end
		end

		OriginKayaAgent.instance:sendPM_OriginKayaClgReq(self.activityId, simpleForm, self.floorId, self.stageId, useSeed)
	end

	self:setFightHandler(handler, nil)
end

function OriginKayaFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginKayaFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginKayaFmtMo:getExtendViewName()
	return ViewName.OriginKayaFmtView
end

return OriginKayaFmtMo
