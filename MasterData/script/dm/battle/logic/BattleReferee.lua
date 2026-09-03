-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleReferee.lua

kBattleSideAWaveWiped = -10
kBattleSideBWaveWiped = 10
BattleReferee = class("BattleReferee", objectlua.Object, _M)

function BattleReferee:initialize(basicRule)
	super.initialize(self)

	self._basicRule = basicRule
end

function BattleReferee:setJudgeRules(judgeRules)
	self._judgeRules = judgeRules
end

function BattleReferee:finishBout(result)
	if self._boutResult then
		return self._boutResult
	end

	if result.result == kBattleSideAWin then
		local teamB = self._battleContext:getObject("TeamB")
		local playerB = teamB:getCurPlayer()

		playerB:fail()
		self._battleLogic:getActionScheduler():setFinished()
		self._battleLogic:dispatchMessage({
			type = "BOUT_END"
		})
	elseif result.result == kBattleSideBWin then
		local teamA = self._battleContext:getObject("TeamA")
		local playerA = teamA:getCurPlayer()

		playerA:fail()
		self._battleLogic:getActionScheduler():setFinished()
		self._battleLogic:dispatchMessage({
			type = "BOUT_END"
		})
	elseif result.result == kBattleSideAWaveWiped then
		local teamA = self._battleContext:getObject("TeamA")
		local playerA = teamA:getCurPlayer()

		playerA:waveWipe()
		self._battleLogic:getActionScheduler():setFinished()
		self._battleLogic:dispatchMessage({
			type = "NEXT_WAVE",
			args = {
				result = result
			}
		})

		return
	elseif result.result == kBattleSideBWaveWiped then
		local teamB = self._battleContext:getObject("TeamB")
		local playerB = teamB:getCurPlayer()

		playerB:waveWipe()
		self._battleLogic:getActionScheduler():setFinished()
		self._battleLogic:dispatchMessage({
			type = "NEXT_WAVE",
			args = {
				result = result
			}
		})

		return
	end

	self._boutResult = result

	return result
end

function BattleReferee:getResult()
	return self._boutResult
end

function BattleReferee:checkRules(fnName, reason, ...)
	if self._boutResult or self._battleContext == nil then
		return self._boutResult
	end

	local judgeRules = self._judgeRules

	if judgeRules then
		for i = 1, #judgeRules do
			local rule = judgeRules[i]
			local func = rule[fnName]

			if func then
				local result = func(rule, ...)

				if result ~= nil then
					if result.reason == nil then
						result.reason = reason
					end

					return self:finishBout(result)
				end
			end
		end
	end

	local rule = self._basicRule

	if rule then
		local func = rule[fnName]

		if func then
			local result = func(rule, ...)

			if result ~= nil then
				if result.reason == nil then
					result.reason = reason
				end

				return self:finishBout(result)
			end
		end
	end
end

function BattleReferee:startNewBattle(battleLogic, battleContext)
	self._battleContext = battleContext
	self._battleLogic = battleLogic
	self._boutResult = nil

	local judgeRules = self._judgeRules

	if judgeRules then
		for i = 1, #judgeRules do
			local rule = judgeRules[i]

			rule._battleLogic = battleLogic
			rule._battlecontext = battleContext

			if rule.startup ~= nil then
				rule:startup(battleLogic, battleContext)
			end
		end
	end

	local rule = self._basicRule

	if rule then
		rule._battleLogic = battleLogic
		rule._battlecontext = battleContext

		if rule.startup ~= nil then
			rule:startup(battleLogic, battleContext)
		end
	end
end

function BattleReferee:battleRoundOver(roundNumber)
	return self:checkRules("onRoundOver", "ROUND_OUT", roundNumber)
end

function BattleReferee:battleTimedup()
	return self:checkRules("onTimedout", "TIME_OUT")
end

function BattleReferee:battleUnitDied(deadUnit)
	return self:checkRules("onUnitDied", nil, deadUnit)
end

function BattleReferee:battleUnitOrSummonDied(deadUnit)
	return self:checkRules("onUnitOrSummonDied", nil, deadUnit)
end

function BattleReferee:battleUnitsExcluded(excludedUnits)
	return self:checkRules("onUnitsExcluded", nil, excludedUnits)
end

function BattleReferee:checkPlayerEnergy()
	return self:checkRules("checkPlayerEnergy", "OUT_OF_ENERGY")
end

function BattleReferee:battleUnitsEscaped(escapedUnits)
	return self:checkRules("onUnitsEscaped", nil, escapedUnits)
end

BattleJudgeRule = class("BattleJudgeRule", objectlua.Object, _M)

function BattleJudgeRule:initialize()
	super.initialize(self)
end

function BattleJudgeRule:execute(challenger, defender, battleContext)
	assert(false, "Override me")
end

BasicJudgeRule = class("BasicJudgeRule", BattleJudgeRule, _M)

BasicJudgeRule:has("_roundLimit", {
	is = "rw"
})

