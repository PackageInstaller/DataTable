-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/local/MyLogTemplate.lua

module("logic.config.local.MyLogTemplate", package.seeall)

local nprint = print

local function getLogStrFromVariadicArguments(...)
	local argsSize = select("#", ...)
	local args = {
		...
	}
	local strs = {}

	for i = 1, argsSize do
		local curArg = args[i]
		local str = type(curArg) == "table" and table.serialize(curArg, 8) or tostring(curArg)

		table.insert(strs, str)
	end

	return table.concat(strs, " ")
end

local function getMsg(level, ...)
	local str = getLogStrFromVariadicArguments(...)

	level = level + 1

	local debugInfo = debug.getinfo(level, "nSl")
	local currentline = debugInfo.currentline
	local funcname = debugInfo.name or "closure"
	local source = debugInfo.source
	local what = string.find(source, ".lua") and "" or "." .. string.lower(debugInfo.what)
	local msgFileAndLine = string.format("[%s%s:%s]:", source, what, tostring(currentline))
	local msgFunAndContent = string.format("{%s}%s", funcname, str)

	if Astral.OSDef.isEditor then
		return msgFunAndContent
	else
		return string.format("%s%s", msgFileAndLine, msgFunAndContent)
	end
end

function printError(...)
	if not enableErrorLog then
		return
	end

	local msg = getMsg(2, ...)

	if msg ~= "" then
		nprintError(string.format("%s%s", msg, debug.traceback("", 3)))
	end
end

function printWarn(...)
	if not enableWarnLog then
		return
	end

	local msg = getMsg(2, ...)

	if msg ~= "" then
		nprintWarn(string.format("%s%s", msg, debug.traceback("", 3)))
	end
end

function printInfo(...)
	if not enableLog then
		return
	end

	local msg = getMsg(2, ...)

	if msg ~= "" then
		nprint(msg)
	end
end

function forcePrint(...)
	local msg = getMsg(2, ...)

	if msg ~= "" then
		nprint(msg)
	end
end

local function dump_value_(v)
	if type(v) == "string" then
		v = "\"" .. v .. "\""
	end

	return tostring(v)
end

function dump(value, desciption, nesting)
	if type(nesting) ~= "number" then
		nesting = 3
	end

	local lookupTable = {}
	local result = {}
	local traceback = string.split(debug.traceback("", 2), "\n")

	nprint("dump from: " .. string.trim(traceback[3]))

	local function dump_(value, desciption, indent, nest, keylen)
		desciption = desciption or "<var>"

		local spc = ""

		if type(keylen) == "number" then
			spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
		end

		if type(value) ~= "table" then
			result[#result + 1] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
		elseif lookupTable[tostring(value)] then
			result[#result + 1] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
		else
			lookupTable[tostring(value)] = true

			if nest > nesting then
				result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
			else
				result[#result + 1] = string.format("%s%s = {", indent, dump_value_(desciption))

				local indent2 = indent .. "    "
				local keys = {}
				local keylen = 0
				local values = {}

				for k, v in pairs(value) do
					keys[#keys + 1] = k

					local vk = dump_value_(k)
					local vkl = string.len(vk)

					if keylen < vkl then
						keylen = vkl
					end

					values[k] = v
				end

				table.sort(keys, function(a, b)
					if type(a) == "number" and type(b) == "number" then
						return a < b
					else
						return tostring(a) < tostring(b)
					end
				end)

				for i, k in ipairs(keys) do
					dump_(values[k], k, indent2, nest + 1, keylen)
				end

				result[#result + 1] = string.format("%s}", indent)
			end
		end
	end

	dump_(value, desciption, "- ", 1)

	for i, line in ipairs(result) do
		nprint(line)
	end
end

setglobal("printError", printError)
setglobal("printWarn", printWarn)
