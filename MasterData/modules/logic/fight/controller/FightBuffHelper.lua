-- chunkname: @modules/logic/fight/controller/FightBuffHelper.lua

module("modules.logic.fight.controller.FightBuffHelper", package.seeall)

local FightBuffHelper = _M

function FightBuffHelper.isStoneBuff(buff_id)
	return FightConfig.instance:hasBuffFeature(buff_id, FightEnum.BuffType_Petrified)
end

function FightBuffHelper.isDizzyBuff(buff_id)
	return FightConfig.instance:hasBuffFeature(buff_id, FightEnum.BuffType_Dizzy)
end

function FightBuffHelper.isSleepBuff(buff_id)
	return FightConfig.instance:hasBuffFeature(buff_id, FightEnum.BuffType_Sleep)
end

function FightBuffHelper.isFrozenBuff(buff_id)
	return FightConfig.instance:hasBuffFeature(buff_id, FightEnum.BuffType_Frozen)
end

function FightBuffHelper.isDormantBuff(buff_id)
	local buff_config = lua_skill_buff.configDict[buff_id]

	if buff_config and buff_config.typeId == 8241 then
		return true
	end

	return false
end

function FightBuffHelper.canPlayDormantBuffAni(actEffectData, fightStepData)
	local buff = actEffectData.buff

	if not FightBuffHelper.isDormantBuff(buff.buffId) then
		return
	end

	local entity_mo = FightDataHelper.entityMgr:getById(actEffectData.targetId)

	if not entity_mo then
		return
	end

	local had_buff = 0
	local buffDic = entity_mo:getBuffDic()

	for i, v in pairs(buffDic) do
		if FightBuffHelper.isDormantBuff(v.buffId) then
			had_buff = had_buff + 1

			break
		end
	end

	local origin_sign = had_buff

	for i, v in ipairs(fightStepData.actEffect) do
		if v.buff and FightBuffHelper.isDormantBuff(v.buff.buffId) then
			if v.effectType == FightEnum.EffectType.BUFFADD then
				had_buff = had_buff + 1
			elseif v.effectType == FightEnum.EffectType.BUFFDEL then
				had_buff = had_buff - 1
			elseif v.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				had_buff = had_buff - 1
			end
		end
	end

	if origin_sign ~= had_buff then
		return 2
	end
end

function FightBuffHelper.simulateBuffList(entityMO, endCardOp)
	if not entityMO then
		return {}
	end

	local buffList = entityMO and entityMO:getBuffList()
	local ops = FightDataHelper.operationDataMgr:getOpList()

	for _, op in ipairs(ops) do
		if op:isPlayCard() then
			if endCardOp and endCardOp == op then
				break
			end

			if op.clientSimulateCanPlayCard then
				local skillCO = lua_skill.configDict[op.skillId]

				for i = 1, FightEnum.MaxBehavior do
					local condition = skillCO["condition" .. i]
					local behavior = skillCO["behavior" .. i]
					local behaviorTarget = skillCO["behaviorTarget" .. i]
					local conditionTarget = skillCO["conditionTarget" .. i]

					if FightBuffHelper.checkCanAddBuff(condition) and not string.nilorempty(behavior) then
						local targetType = behaviorTarget

						if behaviorTarget == "0" then
							targetType = skillCO.logicTarget
						elseif behaviorTarget == "999" then
							targetType = conditionTarget ~= "0" and conditionTarget or skillCO.logicTarget
						end

						FightBuffHelper.simulateSkillehavior(entityMO, op, behavior, targetType, buffList)
					end
				end
			end
		end
	end

	return buffList
end

function FightBuffHelper.checkCanAddBuff(condition)
	if string.nilorempty(condition) then
		return
	end

	local condition, count = string.gsub(condition, "[!！]", "")
	local state = FightBuffHelper.__checkCanAddBuff(condition)

	if count > 0 then
		return not state
	end

	return state
end

