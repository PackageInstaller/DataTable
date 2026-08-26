-- chunkname: @modules/logic/common/obj/LuaPingObj.lua

module("modules.logic.common.obj.LuaPingObj", package.seeall)
require("tolua.reflection")
tolua.loadassembly("UnityEngine.CoreModule")

local Type_Ping = tolua.findtype("UnityEngine.Ping")
local Method_isDone = tolua.getproperty(Type_Ping, "isDone")
local Method_time = tolua.getproperty(Type_Ping, "time")
local kTimeoutFrameCount = 300
local LuaPingObj = class("LuaPingObj", UserDataDispose)

function LuaPingObj:ctor(timeoutFrames)
	self:__onInit()

	self._timeoutFrameCount = timeoutFrames or kTimeoutFrameCount

	self:reset()
end

function LuaPingObj:setCompletedCb(cb, cbObj)
	self._onCompletedCb = cb
	self._onCompletedCbObj = cbObj
end

function LuaPingObj:setTimeoutCb(cb, cbObj)
	self._onTimeoutCb = cb
	self._onTimeoutCbObj = cbObj
end

function LuaPingObj:setTimeoutFrames(timeoutFrames)
	self._timeoutFrameCount = timeoutFrames or kTimeoutFrameCount
end

function LuaPingObj:reset(ip)
	self:_release()

	self._isValid = false
	self._ms = -1
	self._frameCount = 0

	if string.nilorempty(ip) then
		return
	end

	self._ip = string.find(ip, "www") and SLFramework.UnityHelper.ParseDomainToIp(ip) or ip
	self._pingObj = tolua.createinstance(Type_Ping, self._ip)

	self:_poll()
end

function LuaPingObj:onDestroy()
	self:onDestroyView()
end

function LuaPingObj:onDestroyView()
	self:setCompletedCb(nil, nil)
	self:setTimeoutCb(nil, nil)
	self:reset()
	self:__onDispose()
end

function LuaPingObj:_release()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	if not gohelper.isNil(self._pingObj) then
		self._pingObj = nil
	end
end

function LuaPingObj:_poll()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._fTimer = FrameTimerController.instance:register(self._onTickCheck, self, 1, 199999)

	self._fTimer:Start()
end

function LuaPingObj:_onTickCheck()
	if gohelper.isNil(self._pingObj) then
		self:reset()

		return
	end

	local isDone = Method_isDone:Get(self._pingObj, nil)

	if not isDone then
		self._frameCount = self._frameCount + 1

		if self._frameCount >= self._timeoutFrameCount then
			self:_onTimeout()
		end
	else
		self:_onPollDone()
	end
end

function LuaPingObj:_onPollDone()
	if self._isValid then
		return
	end

	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._isValid = true
	self._ms = Method_time:Get(self._pingObj, nil)

	self:_execCb(self._onCompletedCb, self._onCompletedCbObj)
end

function LuaPingObj:_onTimeout()
	self._isValid = false

	self:_release()
	self:_execCb(self._onTimeoutCb, self._onTimeoutCbObj)
end

function LuaPingObj:_execCb(cb, cbObj)
	if not cb then
		return
	end

	if cbObj then
		callWithCatch(cb, cbObj, self)
	else
		callWithCatch(cb, self)
	end
end

function LuaPingObj:isValid()
	return self._isValid
end

function LuaPingObj:ms()
	return (self._isValid or nil) and (self._ms or -1)
end

function LuaPingObj:ip()
	return self._ip
end

return LuaPingObj
