-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/config/ChamberConfig.lua

module("logic.extensions.chamber.config.ChamberConfig", package.seeall)

local M = class("ChamberConfig", BaseConfig)

function M:onInit()
	self._dictEntryCO = {}
	self._const = {}
end

function M:getNames()
	return {
		ConfigName.ChamberOpenSlot,
		ConfigName.ChamberEntry,
		ConfigName.ChamberTask,
		ConfigName.AirtightRoomConst
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.ChamberEntry then
		local cfgList = self:getConfigList(ConfigName.ChamberEntry)

		for i, cfg in ipairs(cfgList) do
			local CO = ChamberEntryCO.New(cfg)

			if self._dictEntryCO[cfg.id] == nil then
				self._dictEntryCO[cfg.id] = {}
			end

			self._dictEntryCO[cfg.id][cfg.lv] = CO
		end
	elseif name == ConfigName.AirtightRoomConst then
		self._const = content
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getConstByKey(key)
	return self._const[key] and self._const[key].numValue or 0
end

function M:getEntryCO(id, lv)
	if self._dictEntryCO[id] then
		return self._dictEntryCO[id][lv]
	end
end

function M:getItemEntrysById(id, needClone, count)
	local cfg = BackpackConfig.instance:getConfigByKey(ConfigName.ItemChamberClue, id)

	return self:getItemEntrys(cfg, needClone, count)
end

function M:getItemEntrysByUuid(uuid, needClone, count)
	local itemData = ItemModel.instance:getItemDataByUuid(tostring(uuid))

	if itemData then
		local cfg = itemData:getItemInfo()

		return self:getItemEntrys(cfg, needClone, count)
	end

	return {}
end

function M:getItemEntrys(cfg, needClone, count)
	local entryCOs = {}

	if cfg.entry then
		for _, entryStr in ipairs(cfg.entry) do
			local list = string.split(entryStr, "#")
			local CO = self:getEntryCO(tonumber(list[1]), tonumber(list[2]))

			if CO then
				if needClone then
					local newCO = clone(CO)

					newCO:setCount(count)
					table.insert(entryCOs, newCO)
				else
					table.insert(entryCOs, CO)
				end
			end
		end
	end

	return entryCOs
end

function M:getSlotUnlockLv(idx)
	local cfg = self:getConfigByKey(ConfigName.ChamberOpenSlot, idx)

	return cfg.lv
end

M.instance = M.New()

return M
