-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/model/DragonDishitianFmtMo.lua

module("logic.extensions.dragondishitian.model.DragonDishitianFmtMo", package.seeall)

local DragonDishitianFmtMo = class("DragonDishitianFmtMo", BaseCustomFmtMo)

function DragonDishitianFmtMo:initParams(activityId, chapterId, stageId)
	self._activityId = activityId
	self._chapterId = chapterId
	self._stageId = stageId

	local cfg = DragonDishitianConfig.instance:getStageCfg(activityId, chapterId, stageId) or {}

	self._monsterCfg = DragonDishitianConfig.instance:getMonsterCfg(cfg.creepsMasterId)
	self._creepsCfgs = DragonDishitianConfig.instance:getCreeps(cfg.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	self.validatorDescStr = cfg.validatorDescStr
end

function DragonDishitianFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		DragonDishitianAgent.instance:sendPM_DragonDishitianChallengeReq(self._activityId, self._chapterId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function DragonDishitianFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DragonDishitianFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return DragonDishitianFmtMo
