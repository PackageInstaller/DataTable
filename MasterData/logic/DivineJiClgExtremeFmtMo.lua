-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/model/DivineJiClgExtremeFmtMo.lua

module("logic.extensions.divinejiclg.model.DivineJiClgExtremeFmtMo", package.seeall)

local DivineJiClgExtremeFmtMo = class("DivineJiClgExtremeFmtMo", BaseCustomFmtMo)

function DivineJiClgExtremeFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.lockedRaceMap = {}
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self.activityId)

	local stageCfg = DivineJiClgConfig.instance:getExtremeSingleStageCfg(activityId, stageId)
	local lockedRace = DivineJiClgModel.instance:getExtremeClgLockedRace(activityId) or {}

	if lockedRace then
		for i, raceId in ipairs(lockedRace) do
			self.lockedRaceMap[raceId] = true
		end
	end

	self.creepsMasterId = stageCfg.creepsMasterId
	self.creepCfg = DivineJiClgConfig.instance:getNormalCreepsCfgByCreepsId(self.creepsMasterId)
	self.masterCfg = DivineJiClgConfig.instance:getNormalCreepsMasterCfgByCreepsId(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "DivineJiClgExtremeFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function DivineJiClgExtremeFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineJiClgExtremeFmtMo:getMonsterConfigList()
	return self.creepCfg
end

function DivineJiClgExtremeFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineJiClgExtremeFmtMo:initFightHandler()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineJiClg, self.activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineJiClgController.instance:sendExtremeClgStartFight(self.activityId, self, self:getCurSimpleForm())
	end, nil)
end

function DivineJiClgExtremeFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self.lockedRaceMap[petMo.raceId])
end

function DivineJiClgExtremeFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

function DivineJiClgExtremeFmtMo:getExtendViewName()
	return ViewName.DivineJiExtremeMissionView
end

return DivineJiClgExtremeFmtMo
