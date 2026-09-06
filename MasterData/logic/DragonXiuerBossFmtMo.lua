-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/model/DragonXiuerBossFmtMo.lua

module("logic.extensions.dragonxiuer.model.DragonXiuerBossFmtMo", package.seeall)

local DragonXiuerBossFmtMo = class("DragonXiuerBossFmtMo", ICustomFmtMo)

function DragonXiuerBossFmtMo:initParams(activityId)
	self._activityId = activityId

	local challengeCfg = DragonXiuerConfig.instance:getBossCfg(self._activityId)

	self._teamId = challengeCfg.bossTeamId
	self._cfgEnemy = DragonXiuerConfig.instance:getTeamCfg(self._teamId)
	self._masterList = DragonXiuerConfig.instance:getCreepsCfg(self._teamId)
end

function DragonXiuerBossFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DragonXiuerBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BattleFacade.instance:startDragonXiuerBossBattle()
		DragonXiuerController.instance:sendPM_DragonXiuerChallengeSoulModeReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DragonXiuerBossFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function DragonXiuerBossFmtMo:getMonsterConfigList()
	return self._masterList
end

function DragonXiuerBossFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DragonXiuerBossFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

return DragonXiuerBossFmtMo
