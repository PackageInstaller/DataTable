-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/card_ops.lua

if not SkillDevKit then
	local floor, ceil = math.floor, math.ceil
	local MakeFilter = _G.MakeFilter
	local makeBuffMatchFunction = _G.makeBuffMatchFunction

	function SkillDevKit.GetCardCost(env, card)
		return card:getActualCost()
	end

	function SkillDevKit.addHeroCardSeatRules(env, player, card, rules, dierules)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:addHeroCardSeatRules(player, card, rules, dierules)
	end

	function SkillDevKit.clearHeroCardSeatRules(env, player, card, rules, dierules)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:clearHeroCardSeatRules(player, card, rules, dierules)
	end

	function SkillDevKit.ClearCardFlags(env, card, flags)
		if not card then
			return
		end

		card:clearFlags(flags or {})
	end

	function SkillDevKit.AddCardFlags(env, card, flags)
		if not card then
			return
		end

		card:addFlags(flags or {})
	end

	function SkillDevKit.setEnterPauseTime(env, player, card, time)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:setEnterPauseTime(player, card, time)
	end

	function SkillDevKit.CARD_HERO_MARKED(env, flag)
		return MakeFilter(function(card)
			if card:getType() == "hero" then
				return card:hasFlag(flag)
			else
				return false
			end
		end)
	end

	function SkillDevKit.CARD_HERO_GENRE(env, genre)
		return MakeFilter(function(_, card)
			if card then
				return card:isGenre(genre)
			end

			return false
		end)
	end

	function SkillDevKit.CARD_COST_EQ(env, cost)
		return MakeFilter(function(card)
			return card:getActualCost() == cost
		end)
	end

	function SkillDevKit.CARD_COST_LE(env, cost)
		return MakeFilter(function(card)
			return card:getActualCost() <= cost
		end)
	end

	function SkillDevKit.CARD_COST_GE(env, cost)
		return MakeFilter(function(card)
			return card:getActualCost() >= cost
		end)
	end

	function SkillDevKit.CARD_EXACT(env, exactCard)
		return MakeFilter(function(card)
			return card == exactCard
		end)
	end

	function SkillDevKit.GetHeroCardAttr(env, card, key)
		if card:getType() == "hero" then
			local heroData = card:getHeroData()

			return heroData[key] or 0
		end

		return 0
	end

	function SkillDevKit.CardsOfPlayer(env, player, cardfilter)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:getHeroCards(player, cardfilter)
	end

	function SkillDevKit.CardsInWindow(env, player, cardfilter)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:getHeroCardsInWindow(player, cardfilter)
	end

	function SkillDevKit.CardAtWindowIndex(env, player, index)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:getHeroCardByIndex(player, index)
	end

	function SkillDevKit.CardsInPool(env, player, cardfilter)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:getHeroCardsInPool(player, cardfilter)
	end

	function SkillDevKit.CardCostEnchant(env, type, value, priority)
		return CardCostEnchant:new({
			type = type,
			value = value,
			priority = priority
		})
	end

	function SkillDevKit.ApplyEnchant(env, player, card, config, enchants)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		local enchantConfig = {
			duration = config.duration,
			timing = config.timing,
			tags = config.tags
		}
		local enchantObject = EnchantObject:new(enchantConfig, enchants)

		enchantObject:setSource(env["$actor"])

		local groupConfig

		return cardSystem:applyEnchantOnCard(player, card, enchantObject, (config.group ~= nil or nil) and {
			group = config.group,
			limit = config.limit
		}, env["$id"])
	end

	function SkillDevKit.ApplyHeroCardBuff(env, player, heroCard, buffConfig, buffEffects, anim)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		local triggerBuff = TriggerBuff:new(buffConfig, buffEffects)

		return cardSystem:applyBuffsOnHeroCard(player, heroCard, triggerBuff, anim, env["$id"])
	end

	function SkillDevKit.DispelTiggerOnHeroCard(env, heroCard, tags)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		return cardSystem:dispelTiggerOnHeroCard(heroCard, tags or {})
	end

	function SkillDevKit.SelectCardBuffCount(env, heroCard, tag)
		if not heroCard then
			return 0
		end

		if heroCard:getType() ~= "hero" then
			return 0
		end

		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return 0
		end

		return cardSystem:getTiggerBuffCountOnHeroCard(heroCard, tag)
	end

	function SkillDevKit.SelectCardPassiveCount(env, heroCard, skillId)
		if not heroCard then
			return 0
		end

		if heroCard:getType() ~= "hero" then
			return 0
		end

		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return 0
		end

		return cardSystem:getPassiveCountOnHeroCard(heroCard, skillId)
	end

	function SkillDevKit.DispelBuffOnHeroCard(env, heroCard, tags)
		if not heroCard then
			return 0
		end

		if heroCard:getType() ~= "hero" then
			return 0
		end

		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return 0
		end

		return cardSystem:getTiggerBuffCountOnHeroCard(heroCard, tags)
	end

	function SkillDevKit.SelectEnhanceCount(env, player, target, tagOrFilter)
		local cardSystem = env.global["$CardSystem"]
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)
		local buffs, count = cardSystem:selectEnchantOnTarget(player, target, matchFunc)

		return count
	end

	function SkillDevKit.LockHeroCards(env, player, cardfilter, lockConfig)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		cardSystem:lockHeroCards(player, cardfilter, lockConfig)
	end

	function SkillDevKit.UnlockHeroCards(env, player, cardfilter)
		local cardSystem = env.global["$CardSystem"]

		if cardSystem == nil then
			return nil
		end

		cardSystem:unlockHeroCards(player, cardfilter)
	end
end
