-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/ai/WeightedStrategy.lua

WeightedStrategy = class("WeightedStrategy", BaseStrategy, _M)

WeightedStrategy:has("_calcCDConfig", {
	is = "rw"
})
WeightedStrategy:has("_defaultInitWaitingCD", {
	is = "rw"
})

local defaultCalcCD = 1000

local function deepCopy(desc, src)
	local d = desc or {}

	for k, v in ipairs(src) do
		d[k] = type(v) == "table" and deepCopy({}, v) or v
	end

	return d
end

local function shuffle(rand, arr, start, ending)
	local m = start or 1
	local n = ending or #arr

	for i = m, n - 1 do
		local k = rand:random(i, n)

		if k ~= i then
			arr[i], arr[k] = arr[k], arr[i]
		end
	end

	return arr
end

function WeightedStrategy:initialize(team, random)
	super.initialize(self, team)

	self._random = random or Random:new()
	self._ignoreWaiting = true
end

function WeightedStrategy:start(battleContext)
	local eventCenter = battleContext:getObject("EventCenter")

	eventCenter:addListener("GainEnergy", bind1(self.onEnergyIncreased, self), 0)

	self._context = battleContext
	self._battleLogic = battleContext:getObject("BattleLogic")
	self._processRecorder = battleContext:getObject("ProcessRecorder")
	self._willCheckEnergy = true
	self._cardIndex = nil
	self._nextCard = nil
	self._waitCD = 0
	self._calcCD = 0
end

function WeightedStrategy:reset()
	self._willCheckEnergy = true
	self._cardIndex = nil
	self._nextCard = nil
	self._waitCD = 0
	self._calcCD = 0
end

function WeightedStrategy:update(interval)
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
			local skillType = avails[1]

			if skillType == kBattleMasterSkill1 then
				self:doSkill(skillType)
			end
		end
	end

	self._calcCD = self._calcCD - interval

	if self._waitCD > 0 then
		self._waitCD = self._waitCD - interval

		return
	end

	local player = self._team:getCurPlayer()

	if self._nextCard == nil or self._calcCD <= 0 then
		self._calcCD = self._calcCDConfig or defaultCalcCD
		self._cardIndex, self._nextCard = self:determineNextCard(player)
		self._willCheckEnergy = true
	end

	if self._willCheckEnergy and self._nextCard then
		local cost = self._nextCard:getActualCost()

		self._willCheckEnergy = false

		if player:energyIsEnough(cost) then
			if player:getCardState() == "hero" then
				if not self._nextCard._cardAI then
					self._nextCard = nil

					return
				end

				local battleField = self._context:getObject("BattleField")
				local seatRules = self._nextCard:getSeatRules()
				local cellNo = self:determineTargetCell(battleField, player:getSide(), seatRules)

				if cellNo ~= nil then
					self:spawnCard(self._cardIndex, cellNo, function(success, detail)
						self._waitCD = 1000

						if success then
							self._nextCard = nil
							self._waitCD = 0
						end
					end)
				end
			elseif player:getCardState() == "skill" then
				self:spawnSkillCard(self._cardIndex, function(success, detail)
					self._waitCD = 1000

					if success then
						self._nextCard = nil
						self._waitCD = 0
					end
				end)
			end
		end
	end
end

function WeightedStrategy:calcWeight(card, side, player)
	local statusNames = {
		"FriendMasterHP",
		"EnemyMasterHP",
		"PaddingCard",
		"UniqueRatio",
		"Curse",
		"Cost",
		"CardForce",
		"ForcedWeight"
	}

	self._status = self:calcStatus(side, card)

	local weight = 0
	local cardAI = card:getCardAI() or {}

	for index, name in ipairs(statusNames) do
		weight = weight + (tonumber(cardAI[name]) or 0) * ((not self._status[index] or nil) and 1)
	end

	if self._processRecorder and GameConfigs and GameConfigs.ShowAiWeightBox then
		self._processRecorder:recordObjectEvent(player:getId(), "CurrentBattleSt", {
			status = self._status
		})
	end

	return weight
end

function WeightedStrategy:calcSkillWeight(card)
	return (card.getAutoWeight or nil) and tonumber(card:getAutoWeight() or 0)
end

function WeightedStrategy:calcStatus(side, card)
	local cardAI = card:getCardAI() or {}
	local result = self:calcOneSideStatus(side)
	local oppoResult = self:calcOneSideStatus(opposeBattleSide(side))

	for i = 1, 1 do
		result[i + 1] = oppoResult[i]
	end

	result[3] = 1

	local battleField = self._context:getObject("BattleField")
	local units = battleField:collectLivingUnits({}, opposeBattleSide(side))
	local x = tonumber(cardAI.UniqueRatio) or 0
	local y = #units

	if x > 0 then
		result[4] = 400 / (x / y + y / x) / x or 0
	end

	local units = battleField:collectLivingUnits({}, side)
	local isMasterCurse = false

	for k, v in pairs(units) do
		if v:getUnitType() == BattleUnitType.kMaster then
			local unitFlagComp = v:getComponent("Flag")

			if unitFlagComp:hasStatus(kBECurse) then
				isMasterCurse = true
			end

			break
		end
	end

	result[5] = isMasterCurse and 1 or 0
	result[6] = -1

	local x = tonumber(cardAI.CardForce) or 0

	if x > 0 then
		result[7] = (x + 20) / x or 0
	end

	result[8] = 1

	return result
