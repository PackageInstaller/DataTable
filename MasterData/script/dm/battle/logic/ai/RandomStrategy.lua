-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/ai/RandomStrategy.lua

RandomStrategy = class("RandomStrategy", BaseStrategy, _M)

function RandomStrategy:initialize(team, random)
	super.initialize(self, team)

	self._random = random or Random:new()
end

function RandomStrategy:start(battleContext)
	local eventCenter = battleContext:getObject("EventCenter")

	eventCenter:addListener("GainEnergy", bind1(self.onEnergyIncreased, self), 0)

	self._context = battleContext
	self._willCheckEnergy = true
	self._cardIndex = nil
	self._nextCard = nil
	self._waitCD = 4000
end

function RandomStrategy:reset()
	self._willCheckEnergy = true
	self._cardIndex = nil
	self._nextCard = nil
	self._waitCD = 0
end

function RandomStrategy:update(interval)
	self._skillCD = self._skillCD or 1000

	if self._skillCD > 0 then
		self._skillCD = self._skillCD - interval
	else
		self._skillCD = 1000

		local avails = self:getAvailableSkill()

		if avails and #avails > 0 then
			local skillType = avails[self._random:random(1, #avails)]

			self:doSkill(skillType)
		end
	end

	if self._waitCD > 0 then
		self._waitCD = self._waitCD - interval

		return
	end

	local player = self._team:getCurPlayer()

	if self._nextCard == nil then
		self._cardIndex, self._nextCard = self:determineNextCard(player)
		self._willCheckEnergy = true
	end

	if self._willCheckEnergy and self._nextCard then
		local cost = self._nextCard:getActualCost()

		self._willCheckEnergy = false

		self:checkNextCardIsRelocate(player)

		if player:energyIsEnough(cost) then
			if not self._nextCard._cardAI then
				self._nextCard = nil

				return
			end

			local battleField = self._context:getObject("BattleField")
			local seatRules = self._nextCard:getSeatRules()
			local cellNo = self:determineTargetCell(battleField, player:getSide(), seatRules)
			local realcardIndex = self:getRealCardIndex(player, self._nextCard)

			if cellNo ~= nil and realcardIndex then
				self:spawnCard(self._cardIndex, cellNo, function(success, detail)
					self._waitCD = 1000

					if success then
						self._nextCard = nil
					end
				end)
			end
		end
	end
end

function RandomStrategy:onEnergyIncreased(_, args)
	local player = self._team:getCurPlayer()

	if args.player == player:getId() then
		self._willCheckEnergy = true
	end
end

function RandomStrategy:determineNextCard(player)
	if player:getCardState() == "hero" then
		local cardWindow = player:getCardWindow()
		local indices = {}
		local count = cardWindow:collectNonEmptyIndices(indices)

		if count > 0 then
			local r = self._random:random(1, count)
			local idx = indices[r]
			local card = cardWindow:getCardAtIndex(idx)

			return idx, card
		end
	end

	return nil, nil
end

function RandomStrategy:determineTargetCell(battleField, side)
	local emptyCells = battleField:collectEmtpyCells({}, side)
	local count = #emptyCells

	if count > 0 then
		local r = self._random:random(1, count)

		return emptyCells[r]:getNumber()
	end

	return nil
end
