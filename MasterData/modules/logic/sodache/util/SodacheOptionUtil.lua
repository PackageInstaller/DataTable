-- chunkname: @modules/logic/sodache/util/SodacheOptionUtil.lua

module("modules.logic.sodache.util.SodacheOptionUtil", package.seeall)

local SodacheOptionUtil = class("SodacheOptionUtil")

function SodacheOptionUtil:checkOption(condition)
	if string.nilorempty(condition) then
		return true
	end

	local arr = string.split(condition, "|")

	for i, v in ipairs(arr) do
		local arr2 = string.split(v, "#") or {}
		local isValid, ret = self:_checkCondition(arr2)

		if isValid then
			return isValid, ret
		end
	end

	return false
end

function SodacheOptionUtil:getOptionConditionStr(condition)
	if string.nilorempty(condition) then
		return ""
	end

	local firstDesc = ""
	local arr = string.split(condition, "|")

	for i, v in ipairs(arr) do
		local arr2 = string.split(v, "#") or {}
		local isValid = self:_checkCondition(arr2)
		local desc

		if arr2[1] == "type" then
			desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_choice_condition_type"), luaLang("sodache_cardtype_" .. arr2[2]))
		elseif arr2[1] == "subtype" then
			desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_choice_condition_subtype"), luaLang("sodache_cardsubtype_" .. arr2[2]))
		elseif arr2[1] == "card" then
			local cardCo = lua_sodache_card.configDict[tonumber(arr2[2])]

			desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_choice_condition_card"), (cardCo or nil) and (cardCo.name or "error"))
		end

		if isValid then
			return desc
		end

		if string.nilorempty(firstDesc) and not string.nilorempty(desc) then
			firstDesc = desc
		end
	end

	return firstDesc
end

function SodacheOptionUtil:_checkCondition(arr2)
	for ii, vv in ipairs(arr2) do
		arr2[ii] = tonumber(vv) or vv
	end

	local checkFunc = self["checkOption_" .. arr2[1]]

	if checkFunc then
		local isValid, ret = checkFunc(self, unpack(arr2, 2))

		if isValid then
			return isValid, ret
		end
	end
end

function SodacheOptionUtil:checkOption_card(cardId, num)
	cardId = cardId or 0
	num = num or 0

	local enough = num <= SodacheUtil.getItemCount(cardId, SodacheEnum.BagType.Inside)

	if not enough then
		return false
	end

	return true, {
		SodacheCardMo.Create(cardId).serverMo
	}
end

function SodacheOptionUtil:checkOption_subtype(subType, quality, num)
	subType = subType or 0
	quality = quality or 0
	num = num or 0

	local bag = self:getBag()

	if not bag then
		return false
	end

	local count, cards = 0, {}

	for i, v in ipairs(bag.items) do
		if v.itemCo.subType == subType and quality <= v.itemCo.quality then
			count = count + v.count

			table.insert(cards, v)
		end
	end

	return num <= count, cards
end

function SodacheOptionUtil:checkOption_type(type, quality, num)
	type = type or 0
	quality = quality or 0
	num = num or 0

	local bag = self:getBag()

	if not bag then
		return false
	end

	local count, cards = 0, {}

	for i, v in ipairs(bag.items) do
		if v.itemCo.type == type and quality <= v.itemCo.quality then
			count = count + v.count

			table.insert(cards, v)
		end
	end

	return num <= count, cards
end

function SodacheOptionUtil:checkOption_attr(attrId, mode, num)
	attrId = attrId or 0
	mode = mode or 0
	num = num or 0

	return SodacheUtil.compareNum(SodacheUtil.getAttr(attrId), mode, num)
end

function SodacheOptionUtil:getBag()
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return
	end

	return (outSideMo:getBag(SodacheEnum.BagType.Inside))
end

SodacheOptionUtil.instance = SodacheOptionUtil.New()

return SodacheOptionUtil
