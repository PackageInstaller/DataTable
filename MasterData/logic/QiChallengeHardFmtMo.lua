-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/model/QiChallengeHardFmtMo.lua

module("logic.extensions.qichallenge.model.QiChallengeHardFmtMo", package.seeall)

local QiChallengeHardFmtMo = class("QiChallengeHardFmtMo", ICustomFmtMo)

function QiChallengeHardFmtMo:initParams(activityId, extremePlanId, challengeId)
	self._activityId = activityId
	self._challengeId = challengeId

	local challengeCfg = QiChallengeConfig.instance:getHardChallengeCfg(extremePlanId, challengeId)

	self._cfgEnemy = QiChallengeConfig.instance:getCreepTeamCfg(challengeCfg.creepsMasterId)
	self._masterList = QiChallengeConfig.instance:getCreepsCfg(challengeCfg.creepsMasterId)
end

function QiChallengeHardFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.description

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function QiChallengeHardFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.QiChallengeMainView, true)
		UIJumper.instance:pushOneStack(ViewName.QiChallengeHardLevelView, true, self._activityId)

		local simpleForm = self:getCurSimpleForm()

		QiChallengeAgent.instance:sendPM_QiChallengeExtremeReq(self._activityId, self._challengeId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function QiChallengeHardFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function QiChallengeHardFmtMo:getMonsterConfigList()
	return self._masterList
end

function QiChallengeHardFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function QiChallengeHardFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

function QiChallengeHardFmtMo:updateCellTop(cell, petMo)
	local luaCls = SuppressTagCell
	local url = SuppressTagCell.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:onUpdateBlockTagActive(self._activityId, petMo:getDefineId())
	end
end

function QiChallengeHardFmtMo:getExtendViewName()
	return ViewName.QiChallengeHardFmtView
end

function QiChallengeHardFmtMo:getActivityId()
	return self._activityId
end

return QiChallengeHardFmtMo
