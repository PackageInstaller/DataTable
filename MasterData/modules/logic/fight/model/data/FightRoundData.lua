-- chunkname: @modules/logic/fight/model/data/FightRoundData.lua

module("modules.logic.fight.model.data.FightRoundData", package.seeall)

local FightRoundData = FightDataClass("FightRoundData")
local stringSub = string.sub
local stringByte = string.byte
local stringChar = string.char
local tableConcat = table.concat
local UnzipBuffer = SLFramework.GameUpdate.UnityZipUtil.UnzipBuffer
local fightStepFunc = FightDef_pb.FightStep

local function readInt(bytes, idx)
	local b1, b2, b3, b4 = stringByte(bytes, idx, idx + 3)
	local val = b1 * 16777216 + b2 * 65536 + b3 * 256 + b4

	return val, idx + 4
end

local function decodeStep(bytes)
	if not bytes or #bytes == 0 then
		return {}
	end

	local idx = 1
	local count, newIdx = readInt(bytes, idx)

	idx = newIdx

	local steps = {}
	local stepIndex = 1

	for _ = 1, count do
		local len

		len, idx = readInt(bytes, idx)

		local stepBytes = stringSub(bytes, idx, idx + len - 1)

		idx = idx + len

		local fightStep = fightStepFunc()

		fightStep:ParseFromString(stepBytes)

		steps[stepIndex] = fightStep
		stepIndex = stepIndex + 1
	end

	return steps
end

function FightRoundData:onConstructor(proto)
	if not proto then
		return
	end

	self.hurtMergeFlag = {}

	if proto:HasField("fightStepBytes") then
		local fightStepBytes = UnzipBuffer(proto.fightStepBytes)
		local charList = {}
		local charIndex = 1

		for i = 0, fightStepBytes.Length - 1 do
			charList[charIndex] = stringChar(fightStepBytes[i])
			charIndex = charIndex + 1
		end

		local list = decodeStep(tableConcat(charList, ""))

		self.fightStep = self:buildFightStep(list)
		proto.fightStepBytes = ""

		if isDebugBuild then
			for i = 1, #list do
				table.insert(proto.fightStep, list[i])
			end
		end
	else
		self.fightStep = self:buildFightStep(proto.fightStep)
	end

	if proto:HasField("actPoint") then
		self.actPoint = proto.actPoint
	end

	self.isFinish = proto.isFinish

	if proto:HasField("moveNum") then
		self.moveNum = proto.moveNum
	end

	self.exPointInfo = {}

	for i, v in ipairs(proto.exPointInfo) do
		table.insert(self.exPointInfo, FightExPointInfoData.New(v))
	end

	self.aiUseCards = {}
	self.entityAiUseCards = {}

	for i, v in ipairs(proto.aiUseCards) do
		local entityId = v.uid
		local data = FightCardInfoData.New(v)

		data.clientData.custom_enemyCardIndex = i
		self.entityAiUseCards[entityId] = self.entityAiUseCards[entityId] or {}

		table.insert(self.entityAiUseCards[entityId], data)
		table.insert(self.aiUseCards, data)
	end

	self.power = proto.power
	self.skillInfos = {}

	for i, v in ipairs(proto.skillInfos) do
		table.insert(self.skillInfos, FightPlayerSkillInfoData.New(v))
	end

	self.beforeCards1 = {}

	for i, v in ipairs(proto.beforeCards1) do
		table.insert(self.beforeCards1, FightCardInfoData.New(v))
	end

	self.teamACards1 = {}

	for i, v in ipairs(proto.teamACards1) do
		table.insert(self.teamACards1, FightCardInfoData.New(v))
	end

	self.beforeCards2 = {}

	for i, v in ipairs(proto.beforeCards2) do
		table.insert(self.beforeCards2, FightCardInfoData.New(v))
	end

	self.teamACards2 = {}

	for i, v in ipairs(proto.teamACards2) do
		table.insert(self.teamACards2, FightCardInfoData.New(v))
	end

	self.nextRoundBeginStep = self:buildFightStep(proto.nextRoundBeginStep)
	self.useCardList = {}

	for i, v in ipairs(proto.useCardList) do
		table.insert(self.useCardList, v)
	end

	self.curRound = proto.curRound
	self.heroSpAttributes = {}

	for i, v in ipairs(proto.heroSpAttributes) do
		table.insert(self.heroSpAttributes, FightHeroSpAttributeInfoData.New(v))
	end

	self.lastChangeHeroUid = proto.lastChangeHeroUid
end

function FightRoundData:buildFightStep(stepProtoList)
	local stepList = {}

	for i, oneStep in ipairs(stepProtoList) do
		local fightStepData = FightStepData.New(oneStep)

		table.insert(stepList, fightStepData)
	end

	return stepList
end

function FightRoundData:processRoundData()
	self.fightStep = self:processStepList(self.fightStep)
	self.nextRoundBeginStep = self:processStepList(self.nextRoundBeginStep)

	self:maskDeviceDone()
	self:buildStepDeviceInnerIndex()
	self:calculateTimelineCount()

	if FightDataHelper.fieldMgr:isRouge2() then
		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function FightRoundData:buildStepDeviceInnerIndex()
	local wrapType = FightStepData.StepType.Wrap
	local deviceType = FightEnum.ActType.DEVICE
	local innerIndex = 1

	for _, step in ipairs(self.fightStep) do
		if step.actType == deviceType then
			if step:getStepType() == wrapType then
				innerIndex = step.supportHeroId
			else
				step:setDeviceInnerIndex(innerIndex)
			end
		end
	end
end

