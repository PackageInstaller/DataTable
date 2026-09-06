-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/model/OriginAsheClgFmtMo.lua

module("logic.extensions.originasheclg.model.OriginAsheClgFmtMo", package.seeall)

local OriginAsheClgFmtMo = class("OriginAsheClgFmtMo", BaseCustomFmtMo)

function OriginAsheClgFmtMo:initParams(activityId, stageId, index)
	self.activityId = activityId
	self.stageId = stageId
	self.index = index

	local stageCfg = OriginAsheClgConfig.instance:getStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = OriginAsheClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginAsheClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	local buffCfg = OriginAsheClgConfig.instance:getBuffCfg(stageCfg.buffIds[self.index])

	self.validatorDescStr = buffCfg.des
end

function OriginAsheClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginAsheClgController.instance:sendPM_OriginAsheClgChallengeReq(self.activityId, self.stageId, self.index, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginAsheClgFmtMo:getMonsterConfigList()
	local list = {}
	local stageInfo = OriginAsheClgModel.instance:getStageInfo(self.activityId, self.stageId)
	local hpMap = {}

	if stageInfo and stageInfo.info.hpWanPercent then
		for i, v in ipairs(stageInfo.info.hpWanPercent) do
			hpMap[v.left] = v.right
		end
	end

	for i, v in ipairs(self._masterList) do
		if not hpMap[v.creepsId] or hpMap[v.creepsId] > 0 then
			table.insert(list, v)
		end
	end

	return list
end

function OriginAsheClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginAsheClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return OriginAsheClgModel.instance:isPetLock(self.activityId, self.stageId, petMo.raceId)
end

function OriginAsheClgFmtMo:showForbitPetAlert(petMo)
	if OriginAsheClgModel.instance:isPetLock(self.activityId, self.stageId, petMo.raceId) == true then
		FloatWordMgr.instance:show(lang("精灵已被封印"))
	end
end

function OriginAsheClgFmtMo:getExtendViewName()
	return ViewName.OriginAsheClgFmtView
end

return OriginAsheClgFmtMo
