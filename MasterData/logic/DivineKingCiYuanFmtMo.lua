-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/model/DivineKingCiYuanFmtMo.lua

module("logic.extensions.divinekingciyuan.model.DivineKingCiYuanFmtMo", package.seeall)

local DivineKingCiYuanFmtMo = class("DivineKingCiYuanFmtMo", BaseCustomFmtMo)

function DivineKingCiYuanFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._activityType = DivineKingCiYuanController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self.activityId)
	self._lockedRaceMap = {}

	local lockRaceIds = DivineKingCiYuanModel.instance:getLockRaceIds(activityId, phaseId)

	for _, raceId in ipairs(lockRaceIds) do
		self._lockedRaceMap[raceId] = true
	end

	local groupCfg = DivineKingCiYuanConfig.instance:getStageCfg(activityId, phaseId, stageId) or {}

	self.creepsMasterId = groupCfg.creepsMasterId
	self.masterCfg = DivineKingCiYuanConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = DivineKingCiYuanConfig.instance:getCreepsCfgsById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "DivineKingCiYuanFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function DivineKingCiYuanFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineKingCiYuanFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineKingCiYuanFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self.activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineKingCiYuanController.instance:sendStartFight(self.activityId, self.phaseId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function DivineKingCiYuanFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local isOnlySupport = false
	local formationMo = self:getCurFormation()
	local pets = formationMo:getHasPets()

	if #pets == 1 then
		local petId = pets[1]
		local petMo = self:getPetMoById(petId)

		if petMo and petMo.isSupportedPet then
			isOnlySupport = true
		end
	end

	if isOnlySupport then
		FloatWordMgr.instance:show("需要上阵更多精灵才能开始挑战")

		return true
	else
		return DivineKingCiYuanFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

function DivineKingCiYuanFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getBagPets()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineKingCiYuanFmtMo:getFixedPosList()
	return self._fixPosList
end

function DivineKingCiYuanFmtMo:getExtendViewName()
	return nil
end

function DivineKingCiYuanFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function DivineKingCiYuanFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return DivineKingCiYuanFmtMo