function FightBuffHelper.__checkCanAddBuff(condition)
	local arr = FightStrUtil.instance:getSplitCache(condition, "&")

	if #arr > 1 then
		local count = 0

		for i, v in ipairs(arr) do
			if FightBuffHelper.checkSingleConditionCanAddBuff(v) then
				count = count + 1
			end
		end

		if count == #arr then
			return true
		end
	else
		arr = FightStrUtil.instance:getSplitCache(condition, "|")

		if #arr > 1 then
			for i, v in ipairs(arr) do
				if FightBuffHelper.checkSingleConditionCanAddBuff(v) then
					return true
				end
			end
		elseif FightBuffHelper.checkSingleConditionCanAddBuff(condition) then
			return true
		end
	end
end

function FightBuffHelper.checkSingleConditionCanAddBuff(condition)
	local sp = FightStrUtil.instance:getSplitCache(condition, "#")
	local typeId = tonumber(sp[1])
	local conditionCO = lua_skill_behavior_condition.configDict[typeId]

	if not conditionCO or string.nilorempty(conditionCO.type) then
		return false
	end

	if conditionCO.type == "None" then
		return true
	end
end

function FightBuffHelper.simulateSkillehavior(entityMO, op, behavior, targetType, buffList)
	local sp = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
	local behaviorId = sp[1]
	local behaviorCO = lua_skill_behavior.configDict[behaviorId]
	local needBehavior = false

	if FightEnum.LogicTargetClassify.Special[targetType] then
		-- block empty
	elseif FightEnum.LogicTargetClassify.Single[targetType] then
		if op.toId == entityMO.id then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[targetType] then
		if op.toId == entityMO.id then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[targetType] then
		if entityMO.side == FightEnum.EntitySide.EnemySide then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[targetType] then
		if entityMO.side == FightEnum.EntitySide.MySide then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.Me[targetType] and op.belongToEntityId == entityMO.id then
		needBehavior = true
	end

	if needBehavior and behaviorCO and behaviorCO.type == "AddBuff" then
		local buffProto = FightDef_pb.BuffInfo()

		buffProto.uid = "9999"
		buffProto.buffId = sp[2]

		local buffMO = FightBuffInfoData.New(buffProto, entityMO.id)

		table.insert(buffList, buffMO)
	end
end

function FightBuffHelper.checkCurEntityIsBeContractAndHasChannel(curEntityId)
	if FightModel.instance:isBeContractEntity(curEntityId) then
		return false
	end

	local nanaEntityId = FightModel.instance.contractEntityUid

	if nanaEntityId then
		::label_12_0::

		local nanaEntityMo = FightDataHelper.entityMgr:getById(nanaEntityId)

		return nanaEntityMo and nanaEntityMo:hasBuffFeature(FightEnum.BuffType_ContractCastChannel)
	end
end

function FightBuffHelper.hasCastChannel(entityMO, buffList)
	local entityMoName = entityMO and entityMO:getEntityName()
	local curBuffList = buffList or FightBuffHelper.simulateBuffList(entityMO)

	for i, buffMO in ipairs(curBuffList) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO then
			local feature = FightConfig.instance:hasBuffFeature(buffCO.id, FightEnum.BuffType_CastChannel)

			if feature then
				return true
			end

			feature = FightConfig.instance:hasBuffFeature(buffCO.id, FightEnum.BuffType_NoneCastChannel)

			if feature then
				return true
			end

			feature = FightConfig.instance:hasBuffFeature(buffCO.id, FightEnum.BuffType_ContractCastChannel)

			if feature then
				return true
			end
		end
	end

	if FightModel.instance:isBeContractEntity(entityMO and entityMO.uid) then
		if buffList then
			local nanaEntityId = FightModel.instance.contractEntityUid

			if nanaEntityId then
				::label_13_0::

				local nanaEntityMo = FightDataHelper.entityMgr:getById(nanaEntityId)

				buffList = FightBuffHelper.simulateBuffList(nanaEntityMo)

				if FightBuffHelper.hasFeature(nil, buffList, FightEnum.BuffType_ContractCastChannel) then
					return true
				end
			end
		elseif FightBuffHelper.checkCurEntityIsBeContractAndHasChannel(entityMO and entityMO.uid) then
			return true
		end
	end

	return false