function FightRoundData:calculateTimelineCount()
	local count = 0

	for _, stepMo in ipairs(self.fightStep) do
		if self:checkIsTimeLineStep(stepMo) then
			count = count + 1
		end
	end

	for _, stepMo in ipairs(self.nextRoundBeginStep) do
		if self:checkIsTimeLineStep(stepMo) then
			count = count + 1
		end
	end

	self.timelineCount = count
end

function FightRoundData:checkIsTimeLineStep(stepMo)
	local actType = stepMo.actType

	if actType == FightEnum.ActType.SKILL or actType == FightEnum.ActType.DEVICE then
		if FightHelper.isASFDSkill(stepMo.actId) then
			return true
		else
			local entityMo = FightDataHelper.entityMgr:getById(stepMo.fromId)
			local skinId = entityMo and entityMo.skin
			local timeline = FightConfig.instance:getSkinSkillTimeline(skinId, stepMo.actId)

			return not string.nilorempty(timeline)
		end
	end
end

function FightRoundData:maskDeviceDone()
	local deviceActType = FightEnum.ActType.DEVICE
	local count = #self.fightStep

	for i = count, 1, -1 do
		local fightStep = self.fightStep[i]

		if fightStep.actType == deviceActType then
			fightStep:setCustomDeviceDone(true)

			return
		end
	end
end

function FightRoundData:processStepList(stepList)
	self.stepIndex = 0
	self.stepList = {}
	self.effectSplitIndex = 0
	self.effectStepDeep = 0

	for i, v in ipairs(stepList) do
		self:addStep(v, FightStepData.StepType.Wrap)
	end

	return self.stepList
end

function FightRoundData:addStep(step, stepType)
	self.stepIndex = self.stepIndex + 1
	step.custom_stepIndex = self.stepIndex

	step:setStepType(stepType)
	table.insert(self.stepList, step)
	self:detectStepEffect(step.actEffect)
end

function FightRoundData:detectStepEffect(actEffect)
	local index = 1

	while actEffect[index] do
		local actEffectData = actEffect[index]

		self:processNuoDiKaUniqueDamage(actEffect, index, actEffectData)

		local hurtInfo = actEffectData.hurtInfo

		if hurtInfo then
			local flag = hurtInfo.hurtMergeFlag

			if flag ~= 0 then
				local tab = self.hurtMergeFlag[flag]

				if not tab then
					tab = {}
					tab.damage = 0
					self.hurtMergeFlag[flag] = tab
				end

				tab.damage = tab.damage + hurtInfo.damage

				if hurtInfo.critical then
					tab.critical = true
				end
			end
		end

		if actEffectData.effectType == FightEnum.EffectType.SPLITSTART then
			self.effectSplitIndex = self.effectSplitIndex + 1
		elseif actEffectData.effectType == FightEnum.EffectType.SPLITEND then
			self.effectSplitIndex = self.effectSplitIndex - 1
		end

		if actEffectData.effectType == FightEnum.EffectType.FIGHTSTEP then
			if self.effectSplitIndex > 0 then
				table.remove(actEffect, index)

				index = index - 1
				self.effectStepDeep = self.effectStepDeep + 1

				self:addStep(actEffectData.fightStep, FightStepData.StepType.Inner)

				self.effectStepDeep = self.effectStepDeep - 1
			else
				local fightStepData = actEffectData.fightStep

				if FightRoundData.needAddRoundStep(fightStepData) then
					table.remove(actEffect, index)

					index = index - 1

					self:addStep(fightStepData, FightStepData.StepType.Inner)
				else
					self:detectStepEffect(fightStepData.actEffect)
				end
			end
		elseif self.effectSplitIndex > 0 and self.effectStepDeep == 0 then
			table.remove(actEffect, index)

			index = index - 1

			local stepData = FightStepData.New()

			stepData.actType = FightEnum.ActType.EFFECT
			stepData.fromId = "0"
			stepData.toId = "0"
			stepData.actId = 0
			stepData.actEffect = {
				actEffectData
			}
			stepData.cardIndex = 0
			stepData.supportHeroId = 0
			stepData.fakeTimeline = false

			table.insert(self.stepList, stepData)
		end

		index = index + 1
	end
end

function FightRoundData:getEnemyActPoint()
	return #self.aiUseCards
end

function FightRoundData:getAIUseCardMOList()
	return self.aiUseCards
end

function FightRoundData:getEntityAIUseCardMOList(entityId)
	return self.entityAiUseCards[entityId] or {}
end

function FightRoundData.needAddRoundStep(fightStep)
	if FightHelper.isTimelineStep(fightStep) then
		return true
	end

	if fightStep.actType == FightEnum.ActType.CHANGEHERO then
		return true
	elseif fightStep.actType == FightEnum.ActType.CHANGEWAVE then
		return true
	end

	if fightStep.fakeTimeline then
		return true
	end
end

function FightRoundData:processNuoDiKaUniqueDamage(actEffect, index, actEffectData)
	if (actEffectData.effectType == FightEnum.EffectType.NUODIKARANDOMATTACK or actEffectData.effectType == FightEnum.EffectType.NUODIKATEAMATTACK) and not actEffectData.custom_nuoDiKaDamageSign then
		local configEffect = actEffectData.configEffect

		for i = #actEffect, index, -1 do
			local tempEffectData = actEffect[i]

			if tempEffectData.effectType == FightEnum.EffectType.DAMAGE and tempEffectData.configEffect == configEffect then
				tempEffectData.custom_nuoDiKaDamageSign = true
				actEffectData.hurtInfo = tempEffectData.hurtInfo
			end

			if tempEffectData.effectType == FightEnum.EffectType.SHIELD and tempEffectData.configEffect == configEffect then
				tempEffectData.custom_nuoDiKaDamageSign = true
				actEffectData.hurtInfo = tempEffectData.hurtInfo
			end
		end
	end
end

return FightRoundData
