-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleCompositeActions.lua

BattleSequenceAction = class("BattleSequenceAction", BattleAction, _M)

function BattleSequenceAction:initialize(...)
	super.initialize(self)

	self._subactions = {
		...
	}
end

function BattleSequenceAction:addAction(action)
	self._subactions[#self._subactions + 1] = action

	return self
end

function BattleSequenceAction:doStart(battleContext)
	local nextIndex = 1
	local startNextAction = function()
		local action = self._subactions[nextIndex]

		self._currentAction = action

		if action ~= nil then
			nextIndex = nextIndex + 1

			action:start(battleContext, startNextAction)
		else
			self:finish()
		end
	end

	startNextAction()
end

function BattleSequenceAction:doUpdate(dt)
	if self._currentAction then
		self._currentAction:update(dt)
	end
end

BattleParallelAction = class("BattleParallelAction", BattleAction, _M)

function BattleParallelAction:initialize(...)
	super.initialize(self)

	self._subactions = {
		...
	}
end

function BattleParallelAction:addAction(action)
	self._subactions[#self._subactions + 1] = action

	return self
end

function BattleParallelAction:doStart(battleContext)
	local function onSubactionEnded(action)
		local activeActions = self._activeActions

		activeActions[action] = nil
		activeActions.n = activeActions.n - 1
	end

	self._activeActions = {
		n = 0
	}

	local activeActions = self._activeActions
	local subactions = self._subactions

	for i = 1, #subactions do
		local action = subactions[i]

		activeActions[action] = true
		activeActions.n = activeActions.n + 1

		action:start(battleContext, onSubactionEnded)
	end

	if activeActions.n <= 0 then
		self:finish()
	end
end

function BattleParallelAction:doUpdate(dt)
	local activeActions = self._activeActions
	local subactions = self._subactions

	for i = 1, #subactions do
		local action = subactions[i]

		if activeActions[action] then
			action:update(dt)
		end
	end

	if activeActions.n <= 0 then
		self:finish()
	end
end
