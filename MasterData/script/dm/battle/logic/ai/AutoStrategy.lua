-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/ai/AutoStrategy.lua

BattleAIScheduler = class("BattleAIScheduler")

function BattleAIScheduler:initialize()
	super.initialize(self)

	self._autoStrategies = {}
	self._battleContext = nil
end

function BattleAIScheduler:schedule(autoStrategy)
	local autoStrategies = self._autoStrategies

	if autoStrategies[autoStrategy] then
		return false
	end

	autoStrategies[#autoStrategies + 1] = autoStrategy
	autoStrategies[autoStrategy] = true

	return true
end

function BattleAIScheduler:unschedule(autoStrategy)
	local autoStrategies = self._autoStrategies

	if not autoStrategies[autoStrategy] then
		return nil
	end

	for i = 1, #autoStrategies do
		if autoStrategies[i] == autoStrategy then
			autoStrategies[autoStrategy] = nil

			return table.remove(autoStrategies, i)
		end
	end

	return nil
end

function BattleAIScheduler:start(battleContext)
	local autoStrategies = self._autoStrategies
	local count = #autoStrategies

	for i = 1, count do
		local autoStrategy = autoStrategies[i]

		autoStrategy:start(battleContext)
	end
end

function BattleAIScheduler:tick(frameInterval)
	local autoStrategies = self._autoStrategies

	for i = 1, #autoStrategies do
		local autoStrategy = autoStrategies[i]

		if autoStrategy:isEnabled() then
			autoStrategy:update(frameInterval)
		end
	end
end

AutoStrategy = class("AutoStrategy", objectlua.Object, _M)

AutoStrategy:has("_controller", {
	is = "rw"
})
AutoStrategy:has("_isEnabled", {
	is = "rwb"
})

function AutoStrategy:initialize()
	super.initialize(self)

	self._isEnabled = true
end

function AutoStrategy:reset()
	return
end

function AutoStrategy:setIsEnabled(enabled)
	self._isEnabled = enabled

	self:reset()
end

function AutoStrategy:start(battleContext)
	return
end

function AutoStrategy:update(interval)
	return
end

function AutoStrategy:getRandomSeed()
	if self._random then
		return self._random:getRandomseed()
	end
end

function AutoStrategy:sendOpCommand(...)
	if self._controller then
		self._controller:sendOpCommandByPlayer(...)
	end
end

BaseStrategy = class("BaseStrategy", AutoStrategy, _M)

BaseStrategy:has("_team", {
	is = "r"
})
BaseStrategy:has("_ignoreWaiting", {
	is = "rw"
})

function BaseStrategy:initialize(team)
	super.initialize(self)

	self._team = team
end

function BaseStrategy:start(battleContext)
	self._context = battleContext
end

function BaseStrategy:spawnCard(idx, cellNo, callback)
	if cellNo == nil then
		return
	end

	if self._team then
		local player = self._team:getCurPlayer()

		if player == nil then
			return
		end

		local cardWindow = player:getCardWindow()
		local card = cardWindow:getCardAtIndex(idx)

		if card == nil then
			return
		end

		local cost = card:getActualCost()

		if player:energyIsEnough(cost) then
			self:sendOpCommand(player:getId(), "heroCard", {
				idx = idx,
				card = card:getId(),
				cellNo = cellNo
			}, callback)
		end
	end
end

function BaseStrategy:spawnSkillCard(idx, callback)
	if self._team then
		local player = self._team:getCurPlayer()

		if player == nil then
			return
		end

		local cardWindow = player:getCardWindow()
		local card = cardWindow:getCardAtIndex(idx)

		if card == nil then
			return
		end

		local cost = card:getActualCost()

		if player:energyIsEnough(cost) then
			self:sendOpCommand(player:getId(), "skillCard", {
				idx = idx,
				card = card:getId()
			}, callback)
		end
	end
end

function BaseStrategy:doSkill(skillType, callback)
	if self._team then
		local player = self._team:getCurPlayer()
		local master = player and player:getMasterUnit()

		if master == nil then
			return
		end

		if isReadyForUniqueSkill(master) then
			self:sendOpCommand(player:getId(), "doskill", {
				type = skillType
			}, callback)
		end
	end
end

function BaseStrategy:getRealCardIndex(player, card)
	local cardWindow = player:getCardWindow()

	for i = 1, cardWindow:getWindowSize() do
		local _card = cardWindow:getCardAtIndex(i)

		if _card and _card:getId() == card:getId() then
			return i
		end
	end

	return nil
end

function BaseStrategy:checkNextCardIsRelocate(player)
	if player:getCardState() == "hero" then
		local realcardIndex = self:getRealCardIndex(player, self._nextCard)

		if not realcardIndex then
			self._nextCard = nil
		end
	end
end

function BaseStrategy:getAvailableSkill()
	if self._team then
		local player = self._team:getCurPlayer()
		local master = player and player:getMasterUnit()

		if master == nil then
			return
		end

		if isReadyForUniqueSkill(master) then
			return self:getMasterSkills()
		end
	end
end

local skills = {
	kBattleMasterSkill1,
	kBattleMasterSkill2,
	kBattleMasterSkill3
}

function BaseStrategy:getMasterSkills()
	local result = {}

	if self._team then
		local player = self._team:getCurPlayer()
		local master = player and player:getMasterUnit()
		local skillComp = master and master:getComponent("Skill")

		if skillComp == nil then
			return result
		end

		for i, skillType in ipairs(skills) do
			if skillComp:getSkill(skillType) then
				result[#result + 1] = skillType
			end
		end

		return result
	end
end
