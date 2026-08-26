-- chunkname: @modules/logic/gm/view/profiler/LuaProfilerController.lua

module("modules.logic.gm.view.profiler.LuaProfilerController", package.seeall)

local LuaProfilerController = class("LuaProfilerController")
local RunState = {
	Ready = 0,
	Running = 1
}
local memoryFuncCollectIgnoreFile = {
	"LuaProfilerController",
	"GM"
}

function LuaProfilerController:ctor()
	self._funMemoryState = RunState.Ready
	self._luaMemoryState = RunState.Ready
end

local maxMemory = 0
local memoryList = {}
local luaFunMemoryCalBeginTime = 0
local luaMemoryCalBeginTime = 0

function LuaProfilerController:luaFunMemoryCalBegin()
	if self._funMemoryState ~= RunState.Ready then
		return
	end

	self._funMemoryState = RunState.Running
	luaFunMemoryCalBeginTime = os.time()

	LuaProfilerController.SC_StartRecordAlloc(false)
end

function LuaProfilerController:luaFunMemoryCalEnd()
	if self._funMemoryState ~= RunState.Running then
		return
	end

	local fileName = LuaProfilerController.getFileName("luaFunMemory")

	LuaProfilerController.SC_StopRecordAllocAndDumpStat(fileName)

	self._funMemoryState = RunState.Ready
end

function LuaProfilerController:luaMemoryCalBegin()
	if self._luaMemoryState ~= RunState.Ready then
		return
	end

	self._luaMemoryState = RunState.Running
	luaMemoryCalBeginTime = os.time()

	TaskDispatcher.runRepeat(self._calLuaMemory, self, 1)
end

function LuaProfilerController:luaMemoryCalEnd()
	if self._luaMemoryState ~= RunState.Running then
		return
	end

	TaskDispatcher.cancelTask(self._calLuaMemory, self)

	local time = os.time() - luaMemoryCalBeginTime
	local str = ""

	str = str .. "Lua内存统计时间：" .. time .. "s\n"
	str = str .. "----------------------\n"
	str = str .. "占用最大内存：" .. maxMemory .. "\n"

	if #memoryList > 0 then
		for _, value in ipairs(memoryList) do
			value.memory = value.memory / 1024
		end

		local maxValues, minValues = self:getMemoryPeakValue(memoryList)

		if #maxValues > 0 and #minValues > 0 and #maxValues >= #minValues then
			str = str .. "Lua GC消耗：\n"

			for i = 1, #maxValues do
				if minValues[i] then
					str = str .. "GC 耗时：" .. minValues[i].time - maxValues[i].time .. "s, 释放内存：" .. maxValues[i].memory .. "-->" .. minValues[i].memory .. "MB\n"
				end
			end
		end

		str = str .. "Lua内存占用统计：\n"

		for _, value in ipairs(memoryList) do
			str = str .. value.time .. " : " .. value.memory .. "MB\n"
		end
	end

	SLFramework.FileHelper.WriteTextToPath(LuaProfilerController.getFileName("luaMemory"), str)

	memoryList = {}
	maxMemory = 0
	self._luaMemoryState = RunState.Ready
end

function LuaProfilerController.getFileName(typeString)
	local time = os.time()
	local filePath = SLFramework.FrameworkSettings.PersistentResRootDir .. "/luaMemoryTest/" .. typeString .. time

	filePath = typeString == "luaMemory" and filePath .. ".log" or filePath .. ".csv"

	print("filePath:" .. filePath)

	return filePath
end

function LuaProfilerController:_calLuaMemory()
	local curMemory = collectgarbage("count")

	memoryList[#memoryList + 1] = {
		time = os.time(),
		memory = curMemory
	}

	if curMemory > maxMemory then
		maxMemory = curMemory
	end
end

local function findMaxValueInNestedTable(tbl, key, compareValue)
	local max_value = compareValue
	local maxTable

	for i = 1, #tbl do
		local value = tbl[i]

		if value[key] and max_value < value[key] then
			max_value = value[key]
			maxTable = value
		end

		if maxTable ~= nil and max_value > value[key] then
			return i, maxTable
		end
	end

	return #tbl, maxTable
end

local function findMinValueInNestedTable(tbl, key, compareValue)
	local min_value = compareValue
	local minTable

	for i = 1, #tbl do
		local value = tbl[i]

		if value[key] and min_value > value[key] then
			min_value = value[key]
			minTable = value
		end

		if minTable ~= nil and min_value < value[key] then
			return i, minTable
		end
	end

	return #tbl, minTable
end

