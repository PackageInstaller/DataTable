-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/model/GuardCityFmtMo.lua

module("logic.extensions.guardcity.model.GuardCityFmtMo", package.seeall)

local GuardCityFmtMo = class("GuardCityFmtMo", ICustomFmtMo)

function GuardCityFmtMo:initParams(activityId, masterInfo, isPowerful, playerId)
	self._activityId = activityId
	self._masterUniqueId = masterInfo.masterUniqueId
	self._isPowerful = isPowerful or false
	self._playerId = playerId
	self._actCfg = GuardCityConfig.instance:getActivityCfg(activityId)
	self._creepsMasterId = masterInfo.creepsMasterId
	self._cfgEnemy = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, masterInfo.creepsMasterId)
	self._masterList = {}

	for i, v in ipairs(GuardCityConfig.instance:getCreepsCfg(masterInfo.creepsMasterId)) do
		if not masterInfo.enemyStage[v.creepsId] or masterInfo.enemyStage[v.creepsId] > 0 then
			table.insert(self._masterList, v)
		end
	end
end

function GuardCityFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function GuardCityFmtMo:initFightHandler()
	local function handler()
		local startInfo = {}

		if RoleModel.instance:getUserId() == self._playerId then
			startInfo.isMyBoss = true

			UIJumper.instance:pushOneStack(ViewName.GuardCityMainView, true, self._activityId)
			UIJumper.instance:pushOneStack(ViewName.GuardCityGameView, true, self._activityId)
		else
			startInfo.isMyBoss = false

			UIJumper.instance:pushOneStack(ViewName.GuardCityMainView, true)
			UIJumper.instance:pushOneStack(ViewName.GuardCityHelpView, true)
		end

		startInfo.activityId = self._activityId
		startInfo.attackId = self._masterUniqueId

		GuardCiytModel.instance:setBossInfoFormStart(startInfo)

		local simpleForm = self:getCurSimpleForm()
		local cost = GuardCityConfig.instance:getCommonValue("CHALLENGE_STRENGTH_COST", true)

		if self._isPowerful == true then
			cost = cost * GuardCityConfig.instance:getCommonValue("STRONG_CHALLENGE_COST_MULTIPLE", true)
		end

		GuardCityController.instance:sendPM_GuardCityChallengeReq(self._actCfg.activityId, self._playerId, self._masterUniqueId, simpleForm, self._isPowerful, self._creepsMasterId)
	end

	self:setFightHandler(handler, nil)
end

function GuardCityFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function GuardCityFmtMo:getMonsterConfigList()
	return self._masterList
end

function GuardCityFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function GuardCityFmtMo:getExtendViewName()
	return ViewName.GuardCityFmtView
end

return GuardCityFmtMo
