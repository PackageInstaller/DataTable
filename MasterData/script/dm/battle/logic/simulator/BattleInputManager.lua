-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/simulator/BattleInputManager.lua

BattleInputManager = class("BattleInputManager")

BattleInputManager:has("_currentFrame", {
	is = "rw"
})

function BattleInputManager:initialize(skillConfig)
	super.initialize(self)
end

function BattleInputManager:reset()
	self._currentFrame = 0
	self._inputHistory = {}
	self._comingInputs = {}
	self._nextUnprocessedIndex = 1
end

function BattleInputManager:dumpInputHistory()
	local inputHistory = self._inputHistory

	if inputHistory == nil then
		return nil
	end

	local dumped = {}

	for i = 1, #inputHistory do
		local input = inputHistory[i]

		dumped[i] = {
			frame = input.frame,
			playerId = input.playerId,
			op = input.op,
			args = input.args
		}
	end

	return dumped
end

function BattleInputManager:restore(data)
	for i = 1, #data do
		local input = data[i]

		self:addInputAtFrame(input.frame, input.playerId, input.op, input.args)
	end
end

function BattleInputManager:appendInput(playerId, op, args, callback)
	if not self._inputHistory then
		return nil
	end

	self._inputHistory[#self._inputHistory + 1] = {
		frame = self._currentFrame,
		playerId = playerId,
		op = op,
		args = args,
		callback = callback
	}

	return true
end

function BattleInputManager:nextInput()
	if self._inputHistory == nil then
		return nil
	end

	local input = self._inputHistory[self._nextUnprocessedIndex]

	if input ~= nil then
		local idx = self._nextUnprocessedIndex

		self._nextUnprocessedIndex = idx + 1

		return idx, input.playerId, input.op, input.args, input.callback
	end

	return nil
end

function BattleInputManager:addInputAtFrame(frame, playerId, op, args, callback)
	local currentFrame = self._currentFrame

	if frame < currentFrame then
		return nil
	end

	if frame == currentFrame then
		return self:appendInput(playerId, op, args, callback)
	end

	self._comingInputs[#self._comingInputs + 1] = {
		frame = frame,
		playerId = playerId,
		op = op,
		args = args,
		callback = callback
	}

	return true
end

function BattleInputManager:addInputInAdvance(advance, playerId, op, args, callback)
	return self:addInputAtFrame(self._currentFrame + advance, playerId, op, args, callback)
end

function BattleInputManager:flushComingInputs()
	local comingInputs = self._comingInputs
	local n = #comingInputs

	if n == 0 then
		return
	end

	local currentFrame = self._currentFrame
	local inputHistory = self._inputHistory
	local idx = #inputHistory + 1
	local epos

	for i = 1, n do
		local input = comingInputs[i]

		if currentFrame >= input.frame then
			idx = idx + 1
			inputHistory[idx] = input
			comingInputs[i] = nil

			if epos == nil then
				epos = i
			end
		elseif epos ~= nil then
			epos = epos + 1
			comingInputs[epos] = input
			comingInputs[i] = nil
		end
	end
end
