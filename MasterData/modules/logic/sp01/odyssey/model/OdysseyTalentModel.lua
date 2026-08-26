-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyTalentModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyTalentModel", package.seeall)

local OdysseyTalentModel = class("OdysseyTalentModel", BaseModel)

function OdysseyTalentModel:onInit()
	self:reInit()
end

function OdysseyTalentModel:reInit()
	self.curTalentPoint = 0
	self.levelAddTalentPoint = 0
	self.rewardAddTalentPoint = 0
	self.talentNodeMap = {}
	self.talentTypeNodeMap = {}
	self.curSelectNodeId = 0
end

function OdysseyTalentModel:resetTalentData()
	self.levelAddTalentPoint = 0
	self.rewardAddTalentPoint = 0
	self.talentNodeMap = {}
	self.talentTypeNodeMap = {}
	self.curSelectNodeId = 0
end

function OdysseyTalentModel:updateTalentInfo(talentInfo)
	self.curTalentPoint = talentInfo.point

	for _, nodeInfo in ipairs(talentInfo.nodes) do
		self:updateTalentNode(nodeInfo)
	end

	self:buildTalentTypeNodeMap()
	self:setCassandraTreeInfoStr(talentInfo.cassandraTree)
	self:setNodeChild()
end

function OdysseyTalentModel:updateTalentNode(nodeInfo)
	local talentNodeMo = self.talentNodeMap[nodeInfo.id]

	if not talentNodeMo then
		talentNodeMo = OdysseyTalentNodeMo.New()

		talentNodeMo:init(nodeInfo.id)

		self.talentNodeMap[nodeInfo.id] = talentNodeMo
	end

	talentNodeMo:updateInfo(nodeInfo)
end

function OdysseyTalentModel:buildTalentTypeNodeMap()
	self.talentTypeNodeMap = {}

	for _, talentNodeMo in pairs(self.talentNodeMap) do
		if talentNodeMo.level > 0 and talentNodeMo.config then
			local talentType = talentNodeMo.config.type

			self.talentTypeNodeMap[talentType] = self.talentTypeNodeMap[talentType] or {}
			self.talentTypeNodeMap[talentType][talentNodeMo.id] = talentNodeMo
		end
	end
end

function OdysseyTalentModel:setNodeChild()
	self:cleanNotLevelUpTalentNode()

	for _, talentNodeMo in pairs(self.talentNodeMap) do
		local talentEffectList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(talentNodeMo.id)
		local unlockConditionStr = talentEffectList[1].unlockCondition

		if not string.nilorempty(unlockConditionStr) then
			local unlockConditionList = GameUtil.splitString2(unlockConditionStr)

			for _, unlockConditionData in ipairs(unlockConditionList) do
				if unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
					local talentNodeId = tonumber(unlockConditionData[2])
					local preTalentNodeMo = self.talentNodeMap[talentNodeId]

					if preTalentNodeMo then
						preTalentNodeMo:setChildNode(talentNodeMo)
					end
				end
			end
		end
	end
end

function OdysseyTalentModel:cleanNotLevelUpTalentNode()
	for _, talentNodeMo in pairs(self.talentNodeMap) do
		talentNodeMo:cleanChildNodes()

		if talentNodeMo.level == 0 and talentNodeMo.consume == 0 then
			self.talentNodeMap[talentNodeMo.id] = nil
		end
	end
end

function OdysseyTalentModel:checkTalentCanUnlock(nodeId)
	local talentEffectList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(nodeId)
	local unlockConditionStr = talentEffectList[1].unlockCondition

	if string.nilorempty(unlockConditionStr) then
		return true
	end

	local unlockConditionList = GameUtil.splitString2(unlockConditionStr)

	for index, unlockConditionData in ipairs(unlockConditionList) do
		if unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentType then
			local talentType, needConsumeCount = tonumber(unlockConditionData[2]), tonumber(unlockConditionData[3])
			local consumeCount = self:getTalentConsumeCount(talentType)

			if consumeCount < needConsumeCount then
				return false, unlockConditionData
			end
		elseif unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
			local talentNodeId = tonumber(unlockConditionData[2])

			if not self.talentNodeMap[talentNodeId] then
				return false, unlockConditionData
			end
		end
	end

	return true
end

function OdysseyTalentModel:getTalentConsumeCount(typeId)
	local count = 0

	if not self.talentTypeNodeMap[typeId] then
		for _, talentNodeMo in pairs(self.talentTypeNodeMap[typeId]) do
			if talentNodeMo and talentNodeMo.consume > 0 then
				count = count + talentNodeMo.consume
			end
		end

		return count
	end
end

function OdysseyTalentModel:getTalentMo(nodeId)
	return self.talentNodeMap[nodeId]
end

