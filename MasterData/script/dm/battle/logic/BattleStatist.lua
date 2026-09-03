-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleStatist.lua

BattleStatist = class("BattleStatist")

function BattleStatist:initialize()
	super.initialize(self)

	self._battleContext = nil
end

function BattleStatist:sendStatisticEvent(event, args)
	local resp_name = "on_" .. event
	local responder = self[resp_name]

	if responder == nil then
		return
	end

	responder(self, args)
end

function BattleStatist:willStartBattle(battleContext)
	self._battleContext = battleContext
	self._summary = nil
end

function BattleStatist:didFinishBattle(result, time)
	return
end

function BattleStatist:getSummary(forceRecalculating)
	if self._summary == nil or forceRecalculating then
		self._summary = self:summarize()
	end

	return self._summary
end

function BattleStatist:summarize()
	return
end

SimpleBattleStatist = class("SimpleBattleStatist", BattleStatist)

function SimpleBattleStatist:willStartBattle(battleContext)
	super.willStartBattle(self, battleContext)

	self._finishTime = nil
	self._curBout = 1
	self._boutInfo = {}
	self._units = {}
	self._spoils = {}
	self._players = {}
end

function SimpleBattleStatist:didFinishBattle(result, time)
	self._result = result
	self._finishTime = time
end

function SimpleBattleStatist:_getUnitInfo(unitId, createIfNotExist)
	local unitInfo = self._units[unitId]

	if unitInfo == nil and createIfNotExist then
		unitInfo = {
			skillKilled = {},
			doSkill = {}
		}
		self._units[unitId] = unitInfo
	end

	return unitInfo
end

function SimpleBattleStatist:_getPlayerInfo(playerId, createIfNotExist)
	local playerInfo = self._players[playerId]

	if playerInfo == nil and createIfNotExist then
		playerInfo = {
			usedHeroCards = {}
		}
		self._players[playerId] = playerInfo
	end

	return playerInfo
end

function SimpleBattleStatist:on_UseHeroCard(args)
	local player, card = args.player, args.card

	if card then
		cardInfo = card:dumpInformation()

		local playerInfo = self:_getPlayerInfo(player:getId(), true)
		local usedCard = playerInfo.usedHeroCards

		usedCard[#usedCard + 1] = {
			type = cardInfo.hero.genre,
			cost = cardInfo.cost,
			rawCost = cardInfo.rawCost
		}
	end
end

function SimpleBattleStatist:on_UnitSpawned(args)
	if args.type == "battlefield" then
		return
	end

	local player, unit, type = args.player, args.unit, args.type
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, true)

	unitInfo.id = unitId
	unitInfo.uid = unit:getUid() or ""
	unitInfo.cid = unit:getCid()
	unitInfo.hp = unit:getComponent("Health"):getHp()
	unitInfo.maxHp = unit:getComponent("Health"):getMaxHp()
	unitInfo.hpRemain = unit:getComponent("Health"):getHp()
	unitInfo.owner = player:getId()
	unitInfo.type = type
	unitInfo.modelId = unit:getModelId()
	unitInfo.startRound = args.round
	unitInfo.cell = math.abs(unit:getCell():getId())
	unitInfo.rarity = unit:getRarity()
	unitInfo.startTime = args.startTime
	unitInfo.level = unit:getLevel()
	unitInfo.cost = unit:getCost()
	unitInfo.star = unit:getStar()
	unitInfo.quality = unit:getQuality()
	unitInfo.qualityId = unit:getQualityId()
	unitInfo.summoned = {}
	unitInfo.isSummoned = unit._isSummoned
	unitInfo.presentMaster = unit._presentMaster

	if unitInfo.presentMaster then
		for id, info in pairs(self._units) do
			if info.owner == unitInfo.owner and unitInfo.id ~= info.id then
				info.presentMaster = nil
			end
		end
	end
end

function SimpleBattleStatist:on_UnitDied(args)
	local player, unit = args.player, args.unit
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.owner = player:getId()
		unitInfo.dead = true
		unitInfo.endRound = args.round
		unitInfo.endTime = args.endTime
		unitInfo.foe = unit:getFoe()
	end

	if unitInfo.type == "master" and unit:getFoe() then
		local foeInfo = self:_getUnitInfo(unit:getFoe(), false)

		if foeInfo and foeInfo.type == "master" then
			local playerInfo = self:_getPlayerInfo(foeInfo.owner, true)

			playerInfo.masterKillMaster = true
		end
	end
end

