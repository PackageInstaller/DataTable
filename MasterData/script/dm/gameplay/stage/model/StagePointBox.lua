-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/StagePointBox.lua

StageElementType = {
	kBoxTimes = "BOX_TIMES",
	kBoxTrap = "BOX_TRAP",
	kBox = "BOX",
	kQuestion = "QUESTION",
	kBoxRun = "BOX_RUN",
	kBoxMario = "BOX_MARIO"
}
StageBoxState = {
	kCannotReceive = -1,
	kHasReceived = 1,
	kCanReceive = 0
}
StagePointBox = class("StagePointBox", objectlua.Object, _M)

StagePointBox:has("_config", {
	is = "rw"
})
StagePointBox:has("_boxType", {
	is = "rw"
})
StagePointBox:has("_boxState", {
	is = "rw"
})
StagePointBox:has("_owner", {
	is = "rw"
})

function StagePointBox:initialize(config)
	super.initialize(self)

	self._config = config
	self._boxType = config.type
	self._boxState = StageBoxState.kCannotReceive
	self._owner = nil
end

function StagePointBox:dispose()
	super.dispose(self)
end

function StagePointBox:sync(data)
	return
end

function StagePointBox:getBoxState()
	if self._boxState == 0 then
		if self._owner:isPass() then
			return StageBoxState.kCanReceive
		else
			return StageBoxState.kCannotReceive
		end
	else
		return self._boxState
	end
end

function StagePointBox:hasRedPoint()
	return self:getBoxState() == StageBoxState.kCanReceive
end

NormalPointBox = class("NormalPointBox", StagePointBox, _M)

function NormalPointBox:initialize(config)
	super.initialize(self, config)
end

function NormalPointBox:dispose()
	super.dispose(self)
end

function NormalPointBox:sync(data)
	if data.status then
		self:setBoxState(data.status)
	end
end

function NormalPointBox:getReward()
	return self._config.reward
end

MarioPointBox = class("MarioPointBox", StagePointBox, _M)

MarioPointBox:has("_times", {
	is = "rw"
})

function MarioPointBox:initialize(config)
	super.initialize(self, config)

	self._times = 0
end

function MarioPointBox:dispose()
	super.dispose(self)
end

function MarioPointBox:sync(data)
	super.sync(self, data)

	if data.times then
		self:setTimes(data.times)
	end
end

function MarioPointBox:getRealBoxState()
	local owner = self._owner

	if owner:isPass() then
		local times = self._config.times

		if times <= self._times then
			return StageBoxState.kHasReceived
		else
			return StageBoxState.kCanReceive
		end
	else
		return StageBoxState.kCannotReceive
	end
end

function MarioPointBox:getBoxState()
	local owner = self._owner

	if owner:isPass() then
		if self._times > 0 then
			return StageBoxState.kHasReceived
		else
			return StageBoxState.kCanReceive
		end
	else
		return StageBoxState.kCannotReceive
	end
end

function MarioPointBox:getReward()
	return self._config.reward
end

QuestionPointBox = class("QuestionPointBox", StagePointBox, _M)

function QuestionPointBox:initialize(config)
	super.initialize(self, config)
end

function QuestionPointBox:dispose()
	super.dispose(self)
end

function QuestionPointBox:getBoxState()
	local owner = self._owner

	if owner:isPass() then
		return StageBoxState.kCanReceive
	else
		return StageBoxState.kCannotReceive
	end
end

function QuestionPointBox:getReward()
	return nil
end

function QuestionPointBox:hasRedPoint()
	return false
end

TimesPointBox = class("TimesPointBox", StagePointBox, _M)

TimesPointBox:has("_times", {
	is = "rw"
})

function TimesPointBox:initialize(config)
	super.initialize(self, config)

	self._times = 0
end

function TimesPointBox:dispose()
	super.dispose(self)
end

function TimesPointBox:sync(data)
	super.sync(self, data)

	if data.times then
		self:setTimes(data.times)
	end
end

function TimesPointBox:getBoxState()
	local owner = self._owner

	if owner:isPass() then
		local continue = self._config.continue

		if continue == 1 then
			return StageBoxState.kCanReceive
		else
			local content = self._config.content
			local times = content[#content].times

			if times <= self._times then
				return StageBoxState.kHasReceived
			else
				return StageBoxState.kCanReceive
			end
		end
	else
		return StageBoxState.kCannotReceive
	end
end

function TimesPointBox:getContentMaps()
	if self._contentMap == nil then
		self._contentMap = {}

		local content = self._config.content

		for i = 1, #content do
			local record = content[i]

			self._contentMap[record.times] = record
		end
	end

	return self._contentMap
end

function TimesPointBox:getReward()
	return self._config.content[1].reward
end

function TimesPointBox:hasRedPoint()
	local content = self._config.content
	local firstRewardTimes = content[1].times

	return self:getBoxState() == StageBoxState.kCanReceive and firstRewardTimes > self._times
end

TrapPointBox = class("TrapPointBox", StagePointBox, _M)

TrapPointBox:has("_hasObtainEarly", {
	is = "rw"
})
TrapPointBox:has("_obtainTime", {
	is = "rw"
})

function TrapPointBox:initialize(config)
	super.initialize(self, config)

	self._hasObtainEarly = false
	self._obtainTime = -1
end

function TrapPointBox:dispose()
	super.dispose(self)
end

function TrapPointBox:sync(data)
	super.sync(self, data)

	if data.hasObtainEarly then
		self:setHasObtainEarly(data.hasObtainEarly)
	end

	if data.obtainTime then
		self:setObtainTime(data.obtainTime)
	end
end

function TrapPointBox:getBoxState()
	local owner = self._owner

	if owner:isUnlock() then
		if self._obtainTime > 0 then
			return StageBoxState.kHasReceived
		else
			return StageBoxState.kCanReceive
		end
	else
		return StageBoxState.kCannotReceive
	end
end

function TrapPointBox:getReward()
	return self._config.reward
end

function TrapPointBox:hasRedPoint()
	local owner = self._owner
	local isPass = owner:isPass()

	return self:getBoxState() == StageBoxState.kCanReceive and isPass
end

RunPointBox = class("RunPointBox", StagePointBox, _M)

RunPointBox:has("_inPoint", {
	is = "rw"
})
RunPointBox:has("_initialStatus", {
	is = "rw"
})
RunPointBox:has("_initialPoint", {
	is = "rw"
})

function RunPointBox:initialize(config)
	super.initialize(self, config)

	self._inPoint = true
	self._initialStatus = StageBoxState.kCannotReceive
	self._initialPoint = ""
end

function RunPointBox:dispose()
	super.dispose(self)
end

function RunPointBox:sync(data)
	super.sync(self, data)

	if data.inPoint ~= nil then
		self._inPoint = data.inPoint
	end

	if data.initialStatus then
		self:setInitialStatus(data.initialStatus)
	end

	if data.initialPoint then
		self:setInitialPoint(data.initialPoint)
	end
end

function RunPointBox:getBoxState()
	return
end
