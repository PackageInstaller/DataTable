-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/model/OriginDarkMMClgFmtMo.lua

module("logic.extensions.origindarkmmclg.model.OriginDarkMMClgFmtMo", package.seeall)

local OriginDarkMMClgFmtMo = class("OriginDarkMMClgFmtMo", BaseCustomFmtMo)

function OriginDarkMMClgFmtMo:onInit()
	OriginDarkMMClgFmtMo.super.onInit(self)
end

function OriginDarkMMClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = OriginDarkMMClgConfig.instance:getStage(self.activityId, self.stageId)

	local creepsMasterId = checknumber(self.stageCfg.creepsMasterId)

	self._cfgEnemy = OriginDarkMMClgConfig.instance:getMaster(creepsMasterId)
	self._masterList = OriginDarkMMClgConfig.instance:getCreeps(creepsMasterId)
	self.behaviourCfg = OriginDarkMMClgConfig.instance:getBehaviour(self.stageCfg.costPlanId) or {}
	self.actionPoints = OriginDarkMMClgConfig.instance:getActionPoints(self.activityId, self.stageId)
	self.actionValueData = OriginDarkMMClgModel.instance:getActionValueData(self.activityId, self.stageId) or self:_createDefaultActionValueData()

	self:_normalizeActionValueData()

	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.winId

	self:setFormCondition(self._cfgEnemy.formCondition)

	self.lockRaceIdMap = {}

	local stageCfgs = OriginDarkMMClgConfig.instance:getStages(self.activityId) or {}

	for _, stageCfg in ipairs(stageCfgs) do
		local stageInfo = OriginDarkMMClgModel.instance:getStageInfo(self.activityId, stageCfg.stageId)

		for _, raceId in ipairs((stageInfo or nil) and (stageInfo.lockRaceIds or {})) do
			self.lockRaceIdMap[raceId] = true
		end
	end
end

function OriginDarkMMClgFmtMo:_createDefaultActionValueData()
	return {
		totalActionValue = self.actionPoints,
		currentPetList = {}
	}
end

function OriginDarkMMClgFmtMo:_normalizeActionValueData()
	self.actionValueData = self.actionValueData or self:_createDefaultActionValueData()
	self.actionValueData.currentPetList = self.actionValueData.currentPetList or {}

	local assignedActionValue = 0

	for petId, actionValue in pairs(self.actionValueData.currentPetList) do
		actionValue = math.floor(tonumber(actionValue) or 0)

		if actionValue <= 0 then
			self.actionValueData.currentPetList[petId] = nil
		else
			self.actionValueData.currentPetList[petId] = actionValue
			assignedActionValue = assignedActionValue + actionValue
		end
	end

	if assignedActionValue > self.actionPoints then
		self.actionValueData = self:_createDefaultActionValueData()

		return
	end

	self.actionValueData.totalActionValue = self.actionPoints - assignedActionValue
end

function OriginDarkMMClgFmtMo:saveActionValueData(actionValueData)
	self.actionValueData = clone(actionValueData or self.actionValueData)

	self:_normalizeActionValueData()
	OriginDarkMMClgModel.instance:saveActionValueData(self.activityId, self.stageId, self.actionValueData)
end

function OriginDarkMMClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local actionList = self:getAssignActionList()

		OriginDarkMMClgAgent.instance:sendPM_OriginDarkMMClgChallengeReq(self.activityId, self.stageId, simpleForm, actionList)
	end

	self:setFightHandler(handler, nil)
end

function OriginDarkMMClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self.lockRaceIdMap[petMo.raceId] == true
end

function OriginDarkMMClgFmtMo:showForbitPetAlert(petMo)
	if self.lockRaceIdMap[petMo.raceId] == true then
		TipsFacade.instance:openCommonTips(lang("该精灵被封印"))
	end
end

function OriginDarkMMClgFmtMo:getAssignedActionValue()
	local sum = 0

	if self.actionValueData then
		if not self.actionValueData.currentPetList then
			local petList = {}

			for _, actionValue in pairs(petList) do
				sum = sum + (tonumber(actionValue) or 0)
			end

			return sum
		end
	end
end

function OriginDarkMMClgFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self.actionValueData.totalActionValue == self:getActionPoints() then
		TipsFacade.instance:openCommonTips(lang("未分配行动值"))
		OriginDarkMMClgController.instance:notifyAssignActionValue()

		return true
	end

	return OriginDarkMMClgFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function OriginDarkMMClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginDarkMMClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginDarkMMClgFmtMo:getActivityId()
	return self.activityId
end

function OriginDarkMMClgFmtMo:getStageId()
	return self.stageId
end

function OriginDarkMMClgFmtMo:getCostPlanId()
	return self.stageCfg.costPlanId
end

function OriginDarkMMClgFmtMo:getExtendViewName()
	return ViewName.OriginDarkMMClgFmtView
end

function OriginDarkMMClgFmtMo:getActionPoints()
	return self.actionPoints
end

function OriginDarkMMClgFmtMo:getStageData()
	return self.stageCfg
end

function OriginDarkMMClgFmtMo:getBehaviourData()
	return self.behaviourCfg or {}
end

function OriginDarkMMClgFmtMo:getActionValueData()
	return self.actionValueData
end

function OriginDarkMMClgFmtMo:getAssignActionList()
	local actionList = {}
	local var_22_0 = self:getCurFormation():GetPositions()

	if not var_22_0 then
		var_22_0 = {}

		local positions = var_22_0

		if not self.actionValueData.currentPetList then
			local currentPetList = {}

			for stance, petId in ipairs(positions) do
				petId = checknumber(petId)

				if petId > 0 then
					table.insert(actionList, {
						stance = stance,
						action = checknumber(currentPetList[petId])
					})
				end
			end

			return actionList
		end
	end
end

return OriginDarkMMClgFmtMo
