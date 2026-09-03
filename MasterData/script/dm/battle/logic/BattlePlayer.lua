-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattlePlayer.lua

BattlePlayer = class("BattlePlayer")

BattlePlayer:has("_id", {
	is = "rw"
})
BattlePlayer:has("_profile", {
	is = "rw"
})
BattlePlayer:has("_team", {
	is = "rw"
})
BattlePlayer:has("_index", {
	is = "rw"
})
BattlePlayer:has("_side", {
	is = "rw"
})
BattlePlayer:has("_initiative", {
	default = 0,
	is = "rw"
})
BattlePlayer:has("_masterUnit", {
	is = "rw"
})
BattlePlayer:has("_initialCellNo", {
	is = "rw"
})
BattlePlayer:has("_initialBattleFeildCellNo", {
	is = "rw"
})
BattlePlayer:has("_cardPool", {
	is = "rw"
})
BattlePlayer:has("_extraCardPool", {
	is = "rw"
})
BattlePlayer:has("_heroCardPool", {
	is = "rw"
})
BattlePlayer:has("_cardWindow", {
	is = "r"
})
BattlePlayer:has("_energyReservoir", {
	is = "r"
})
BattlePlayer:has("_autoStrategy", {
	is = "rw"
})
BattlePlayer:has("_cardState", {
	is = "r"
})
BattlePlayer:has("_refreshCost", {
	is = "r"
})

function BattlePlayer:initialize(id)
	super.initialize(self)

	self._id = id
	self._initialCellNo = 8
	self._initialBattleFeildCellNo = 108
	self._energyReservoir = EnergyReservoir:new()
	self._cardPool = HeroCardPool:new()
	self._heroCardPool = self._cardPool
	self._extraCardPool = ExtraCardPool:new()
	self._cardWindow = BattleCardWindow:new()
end

function BattlePlayer:initWithData(data)
	self._waves = data.waves
	self._initiative = data.initiative or 0
	self._combat = data.combat or 0

	self._cardPool:initWithData(data.cards or {})
	self._energyReservoir:initWithData(data.energy)

	self._summon = data.summon or {}
	self._assist = data.assist or {}
	self._tactics = data.tactics or {}
	self._refreshCost = data.refreshCost
	self._tacticsNeedWait = data.tacticsNeedWait

	if data.extraCards2 and #data.extraCards2 > 0 then
		self._extraCardPool:addHeroCard({
			data.extraCards2[1]
		})
	end

	if data.extraTactics and #data.extraTactics > 0 then
		self._extraCardPool:addSkillCard({
			data.extraTactics[1]
		})
	end

	return self
end

function BattlePlayer:setTeam(team)
	self._team = team

	if team ~= nil then
		self:setSide(team:getSide())
	else
		self:setSide(nil)
	end
end

function BattlePlayer:start(battleContext)
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._battleStatist = battleContext:getObject("BattleStatist")

	self:setupCardWindowWithHeroCards(battleContext:getObject("Randomizer"))
	self:setupExtraCardWindowWithCards(battleContext:getObject("Randomizer"))
	self._energyReservoir:start(battleContext)
	self:recordNewPlayer(self._battleRecorder)

	self._needEmbattle = true
end

function BattlePlayer:isEmbattleNeeded()
	return self._needEmbattle
end

function BattlePlayer:waveWipe()
	self._needEmbattle = true
end

