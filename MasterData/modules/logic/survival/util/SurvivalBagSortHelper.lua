-- chunkname: @modules/logic/survival/util/SurvivalBagSortHelper.lua

module("modules.logic.survival.util.SurvivalBagSortHelper", package.seeall)

local SurvivalBagSortHelper = class("SurvivalBagSortHelper")

function SurvivalBagSortHelper.sortByInDict(a, b, dict)
	if dict[a.uid] ~= dict[b.uid] then
		return not not dict[b.uid]
	end
end

function SurvivalBagSortHelper.sortByChange(a, b)
	local exchangeA = a.co and not string.nilorempty(a.co.exchange) or false
	local exchangeB = b.co and not string.nilorempty(b.co.exchange) or false

	if exchangeA ~= exchangeB then
		return exchangeB
	end
end

function SurvivalBagSortHelper.sortByMass(a, b)
	local massA = a.co.mass
	local massB = b.co.mass

	if massA ~= massB then
		return massA < massB
	end
end

function SurvivalBagSortHelper.sortByWorth(a, b)
	local worthA = a.co.worth
	local worthB = b.co.worth

	if worthA ~= worthB then
		return worthA < worthB
	end
end

function SurvivalBagSortHelper.sortByType(a, b)
	local typeA = a.co.type
	local typeB = b.co.type

	if typeA ~= typeB then
		return typeA < typeB
	end
end

local typeFirst = {
	[SurvivalEnum.ItemType.Equip] = -3,
	[SurvivalEnum.ItemType.Material] = -2,
	[SurvivalEnum.ItemType.Quick] = -1
}

function SurvivalBagSortHelper.sortByCustomType(a, b)
	local typeA = a.co.type
	local typeB = b.co.type

	typeA = typeFirst[typeA] or typeA
	typeB = typeFirst[typeB] or typeB

	if typeA ~= typeB then
		return typeB < typeA
	end
end

function SurvivalBagSortHelper.sortByRare(a, b)
	local rareA = a.co.rare
	local rareB = b.co.rare

	if rareA ~= rareB then
		return rareA < rareB
	end
end

function SurvivalBagSortHelper.sortById(a, b)
	local idA = a.co.id
	local idB = b.co.id

	if idA ~= idB then
		return idA < idB
	end
end

function SurvivalBagSortHelper.sortByTime(a, b)
	local uidA = tonumber(a.uid) or 0
	local uidB = tonumber(b.uid) or 0

	if uidA ~= uidB then
		return uidA < uidB
	end
end

function SurvivalBagSortHelper.sortByEquipTag(a, b)
	if not a.equipCo or not b.equipCo then
		return
	end

	local tagIdA = SurvivalBagSortHelper.getFirstEquipTag(a)
	local tagIdB = SurvivalBagSortHelper.getFirstEquipTag(b)

	if tagIdA ~= tagIdB then
		return tagIdA < tagIdB
	end
end

function SurvivalBagSortHelper.sortByNPCItem(a, b)
	local aIs = a:isNPCRecommendItem()
	local bIs = b:isNPCRecommendItem()

	if aIs ~= bIs then
		return aIs
	end
end

function SurvivalBagSortHelper.getFirstEquipTag(itemMo)
	local tagStr = itemMo.equipCo.tag
	local tagId = string.match(tagStr, "^([0-9]+)")

	return tonumber(tagId) or 0
end

function SurvivalBagSortHelper.filterItemMo(filterList, itemMo)
	if not itemMo or itemMo:isEmpty() then
		return false
	end

	if not next(filterList) then
		return true
	end

	local type = itemMo.co.type

	for k, v in pairs(filterList) do
		if v.type == SurvivalEnum.ItemFilterType.Material and type == SurvivalEnum.ItemType.Material then
			return true
		end

		if v.type == SurvivalEnum.ItemFilterType.Equip and type == SurvivalEnum.ItemType.Equip then
			return true
		end

		if v.type == SurvivalEnum.ItemFilterType.Consume and type == SurvivalEnum.ItemType.Quick then
			return true
		end
	end
end

function SurvivalBagSortHelper.filterEquipMo(filterList, itemMo)
	if not itemMo or itemMo:isEmpty() or not itemMo.equipCo then
		return false
	end

	if not next(filterList) then
		return true
	end

	local tags = string.splitToNumber(itemMo.equipCo.tag, "#") or {}

	for _, v in pairs(filterList) do
		if tabletool.indexOf(tags, v.type) then
			return true
		end
	end
