-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/interpreter/BattleInterpreter.lua

kInterpNormal = "Normal"
kInterpFastForward = "FastForward"
ITLInterpreterFactory = interface("ITLInterpreterFactory")

function ITLInterpreterFactory:createTLInterpreter(typeName)
	return
end

TLInterpreter = class("TLInterpreter")

TLInterpreter:has("_id", {
	is = "rw"
})
TLInterpreter:has("_battleInterpreter", {
	is = "rw"
})

function TLInterpreter:initialize()
	super.initialize(self)
end

function TLInterpreter:getTLInterpreterById(id)
	if self._battleInterpreter == nil then
		return nil
	end

	return self._battleInterpreter:findTLInterpreter(id)
end

function TLInterpreter:doAction(action, args, mode)
	local func = self["act_" .. action]

	if func == nil then
		battlelog("warning", string.format("'%s' skipped action '%s'", self._id, action))

		return
	end

	return func(self, action, args, mode)
end

BattleInterpreter = class("BattleInterpreter")

BattleInterpreter:has("_mode", {
	is = "rw"
})

function BattleInterpreter:initialize()
	super.initialize(self)

	self._mode = kInterpNormal
end

function BattleInterpreter:setRecordsProvider(provider)
	self._recordsProvider = provider
end

function BattleInterpreter:getRecordsProvider()
	return self._recordsProvider
end

function BattleInterpreter:setTLInterpFactory(factory)
	self._tlInterpFactory = factory
end

function BattleInterpreter:getTLInterpFactory()
	return self._tlInterpFactory
end

function BattleInterpreter:setEndCallback(endCallback)
	self._endCallback = endCallback
end

function BattleInterpreter:addTLInterpreter(id, tlTypeName)
	assert(id ~= nil and tlTypeName ~= nil, "Invalid arguments")

	local tlInterpreter

	if self._tlInterpFactory ~= nil then
		tlInterpreter = self._tlInterpFactory:createTLInterpreter(tlTypeName)
	end

	if tlInterpreter == nil then
		return nil
	end

	tlInterpreter:setId(id)
	tlInterpreter:setBattleInterpreter(self)

	self._timelineInterpreters[id] = tlInterpreter

	return tlInterpreter
end

function BattleInterpreter:findTLInterpreter(id)
	return self._timelineInterpreters and self._timelineInterpreters[id]
end

function BattleInterpreter:start()
	self._timelineInterpreters = {}
	self._lastIndex = 0
	self._reachedEnding = false

	if self._recordsProvider ~= nil then
		self._recordsProvider:startProviding()
	end

	return self:_processOneFrame(0)
end

function BattleInterpreter:update(frame)
	if self._reachedEnding then
		return
	end

	if not self._lastIndex then
		local lastIndex = 0

		if frame <= lastIndex then
			return
		end

		for i = lastIndex + 1, frame do
			self._lastIndex = i

			self:_processOneFrame(i)
		end
	end
end

function BattleInterpreter:_processOneFrame(frame)
	local recordsProvider = self._recordsProvider

	if recordsProvider == nil or recordsProvider:hasReachedEnding(frame) then
		if not self._reachedEnding then
			self._reachedEnding = true

			if self._endCallback ~= nil then
				self:_endCallback()
			end
		end

		return
	end

	local newTimelines = recordsProvider:allNewTimelinesAtFrame(frame)

	if newTimelines ~= nil then
		for _, tlInfo in ipairs(newTimelines) do
			self:addTLInterpreter(tlInfo[1], tlInfo[2])
		end
	end

	local timelineInterpreters = self._timelineInterpreters
	local frameRecords = recordsProvider:allRecordsAtFrame(frame)

	if frameRecords ~= nil then
		for _, record in ipairs(frameRecords) do
			local tlInterpreter = timelineInterpreters[record[1]]

			if tlInterpreter ~= nil then
				tlInterpreter:doAction(record[2], record[3], self._mode)
			end
		end
	end
end