local function getSubTable(tbl, startindex, endindex)
	local subTable = {}

	startindex = startindex <= 1 and 1 or startindex

	for i = startindex, endindex do
		subTable[#subTable + 1] = tbl[i]
	end

	return subTable
end

function LuaProfilerController:getMemoryPeakValue(memoryList)
	local needFindMax = true
	local maxValues = {}
	local minValues = {}
	local i = 1

	while i < #memoryList do
		if needFindMax then
			if #minValues > 0 then
				if not minValues[#minValues].memory then
					local compareValue = 0
					local index, value = findMaxValueInNestedTable(getSubTable(memoryList, i, #memoryList), "memory", compareValue)

					index = index + i - 1
					i = index
					needFindMax = false

					if value then
						maxValues[#maxValues + 1] = value
					end
				end
			end
		elseif #maxValues > 0 then
			if not maxValues[#maxValues].memory then
				local compareValue = 0
				local index, value = findMinValueInNestedTable(getSubTable(memoryList, i, #memoryList), "memory", compareValue)

				index = index + i - 1
				i = index
				needFindMax = true

				if value then
					minValues[#minValues + 1] = value
				end
			end
		end
	end

	return maxValues, minValues
end

local memStat = {}
local currentMem = 0
local statLine = true

local function RecordAlloc(event, lineNo)
	local memInc = collectgarbage("count") - currentMem

	if memInc <= 1e-06 then
		currentMem = collectgarbage("count")

		return
	end

	local s = debug.getinfo(2, "S").source

	for i = 1, #memoryFuncCollectIgnoreFile do
		if string.find(s, memoryFuncCollectIgnoreFile[i]) then
			currentMem = collectgarbage("count")

			return
		end
	end

	if statLine then
		s = string.format("%s__%d", s, lineNo - 1)
	end

	local item = memStat[s]

	if not item then
		memStat[s] = {
			s,
			1,
			memInc
		}
	else
		item[2] = item[2] + 1
		item[3] = item[3] + memInc
	end

	currentMem = collectgarbage("count")
end

function LuaProfilerController.SC_StartRecordAlloc(igoreLine)
	if debug.gethook() then
		LuaProfilerController.SC_StopRecordAllocAndDumpStat()

		return
	end

	memStat = {}
	currentMem = collectgarbage("count")
	statLine = not igoreLine

	debug.sethook(RecordAlloc, "l")
end

function LuaProfilerController.SC_StopRecordAllocAndDumpStat(filename)
	debug.sethook()

	if not memStat then
		return
	end

	local sorted = {}

	for k, v in pairs(memStat) do
		table.insert(sorted, v)
	end

	table.sort(sorted, function(a, b)
		return a[3] > b[3]
	end)

	filename = filename or "memAlloc.csv"

	local file = io.open(filename, "w")

	if not file then
		logError("can't open file:", filename)

		return
	end

	local totalTime = os.time() - luaFunMemoryCalBeginTime

	file:write("collectTotalTime:" .. totalTime .. " s \n")
	file:write("fileLine, count, mem K, avg K\n")

	for _, v in ipairs(sorted) do
		file:write(string.format("%s, %d, %f, %f\n", v[1], v[2], v[3], v[3] / v[2]))
	end

	file:close()

	memStat = nil
end

local eventInfos = {}
local isCollecting = false
local beginCollectTime = 0

function LuaProfilerController:collectEventIsOpen()
	return isCollecting
end

function LuaProfilerController:collectEventParams(eventName, params, cbObjName)
	if not isCollecting then
		return
	end

	eventInfos = eventInfos or {}

	local paramTypes = {}

	if params then
		for i = 1, #params do
			table.insert(paramTypes, type(params[i]))
		end
	end

	if params then
		if not #params then
			local paramsCount = 0
			local key = eventName .. paramsCount

			eventInfos[key] = eventInfos[key] or {
				dispatchCount = 0,
				cbObjName = cbObjName,
				eventName = eventName,
				paramsCount = paramsCount,
				paramTypes = paramTypes
			}
			eventInfos[key].dispatchCount = eventInfos[key].dispatchCount + 1
		end
	end
end

function LuaProfilerController:collectEventParamsState()
	isCollecting = not isCollecting

	if not isCollecting then
		self:dumpEventInfos()

		eventInfos = {}
	else
		beginCollectTime = os.time()
	end
end

function LuaProfilerController:dumpEventInfos()
	local filename = self.getFileName("eventInfos")
	local file = io.open(filename, "w")

	if not file then
		logError("can't open file:", filename)

		return
	end

	table.sort(eventInfos, function(a, b)
		return a.dispatchCount > b.dispatchCount
	end)
	file:write("collectTotalTime:" .. os.time() - beginCollectTime .. " s \n")
	file:write("cbObjName, eventName, paramsCount, paramTypes, dispatchCount\n")

	for _, v in pairs(eventInfos) do
		file:write(string.format("%s, %s, %d, %s, %d\n", v.cbObjName, v.eventName, v.paramsCount, table.concat(v.paramTypes, "|"), v.dispatchCount))
	end

	file:close()
end

LuaProfilerController.instance = LuaProfilerController.New()

return LuaProfilerController
