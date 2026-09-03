-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/ai/SequenceStrategy.lua

SequenceStrategy = class("SequenceStrategy", WeightedStrategy, _M)

function SequenceStrategy:initialize(team, random)
	super.initialize(self, team)

	self._random = random or Random:new()
	self._curCardIndex = 0
	self._changeSta = false
end

function SequenceStrategy:update(interval)
	if self._battleLogic and not self._battleLogic:isReadyForAI() then
		return
	end

	if self._battleLogic:isWaiting() and not self._ignoreWaiting then
		self._initWaitingCD = self._defaultInitWaitingCD

		return
	end

	if self._initWaitingCD and self._initWaitingCD > 0 then
		self._initWaitingCD = self._initWaitingCD - interval

		return
	end

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
		if self._changeSta then
			self._cardIndex, self._nextCard = self:determineNextCard(player)
		else
			self._cardIndex, self._nextCard = self:determineNextCardByIndex(player)
		end
	end

	if self._nextCard then
		local cost = self._nextCard:getActualCost()

		self:checkNextCardIsRelocate(player)

		if player:energyIsEnough(cost) then
			if player:getCardState() == "hero" then
				if not self._nextCard._cardAI then
					self._nextCard = nil

					return
				end

				local battleField = self._context:getObject("BattleField")
				local seatRules = self._nextCard:getSeatRules()
				local cellNo = self:determineTargetCell(battleField, player:getSide(), seatRules)
				local realcardIndex = self:getRealCardIndex(player, self._nextCard)

				if cellNo ~= nil and realcardIndex ~= nil then
					self:spawnCard(realcardIndex, cellNo, function(success, detail)
						self._waitCD = 1000

						if success then
							self._nextCard = nil
						end
					end)
				end
			elseif player:getCardState() == "skill" then
				self:spawnSkillCard(self._cardIndex, function(success, detail)
					self._waitCD = 1000

					if success then
						self._nextCard = nil
					end
				end)
			end
		end
	end
end

function SequenceStrategy:determineNextCardByIndex(player)
	if player:getCardState() == "hero" then
		self._curCardIndex = self._curCardIndex + 1

		local cardWindow = player:getCardWindow()
		local idx = (self._curCardIndex - 1) % 4 + 1
		local card = cardWindow:getCardAtIndex(idx)

		return idx, card
	end

	return nil, nil
end

function SequenceStrategy:setIsEnabled(enabled)
	self._isEnabled = enabled

	self:reset()
end

function SequenceStrategy:changeAi(enabled)
	self._changeSta = true
end