end

function WeightedStrategy:calcOneSideStatus(side)
	local result = {
		1,
		1,
		1,
		1
	}
	local battleField = self._context:getObject("BattleField")
	local units = battleField:collectLivingUnits({}, side)
	local masterHp
	local minHP = 1
	local totalHpPercent = 0
	local heroCounts = 0

	for _, unit in ipairs(units) do
		local hpComp, hpRatio

		if unit:getUnitType() == BattleUnitType.kMaster then
			hpComp = unit:getComponent("Health")
			hpRatio = hpComp:getHpRatio()
			masterHp = hpRatio
		else
			heroCounts = heroCounts + 1
			hpComp = unit:getComponent("Health")
			hpRatio = hpComp:getHpRatio()
		end

		minHP = hpRatio <= minHP and minHP or hpRatio
		totalHpPercent = totalHpPercent + hpRatio
	end

	masterHp = masterHp and masterHp >= 0.5 and 0 or 1
	result[1] = masterHp

	return result
end

function WeightedStrategy:onEnergyIncreased(_, args)
	local player = self._team:getCurPlayer()

	if args.player == player:getId() then
		self._willCheckEnergy = true
	end
end

function WeightedStrategy:determineNextCard(player)
	local cardWindow = player:getCardWindow()
	local indices = {}
	local count = cardWindow:collectNonEmptyIndices(indices)

	if count > 0 then
		if count == 1 then
			local idx = indices[1]
			local card = cardWindow:getCardAtIndex(idx)

			return idx, card
		end

		local result = {}

		self._status = nil

		local side = player:getSide()

		for i, idx in ipairs(indices) do
			local card = cardWindow:getCardAtIndex(idx)
			local weight = 0

			if player:getCardState() == "hero" then
				weight = self:calcWeight(card, side, player)
			elseif player:getCardState() == "skill" then
				weight = self:calcSkillWeight(card)
			end

			result[i] = {
				idx,
				card,
				weight
			}

			if self._processRecorder and GameConfigs and GameConfigs.ShowAiWeightBox then
				self._processRecorder:recordObjectEvent(player:getId(), "UpdateCardWeight", {
					cardInfos = {
						idx,
						[3] = weight
					}
				})
			end
		end

		table.sort(result, function(a, b)
			return a[3] > b[3]
		end)

		if self._processRecorder and GameConfigs and GameConfigs.ShowAiWeightBox then
			self._processRecorder:recordObjectEvent(player:getId(), "MaxCardWeight", {
				cardInfos = result[1][1]
			})
		end

		return result[1][1], result[1][2]
	end

	return nil, nil
end

function WeightedStrategy:determineTargetCell(battleField, side, seatRules)
	local emptyCells = battleField:collectEmtpyCells({}, side)
	local residentCells = {}

	if next(seatRules) then
		local allCells = battleField:collectCells({}, side)

		for k, v in pairs(allCells) do
			local resident = v:getResident()
			local canBeSit = false

			if resident then
				for rule, _ in pairs(seatRules) do
					if rule == "SUMMONED" then
						canBeSit = resident._isSummoned
					else
						local flagComp = resident:getComponent("Flag")

						canBeSit = flagComp:hasFlag(rule)
					end

					if canBeSit then
						break
					end
				end

				if canBeSit then
					residentCells[#residentCells + 1] = v
				end
			end
		end
	end

	local count = #emptyCells

	if count > 0 then
		local cardAI = self._nextCard:getCardAI()
		local PosArray = cardAI and cardAI.ForcedPosition

		if PosArray then
			local map = {}

			for _, cell in ipairs(emptyCells) do
				map[math.abs(cell:getNumber())] = cell
			end

			for _, poses in ipairs(PosArray) do
				local _poses = shuffle(self._random, deepCopy({}, poses))

				for _, pos in ipairs(_poses) do
					if map[pos] then
						return map[pos]:getNumber()
					end
				end
			end
		end

		local r = self._random:random(1, count)

		return emptyCells[r]:getNumber()
	end

	local count = #residentCells

	if count > 0 then
		local cardAI = self._nextCard:getCardAI()
		local PosArray = cardAI and cardAI.ForcedPosition

		if PosArray then
			local map = {}

			for _, cell in ipairs(residentCells) do
				map[math.abs(cell:getNumber())] = cell
			end

			for _, poses in ipairs(PosArray) do
				local _poses = shuffle(self._random, deepCopy({}, poses))

				for _, pos in ipairs(_poses) do
					if map[pos] then
						return map[pos]:getNumber()
					end
				end
			end
		end

		local r = self._random:random(1, count)

		return residentCells[r]:getNumber()
	end

	return nil
end
