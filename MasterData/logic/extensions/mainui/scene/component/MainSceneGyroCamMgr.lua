-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneGyroCamMgr.lua

module("logic.extensions.mainui.scene.component.MainSceneGyroCamMgr", package.seeall)

local M = class("MainSceneGyroCamMgr", SceneComponentBase)
local Input = Astral.ToLuaFramework.AsInputSystem.InputSystemToLua
local gyroAngleYOffsetMax = -10
local gyroAngleXOffsetMax = 0
local filterRateX = 0.8
local filterRateY = 0.07
local ease = DG.Tweening.Ease.OutQuad

function M:onInit()
	self._frameTime = 0.01
	self._isSupport = UnityEngine.SystemInfo.supportsGyroscope
	self._isSimulate = false
	self._simulatePos = Vector3.New(0, 0, 0)
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self:_setEvent(true)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._sceneCamComp = self._scene.camera

	self:clear()
	self:setActiveGyroCamAni(true)
	self:startFrameTimer(true)

	self._blockGyro = false
end

function M:onExitScene()
	self:_setEvent(false)
	self:setActiveGyroCamAni(false)
	self:startFrameTimer(false)

	self._sceneCamComp = nil

	self:clear()
end

function M:onLeaveScene()
	self:onExitScene()
end

function M:onReturnScene()
	return
end

function M:onReturnSceneFinished()
	self:onEnterSceneFinished(self._scene:getSceneId(), self._scene:getBornX(), self._scene:getBornZ())
	self:_setEvent(true)
end

function M:clear()
	self._lastValueX = 0
	self._lastValueY = 0
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GYRO_PERFORM_DATA_GET, self._handleGyroPerformDataGet, self)
		GlobalDispatcher:addEventListener(EventType.GYRO_PERFORM_DATA_SET, self._handleGyroPerformDataSet, self)
		GlobalDispatcher:addEventListener(EventType.GYRO_PERFORM_SIMULATE, self._handleGyroPerformSimulate, self)
		GlobalDispatcher:addEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_BLOCK_GYRO_CAM, self._handleBlockGyroCam, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GYRO_PERFORM_DATA_GET, self._handleGyroPerformDataGet, self)
		GlobalDispatcher:removeEventListener(EventType.GYRO_PERFORM_DATA_SET, self._handleGyroPerformDataSet, self)
		GlobalDispatcher:removeEventListener(EventType.GYRO_PERFORM_SIMULATE, self._handleGyroPerformSimulate, self)
		GlobalDispatcher:removeEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_BLOCK_GYRO_CAM, self._handleBlockGyroCam, self)
	end
end

function M:_handleShowMainViewFinish(e, mainUIEnter)
	self:setActiveGyroCamAni(mainUIEnter)

	if not mainUIEnter then
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_UPDATE_GYRO_ANGLE, 0, 0, 0)
	end
end

function M:_handleGyroPerformDataGet(e, gyroEventId, callBackFunc, callBackHandler)
	if gyroEventId ~= MainPerformEnum.GyrosEventTyp.MainCam then
		return
	end

	local angleMaxX, angleMaxY = self:getGyroAngleOffset()
	local filterX, filterY = self:getFilterRate()
	local frameTime = self:getFrameTime()
	local gyroDuration = self._scene.camera:getGyroCamTweenDuration()

	if callBackFunc then
		if not self._cacheGyroCfgData then
			self._cacheGyroCfgData = {}
		end

		self._cacheGyroCfgData.angleMaxX = angleMaxX
		self._cacheGyroCfgData.angleMaxY = angleMaxY
		self._cacheGyroCfgData.filterX = filterX
		self._cacheGyroCfgData.filterY = filterY
		self._cacheGyroCfgData.durationGetDevice = frameTime
		self._cacheGyroCfgData.durationTween = gyroDuration

		callBackFunc(callBackHandler, self._cacheGyroCfgData)
	end
end

