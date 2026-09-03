-- chunkname: @/tmp/or_script/lua_compile/dm/battle/interactor/RTPVPBattleDirector.lua

require("dm.battle.interactor.BattleDirector")
require("dm.battle.interactor.RTPVPPlayerController")
require("socket")

local socket = require("socket")

RTPVPBattleDirector = class("RTPVPBattleDirector", BattleDirector)

RTPVPBattleDirector:has("_viewContext", {
	is = "r"
})
RTPVPBattleDirector:has("_lastSyncClientFrame", {
	is = "r"
})

local kReadyGoFrame = 0

function RTPVPBattleDirector:initialize(simulator, service)
	super.initialize(self)
	assert(simulator ~= nil, "Invalid argument #1")
	assert(service ~= nil, "Invalid argument #2")

	self._opsCache = {}
	self._opList = {}
	self._opId = 0
	self._service = service
	self._battleSimulator = simulator
	self._lastConfirmFrame = 0
	self._tprCache = {}
end

function RTPVPBattleDirector:_clientSpeedUp()
	local delay = self._maxReachableFrame - self._frameCounter

	newScale = delay < 4 and 1 or delay < 20 and (delay + 2) / 2 or (delay + 10) / 10

	self._service:speedUp(newScale)
end

function RTPVPBattleDirector:update(interval)
	if self._lastSyncClientFrame and self._maxReachableFrame then
		self._lastSyncClientFrame = self._lastSyncClientFrame + interval

		if self._lastSyncClientFrame > 35000 then
			DpsLogger:fatal("rtpvp", "Server Crash")
			self._service:stopTick()

			return
		end
	end

	for i = #self._opList, 1, -1 do
		local opId = self._opList[i]
		local frameData = self._opsCache[opId].data

		if not self._maxReachableFrame or frameData.frame >= self._maxReachableFrame then
			break
		end

		if not self._opsCache[opId].received then
			DpsLogger:error("rtpvp", "TimeOutFrame: {}", frameData)

			if self._opsCache[opId].callback then
				self._opsCache[opId].callback(false, "ReqTimeOut")
			end
		end

		table.remove(self._opList, i)

		self._opsCache[opId] = nil
	end

	return super.update(self, interval)
end

function RTPVPBattleDirector:sendMessage(msg, args, callback)
	if self._maxReachableFrame then
		if not GameConfigs.rtpvpDelayFrame then
			local delayFrame = 20
			local eventFrame = self._maxReachableFrame + delayFrame

			self._opId = self._opId + 1

			local data = {
				msg = msg,
				args = args,
				frame = eventFrame,
				id = self._opId
			}

			table.insert(self._opList, 1, self._opId)

			self._opsCache[self._opId] = {
				data = data,
				callback = callback,
				ts = socket.gettime()
			}

			self._service:operate(data, function(resp)
				if resp.resCode ~= GS_SUCCESS then
					callback(false, "ReqTimeOut")
				end
			end)

			return true
		end
	end

	return false
end

function RTPVPBattleDirector:start()
	self._maxReachableFrame = kReadyGoFrame

	super.start(self)
	self._service:ready()
end

function RTPVPBattleDirector:createPlayerController()
	return RTPVPPlayerController:new(self)
end

function RTPVPBattleDirector:getNetDelay()
	return self._service:getAgent():getNetDelay()
end

function RTPVPBattleDirector:syncFrameEvent(data)
	if self._maxReachableFrame == nil then
		return
	end

	local frameList = data.frameDatas

	for _, frameData in ipairs(frameList) do
		if not frameData.ops then
			local frame = frameData.frame

			if frame > self._maxReachableFrame then
				DpsLogger:info("rtpvp", "SyncFrame: {}", frameData)

				local inputManager = self._battleSimulator:getInputManager()
				local delayTotal = 0
				local delayCount = 0

				for i, op in ipairs(frameData.ops) do
					local callback

					if op.player == self._service:fetchRid() and op ~= "Leave" and op.id > 0 then
						callback = self._opsCache[op.id].callback

						local tprId = "op_" .. tostring(op.id)

						self._tprCache[tprId] = socket.gettime() - self._opsCache[op.id].ts
						self._opsCache[op.id].received = true
						delayTotal = delayTotal + self._tprCache[tprId]
						delayCount = delayCount + 1

						DpsLogger:info("rtpvp", "Id: {} RoundTime: {}", op.id, self._tprCache[tprId])
					end

					inputManager:addInputAtFrame(frame, op.player, op.msg, op.args, callback)
					DpsLogger:info("rtpvp", "frame: {} op: {}", frame, op)
				end

				self._lastSyncClientFrame = 0
				self._maxReachableFrame = frame
			end
		end
	end

	if self._maxReachableFrame >= self._lastConfirmFrame + 10 then
		DpsLogger:info("rtpvp", "ConfirmFrame: {}", self._maxReachableFrame)
		self._service:confirm(self._maxReachableFrame, self._tprCache)

		self._tprCache = {}
		self._lastConfirmFrame = self._maxReachableFrame
	end
end

function RTPVPBattleDirector:displayToTheEnd()
	self._maxReachableFrame = nil
end

function RTPVPBattleDirector:repairHome()
	self._lastSyncClientFrame = nil
end
