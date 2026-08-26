-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/HedoneGameHelper.lua

module("modules.logic.versionactivity3_9.hedone.controller.HedoneGameHelper", package.seeall)

local HedoneGameHelper = _M

function HedoneGameHelper.checkAttrSubId(attrId, attrSubId, logErr)
	local isNeedSubId = HedoneConfig.instance:getHedoneAttributeIsNeedSubId(attrId)
	local valid = not isNeedSubId or attrSubId ~= nil

	if not valid and logErr then
		logError(string.format("HedoneGameHelper.checkAttrSubId error, attrId:%s need subId", attrId))
	end

	return valid, isNeedSubId
end

function HedoneGameHelper.getBuffLifeUniqueKey(buffId)
	local result
	local lifeRule = HedoneConfig.instance:getHedoneBuffLifeRule(buffId)

	if not string.nilorempty(lifeRule) then
		result = lifeRule

		local subLifeRule = HedoneConfig.instance:getHedoneBuffSubLifeRule(buffId)

		if not string.nilorempty(subLifeRule) then
			result = string.format("%s#%s", lifeRule, subLifeRule)
		end
	end

	return result
end

function HedoneGameHelper.createSkill(uid, skillId, unitMO)
	local cfg = HedoneConfig.instance:getHedoneSkillCfg(skillId, true)

	if cfg then
		return HedoneSkill.New(uid, skillId, unitMO)
	end
end

function HedoneGameHelper.createTrigger(skillUid, skillId, index)
	local skillCfg = HedoneConfig.instance:getHedoneSkillCfg(skillId, true)
	local paramKey = string.format("%s%s", HedoneGameEnum.SkillCfgKey.Param, index)
	local param = skillCfg and skillCfg[paramKey]

	if not string.nilorempty(param) then
		return HedoneTrigger.New(skillUid, skillId, index)
	end
end

function HedoneGameHelper.createEffect(skillId, effectId)
	if not effectId or effectId <= 0 then
		return
	end

	local effectType = HedoneConfig.instance:getHedoneEffectType(effectId)
	local cls = effectType and HedoneGameEnum.EffectTypeCls[effectType]

	if not cls then
		logError(string.format("HedoneGameHelper.createEffect error, no effectId:%s effectType:%s cls define", effectId, effectType))

		return
	end

	return cls.New(skillId, effectId)
end

