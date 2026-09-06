-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/model/DragonXiuerLevelFmtMo.lua

module("logic.extensions.dragonxiuer.model.DragonXiuerLevelFmtMo", package.seeall)

local DragonXiuerLevelFmtMo = class("DragonXiuerLevelFmtMo", ICustomFmtMo)

function DragonXiuerLevelFmtMo:initParams(activityId, stageId, teamIndex)
	self._activityId = activityId
	self._stageId = stageId
	self._teamIndex = teamIndex - 1

	local challengeCfg = DragonXiuerConfig.instance:getActStageCfg(self._activityId)
	local stageCfg = challengeCfg[self._stageId]

	self._teamId = stageCfg.teams[teamIndex]
	self._cfgEnemy = DragonXiuerConfig.instance:getTeamCfg(self._teamId)
	self._masterList = DragonXiuerConfig.instance:getCreepsCfg(self._teamId)
	self._lockPetMap = DragonXiuerModel.instance:getLockPetIdsMap(activityId, stageId)
end

function DragonXiuerLevelFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DragonXiuerLevelFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DragonXiuerController.instance:sendPM_DragonXiuerChallengeDestroyModeReq(self._activityId, self._stageId, self._teamIndex, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DragonXiuerLevelFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function DragonXiuerLevelFmtMo:getMonsterConfigList()
	return self._masterList
end

function DragonXiuerLevelFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DragonXiuerLevelFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

function DragonXiuerLevelFmtMo:checkPetIsForbit(petMo)
	if self._lockPetMap[petMo:getPetId()] == true then
		return true
	else
		return false
	end
end

function DragonXiuerLevelFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) == true then
		FloatWordMgr.instance:show(lang("该精灵已在其他关卡战胜过敌阵，请选择其他精灵"))
	end
end

return DragonXiuerLevelFmtMo
