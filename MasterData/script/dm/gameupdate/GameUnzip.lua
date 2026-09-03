-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/GameUnzip.lua

GameUnzip = GameUnzip or {}

local luaoc, luaj
local PlatformClassPath = ""
local application = cc.Application:getInstance()
local target = application:getTargetPlatform()
local isPlatformAndroid = false

if target == 3 then
	luaj = require("cocos.cocos2d.luaj")
	PlatformClassPath = "org/hardware/device/Device"
	isPlatformAndroid = true
end

local DelayMilliseconds = 1000

function GameUnzip:new()
	local result = setmetatable({}, {
		__index = GameUnzip
	})

	result:initialize()

	return result
end

function GameUnzip:initialize()
	self._animTickEntry = nil
	self._callback = nil
	self._finishcallback = nil
	self._time = 1
end

function GameUnzip:setCallback(callback)
	self._callback = callback
end

function GameUnzip:setFinishDelegate(callback)
	self._finishcallback = callback
end

function GameUnzip:run()
	local function timeUp(time)
		if self._time >= 20 then
			self:stopSchedule()

			if self._callback then
				self._callback({
					type = "failed"
				})
			end
		end

		self._time = self._time + 1

		if self._animTickEntry ~= nil then
			local ret = self:requestUnzipState()

			if ret and ret == -1 then
				-- block empty
			elseif ret and ret == 0 then
				self:stopSchedule()

				if self._callback then
					self._callback({
						type = "success"
					})
				end
			elseif ret and ret == 3 then
				-- block empty
			elseif ret and ret == 4 then
				-- block empty
			elseif ret and ret == 5 then
				if self._callback then
					self._callback({
						type = "unziping"
					})
				end
			else
				self:stopSchedule()

				if self._callback then
					self._callback({
						type = "failed"
					})
				end
			end
		end
	end

	local delay = (DelayMilliseconds or 0) * 0.001

	self._animTickEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(timeUp, delay, false)
end

function GameUnzip:stopSchedule()
	if self._animTickEntry then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._animTickEntry)

		self._animTickEntry = nil
		self._time = 1
	end
end

function GameUnzip:requestUnzipState()
	local ok, ret = luaj.callStaticMethod(PlatformClassPath, "checkObbFile", {}, "()I")

	if ok then
		return ret
	end

	return nil
end

function GameUnzip:excuteFinishCmd()
	if self._finishcallback() then
		self._finishcallback()
	end
end

function GameUnzip:checkOBBFinish()
	return true
end

function GameUnzip:print(fmt, ...)
	return
end
