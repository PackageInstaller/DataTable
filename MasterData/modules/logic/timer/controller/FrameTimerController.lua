-- chunkname: @modules/logic/timer/controller/FrameTimerController.lua

module("modules.logic.timer.controller.FrameTimerController", package.seeall)

local FrameTimerController = class("FrameTimerController", BaseController)
local FrameTimer = _G.FrameTimer
local tinsert = table.insert
local rawset = _G.rawset
local callWithCatch = _G.callWithCatch
local sTimerPool = {}
local sRunningTimer = {}

local function _putBackToPool(timer)
	if not timer then
		return
	end

	if not timer.func then
		return
	end

	timer:Stop()
	rawset(sRunningTimer, timer.func, nil)

	timer.func = nil

	tinsert(sTimerPool, timer)
end

local function _stopAll()
	for _, timer in pairs(sRunningTimer) do
		_putBackToPool(timer)
	end
end

function FrameTimerController:onInit()
	self:reInit()
end

function FrameTimerController:reInit()
	_stopAll()
end

function FrameTimerController:register(cb, cbObj, frameCount, times)
	frameCount = frameCount or 3
	times = times or 1

	local timer

	local function wrapperFunc()
		if cb then
			callWithCatch(cb, cbObj)
		end

		if timer.loop <= 0 then
			_putBackToPool(timer)
		end
	end

	if #sTimerPool > 0 then
		timer = table.remove(sTimerPool)

		timer:Reset(wrapperFunc, frameCount, times)
	else
		timer = FrameTimer.New(wrapperFunc, frameCount, times)
	end

	sRunningTimer[wrapperFunc] = timer

	return timer
end

function FrameTimerController:unregister(timer)
	_putBackToPool(timer)
end

function FrameTimerController.onDestroyViewMember(Self, mamberName)
	if Self[mamberName] then
		_putBackToPool(Self[mamberName])

		Self[mamberName] = nil
	end
end

FrameTimerController.instance = FrameTimerController.New()

return FrameTimerController
