-- chunkname: @modules/logic/gm/controller/PerformanceRecorder.lua

module("modules.logic.gm.controller.PerformanceRecorder", package.seeall)

local PerformanceRecorder = class("PerformanceRecorder")

function PerformanceRecorder:init()
	self._curTime = 0
	self._curFrameCount = 0
	self._curSceondTime = 0
	self._record = {}
end

function PerformanceRecorder.initProfilerConnection()
	ZProj.ProfilerConnection.Instance:Init()
	ZProj.ProfilerConnection.Instance:RegisterReceiveMsgLuaCallback(PerformanceRecorder.onProfilerMsg, PerformanceRecorder.instance)
end

function PerformanceRecorder:beginRecord(recordFrameNum)
	self._recording = true
	self._startSceondTime = os.time()
	self._startTime = Time.realtimeSinceStartup
	self._curSceondTime = 0
	self._luaMemoryList = {}
	self._allocatedMemoryList = {}
	self._reservedMemoryList = {}
	self._monoReservedMemoryList = {}
	self._monoUsedMemoryList = {}
	self._fpsList = {}
	self._monoGCCount = ZProj.ProfilerHelper.GetGCCount()
	self._monoGCAllocated = ZProj.ProfilerHelper.GetGCAllocated()
	self._monoGCAllocated2 = ZProj.ProfilerHelper.GetMonoUsedSizeLong()
	self._monoGCAmount = 0
	self._luaAllocated = ZProj.ProfilerHelper.GetLuaMemory()
	self._luaAllocateAmount = 0
	self._luaAllocateAmountMax = 0
	self._luaGCAmount = 0
	self._lowestFps = 60
	self._recordFrameNum = recordFrameNum
	self._curRecordFrame = 0
	self._beginTextureAsset = ZProj.ProfilerHelper.GetTextureAssetMemory()

	LateUpdateBeat:Add(self._lateUpdate, self)

	local beginRecordParams = {}

	beginRecordParams.sheetIdx = self._curCaseIdx
	beginRecordParams.cmd = "BeginRecord"
	beginRecordParams.frameNum = recordFrameNum

	local jsonStr = cjson.encode(beginRecordParams)

	ZProj.ProfilerConnection.Instance:SendToEditor(jsonStr)

	self._curCaseIdx = self._curCaseIdx + 1
end

