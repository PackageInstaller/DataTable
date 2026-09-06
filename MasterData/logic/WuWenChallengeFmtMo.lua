-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/model/WuWenChallengeFmtMo.lua

module("logic.extensions.wuwenchallenge.model.WuWenChallengeFmtMo", package.seeall)

local WuWenChallengeFmtMo = class("WuWenChallengeFmtMo", BaseCustomFmtMo)

function WuWenChallengeFmtMo:initParams(activityId, level, stageId, selectBuffList)
	self.activityId = activityId
	self.level = level
	self.stageId = stageId
	self.selectBuffList = selectBuffList
	self._stageCfg = WuWenChallengeConfig.instance:getStageCfg(self.activityId, self.level, self.stageId)
	self._cfgEnemy = WuWenChallengeConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = WuWenChallengeConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function WuWenChallengeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		WuWenClgAgent.instance:sendPM_WuWenClgFightReq(self.activityId, self.stageId, simpleForm, self.selectBuffList)
	end

	self:setFightHandler(handler, nil)
end

function WuWenChallengeFmtMo:getMonsterConfigList()
	return self._masterList
end

function WuWenChallengeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function WuWenChallengeFmtMo:checkPetIsForbit(petMo, baseCheck)
	if WuWenChallengeModel.instance:getPetRateMap(self.activityId, petMo.raceId) == 0 then
		return true
	end

	return false
end

function WuWenChallengeFmtMo:showForbitPetAlert(petMo)
	if WuWenChallengeModel.instance:getPetRateMap(self.activityId, petMo.raceId) == 0 then
		FloatWordMgr.instance:show(lang("该精灵已无阵亡"))
	end
end

function WuWenChallengeFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local petRate = WuWenChallengeModel.instance:getPetRateMap(self.activityId, petMo.raceId)

		proxy.binder:onUpdateHp(petRate / 100)
	end
end

return WuWenChallengeFmtMo