function OdysseyTalentModel:setCurTalentPoint(curPoint, reason)
	if reason == OdysseyEnum.Reason.LevelUp then
		self.levelAddTalentPoint = self.levelAddTalentPoint + (curPoint - self.curTalentPoint)
	elseif OdysseyEnum.GetItemPushReason[reason] then
		self.rewardAddTalentPoint = self.rewardAddTalentPoint + (curPoint - self.curTalentPoint)
	end

	self.curTalentPoint = curPoint
end

function OdysseyTalentModel:getRewardAddTalentPoint()
	return self.rewardAddTalentPoint
end

function OdysseyTalentModel:getLevelAddTalentPoint()
	return self.levelAddTalentPoint
end

function OdysseyTalentModel:getCurTalentPoint()
	return self.curTalentPoint
end

function OdysseyTalentModel:cleanChangeTalentPoint()
	self.levelAddTalentPoint = 0
	self.rewardAddTalentPoint = 0
end

function OdysseyTalentModel:setCurselectNodeId(nodeId)
	self.curSelectNodeId = nodeId
end

function OdysseyTalentModel:getCurSelectNodeId()
	return self.curSelectNodeId
end

function OdysseyTalentModel:setCassandraTreeInfoStr(treeStr)
	self.cassandraTreeInfoStr = treeStr
end

function OdysseyTalentModel:setTrialCassandraTreeInfo()
	self.skillTalentMo = self.skillTalentMo or CharacterExtraSkillTalentMO.New()

	local trialHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local trialHeroId = tonumber(trialHeroConstCo.value)
	local trialHeroCo = lua_hero_trial.configDict[trialHeroId][0]
	local heroMo = HeroGroupTrialModel.instance:getHeroMo(trialHeroCo)

	if heroMo then
		self.skillTalentMo:refreshMo(self.cassandraTreeInfoStr, heroMo)
	end
end

function OdysseyTalentModel:getTrialCassandraTreeInfo()
	return self.skillTalentMo
end

function OdysseyTalentModel:isHasTalentNode()
	return tabletool.len(self.talentNodeMap) > 0
end

function OdysseyTalentModel:checkLvDownHasNotAccordLightNumNode(curSelectNodeId)
	local curTalentMo = self:getTalentMo(curSelectNodeId)

	if not curTalentMo or curTalentMo.level == 0 or not curTalentMo.config then
		return false
	end

	local typeId = curTalentMo.config.type

	if not self.talentTypeNodeMap[typeId] then
		local curTalentNodeLayer = math.ceil(curTalentMo.config.position / 2)

		for _, talentNodeMo in pairs(self.talentTypeNodeMap[typeId]) do
			if talentNodeMo.level > 0 and talentNodeMo.config then
				local nodeLayer = math.ceil(talentNodeMo.config.position / 2)

				if curTalentNodeLayer < nodeLayer and nodeLayer > 1 then
					local lowLayerConsume = self:getCurTalentAllLowLayerTalentConsume(talentNodeMo)
					local tempCosumeNum = lowLayerConsume - curTalentMo.config.consume

					if not string.nilorempty(talentNodeMo.config.unlockCondition) then
						local unlockConditionList = GameUtil.splitString2(talentNodeMo.config.unlockCondition)

						for index, unlockConditionData in ipairs(unlockConditionList) do
							if unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentType then
								local talentType, needConsumeCount = tonumber(unlockConditionData[2]), tonumber(unlockConditionData[3])

								if tempCosumeNum < needConsumeCount then
									return true
								end
							end
						end
					end
				end
			end
		end

		return false
	end
end

function OdysseyTalentModel:getCurTalentAllLowLayerTalentConsume(curTalentMo)
	local curLayer = math.ceil(curTalentMo.config.position / 2)

	if not self.talentTypeNodeMap[curTalentMo.config.type] then
		local consumeNum = 0

		for _, talentNodeMo in pairs(self.talentTypeNodeMap[curTalentMo.config.type]) do
			if talentNodeMo.level > 0 and talentNodeMo.config then
				local nodeLayer = math.ceil(talentNodeMo.config.position / 2)

				if nodeLayer < curLayer and talentNodeMo.id ~= curTalentMo.id then
					consumeNum = consumeNum + talentNodeMo.consume
				end
			end
		end

		return consumeNum
	end
end

function OdysseyTalentModel:isTalentUnlock()
	local level = OdysseyModel.instance:getHeroCurLevelAndExp()

	if level == nil then
		return false
	end

	local constConfig = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TalentUnlockLevel)
	local data = string.split(constConfig.value, "#")
	local unlockLevel = tonumber(data[2])

	return unlockLevel ~= nil and unlockLevel <= level
end

function OdysseyTalentModel:checkHasNotUsedTalentPoint()
	return self.curTalentPoint > 0
end

OdysseyTalentModel.instance = OdysseyTalentModel.New()

return OdysseyTalentModel
