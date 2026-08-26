-- chunkname: @modules/logic/character/config/CharacterDestinyConfig.lua

module("modules.logic.character.config.CharacterDestinyConfig", package.seeall)

local CharacterDestinyConfig = class("CharacterDestinyConfig", BaseConfig)

function CharacterDestinyConfig:reqConfigNames()
	return {
		"character_destiny_facets_consume",
		"character_destiny_facets",
		"character_destiny_slots",
		"character_destiny",
		"destiny_facets_ex_level"
	}
end

function CharacterDestinyConfig:onInit()
	self._consumeTable = nil
	self._destinyFacetsTable = nil
	self._slotTable = nil
	self._destinyTable = nil
	self._skillExlevelTable = nil
	self._destinyBattleTagHeroIdDic = nil
end

function CharacterDestinyConfig:onConfigLoaded(configName, configTable)
	if configName == "character_destiny_facets_consume" then
		self._consumeDict = configTable
	elseif configName == "character_destiny_facets" then
		self._destinyFacetsTable = configTable
	elseif configName == "character_destiny_slots" then
		self._slotTable = configTable
	elseif configName == "character_destiny" then
		self._destinyTable = configTable

		self:initDestinyTable()
	elseif configName == "destiny_facets_ex_level" then
		self._skillExlevelTable = configTable
	end
end

function CharacterDestinyConfig:hasDestinyHero(heroId)
	if self._destinyTable then
		return self._destinyTable.configDict[heroId]
	end
end

function CharacterDestinyConfig:getHeroDestiny(heroId)
	if self._destinyTable then
		return self._destinyTable.configDict[heroId]
	end
end

function CharacterDestinyConfig:getSlotIdByHeroId(heroId)
	local co = self._destinyTable.configDict[heroId]

	return co and co.slotsId
end

function CharacterDestinyConfig:getFacetIdsByHeroId(heroId)
	local co = self._destinyTable.configDict[heroId]
	local facetsId = co and co.facetsId

	if not string.nilorempty(facetsId) then
		return (string.splitToNumber(facetsId, "#"))
	end
end

function CharacterDestinyConfig:getDestinySlotCosByHeroId(heroId)
	local slotsId = self:getSlotIdByHeroId(heroId)

	return self._slotTable.configDict[slotsId]
end

function CharacterDestinyConfig:getDestinySlotCo(heroId, rank, level)
	local cos = self:getDestinySlotCosByHeroId(heroId)

	if cos and cos[rank] then
		return cos[rank][level]
	end
end

function CharacterDestinyConfig:getNextDestinySlotCo(heroId, rank, level)
	if rank == 0 then
		return self:getDestinySlotCo(heroId, 1, 1)
	end

	local co = self:getDestinySlotCo(heroId, rank, level + 1)

	if not co then
		return self:getDestinySlotCo(heroId, rank + 1, 1)
	end

	return co
end

function CharacterDestinyConfig:getCurDestinySlotAddAttr(heroId, rank, level)
	local attrInfos = {}
	local cos = self:getDestinySlotCosByHeroId(heroId)

	if cos then
		for _rank, cos1 in ipairs(cos) do
			if _rank < rank then
				for _, co in ipairs(cos1) do
					local effect = GameUtil.splitString2(co.effect, true)

					for _, v in ipairs(effect) do
						local id = v[1]
						local num = v[2]
						local attrCo = HeroConfig.instance:getHeroAttributeCO(id)

						num = attrCo.showType == 1 and num * 0.1 or num

						if attrInfos[id] then
							attrInfos[id] = attrInfos[id] + num or num
						end
					end
				end
			elseif _rank == rank then
				for i = 1, level do
					local co = cos1[i]

					if co then
						local effect = GameUtil.splitString2(co.effect, true)

						for _, v in ipairs(effect) do
							local id = v[1]
							local num = v[2]
							local attrCo = HeroConfig.instance:getHeroAttributeCO(id)

							num = attrCo.showType == 1 and num * 0.1 or num

							if attrInfos[id] then
								attrInfos[id] = attrInfos[id] + num or num
							end
						end
					end
				end
			end
		end
	end

	return attrInfos
