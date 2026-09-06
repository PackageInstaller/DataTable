-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/model/DragonVeinNuoYaClgFmtMo.lua

module("logic.extensions.dragonveinnuoyaclg.model.DragonVeinNuoYaClgFmtMo", package.seeall)

local DragonVeinNuoYaClgFmtMo = class("DragonVeinNuoYaClgFmtMo", ICustomFmtMo)

function DragonVeinNuoYaClgFmtMo:initParams(activityId, gridId, creepsMasterId)
	self.activityId = activityId
	self.gridId = gridId
	self.creepsMasterId = creepsMasterId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self.activityId)
	self._cfgEnemy = DragonVeinNuoYaClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = DragonVeinNuoYaClgConfig.instance:getCreepsCfg(creepsMasterId)
end

function DragonVeinNuoYaClgFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc
	self.isSetEnemySimpleForm = true
	self.nEnterShowRuleFlag = not string.nilorempty(self.ruleDescStr) and ICustomFmtMo.EEnterShowRuleFlag_DailyOnce or ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = DragonVeinNuoYaClgModel.ReadFlag .. "#" .. self.activityId .. "#" .. self.creepsMasterId
	self.isPopRuleDesc = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DragonVeinNuoYaClgFmtMo:initFightHandler()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DragonVeinNuoYaClg, self.activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	local function handler()
		UIJumper.instance:pushOneStack(ViewName.DragonVeinNuoYaClgMainView, true, self.activityId)
		UIJumper.instance:pushOneStack(ViewName.DragonVeinNuoYaClgGameView, true, self.activityId)

		local simpleForm = self:getCurSimpleForm()

		DragonVeinNuoYaClgAgent.instance:sendPM_DragonVeinNuoYaClgFightReq(self.activityId, self.gridId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DragonVeinNuoYaClgFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DragonVeinNuoYaClgFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function DragonVeinNuoYaClgFmtMo:_changePetMo(petMo)
	return petMo
end

function DragonVeinNuoYaClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function DragonVeinNuoYaClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return DragonVeinNuoYaClgFmtMo
