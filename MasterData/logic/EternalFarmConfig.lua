-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/config/EternalFarmConfig.lua

module("logic.extensions.eternalfarm.config.EternalFarmConfig", package.seeall)

local EternalFarmConfig = class("EternalFarmConfig", BaseConfig)

function EternalFarmConfig:onInit()
	EternalFarmConfig.super.onInit(self)
end

function EternalFarmConfig:getNames()
	return {
		"eternal_farm_activity",
		"eternal_farm_zone",
		"eternal_farm_crop",
		"eternal_farm_shop",
		"eternal_farm_collect_prize",
		"eternal_farm_multiple"
	}
end

function EternalFarmConfig:handleConfig(name, content)
	if name == "eternal_farm_activity" then
		self._farm_actCfg = content
	elseif name == "eternal_farm_zone" then
		self._farm_zonCfg = content
	elseif name == "eternal_farm_crop" then
		self._farm_cropCfg = content
	elseif name == "eternal_farm_shop" then
		self._farm_shopCfg = content
	elseif name == "eternal_farm_collect_prize" then
		self.eternal_farm_collect_prize = content
	elseif name == "eternal_farm_multiple" then
		self._eternal_farm_multiple = content
	end
end

function EternalFarmConfig:getActCfgById(activityId)
	return self._farm_actCfg[activityId]
end

function EternalFarmConfig:getZoneCfg(activityId)
	return self._farm_zonCfg[activityId]
end

function EternalFarmConfig:getZoneCfgById(activityId, zoneId)
	return self._farm_zonCfg[activityId][zoneId]
end

function EternalFarmConfig:getCropCfg(activityId)
	return self._farm_cropCfg[activityId]
end

function EternalFarmConfig:getCropCfgByCropId(activityId, cropId)
	return self._farm_cropCfg[activityId] and self._farm_cropCfg[activityId][cropId]
end

function EternalFarmConfig:getCropCfgById(activityId, zoneId)
	local cfg = self._farm_cropCfg[activityId]

	for _, v in ipairs(cfg) do
		if v.zoneId == zoneId then
			return v
		end
	end

	return {}
end

function EternalFarmConfig:getCropCfgByYardId(activityId, yardId)
	local cfgs = {}
	local zoneIdList = self:getZoneIdsListByYardId(activityId, yardId)

	for i, zoneId in ipairs(zoneIdList) do
		local cfg = self:getCropCfgById(activityId, zoneId)

		table.insert(cfgs, cfg)
	end

	return cfgs
end

function EternalFarmConfig:getCropCfgsByZoneId(activityId, zoneId)
	local cfgs = {}
	local cfg = self._farm_cropCfg[activityId]

	for _, v in ipairs(cfg) do
		if v.zoneId == zoneId then
			table.insert(cfgs, v)
		end
	end

	return cfgs
end

function EternalFarmConfig:getCollectPrizeCfg(activityId)
	return self.eternal_farm_collect_prize[activityId]
end

function EternalFarmConfig:getCollectPrizeCfgByItemId(activityId, itemId)
	return self.eternal_farm_collect_prize[activityId] and self.eternal_farm_collect_prize[activityId][itemId]
end

function EternalFarmConfig:getShopCfg(activityId)
	return self._farm_shopCfg[activityId]
end

function EternalFarmConfig:getShopCfgById(activityId, shopId)
	return self._farm_shopCfg[activityId][shopId]
end

function EternalFarmConfig:getMultipleCfg(activityId)
	return self._eternal_farm_multiple[activityId]
end

function EternalFarmConfig:getShopCfgByType(activityId, type)
	local cfg = self:getShopCfg(activityId)
	local shopCfg = {}

	for _, v in ipairs(cfg) do
		if v.type == type then
			table.insert(shopCfg, v)
		end
	end

	return shopCfg
end

function EternalFarmConfig:getShopCfgByTypeAndYardId(activityId, type, yardId)
	local cfg = self:getShopCfg(activityId)
	local shopCfg = {}

	if checknumber(yardId) > 0 then
		for _, v in ipairs(cfg) do
			if type == 2 then
				if v.type == type then
					table.insert(shopCfg, v)
				end
			elseif v.type == type and v.showYardId == yardId then
				table.insert(shopCfg, v)
			end
		end

		return shopCfg
	else
		return self:getShopCfgByType(activityId, type)
	end
end

function EternalFarmConfig:getItemIds(activityId)
	local itemIdList = {}

	if self.eternal_farm_collect_prize[activityId] then
		for itemId, prizes in pairs(self.eternal_farm_collect_prize[activityId]) do
			local curItemId = 0

			for i, data in ipairs(prizes) do
				curItemId = data.itemId
			end

			table.insert(itemIdList, itemId)
		end

		table.sort(itemIdList)
	end

	return itemIdList
end

function EternalFarmConfig:getCollectNames(activityId)
	local nameDic = {}

	if self.eternal_farm_collect_prize[activityId] then
		for itemId, prizes in pairs(self.eternal_farm_collect_prize[activityId]) do
			local name = ""

			for i, prize in ipairs(prizes) do
				name = prize.name or ""
			end

			nameDic[itemId] = name
		end
	end

	return nameDic
end

function EternalFarmConfig:getItemPrizeNum(activityId, itemId)
	return self.eternal_farm_collect_prize[activityId] and #self.eternal_farm_collect_prize[activityId][itemId]
end

function EternalFarmConfig:getYardNum(activityId)
	local yardIdDic = {}
	local yardNum = 0
	local zoneCfg = self._farm_zonCfg[activityId]

	for i, cfg in ipairs(zoneCfg) do
		if yardIdDic[cfg.showYardId] == nil then
			yardIdDic[cfg.showYardId] = true
			yardNum = yardNum + 1
		end
	end

	return yardNum
end

function EternalFarmConfig:getZoneIdsListByYardId(activityId, yardId)
	local zoneIdList = {}

	if self._farm_zonCfg[activityId] then
		for i, cfg in ipairs(self._farm_zonCfg[activityId]) do
			if yardId == cfg.showYardId then
				table.insert(zoneIdList, cfg.zoneId)
			end
		end
	end

	return zoneIdList
end

EternalFarmConfig.instance = EternalFarmConfig.New()

return EternalFarmConfig