function HedoneGameHelper.createModifierList(buffUid, buffId)
	local affectType = HedoneConfig.instance:getHedoneBuffAffectType(buffId)
	local affectParam = HedoneConfig.instance:getHedoneBuffAffectParam(buffId)

	if not affectType or not affectParam then
		return
	end

	local cls = HedoneGameEnum.BuffAffectType2ModifierCls[affectType]

	if not cls then
		logError(string.format("HedoneGameHelper.createModifierList error, no buffId:%s affectType:%s cls define", buffId, affectType))

		return
	end

	local modifierList = {}
	local paramGroups = string.split(affectParam, "|")

	for index, strParam in ipairs(paramGroups) do
		local paramArr = string.splitToNumber(strParam, "#")
		local attrId, attrSubId, modValue = paramArr[1], paramArr[2], paramArr[3]

		if not modValue then
			modValue = attrSubId
			attrSubId = nil
		end

		modifierList[#modifierList + 1] = cls.New(buffUid, buffId, index, attrId, attrSubId, modValue)
	end

	return modifierList
end

function HedoneGameHelper.getEntityMOCls(entityType)
	local moCls = HedoneGameEnum.EntityTypeMOCls[entityType]

	if not moCls then
		logError(string.format("HedoneGameHelper.getEntityMOCls error, entityType:%s no moCls define", entityType))
	end

	return moCls
end

function HedoneGameHelper.getEntityCls(entityType)
	if entityType == HedoneGameEnum.EntityType.Player then
		return
	end

	local cls = HedoneGameEnum.EntityTypeEntityCls[entityType]

	if not cls then
		logError(string.format("HedoneGameHelper.getEntityCls error, entityType:%s no cls define", entityType))
	end

	return cls
end

function HedoneGameHelper.getWeightedRandomPick(itemList, getWeightFunc)
	if not itemList or #itemList <= 0 or type(getWeightFunc) ~= "function" then
		return
	end

	local weightList = {}
	local totalWeight = 0

	for i, item in ipairs(itemList) do
		local weight = getWeightFunc(item)

		weightList[i] = weight
		totalWeight = totalWeight + weight
	end

	local index = ArcadeGameHelper.getRandomIndex(weightList, totalWeight)

	return index and itemList[index]
end

function HedoneGameHelper.getWeightedRandomPickList(itemList, pickCount, getWeightFunc, isRepeatPick)
	local result = {}

	if not itemList or #itemList <= 0 or type(getWeightFunc) ~= "function" or not pickCount or pickCount <= 0 then
		return result
	end

	local weightList = {}
	local totalWeight = 0

	for i, item in ipairs(itemList) do
		local weight = getWeightFunc(item)

		weightList[i] = weight
		totalWeight = totalWeight + weight
	end

	local remainingCount = isRepeatPick and pickCount or math.min(pickCount, #itemList)

	for _ = 1, remainingCount do
		local index = ArcadeGameHelper.getRandomIndex(weightList, totalWeight)

		if not index then
			break
		end

		result[#result + 1] = itemList[index]

		if not isRepeatPick then
			totalWeight = totalWeight - weightList[index]
			weightList[index] = 0
		end
	end

	return result
end

function HedoneGameHelper.getEffectScaleFactor(effectId, skillCaster)
	local result = HedoneGameEnum.Const.BaseScaleFactor
	local baseRange = HedoneConfig.instance:getHedoneEffectRange(effectId)

	if baseRange and baseRange ~= 0 and skillCaster then
		local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(effectId)
		local rangAttr = skillCaster:getAttrValue(HedoneGameEnum.Attribute.EffectRange, effectGroup) or 0

		result = HedoneGameEnum.Const.EffectBaseFactor + rangAttr
	end

	return result
end

function HedoneGameHelper.getTriggerPointWithParamKey(triggerPoint, param)
	return (not string.nilorempty(param) or nil) and string.format("%s#%s", tostring(triggerPoint), tostring(param))
end

function HedoneGameHelper._findTargetNearest(uidList)
	local playerPos = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.PlayerXY, false, true, "#")
	local playerX = playerPos[1]
	local bestValue, bestCandidates

	for _, uid in ipairs(uidList) do
		local mo = HedoneGameModel.instance:getEntityMO(uid)

		if mo then
			local posX = mo:getPosition()
			local distance = math.abs(playerX - posX)

			if not bestValue or distance < bestValue then
				bestValue = distance
				bestCandidates = {
					uid
				}
			elseif distance == bestValue then
				bestCandidates[#bestCandidates + 1] = uid
			end
		end
	end

	return HedoneGameHelper._findTargetRandom(bestCandidates)
end

function HedoneGameHelper._findTargetHighestHp(uidList)
	local bestValue, bestCandidates

	for _, uid in ipairs(uidList) do
		local mo = HedoneGameModel.instance:getEntityMO(uid)

		if mo then
			local hp = mo:getAttrValue(HedoneGameEnum.Attribute.Hp) or 0

			if not bestValue or bestValue < hp then
				bestValue = hp
				bestCandidates = {
					uid
				}
			elseif hp == bestValue then
				bestCandidates[#bestCandidates + 1] = uid
			end
		end
	end

	return HedoneGameHelper._findTargetRandom(bestCandidates)
end

function HedoneGameHelper._findTargetFarthest(uidList)
	local playerPos = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.PlayerXY, false, true, "#")
	local playerX = playerPos[1]
	local bestValue, bestCandidates

	for _, uid in ipairs(uidList) do
		local mo = HedoneGameModel.instance:getEntityMO(uid)

		if mo then
			local posX = mo:getPosition()
			local distance = math.abs(playerX - posX)

			if not bestValue or bestValue < distance then
				bestValue = distance
				bestCandidates = {
					uid
				}
			elseif distance == bestValue then
				bestCandidates[#bestCandidates + 1] = uid
			end
		end
	end

	return HedoneGameHelper._findTargetRandom(bestCandidates)
end

function HedoneGameHelper._findTargetMostSurround(uidList)
	local gridCache = HedoneGameHelper._buildSurroundGrid(uidList)

	if not gridCache then
		return
	end

	local bestValue, bestCandidates

	for _, uid in ipairs(uidList) do
		local count = HedoneGameHelper._countEntitiesSurround(uid, gridCache)

		if not bestValue or not bestCandidates or bestValue < count then
			bestValue = count
			bestCandidates = {
				uid
			}
		elseif count == bestValue then
			bestCandidates[#bestCandidates + 1] = uid
		end
	end

	return HedoneGameHelper._findTargetRandom(bestCandidates)
end

local _gridKeyBuf = {}

local function _makeGridKey(gridX, gridY)
	_gridKeyBuf[1] = gridX
	_gridKeyBuf[2] = "#"
	_gridKeyBuf[3] = gridY

	return table.concat(_gridKeyBuf)
end

function HedoneGameHelper._buildSurroundGrid(uidList)
	local gridCache = {}
	local rectSize = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.FindTargetRectSize, false, true)

	for _, uid in ipairs(uidList) do
		local mo = HedoneGameModel.instance:getEntityMO(uid)

		if mo then
			local x, y = mo:getPosition()
			local gridX = math.floor(x / rectSize)
			local gridY = math.floor(y / rectSize)
			local gridKey = _makeGridKey(gridX, gridY)
			local gridData = GameUtil.tabletool_checkDictTable(gridCache, gridKey)

			table.insert(gridData, uid)
		end
	end

	return gridCache
end

local SURROUND_GRID_OFFSETS = {
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	},
	{
		-1,
		0
	},
	{
		0,
		0
	},
	{
		1,
		0
	},
	{
		-1,
		1
	},
	{
		0,
		1
	},
	{
		1,
		1
	}
}

function HedoneGameHelper._countEntitiesSurround(uid, gridCache)
	local count = 0
	local mo = HedoneGameModel.instance:getEntityMO(uid)

	if not mo then
		return count
	end

	local x, y = mo:getPosition()
	local rectSize = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.FindTargetRectSize, false, true)
	local halfSide = rectSize / 2
	local minX, maxX = x - halfSide, x + halfSide
	local minY, maxY = y - halfSide, y + halfSide
	local gridX = math.floor(x / rectSize)
	local gridY = math.floor(y / rectSize)

	for _, offset in ipairs(SURROUND_GRID_OFFSETS) do
		local dx, dy = offset[1], offset[2]
		local gridKey = _makeGridKey(gridX + dx, gridY + dy)
		local gridData = gridCache[gridKey]

		if gridData then
			count = count + HedoneGameHelper._countInGrid(gridData, minX, maxX, minY, maxY)
		end
	end

	return count
end

function HedoneGameHelper._countInGrid(gridData, minX, maxX, minY, maxY)
	local count = 0

	for _, uid in ipairs(gridData) do
		local mo = HedoneGameModel.instance:getEntityMO(uid)

		if mo then
			local x, y = mo:getPosition()

			if minX <= x and x <= maxX and minY <= y and y <= maxY then
				count = count + 1
			end
		end
	end

	return count
end

function HedoneGameHelper._findTargetRandom(uidList)
	if uidList then
		if not #uidList then
			local count = 0

			if count <= 0 then
				return
			end

			local randomIndex = math.random(1, count)

			return uidList[randomIndex]
		end
	end
end

HedoneGameHelper.FindTargetHandlerDict = {
	[HedoneGameEnum.FindTargetType.Nearest] = HedoneGameHelper._findTargetNearest,
	[HedoneGameEnum.FindTargetType.HighestHp] = HedoneGameHelper._findTargetHighestHp,
	[HedoneGameEnum.FindTargetType.Farthest] = HedoneGameHelper._findTargetFarthest,
	[HedoneGameEnum.FindTargetType.MostSurround] = HedoneGameHelper._findTargetMostSurround,
	[HedoneGameEnum.FindTargetType.Random] = HedoneGameHelper._findTargetRandom
}

function HedoneGameHelper._filterAliveUidList(entityType, excludeUidDict)
	local uidList = HedoneGameModel.instance:getEntityTypeUidList(entityType)

	if not uidList or #uidList <= 0 then
		return
	end

	local excludedUidList
	local filterUidList = {}

	for _, uid in ipairs(uidList) do
		local mo = HedoneGameModel.instance:getEntityMO(uid)
		local isAlive = mo and mo:getIsAlive()

		if isAlive then
			if not excludeUidDict or not excludeUidDict[uid] then
				filterUidList[#filterUidList + 1] = uid
			else
				excludedUidList = excludedUidList or {}
				excludedUidList[#excludedUidList + 1] = uid
			end
		end
	end

	if #filterUidList <= 0 and excludedUidList then
		for uid in pairs(excludeUidDict) do
			excludeUidDict[uid] = nil
		end

		filterUidList = excludedUidList
	end

	return filterUidList
end

function HedoneGameHelper.findTarget(findTargetType, targetEntityType, excludeUidDict)
	if findTargetType == HedoneGameEnum.FindTargetType.Player then
		return HedoneGameEnum.Const.PlayerUid
	end

	local entityType = targetEntityType or HedoneGameEnum.EntityType.Monster
	local filterUidList = HedoneGameHelper._filterAliveUidList(entityType, excludeUidDict)

	if not filterUidList or #filterUidList <= 0 then
		return
	end

	local handler = HedoneGameHelper.FindTargetHandlerDict[findTargetType]

	if handler then
		local findUid = handler(filterUidList)

		if excludeUidDict and findUid then
			excludeUidDict[findUid] = true
		end

		return findUid
	else
		logError(string.format("HedoneGameHelper:findTarget error, findTargetType:%s no handler", findTargetType))
	end
end

return HedoneGameHelper
