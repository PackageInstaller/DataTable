-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/model/QiChallengeDailyFmtMo.lua

module("logic.extensions.qichallenge.model.QiChallengeDailyFmtMo", package.seeall)

local QiChallengeDailyFmtMo = class("QiChallengeDailyFmtMo", ICustomFmtMo)

function QiChallengeDailyFmtMo:initParams(activityId, allPlanId, challengeId)
	self._activityId = activityId
	self._challengeId = challengeId

	local challengeCfg = QiChallengeConfig.instance:getAllChallengeCfg(allPlanId, challengeId)

	self._cfgEnemy = QiChallengeConfig.instance:getCreepTeamCfg(challengeCfg.creepsMasterId)
	self._masterList = QiChallengeConfig.instance:getCreepsCfg(challengeCfg.creepsMasterId)
end

function QiChallengeDailyFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function QiChallengeDailyFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.QiChallengeMainView, true)
		UIJumper.instance:pushOneStack(ViewName.QiChallengeDailyLevelView, true, self._activityId)

		local simpleForm = self:getCurSimpleForm()

		QiChallengeAgent.instance:sendPM_QiChallengeAllReq(self._activityId, self._challengeId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function QiChallengeDailyFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function QiChallengeDailyFmtMo:getMonsterConfigList()
	return self._masterList
end

function QiChallengeDailyFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function QiChallengeDailyFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

function QiChallengeDailyFmtMo:updateCellTop(cell, petMo)
	local luaCls = BlockTagCell
	local url = BlockTagCell.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:onUpdateBlockTagActive(petMo:getDefineId())
	end
end

function QiChallengeDailyFmtMo:checkPetIsForbit(petMo)
	local usedraceids = QiChallengeModel.instance:getUsedRaceInfos()

	if not usedraceids[petMo:getDefineId()] then
		return false
	end

	return true
end

function QiChallengeDailyFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) == true then
		FloatWordMgr.instance:show(lang("该精灵已在其他关卡战胜过敌阵，请选择其他精灵"))
	end
end

return QiChallengeDailyFmtMo
