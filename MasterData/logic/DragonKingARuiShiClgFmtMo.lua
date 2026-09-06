-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/model/DragonKingARuiShiClgFmtMo.lua

module("logic.extensions.dragonkingaruishiclg.model.DragonKingARuiShiClgFmtMo", package.seeall)

local DragonKingARuiShiClgFmtMo = class("DragonKingARuiShiClgFmtMo", ICustomFmtMo)

function DragonKingARuiShiClgFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local challengeCfg = DragonKingARuiShiClgConfig.instance:getStageCfg(self._activityId, self._stageId)

	self._cfgEnemy = DragonKingARuiShiClgConfig.instance:getTeamCfg(challengeCfg.creepsMasterId)
	self._masterList = DragonKingARuiShiClgConfig.instance:getCreepCfg(challengeCfg.creepsMasterId)
end

function DragonKingARuiShiClgFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DragonKingARuiShiClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.DragonKingARuiShiClgMainView, true, self._activityId)
		UIJumper.instance:pushOneStack(ViewName.DragonKingARuiShiClgLevelView, true, self._activityId)

		local simpleForm = self:getCurSimpleForm()

		BattleFacade.instance:startDragonKingARuiShiClg()
		DragonKingARuiShiClgAgent:sendPM_DragonKingARuiShiClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DragonKingARuiShiClgFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function DragonKingARuiShiClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function DragonKingARuiShiClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DragonKingARuiShiClgFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

function DragonKingARuiShiClgFmtMo:getExtendViewName()
	return ViewName.DragonKingARuiShiClgRuleView
end

function DragonKingARuiShiClgFmtMo:getActivityId()
	return self._activityId
end

function DragonKingARuiShiClgFmtMo:getStageId()
	return self._stageId
end

return DragonKingARuiShiClgFmtMo
