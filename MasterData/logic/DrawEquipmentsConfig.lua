-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/config/DrawEquipmentsConfig.lua

module("logic.extensions.drawequipments.config.DrawEquipmentsConfig", package.seeall)

local DrawEquipmentsConfig = class("DrawEquipmentsConfig", BaseConfig)

function DrawEquipmentsConfig:ctor()
	self._pool_weight_config_map = {}

	DrawEquipmentsConfig.super.ctor(self)
end

function DrawEquipmentsConfig:getNames()
	local names = {
		"equipment_pool_config",
		"equipment_pool_common_config",
		"equipment_pool_progress_prize",
		"equipment_pool_rare_config"
	}

	self._pool_weight_config_map = GameUtil.getTotalConfigs("equipment_pool_weight_config")

	table.insertto(names, table.keys(self._pool_weight_config_map))

	return names
end

function DrawEquipmentsConfig:handleConfig(name, content)
	if name == "equipment_pool_config" then
		self._poolConfigs = content
	elseif name == "equipment_pool_common_config" then
		self._poolParams = content
	elseif name == "equipment_pool_progress_prize" then
		self._progressPrize = content
	elseif name == "equipment_pool_rare_config" then
		self._rareConfig = content
	elseif self._pool_weight_config_map[name] then
		self._pool_weight_config_map[name] = content
	end
end

function DrawEquipmentsConfig:getAllPools()
	return self._poolConfigs.dataList
end

function DrawEquipmentsConfig:getPoolCo(id)
	return self._poolConfigs[id]
end

function DrawEquipmentsConfig:getPoolProgressPrize(id)
	return self._progressPrize[id]
end

function DrawEquipmentsConfig:getParamsString(key)
	if self._poolParams[key] then
		return self._poolParams[key].value
	end
end

function DrawEquipmentsConfig:getParamsInt(key)
	return checknumber(self:getParamsString(key))
end

function DrawEquipmentsConfig:getAllRaresConfig(poolId)
	return self._rareConfig[poolId]
end

function DrawEquipmentsConfig:getRareWeight(poolId, rare)
	local pool = self._rareConfig[poolId]

	if not pool then
		return 0
	end

	local rareCo = pool[rare]

	if not rareCo then
		return 0
	end

	return rareCo.realWeight
end

function DrawEquipmentsConfig:getRareName(poolId, rare)
	local pool = self._rareConfig[poolId]

	if not pool then
		return
	end

	local rareCo = pool[rare]

	if not rareCo then
		return
	end

	return rareCo.rareName
end

function DrawEquipmentsConfig:getEquipments(poolId, rare)
	self._equipsByRare = self._equipsByRare or {}
	self._equipsByRare[poolId] = self._equipsByRare[poolId] or {}

	if self._equipsByRare[poolId][rare] then
		return self._equipsByRare[poolId][rare]
	end

	local equips

	for k, v in pairs(self._pool_weight_config_map) do
		equips = v[poolId]

		if v[poolId] then
			break
		end
	end

	if not equips then
		return
	end

	local raresCfg = {}
	local upEquips = {}

	for _, v in pairs(equips) do
		for _, v1 in pairs(v or {}) do
			if v1 and v1.rare == rare then
				if v1.upPool > 0 then
					if upEquips[v1.item] == nil then
						upEquips[v1.item] = v1
					end
				elseif raresCfg[v1.item] == nil then
					raresCfg[v1.item] = v1
				end
			end
		end
	end

	self._equipsByRare[poolId][rare] = {
		upEquips = {},
		equipments = {}
	}

	for _, cfg in pairs(raresCfg) do
		if cfg and not string.nilorempty(cfg.item) then
			table.insert(self._equipsByRare[poolId][rare].equipments, cfg)
		end
	end

	for _, cfg in pairs(upEquips) do
		if cfg and not string.nilorempty(cfg.item) then
			table.insert(self._equipsByRare[poolId][rare].upEquips, cfg)
		end
	end

	return self._equipsByRare[poolId][rare]
end

function DrawEquipmentsConfig:getDrawTypeTimes()
	return self:getParamsString("MULT_DRAW_TYPES")
end

function DrawEquipmentsConfig:getDrawTypeDesc()
	return self:getParamsString("MULT_DRAW_DESC")
end

DrawEquipmentsConfig.instance = DrawEquipmentsConfig.New()

return DrawEquipmentsConfig