function SimpleBattleStatist:on_UnitSummoned(args)
	local unit, actor = args.unit, args.actor
	local unitId = unit:getId()
	local actorId = actor:getId()
	local actorInfo = self:_getUnitInfo(actorId, false)

	if actorInfo then
		local summoned = actorInfo.summoned

		summoned[#summoned + 1] = unitId
	end
end

function SimpleBattleStatist:on_UnitTransported(args)
	local player, unit, cellId = args.player, args.unit, args.cellId
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.cell = math.abs(cellId)
	end
end

function SimpleBattleStatist:on_UnitLeft(args)
	local player, unit = args.player, args.unit
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.owner = player:getId()
		unitInfo.dead = true
		unitInfo.endRound = args.round
	end
end

function SimpleBattleStatist:on_UnitDoSkill(args)
	local unit, skillType = args.unit, args.type
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.doSkill[skillType] = (unitInfo.doSkill[skillType] or 0) + 1
	end
end

function SimpleBattleStatist:on_DoDamage(args)
	local player, unit, detail = args.player, args.unit, args.detail
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo and detail then
		unitInfo.damage = (unitInfo.damage or 0) + detail.eft
	end

	if args.target and detail then
		local unitId_receiveDamage = args.target:getId()
		local unitInfo_receiveDamage = self:_getUnitInfo(unitId_receiveDamage, false)

		if unitInfo_receiveDamage then
			unitInfo_receiveDamage.receiveDamage = (unitInfo_receiveDamage.receiveDamage or 0) + detail.eft
		end
	end
end

function SimpleBattleStatist:on_DoReflect(args)
	local player, unit, detail = args.player, args.unit, args.detail
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.damage = (unitInfo.damage or 0) + detail.eft
	end

	if args.target then
		local unitId_receiveDamage = args.target:getId()
		local unitInfo_receiveDamage = self:_getUnitInfo(unitId_receiveDamage, false)

		if unitInfo_receiveDamage then
			unitInfo_receiveDamage.receiveDamage = (unitInfo_receiveDamage.receiveDamage or 0) + detail.eft
		end
	end
end

function SimpleBattleStatist:on_DoPeriodDamage(args)
	local unit, detail = args.unit, args.detail
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.damage = (unitInfo.damage or 0) + detail.eft
	end

	if args.target then
		local unitId_receiveDamage = args.target:getId()
		local unitInfo_receiveDamage = self:_getUnitInfo(unitId_receiveDamage, false)

		if unitInfo_receiveDamage then
			unitInfo_receiveDamage.receiveDamage = (unitInfo_receiveDamage.receiveDamage or 0) + detail.eft
		end
	end
end

function SimpleBattleStatist:on_DoCure(args)
	local player, unit, detail = args.player, args.unit, args.detail
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.cure = (unitInfo.cure or 0) + detail.eft
	end

	if args.target then
		local unitId_receiveCure = args.target:getId()
		local unitInfo_receiveCure = self:_getUnitInfo(unitId_receiveCure, false)

		if unitInfo_receiveCure then
			unitInfo_receiveCure.receiveCure = (unitInfo_receiveCure.receiveCure or 0) + detail.eft
		end
	end
end

function SimpleBattleStatist:on_DoPeriodRecover(args)
	local unit, detail = args.unit, args.detail
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)

	if unitInfo then
		unitInfo.cure = (unitInfo.cure or 0) + detail.eft
	end

	if args.target then
		local unitId_receiveCure = args.target:getId()
		local unitInfo_receiveCure = self:_getUnitInfo(unitId_receiveCure, false)

		if unitInfo_receiveCure then
			unitInfo_receiveCure.receiveCure = (unitInfo_receiveCure.receiveCure or 0) + detail.eft
		end
	end
end

function SimpleBattleStatist:on_SkillKilled(args)
	local player, unit, skill, killed = args.player, args.unit, args.skill, args.killed
	local unitId = unit:getId()
	local unitInfo = self:_getUnitInfo(unitId, false)
	local range = skill:getRange()

	if unitInfo and range then
		local curKilled = unitInfo.skillKilled[range]

		unitInfo.skillKilled[range] = curKilled and killed < curKilled and curKilled or killed
	end
end

