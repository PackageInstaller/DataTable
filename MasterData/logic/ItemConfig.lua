-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/config/ItemConfig.lua

module("logic.extensions.bag.model.ItemConfig", package.seeall)

local ItemConfig = class("ItemConfig", BaseConfig)

function ItemConfig:onInit()
	ItemConfig.super.onInit(self)

	self._itemCfg = nil
end

function ItemConfig:getNames()
	return {
		"item",
		"item_source",
		"score",
		"diamond",
		"god_gem",
		"item_fake",
		"strength",
		"activity_item",
		"awaken_item_ext"
	}
end

function ItemConfig:handleConfig(name, content)
	if name == "item" then
		self._itemCfg = content
	elseif name == "item_source" then
		self._itemSourceCfg = content
	elseif name == "score" then
		self._scoreCfg = content
	elseif name == "diamond" then
		self._diamondCfg = content
	elseif name == "item_fake" then
		self._itemFakeCfg = content
	elseif name == "strength" then
		self._strengthCfg = content
	elseif name == "activity_item" then
		self._activityCfg = content
	elseif name == "awaken_item_ext" then
		self._awakenItemExt = content
	elseif name == "god_gem" then
		self._god_gemCfg = content
	end
end

function ItemConfig:getAwakenItemExtCfgs()
	if self._awakenItemExt then
		return self._awakenItemExt.dataList
	else
		return {}
	end
end

function ItemConfig:getAwakenItemExtCfgById(itemId)
	if self._awakenItemExt then
		return self._awakenItemExt[itemId]
	end

	return nil
end

function ItemConfig:canReplacePet(itemId, needAwakenLv, raceId, raceType)
	local cfg = self:getAwakenItemExtCfgById(itemId)

	if cfg then
		if cfg.level ~= needAwakenLv then
			return false
		end

		if raceId then
			return cfg.isSameRace
		else
			return raceType and raceType == GameEnum.Races[cfg.attr]
		end
	end

	return false
end

function ItemConfig:getReplaceItemId(raceId, upType, needAwakenLv, raceType)
	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local rare = cfg.rare

	for _, v in ipairs(self._awakenItemExt.dataList) do
		local initRares = v.initRares

		if initRares and table.indexof(initRares, rare) ~= false then
			if upType == GameEnum.PetStarUpStrategy.RaceId and v.isSameRace then
				return v.id
			end

			if upType == GameEnum.PetStarUpStrategy.Attr and raceType and (v.attr == raceType or GameEnum.Races[v.attr] == raceType) then
				return v.id
			end
		end
	end

	return nil
end

function ItemConfig:getReplaceItemCfgList(mo)
	local awakenLv = mo.awakenLv
	local petCfg = CharacterConfig.instance:getPetCo(mo.raceId)
	local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(checknumber(petCfg.awakenCostStrategyId), awakenLv + 1)
	local cfgList = ItemConfig.instance:getAwakenItemExtCfgs()
	local rare = petCfg.rare
	local baseList = {}
	local raceList = {}

	for i, cfg in ipairs(cfgList) do
		if cfg.race == 0 then
			local initRares = cfg.initRares

			if string.nilorempty(cfg.attr) then
				if initRares == nil or table.indexof(initRares, rare) ~= false then
					table.insert(baseList, cfg)
				end
			elseif PetSkinConfig.instance:checkHasEleAttr(mo.curFaceId, cfg.attr) and (initRares == nil or table.indexof(initRares, rare) ~= false) then
				table.insert(baseList, cfg)
			end
		elseif cfg.race == mo.raceId then
			table.insert(raceList, cfg)
		end
	end

	return raceList, baseList
end

function ItemConfig:getAllReplaceItemCfgList(mo)
	local petCfg = CharacterConfig.instance:getPetCo(mo.raceId)
	local cfgList = ItemConfig.instance:getAwakenItemExtCfgs()
	local rare = petCfg.rare
	local itemCfgs = {}

	for i, cfg in ipairs(cfgList) do
		if cfg.race == mo.raceId then
			table.insert(itemCfgs, cfg)
		elseif cfg.initRares and table.indexof(cfg.initRares, rare) then
			if string.nilorempty(cfg.attr) then
				table.insert(itemCfgs, cfg)
			elseif PetSkinConfig.instance:checkHasEleAttr(mo.curFaceId, cfg.attr) then
				table.insert(itemCfgs, cfg)
			end
		end
	end

	return itemCfgs
end

function ItemConfig:getSourceCfg(id)
	id = checknumber(id)

	return self._itemSourceCfg[id]
end

function ItemConfig:getCfgById(id)
	return self._itemCfg[id]
end

function ItemConfig:getActItemCfgById(id)
	return self._activityCfg[id]
end

function ItemConfig:getFakeCfgById(id)
	return self._itemFakeCfg[id]
end

function ItemConfig:getCfgs()
	return self._itemCfg
end

function ItemConfig:getScoreCfgs()
	return self._scoreCfg
end

function ItemConfig:getDiamondCfgs()
	return self._diamondCfg
end

function ItemConfig:getScoreById(id)
	return self._scoreCfg[id]
end

function ItemConfig:getDiamondById(id)
	return self._diamondCfg[id]
end

function ItemConfig:getGodGemCfgs()
	return self._god_gemCfg.dataList
end

function ItemConfig:getGodGemById(id)
	return self._god_gemCfg[id]
end

function ItemConfig:getStrengthById(id)
	return self._strengthCfg[id]
end

function ItemConfig:getEmptyItems(subType)
	local ret = {}

	for i, v in pairs(self._itemCfg) do
		if v.subType == subType then
			local item = {}

			item.id = self._itemCfg[i].id
			item.num = 0
			item.type = MatType.Item
			item.subType = subType
			item.order = v.order

			table.insert(ret, item)
		end
	end

	table.sort(ret, function(x, y)
		return x.id < y.id
	end)

	return ret
end

ItemConfig.instance = ItemConfig.New()

return ItemConfig