end

function FightBuffHelper.hasFeature(entityMO, buffList, feature)
	local curBuffList = buffList or FightBuffHelper.simulateBuffList(entityMO)

	for i, buffMO in ipairs(curBuffList) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO and FightConfig.instance:hasBuffFeature(buffCO.id, feature) then
			return true
		end
	end
end

function FightBuffHelper.initPurifyHandle()
	FightBuffHelper.PurifyHandle = FightBuffHelper.PurifyHandle or {
		[FightEnum.PurifyId.Purify1] = FightBuffHelper.checkCanPurify1,
		[FightEnum.PurifyId.Purify2] = FightBuffHelper.checkCanPurify2,
		[FightEnum.PurifyId.PurifyX] = FightBuffHelper.checkCanPurifyX
	}
end

function FightBuffHelper.checkSkillCanPurifyBySkill(entityId, skillId, useSkill, buffList, userSkillEntityId)
	local useSkillCo = lua_skill.configDict[useSkill]

	if not useSkillCo then
		return false
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	buffList = buffList or FightBuffHelper.simulateBuffList(entityMO)

	if FightBuffHelper.hasCastChannel(entityMO, buffList) then
		return false
	end

	if FightBuffHelper.hasFeature(entityMO, buffList, FightEnum.BuffFeature.Dream) and not FightCardDataHelper.isBigSkill(skillId) then
		return false
	end

	for i = 1, FightEnum.MaxBehavior do
		local condition = useSkillCo["condition" .. i]
		local conditionTarget = useSkillCo["conditionTarget" .. i]

		if FightConditionHelper.checkCondition(condition, conditionTarget, userSkillEntityId, entityId) then
			local behavior = useSkillCo["behavior" .. i]

			if FightBuffHelper.checkSkillCanPurifyByBehaviour(entityId, skillId, behavior, buffList) then
				return true
			end
		end
	end

	return false
end

function FightBuffHelper.checkSkillCanPurifyByBehaviour(entityId, skillId, behavior, buffList)
	if string.nilorempty(behavior) then
		return false
	end

	FightBuffHelper.initPurifyHandle()

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	buffList = buffList or FightBuffHelper.simulateBuffList(entityMO)

	if FightBuffHelper.hasCastChannel(entityMO, buffList) then
		return false
	end

	if FightBuffHelper.hasFeature(entityMO, buffList, FightEnum.BuffFeature.Dream) and not FightCardDataHelper.isBigSkill(skillId) then
		return false
	end

	local array = tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(behavior, "#"))
	local purifyId = table.remove(array, 1)
	local purifyHandle = FightBuffHelper.PurifyHandle[purifyId]

	if purifyHandle and purifyHandle(array, buffList, entityId, skillId) then
		return true
	end

	return false
end

function FightBuffHelper.checkCanPurify1(purifyBuffTypeList, buffList, entityId, skillId)
	local newBuffList = {}

	for _, buffMO in ipairs(buffList) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO then
			local typeId = buffCO.typeId
			local buffTypeCo = lua_skill_bufftype.configDict[typeId]
			local buffType = buffTypeCo.type

			if not tabletool.indexOf(purifyBuffTypeList, buffType) then
				table.insert(newBuffList, buffMO)
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(entityId, skillId, newBuffList)
end

function FightBuffHelper.checkCanPurify2(purifyBuffIdList, buffList, entityId, skillId)
	local newBuffList = {}

	for _, buffMO in ipairs(buffList) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO and not tabletool.indexOf(purifyBuffIdList, buffCO.typeId) then
			table.insert(newBuffList, buffMO)
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(entityId, skillId, newBuffList)
end