end

function CharacterDestinyConfig:getLockAttr(heroId, rank)
	local attrInfos = {}
	local cos = self:getDestinySlotCosByHeroId(heroId)

	if cos and rank < #cos then
		for i = rank + 1, #cos do
			for _, co in ipairs(cos[i]) do
				local effect = GameUtil.splitString2(co.effect, true)

				for _, v in ipairs(effect) do
					local id = v[1]
					local num = v[2]
					local attrCo = HeroConfig.instance:getHeroAttributeCO(id)

					num = attrCo.showType == 1 and num * 0.1 or num
					attrInfos[i] = attrInfos[i] or {}
					attrInfos[i][id] = attrInfos[i][id] and attrInfos[i][id] + num or num
				end
			end
		end
	end

	return attrInfos
end

function CharacterDestinyConfig:getDestinyFacets(facetsId, level)
	local cos = self._destinyFacetsTable.configDict[facetsId]

	return cos and cos[level]
end

function CharacterDestinyConfig:getDestinyFacetCo(facetId)
	return self._destinyFacetsTable.configDict[facetId]
end

function CharacterDestinyConfig:getDestinyFacetConsumeCo(facetId)
	return self._consumeDict.configDict[facetId]
end

function CharacterDestinyConfig:getAllDestinyConfigList()
	if not self._destinyTable then
		return
	end

	return self._destinyTable.configList
end

function CharacterDestinyConfig:initDestinyTable()
	local configList = self:getAllDestinyConfigList()

	self._destinyFacetHeroIdDic = {}

	if configList == nil then
		return
	end

	for _, config in ipairs(configList) do
		if not string.nilorempty(config.facetsId) then
			local faceIdList = string.splitToNumber(config.facetsId, "#")

			for _, faceId in ipairs(faceIdList) do
				if not self._destinyFacetHeroIdDic[faceId] then
					self._destinyFacetHeroIdDic[faceId] = config.heroId
				else
					logError("角色命石表 存在重复命石id:" + tostring(faceId))
				end
			end
		end
	end
end

function CharacterDestinyConfig:getDestinyFacetHeroId(facetId)
	if not self._destinyFacetHeroIdDic then
		return nil
	end

	return self._destinyFacetHeroIdDic[facetId]
end

function CharacterDestinyConfig:getSkillExlevelTable(facetsId, exp)
	if self._skillExlevelTable then
		local cos = self._skillExlevelTable.configDict[facetsId]

		return cos and cos[exp]
	end
end

function CharacterDestinyConfig:getSkillExlevelCos(facetsId)
	if self._skillExlevelTable then
		return self._skillExlevelTable.configDict[facetsId]
	end
end

function CharacterDestinyConfig:getHeroIdBydDestinyLastBattleTag(battleTag)
	if self._destinyBattleTagHeroIdDic == nil then
		self._destinyBattleTagHeroIdDic = {}

		for facetId, heroId in pairs(self._destinyFacetHeroIdDic) do
			local facetCostCo = self:getDestinyFacetConsumeCo(facetId)
			local tagList = string.split(facetCostCo.tag, "#")

			for _, tag in ipairs((facetCostCo.tag == "" or nil) and HeroConfig.instance:getHeroBattleTagList(heroId)) do
				self._destinyBattleTagHeroIdDic[tag] = self._destinyBattleTagHeroIdDic[tag] or {}

				table.insert(self._destinyBattleTagHeroIdDic[tag], heroId)
			end
		end
	end

	return self._destinyBattleTagHeroIdDic[battleTag] or nil
end

CharacterDestinyConfig.instance = CharacterDestinyConfig.New()

return CharacterDestinyConfig
