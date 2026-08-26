-- chunkname: @modules/common/utils/LuaUtil.lua

module("modules.common.utils.LuaUtil", package.seeall)

local LuaUtil = {}

LuaUtil.emptyStr = ""
LuaUtil.emptyTable = {}

function LuaUtil.isFunction(val)
	return type(val) == "function"
end

function LuaUtil.isTable(val)
	return type(val) == "table"
end

function LuaUtil.isNumber(val)
	return type(val) == "number"
end

function LuaUtil.isString(val)
	return type(val) == "string"
end

function LuaUtil.isBoolean(val)
	return type(val) == "boolean"
end

function LuaUtil.numToBoolean(num)
	if not num or type(num) ~= "number" then
		logError("请输入正确的数字！")

		return
	end

	return num ~= 0
end

function LuaUtil.isEmptyStr(val)
	if val == nil then
		return true
	end

	return LuaUtil.isString(val) and string.gsub(val, "^%s*(.-)%s*$", "%1") == LuaUtil.emptyStr
end

function LuaUtil.isLineFeedStr(val)
	if val == nil then
		return false
	end

	return LuaUtil.isString(val) and (val == "\n" or val == "\r\n")
end

function LuaUtil.getStrLen(str)
	if LuaUtil.isEmptyStr(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte > 0 and byte <= 127 then
			strLen = strLen + 1
		elseif byte >= 192 and byte <= 239 then
			strLen = strLen + 2
			i = i + 2
		end
	end

	return strLen
end

function LuaUtil.getChineseLen(str)
	if LuaUtil.isEmptyStr(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte >= 192 and byte <= 239 then
			strLen = strLen + 1
			i = i + 2
		end
	end

	return strLen
end

function LuaUtil.containChinese(str)
	if LuaUtil.isEmptyStr(str) then
		return false
	end

	for i = 1, #str do
		local byte = string.byte(str, i)

		if byte >= 228 and byte <= 233 then
			local next1 = string.byte(str, i + 1) or 0
			local next2 = string.byte(str, i + 2) or 0

			if next1 >= 128 and next1 <= 191 and next2 >= 128 and next2 <= 191 then
				return true
			end
		end
	end

	return false
end

function LuaUtil.getCharNum(str)
	if LuaUtil.isEmptyStr(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte > 0 and byte <= 127 then
			strLen = strLen + 1
		elseif byte >= 192 and byte <= 239 then
			strLen = strLen + 1
			i = i + 2
		end
	end

	return strLen
end

function LuaUtil.getUCharArr(ucharStr)
	if LuaUtil.isEmptyStr(ucharStr) then
		return
	end

	local ret = {}

	for uchar in string.gmatch(ucharStr, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF \n]*") do
		if not LuaUtil.isEmptyStr(uchar) then
			table.insert(ret, uchar)
		end
	end

	return ret
end

function LuaUtil.getUCharArrWithLineFeed(ucharStr)
	if LuaUtil.isEmptyStr(ucharStr) then
		return
	end

	local ret = {}

	for uchar in string.gmatch(ucharStr, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF ]*") do
		if not LuaUtil.isEmptyStr(uchar) or LuaUtil.isLineFeedStr(uchar) then
			table.insert(ret, uchar)
		end
	end

	return ret
end

function LuaUtil.strEndswith(str, substr)
	if str == nil or substr == nil then
		return nil, "the string or the sub-string parameter is nil"
	end

	local str_tmp = string.reverse(str)
	local substr_tmp = string.reverse(substr)

	if string.find(str_tmp, substr_tmp) ~= 1 then
		return false
	else
		return true
	end
end

function LuaUtil.getReverseArrTab(arrTab)
	if not arrTab or not LuaUtil.isTable(arrTab) then
		return arrTab
	end

	local reverseTab = {}

	for i = #arrTab, 1, -1 do
		table.insert(reverseTab, arrTab[i])
	end

	return reverseTab
end

function LuaUtil.stringToVector3(str)
	local vecs = string.split(string.gsub(string.gsub(str, "%[", ""), "%]", ""), ",")
	local result = {}

	for i = 1, #vecs do
		table.insert(result, tonumber(vecs[i]))
	end

	return result
end

function LuaUtil.pairsByKeys(tab)
	local a = {}

	for k, _ in pairs(tab) do
		a[#a + 1] = k
	end

	table.sort(a)

	local i = 0

	return function()
		i = i + 1

		return a[i], tab[a[i]]
	end
end

function LuaUtil.deepCopy(obj)
	local SearchTable = {}

	local function Func(obj)
		if type(obj) ~= "table" then
			return obj
		end

		local NewTable = {}

		SearchTable[obj] = NewTable

		for k, v in pairs(obj) do
			NewTable[Func(k)] = Func(v)
		end

		return setmetatable(NewTable, getmetatable(obj))
	end

	return Func(obj)
end

function LuaUtil.deepCopyNoMeta(obj)
	local SearchTable = {}

	local function Func(obj)
		if type(obj) ~= "table" then
			return obj
		end

		local NewTable = {}

		SearchTable[obj] = NewTable

		for k, v in pairs(obj) do
			NewTable[Func(k)] = Func(v)
		end

		return NewTable
	end

	return Func(obj)
end

function LuaUtil.deepCopySimple(obj)
	if type(obj) ~= "table" then
		return obj
	else
		local table = {}

		for k, v in pairs(obj) do
			table[k] = LuaUtil.deepCopySimple(v)
		end

		return table
	end
end

function LuaUtil.luaHotUpdate(fileName)
	local oldTarget = moduleNameToTables[fileName]

	moduleNameToTables[fileName] = nil
	package.loaded[moduleNameToPath[fileName]] = nil

	setGlobal(fileName, nil)

	if oldTarget and oldTarget.instance then
		local newTarget = _G[fileName]

		for k, v in pairs(oldTarget.instance) do
			if type(v) ~= "function" or not newTarget.instance[k] then
				newTarget.instance[k] = v
			end
		end
	end

	print(fileName, "======hot update finish!")
end

function LuaUtil.replaceSpace(text)
	if string.nilorempty(text) then
		return text
	end

	return string.gsub(text, " ", " ")
end

function LuaUtil.updateTMPRectHeight_LayoutElement(tmp)
	local layoutElement = gohelper.onceAddComponent(tmp.gameObject, typeof(UnityEngine.UI.LayoutElement))

	tmp:ForceMeshUpdate(true, true)

	local renderedValues = tmp:GetRenderedValues()

	layoutElement.preferredHeight = renderedValues.y
end

function LuaUtil.updateTMPRectHeight(tmp)
	tmp:ForceMeshUpdate(true, true)

	local renderedValues = tmp:GetRenderedValues()

	recthelper.setHeight(tmp.rectTransform, renderedValues.y)
end

function LuaUtil.mergeTable(list, ...)
	local subTables = {
		...
	}

	for _, subTable in pairs(subTables) do
		if subTable then
			for __, object in pairs(subTable) do
				table.insert(list, object)
			end
		end
	end

	return list
end

function LuaUtil.insertDict(list, dict)
	if not dict then
		return
	end

	for _, object in pairs(dict) do
		table.insert(list, object)
	end
end

function LuaUtil.tableContains(list, value)
	if not list then
		return false
	end

	for _, object in pairs(list) do
		if object == value then
			return true
		end
	end

	return false
end

function LuaUtil.indexOfElement(list, value)
	if not list then
		return -1
	end

	for index, object in pairs(list) do
		if object == value then
			return index
		end
	end

	return -1
end

function LuaUtil.tableToDictionary(luaTable)
	local dictionary = System.Collections.Generic.Dictionary_string_object.New()

	if luaTable then
		for k, v in pairs(luaTable) do
			dictionary:Add(k, v)
		end
	end

	return dictionary
end

function LuaUtil.subString(str, startIndex, endIndex)
	local tempStr = str
	local byteStart = 1
	local byteEnd = -1
	local index = 0
	local bytes = 0

	startIndex = math.max(startIndex, 1)
	endIndex = endIndex or -1

	while string.len(tempStr) > 0 do
		if index == startIndex - 1 then
			byteStart = bytes + 1
		elseif index == endIndex then
			byteEnd = bytes

			break
		end

		bytes = bytes + LuaUtil.GetBytes(tempStr)
		tempStr = string.sub(str, bytes + 1)
		index = index + 1
	end

	return string.sub(str, byteStart, byteEnd)
end

function LuaUtil.GetBytes(char)
	if not char then
		return 0
	end

	local code = string.byte(char)

	if code < 127 then
		return 1
	elseif code <= 223 then
		return 2
	elseif code <= 239 then
		return 3
	elseif code <= 247 then
		return 4
	else
		return 0
	end
end

function LuaUtil.tableNotEmpty(t)
	if not t then
		return false
	end

	if not LuaUtil.isTable(t) then
		return false
	end

	return next(t) ~= nil
end

function LuaUtil.fractionAddition(numerator1, denominator1, numerator2, denominato2)
	local denominator = denominator1

	if denominator1 ~= denominato2 then
		denominator = denominator1 * denominato2
		numerator1 = numerator1 * denominato2
		numerator2 = numerator2 * denominator1
	end

	return numerator1 + numerator2, denominator
end

function LuaUtil.divisionOperation2Fraction(float1, float2)
	local numerator1, denominator1 = LuaUtil.float2Fraction(float1)
	local numerator2, denominator2 = LuaUtil.float2Fraction(float2)

	return numerator1 * denominator2, denominator1 * numerator2
end

function LuaUtil.float2Fraction(float)
	local num1, num2 = math.modf(float)
	local numerator = num1
	local denominator = 1

	if num2 ~= 0 then
		local len = #tostring(num2) - 2

		numerator, denominator = LuaUtil:fractionAddition(denominator, math.abs(num2 * 10 * len), len * 10)
	end

	return numerator, denominator
end

function LuaUtil.full2HalfWidth(str)
	local strTbl = {}

	for code in str:gmatch("[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if code:byte(3) then
			local codepoint = code:byte(2) * 64 + code:byte(3) - 12193 + 65

			if codepoint > 32 and codepoint < 126 then
				table.insert(strTbl, string.char(codepoint))
			else
				table.insert(strTbl, code)
			end
		else
			table.insert(strTbl, code)
		end
	end

	return table.concat(strTbl)
end

function LuaUtil.class(classname, superCls, overseasImplCls, nativesImplCls)
	if isDebugBuild and superCls then
		if nativesImplCls then
			assert(_G.isTypeOf(nativesImplCls, superCls), nativesImplCls.__cname .. " is not type of " .. superCls.__cname)
		end

		if overseasImplCls then
			assert(_G.isTypeOf(overseasImplCls, superCls), overseasImplCls.__cname .. " is not type of " .. superCls.__cname)
		end
	end

	if SettingsModel.instance:isOverseas() then
		return _G.class(classname, overseasImplCls or superCls)
	else
		return _G.class(classname, nativesImplCls or superCls)
	end
end

return LuaUtil
