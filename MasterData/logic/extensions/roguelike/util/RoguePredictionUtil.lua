-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/util/RoguePredictionUtil.lua

module("logic.extensions.roguelike.util.RoguePredictionUtil", package.seeall)

local M = class("RoguePredictionUtil")
local PATTERN = RoguelikeConst.DICE_PATTERN

function M:getOriginActionRange(actionCo, attrLevel)
	local format = "<color=#ffffff>%s~%s</color>"

	return string.format(actionCo.effectDesc, string.format(format, 0, attrLevel))
end

function M:predictionRoleActionRang(roleMo, roleIndex, actionCo, attrLevel, cardEntries)
	local actionId = actionCo.id

	if not RogueMgr.instance:isInRogue() then
		return self:getOriginActionRange(actionCo, attrLevel)
	end

	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local extraPatterns = roleIndex and RogueMgr.instance:getStateMgr():getExtraPattern(roleIndex, 2) or {}
	local extraMinPatterns = roleIndex and RogueMgr.instance:getStateMgr():getExtraPattern(roleIndex, 3) or {}
	local actionCardBase = roleIndex and RoguelikeModel.instance:getCardAttrBase(actionCo.attr, roleIndex) or 0
	local cardAddBase = self:getCardEntryAdditionBase(cardEntries)
	local actionBase = actionCo.base + actionCardBase
	local actionCardRate = roleIndex and RoguelikeModel.instance:getCardAttrRate(actionCo.attr, roleIndex) / 10 or 0
	local propCount = roleMo and roleMo:getPropertyLevel(actionCo.attr) or attrLevel
	local diceResultCount = self:getPatternEffectCount(propCount + cardAddBase, extraPatterns) + self:getCardEntryAdditionCount(cardEntries)
	local minResultCount = self:getMinCalcPatternCount(propCount + cardAddBase, extraMinPatterns) + cardAddBase
	local resultOrigin = diceResultCount

	diceResultCount = diceResultCount * (1 + actionCardRate)
	minResultCount = minResultCount * (1 + actionCardRate)

	local clientPrograms = judgeModel:getCurRoleActionClientProgram(actionId)

	for k, v in pairs(clientPrograms) do
		local handler = RogueMgr.instance:getRogueFlow().judgeMgr:getRoleActionHandler(v)

		if handler then
			return handler:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
		end
	end
end

function M:getCardEntryAdditionBase(entries)
	local count = 0

	for k, v in pairs(entries or {}) do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

		if entryCo then
			local params = string.split(entryCo.effect, "#")
			local program = params[1]
			local result = RogueMgr.instance:getRogueFlow().judgeMgr:getCardEntryHandler(program):getEffectParam(entryCo)

			if result and result[1] == 2 and result[2] == "THROW_RESULT" then
				count = count + result[3]
			end
		end
	end

	return count
end

function M:getCardEntryAdditionCount(entries)
	local count = 0

	for k, v in pairs(entries or {}) do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

		if entryCo then
			local params = string.split(entryCo.effect, "#")
			local program = params[1]
			local result = RogueMgr.instance:getRogueFlow().judgeMgr:getCardEntryHandler(program):getEffectParam(entryCo)

			if result then
				if result[1] == 1 then
					if result[2] ~= RoguelikeConst.DICE_PATTERN.BLEEDING then
						count = count + result[3]
					end
				elseif result[1] == 2 then
					-- block empty
				elseif result[1] == 3 then
					-- block empty
				end
			end
		end
	end

	return count
end

function M:getCardEntryEffectDesc(entries)
	local addEntrys = {}
	local effectDescs = {}
	local resultStr = ""

	function AppendResultStr(str)
		if resultStr == "" then
			resultStr = str
		else
			resultStr = resultStr .. "\n" .. str
		end
	end

	for k, v in pairs(entries) do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

		if entryCo then
			local params = string.split(entryCo.effect, "#")
			local program = params[1]

			table.insert(effectDescs, entryCo.desc)

			local result = RogueMgr.instance:getRogueFlow().judgeMgr:getCardEntryHandler(program):getEffectParam(entryCo)

			if result then
				if result[1] == 1 or result[1] == 2 then
					addEntrys[result[2]] = addEntrys[result[2]] or {}
					addEntrys[result[2]].desc = entryCo.descFormat
					addEntrys[result[2]].count = (addEntrys[result[2]].count or 0) + result[3]
				elseif result[1] == 3 then
					AppendResultStr(entryCo.desc)
				end
			end
		end
	end

	for k, v in pairs(addEntrys) do
		AppendResultStr(string.format(v.desc, v.count))
	end

	return resultStr
end