function PerformanceRecorder:endRecord()
	self._endSecondTime = os.time()

	LateUpdateBeat:Remove(self._lateUpdate, self)

	local resultTable = {}

	resultTable.monoGCAmount = self._monoGCAmount

	local average, maxValue = self.getAverageAndMax(self._luaMemoryList)

	resultTable.luaMemory = {
		self._luaMemoryList[1],
		self._luaMemoryList[#self._luaMemoryList],
		average,
		maxValue
	}
	average, maxValue = self.getAverageAndMax(self._luaMemoryList)
	resultTable.luaAllocateAmount = {
		0,
		self._luaAllocateAmount,
		self._luaAllocateAmount / (self._curRecordFrame - 1),
		self._luaAllocateAmountMax
	}
	average, maxValue = self.getAverageAndMax(self._allocatedMemoryList)

	local var_4_0 = {
		self._allocatedMemoryList[1],
		self._allocatedMemoryList[#self._allocatedMemoryList]
	}

	var_4_0[3] = average
	var_4_0[4] = maxValue
	resultTable.allocatedMemory = var_4_0
	average, maxValue = self.getAverageAndMax(self._reservedMemoryList)

	local var_4_1 = {
		self._reservedMemoryList[1],
		self._reservedMemoryList[#self._reservedMemoryList]
	}

	var_4_1[3] = average
	var_4_1[4] = maxValue
	resultTable.reservedMemory = var_4_1
	average, maxValue = self.getAverageAndMax(self._monoUsedMemoryList)

	local var_4_2 = {
		self._monoUsedMemoryList[1],
		self._monoUsedMemoryList[#self._monoUsedMemoryList]
	}

	var_4_2[3] = average
	var_4_2[4] = maxValue
	resultTable.monoUsedMemory = var_4_2
	average, maxValue = self.getAverageAndMax(self._monoReservedMemoryList)

	local var_4_3 = {
		self._monoReservedMemoryList[1],
		self._monoReservedMemoryList[#self._monoReservedMemoryList]
	}

	var_4_3[3] = average
	var_4_3[4] = maxValue
	resultTable.monoReservedMemory = var_4_3

	local average, minValue = self.getAverageAndMin(self._fpsList)

	resultTable.fps = {
		self._fpsList[1],
		self._fpsList[#self._fpsList],
		average,
		minValue
	}
	resultTable.lowestFps = self._lowestFps
	resultTable.textureAssetMemory = {
		self._beginTextureAsset,
		ZProj.ProfilerHelper.GetTextureAssetMemory(),
		0,
		0
	}
	resultTable.graphicsDriverMemory = {
		0,
		ZProj.ProfilerHelper.GetGraphicsDriverMemory(),
		0,
		0
	}
	resultTable.cmd = "EndRecord"
	resultTable.frameNum = self._curRecordFrame - 1

	local jsonStr = cjson.encode(resultTable)

	ZProj.ProfilerConnection.Instance:SendToEditor(jsonStr)

	local curCaseData = self._cases[self._curCaseIdx]

	if curCaseData.screenshot then
		ZProj.ScreenCaptureUtil.Instance:CaptureScreenshotAsTexture(self._onCaptureDone, self)
	end

	logNormal("EndRecord")
	self:dispatchEvent(PerformanceRecordEvent.onRecordDone)
end

function PerformanceRecorder:endRecordByEvent()
	self._endTime = Time.realtimeSinceStartup

	self:endRecord()
end

function PerformanceRecorder:_lateUpdate()
	self._curRecordFrame = self._curRecordFrame + 1

	if self._recordFrameNum > 0 and self._curRecordFrame > self._recordFrameNum then
		self._endTime = Time.realtimeSinceStartup

		if self._recordFrameNum < 10 then
			TaskDispatcher.runDelay(self.endRecord, self, 0.75)
			LateUpdateBeat:Remove(self._lateUpdate, self)
		else
			self:endRecord()
		end

		return
	end

	self:_updatePerFrameData()

	if self._recordFrameNum <= 120 then
		if self._curRecordFrame % 10 == 1 then
			self:_updatePerSecondData()
		end
	else
		local curFrameTime = os.time()

		if curFrameTime > self._curSceondTime then
			self._curSceondTime = curFrameTime

			self:_updatePerSecondData()
		end
	end
end

function PerformanceRecorder:onProfilerMsg(msg)
	local actionStrParams = string.split(msg, "#")
	local actionStr = actionStrParams[1]

	if actionStr == "BeginRecord" then
		local recordFrameNum = tonumber(actionStrParams[2])

		self:beginRecord(recordFrameNum or 100)
	elseif actionStr == "GetDeviceInfo" then
		self:_sendDevicesInfo()
	elseif actionStr == "StartCases" then
		local allCaseStr = actionStrParams[2]

		self._cases = {}

		local caseStrList = string.split(allCaseStr, "|")

		for _, caseStr in ipairs(caseStrList) do
			local caseObj = {}
			local caseParamList = string.split(caseStr, "@")

			caseObj.preAction = caseParamList[2]
			caseObj.delay = caseParamList[3]
			caseObj.startEventParams = caseParamList[4]
			caseObj.sampleFrameNum = caseParamList[5]
			caseObj.endEventParams = caseParamList[6]
			caseObj.endAction = caseParamList[7]
			caseObj.screenshot = caseParamList[8] == "True"
			caseObj.endActionDelay = caseParamList[9]
			self._cases[#self._cases + 1] = caseObj
		end

		self:beginCheckCasesFlow()
	end
end

function PerformanceRecorder:isRecording()
	return self._recording
end

function PerformanceRecorder:exportCurFramePerformanceData()
	local framePerformanceData = {}

	framePerformanceData.LuaMemory = ZProj.ProfilerHelper.GetLuaMemory()
	framePerformanceData.TotalAllocatedMemory = ZProj.ProfilerHelper.GetTotalAllocatedMemory()
	framePerformanceData.TotalReservedMemory = ZProj.ProfilerHelper.GetTotalReservedMemory()
	framePerformanceData.MonoHeapReservedMemory = ZProj.ProfilerHelper.GetMonoHeapReservedMemory()
	framePerformanceData.MonoHeapUsedMemory = ZProj.ProfilerHelper.GetMonoHeapUsedMemory()
	framePerformanceData.TextureAssetMemory = ZProj.ProfilerHelper.GetTextureAssetMemory()

	local filePath = string.format("%s/../curFramePerformanceData.json", UnityEngine.Application.dataPath)
	local jsonStr = JsonUtil.encode(framePerformanceData)

	SLFramework.FileHelper.WriteTextToPath(filePath, jsonStr)
	logNormal(filePath)
end

function PerformanceRecorder:_updatePerFrameData()
	local curAllocated = ZProj.ProfilerHelper.GetGCAllocated()
	local curMonoGC = ZProj.ProfilerHelper.GetGCCount()

	if curMonoGC > self._monoGCCount then
		self._monoGCCount = curMonoGC
		self._monoGCAmount = self._monoGCAmount + self._monoGCAllocated - curAllocated
	end

	self._monoGCAllocated = curAllocated
	self._monoGCAllocated2 = ZProj.ProfilerHelper.GetMonoUsedSizeLong()

	local curLuaAlloctated = ZProj.ProfilerHelper.GetLuaMemory()

	if curLuaAlloctated > self._luaAllocated then
		local increase = curLuaAlloctated - self._luaAllocated

		self._luaAllocateAmount = self._luaAllocateAmount + increase
		self._luaAllocateAmountMax = math.max(self._luaAllocateAmountMax, increase)
	end

	self._luaAllocated = curLuaAlloctated
	self._lowestFps = math.min(self._lowestFps, 1 / Time.deltaTime)
	self._fpsList[#self._fpsList + 1] = 1 / Time.deltaTime
end

function PerformanceRecorder:_updatePerSecondData()
	local newIdx = #self._luaMemoryList + 1

	self._luaMemoryList[newIdx] = ZProj.ProfilerHelper.GetLuaMemory()
	self._allocatedMemoryList[newIdx] = ZProj.ProfilerHelper.GetTotalAllocatedMemory()
	self._reservedMemoryList[newIdx] = ZProj.ProfilerHelper.GetTotalReservedMemory()
	self._monoReservedMemoryList[newIdx] = ZProj.ProfilerHelper.GetMonoHeapReservedMemory()
	self._monoUsedMemoryList[newIdx] = ZProj.ProfilerHelper.GetMonoHeapUsedMemory()
end

function PerformanceRecorder.getAverageAndMax(valueList)
	local maxValue = 0
	local valueSum = 0

	for i = 1, #valueList do
		valueSum = valueSum + valueList[i]
		maxValue = math.max(maxValue, valueList[i])
	end

	return valueSum / #valueList, maxValue
end

function PerformanceRecorder.getAverageAndMin(valueList)
	local minValue = 999
	local valueSum = 0

	for i = 1, #valueList do
		valueSum = valueSum + valueList[i]
		minValue = math.min(minValue, valueList[i])
	end

	return valueSum / #valueList, minValue
end

function PerformanceRecorder:_onCaptureDone(texture2d)
	local bytes = UnityEngine.ImageConversion.EncodeToPNG(texture2d)

	ZProj.ProfilerConnection.Instance:SendToEditor(bytes)
end

local gradeStrDict = {
	[ModuleEnum.Performance.High] = "High",
	[ModuleEnum.Performance.Middle] = "Middle",
	[ModuleEnum.Performance.Low] = "Low"
}

function PerformanceRecorder:_sendDevicesInfo()
	local deviceName = UnityEngine.SystemInfo.deviceModel
	local cpuName = BootNativeUtil.getCpuName()
	local gpuName = UnityEngine.SystemInfo.graphicsDeviceName
	local memory = UnityEngine.SystemInfo.systemMemorySize
	local grade, by = HardwareUtil.getPerformanceGrade()
	local gradeStr = gradeStrDict[grade]
	local deviceInfo = {}

	deviceInfo.deviceName = deviceName
	deviceInfo.cpuName = cpuName
	deviceInfo.gpuName = gpuName
	deviceInfo.memory = memory .. "M"
	deviceInfo.DPI = UnityEngine.Screen.dpi
	deviceInfo.resolution = UnityEngine.Screen.currentResolution:ToString()
	deviceInfo.grade = gradeStr
	deviceInfo.cmd = "DeviceInfo"

	local jsonStr = cjson.encode(deviceInfo)

	ZProj.ProfilerConnection.Instance:SendToEditor(jsonStr)
end

function PerformanceRecorder:beginCheckCasesFlow()
	local sequence = FlowSequence.New()
	local workInterval = 3

	self._curCaseIdx = 0

	for _, caseItem in ipairs(self._cases) do
		if not string.nilorempty(caseItem.preAction) then
			sequence:addWork(DoStringActionWork.New(caseItem.preAction))
		end

		if not string.nilorempty(caseItem.startEventParams) then
			sequence:addWork(WaitEventWork.New(caseItem.startEventParams))
		end

		local delaySec = 0

		if not string.nilorempty(caseItem.delay) then
			delaySec = tonumber(caseItem.delay)
		end

		local recordFrameNum = tonumber(caseItem.sampleFrameNum) or 120

		sequence:addWork(DelayDoFuncWork.New(self.beginRecord, self, delaySec, (not string.nilorempty(caseItem.endEventParams) or nil) and -1))

		if not string.nilorempty(caseItem.endEventParams) then
			sequence:addWork(WaitEventWork.New(caseItem.endEventParams))
			sequence:addWork(DelayDoFuncWork.New(self.endRecordByEvent, self, 0))
		else
			sequence:addWork(WaitRecordDoneWork.New())
		end

		if not string.nilorempty(caseItem.endAction) then
			local endActionDelaySec = 0

			if not string.nilorempty(caseItem.endActionDelay) then
				endActionDelaySec = tonumber(caseItem.endActionDelay)
			end

			if endActionDelaySec > 0 then
				sequence:addWork(BpWaitSecWork.New(endActionDelaySec))
			end

			sequence:addWork(DoStringActionWork.New(caseItem.endAction))
		end

		sequence:addWork(BpWaitSecWork.New(workInterval))
	end

	sequence:start()
end

function PerformanceRecorder:doProfilerCmdAction(cmdList)
	self._record = {}
	self._recordDataCmdList = {}

	for _, cmdData in ipairs(cmdList) do
		local cmd = cmdData.cmd
		local stopCmd = cmdData.stop
		local action = self:_getProfilerAciton(cmd)

		if action then
			local frame = cmdData.frame

			if frame then
				if frame > 1 then
					-- block empty
				elseif frame == 1 then
					-- block empty
				end
			else
				self:addProfilerAcitonInUpdate(cmd)
			end
		elseif cmd == "WaitSceond" then
			-- block empty
		end

		if stopCmd then
			self:removeProfilerAcitonInUpdate(stopCmd)
		end
	end

	if self.workFlow then
		self.workFlow:registerDoneListener(self.onFlowDone, self)
		self.workFlow:start()
	end
end

function PerformanceRecorder:_getProfilerAciton(cmd)
	if self._cmdActionDict == nil then
		self._cmdActionDict = {}
		self._cmdActionDict.GetTextureMemory = self.recordTextureMemory
		self._cmdActionDict.WaitSceond = nil
		self._cmdActionDict.GetLuaMemory = self.recordLuaMemory
		self._cmdActionDict.LogMonoMemory = self.logMonoMemory
		self._cmdActionDict.LogMonoGCInfo = self.logMonoGCInfo
		self._cmdActionDict.LogLuaMemory = self.logLuaMemory
		self._cmdActionDict.LogRenderData = self.logRenderDataAction
		self._cmdActionDict.LogTextureMemory = self.logTextureMemory
	end

	return self._cmdActionDict[cmd]
end

function PerformanceRecorder:_getStopProfilerAciton(cmd)
	if self._stopActionDict == nil then
		self._stopActionDict = {}
		self._stopActionDict.GetRenderData = self.stopLogRenderDataAction
		self._stopActionDict.LogMonoGCInfo = self.stopLogMonoGCInfoAction
	end

	return self._stopActionDict[cmd]
end

function PerformanceRecorder:addProfilerAcitonInUpdate(cmd)
	local profilerAction = self:_getProfilerAciton(cmd)

	if profilerAction then
		if not self._secondsProfilerAcitons then
			self._secondsProfilerAcitons = {}

			LateUpdateBeat:Add(self.doProfilerAcitonInUpdate, self)
		end

		self._secondsProfilerAcitons[cmd] = profilerAction
	end
end

function PerformanceRecorder:removeProfilerAcitonInUpdate(stopCmd)
	local stopAction = self:_getStopProfilerAciton(stopCmd)

	if not self._secondsProfilerAcitons then
		return
	end

	self._secondsProfilerAcitons[stopCmd] = nil

	if tabletool.len(self._secondsProfilerAcitons) == 0 then
		LateUpdateBeat:Remove(self.doProfilerAcitonInUpdate, self)
	end

	if stopAction then
		stopAction(self)
	end
end

function PerformanceRecorder:doProfilerAcitonInUpdate()
	if not self._secondsProfilerAcitons then
		return
	end

	self._curSceondTime = self._curSceondTime or 0

	local curFrameTime = os.time()

	if curFrameTime <= self._curSceondTime then
		return
	end

	self._curSceondTime = curFrameTime

	local actionCount = 0

	for _, action in pairs(self._secondsProfilerAcitons) do
		actionCount = actionCount + 1

		action(self)
	end

	if actionCount == 0 then
		LateUpdateBeat:Remove(self.doProfilerAcitonInUpdate, self)
	end
end

function PerformanceRecorder:getTextureMemory()
	return ZProj.ProfilerHelper.GetTextureAssetMemory()
end

function PerformanceRecorder:recordTextureMemory(frame)
	if not frame then
		self._record[#self._record + 1] = self:getTextureMemory()
	else
		if frame == 0 then
			self._record[#self._record + 1] = {}
		end

		local frameData = self._record[#self._record]

		frameData[frame + 1] = self:getTextureMemory()
	end
end

function PerformanceRecorder:getLuaMemory()
	return ZProj.ProfilerHelper.GetLuaMemory()
end

function PerformanceRecorder:recordLuaMemory(frame)
	if not frame then
		self._record[#self._record + 1] = self:getLuaMemory()
	else
		if frame == 0 then
			self._record[#self._record + 1] = {}
		end

		local frameData = self._record[#self._record]

		frameData[frame + 1] = self:getLuaMemory()
	end
end

function PerformanceRecorder:logLuaMemory()
	local luaMemoryValue = self:getLuaMemory()

	BenchmarkApi.AndroidLog(string.format("LuaMemory:%.2f MB", luaMemoryValue))
end

function PerformanceRecorder:logMonoMemory()
	local monoMemory = ZProj.ProfilerHelper.GetGCAllocated()

	BenchmarkApi.AndroidLog(string.format("MonoMemory:%.2f MB", Bitwise[">>"](monoMemory, 10) / 1024))
end

function PerformanceRecorder:logMonoGCInfo()
	local curGCCount = ZProj.ProfilerHelper.GetGCCount()

	self._gcCount = self._gcCount or curGCCount

	if curGCCount > self._gcCount then
		BenchmarkApi.AndroidLog(string.format("GCCount:%d", curGCCount - self._gcCount))

		self._gcCount = curGCCount
	end
end

function PerformanceRecorder:logUnuseMemory()
	local unusedMemory = ZProj.ProfilerHelper.GetGCAllocated()

	BenchmarkApi.AndroidLog(string.format("Unuse Memory:%f MB", unusedMemory))
end

function PerformanceRecorder:logTotalMemory()
	local totalUsedMemory = ZProj.ProfilerHelper.GetTotalAllocatedMemory()
	local totalReservedMemory = ZProj.ProfilerHelper.GetTotalReservedMemory()

	BenchmarkApi.AndroidLog(string.format("Total:%.2f / %.2f MB", totalUsedMemory, totalReservedMemory))
end

function PerformanceRecorder:logRenderDataAction()
	if SLFramework.NativeUtil.IsAndroidX8664() then
		logWarn("X86_64 not support Catch Render Data For the [ShadowHook] is not supported On X86")

		return
	end

	self._benchMarkInited = self._benchMarkInited or BenchmarkApi.init()

	if not self._benchMarkInited then
		return
	end

	if not self._benchMarkInlineHooked then
		BenchmarkApi.hook()

		self._benchMarkInlineHooked = true
	end

	if self._catchedFrameData then
		self._catchedFrameData = false

		local drawCall = BenchmarkApi.pop_draw_num()

		drawCall = self:getReadableNum(drawCall)

		local vertCount = BenchmarkApi.pop_num_vertices()

		vertCount = self:getReadableNum(vertCount)

		local triCount = BenchmarkApi.pop_num_triangles()

		triCount = self:getReadableNum(triCount)

		BenchmarkApi.AndroidLog(string.format("DrawCall:%s|VertCount:%s|TriCount:%s", drawCall, vertCount, triCount))
	end

	if not self._catchedFrameData then
		BenchmarkApi.clearInfo()
		BenchmarkApi.CatchSingleFrameData()

		self._catchedFrameData = true
	end
end

function PerformanceRecorder:logTextureMemory()
	local textureMemory = self:getTextureMemory()

	BenchmarkApi.AndroidLog(string.format("TextrueMemory:%.0f MB", textureMemory))
end

function PerformanceRecorder:stopLogRenderDataAction()
	if not self._benchMarkInited then
		return
	end

	if self._benchMarkInlineHooked then
		BenchmarkApi.clearInfo()
		BenchmarkApi.unhook()
	end

	self._catchedFrameData = false
end

function PerformanceRecorder:stopLogMonoGCInfoAction()
	self._gcCount = nil
end

function PerformanceRecorder:getReadableNum(num)
	if num < 1000 then
		return num
	elseif num < 1000000 then
		num = num / 1000

		return string.format("%.1f", num) .. "k"
	else
		num = num / 1000000

		return string.format("%.1f", num) .. "m"
	end
end

function PerformanceRecorder:onFlowDone()
	local result = {}

	for idx, data in ipairs(self._record) do
		local cmdData = self._recordDataCmdList[idx]

		result[idx .. cmdData.cmd] = data
	end

	local resultJson = JsonUtil.encode(result)
	local directory = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "profiler")
	local fileName = "profilerResult.json"
	local path = System.IO.Path.Combine(directory, fileName)
	local file = io.open(path, "w")

	file:write(tostring(resultJson))
	file:close()
	BenchmarkApi.AndroidLog(resultJson)

	self.flow = nil
end

PerformanceRecorder.instance = PerformanceRecorder.New()

LuaEventSystem.addEventMechanism(PerformanceRecorder.instance)

return PerformanceRecorder
