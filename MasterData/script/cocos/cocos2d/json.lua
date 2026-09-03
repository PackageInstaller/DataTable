-- chunkname: @/tmp/or_script/lua_compile/cocos/cocos2d/json.lua

local math = require("math")
local string = require("string")
local table = require("table")
local base = _G

module("json")

local decode_scanArray, decode_scanComment, decode_scanConstant, decode_scanNumber, decode_scanObject, decode_scanString, decode_scanWhitespace, encodeString, isArray, isEncodable

function encode(v)
	if v == nil then
		return "null"
	end

	local vtype = base.type(v)

	if vtype == "string" then
		return "\"" .. encodeString(v) .. "\""
	end

	if vtype == "number" or vtype == "boolean" then
		return base.tostring(v)
	end

	if vtype == "table" then
		local rval = {}
		local bArray, maxCount = isArray(v)

		if bArray then
			for i = 1, maxCount do
				table.insert(rval, encode(v[i]))
			end
		else
			for i, j in base.pairs(v) do
				if isEncodable(i) and isEncodable(j) then
					table.insert(rval, "\"" .. encodeString(i) .. "\":" .. encode(j))
				end
			end
		end

		if bArray then
			return "[" .. table.concat(rval, ",") .. "]"
		else
			return "{" .. table.concat(rval, ",") .. "}"
		end
	end

	if vtype == "function" and v == null then
		return "null"
	end

	base.assert(false, "encode attempt to encode unsupported type " .. vtype .. ":" .. base.tostring(v))
end

function decode(s, startPos)
	startPos = startPos and startPos or 1
	startPos = decode_scanWhitespace(s, startPos)

	base.assert(startPos <= string.len(s), "Unterminated JSON encoded object found at position in [" .. s .. "]")

	local curChar = string.sub(s, startPos, startPos)

	if curChar == "{" then
		return decode_scanObject(s, startPos)
	end

	if curChar == "[" then
		return decode_scanArray(s, startPos)
	end

	if string.find("+-0123456789.e", curChar, 1, true) then
		return decode_scanNumber(s, startPos)
	end

	if curChar == "\"" or curChar == "'" then
		return decode_scanString(s, startPos)
	end

	if string.sub(s, startPos, startPos + 1) == "/*" then
		return decode(s, decode_scanComment(s, startPos))
	end

	return decode_scanConstant(s, startPos)
end

function null()
	return null
end

function decode_scanArray(s, startPos)
	local array = {}
	local stringLen = string.len(s)

	base.assert(string.sub(s, startPos, startPos) == "[", "decode_scanArray called but array does not start at position " .. startPos .. " in string:\n" .. s)

	startPos = startPos + 1

	repeat
		startPos = decode_scanWhitespace(s, startPos)

		base.assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")

		local curChar = string.sub(s, startPos, startPos)

		if curChar == "]" then
			return array, startPos + 1
		end

		if curChar == "," then
			startPos = decode_scanWhitespace(s, startPos + 1)
		end

		base.assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")

		object, startPos = decode(s, startPos)

		table.insert(array, object)
	until false
end

function decode_scanComment(s, startPos)
	base.assert(string.sub(s, startPos, startPos + 1) == "/*", "decode_scanComment called but comment does not start at position " .. startPos)

	local endPos = string.find(s, "*/", startPos + 2)

	base.assert(endPos ~= nil, "Unterminated comment in string at " .. startPos)

	return endPos + 2
end

function decode_scanConstant(s, startPos)
	local consts = {
		["false"] = false,
		["true"] = true
	}
	local constNames = {
		"true",
		"false",
		"null"
	}

	for i, k in base.pairs(constNames) do
		if string.sub(s, startPos, startPos + string.len(k) - 1) == k then
			return consts[k], startPos + string.len(k)
		end
	end

	base.assert(nil, "Failed to scan constant from string " .. s .. " at starting position " .. startPos)
end

