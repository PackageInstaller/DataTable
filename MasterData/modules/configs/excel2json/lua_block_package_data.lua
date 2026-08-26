-- chunkname: @modules/configs/excel2json/lua_block_package_data.lua

module("modules.configs.excel2json.lua_block_package_data", package.seeall)

local lua_block_package_data = {}

function lua_block_package_data.onLoad(json)
	lua_block_package_data.configList, lua_block_package_data.configDict, lua_block_package_data.packageDict = lua_block_package_data.json_parse(json)
end

function lua_block_package_data.json_parse(json)
	local configList = {}
	local configDict = {}
	local packageDict = {}

	for _, packageCfg in ipairs(json) do
		packageDict[packageCfg.id] = packageDict[packageCfg.id] or {}

		local packageList = packageDict[packageCfg.id]

		for i, cfg in ipairs(packageCfg.infos) do
			cfg.packageId = packageCfg.id
			cfg.packageOrder = i

			table.insert(configList, cfg)

			configDict[cfg.blockId] = cfg

			table.insert(packageList, cfg)
		end
	end

	return configList, configDict, packageDict
end

return lua_block_package_data
