-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Load\\LoadPhase.lua

local strClassName = "LoadPhase"
local LoadPhase = Class(strClassName)

function LoadPhase:ctor(mgr, doLoad)
	self.mgr = mgr
	self._core = doLoad
	self.mRunning = false
	self.mComplete = false
end

function LoadPhase:clear()
	return
end

function LoadPhase:start()
	self.mComplete = false
	self.mRunning = true

	self._core:start()
end

function LoadPhase:getRate()
	self.mCurRate = self._core:getRate()
	self.mComplete = self.mCurRate == 1

	if self.mComplete then
		self.mRunning = false
	end

	return self.mCurRate
end

function LoadPhase:getMaxRate()
	return self._core.mMaxRate
end

function LoadPhase:onInterupt()
	return true
end

return LoadPhase