end

function SurvivalBagSortHelper.filterNpc(filterList, npcMo)
	if not npcMo or not npcMo.co then
		return false
	end

	if not filterList or not next(filterList) then
		return true
	end

	if string.nilorempty(npcMo.co.tag) then
		return false
	end

	local list = string.splitToNumber(npcMo.co.tag, "#")
	local dict = {}

	for i, v in ipairs(list) do
		local tagConfig = lua_survival_tag.configDict[v]

		if tagConfig then
			dict[tagConfig.tagType] = true
		end
	end

	for k, v in pairs(filterList) do
		if dict[v.type] then
			return true
		end
	end

	return false
end

local sortDict = {
	[SurvivalEnum.ItemSortType.EquipTag] = {
		SurvivalBagSortHelper.sortByEquipTag,
		SurvivalBagSortHelper.sortByRare,
		SurvivalBagSortHelper.sortByWorth,
		SurvivalBagSortHelper.sortByMass,
		SurvivalBagSortHelper.sortByTime,
		SurvivalBagSortHelper.sortById
	},
	[SurvivalEnum.ItemSortType.Type] = {
		SurvivalBagSortHelper.sortByType,
		SurvivalBagSortHelper.sortByEquipTag,
		SurvivalBagSortHelper.sortByRare,
		SurvivalBagSortHelper.sortByWorth,
		SurvivalBagSortHelper.sortByMass,
		SurvivalBagSortHelper.sortByTime,
		SurvivalBagSortHelper.sortById
	},
	[SurvivalEnum.ItemSortType.Worth] = {
		SurvivalBagSortHelper.sortByWorth,
		SurvivalBagSortHelper.sortByRare,
		SurvivalBagSortHelper.sortByType,
		SurvivalBagSortHelper.sortByEquipTag,
		SurvivalBagSortHelper.sortByMass,
		SurvivalBagSortHelper.sortByTime,
		SurvivalBagSortHelper.sortById
	},
	[SurvivalEnum.ItemSortType.Mass] = {
		SurvivalBagSortHelper.sortByMass,
		SurvivalBagSortHelper.sortByRare,
		SurvivalBagSortHelper.sortByType,
		SurvivalBagSortHelper.sortByEquipTag,
		SurvivalBagSortHelper.sortByWorth,
		SurvivalBagSortHelper.sortByTime,
		SurvivalBagSortHelper.sortById
	},
	[SurvivalEnum.ItemSortType.Time] = {
		SurvivalBagSortHelper.sortByTime,
		SurvivalBagSortHelper.sortByType,
		SurvivalBagSortHelper.sortByEquipTag,
		SurvivalBagSortHelper.sortByRare,
		SurvivalBagSortHelper.sortByWorth,
		SurvivalBagSortHelper.sortByMass,
		SurvivalBagSortHelper.sortById
	},
	[SurvivalEnum.ItemSortType.NPC] = {
		SurvivalBagSortHelper.sortByTime,
		SurvivalBagSortHelper.sortById
	},
	[SurvivalEnum.ItemSortType.Result] = {
		SurvivalBagSortHelper.sortByChange,
		SurvivalBagSortHelper.sortByRare,
		SurvivalBagSortHelper.sortByType,
		SurvivalBagSortHelper.sortById
	},
	[SurvivalEnum.ItemSortType.ItemReward] = {
		SurvivalBagSortHelper.sortByRare,
		SurvivalBagSortHelper.sortByCustomType,
		SurvivalBagSortHelper.sortById
	}
}
local sortList, isDec, param

function SurvivalBagSortHelper.sortItems(showList, sortType, dec, exParam)
	sortList = sortDict[sortType]
	isDec = dec
	param = exParam

	if not sortList then
		return
	end

	table.sort(showList, SurvivalBagSortHelper.sortFunc)

	sortList = nil
	isDec = nil
	param = nil
end

function SurvivalBagSortHelper.sortFunc(a, b)
	if param and param.isCheckNPCItem then
		local result = SurvivalBagSortHelper.sortByNPCItem(a, b)

		if result ~= nil then
			return result
		end
	end

	for k, func in ipairs(sortList) do
		local result = func(a, b, param)

		if result ~= nil then
			if isDec then
				result = not result
			end

			return result
		end
	end

	return false
end

return SurvivalBagSortHelper
