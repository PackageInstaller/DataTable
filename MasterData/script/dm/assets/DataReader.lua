-- chunkname: @/tmp/or_script/lua_compile/dm/assets/DataReader.lua

if not table.copy then
	DataReader = {}

	DBReader:getInstance(true)

	local fileUtils = cc.FileUtils:getInstance()
	local writablePath = fileUtils:getWritablePath()
	local dbFilePath = writablePath .. "gameConfig.db"

	if fileUtils:isFileExist("gameConfig.db") and (device.platform ~= "android" or GameConfigs.isMUMU) then
		dbFilePath = "gameConfig.db"
	end

	local cjson = require("cjson.safe")
	local splitStr = "#@#"

	DataReader._DBTables = {}
	DataReader._cacheDataTable = {}
	DataReader._isTotalData = {}

	function DataReader:cleanCache()
		DataReader._cacheDataTable = {}
		DataReader._isTotalData = {}
		DataReader._DBTables = {}
	end

	function DataReader:getDBTable(tableName)
		if not self._DBTables[tableName] then
			local dbTable, errorInfo = DBReader:getInstance():getTable(dbFilePath, tableName)

			if not dbTable then
				self:cleanCache()

				dbTable, errorInfo = DBReader:getInstance(true):getTable(dbFilePath, tableName)
			end

			assert(dbTable, string.format("no such db table:%s,errorInfo:%s", tableName, tostring(errorInfo)))

			local info = {}

			info.table = dbTable
			info.columnNames = DBReader:getInstance():getTable(dbFilePath, tableName):getRowById("Id")
			info.types = DBReader:getInstance():getTable(dbFilePath, tableName):getRowById("DataType")
			info.types[1] = "string"

			if dbTable:getColName()[2] == "DpstormData" then
				info.isEncrypted = true
				info.columnNames = string.split(info.columnNames[2], splitStr)

				table.insert(info.columnNames, "Id")

				info.types = string.split(info.types[2], splitStr)

				table.insert(info.types, "string")
			end

			self._DBTables[tableName] = info
		end

		return self._DBTables[tableName]
	end

	function DataReader:convertToType(data, type, tableName, key)
		if type == "string" then
			-- block empty
		elseif type == "int" or type == "long" or type == "double" then
			data = tonumber(data)
		elseif type == "array" or type == "dict" or type == "auto" then
			data = cjson.decode(data)
		elseif type == "bool" then
			data = data == "True"
		else
			assert(false, string.format("invalid type:%s,tableName:%s,key:%s,value:%s", type, tableName, key, data))
		end

		return data
	end

	function DataReader:_createDataMap(dataArray, dataTable, tableName, id)
		if dataTable.isEncrypted then
			dataArray = string.split(dataArray[2], splitStr)

			table.insert(dataArray, id)
		end

		local dataMap = {}
		local columnNames = dataTable.columnNames

		for i = 1, #columnNames do
			local key = columnNames[i]

			dataMap[key] = self:convertToType(dataArray[i], dataTable.types[i], tableName, key)
		end

		return dataMap
	end

	function DataReader:_getRecordById(tableName, id)
		id = tostring(id)

		local cacheData

		self._cacheDataTable[tableName] = self._cacheDataTable[tableName] or {}

		local tableCache = self._cacheDataTable[tableName]
		local cacheDataInfo = tableCache[id]

		if cacheDataInfo == false or not cacheDataInfo and self._isTotalData[tableName] then
			return
		end

		if not cacheDataInfo then
			local dataTable = self:getDBTable(tableName)
			local dataArray = dataTable.table:getRowById(id)

			if #dataArray == 0 then
				tableCache[id] = false

				return
			end

			local dataMap = self:_createDataMap(dataArray, dataTable, tableName, id)

			tableCache[id] = dataMap
			cacheData = dataMap
		else
			cacheData = cacheDataInfo
		end

		return cacheData
	end

	function DataReader:getDataTable(tableName)
		local dataTable = self:getDBTable(tableName)

		self._cacheDataTable[tableName] = self._cacheDataTable[tableName] or {}

		local tableCache = self._cacheDataTable[tableName]

		local function filter(t)
			local temp = {}

			for key, value in pairs(t) do
				if value ~= false then
					temp[key] = value
				end
			end

			return temp
		end

		if self._isTotalData[tableName] then
			return filter(tableCache)
		end

		local datas = dataTable.table:getRowsByConditionStr("where Id not in ('Id','DataType')")

		for i = 1, #datas do
			local dataArray = datas[i]
			local id = dataArray[1]

			tableCache[id] = tableCache[id] or self:_createDataMap(dataArray, dataTable, tableName, id)
		end

		self._isTotalData[tableName] = true

		return filter(tableCache)
	end

	function DataReader:getRecordsByConditionStr(tableName, conditionStr)
		conditionStr = conditionStr or ""

		if #conditionStr > 0 then
			conditionStr = "and " .. conditionStr
		end

		local dataTable = self:getDBTable(tableName)
		local datas = dataTable.table:getRowsByConditionStr("where Id not in ('Id','DataType') " .. conditionStr)
		local dataTable = self:getDBTable(tableName)

		self._cacheDataTable[tableName] = self._cacheDataTable[tableName] or {}

		local tableCache = self._cacheDataTable[tableName]
		local retData = {}

		for i = 1, #datas do
			local dataArray = datas[i]
			local id = dataArray[1]

			tableCache[id] = tableCache[id] or self:_createDataMap(dataArray, dataTable, tableName, id)
			retData[id] = tableCache[id]
		end

		return retData
	end

	function DataReader:getIdsByIdConditionStr(tableName, conditionStr)
		conditionStr = conditionStr or ""

		if #conditionStr > 0 then
			conditionStr = "and " .. conditionStr
		end

		local dataTable = self:getDBTable(tableName)

		return dataTable.table:getIdsByConditionStr("where Id not in ('Id','DataType') " .. conditionStr)
	end

	function DataReader:getRecordById(tableName, id)
		return self:_getRecordById(tableName, id)
	end

	function DataReader:requireRecordById(tableName, id)
		local record = self:getRecordById(tableName, id)

		if record == nil then
			local errmsg = string.format("[DataReader] No record: (table=\"%s\", id=\"%s\")", tostring(tableName), tostring(id))

			error(errmsg, 2)
		end

		return record
	end

	function DataReader:getDataByNameIdAndKey(tableName, id, key)
		id = tostring(id)

		local record = self:getRecordById(tableName, id)

		if record ~= nil then
			assert(type(record) == "table", "record is NOT table")

			return record[key]
		end

		return nil
	end

	function DataReader:requireDataByNameIdAndKey(tableName, id, key)
		id = tostring(id)

		local field = self:getDataByNameIdAndKey(tableName, id, key)

		if field == nil then
			local errmsg = string.format("[DataReader] No record field: (table=\"%s\", id=\"%s\", key=\"%s\")", tostring(tableName), tostring(id), tostring(key))

			error(errmsg, 2)
		end

		return field
	end

	function DataReader:getKeysOfTable(tableName)
		local dataTable = self:getDBTable(tableName)

		return (dataTable.table:getIdsByConditionStr("where Id not in ('Id','DataType')"))
	end

	function DataReader:getEffectDesc(targetTable, desc, targetId, level, style)
		style = style or {}
		style.fontName = style.fontName or TTF_FONT_FZYH_R
		style.fontSize = style.fontSize or 18
		style.fontColor = style.fontColor or "#FFFFFF"

		local descValue = Strings:get(desc, style)
		local factorMap = DataReader:getRecordById(targetTable, targetId)
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
end