function FightBuffHelper.checkCanPurifyX(purifyBuffTypeList, buffList, entityId, skillId)
	local purifyCount = table.remove(purifyBuffTypeList, 1)
	local newBuffList = {}
	local removeCount = 0

	for _, buffMO in ipairs(buffList) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO then
			if purifyCount <= removeCount then
				table.insert(newBuffList, buffMO)
			else
				local typeId = buffCO.typeId
				local buffTypeCo = lua_skill_bufftype.configDict[typeId]
				local buffType = buffTypeCo.type

				if not tabletool.indexOf(purifyBuffTypeList, buffType) then
					table.insert(newBuffList, buffMO)
				else
					removeCount = removeCount + 1
				end
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(entityId, skillId, newBuffList)
end

local featureOfRestrainAll = "CareerRestraint"

function FightBuffHelper.restrainAll(entityId)
	local entity = FightHelper.getEntity(entityId)
	local entityMO = entity and entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, buffMO in pairs(buffDic) do
			if FightConfig.instance:hasBuffFeature(buffMO.buffId, featureOfRestrainAll) then
				return true
			end
		end
	end
end

local featureOfNotRestrainAll = "NonCareerRestraint"

function FightBuffHelper.notRestrainAll(entityId)
	local entity = FightHelper.getEntity(entityId)
	local entityMO = entity and entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, buffMO in pairs(buffDic) do
			if FightConfig.instance:hasBuffFeature(buffMO.buffId, featureOfNotRestrainAll) then
				return true
			end
		end
	end
end

function FightBuffHelper.isIncludeType(buffId, includeType)
	local buffConfig = lua_skill_buff.configDict[buffId]

	if buffConfig then
		local buff_type_config = lua_skill_bufftype.configDict[buffConfig.typeId]

		if buff_type_config then
			local tab = FightStrUtil.instance:getSplitCache(buff_type_config.includeTypes, "#")

			if includeType == tab[1] then
				return true
			end
		end
	end
end

function FightBuffHelper.filterHuanZhuangShuiXingBuff(entityId, buffList)
	if not buffList then
		return {}
	end

	local entity = FightHelper.getEntity(entityId)

	if entity then
		local entityMO = entity:getMO()

		if entityMO and entityMO.modelId ~= 3095 then
			for i = #buffList, 1, -1 do
				local buffMO = buffList[i]

				if buffMO and (buffMO.buffId == 30950111 or buffMO.buffId == 30950112 or buffMO.buffId == 30950113) then
					table.remove(buffList, i)
				end
			end
		end
	end

	return buffList
end

function FightBuffHelper.filterBuffType(buffList, filterKey)
	for i = #buffList, 1, -1 do
		local buffMO = buffList[i]

		if buffMO and filterKey[buffMO.type] then
			table.remove(buffList, i)
		end
	end

	return buffList
end

function FightBuffHelper.getTransferExPointUid(entityMo)
	if not entityMo then
		return
	end

	local buffDic = entityMo:getBuffDic()

	if not buffDic then
		return
	end

	for _, buffMO in pairs(buffDic) do
		local buffId = buffMO.buffId
		local featuresSplit = entityMo:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				local buffActCO = lua_buff_act.configDict[oneFeature[1]]

				if buffActCO and buffActCO.type == FightEnum.BuffType_TransferAddExPoint then
					return buffMO.fromUid
				end
			end
		end
	end
end

function FightBuffHelper.isCountContinueChanelBuff(buffMo)
	if not buffMo then
		return false
	end

	return FightConfig.instance:hasBuffFeature(buffMo.buffId, FightEnum.BuffType_CountContinueChannel)
end

function FightBuffHelper.hasCantAddExPointFeature(buffId)
	if FightConfig.instance:hasBuffFeature(buffId, FightEnum.ExPointCantAdd) then
		return true
	end

	if FightConfig.instance:hasBuffFeature(buffId, FightEnum.BuffType_TransferAddExPoint) then
		return true
	end

	return false
