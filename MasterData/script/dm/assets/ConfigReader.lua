-- chunkname: @/tmp/or_script/lua_compile/dm/assets/ConfigReader.lua

local isUseDBReader = false

if cc and cc.FileUtils then
	local fileUtils = cc.FileUtils:getInstance()
	local writablePath = fileUtils:getWritablePath()
	local isFileExistWritablePath = fileUtils:isFileExist(writablePath .. "gameConfig.db")
	local isFileExistLocalPath = fileUtils:isFileExist(fileUtils:fullPathForFilename("gameConfig.db"))

	if (isFileExistWritablePath or isFileExistLocalPath) and not GameConfigs.useLuaCfg then
		isUseDBReader = true
	end
end

ConfigReader = {}

local hasconfig, config_indices, __ConfigRecordMetatable__

if not isUseDBReader then
	local var_0_0, var_0_1 = pcall(require, "config.all")

	config_indices = var_0_1

	if not var_0_0 or config_indices == nil then
		config_indices = {
			version = -1
		}
	end

	ConfigReader._Tables = {}
	ConfigReader._KeysCache = {}
	__ConfigRecordMetatable__ = {
		__index = function(t, k)
			local linkkey = "L:" .. tostring(k)
			local linkage = rawget(t, linkkey)

			if linkage == nil then
				return nil
			end

			local value = ConfigReader:getRecordByRef(linkage)

			if value == nil then
				return nil
			end

			rawset(t, k, value)

			return value
		end,
		__newindex = function(t, k, v)
			assert(false, "`record` can't be modified!")
		end
	}

	function ConfigReader:getConfigVersion()
		return config_indices.version
	end
end

function ConfigReader:getDataTable(tableName)
	if isUseDBReader then
		return DataReader:getDataTable(tableName)
	end

	if self._Tables[tableName] == nil then
		local cfgModuleNames = config_indices[tableName]

		if type(cfgModuleNames) == "string" then
			self._Tables[tableName] = require(cfgModuleNames)
		elseif type(cfgModuleNames) == "table" then
			local dataTable = require(cfgModuleNames[1])

			self._Tables[tableName] = dataTable

			if #cfgModuleNames > 0 then
				local extraTables = {}

				for i = 2, #cfgModuleNames do
					extraTables[i - 1] = require(cfgModuleNames[i])
				end

				local metaIndex = #extraTables == 1 and extraTables[1] or function(t, k)
					for i = 1, #extraTables do
						local record = extraTables[i][k]

						if record ~= nil then
							return record
						end
					end

					return nil
				end

				setmetatable(dataTable, {
					__extra_tables__ = extraTables,
					__index = metaIndex
				})
			end
		end
	end

	return self._Tables[tableName]
end

function ConfigReader:getRecordById(tableName, id)
	if isUseDBReader then
		return DataReader:getRecordById(tableName, id)
	end

	id = tostring(id)

	local dataTable = self:getDataTable(tableName)

	if dataTable == nil then
		local errmsg = string.format("[ConfigReader] No record: (table=\"%s\")", tostring(tableName))

		error(errmsg, 2)
	end

	return dataTable and dataTable[id]
end

function ConfigReader:requireRecordById(tableName, id)
	if isUseDBReader then
		return DataReader:requireRecordById(tableName, id)
	end

	id = tostring(id)

	local record = self:getRecordById(tableName, id)

	if record == nil then
		local errmsg = string.format("[ConfigReader] No record: (table=\"%s\", id=\"%s\")", tostring(tableName), tostring(id))

		error(errmsg, 2)
	end

	return record
end

function ConfigReader:getDataByNameIdAndKey(tableName, id, key)
	if isUseDBReader then
		return DataReader:getDataByNameIdAndKey(tableName, id, key)
	end

	id = tostring(id)

	local record = self:getRecordById(tableName, id)

	if record ~= nil then
		assert(type(record) == "table", "record is NOT table")

		return record[key]
	end

	return nil
end

function ConfigReader:requireDataByNameIdAndKey(tableName, id, key)
	if isUseDBReader then
		return DataReader:requireDataByNameIdAndKey(tableName, id, key)
	end

	id = tostring(id)

	local field = self:getDataByNameIdAndKey(tableName, id, key)

	if field == nil then
		local errmsg = string.format("[ConfigReader] No record field: (table=\"%s\", id=\"%s\", key=\"%s\")", tostring(tableName), tostring(id), tostring(key))

		error(errmsg, 2)
	end

	return field
end

function ConfigReader:getRecordsByConditionStr(tableName, conditionStr)
	assert(isUseDBReader, "此方法只支持DB数据表")

	return DataReader:getRecordsByConditionStr(tableName, conditionStr)
end

function ConfigReader:getCountOfRecordByTableName(tableName)
	if isUseDBReader then
		return #DataReader:getIdsByIdConditionStr(tableName)
	end

	local tableData = ConfigReader:getDataTable(tableName)

	return table.nums(tableData)
end

local function collectKeys(result, tbl)
	local c = #result + 1

	for k in pairs(tbl) do
		c = c + 1
		result[c] = k
	end

	return result
end

function ConfigReader:getKeysOfTable(tableName)
	if isUseDBReader then
		return DataReader:getKeysOfTable(tableName, id, key)
	end

	local keys = self._KeysCache[tableName]

	if keys ~= nil then
		return keys
	end

	local dataTable = self:getDataTable(tableName)

	if dataTable ~= nil then
		keys = collectKeys({}, dataTable)

		local mt = getmetatable(dataTable)

		if mt ~= nil and mt.__extra_tables__ ~= nil then
			for _, tbl in ipairs(mt.__extra_tables__) do
				keys = collectKeys(keys, tbl)
			end
		end

		self._KeysCache[tableName] = keys
	end

	return keys
end

function ConfigReader:getEffectDesc(targetTable, desc, targetId, level, style)
	if isUseDBReader then
		return DataReader:getEffectDesc(targetTable, desc, targetId, level, style)
	end

	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18
	style.fontColor = style.fontColor or "#FFFFFF"

	local descValue = Strings:get(desc, style)
	local factorMap = ConfigReader:getRecordById(targetTable, targetId)
	local t = TextTemplate:new(descValue)
	local funcMap = {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[level]
		end
	}

	return t:stringify(factorMap, funcMap)
end
