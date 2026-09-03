-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleFSMAction.lua

BattleActionState = class("BattleActionState", State, _M)

function BattleActionState:update(_, dt)
	self:updateTimers(dt)
end

function BattleActionState:finish()
	self._timers = nil
end

local __NullTimer__ = "NullTimer"

function BattleActionState:startTimer(timeout, callback)
	local timer = BattleTimer:new(timeout, callback)
	local timers = self._timers

	if timers == nil then
		self._timers = {
			timer
		}
	else
		timers[#timers + 1] = timer
	end

	timer:restart()

	return timer
end

function BattleActionState:updateTimers(dt)
	local timers = self._timers

	if timers ~= nil then
		local cntTimers = #timers
		local done = 0

		for i = 1, cntTimers do
			local timer = timers[i]

			if timer:tick(dt) then
				timers[i] = __NullTimer__
				done = done + 1
			end
		end

		if done > 0 then
			local eidx = 1

			for i = 1, #timers do
				local timer = timers[i]

				if timers[i] == __NullTimer__ then
					timers[i] = nil
				else
					if i ~= eidx then
						timers[eidx] = timer
						timers[i] = nil
					end

					eidx = eidx + 1
				end
			end
		end
	end
end

BattleFSMAction = class("BattleFSMAction", BattleAction, _M)

function BattleFSMAction:initialize()
	super.initialize(self)
end

function BattleFSMAction:getFSM()
	return self._fsm
end

function BattleFSMAction:changeState(newState, ...)
	if self._fsm then
		self._fsm:changeState(newState, ...)
	end
end

function BattleFSMAction:doStart(battleContext)
	local initState = self:willStartWithContext(battleContext)

	if initState then
		self._fsm = StateMachine:new(self)

		self._fsm:changeState(initState)
	else
		self:finish()
	end
end

function BattleFSMAction:doUpdate(dt)
	self._fsm:update(dt)
end

function BattleFSMAction:willStartWithContext(battleContext)
	return ActionFinishState:new()
end

ActionFinishState = class("ActionFinishState", BattleActionState, _M)

function ActionFinishState:enter(battleAction)
	battleAction:finish()
end
