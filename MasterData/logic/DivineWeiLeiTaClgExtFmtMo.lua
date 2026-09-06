-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/model/DivineWeiLeiTaClgExtFmtMo.lua

module("logic.extensions.divineweileitaclg.model.DivineWeiLeiTaClgExtFmtMo", package.seeall)

local DivineWeiLeiTaClgExtFmtMo = class("DivineWeiLeiTaClgExtFmtMo", BaseCustomFmtMo)

function DivineWeiLeiTaClgExtFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self._stageCfg = DivineWeiLeiTaClgConfig.instance:getExtremeStageCfg(self.activityId, self.stageId)
	self._cfgEnemy = DivineWeiLeiTaClgConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = DivineWeiLeiTaClgConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)

	if not self._stageCfg.lockPosIds then
		self:clearAllFixedEffects()

		for _, posId in ipairs(self._stageCfg.lockPosIds) do
			self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab")
		end
	end
end

function DivineWeiLeiTaClgExtFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.winDesc
	self.validatorDescStr = self._cfgEnemy.bottomDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DivineWeiLeiTaClgExtFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgExtremeChallengeReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineWeiLeiTaClgExtFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineWeiLeiTaClgExtFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineWeiLeiTaClgExtFmtMo:checkPetIsForbit(petMo, baseCheck)
	if DivineWeiLeiTaClgModel.instance:isExtRaceLock(self.activityId, petMo.raceId) == true then
		return true
	end

	return false
end

function DivineWeiLeiTaClgExtFmtMo:showForbitPetAlert(petMo)
	if DivineWeiLeiTaClgModel.instance:getPetRateMap(self.activityId, petMo.raceId) == 0 then
		FloatWordMgr.instance:show(lang("该精灵已被封印"))
	end
end

return DivineWeiLeiTaClgExtFmtMo
