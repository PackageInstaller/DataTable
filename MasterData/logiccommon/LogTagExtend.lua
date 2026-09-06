-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/log/LogTagExtend.lua

module("logiccommon.common.log.LogTagExtend", package.seeall)

local LogTagExtend = {}

function LogTagExtend.extend()
	LogTag.BATTLE = "[Battle]"
	LogTag.TASK = "[Task]"
	LogTag.GUIDE = "[Guide]"
	LogTag.enableBattleLog = true
	LogTag.enableTaskLog = true
	LogTag.enableGuideLog = true
end

function LogTagExtend.printBattleInfo(...)
	if LogTag.enableBattleLog == true then
		local msg = ...

		printInfo(LogTag.BATTLE .. msg)
	end
end

function LogTagExtend.printBattleWarn(...)
	if LogTag.enableBattleLog == true then
		local msg = ...

		printWarn(LogTag.BATTLE .. msg)
	end
end

function LogTagExtend.printBattleError(...)
	if LogTag.enableBattleLog == true then
		local msg = ...

		printError(LogTag.BATTLE .. msg)
	end
end

function LogTagExtend.printTaskInfo(...)
	if LogTag.enableTaskLog == true then
		local msg = ...

		printInfo(LogTag.TASK .. msg)
	end
end

function LogTagExtend.printTaskWarn(...)
	if LogTag.enableTaskLog == true then
		local msg = ...

		printWarn(LogTag.TASK .. msg)
	end
end

function LogTagExtend.printTaskError(...)
	if LogTag.enableTaskLog == true then
		local msg = ...

		printError(LogTag.TASK .. msg)
	end
end

function LogTagExtend.printGuideInfo(...)
	if LogTag.enableGuideLog == true then
		local msg = ...

		printInfo(LogTag.GUIDE .. msg)
	end
end

function LogTagExtend.printGuideWarn(...)
	if LogTag.enableGuideLog == true then
		local msg = ...

		printWarn(LogTag.GUIDE .. msg)
	end
end

function LogTagExtend.printGuideError(...)
	if LogTag.enableGuideLog == true then
		local msg = ...

		printError(LogTag.GUIDE .. msg)
	end
end

function printf(pre_str, root)
	if not root then
		return
	end

	local print = print
	local tconcat = table.concat
	local tinsert = table.insert
	local srep = string.rep
	local type = type
	local pairs = pairs
	local tostring = tostring
	local next = next
	local cache = {
		[root] = "."
	}

	local function _dump(t, space, name)
		local temp = {}

		for k, v in pairs(t) do
			local key = tostring(k)

			if cache[v] then
				tinsert(temp, "+" .. key .. " {" .. cache[v] .. "}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key

				cache[v] = new_key

				tinsert(temp, "+" .. key .. _dump(v, space .. (next(t, k) and "|" or " ") .. srep(" ", #key), new_key))
			else
				tinsert(temp, "+" .. key .. " [" .. tostring(v) .. "]")
			end
		end

		return tconcat(temp, "\n" .. space)
	end

	if pre_str then
		print(pre_str .. "\n" .. _dump(root, "", ""))
	else
		print(_dump(root, "", ""))
	end
end

LogTagExtend.extend()
setglobal("printf", printf)
setglobal("printBattleInfo", LogTagExtend.printBattleInfo)
setglobal("printBattleWarn", LogTagExtend.printBattleWarn)
setglobal("printBattleError", LogTagExtend.printBattleError)
setglobal("printTaskInfo", LogTagExtend.printTaskInfo)
setglobal("printTaskWarn", LogTagExtend.printTaskWarn)
setglobal("printTaskError", LogTagExtend.printTaskError)
setglobal("printGuideInfo", LogTagExtend.printGuideInfo)
setglobal("printGuideWarn", LogTagExtend.printGuideWarn)
setglobal("printGuideError", LogTagExtend.printGuideError)

return LogTagExtend
