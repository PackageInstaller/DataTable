-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/model/NvdiExtFmtMo.lua

module("logic.extensions.nvdi.model.NvdiExtFmtMo", package.seeall)

local NvdiExtFmtMo = class("NvdiExtFmtMo", BaseCustomFmtMo)

function NvdiExtFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self._activityType = NvdiChallengeController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self.activityId)

	local cfg = NvdiChallengeConfig.instance:getStageCfgById(activityId, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = NvdiChallengeConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = NvdiChallengeConfig.instance:getCreepsCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "NvdiExtFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true

	local info = NvdiChallengeModel.instance:getInfo(self.activityId) or {}
	local buffList = NvdiChallengeConfig.instance:getBuffCfgList(self.activityId) or {}

	self.buffIdUsed = 1
	self._lockedRaceMap = {}
	self.usingBuffMap = {}

	for i, v in ipairs(info.extremeClgStageInfo or {}) do
		if v.stageId == self.stageId then
			self.buffIdUsed = v.buffIdUsed
		end

		for j, raceId in ipairs(v.lockedRace or {}) do
			self._lockedRaceMap[raceId] = true
		end

		self.usingBuffMap[v.buffIdUsed] = true
	end

	for i, v in ipairs(buffList) do
		if self.usingBuffMap[v.buffId] == nil then
			self.buffIdUsed = v.buffId

			break
		end
	end
end

function NvdiExtFmtMo:getMonsterConfigList()
	return self.creeps
end

function NvdiExtFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function NvdiExtFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self.activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		NvdiChallengeController.instance:sendStartFightExt(self.activityId, self.stageId, self.buffIdUsed, self:getCurSimpleForm())
	end, nil)
end

function NvdiExtFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function NvdiExtFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("被封印的精灵不能上阵")
end

function NvdiExtFmtMo:getExtendViewName()
	return ViewName.NvdiextView
end

return NvdiExtFmtMo