function M:_handleGyroPerformDataSet(e, gyroEventId, dataTable)
	if gyroEventId ~= MainPerformEnum.GyrosEventTyp.MainCam then
		return
	end

	if not dataTable then
		return
	end

	if dataTable.angleMaxX and dataTable.angleMaxY then
		self:setGyroAngleOffset(dataTable.angleMaxX, dataTable.angleMaxY)
	end

	if dataTable.filterX and dataTable.filterY then
		self:setFilterRate(dataTable.filterX, dataTable.filterY)
	end

	if dataTable.durationGetDevice then
		self:setFrameTime(dataTable.durationGetDevice)
	end

	if dataTable.durationTween then
		self._scene.camera:setGyroCamTweenDuration(dataTable.durationTween)
	end
end

function M:_handleGyroPerformSimulate(e, gyroEventId, simulateActive, x, y, z)
	if gyroEventId ~= MainPerformEnum.GyrosEventTyp.MainCam then
		return
	end

	self:setSimulate(simulateActive)

	if simulateActive then
		self:setSimulatePos(x, y, z)
	end
end

function M:_handleBlockGyroCam(e, block)
	if SceneFace.instance:getCurSceneFlowTyp() ~= SceneType.Room then
		return
	end

	self._blockGyro = block

	if block then
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_UPDATE_GYRO_ANGLE, 0, 0, 0)
	end
end

function M:setActiveGyroCamAni(active)
	self._activeGyroCamAni = active
end

function M:setSimulate(active)
	self._isSimulate = active
end

function M:startFrameTimer(start)
	if start then
		settimer(self._frameTime, self.onFrame, self, true)
	else
		removetimer(self.onFrame, self)
	end
end

function M:onFrame()
	if not self._isSupport and not self._isSimulate then
		return
	end

	if not self._activeGyroCamAni then
		return
	end

	if self._blockGyro then
		return
	end

	local mobilePos = self:getMobilePos()
	local valueY = mobilePos.x * gyroAngleYOffsetMax
	local valueX = mobilePos.y * gyroAngleXOffsetMax

	if math.abs(valueY - self._lastValueY) < filterRateY and math.abs(valueX - self._lastValueX) < filterRateX then
		return
	end

	valueX, valueY = self:_fixGyroData(valueX, valueY)
	self._lastValueX = valueX
	self._lastValueY = valueY

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_UPDATE_GYRO_ANGLE, valueX, valueY, 0)
end

function M:getMobilePos()
	local curMobilePos = Input.acceleration

	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		-- block empty
	else
		curMobilePos.x = math.random(-5, 5) / 10
		curMobilePos.y = math.random(-5, 5) / 10
		curMobilePos.z = math.random(-5, 5) / 10

		if self._isSimulate then
			curMobilePos = self._simulatePos
		end
	end

	if DeviceUtil.isEmulator() then
		curMobilePos.x = 0
		curMobilePos.y = 0
		curMobilePos.z = 0
	end

	return curMobilePos
end

function M:setSimulatePos(x, y, z)
	self._simulatePos:Set(x, y, z)
end

function M:getFilterRate()
	return filterRateX, filterRateY
end

function M:setFilterRate(x, y)
	x = x or 0

	if x < 0 then
		x = 0
	end

	y = y or 0

	if y < 0 then
		y = 0
	end

	filterRateX = x
	filterRateY = y
end

function M:getGyroAngleOffset()
	return gyroAngleXOffsetMax, gyroAngleYOffsetMax
end

function M:setGyroAngleOffset(x, y)
	x = x or 0
	x = tonumber(x)
	y = y or 0
	y = tonumber(y)
	gyroAngleXOffsetMax = x
	gyroAngleYOffsetMax = y
end

function M:getFrameTime()
	return self._frameTime
end

function M:setFrameTime(frameTime)
	frameTime = frameTime or 0
	frameTime = tonumber(frameTime)

	if frameTime < 0 then
		frameTime = 0
	end

	if self._frameTime == frameTime then
		return
	end

	self:startFrameTimer(false)

	self._frameTime = frameTime

	self:startFrameTimer(true)
end

function M:_fixGyroData(valueX, valueY)
	if not ViewMgr.instance:isOpen(ViewName.MainUIView) then
		return 0, 0
	end

	if GuideController.instance:isGuiding() then
		return 0, 0
	end

	return valueX, valueY
end

return M
