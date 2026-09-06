-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/model/OriginKingMoYanClgFmtMo.lua

module("logic.extensions.originkingmoyanclg.model.OriginKingMoYanClgFmtMo", package.seeall)

local OriginKingMoYanClgFmtMo = class("OriginKingMoYanClgFmtMo", BaseCustomFmtMo)

function OriginKingMoYanClgFmtMo:initParams(activityId, floorId, stageId, flowerCount, fireCount, unitCount)
	self.activityId = activityId
	self.floorId = floorId
	self.stageId = stageId
	self.flowerCount = flowerCount
	self.fireCount = fireCount
	self.unitCount = unitCount

	local stageCfg = OriginKingMoYanClgConfig.instance:getStageCfg(self.activityId, self.floorId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = OriginKingMoYanClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginKingMoYanClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	local fireBuffList = OriginKingMoYanClgConfig.instance:getBuffCfgWithType(activityId, 2)
	local activeBuffCfg

	for i, v in ipairs(fireBuffList) do
		if fireCount >= v.itemCount then
			activeBuffCfg = v
		end
	end

	if activeBuffCfg then
		self:setFormCondition(checknumber(activeBuffCfg.formCondition))
	else
		self:setFormCondition(self._cfgEnemy.formCondition)
	end
end

function OriginKingMoYanClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginKingMoYanClgAgent.instance:sendPM_OriginKingMoYanClgFightReq(self.activityId, self.floorId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginKingMoYanClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginKingMoYanClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginKingMoYanClgFmtMo:getExtendViewName()
	return ViewName.OriginKingMoYanClgFmtView
end

return OriginKingMoYanClgFmtMo
