-- chunkname: @IQIGame\\RequireConfig.lua

local cfgSplitConfig = require("IQIGame.Config.SplitConfigInfo")
local log = warning
local logError = logError

local function combineTable(t, t1)
	if t == nil or t1 == nil then
		return
	end

	for i, v in pairs(t1) do
		t[i] = v
	end
end

local cfg2NameMap = {}
local loadAllSplitCache = {}
local packageCache = {
	loaded = {}
}
local requirePrefix = "IQIGame.Config."

local function getTableMax(tb, k)
	local max = 0

	for i, v in ipairs(tb) do
		local it = v[3]

		if max < it then
			max = it
		end
	end

	return max
end

local function getRouteTable(tbName)
	local routeName = requirePrefix .. tbName .. "_Route"
	local key2TableId = require(routeName)

	return key2TableId
end

local function getSplitTableId(tbName, k)
	if type(k) ~= "number" then
		logError(string.format("key type must number,in table %s", tbName))

		return nil
	end

	local key2TableId = getRouteTable(tbName)
	local tableId

	for i, v in pairs(key2TableId) do
		local min = v[1]
		local max = v[2]

		if min <= k and k <= max then
			tableId = v[3]
		end
	end

	return tableId
end

local function loadSplitTable(t, splitTableName)
	local splitTable = require(splitTableName)

	if splitTable == nil then
		log("not find table:" .. splitTableName)

		return nil
	else
		packageCache.loaded[splitTableName] = true
		package.loaded[splitTableName] = nil
	end

	combineTable(t, splitTable)

	return splitTable
end

local function CfgKeyIndex(t, k)
	if k == nil then
		log("error arg, key is nil")

		return nil
	end

	local tbName = cfg2NameMap[t]
	local hasSplit = cfgSplitConfig[tbName]
	local splitTableName = ""

	if hasSplit then
		local tableId = getSplitTableId(tbName, k)

		if tableId == nil then
			local routeName = requirePrefix .. tbName .. "_Route"

			if tbName ~= "CfgI18NTable" then
				logError(string.format("not find key:%s in %s", k, routeName))
			end

			return nil
		end

		splitTableName = string.format("%s%s_%s", requirePrefix, tbName, tableId)

		local loaded = packageCache.loaded[splitTableName]

		if loaded then
			if tbName ~= "CfgI18NTable" then
				logError(string.format("key:%s not find in table:%s_%s", k, tbName, tableId))
			end

			return nil
		end

		local splitTable = loadSplitTable(t, splitTableName)

		if splitTable == nil then
			return nil
		end

		local var = rawget(t, k)

		if var == nil then
			logError(string.format("key:%s not find in table:%s", k, tbName))
		end

		return var
	else
		logError(string.format("key:%s not find in table:%s", k, tbName))

		return nil
	end
end

local cfgMetatable = {
	__index = CfgKeyIndex
}

local function generateNewCfgRawTable(k)
	local hasSplit = cfgSplitConfig[k]
	local t

	if hasSplit then
		t = {}
	else
		local tbName = string.format("%s%s", requirePrefix, k)

		t = require(tbName)

		if t then
			packageCache.loaded[tbName] = true
		end
	end

	setmetatable(t, cfgMetatable)

	cfg2NameMap[t] = k

	return t
end

local function CfgIndex(t, k)
	local value = generateNewCfgRawTable(k)

	rawset(t, k, value)

	return value
end

local g = _G
local gMetatable = getmetatable(g) or {}
local srcIndex = gMetatable.__index

local function GIndex(t, k)
	if type(k) == "string" then
		local prefix = string.sub(k, 1, 3)

		if prefix == "Cfg" then
			local var = CfgIndex(t, k)

			return var
		end
	end

	if srcIndex ~= nil then
		return srcIndex(t, k)
	end
end

gMetatable.__index = GIndex

setmetatable(g, gMetatable)

local pairs = pairs

function pairsCfg(t)
	local tbName = cfg2NameMap[t]
	local hasSplit = cfgSplitConfig[tbName]

	if hasSplit then
		local loadedAll = loadAllSplitCache[tbName]

		if loadedAll == nil then
			local routeTb = getRouteTable(tbName)
			local splitTableCount = getTableMax(routeTb)

			for i = 1, splitTableCount do
				local splitTableName = string.format("%s%s_%s", requirePrefix, tbName, i)
				local loaded = packageCache.loaded[splitTableName]

				if loaded == nil then
					loadSplitTable(t, splitTableName)
				end
			end

			loadAllSplitCache[tbName] = true
		end
	end

	return pairs(t)
end
