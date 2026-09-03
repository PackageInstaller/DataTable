-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleViewContext.lua

EVT_Battle_Hp_Changed = "EVT_Battle_Hp_Changed"
EVT_Battle_Rp_Changed = "EVT_Battle_Rp_Changed"
EVT_Battle_Shield_Changed = "EVT_Battle_Shield_Changed"
EVT_Battle_UnitDie = "EVT_Battle_UnitDie"
EVT_BATTLE_SHOW_BUFF = "EVT_BATTLE_SHOW_BUFF"
EVT_BATTLE_HIDE_BUFF = "EVT_BATTLE_HIDE_BUFF"
EVT_BATTLE_POINT_READY = "EVT_BATTLE_POINT_READY"
BattleEvent = class("BattleEvent", Event, _M)

BattleEvent:has("_battleMediator", {
	is = "rw"
})

BattleViewContext = class("BattleViewContext", DisposableObject, _M)

BattleViewContext:has("_injector", {
	is = "rw"
})
BattleViewContext:has("_eventDispatcher", {
	is = "r"
})
BattleViewContext:has("_timeScale", {
	is = "rw"
})
BattleViewContext:has("_timeFactor", {
	is = "rw"
})
BattleViewContext:has("_bulletTimeFactor", {
	is = "rw"
})
BattleViewContext:has("_scheduler", {
	is = "r"
})
BattleViewContext:has("_scalableScheduler", {
	is = "r"
})
BattleViewContext:has("_battleDelegate", {
	is = "rw"
})

function BattleViewContext:initialize()
	super.initialize(self)

	self._namedValues = {}
	self._skillActions = {}
	self._eventDispatcher = EventDispatcher:new()
	self._isBattleFinished = false
	self._battleResult = nil
	self._timeScale = 1
	self._timeFactor = 1
	self._bulletTimeFactor = 1
	self._scheduler = LuaScheduler:new()

	self._scheduler:start()

	self._scalableScheduler = {
		schedule = function(_, callback, interval, triggerImmediately)
			return self._scheduler:schedule(function(task, dt)
				local timeScale = self:getTimeScale() or 1
				local timeFactor = self:getTimeFactor() or 1
				local bulletTime = self:getValue("bulletTimeEnabled") and self:getBulletTimeFactor() or 1

				return callback(task, dt * ((bulletTime == 1 or nil) and (timeScale * timeFactor or bulletTime)))
			end, interval, triggerImmediately)
		end
	}
end

function LuaScheduler:stop(stopAll)
	if stopAll then
		for i, task in ipairs(self._tasks) do
			task:stop()
		end
	end

	if self.tickEntry ~= nil then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.tickEntry)

		self.tickEntry = nil
	end
end

function BattleViewContext:dispose()
	self._scalableScheduler = nil

	if self._scheduler ~= nil then
		self._scheduler:stop(true)

		self._scheduler = nil
	end

	if self._eventDispatcher ~= nil then
		self._eventDispatcher:clearAllListeners()

		self._eventDispatcher = nil
	end

	super.dispose(self)
end

function BattleViewContext:finishBattle(result)
	self._battleResult = result
end

function BattleViewContext:isBattleFinished()
	return self._battleResult ~= nil
end

function BattleViewContext:queryBattleResult()
	return self._battleResult
end

function BattleViewContext:setValue(name, value)
	self._namedValues[name] = value
end

function BattleViewContext:getValue(name)
	return self._namedValues[name]
end

function BattleViewContext:getInstance(clazz, named)
	return self._injector and self._injector:getInstance(clazz, named)
end

function BattleViewContext:addEventListener(type, target, listener, priority)
	if self._eventDispatcher ~= nil then
		self._eventDispatcher:addEventListener(type, target, listener, false, priority or 0)
	end
end

function BattleViewContext:removeEventListener(type, target, listener)
	if self._eventDispatcher ~= nil then
		self._eventDispatcher:removeEventListener(type, target, listener, false)
	end
end

function BattleViewContext:dispatch(event)
	if self._eventDispatcher then
		if event.setBattleMediator then
			event:setBattleMediator(self:getValue("BattleMainMediator"))
		end

		self._eventDispatcher:dispatchEvent(event)
	end
end

function BattleViewContext:schedule(callback, interval, triggerImmediately)
	local scheduler = self:getScheduler()

	if scheduler == nil then
		return nil
	end

	return scheduler:schedule(callback, interval, triggerImmediately)
end

function BattleViewContext:scalableSchedule(callback, interval, triggerImmediately)
	local scheduler = self:getScalableScheduler()

	if scheduler == nil then
		return nil
	end

	return scheduler:schedule(callback, interval, triggerImmediately)
end

function BattleViewContext:runActionTask(duration, updateFunc, endFunc)
	updateFunc(0)

	return self:scalableSchedule(actionFunction(duration, updateFunc, endFunc))
end

function BattleViewContext:callWithDelay(seconds, func)
	assert(func ~= nil, "invalid arguments")

	local cdtime = seconds

	return self:scalableSchedule(function(task, dt)
		if cdtime == nil then
			task:stop()

			return
		end

		cdtime = cdtime - dt

		if cdtime <= 0 then
			cdtime = nil

			task:stop()
			func()
		end
	end)
end

function BattleViewContext:addSkillAction(act, skillAction)
	self._skillActions[act] = skillAction
end

function BattleViewContext:delSkillAction(act)
	local skillAction = self._skillActions[act]
	local unitManager = self:getValue("BattleUnitManager")
	local targets = skillAction:getTargets()

	for roleId, v in pairs(targets) do
		local role = unitManager:getUnitById(roleId)

		if role then
			role:subActivateNums(act)
		end
	end

	if skillAction then
		skillAction:dispose()

		skillAction = nil
	end

	self._skillActions[act] = nil
end

function BattleViewContext:getSkillAction(act)
	return self._skillActions[act]
end

function BattleViewContext:getSkillActions()
	return self._skillActions
end
