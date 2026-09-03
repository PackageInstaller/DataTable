-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/sp_ops.lua

if not SkillDevKit then
	local floor, ceil = math.floor, math.ceil
	local filterElements = _G.filterElements

	function SkillDevKit.AddStatus(env, unit, status)
		local flagComp = unit:getComponent("Flag")

		flagComp:addStatus(status)
	end

	function SkillDevKit.RemoveStatus(env, unit, status)
		local flagComp = unit:getComponent("Flag")

		flagComp:removeStatus(status)
	end

	function SkillDevKit.INSTATUS(env, status)
		return MakeFilter(function(_, unit)
			local flagComp = unit:getComponent("Flag")

			return flagComp:hasStatus(status)
		end)
	end

	function SkillDevKit.INANYSTATUS(env, statusArr)
		return MakeFilter(function(_, unit)
			local flagComp = unit:getComponent("Flag")

			return flagComp:hasAnyStatus(statusArr)
		end)
	end

	function SkillDevKit.Stop(env)
		local excutor = env.global["$SkillSystem"]:getSkillExecutor()

		excutor:stopAction(env, "special skill")
	end

	function SkillDevKit.ApplyEnergyDamage(env, player, energy)
		local energyInfo = player:reduceEnergy(energy)

		env.global.RecordImmediately(env, player:getId(), "SyncE", energyInfo)
	end

	function SkillDevKit.FlyBallEffect(env, unit, card)
		local player = env["$actor"]:getOwner()
		local cardSystem = env.global["$CardSystem"]
		local effectInfo = {
			index = cardSystem:getCardIdx(player, card)
		}

		env.global.RecordImmediately(env, unit:getId(), "FlyBallToCard", effectInfo)

		return true
	end

	function SkillDevKit.ApplyEnergyRecovery(env, player, energy)
		if not player then
			return
		end

		local energyInfo = player:recoverEnergy(energy)

		env.global.RecordImmediately(env, player:getId(), "SyncERecovery", energyInfo)
	end

	function SkillDevKit.ShowGrayEnergyEffect(env, player, isShow)
		if not player then
			return
		end

		env.global.RecordImmediately(env, player:getId(), "ShowGrayEnergyEffect", isShow)
	end

	function SkillDevKit.ShowFrazeEnergyEffect(env, player, isShow)
		if not player then
			return
		end

		env.global.RecordImmediately(env, player:getId(), "ShowFrazeEnergyEffect", isShow)
	end

	function SkillDevKit.Recruit(env, cardfilter, location, cost)
		local player = env["$actor"]:getOwner()
		local battleField = env.global["$BattleContext"]:getObject("BattleField")
		local cellId = battleField:findEmptyCellId(player:getSide(), location)

		if not cellId then
			return
		end

		local cardsInWindow = player:getCardWindow():getCardArray()

		if #cardsInWindow == 0 or cardsInWindow[1]:getType() ~= CARD_TYPE.kHeroCard then
			return
		end

		local cardsInPool = player:getCardPool():getCardArray()

		if cardfilter then
			cardsInWindow = filterElements(cardsInWindow, cardfilter)
			cardsInPool = filterElements(cardsInPool, cardfilter)
		end

		local windowCount, poolCount = #cardsInWindow, #cardsInPool

		if windowCount + poolCount == 0 then
			return
		end

		local resultIndex = env.global.random(1, windowCount + poolCount)
		local resultCard

		if resultIndex <= windowCount then
			resultCard = cardsInWindow[resultIndex]

			cardsInWindow[resultIndex]:usedByPlayer(player, env.global["$BattleContext"], cellId, cost or 0, true)

			local idx = player:getCardWindow():getCardIndex(resultCard)
			local newCard, nextCard = player:fillCardAtIndex(idx)
			local var_14_0 = player:getId()
			local var_14_1 = "RecruitCard"
			local var_14_2 = {
				type = "hero",
				idx = idx
			}

			var_14_2.card = newCard and newCard:dumpInformation() or 0
			var_14_2.next = nextCard and nextCard:dumpInformation() or 0

			env.global:RecordImmediately(var_14_0, var_14_1, var_14_2)
			env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
				player = player,
				idx = resultIndex,
				oldcard = resultCard,
				newcard = newCard
			})
		else
			resultCard = cardsInPool[resultIndex - windowCount]

			cardsInPool[resultIndex - windowCount]:usedByPlayer(player, env.global["$BattleContext"], cellId, cost or 0, true)

			local removed, isFront = player:getCardPool():removeCard(resultCard)

			if removed then
				if isFront then
					local nextCard = player:getCardPool():getFrontCard()
					local var_14_3 = player:getId()
					local var_14_4 = "RecruitCard"
					local var_14_5 = {
						type = "hero"
					}

					var_14_5.next = nextCard and nextCard:dumpInformation() or 0

					env.global:RecordImmediately(var_14_3, var_14_4, var_14_5)
				else
					env.global.RecordImmediately(env, player:getId(), "RecruitCard", {
						type = "hero"
					})
				end
			end
		end
	end

	function SkillDevKit.RecruitCard(env, card, location, cost, otherPlayer, rightNowSit)
		if not otherPlayer then
			::label_15_0::

			local player = env["$actor"]:getOwner()
			local battleField = env.global["$BattleContext"]:getObject("BattleField")
			local cellId = battleField:findEmptyCellId(player:getSide(), location)

			if not cellId then
				return false
			end

			if card:isLocked() then
				return false
			end

			local cardWindow = player:getCardWindow()
			local index = cardWindow:getCardIndex(card)

			if index then
				local ok, detail = card:usedByPlayer(player, env.global["$BattleContext"], cellId, cost or 0, true, rightNowSit)

				if not ok then
					return false
				end

				local newCard, nextCard = player:fillCardAtIndex(index)
				local var_15_0 = player:getId()
				local var_15_1 = "RecruitCard"
				local var_15_2 = {
					type = "hero",
					idx = index
				}

				var_15_2.card = newCard and newCard:dumpInformation() or 0
				var_15_2.next = nextCard and nextCard:dumpInformation() or 0

				env.global:RecordImmediately(var_15_0, var_15_1, var_15_2)
				env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
					player = player,
					idx = idx,
					oldcard = card,
					newcard = newCard
				})

				return detail
			else
				local removed, isFront = player:getCardPool():removeCard(card)

				if removed then
					local ok, detail = card:usedByPlayer(player, env.global["$BattleContext"], cellId, cost or 0, true, rightNowSit)

					if not ok then
						return false
					end

					if isFront then
						local nextCard = player:getCardPool():getFrontCard()
						local var_15_3 = player:getId()
						local var_15_4 = "RecruitCard"
						local var_15_5 = {
							type = "hero"
						}

						var_15_5.next = nextCard and nextCard:dumpInformation() or 0

						env.global:RecordImmediately(var_15_3, var_15_4, var_15_5)
					else
						env.global.RecordImmediately(env, player:getId(), "RecruitCard", {
							type = "hero"
						})
					end

					return detail
				else
					return false
				end
			end
		end
	end

	function SkillDevKit.DiligentRound(env, duration)
		local battlelogic = env.global["$BattleContext"]:getObject("BattleLogic")

		battlelogic:dispatchMessage({
			type = "DILIGENT_ROUND",
			args = {
				duration = duration
			}
		})
	end

	function SkillDevKit.TruthBubble(env, unit)
		env.global.RecordImmediately(env, unit:getId(), "TruthBubble", {
			seed = env.global.random(1, 65535)
		})
	end

	function SkillDevKit.InheritCardByConfig(env, config, owner)
		local card = config.card
		local modelId = config.modelId
		local ignorePassive = config.ignorePassive
		local ignoreUnique = config.ignoreUnique
		local uniqueSkill = config.uniqueSkill
		local cost = config.cost
		local atk = config.atk
		local def = config.def
		local maxHp = config.maxHp

		if card and (card._unitType or card:getType() == "hero") then
			if not owner then
				::label_18_0::

				local player = env["$actor"]:getOwner()
				local _cardInfo = card:getCardInfo()
				local cardSystem = env.global["$CardSystem"]
				local cardInfo = cardSystem:genNewHeroCard(player, _cardInfo, "c" .. player:getId())

				if cardInfo.hero and cardInfo.hero.skills then
					for k, v in pairs(cardInfo.hero.skills.passive or {}) do
						if ignorePassive or v.skillType and v.skillType == "Equip" then
							cardInfo.hero.skills.passive[k] = nil
						end
					end

					if cardInfo.hero.skills.unique then
						if ignoreUnique then
							cardInfo.hero.skills.unique = nil
						end

						if uniqueSkill then
							cardInfo.hero.skills.unique.proto = uniqueSkill
						end
					end
				end

				local passives_new = {}
				local passvies = {}

				for k, v in pairs(cardInfo.hero.skills.passive) do
					passvies[#passvies + 1] = v
				end

				table.deepcopy(passvies, passives_new)

				cardInfo.hero.skills.passive = passives_new

				if modelId then
					cardInfo.hero.modelId = modelId
				end

				if cost then
					cardInfo.cost = cost
				end

				if atk then
					cardInfo.hero.atk = atk
				end

				if def then
					cardInfo.hero.def = def
				end

				if maxHp then
					cardInfo.hero.maxHp = maxHp
				end

				if player:getCardState() == "skill" then
					for i = 1, 4 do
						local card_ws = player:takeCardAtIndex(i)

						if card_ws then
							player:backCardToPool(card_ws)
						end
					end

					player:setCardPool(player:getHeroCardPool())
					player:setupCardWindowWithHeroCards()
					env.global.RecordImmediately(env, player:getId(), "RemoveSCard")
				end

				local card = player:getCardPool():insertCardByInfo(cardInfo)
				local var_18_1 = player:getId()
				local var_18_2 = "BackToCard"
				local var_18_3 = {
					type = "hero"
				}

				var_18_3.card = card and card:dumpInformation() or 0

				env.global:RecordImmediately(var_18_1, var_18_2, var_18_3)

				for idx = 1, 4 do
					if player:takeCardAtIndex(idx) == nil then
						local newCard, nextCard = player:fillCardAtIndex(idx)
						local var_18_4 = player:getId()
						local var_18_5 = "Card"
						local var_18_6 = {
							type = "hero",
							idx = idx
						}

						var_18_6.card = newCard and newCard:dumpInformation() or 0
						var_18_6.next = nextCard and nextCard:dumpInformation() or 0

						env.global:RecordImmediately(var_18_4, var_18_5, var_18_6)
						env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
							player = player,
							idx = idx,
							newcard = newCard
						})

						return card
					end
				end

				return card
			end
		end

		return nil
	end

	function SkillDevKit.InheritCard(env, card, modelId, ignorePassive, ignoreUnique)
		if card and (card._unitType or card:getType() == "hero") then
			local player = env["$actor"]:getOwner()
			local _cardInfo = card:getCardInfo()
			local cardSystem = env.global["$CardSystem"]
			local cardInfo = cardSystem:genNewHeroCard(player, _cardInfo, "c")

			if cardInfo.hero and cardInfo.hero.skills then
				for k, v in pairs(cardInfo.hero.skills.passive or {}) do
					if ignorePassive or v.skillType and v.skillType == "Equip" then
						cardInfo.hero.skills.passive[k] = nil
					end
				end

				if cardInfo.hero.skills.unique and ignoreUnique then
					cardInfo.hero.skills.unique = nil
				end
			end

			local passives_new = {}
			local passvies = {}

			for k, v in pairs(cardInfo.hero.skills.passive) do
				passvies[#passvies + 1] = v
			end

			table.deepcopy(passvies, passives_new)

			cardInfo.hero.skills.passive = passives_new

			if modelId then
				cardInfo.hero.modelId = modelId
			end

			if player:getCardState() == "skill" then
				for i = 1, 4 do
					local card_ws = player:takeCardAtIndex(i)

					if card_ws then
						player:backCardToPool(card_ws)
					end
				end

				player:setCardPool(player:getHeroCardPool())
				player:setupCardWindowWithHeroCards()
				env.global.RecordImmediately(env, player:getId(), "RemoveSCard")
			end

			local card = player:getCardPool():insertCardByInfo(cardInfo)
			local var_19_1 = player:getId()
			local var_19_2 = "BackToCard"
			local var_19_3 = {
				type = "hero"
			}

			var_19_3.card = card and card:dumpInformation() or 0

			env.global:RecordImmediately(var_19_1, var_19_2, var_19_3)

			for idx = 1, 4 do
				if player:takeCardAtIndex(idx) == nil then
					local newCard, nextCard = player:fillCardAtIndex(idx)
					local var_19_4 = player:getId()
					local var_19_5 = "Card"
					local var_19_6 = {
						type = "hero",
						idx = idx
					}

					var_19_6.card = newCard and newCard:dumpInformation() or 0
					var_19_6.next = nextCard and nextCard:dumpInformation() or 0

					env.global:RecordImmediately(var_19_4, var_19_5, var_19_6)
					env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
						player = player,
						idx = idx,
						newcard = newCard
					})

					return card
				end
			end

			return card
		end

		return nil
	end

	function SkillDevKit.BackToCard(env, unit, owner)
		if not owner then
			::label_20_0::

			local player = env["$actor"]:getOwner()

			if unit:getCardInfo() then
				local formationSystem = env.global["$FormationSystem"]

				formationSystem:forbidenRevive(unit)

				local cardSystem = env.global["$CardSystem"]
				local cardInfo = cardSystem:genNewHeroCard(player, unit:getCardInfo(), "b")

				if player:getCardState() == "skill" then
					for i = 1, 4 do
						local card_ws = player:takeCardAtIndex(i)

						if card_ws then
							player:backCardToPool(card_ws)
						end
					end

					player:setCardPool(player:getHeroCardPool())
					player:setupCardWindowWithHeroCards()
					env.global.RecordImmediately(env, player:getId(), "RemoveSCard")
				end

				local card = player:getCardPool():insertCardByInfo(cardInfo)
				local var_20_0 = player:getId()
				local var_20_1 = "BackToCard"
				local var_20_2 = {
					type = "hero"
				}

				var_20_2.card = card and card:dumpInformation() or 0

				env.global:RecordImmediately(var_20_0, var_20_1, var_20_2)

				for idx = 1, 4 do
					if player:takeCardAtIndex(idx) == nil then
						local newCard, nextCard = player:fillCardAtIndex(idx)
						local var_20_3 = player:getId()
						local var_20_4 = "Card"
						local var_20_5 = {
							type = "hero",
							idx = idx
						}

						var_20_5.card = newCard and newCard:dumpInformation() or 0
						var_20_5.next = nextCard and nextCard:dumpInformation() or 0

						env.global:RecordImmediately(var_20_3, var_20_4, var_20_5)
						env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
							player = player,
							idx = idx,
							newcard = newCard
						})

						return card
					end
				end

				return card
			end
		end
	end

	function SkillDevKit.GetWindowCard(env, windowIndex, owner)
		if not owner then
			::label_21_0::

			local player = env["$actor"]:getOwner()

			return player:takeCardAtIndex(windowIndex)
		end
	end

	function SkillDevKit.BackToWindow(env, unit, windowIndex, owner)
		if not owner then
			::label_22_0::

			local player = env["$actor"]:getOwner()

			if unit:getCardInfo() then
				local formationSystem = env.global["$FormationSystem"]

				formationSystem:forbidenRevive(unit)

				local cardSystem = env.global["$CardSystem"]
				local cardInfo = cardSystem:genNewHeroCard(player, unit:getCardInfo(), "b")

				if player:getCardState() == "skill" then
					for i = 1, 4 do
						local card_ws = player:takeCardAtIndex(i)

						if card_ws then
							player:backCardToPool(card_ws)
						end
					end

					player:setCardPool(player:getHeroCardPool())
					player:setupCardWindowWithHeroCards()
					env.global.RecordImmediately(env, player:getId(), "RemoveSCard")
				end

				local card = player:getCardPool():insertCardByInfo(cardInfo)
				local var_22_0 = player:getId()
				local var_22_1 = "BackToCard"
				local var_22_2 = {
					type = "hero"
				}

				var_22_2.card = card and card:dumpInformation() or 0

				env.global:RecordImmediately(var_22_0, var_22_1, var_22_2)

				if windowIndex and windowIndex > 0 then
					local idx = windowIndex
					local card_ws = player:takeCardAtIndex(idx)

					if card_ws then
						player:backCardToPoolAtIndex(card_ws, 0)
					end

					local newCard, nextCard = player:fillCardAtIndex(idx)
					local var_22_3 = player:getId()
					local var_22_4 = "Card"
					local var_22_5 = {
						type = "hero",
						idx = idx
					}

					var_22_5.card = newCard and newCard:dumpInformation() or 0
					var_22_5.next = nextCard and nextCard:dumpInformation() or 0

					env.global:RecordImmediately(var_22_3, var_22_4, var_22_5)
					env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
						player = player,
						idx = idx,
						newcard = newCard
					})
				end

				return card
			end
		end
	end

	function SkillDevKit.RefreshCardPool(env, buffTag, owner)
		if not owner then
			::label_23_0::

			local player = env["$actor"]:getOwner()

			for i = 1, 4 do
				local idx = i
				local card_ws = player:takeCardAtIndex(idx)

				if card_ws then
					player:backCardToPoolAtIndex(card_ws, 1)
				end
			end

			local cardSystem = env.global["$CardSystem"]

			cardSystem:sortCardInPool(player, buffTag)

			local cards = {}

			for i = 1, 4 do
				local card = player:fillCardAtIndex(i)

				cards[i] = card and card:dumpInformation() or 0
			end

			local var_23_0 = player:getId()
			local var_23_1 = {
				cards = cards
			}

			var_23_1.cardPoolSize = player:getCardPool():getTotalCount()

			local var_23_2 = player:getNextCard()

			var_23_2 = var_23_2 and player:getNextCard():dumpInformation()
			var_23_1.nextCard = var_23_2

			env.global:RecordImmediately(var_23_0, "RelocatCardWindow", var_23_1)
		end
	end

	function SkillDevKit.RelocateExtraCard(env, cardType, cost)
		local player = env["$actor"]:getOwner()
		local extraCardPool = player:getExtraCardPool()
		local cardInstance
		local windowIndex = 0

		for i = 1, 2 do
			if extraCardPool:getCardAtIndex(i):getType() == cardType then
				cardInstance = extraCardPool:getCardAtIndex(i)
				windowIndex = i

				break
			end
		end

		local cardSystem = env.global["$CardSystem"]
		local card

		if cardType == "hero" then
			if not cardInstance:getCardInfo() then
				return
			end

			local cardInfo = cardSystem:genNewHeroCard(player, cardInstance:getCardInfo(), "b", true)

			card = player:getExtraCardPool():repleaceCard(cardInfo, windowIndex)
		end

		if cardType == "skill" then
			if not cardInstance:getSkillInfo() then
				return
			end

			local cardInfo = cardSystem:genNewSkillCard(cardInstance:getSkillInfo())

			card = player:getExtraCardPool():repleaceCard(cardInfo, windowIndex)
		end

		if cost and cost >= 0 then
			card:setRawCost(cost)
		end

		local var_24_0 = player:getId()
		local var_24_1 = "BackToExtraCard"
		local var_24_2 = {
			type = cardType,
			idx = 4 + windowIndex
		}

		var_24_2.card = card and card:dumpInformation() or 0

		env.global:RecordImmediately(var_24_0, var_24_1, var_24_2)

		if windowIndex and windowIndex > 0 then
			local idx = windowIndex
			local newCard = player:fillExtraCardAtIndex(idx)
			local var_24_3 = player:getId()
			local var_24_4 = "Card"
			local var_24_5 = {
				next = 0,
				idx = 4 + idx,
				type = cardType
			}

			var_24_5.card = newCard and newCard:dumpInformation() or 0

			env.global:RecordImmediately(var_24_3, var_24_4, var_24_5)
			env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
				player = player,
				idx = idx,
				newcard = newCard
			})
		end
	end

	function SkillDevKit.BackToExtraWindow(env, unit, windowIndex)
		local player = env["$actor"]:getOwner()

		if unit:getCardInfo() then
			local formationSystem = env.global["$FormationSystem"]

			formationSystem:forbidenRevive(unit)

			local cardSystem = env.global["$CardSystem"]
			local cardInfo = cardSystem:genNewHeroCard(player, unit:getCardInfo(), "b")
			local card = player:getExtraCardPool():insertCardByInfoAtIndex(cardInfo, windowIndex)
			local var_25_0 = player:getId()
			local var_25_1 = "BackToExtraCard"
			local var_25_2 = {
				type = "hero"
			}

			var_25_2.card = card and card:dumpInformation() or 0

			env.global:RecordImmediately(var_25_0, var_25_1, var_25_2)

			if windowIndex and windowIndex > 0 then
				local idx = windowIndex
				local newCard = player:fillExtraCardAtIndex(idx)
				local var_25_3 = player:getId()
				local var_25_4 = "Card"
				local var_25_5 = {
					next = 0,
					type = "hero",
					idx = idx
				}

				var_25_5.card = newCard and newCard:dumpInformation() or 0

				env.global:RecordImmediately(var_25_3, var_25_4, var_25_5)
				env.global["$SkillSystem"]:activateGlobalTrigger("HERO_CARD_CHANGEED", {
					player = player,
					idx = idx,
					newcard = newCard
				})
			end

			return card
		end
	end

	function SkillDevKit.GetCardWindowIndex(env, unit)
		if not unit then
			return 0
		end

		local cardInfo = unit:getCardInfo()

		if not cardInfo then
			return 0
		end

		if cardInfo.cardIndex then
			return cardInfo.cardIndex
		end

		return 0
	end

	function SkillDevKit.GetAttackEffects(env, unit)
		local effects = unit:getAttackEffect()

		if effects and next(effects) then
			return effects
		end

		return {}
	end

	function SkillDevKit.SelectHeroPassiveCount(env, unit, skillId)
		if not unit then
			return 0
		end

		local formationSystem = env.global["$FormationSystem"]

		if formationSystem == nil then
			return 0
		end

		return formationSystem:getPassiveCountOnHero(unit, skillId)
	end

	function SkillDevKit.IsAwaken(env, unit)
		if not unit then
			return false
		end

		return unit:getAwakenLevel() > 0
	end

	function SkillDevKit.HolyHide(env, unit, alpha)
		env.global.RecordImmediately(env, unit:getId(), "HolyHide", {
			alpha = alpha
		})
	end

	function SkillDevKit.SummonEnemy(env, source, summonId, summonFactor, summonExtra, location, curHpRatio)
		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]
		local var_31_0 = {}

		if summonFactor then
			var_31_0.hpRatio = summonFactor[1] or 1
		end

		if summonFactor then
			var_31_0.atkRatio = summonFactor[2] or 1
		end

		if summonFactor then
			var_31_0.defRatio = summonFactor[3] or 1
		end

		if summonExtra then
			var_31_0.hpEx = summonExtra[1] or 0
		end

		if summonExtra then
			var_31_0.atkEx = summonExtra[2] or 0
		end

		if summonExtra then
			var_31_0.defEx = summonExtra[3] or 0
		end

		var_31_0.curHpRatio = curHpRatio or 1

		local factors = var_31_0

		return formationSystem:summonEnemy(actor, source, summonId, factors, location)
	end

	function SkillDevKit.ActivateSpecificTrigger(env, unit, event, detail)
		local skillSystem = env.global["$SkillSystem"]

		skillSystem:activateSpecificTrigger(unit, event, detail)
	end

	function SkillDevKit.ActivateGlobalTrigger(env, unit, event, detail)
		local skillSystem = env.global["$SkillSystem"]

		detail = detail or {}
		detail.unit = unit

		skillSystem:activateGlobalTrigger(event, detail)
	end

	function SkillDevKit.ExertUniqueSkill(env, unit)
		local battleContext = env.global["$BattleContext"]
		local actionScheduler = battleContext:getObject("ActionScheduler")
		local skillComp = unit:getComponent("Skill")

		skillComp:setUniqueSkillRoutine(nil)
		actionScheduler:exertUniqueSkill(unit, kBattleUniqueSkill, true)
	end

	function SkillDevKit.ExertRegularSkill(env, unit)
		local battleContext = env.global["$BattleContext"]
		local actionScheduler = battleContext:getObject("ActionScheduler")
		local regularAction = BattleRegularAction:new():withActor(unit)

		actionScheduler:addUserActionAtFirst(regularAction)
	end
end
