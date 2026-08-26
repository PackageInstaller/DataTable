-- chunkname: @modules/configs/excel2json/lua_block_init.lua

module("modules.configs.excel2json.lua_block_init", package.seeall)

local lua_block_init = {}

function lua_block_init.onLoad(json)
	lua_block_init.configList, lua_block_init.configDict, lua_block_init.poscfgDict = lua_block_init.json_parse(json)
end

function lua_block_init.json_parse(json)
	local configList = {}
	local configDict = {}
	local poscfgDict = {}

	if json.infos then
		for i, info in ipairs(json.infos) do
			local config = {}

			config.blockId = info.blockId
			config.defineId = info.defineId
			config.mainRes = info.mainRes
			config.packageId = -1
			config.order = -1

			table.insert(configList, config)

			configDict[config.blockId] = config
			poscfgDict[info.x] = poscfgDict[info.x] or {}
			poscfgDict[info.x][info.y] = info
		end
	end

	return configList, configDict, poscfgDict
end

return lua_block_init