function BattlePlayer:embattle(waveIndex, anim, formationSystem, battleRecorder)
	self._needEmbattle = false
	self._waveIndex = waveIndex

	local waveData = self._waves[self._waveIndex]
	local masterData = waveData and waveData.master
	local herosData = waveData and waveData.heros
	local masterId = masterData and masterData.modelId
	local heros

	if herosData and next(herosData) ~= nil then
		heros = {}

		for i = 1, 9 do
			local unitData = herosData[tostring(i)]

			if unitData then
				heros[#heros + 1] = unitData.id
			end
		end
	end

	local waveInfo = {
		id = playerId,
		side = self:getSide(),
		master = masterId,
		heros = heros,
		index = waveIndex,
		total = #self._waves
	}

	battleRecorder:recordEvent(self:getId(), "NewWave", waveInfo)

	if masterData ~= nil then
		local animation = {
			dur = 1000,
			name = anim or "init"
		}

		self._masterUnit = formationSystem:SpawnUnit(self, masterData, self:getInitialCellNo(), animation, false, true)
	else
		self._masterUnit = nil
	end

	if not self._BattleFieldUnit then
		local battleFeildData = self:getBattleFieldData()
		local animation = {
			dur = 1000,
			name = anim or "init"
		}

		self._BattleFieldUnit = formationSystem:SpawnUnit(self, battleFeildData, self:getInitialBattleFeildCellNo(), animation, false, true, {})
	end

	if herosData and next(herosData) ~= nil then
		local heroUnits = {}

		for i = 1, 9 do
			local unitData = herosData[tostring(i)]

			if unitData then
				local animation = {
					dur = 1000,
					name = anim or "init"
				}

				heroUnits[#heroUnits + 1] = formationSystem:SpawnUnit(self, unitData, i, animation, false)
			end
		end

		self._heros = heroUnits
	else
		self._heros = nil
	end
end

function BattlePlayer:getBattleFieldData()
	return {
		absorption = 0,
		effectstrg = 0,
		skillrate = 0,
		maxHp = 106818.8,
		anger = 0,
		surfaceIndex = 0,
		defrate = 1,
		cid = "Master_XueZhan",
		combat = 15010,
		unhurtrate = 0.01875,
		critstrg = 0.05625,
		atk = 8962.6,
		defweaken = 0,
		def = 2717.7,
		star = 2,
		level = 40,
		blockrate = 0.0375,
		configId = "Master_XueZhan",
		undeadrate = 0,
		hurtrate = 0.01875,
		isBattleField = true,
		curerate = 0,
		uncritrate = 0.0375,
		blockstrg = 0.05625,
		speed = 295,
		hp = 8888888888,
		reflection = 0,
		aoederate = 0.15,
		atkrate = 1,
		counterrate = 0,
		critrate = 0.0875,
		leadStageLevel = 0,
		doublerate = 0,
		unblockrate = 0.0375,
		uneffectrate = 0,
		effectrate = 0,
		modelId = "Model_Master_XueZhan",
		atkweaken = 0,
		uid = "m-BattleField-108" .. self._id,
		id = "f_BattleField-108" .. self._id,
		flags = {
			"FIELD"
		}
	}
end

function BattlePlayer:hasNextWave()
	local waveData = self._waves[((not self._waveIndex or nil) and 0) + 1]
	local masterData = waveData and waveData.master
	local herosData = waveData and waveData.heros

	if masterData or herosData then
		return (self._waveIndex or 0) + 1
	end

	return false
end

function BattlePlayer:recordNewPlayer(battleRecorder)
	if not battleRecorder then
		return
	end

	local cards = {}
	local cardWindow = self._cardWindow

	for i = 1, cardWindow:getWindowSize() do
		local card = cardWindow:getCardAtIndex(i)

		cards[i] = card and card:dumpInformation() or 0
	end

	local extraCards = {}

	for i = 1, cardWindow:getExtraWindowSize() do
		local card = cardWindow:getExtraCardAtIndex(i)

		extraCards[i] = card and card:dumpInformation() or 0
	end

	local nextCardInfo
	local playerId = self:getId()
	local playerInfo = {
		id = playerId,
		side = self:getSide(),
		master = masterId,
		heros = heros,
		energy = self._energyReservoir:getEnergy(),
		cardPoolSize = self._cardPool:getTotalCount(),
		cards = cards,
		extraCards = extraCards,
		nextCard = (self._nextCard or nil) and self._nextCard:dumpInformation()
	}

	battleRecorder:recordMetaEvent(playerId, "NewPlayer", playerInfo, "BattlePlayer")
end

function BattlePlayer:updateCardArray()
	if not battleRecorder then
		return
	end

	local cards = {}
	local cardWindow = self._cardWindow

	for i = 1, cardWindow:getWindowSize() do
		local card = cardWindow:getCardAtIndex(i)

		cards[i] = card and card:dumpInformation() or 0
	end

	local nextCardInfo
	local playerId = self:getId()
	local playerInfo = {
		id = playerId,
		side = self:getSide(),
		master = masterId,
		heros = heros,
		energy = self._energyReservoir:getEnergy(),
		cardPoolSize = self._cardPool:getTotalCount(),
		cards = cards,
		nextCard = (self._nextCard or nil) and self._nextCard:dumpInformation()
	}

	battleRecorder:recordMetaEvent(playerId, "NewPlayer", playerInfo, "BattlePlayer")
end

function BattlePlayer:getNextCard()
	return self._nextCard
end

function BattlePlayer:update(dt, battleContext)
	local cardWindow = self._cardWindow

	if cardWindow:isAllEmpty() and self:checkCanFillSkillCards(battleContext) and self._nextCard == nil then
		self:setupCardWindowWithSkillCards(battleContext:getObject("Randomizer"))

		if self._battleRecorder ~= nil then
			local cards = {}
			local cardWindow = self._cardWindow

			for i = 1, cardWindow:getWindowSize() do
				local card = cardWindow:getCardAtIndex(i)

				cards[i] = card and card:dumpInformation() or 0
			end

			local nextCardInfo
			local info = {
				cardPoolSize = self._cardPool:getTotalCount(),
				cards = cards,
				nextCard = (self._nextCard or nil) and self._nextCard:dumpInformation(),
				refreshCost = self._refreshCost
			}

			self._battleRecorder:recordEvent(self:getId(), "FillSCard", info)
		end
	end

	if battleContext:getObject("TimingSystem"):isTiming() then
		local battleField = battleContext:getObject("BattleField")
		local result = battleField:collectAllUnits({}, self:getSide())
		local count = #result - (self._masterUnit and 1 or 0)
		local keyinfo = self._energyReservoir:update(dt, count, self:getEnergySpeed())

		if keyinfo ~= nil then
			if self._battleRecorder ~= nil then
				self._battleRecorder:recordEvent(self:getId(), "SyncE", keyinfo)
			end

			local eventCenter = battleContext:getObject("EventCenter")

			eventCenter:dispatchEvent("GainEnergy", {
				player = self:getId(),
				info = keyinfo
			})
		end
	end
end

function BattlePlayer:calcSummonIdentify(summonId)
	self._summonIndex = (self._summonIndex or 0) + 1

	return (self:getSide() == kBattleSideA and "f" or "e") .. "_s" .. self:getIndex() .. "_" .. self._summonIndex .. "#" .. summonId
end

function BattlePlayer:getSummonInfo(summonId)
	for i, summonInfo in ipairs(self._summon) do
		if summonInfo.id == summonId then
			return summonInfo
		end
	end
end

function BattlePlayer:fillSummonInfo(summon)
	for i, summonInfo in ipairs(summon) do
		self._summon[#self._summon + 1] = summonInfo
	end
end

function BattlePlayer:calcAssistIdentify(assistId)
	self._assistIndex = (self._assistIndex or 0) + 1

	return (self:getSide() == kBattleSideA and "f" or "e") .. "_a_" .. self:getIndex() .. "_" .. self._assistIndex .. "#" .. assistId
end

function BattlePlayer:getAssistInfo(assistId)
	for i, assistInfo in ipairs(self._assist) do
		if assistInfo.uid == assistId then
			return assistInfo
		end
	end
end

function BattlePlayer:removeAssistInfo(assistId)
	for i, assistInfo in ipairs(self._assist) do
		if assistInfo.uid == assistId then
			table.remove(self._assist, i)

			return
		end
	end
end

function BattlePlayer:setupCardWindowWithHeroCards(random)
	self._cardState = nil

	local cardPool, cardWindow = self._cardPool, self._cardWindow

	for idx = 1, cardWindow:getWindowSize() do
		cardWindow:setCardAtIndex(idx, cardPool:popFrontCard())
	end

	self._nextCard = cardPool:getFrontCard()

	function self._cardSourceFunc(idx)
		local newCard = self._cardPool:popFrontCard()
		local nextCard = self._cardPool:getFrontCard()

		return newCard, nextCard
	end
end

function BattlePlayer:setupCardWindowWithSkillCards(random)
	self._cardState = "skill"
	self._cardPool = SkillCardPool:new()

	local cardPool, cardWindow = self._cardPool, self._cardWindow

	cardPool:initWithData(self._tactics or {})
	cardPool:shuffle(random)

	for idx = 1, cardWindow:getWindowSize() do
		cardWindow:setCardAtIndex(idx, cardPool:getRandomCard(random))
	end

	self._nextCard = self._cardPool:getRandomCard(random)

	local card = self._nextCard

	function self._cardSourceFunc(idx)
		local newCard = card
		local nextCard = self._cardPool:getRandomCard(random)

		card = nextCard

		return newCard, nextCard
	end
end

function BattlePlayer:setupExtraCardWindowWithCards(random)
	for idx = 1, self._cardWindow:getExtraWindowSize() do
		self._cardWindow:setExtraCardAtIndex(idx, self._extraCardPool:getCardAtIndex(idx))
	end
end

function BattlePlayer:fillExtraCardAtIndex(index)
	self._cardWindow:setExtraCardAtIndex(index, self._extraCardPool:getCardAtIndex(index))

	return self._extraCardPool:getCardAtIndex(index)
end

function BattlePlayer:checkCanFillSkillCards(battleContext)
	if self._cardState == "skill" then
		return true
	end

	if self._cardState == nil or self._cardState == "hero" then
		if self._tactics and next(self._tactics) ~= nil and self._cardWindow:isAllEmpty() and self._cardPool:getRemainedCount() == 0 then
			self._cardState = "preskill"
		else
			return false
		end
	end

	if self._cardState == "preskill" then
		if self._tacticsNeedWait then
			if self:checkOpposePlayerCardState(battleContext) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function BattlePlayer:checkOpposePlayerCardState(battleContext)
	local battleLogic = battleContext:getObject("BattleLogic")
	local opposePlayer = battleLogic:getPlayer(opposeBattleSide(self:getSide()))
	local cardState = opposePlayer:getCardState()

	if cardState == "skill" or cardState == "preskill" then
		return true
	end

	return false
end

function BattlePlayer:refreshSkillCard(random)
	if self._cardState == "skill" then
		self:setupCardWindowWithSkillCards(random)

		if self._battleRecorder ~= nil then
			local cards = {}
			local cardWindow = self._cardWindow

			for i = 1, cardWindow:getWindowSize() do
				local card = cardWindow:getCardAtIndex(i)

				cards[i] = card and card:dumpInformation() or 0
			end

			local nextCardInfo
			local info = {
				cardPoolSize = self._cardPool:getTotalCount(),
				cards = cards,
				nextCard = (self._nextCard or nil) and self._nextCard:dumpInformation(),
				refreshCost = self._refreshCost
			}

			self._battleRecorder:recordEvent(self:getId(), "FillSCard", info)
		end
	end
end

function BattlePlayer:getCardState()
	return self._cardState or "hero"
end

function BattlePlayer:getNextCard()
	return self._nextCard
end

function BattlePlayer:takeCardAtIndex(wndIdx, cardId)
	local card = self._cardWindow:getCardAtIndex(wndIdx)

	if card == nil then
		local extraCard = self._cardWindow:getExtraCardAtIndex(wndIdx - 4)

		if not extraCard then
			return nil, "NoCard"
		end

		card = extraCard
	end

	if cardId ~= nil and cardId ~= card:getId() then
		return nil, "CardNotMatched"
	end

	return card
end

function BattlePlayer:fillCardAtIndex(wndIdx)
	local cardSourceFunc = self._cardSourceFunc
	local newCard, nextCard

	if cardSourceFunc then
		newCard, nextCard = self._cardSourceFunc(wndIdx)
	end

	self._cardWindow:setCardAtIndex(wndIdx, newCard)

	self._nextCard = nextCard

	return newCard, nextCard
end

function BattlePlayer:insertCardAtIndex(wndIdx, newCard)
	local oldCard = self:takeCardAtIndex(wndIdx)

	self._cardWindow:setCardAtIndex(wndIdx, newCard)

	return newCard, oldCard
end

function BattlePlayer:energyIsEnough(required)
	return self._energyReservoir:isEnough(required)
end

function BattlePlayer:consumeEnergy(cost)
	return self._energyReservoir:consume(cost)
end

function BattlePlayer:reduceEnergy(cost)
	return self._energyReservoir:reduce(cost)
end

function BattlePlayer:recoverEnergy(value)
	return self._energyReservoir:recover(value)
end

function BattlePlayer:fail()
	self._failed = true
end

function BattlePlayer:beDefeated()
	return self._failed
end

function BattlePlayer:getCombat()
	return self._combat
end

function BattlePlayer:getHpRatio()
	if self._masterUnit then
		local hpComp = self._masterUnit:getComponent("Health")

		return hpComp:getHpRatio()
	end

	if self._heros and #self._heros > 0 then
		local totalhp, totalmaxhp = 0, 0

		for _, hero in ipairs(self._heros) do
			local hpComp = hero:getComponent("Health")

			totalhp = totalhp + (hpComp and hpComp:getHp() or 0)
			totalmaxhp = totalmaxhp + (hpComp and hpComp:getMaxHp() or 0)
		end

		if totalmaxhp > 0 then
			return totalhp / totalmaxhp
		end
	end

	return 0
end

function BattlePlayer:getRemainAnger()
	if self._masterUnit then
		local angerComp = self._masterUnit:getComponent("Anger")

		return angerComp:getAnger()
	end

	return 0
end

function BattlePlayer:getRemainHpInfo()
	if self._masterUnit then
		local hpComp = self._masterUnit:getComponent("Health")

		return hpComp:getMaxHp(), hpComp:getHp()
	end

	if self._heros and #self._heros > 0 then
		local totalhp, totalmaxhp = 0, 0

		for _, hero in ipairs(self._heros) do
			local hpComp = hero:getComponent("Health")

			totalhp = totalhp + (hpComp and hpComp:getHp() or 0)
			totalmaxhp = totalmaxhp + (hpComp and hpComp:getMaxHp() or 0)
		end

		if totalmaxhp > 0 then
			return totalmaxhp, totalhp
		end
	end

	return 0, 0
end

function BattlePlayer:getHpDetails(battleContext)
	local details = {}
	local battleField = battleContext:getObject("BattleField")
	local result = battleField:collectAllUnits({}, self:getSide())

	for _, unit in ipairs(result) do
		local hpComp = unit:getComponent("Health")

		details[unit:getId()] = hpComp and hpComp:getHp() or 0
	end

	return details
end

function BattlePlayer:clearStatus(battleContext)
	local battleField = battleContext:getObject("BattleField")
	local formationSystem = battleContext:getObject("FormationSystem")
	local result = battleField:collectExistsUnits({}, self:getSide())

	for _, unit in ipairs(result) do
		if not unit:isInStages(ULS_Dying) then
			local skillComp = unit:getComponent("Skill")

			skillComp:setUniqueSkillRoutine(nil)

			if unit:isInStages(ULS_Newborn) then
				battleContext:getObject("SkillSystem"):buildSkillsForActor(unit)
				formationSystem:changeUnitSettled(unit)

				local buffSystem = battleContext:getObject("BuffSystem")

				buffSystem:triggerEnterBuffs(unit)

				local trapSystem = battleContext:getObject("TrapSystem")

				trapSystem:triggerTrap(unit)
				formationSystem:clearOldResident(unit)
			end
		else
			formationSystem:buryUnit(unit)
		end
	end
end

function BattlePlayer:kickAllUnits(battleContext)
	local battleField = battleContext:getObject("BattleField")
	local result = battleField:collectAllUnits({}, self:getSide())

	for _, unit in ipairs(result) do
		local buffSystem = battleContext:getObject("BuffSystem")

		buffSystem:cleanupBuffsOnTarget(unit)

		if battleField:eraseUnit(unit) then
			unit:setLifeStage(ULS_Kicked)

			if self._battleRecorder then
				self._battleRecorder:recordEvent(unit:getId(), "Kick")
			end
		end
	end

	if self._battleRecorder then
		self._battleRecorder:recordEvent(self:getId(), "Kick")
	end
end

function BattlePlayer:backCardToPool(card)
	self._cardPool:insertCard(card)
	self._cardWindow:removeCard(card)
end

function BattlePlayer:backCardToPoolAtIndex(card, index)
	self._cardPool:insertCard(card, index)
	self._cardWindow:removeCard(card)
end

function BattlePlayer:visitCardsInWindow(visitor)
	return self._cardWindow:visitCards(visitor)
end

function BattlePlayer:modifyEnergySpeedEffect(value, source)
	self._energySpeedMap = self._energySpeedMap or {}

	if self._energySpeedMap[source] == nil then
		self._energySpeedMap[source] = value
	end

	return value
end

function BattlePlayer:cancelEnergySpeedEffect(source)
	if self._energySpeedMap and self._energySpeedMap[source] then
		self._energySpeedMap[source] = nil

		return self._energySpeedMap[source]
	end

	return 0
end

function BattlePlayer:getEnergySpeed()
	local speed = 1

	if self._energySpeedMap then
		for k, v in pairs(self._energySpeedMap) do
			speed = speed * v
		end
	end

	return speed
end