function M:patternIsNegative(pattern)
	local isBleeding = pattern == PATTERN.BLEEDING or pattern == PATTERN.BLEEDING_2 or pattern == PATTERN.BLEEDING_3 or pattern == PATTERN.BLEEDING_4 or pattern == PATTERN.BLEEDING_5 or pattern == PATTERN.BLEEDING_6
	local isTrance = pattern == PATTERN.TRANCE or pattern == PATTERN.TRANCE_2 or pattern == PATTERN.TRANCE_3 or pattern == PATTERN.TRANCE_4 or pattern == PATTERN.TRANCE_5 or pattern == PATTERN.TRANCE_6

	return isBleeding or isTrance
end

function M:getPatternCalcCount(pattern)
	local isNegative = self:patternIsNegative(pattern)
	local level = 0

	if not isNegative then
		level = RoguelikeConst.GetPatternLevel(pattern)
	end

	return level
end

function M:getMinCalcPatternCount(diceCount, patterns)
	if #patterns == 0 then
		return 0
	end

	local temp = {}

	for k, v in pairs(patterns) do
		table.insert(temp, self:getPatternCalcCount(v))
	end

	for i = 1, diceCount do
		table.insert(temp, 1)
	end

	table.sort(temp, function(a, b)
		return a < b
	end)

	local minCount = math.floor(#patterns / (diceCount * 3))

	minCount = math.min(minCount, diceCount)

	local count = 0

	for i = 1, minCount do
		count = count + temp[i]
	end

	return count
end

function M:getPatternEffectCount(diceCount, patterns)
	local temp = {}

	for k, v in pairs(patterns) do
		table.insert(temp, self:getPatternCalcCount(v))
	end

	for i = 1, diceCount do
		table.insert(temp, 1)
	end

	table.sort(temp, function(a, b)
		return b < a
	end)

	local count = 0

	for i = 1, diceCount do
		count = count + temp[i]
	end

	return count
end

function M:showPropEffectTips(propId, roleId, roleIndex, cardId, cardIndex, callback)
	local propCo = RoguelikeConfig.instance:getPropById(propId)
	local effectIds = propCo.effectIds or {}
	local needSelectCard = false
	local needSelect = false
	local addEntryId

	for i, v in ipairs(propCo.effectIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo.program == "AddAttribute" then
			ViewMgr.instance:open(ViewName.RogueAttrUpgrade, {
				propCo,
				roleIndex,
				callback
			})

			return
		end

		local selectable = string.find(effectCo.params, "SELECTABLE")

		if selectable or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute" then
			needSelect = true
		end

		needSelectCard = needSelectCard or string.find(effectCo.params, "SELECTED_CARD")

		if needSelectCard then
			addEntryId = addEntryId or tonumber(string.split(effectCo.params, "#")[3])
		end

		if addEntryId ~= nil then
			local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)
			local qua6List = roleCo.qua6
			local roleMo

			if RogueMgr.instance:isInRogue() then
				roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)

				if roleMo ~= nil then
					qua6List = {}

					for j = 1, 6 do
						table.insert(qua6List, roleMo.roleProp:getPropertyLevel(j))
					end
				end
			end

			ViewMgr.instance:open(ViewName.RogueDiceUnlock, {
				cardId,
				qua6List,
				roleMo,
				addEntryId,
				cardIndex,
				callback
			})

			return
		end
	end

	if callback then
		callback()
	end
end

function M:getRoleCanUseProp(roleId, propId)
	if propId == nil or propId == 0 then
		return true
	end

	local propCo = RoguelikeConfig.instance:getPropById(propId)
	local effectIds = propCo.effectIds or {}
	local hasRebirth = false

	for i, v in ipairs(effectIds) do
		hasRebirth = hasRebirth or self:getEffectIsRebirth(v)
	end

	local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)
	local roleProp = roleMo.roleProp

	return hasRebirth and roleProp:getIsDeath() or not roleProp:getIsDeath()
end

function M:getRoleCanUseEffect(roleId, effectId)
	if effectId == nil or effectId == 0 then
		return true
	end

	local hasRebirth = self:getEffectIsRebirth(effectId)
	local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)
	local roleProp = roleMo.roleProp

	if hasRebirth then
		return roleProp:getIsDeath()
	else
		return not roleProp:getIsDeath()
	end
end

function M:getEffectIsRebirth(effectId)
	if effectId == nil or effectId == 0 then
		return false
	end

	local effectCo = RoguelikeConfig.instance:getEffectById(effectId)

	if effectCo and effectCo.program == "Rebirth" then
		return true
	end

	return false
end

M.instance = M.New()

return M
