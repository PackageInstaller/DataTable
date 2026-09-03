-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleContext.lua

BaseContextObject = class("BaseContextObject")

function BaseContextObject:initialize(parentBlackboard)
	super.initialize(self)

	self._blackboard = VariableTable:new(parentBlackboard)
end

function BaseContextObject:getBlackboard()
	return self._blackboard
end

function BaseContextObject:getVariableStorage()
	return self._blackboard:getStorage()
end

function BaseContextObject:writeVar(name, value)
	self._blackboard:write(name, value)
end

function BaseContextObject:readVar(name, default)
	local value = self._blackboard:read(name)

	if value ~= nil then
		return value
	end

	return default
end

function BaseContextObject:rawreadVar(name, default)
	local value = self._blackboard:rawread(name)

	if value ~= nil then
		return value
	end

	return default
end

BattleContext = class("BattleContext", BaseContextObject)

function BattleContext:initialize()
	super.initialize(self)

	self._idSeed = 1
	self._namedObjects = {}
end

function BattleContext:newId()
	local id = self._idSeed

	self._idSeed = id + 1

	return id
end

function BattleContext:setFrameInterval(interval)
	self._frameInterval = interval
end

function BattleContext:getFrameInterval()
	return self._frameInterval
end

function BattleContext:setBattleTime(frame, time)
	self._currentFrame = frame
	self._currentTime = time
end

function BattleContext:getCurrentFrame()
	return self._currentFrame
end

function BattleContext:getCurrentTime()
	return self._currentTime
end

function BattleContext:setObject(name, object)
	self._namedObjects[name] = object
end

function BattleContext:getObject(name)
	return self._namedObjects[name]
end

function BattleContext:random(n, m)
	local random = self._namedObjects.Randomizer

	if random then
		return random:random(n, m)
	else
		return math.random(n, m)
	end
end

function BattleContext:startup()
	self._frameInterval = 0
	self._currentFrame = 0
	self._currentTime = 0
end