function BasicJudgeRule.class:create()
	local resultMapper = {
		[kBattleSideA] = kBattleSideAWin,
		[kBattleSideB] = kBattleSideBWin
	}
	local waveResultMapper = {
		[kBattleSideA] = kBattleSideAWaveWiped,
		[kBattleSideB] = kBattleSideBWaveWiped
	}

	return {
		startup = function(self, battleLogic, battleContext)
			return
		end,
		onUnitDied = function(self, deadUnit)
			local player = deadUnit:getOwner()

			if deadUnit:getUnitType() == BattleUnitType.kMaster then
				return {
					reason = "MASTER_DIED",
					result = resultMapper[opposeBattleSide(player:getSide())]
				}
			end

			local battleField = self._battlecontext:getObject("BattleField")
			local livings = battleField:collectExistsUnits({}, player:getSide())

			if next(livings) == nil then
				return {
					reason = "WIPE_OUT",
					result = waveResultMapper[player:getSide()]
				}
			end
		end,
		onUnitsExcluded = function(self, excludedUnits)
			local players = {}

			for i = 1, #excludedUnits do
				local deadUnit = excludedUnits[i]
				local player = deadUnit:getOwner()

				if deadUnit:getUnitType() == BattleUnitType.kMaster then
					return {
						reason = "MASTER_DIED",
						result = resultMapper[opposeBattleSide(player:getSide())]
					}
				end

				local contained = false

				for _, v in ipairs(players) do
					if v == player then
						contained = true

						break
					end
				end

				if not contained then
					players[#players + 1] = player
				end
			end

			local battleField = self._battlecontext:getObject("BattleField")

			for _, player in ipairs(players) do
				local livings = battleField:collectExistsUnits({}, player:getSide())

				if next(livings) == nil then
					return {
						reason = "WIPE_OUT",
						result = waveResultMapper[player:getSide()]
					}
				end
			end
		end,
		onRoundOver = function(self, roundNumber)
			local battleLogic = self._battleLogic
			local roundLimit = battleLogic and battleLogic:getMaxRounds() or 99

			if roundLimit <= roundNumber then
				return {
					result = kBattleSideBWin
				}
			end
		end,
		onTimedout = function(self)
			local teamA = self._battlecontext:getObject("TeamA")
			local teamB = self._battlecontext:getObject("TeamB")
			local playerA = teamA:getCurPlayer()
			local playerB = teamB:getCurPlayer()
			local ratioA = playerA:getHpRatio()
			local ratioB = playerB:getHpRatio()
			local failPlayer = ratioB < ratioA and playerB or ratioA < ratioB and playerA or playerA:getCombat() < playerB:getCombat() and playerA or playerB

			return {
				result = resultMapper[opposeBattleSide(failPlayer:getSide())]
			}
		end
	}
end

JudgeRuleFactory = {}

local __sideMapping = {
	SideA = kBattleSideA,
	SideB = kBattleSideB
}

local function sideFromString(side)
	return __sideMapping[side] or side
end

local function judgeSideWithDesc(battleLogic, desc)
	if desc:sub(1, 1) == "!" then
		return opposeBattleSide(judgeBattleSide(desc:sub(2)))
	else
		return judgeBattleSide(desc)
	end
end

local function resultFunction(result)
	if result == nil then
		return nil
	end

	local rtype = type(result)

	if rtype == type(kBattleSideAWin) then
		return function(self, ...)
			return result
		end
	elseif rtype == "function" then
		return result
	elseif rtype == "table" then
		local resultMapper, detail

		if result.winner ~= nil then
			detail = result.winner
			resultMapper = {
				[kBattleSideA] = kBattleSideAWin,
				[kBattleSideB] = kBattleSideBWin
			}
		elseif result.loser ~= nil then
			detail = result.loser
			resultMapper = {
				[kBattleSideA] = kBattleSideALose,
				[kBattleSideB] = kBattleSideBLose
			}
		end

		local dtype = type(detail)

		if dtype == "string" then
			return function(self, ...)
				local side = judgeSideWithDesc(self._battleLogic, detail)

				return (side or nil) and (resultMapper[side] or kBattleDraw)
			end
		elseif dtype == "table" then
			return function(self, ...)
				local side
				local battleLogic = self._battleLogic

				for i = 1, #detail do
					side = judgeSideWithDesc(battleLogic, detail[i])

					if side ~= nil then
						local result = resultMapper[side]

						if result ~= nil then
							return result
						end
					end
				end

				return kBattleDraw
			end
		end
	end
end

function JudgeRuleFactory:resultWhen(result, rule)
	if rule ~= nil then
		rule.result = resultFunction(result)
	end

	return rule
end

function JudgeRuleFactory:timeIsUp(args, result)
	assert(result ~= nil, "Invalid arguments!")

	return {
		result = resultFunction(result),
		onTimedout = function(self)
			if self.result ~= nil then
				return {
					reason = "TIME_OUT",
					result = self:result()
				}
			end
		end
	}
end

function JudgeRuleFactory:keyUnitsDied(args, result)
	assert(args ~= nil and args.unitTag ~= nil, "Invalid arguments!")

	local unitTag = args.unitTag

	if not args.count then
		local minimumDeaths = 1

		return {
			result = resultFunction(result),
			startup = function(self, battleLogic, battleContext)
				self._deaths = 0
			end,
			onUnitDied = function(self, deadUnit)
				if deadUnit:hasFlag(unitTag) then
					self._deaths = self._deaths + 1
				end

				if self._deaths >= minimumDeaths and self.result ~= nil then
					return {
						reason = "KEY_UNITS_DIED",
						result = self:result()
					}
				end
			end
		}
	end
end

function JudgeRuleFactory:playerRunOutOfEnergy(args, result)
	if result == nil then
		result = targetSide == kBattleSideA and kBattleSideALose or kBattleSideBLose
	end

	return {
		result = resultFunction(result),
		checkPlayerEnergy = function(self)
			local battleLogic = self._battlecontext:getObject("BattleLogic")
			local player = battleLogic:getPlayer(targetSide)

			if player == nil or self.result == nil then
				return
			end

			if not player:energyIsEnough(1) then
				return {
					reason = "OUT_OF_ENERGY",
					result = self:result()
				}
			end
		end
	}
end

function JudgeRuleFactory:singleSideDeathsReached(args, result)
	local targetSide = sideFromString(args and args.side) or kBattleSideA

	if args then
		if not args.count then
			local minimumDeaths = 1

			if result == nil then
				result = targetSide == kBattleSideA and kBattleSideALose or kBattleSideBLose
			end

			return {
				result = resultFunction(result),
				startup = function(self, battleLogic, battleContext)
					self._deaths = 0
				end,
				onUnitDied = function(self, deadUnit)
					if deadUnit:getSide() == targetSide then
						self._deaths = self._deaths + 1
					end

					if self._deaths >= minimumDeaths and self.result ~= nil then
						return {
							reason = "DEATHS_OVER_LIMIT",
							result = self:result()
						}
					end
				end
			}
		end
	end
end

function JudgeRuleFactory:unitOrSummonDiedReached(args, result)
	local unitType = args.killtype
	local targetEnum = {
		All = "ALL",
		SideA = kBattleSideA,
		SideB = kBattleSideB
	}

	if not args.side then
		local targetSide = "SideB"

		targetSide = targetEnum[targetSide]

		if args then
			if not args.count then
				local minimumDeaths = 1

				if result == nil then
					result = targetSide == kBattleSideA and kBattleSideALose or kBattleSideBLose
				end

				return {
					result = resultFunction(result),
					startup = function(self, battleLogic, battleContext)
						self._deaths = 0
						self._preDeaths = 0
					end,
					onUnitDied = function(self, deadUnit)
						if targetSide == "ALL" or deadUnit:getSide() == targetSide then
							if unitType == "Summoned" then
								if deadUnit._isSummoned then
									self._deaths = self._deaths + 1
								end
							elseif unitType == "Hero" then
								if not deadUnit._isSummoned then
									self._deaths = self._deaths + 1
								end
							elseif deadUnit:hasFlag(unitType) then
								self._deaths = self._deaths + 1
							end
						end

						self._processRecorder = self._battlecontext:getObject("ProcessRecorder")

						if self._processRecorder and self._deaths > self._preDeaths then
							self._processRecorder:recordObjectEvent(kBRMainLine, "CountDeath", {
								cnt = self._deaths
							})
						end

						self._preDeaths = self._deaths

						if self._deaths >= minimumDeaths and self.result ~= nil then
							return {
								reason = "DEATHS_OVER_LIMIT",
								result = self:result()
							}
						end
					end
				}
			end
		end
	end
end

function JudgeRuleFactory:playerDeathsReached(args, result)
	local targetSide = sideFromString(args and args.side) or kBattleSideA

	if args then
		if not args.count then
			local minimumDeaths = 1

			if result == nil then
				result = targetSide == kBattleSideA and kBattleSideALose or kBattleSideBLose
			end

			return {
				result = resultFunction(result),
				startup = function(self, battleLogic, battleContext)
					self._deaths = 0
					self._player = battleLogic:getPlayer(targetSide)
				end,
				onUnitDied = function(self, deadUnit)
					if deadUnit:getOwner() == self._player then
						self._deaths = self._deaths + 1
					end

					if self._deaths >= minimumDeaths and self.result ~= nil then
						return {
							reason = "DEATHS_OVER_LIMIT",
							result = self:result()
						}
					end
				end
			}
		end
	end
end

function JudgeRuleFactory:unitsEscaped(args, result)
	assert(args ~= nil and args.unitTag ~= nil, "Invalid arguments!")

	local unitTag = args.unitTag

	if not args.count then
		local minimumEscapeds = 1

		return {
			result = resultFunction(result),
			startup = function(self, battleLogic, battleContext)
				self._escapeds = 0
			end,
			onUnitsEscaped = function(self, escapedUnits)
				for k, v in pairs(escapedUnits) do
					if v:hasFlag(unitTag) and v:getSide() == kBattleSideB then
						self._escapeds = self._escapeds + 1
					end
				end

				if self._escapeds >= minimumEscapeds and self.result ~= nil then
					return {
						reason = "WIPE_OUT",
						result = self:result()
					}
				end
			end
		}
	end
end