function decode_scanNumber(s, startPos)
	local endPos = startPos + 1
	local stringLen = string.len(s)
	local acceptableChars = "+-0123456789.e"

	while string.find(acceptableChars, string.sub(s, endPos, endPos), 1, true) and endPos <= stringLen do
		endPos = endPos + 1
	end

	local stringValue = "return " .. string.sub(s, startPos, endPos - 1)
	local stringEval = base.loadstring(stringValue)

	base.assert(stringEval, "Failed to scan number [ " .. stringValue .. "] in JSON string at position " .. startPos .. " : " .. endPos)

	return stringEval(), endPos
end

function decode_scanObject(s, startPos)
	local object = {}
	local stringLen = string.len(s)
	local key, value

	base.assert(string.sub(s, startPos, startPos) == "{", "decode_scanObject called but object does not start at position " .. startPos .. " in string:\n" .. s)

	startPos = startPos + 1

	repeat
		startPos = decode_scanWhitespace(s, startPos)

		base.assert(startPos <= stringLen, "JSON string ended unexpectedly while scanning object.")

		local curChar = string.sub(s, startPos, startPos)

		if curChar == "}" then
			return object, startPos + 1
		end

		if curChar == "," then
			startPos = decode_scanWhitespace(s, startPos + 1)
		end

		base.assert(startPos <= stringLen, "JSON string ended unexpectedly scanning object.")

		key, startPos = decode(s, startPos)

		base.assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)

		startPos = decode_scanWhitespace(s, startPos)

		base.assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
		base.assert(string.sub(s, startPos, startPos) == ":", "JSON object key-value assignment mal-formed at " .. startPos)

		startPos = decode_scanWhitespace(s, startPos + 1)

		base.assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)

		object[key], startPos = decode(s, startPos)
	until false
end

function decode_scanString(s, startPos)
	base.assert(startPos, "decode_scanString(..) called without start position")

	local startChar = string.sub(s, startPos, startPos)

	base.assert(startChar == "'" or startChar == "\"", "decode_scanString called for a non-string")

	local escaped = false
	local endPos = startPos + 1
	local bEnded = false
	local stringLen = string.len(s)

	repeat
		local curChar = string.sub(s, endPos, endPos)

		if not escaped then
			if curChar == "\\" then
				escaped = true
			else
				bEnded = curChar == startChar
			end
		else
			escaped = false
		end

		endPos = endPos + 1

		base.assert(endPos <= stringLen + 1, "String decoding failed: unterminated string at position " .. endPos)
	until bEnded

	local stringValue = "return " .. string.sub(s, startPos, endPos - 1)
	local stringEval = base.loadstring(stringValue)

	base.assert(stringEval, "Failed to load string [ " .. stringValue .. "] in JSON4Lua.decode_scanString at position " .. startPos .. " : " .. endPos)

	return stringEval(), endPos
end

function decode_scanWhitespace(s, startPos)
	local whitespace = " \n\r\t"
	local stringLen = string.len(s)

	while string.find(whitespace, string.sub(s, startPos, startPos), 1, true) and startPos <= stringLen do
		startPos = startPos + 1
	end

	return startPos
end

function encodeString(s)
	s = string.gsub(s, "\\", "\\\\")
	s = string.gsub(s, "\"", "\\\"")
	s = string.gsub(s, "'", "\\'")
	s = string.gsub(s, "\n", "\\n")
	s = string.gsub(s, "\t", "\\t")

	return s
end

function isArray(t)
	local maxIndex = 0

	for k, v in base.pairs(t) do
		if base.type(k) == "number" and math.floor(k) == k and k >= 1 then
			if not isEncodable(v) then
				return false
			end

			maxIndex = math.max(maxIndex, k)
		elseif k == "n" then
			if v ~= table.getn(t) then
				return false
			end
		elseif isEncodable(v) then
			return false
		end
	end

	return true, maxIndex
end

function isEncodable(o)
	local t = base.type(o)

	return t == "string" or t == "boolean" or t == "number" or t == "nil" or t == "table" or t == "function" and o == null
end
