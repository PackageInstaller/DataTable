-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/user/controller/UserPerformanceSampler.lua

module("logic.extensions.user.controller.UserPerformanceSampler", package.seeall)

local UserPerformanceSampler = class("UserPerformanceSampler", BaseController)
local SystemInfo = UnityEngine.SystemInfo
local PerformanceInfo = {
	deviceName = 0,
	resolution = 0,
	memory = 0,
	userId = 0,
	realTimeFrameRate = 0,
	logic = 0,
	hdr = false,
	cpuModel = 0,
	realTimeFrameVariance = 0,
	gameFrameRate = 0,
	gpuModel = 0,
	effectLevel = 0,
	antiAliasing = false,
	platform = Astral.OSDef.RunOS
}
local kLogicEnum = {
	DUNGEON_0x4 = 100004,
	RETRIEVE = 3,
	DUNGEON_0x1 = 100001,
	MAIN_NORMAL = 1,
	DUNGEON_0x2 = 100002,
	DUNGEON_1x2 = 110102,
	DUNGEON_1x4 = 110103,
	DUNGEON_1x5 = 110119,
	DUNGEON_1x3 = 110118,
	MAIN_SECRET = 2,
	DUNGEON_1x1 = 110101,
	DUNGEON_0x3 = 100003
}
local kLogicEnumName = {
	[kLogicEnum.MAIN_NORMAL] = "主场景普通时间",
	[kLogicEnum.MAIN_SECRET] = "主场景密室时间",
	[kLogicEnum.RETRIEVE] = "抽卡"
}
local kMonitorDuration = 3

function UserPerformanceSampler:ctor()
	self._monitorTable = {}

	self:_setupMonitorTable()

	self._totalTime = 0
	self._totalFrame = 0
	self._totalTimeOfSquare = 0
	self._currentLogicEnum = 0

	self:_setEvent(true)
end

function UserPerformanceSampler:onReset()
	self:_stopMonitor()
end

function UserPerformanceSampler:luaUpdate(deltaTime)
	self._totalFrame = self._totalFrame + 1
	self._totalTime = self._totalTime + deltaTime
	self._totalTimeOfSquare = self._totalTimeOfSquare + deltaTime * deltaTime

	if self._totalTime >= kMonitorDuration then
		self:_stopMonitor()
	end
end

function UserPerformanceSampler:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
		GlobalDispatcher:addEventListener(RetrieveEventType.Begin_Show_Lottery, self._onRetrieveStart, self)
		GlobalDispatcher:addEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._onShowMainViewFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_BEGIN, self._onSceneChanged, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
		GlobalDispatcher:removeEventListener(RetrieveEventType.Begin_Show_Lottery, self._onRetrieveStart, self)
		GlobalDispatcher:removeEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._onShowMainViewFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_BEGIN, self._onSceneChanged, self)
	end
end

function UserPerformanceSampler:_setupMonitorTable()
	for _, value in pairs(kLogicEnum) do
		self._monitorTable[value] = true
	end
end

function UserPerformanceSampler:_onSceneChanged()
	self:_stopMonitor()
end

function UserPerformanceSampler:_onShowMainViewFinish()
	local isInAirtightTime = AirtightRoomController.instance:getIsInAirtightTime()
	local logicEnum = isInAirtightTime and kLogicEnum.MAIN_SECRET or kLogicEnum.MAIN_NORMAL

	self:_startMonitor(logicEnum)
end

function UserPerformanceSampler:_onBattleStart()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if not dungeonCode then
		return
	end

	self:_startMonitor(dungeonCode)
end

function UserPerformanceSampler:_onRetrieveStart()
	self:_startMonitor(kLogicEnum.RETRIEVE)
end

function UserPerformanceSampler:_startMonitor(logicEnum)
	if not self._monitorTable[logicEnum] then
		return
	end

	self:_stopMonitor()

	self._totalTime = 0
	self._totalFrame = 0
	self._totalTimeOfSquare = 0
	self._currentLogicEnum = logicEnum
	self._monitorTable[logicEnum] = nil

	FrameUpdate:addListener(self)
end

function UserPerformanceSampler:_stopMonitor()
	if self._currentLogicEnum <= 0 then
		return
	end

	self:_sendPerformanceMetric()
	self:_checkAllMonitorFinish()
	FrameUpdate:removeListener(self)

	self._totalTime = 0
	self._totalFrame = 0
	self._totalTimeOfSquare = 0
	self._currentLogicEnum = 0
end

function UserPerformanceSampler:_checkAllMonitorFinish()
	local count = table.nums(self._monitorTable)

	if count <= 0 then
		self:_setEvent(false)
	end
end

function UserPerformanceSampler:_sendPerformanceMetric(avgFPS)
	if self._totalFrame <= 0 then
		return
	end

	local performanceInfo = PerformanceInfo

	self:_fillUserSetting(performanceInfo)
	self:_fillDeviceInfo(performanceInfo)

	local timePreFrame = self._totalTime / self._totalFrame
	local timePreFrameSquare = self._totalTimeOfSquare / self._totalFrame
	local avgFPS = math.floor(1 / timePreFrame)
	local variance = (timePreFrameSquare - timePreFrame * timePreFrame) * avgFPS

	performanceInfo.logic = self:_getPrettyLogicName(self._currentLogicEnum)
	performanceInfo.realTimeFrameRate = avgFPS
	performanceInfo.realTimeFrameVariance = variance

	UserAgent.instance:sendDevicePerformanceMetricRequest(performanceInfo)
end

function UserPerformanceSampler:_getPrettyLogicName(logicEnum)
	local specificName = kLogicEnumName[logicEnum]

	if specificName then
		return specificName
	end

	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(logicEnum)

	if not dungeonCO then
		return logicEnum
	end

	local dungeonTypeName = DungeonConfig.instance:getDungeonTypeName(dungeonCO.type)
	local dungeonName = string.nilorempty(dungeonCO.index) and dungeonCO.name or dungeonCO.index

	return string.format("%s%s(%s)", dungeonTypeName, dungeonName, logicEnum)
end

function UserPerformanceSampler:_fillUserSetting(performanceInfo)
	local current = GfxModel.instance:getCurGfx()
	local isAntialiasingOn = PlayerLocalStorageModel.instance:getAntialiasingSwitch()
	local isHDROn = PlayerLocalStorageModel.instance:getOpenHdr()

	performanceInfo.resolution = GfxConfig.resolution2Index(current.resolution)
	performanceInfo.effectLevel = current.effectQuality
	performanceInfo.gameFrameRate = current.frameRate
	performanceInfo.hdr = isHDROn
	performanceInfo.antiAliasing = isAntialiasingOn
	performanceInfo.level = current.level
end

function UserPerformanceSampler:_fillDeviceInfo(performanceInfo)
	performanceInfo.deviceName = SystemInfo.deviceModel
	performanceInfo.cpuModel = SystemInfo.processorType
	performanceInfo.gpuModel = SystemInfo.graphicsDeviceName
	performanceInfo.memory = SystemInfo.systemMemorySize
end

UserPerformanceSampler.instance = UserPerformanceSampler.New()

return UserPerformanceSampler
