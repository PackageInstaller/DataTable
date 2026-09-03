-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/guidelogic/GuideBattleBuilder.lua

kBRGuideLine = "$GUIDE"
GuideBattleBuilder = class("GuideBattleBuilder")

GuideBattleBuilder:has("_guideLogic", {
	is = "r"
})
GuideBattleBuilder:has("_battleContext", {
	is = "r"
})

function GuideBattleBuilder:initialize()
	super.initialize(self)
end

function GuideBattleBuilder:startBattle(guideThread, battleContext)
	self._guideThread = guideThread
	self._guideLogic = guideThread:getGuideLogic()
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._battleContext = battleContext

	return self
end

function GuideBattleBuilder:finishBattle(result)
	return self._guideLogic:finish(result)
end

function GuideBattleBuilder:newTimeline(objId, typeName)
	if self._battleRecorder ~= nil then
		self._battleRecorder:newTimeline(objId, typeName)
	end

	return self
end

function GuideBattleBuilder:addObjectEvent(objId, evt, data)
	if self._battleRecorder ~= nil then
		self._battleRecorder:recordEvent(objId, evt, data)
	end

	return self
end

function GuideBattleBuilder:sleepForTime(milliseconds)
	self._guideThread:sleepForTime(milliseconds)

	return self
end

function GuideBattleBuilder:sleepForFrames(frames)
	self._guideThread:sleepForFrames(frames)

	return self
end

function GuideBattleBuilder:sleepForEvent(func, ...)
	self._guideThread:suspend(func(self._guideThread, ...))

	return self
end

function GuideBattleBuilder:processPlayerInput(cases, defaultHandler)
	if (cases == nil or next(cases) == nil) and defaultHandler == nil then
		return self
	end

	local function filter(_, op)
		return ((cases or nil) and (cases[op] or defaultHandler)) ~= nil
	end

	while true do
		local input = self._guideThread:waitPlayerInput(filter)

		if cases then
			if not cases[input.op] then
				local handler = defaultHandler

				if handler ~= nil then
					input.claimed = true

					local callback = input.cb

					if callback then
						callback(handler(self, input.pid, input.op, input.args))
					else
						handler(self, input.pid, input.op, input.args)
					end

					return self
				end
			end
		end
	end
end