end

function FightBuffHelper.isDuduBoneContinueChannelBuff(buffMo)
	if not buffMo then
		return false
	end

	return FightConfig.instance:hasBuffFeature(buffMo.buffId, FightEnum.BuffType_DuduBoneContinueChannel)
end

function FightBuffHelper.isDeadlyPoisonBuff(buffMo)
	if not buffMo then
		return false
	end

	return FightConfig.instance:hasBuffFeature(buffMo.buffId, FightEnum.BuffType_DeadlyPoison)
end

function FightBuffHelper.getDeadlyPoisonSignKey(buffMo)
	local buffCo = lua_skill_buff.configDict[buffMo.buffId]
	local featureList = FightStrUtil.instance:getSplitCache(buffCo.features, "#")

	return (string.format("%s_%s_%s", featureList[1], buffMo.duration, featureList[2]))
end

FightBuffHelper.KSDL_BUFF_MO_SIGN_KEY = "KSDL_BUFF_MO_SIGN_KEY"

function FightBuffHelper.getBuffMoSignKey(buffMo)
	if not buffMo then
		return ""
	end

	local buffId = buffMo.buffId
	local buffCo = lua_skill_buff.configDict[buffId]

	if not buffCo then
		return ""
	end

	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(buffId) then
		return FightBuffHelper.KSDL_BUFF_MO_SIGN_KEY
	end

	local buffTypeCo = lua_skill_bufftype.configDict[buffCo.typeId]

	if not buffTypeCo then
		return ""
	end

	if FightBuffHelper.isDeadlyPoisonBuff(buffMo) then
		return FightBuffHelper.getDeadlyPoisonSignKey(buffMo)
	end

	return buffCo.features .. "__" .. buffCo.typeId
end

function FightBuffHelper.checkPlayDuDuGuAddExPointEffect(entity)
	if not entity then
		return false
	end

	local entityMo = FightDataHelper.entityMgr:getById(entity.id)

	if not entityMo then
		return false
	end

	local hasType = entityMo:hasBuffTypeId(31040003)

	if not hasType then
		return false
	end

	return entityMo:hasBuffFeature(FightEnum.BuffType_UseCardFixExPoint) or entityMo:hasBuffFeature(FightEnum.BuffType_ExPointCardMove)
end

function FightBuffHelper.getFeatureList(buffCo, featureType)
	if not buffCo then
		return
	end

	local features = buffCo.features
	local featureList = FightStrUtil.instance:getSplitCache(features, "|")

	for _, feature in ipairs(featureList) do
		local array = FightStrUtil.instance:getSplitCache(feature, "#")
		local featureId = tonumber(array[1])
		local featureCo = featureId and lua_buff_act.configDict[featureId]

		if featureCo and featureCo.type == featureType then
			return array
		end
	end
end

FightBuffHelper.TempKSDLBuffList = {}

function FightBuffHelper.getKSDLSpecialBuffList(buffMo)
	local buffList = FightBuffHelper.TempKSDLBuffList

	tabletool.clear(buffList)

	local entityId = buffMo.entityId

	if entityId then
		::label_35_0::

		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		if not entityMo then
			return buffList
		end

		buffList = entityMo:getBuffList(buffList)

		for i = #buffList, 1, -1 do
			buffMo = buffList[i]

			if not FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(buffList[i].buffId) then
				table.remove(buffList, i)
			end
		end

		table.sort(buffList, FightBuffHelper.sortKSDLBuffList)

		return buffList
	end
end

function FightBuffHelper.sortKSDLBuffList(a, b)
	local rankA = FightHeroSpEffectConfig.instance:getKSDLSpecialBuffRank(a.buffId)
	local rankB = FightHeroSpEffectConfig.instance:getKSDLSpecialBuffRank(b.buffId)

	return rankA < rankB
end

return FightBuffHelper
