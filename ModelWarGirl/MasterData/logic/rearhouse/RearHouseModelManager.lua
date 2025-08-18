-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseModelManager.lua

local GameSettings = require("Helper/GameSettings")
local RearHouseModelManager = {}
local self = RearHouseModelManager
local FOV_THRESHOLD = 15
local minRow, maxRow, minCol, maxCol
local COUNTER = 0
local COUNTER_THRESHOLD = 5
local MAX_HERO_NUM = 40

function RearHouseModelManager.init(state)
	self.state = state
	self.curHeroModelNum = 0
	self._isFarMode = true
	COUNTER = 0
	self.maxHeroNum = self.maxHeroNum or MAX_HERO_NUM
end

function RearHouseModelManager.destroy(...)
	self.state = nil
	self.bounds = nil
	COUNTER = 0
	self.curHeroModelNum = nil
end

function RearHouseModelManager.checkLoadHigh(...)
	if self.state == nil then
		return
	end

	if COUNTER <= COUNTER_THRESHOLD then
		COUNTER = COUNTER + 1

		return
	end

	COUNTER = 0

	if self.isLimitModelQuality() == false then
		return
	end

	self.bounds = self.getCurCameraFieldBounds() or {}
	minRow, maxRow, minCol, maxCol = self.state:getCameraAreaRowCol()
	self.bounds.minRow = minRow
	self.bounds.maxRow = maxRow
	self.bounds.minCol = minCol
	self.bounds.maxCol = maxCol

	if self.state.fov >= FOV_THRESHOLD then
		self:onCameraFar()
	else
		self:onCameraNear()
	end

	return true
end

function RearHouseModelManager.isLimitModelQuality(...)
	return true
end

function RearHouseModelManager.getCurCameraFieldBounds(...)
	if self.bounds == nil and self.state then
		self.bounds = {}
		minRow, maxRow, minCol, maxCol = self.state:getCameraAreaRowCol()
		self.bounds.minRow = minRow
		self.bounds.maxRow = maxRow
		self.bounds.minCol = minCol
		self.bounds.maxCol = maxCol
	end

	return self.bounds
end

function RearHouseModelManager.isFarMode(...)
	return self._isFarMode
end

function RearHouseModelManager.onCameraFar(...)
	self._isFarMode = true
end

function RearHouseModelManager.onCameraNear(...)
	self._isFarMode = false
end

function RearHouseModelManager.onLowModelNumChange(removeOrCreateNum)
	if self.curHeroModelNum then
		self.curHeroModelNum = self.curHeroModelNum + removeOrCreateNum * 1
	end
end

function RearHouseModelManager.onHighModelNumChange(removeOrCreateNum)
	if self.curHeroModelNum then
		self.curHeroModelNum = self.curHeroModelNum + removeOrCreateNum * 2
	end
end

function RearHouseModelManager.isMustDestroyHigh()
	if self.curHeroModelNum then
		return self.curHeroModelNum > (self.maxHeroNum or MAX_HERO_NUM)
	end

	return false
end

function RearHouseModelManager.setMaxHeroNum(num)
	self.maxHeroNum = num
end

return RearHouseModelManager