function SimpleBattleStatist:on_FinishBout(args)
	self._boutInfo[#self._boutInfo + 1] = args

	for playerId, hpDetails in pairs(args.hpDetails) do
		for unitId, hpRemain in pairs(hpDetails) do
			local unitInfo = self:_getUnitInfo(unitId, false)

			if unitInfo then
				unitInfo.hpRemain = hpRemain

				if hpRemain == 0 then
					unitInfo.dead = true
				end

				unitInfo.endTime = unitInfo.endTime or args.endTime
			end
		end
	end
end

function SimpleBattleStatist:on_UnitHurt(args)
	for unitId, hpRemain in pairs(args.hpDetails) do
		local unitInfo = self:_getUnitInfo(unitId, false)

		if unitInfo then
			unitInfo.hpRemain = hpRemain

			if hpRemain == 0 then
				unitInfo.dead = true
			end
		end
	end
end

function SimpleBattleStatist:on_GetSpoils(args)
	local player, items = args.player, args.items
	local playerId = player:getId()
	local spoilItems = self._spoils[playerId]

	if spoilItems == nil then
		spoilItems = {}
		self._spoils[playerId] = spoilItems
	end

	local k = #spoilItems + 1

	for i = 1, #items do
		k = k + 1
		spoilItems[k] = items[i]
	end
end

function SimpleBattleStatist:summarize()
	local players = {}

	for id, info in pairs(self._units) do
		local playerSummary = players[info.owner]

		if playerSummary == nil then
			playerSummary = {
				unitsTotal = 0,
				heroHpMaxTotal = 0,
				heroHpRatio = 0,
				heroHpRemainTotal = 0,
				hpTotal = 0,
				unitsDeath = 0,
				hpRemain = 0,
				unitSummary = {},
				skillKilled = {}
			}
			players[info.owner] = playerSummary

			local playerInfo = self:_getPlayerInfo(info.owner)

			if playerInfo then
				if #playerInfo.usedHeroCards > 0 then
					playerSummary.usedHeroCards = playerInfo.usedHeroCards
				end

				playerSummary.masterKillMaster = playerInfo.masterKillMaster
			end
		end

		playerSummary.unitsTotal = playerSummary.unitsTotal + 1
		playerSummary.hpTotal = playerSummary.hpTotal + (info.hp or 0)

		if info.dead then
			playerSummary.unitsDeath = playerSummary.unitsDeath + 1
		else
			playerSummary.hpRemain = playerSummary.hpRemain + ((not info.hpRemain or nil) and 0)
		end

		if info.type == "master" then
			-- block empty
		else
			playerSummary.heroHpMaxTotal = playerSummary.heroHpMaxTotal + info.maxHp

			if not info.dead then
				playerSummary.heroHpRemainTotal = playerSummary.heroHpRemainTotal + (info.hpRemain or 0)
			end
		end

		local var_27_2 = {
			type = info.type,
			uid = info.uid,
			cid = info.cid,
			startRound = info.startRound,
			endRound = info.endRound,
			foe = info.foe,
			dead = info.dead,
			maxHp = info.maxHp,
			hpRemain = info.hpRemain,
			cellIndex = info.cell,
			model = info.modelId
		}

		var_27_2.damage = info.damage or 0
		var_27_2.receiveDamage = info.receiveDamage or 0
		var_27_2.rarity = info.rarity or 0
		var_27_2.startTime = info.startTime or 0
		var_27_2.endTime = info.endTime or (self._battleContext or nil) and self._battleContext:getCurrentTime()
		var_27_2.cost = info.cost
		var_27_2.star = info.star
		var_27_2.quality = info.quality
		var_27_2.qualityId = info.qualityId
		var_27_2.level = info.level
		var_27_2.summoned = info.summoned
		var_27_2.doSkill = info.doSkill
		var_27_2.cure = info.cure or 0
		var_27_2.receiveCure = info.receiveCure or 0
		var_27_2.isSummoned = info.isSummoned
		var_27_2.presentMaster = info.presentMaster
		playerSummary.unitSummary[info.id] = var_27_2

		for range, killed in pairs(info.skillKilled) do
			local curKilled = playerSummary.skillKilled[range]

			playerSummary.skillKilled[range] = curKilled and killed < curKilled and curKilled or killed
		end
	end

	for playerId, playerInfo in pairs(players) do
		playerInfo.heroHpRatio = playerInfo.heroHpMaxTotal == 0 and 1 or playerInfo.heroHpRemainTotal / math.max(playerInfo.heroHpMaxTotal, 1)
	end

	local totalTime = 0
	local roundCount

	for _, boutInfo in ipairs(self._boutInfo) do
		totalTime = totalTime + boutInfo.time

		for playerId, hpRatio in pairs(boutInfo.hpRatio) do
			players[playerId].hpRatio = hpRatio
		end

		for playerId, remainAnger in pairs(boutInfo.remainAnger) do
			players[playerId].curAnger = remainAnger
		end

		roundCount = boutInfo.roundCount
	end

	for playerId, spoilItems in pairs(self._spoils) do
		local playerSummary = players[playerId]
		local spoils = {}
		local mapping = {}

		for i, item in ipairs(spoilItems) do
			local type, id, unit = item.type, item.id, item.unit
			local key = tostring(type)

			if id ~= nil then
				key = key .. "$" .. tostring(id)
			end

			if unit ~= nil then
				key = key .. "#" .. tostring(unit)
			end

			local info = mapping[key]

			if info == nil then
				local var_27_3 = {
					type = type,
					id = id,
					unit = unit
				}

				var_27_3.count = item.count or 1
				info = var_27_3
				mapping[key] = var_27_3
				spoils[#spoils + 1] = info
			else
				info.count = info.count + ((not item.count or nil) and 1)
			end
		end

		playerSummary.spoils = spoils
	end

	local settingType = self._battleContext:readVar("battleIsAuto")

	if settingType ~= nil then
		for playerId, playerInfo in pairs(players) do
			if playerId == settingType.playerId[1] then
				playerInfo.isAuto = settingType.isAuto
			end
		end
	end

	return {
		players = players,
		totalTime = totalTime,
		roundCount = roundCount
	}
end
