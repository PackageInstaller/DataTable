-- chunkname: @modules/configs/excel2json/lua_block.lua

module("modules.configs.excel2json.lua_block", package.seeall)

local lua_block = {}
local propertyNames = {
	"blockType",
	"waterType"
}

function lua_block.onLoad(json)
	lua_block.confgData = json
	lua_block.configList, lua_block.configDict = lua_block.json_parse(json)
	lua_block.propertyList, lua_block.propertyDict = lua_block.json_property(json, propertyNames)
end

function lua_block.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		configDict[cfg.defineId] = cfg

		if cfg.category == cjson.null then
			cfg.category = nil
		end

		local countDict = {}

		cfg.resIdCountDict = countDict

		for _r, resId in ipairs(cfg.resourceIds) do
			countDict[resId] = (countDict[resId] or 0) + 1
		end
	end

	return configList, configDict
end

function lua_block.json_property(json, propertyNames)
	local propertyList = {}
	local propertyDict = {}

	for _, propertyName in ipairs(propertyNames) do
		local tempList = {}
		local tempDict = {}

		propertyList[propertyName] = tempList
		propertyDict[propertyName] = tempDict

		for __, cfg in ipairs(json) do
			local propertyValue = cfg[propertyName]

			if propertyValue and not tempDict[propertyValue] then
				tempDict[propertyValue] = propertyValue

				table.insert(tempList, propertyValue)
			end
		end

		logNormal(string.format("lua_block.json_property [%s]:%s,", propertyName, table.concat(tempList, ",")))
	end

	return propertyList, propertyDict
end

return lua_block
