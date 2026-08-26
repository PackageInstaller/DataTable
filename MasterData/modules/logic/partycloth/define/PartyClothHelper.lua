-- chunkname: @modules/logic/partycloth/define/PartyClothHelper.lua

module("modules.logic.partycloth.define.PartyClothHelper", package.seeall)

local PartyClothHelper = class("PartyClothHelper")

function PartyClothHelper.GetWearSuitId(clothIdMap)
	local initSuitId = tonumber(lua_party_const.configDict[1].value)
	local suitIdList = {}

	for _, clothId in pairs(clothIdMap) do
		local suitId = PartyClothConfig.instance:getClothConfig(clothId).suitId

		if not tabletool.indexOf(suitIdList, suitId) then
			table.insert(suitIdList, suitId)
		end
	end

	table.sort(suitIdList, function(a, b)
		return a < b
	end)

	if #suitIdList == 1 then
		return suitIdList[1]
	elseif #suitIdList == 2 and suitIdList[1] == initSuitId then
		local suitId = suitIdList[2]
		local clothCfgs = PartyClothConfig.instance:getClothCfgsBySuit(suitId)

		for _, config in ipairs(clothCfgs) do
			if clothIdMap[config.partId] ~= config.clothId then
				local clothMo = PartyClothModel.instance:getClothMo(config.clothId, true)

				if clothMo then
					return
				end
			end
		end

		return suitId
	else
		return
	end
end

function PartyClothHelper.GetSuitClothIdMap(suitId)
	local clothIdMap = PartyClothConfig.instance:getInitClothIdMap()
	local clothCfgs = PartyClothConfig.instance:getClothCfgsBySuit(suitId)

	for _, config in ipairs(clothCfgs) do
		clothIdMap[config.partId] = config.clothId
	end

	return clothIdMap
end

function PartyClothHelper.SortSuitFunc(a, b)
	local cfgA = a.config
	local cfgB = b.config
	local isReverse = PartyClothModel.instance.sortReverse

	if a.isWear == b.isWear then
		if cfgA.rare == cfgB.rare then
			return cfgA.id < cfgB.id
		elseif isReverse then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.rare < cfgB.rare
		end
	else
		return a.isWear > b.isWear
	end
end

function PartyClothHelper.SortClothFunc(a, b)
	local cfgA = a.config
	local cfgB = b.config
	local isReverse = PartyClothModel.instance.sortReverse

	if a.isWear == b.isWear then
		if cfgA.rare == cfgB.rare then
			return cfgA.clothId < cfgB.clothId
		elseif isReverse then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.rare < cfgB.rare
		end
	else
		return a.isWear > b.isWear
	end
end

return PartyClothHelper
