-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/config/HolyDragonFieldConfig.lua

module("logic.extensions.holydragonfield.config.HolyDragonFieldConfig", package.seeall)

local HolyDragonFieldConfig = class("HolyDragonFieldConfig", BaseConfig)

function HolyDragonFieldConfig:getNames()
	return {
		"holy_dragon_field_stage",
		"holy_dragon_field_support_pet",
		"holy_dragon_field_creeps",
		"holy_dragon_field_score_rank_prize_plan",
		"holy_dragon_field_boss_settle",
		"holy_dragon_field_buff",
		"holy_dragon_field_settle_type",
		"holy_dragon_field_settle_plan",
		"holy_dragon_field_activity",
		"holy_dragon_field_filed",
		"holy_dragon_field_master"
	}
end

function HolyDragonFieldConfig:handleConfig(name, content)
	if name == "holy_dragon_field_stage" then
		self._holy_dragon_field_stage = content
	elseif name == "holy_dragon_field_support_pet" then
		self._holy_dragon_field_support_pet = content
	elseif name == "holy_dragon_field_creeps" then
		self._holy_dragon_field_creeps = content
	elseif name == "holy_dragon_field_score_rank_prize_plan" then
		self._holy_dragon_field_score_rank_prize_plan = content
	elseif name == "holy_dragon_field_boss_settle" then
		self._holy_dragon_field_boss_settle = content
	elseif name == "holy_dragon_field_buff" then
		self._holy_dragon_field_buff = content
	elseif name == "holy_dragon_field_settle_type" then
		self._holy_dragon_field_settle_type = content
	elseif name == "holy_dragon_field_settle_plan" then
		self._holy_dragon_field_settle_plan = content
	elseif name == "holy_dragon_field_activity" then
		self._holy_dragon_field_activity = content
	elseif name == "holy_dragon_field_filed" then
		self._holy_dragon_field_filed = content
	elseif name == "holy_dragon_field_master" then
		self._holy_dragon_field_master = content
	end
end

function HolyDragonFieldConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function HolyDragonFieldConfig:getStageType(stageData)
	if stageData == nil then
		printError("HolyDragonFieldConfig stageData is nil")

		return HolyDragonFieldEnum.StageType.Normal
	end

	if checknumber(stageData.bossSettlePlan) > 0 then
		return HolyDragonFieldEnum.StageType.Boss
	end

	if stageData.settlePlan == nil or #stageData.settlePlan <= 0 then
		printError("HolyDragonFieldConfig normal stage settlePlan is empty", stageData.activityId, stageData.fieldId, stageData.stageId)
	end

	return HolyDragonFieldEnum.StageType.Normal
end

function HolyDragonFieldConfig:isBossStage(stageData)
	return self:getStageType(stageData) == HolyDragonFieldEnum.StageType.Boss
end

function HolyDragonFieldConfig:getStageNormalSettlePlans(stageData)
	if stageData == nil or self:getStageType(stageData) ~= HolyDragonFieldEnum.StageType.Normal then
		return {}
	end

	return stageData.settlePlan or {}
end

function HolyDragonFieldConfig:getStageBossSettlePlan(stageData)
	if stageData == nil or self:getStageType(stageData) ~= HolyDragonFieldEnum.StageType.Boss then
		return 0
	end

	return checknumber(stageData.bossSettlePlan)
end

function HolyDragonFieldConfig:getBossSettleTypeGroups(activityId, bossSettlePlan)
	local bossSettleDatas = self:getBossSettleDatas(activityId, checknumber(bossSettlePlan))
	local settleIds = {}

	for settleId, _ in pairs(bossSettleDatas or {}) do
		table.insert(settleIds, checknumber(settleId))
	end

	table.sort(settleIds)

	local groups = {}
	local groupMap = {}

	for _, settleId in ipairs(settleIds) do
		local settleData = bossSettleDatas[settleId]
		local settleType = settleData and checknumber(settleData.settleType) or 0
		local group = groupMap[settleType]

		if settleType > 0 then
			if group == nil then
				group = {
					settlePlan = checknumber(bossSettlePlan),
					settleType = settleType,
					settleTypeName = self:getSettleTypeName(activityId, settleType),
					settleTypeParam = self:getSettleTypeParam(activityId, settleType),
					dataList = {}
				}
				groupMap[settleType] = group

				table.insert(groups, group)
			end

			table.insert(group.dataList, settleData)
		end
	end

	if #groups > 2 then
		printError("HolyDragonFieldConfig boss settleType group count over limit", activityId, bossSettlePlan, #groups)

		while #groups > 2 do
			table.remove(groups)
		end
	end

	return groups
end

function HolyDragonFieldConfig:getActivityData(activityId)
	return self:_safeGet(self._holy_dragon_field_activity, activityId)
end

function HolyDragonFieldConfig:getFieldDatas(activityId)
	return self:_safeGet(self._holy_dragon_field_filed, activityId)
end

function HolyDragonFieldConfig:getFieldData(activityId, fieldId)
	return self:_safeGet(self._holy_dragon_field_filed, activityId, fieldId)
end

function HolyDragonFieldConfig:getStageDatass(activityId)
	return self:_safeGet(self._holy_dragon_field_stage, activityId)
end

function HolyDragonFieldConfig:getStageDatas(activityId, fieldId)
	return self:_safeGet(self._holy_dragon_field_stage, activityId, fieldId)
end

function HolyDragonFieldConfig:getStageData(activityId, fieldId, stageId)
	return self:_safeGet(self._holy_dragon_field_stage, activityId, fieldId, stageId)
end

function HolyDragonFieldConfig:getSupportPetDatas(supportPetPlan)
	return self:_safeGet(self._holy_dragon_field_support_pet, supportPetPlan)
end

function HolyDragonFieldConfig:getSupportPetData(supportPetPlan, creepsId)
	return self:_safeGet(self._holy_dragon_field_support_pet, supportPetPlan, creepsId)
end

function HolyDragonFieldConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._holy_dragon_field_creeps, creepsMasterId)
end

function HolyDragonFieldConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._holy_dragon_field_creeps, creepsMasterId, creepsId)
end

function HolyDragonFieldConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._holy_dragon_field_master, creepsMasterId)
end

function HolyDragonFieldConfig:getScoreRankPrizeDatass(rankPlanId)
	return self:_safeGet(self._holy_dragon_field_score_rank_prize_plan, rankPlanId)
end

function HolyDragonFieldConfig:getScoreRankPrizeDatas(rankPlanId, id)
	return self:_safeGet(self._holy_dragon_field_score_rank_prize_plan, rankPlanId, id)
end

function HolyDragonFieldConfig:getScoreRankPrizeData(rankPlanId, rank)
	local datas = self:getScoreRankPrizeDatass(rankPlanId)

	if datas then
		for rankRange, data in pairs(datas) do
			if rank >= rankRange[1] and rank <= rankRange[2] then
				return data
			end
		end
	end

	return nil
end

function HolyDragonFieldConfig:getBossSettleDatass(activityId)
	return self:_safeGet(self._holy_dragon_field_boss_settle, activityId)
end

function HolyDragonFieldConfig:getBossSettleDatas(activityId, settlePlan)
	return self:_safeGet(self._holy_dragon_field_boss_settle, activityId, settlePlan)
end

function HolyDragonFieldConfig:getBossSettleData(activityId, settlePlan, settleId)
	return self:_safeGet(self._holy_dragon_field_boss_settle, activityId, settlePlan, settleId)
end

function HolyDragonFieldConfig:getBuffDatass(activityId)
	return self:_safeGet(self._holy_dragon_field_buff, activityId)
end

function HolyDragonFieldConfig:getBuffDatas(activityId, fieldId)
	return self:_safeGet(self._holy_dragon_field_buff, activityId, fieldId)
end

function HolyDragonFieldConfig:getBuffData(activityId, fieldId, level)
	return self:_safeGet(self._holy_dragon_field_buff, activityId, fieldId, level)
end

function HolyDragonFieldConfig:getSettleTypeData(activityId, settleType)
	return self:_safeGet(self._holy_dragon_field_settle_type, activityId, checknumber(settleType))
end

function HolyDragonFieldConfig:getSettleTypeParam(activityId, settleType)
	local data = self:getSettleTypeData(activityId, settleType)

	return (data or nil) and (data.settleTypeParam or "")
end

function HolyDragonFieldConfig:getSettleTypeName(activityId, settleType)
	local data = self:getSettleTypeData(activityId, settleType)

	return (data or nil) and (data.name or "")
end

function HolyDragonFieldConfig:getSettlePlanDatass(activityId)
	return self:_safeGet(self._holy_dragon_field_settle_plan, activityId)
end

function HolyDragonFieldConfig:getSettlePlanDatas(activityId, settlePlan)
	return self:_safeGet(self._holy_dragon_field_settle_plan, activityId, settlePlan)
end

function HolyDragonFieldConfig:getSettlePlanData(activityId, settlePlan, num)
	local datas = self:getSettlePlanDatas(activityId, settlePlan)

	return MmUtil.unorderedSearchInArrayKey(datas, "num", num)
end

function HolyDragonFieldConfig:getStageSettleScore(activityId, fieldId, stageId, settleType, settleValue)
	local stageData = self:getStageData(activityId, fieldId, stageId)

	if stageData == nil then
		return 0
	end

	if self:isBossStage(stageData) then
		return self:_getBossStageSettleScore(activityId, stageData, settleType, settleValue)
	end

	return self:_getNormalStageSettleScore(activityId, stageData, settleType, settleValue)
end

function HolyDragonFieldConfig:_getNormalStageSettleScore(activityId, stageData, settleType, settleValue)
	settleType = checknumber(settleType)
	settleValue = checknumber(settleValue)

	for _, settlePlan in ipairs(self:getStageNormalSettlePlans(stageData)) do
		local settleData = self:getSettlePlanData(activityId, settlePlan, settleValue)

		if settleData and settleData.settleType == settleType then
			return checknumber(settleData.score)
		end
	end

	return 0
end

function HolyDragonFieldConfig:_getBossStageSettleScore(activityId, stageData, settleType, settleValue)
	settleType = checknumber(settleType)

	local bossSettlePlan = self:getStageBossSettlePlan(stageData)
	local bossSettleGroups = self:getBossSettleTypeGroups(activityId, bossSettlePlan)

	for _, group in ipairs(bossSettleGroups) do
		for _, settleData in ipairs(group.dataList or {}) do
			if settleData.settleType == settleType and self:_isSettleValueInRange(settleValue, settleData.leftRange, settleData.rightRange) then
				return checknumber(settleData.score)
			end
		end
	end

	return 0
end

function HolyDragonFieldConfig:_isSettleValueInRange(value, leftRange, rightRange)
	if type(leftRange) == "table" then
		rightRange = leftRange[2]
		leftRange = leftRange[1]
	end

	value = checknumber(value)
	leftRange = checknumber(leftRange)
	rightRange = checknumber(rightRange)

	return leftRange <= value and value <= rightRange
end

HolyDragonFieldConfig.instance = HolyDragonFieldConfig.New()

return HolyDragonFieldConfig
