-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/model/StarHallFmtMo.lua

module("logic.extensions.starhall.model.StarHallFmtMo", package.seeall)

local StarHallFmtMo = class("StarHallFmtMo", BaseCustomFmtMo)

function StarHallFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.settleTypeId = -1
	self.diffcultId = -1
	self.settleNumber = -1

	local difficultyCfgs = StarHallConfig.instance:getStageDifficultyCfgsById(self.activityId, self.stageId)

	if difficultyCfgs[1] then
		self._masterData = StarHallConfig.instance:getTeamCfg(difficultyCfgs[1])
		self._creepsCfg = StarHallConfig.instance:getCreepCfgs(difficultyCfgs[1])
		self.helpCfgs = StarHallConfig.instance:getSupportPetCfgs(self.activityId)
		self.topTitleStr = self._masterData.name
		self.ruleDescStr = self._masterData.ruleDesc

		self:setFormCondition(self._masterData.formCondition)

		self.isHideFmtZdl = true
	end
end

function StarHallFmtMo:initFightHandler()
	local function handler()
		if self:checkCanFight() then
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

			local simpleForm = self:getCurSimpleForm()

			StarHallController.instance:startChallenge(self.activityId, self.stageId, self.diffcultId, self.settleTypeId, self.settleNumber, simpleForm)
		else
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end
	end

	self:setFightHandler(handler, nil)
end

function StarHallFmtMo:updateData()
	self:tryInitPetList()
end

function StarHallFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if self.helpCfgs then
		local fmo = self:_getFightPowerPetMo()

		for _, helpData in pairs(self.helpCfgs) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function StarHallFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function StarHallFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function StarHallFmtMo:getFmtInfoConfig()
	return self._masterData
end

function StarHallFmtMo:getExtendViewName()
	return ViewName.StarHallFmtExView
end

function StarHallFmtMo:checkCanFight()
	if self.settleNumber == -1 or self.settleTypeId == -1 or self.diffcultId == -1 then
		FloatWordMgr.instance:show("请先选择难度、结算方式与目标")

		return false
	end

	return true
end

return StarHallFmtMo
