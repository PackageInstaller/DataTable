-- chunkname: @modules/logic/ressplit/xml/ResSplitXml2lua.lua

module("modules.logic.ressplit.xml.ResSplitXml2lua", package.seeall)

local ResSplitXml2lua = {
	_VERSION = "1.5-2"
}

local function printableInternal(tb, level)
	if tb == nil then
		return
	end

	level = level or 1

	local spaces = string.rep(" ", level * 2)

	for k, v in pairs(tb) do
		if type(v) == "table" then
			print(spaces .. k)
			printableInternal(v, level + 1)
		else
			print(spaces .. k .. "=" .. v)
		end
	end
end

function ResSplitXml2lua.parser(handler)
	if handler == ResSplitXml2lua then
		error("You must call ResSplitXml2lua.parse(handler) instead of ResSplitXml2lua:parse(handler)")
	end

	local options = {
		expandEntities = 1,
		stripWS = 1,
		errorHandler = function(errMsg, pos)
			error(string.format("%s [char=%d]\n", errMsg or "Parse Error", pos))
		end
	}

	return ResSplitXmlParser.new(handler, options)
end

function ResSplitXml2lua.printable(tb)
	printableInternal(tb)
end

function ResSplitXml2lua.toString(t)
	local sep = ""
	local res = ""

	if type(t) ~= "table" then
		return t
	end

	for k, v in pairs(t) do
		if type(v) == "table" then
			v = ResSplitXml2lua.toString(v)
		end

		res = res .. sep .. string.format("%s=%s", k, v)
		sep = ","
	end

	res = "{" .. res .. "}"

	return res
end

function ResSplitXml2lua.loadFile(xmlFilePath)
	local f, e = io.open(xmlFilePath, "r")

	if f then
		local content = f:read("*a")

		f:close()

		return content
	end

	error(e)
end

local function attrToXml(attrTable)
	local s = ""

	attrTable = attrTable or {}

	for k, v in pairs(attrTable) do
		s = s .. " " .. k .. "=" .. "\"" .. v .. "\""
	end

	return s
end

local function getFirstKey(tb)
	if type(tb) == "table" then
		for k, _ in pairs(tb) do
			return k
		end

		return nil
	end

	return tb
end

local function parseTableKeyToXml(xmltb, tagName, fieldValue, level)
	local spaces = string.rep(" ", level * 2)
	local strValue, attrsStr = "", ""

	if type(fieldValue) == "table" then
		attrsStr = attrToXml(fieldValue._attr)
		fieldValue._attr = nil
		strValue = #fieldValue == 1 and spaces .. tostring(fieldValue[1]) or ResSplitXml2lua.toXml(fieldValue, tagName, level + 1)
		strValue = "\n" .. strValue .. "\n" .. spaces
	else
		strValue = tostring(fieldValue)
	end

	table.insert(xmltb, spaces .. "<" .. tagName .. attrsStr .. ">" .. strValue .. "</" .. tagName .. ">")
end

function ResSplitXml2lua.toXml(tb, tableName, level)
	level = level or 1

	local firstLevel = level

	tableName = tableName or ""

	local xmltb = tableName ~= "" and level == 1 and {
		"<" .. tableName .. ">"
	} or {}

	for k, v in pairs(tb) do
		if type(v) == "table" then
			if type(k) == "number" then
				parseTableKeyToXml(xmltb, tableName, v, level)
			else
				level = level + 1

				if type(getFirstKey(v)) == "number" then
					parseTableKeyToXml(xmltb, k, v, level)
				else
					parseTableKeyToXml(xmltb, k, v, level)
				end
			end
		else
			if type(k) == "number" then
				k = tableName
			end

			parseTableKeyToXml(xmltb, k, v, level)
		end
	end

	if tableName ~= "" and firstLevel == 1 then
		table.insert(xmltb, "</" .. tableName .. ">\n")
	end

	return table.concat(xmltb, "\n")
end

return ResSplitXml2lua
