-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/buff_ops.lua

if not SkillDevKit then
	local floor, ceil = math.floor, math.ceil
	local MakeFilter = _G.MakeFilter

	function SkillDevKit.BUFF_MARKED(env, tag)
		return MakeFilter(function(env, buff)
			return buff:isMatched(tag)
		end)
	end

	function SkillDevKit.BUFF_MARKED_ALL(env, tag1, ...)
		local tags = {
			tag1,
			...
		}
		local cnt = #tags

		return MakeFilter(function(env, buff)
			for i = 1, cnt do
				if not buff:isMatched(tags[i]) then
					return false
				end
			end

			return true
		end)
	end

	function SkillDevKit.BUFF_MARKED_ANY(env, tag1, ...)
		local tags = {
			tag1,
			...
		}
		local cnt = #tags

		return MakeFilter(function(env, buff)
			for i = 1, cnt do
				if buff:isMatched(tags[i]) then
					return true
				end
			end

			return false
		end)
	end

	local function makeBuffMatchFunction(env, tagOrFilter)
		if tagOrFilter == nil then
			return nil
		end

		local atype = type(tagOrFilter)

		if atype == "string" then
			return function(buff)
				return buff:isMatched(tagOrFilter)
			end
		elseif atype == "table" or atype == "function" then
			return function(buff)
				return tagOrFilter(env, buff)
			end
		end
	end

	_G.makeBuffMatchFunction = makeBuffMatchFunction

	function SkillDevKit.ApplyBuff(env, target, config, buffEffects)
		local buffSystem = env.global["$BuffSystem"]

		if buffSystem == nil then
			return nil
		end

		if not target then
			return
		end

		if not target:isInStages(ULS_Normal, ULS_Newborn) then
			return
		end

		local buffConfig = {
			duration = config.duration,
			timing = config.timing,
			display = config.display,
			tags = config.tags
		}
		local buffObject = BuffObject:new(buffConfig, buffEffects)

		buffObject:setSource(env["$actor"])

		local groupConfig

		return buffSystem:applyBuffOnTarget(target, buffObject, (config.group ~= nil or nil) and {
			group = config.group,
			limit = config.limit
		}, env["$id"])
	end

	function SkillDevKit.DispelBuff(env, target, tagOrFilter, maxCount, ignoreTriggerEvent)
		local buffSystem = env.global["$BuffSystem"]

		if not buffSystem then
			return 0
		end

		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		if maxCount ~= nil then
			local buffs = buffSystem:selectBuffsOnTarget(target, matchFunc)

			if buffs then
				if not #buffs then
					local count = 0

					if count == 0 then
						return 0
					end

					if count <= maxCount then
						for i = 1, count do
							buffs[buffs[i]] = true
						end
					end

					function matchFunc(buff)
						return buffs[buff]
					end
				end
			end
		end

		return buffSystem:dispelBuffsOnTarget(target, matchFunc, env["$id"], ignoreTriggerEvent)
	end

	function SkillDevKit.StealBuff(env, target, tagOrFilter, maxCount)
		local actor = env["$actor"]
		local buffSystem = env.global["$BuffSystem"]

		if not buffSystem then
			return 0
		end

		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		if maxCount ~= nil then
			local buffs = buffSystem:selectBuffsOnTarget(target, matchFunc)

			if buffs then
				if not #buffs then
					local count = 0

					if count == 0 then
						return 0
					end

					if count <= maxCount then
						for i = 1, count do
							buffs[buffs[i]] = true
						end
					end

					function matchFunc(buff)
						return buffs[buff]
					end
				end
			end
		end

		return buffSystem:stealBuffsOnTarget(actor, target, matchFunc, env["$id"])
	end

	function SkillDevKit.CloneBuff(env, unit, target, tagOrFilter, maxCount)
		local buffSystem = env.global["$BuffSystem"]

		if not buffSystem then
			return 0
		end

		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		if maxCount ~= nil then
			local buffs = buffSystem:selectBuffsOnTarget(target, matchFunc)

			if buffs then
				if not #buffs then
					local count = 0

					if count == 0 then
						return 0
					end

					if count <= maxCount then
						for i = 1, count do
							buffs[buffs[i]] = true
						end
					end

					function matchFunc(buff)
						return buffs[buff]
					end
				end
			end
		end

		return buffSystem:cloneBuffsOnTarget(unit, target, matchFunc, env["$id"])
	end

	function SkillDevKit.SelectBuffs(env, target, tagOrFilter)
		local buffSystem = env.global["$BuffSystem"]
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		return buffSystem:selectBuffsOnTarget(target, matchFunc)
	end

	function SkillDevKit.SelectBuffCount(env, target, tagOrFilter)
		local buffSystem = env.global["$BuffSystem"]
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)
		local buffs, count = buffSystem:selectBuffsOnTarget(target, matchFunc)

		return count
	end

	function SkillDevKit.ResetBuffsLifespan(env, target, tagOrFilter)
		local buffSystem = env.global["$BuffSystem"]
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)
		local buffs = buffSystem:selectBuffsOnTarget(target, matchFunc)
		local count = 0

		if buffs ~= nil then
			for i = 1, #buffs do
				local buffObject = buffs[i]

				if buffObject:resetLifespan() then
					count = count + 1
				end
			end
		end

		return count
	end

	function SkillDevKit.SelectTraps(env, cell, tagOrFilter)
		local trapSystem = env.global["$TrapSystem"]
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		return trapSystem:selectBuffsOnTarget(cell, matchFunc)
	end

	function SkillDevKit.SelectTrapCount(env, cell, tagOrFilter)
		local trapSystem = env.global["$TrapSystem"]
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)
		local buffs, count = trapSystem:selectBuffsOnTarget(cell, matchFunc)

		return count
	end

	function SkillDevKit.LimitHpEffect(env, value)
		return LimitHpEffect:new({
			value = value
		})
	end

	function SkillDevKit.MaxHpEffect(env, value)
		return MaxHpEffect:new({
			value = math.floor(value)
		})
	end

	function SkillDevKit.NumericEffect(env, name, itemname, value, uplimit)
		return NumericEffect:new({
			effect = name,
			itemname = itemname,
			value = value,
			uplimit = uplimit
		})
	end

	function SkillDevKit.SpecialNumericEffect(env, name, itemname, value, uplimit)
		return SpecialNumericEffect:new({
			effect = name,
			itemname = itemname,
			value = value,
			uplimit = uplimit
		})
	end

	function SkillDevKit.DeathImmuneEffect(env, value, hpRecoverRatio)
		local brokeCallback

		if hpRecoverRatio then
			local healthSystem = env.global["$HealthSystem"]

			function brokeCallback(battleContext, unit, buffValue)
				if not unit:isInStages(ULS_Normal) then
					return
				end

				return (healthSystem:performHealthRecovery(nil, unit, buffValue))
			end
		end

		return DeathImmuneEffect:new({
			value = value,
			brokeCallback = brokeCallback,
			hpRecoverRatio = hpRecoverRatio
		})
	end

	function SkillDevKit.PassiveFunEffectBuff(env, id, config)
		local skillSystem = env.global["$SkillSystem"]

		return PassiveFunEffect:new({
			id = id,
			config = config,
			skillSystem = skillSystem
		})
	end

	function SkillDevKit.StatusEffect(env, status)
		return StatusEffect:new({
			status = status
		})
	end

	function SkillDevKit.Daze(env)
		return StatusEffect:new({
			status = kBEDazed
		})
	end

	function SkillDevKit.Mute(env)
		local angerSystem = env.global["$AngerSystem"]

		local function cancelFunction(battleContext, unit)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			angerSystem:checkAnger(unit)
		end

		return StatusEffect:new({
			status = kBEMuted,
			onCancel = cancelFunction
		})
	end

	function SkillDevKit.HPLink()
		return StatusEffect:new({
			status = kBELinked
		})
	end

	function SkillDevKit.ShieldEffect(env, value, upLimit)
		return ShieldEffect:new({
			value = value,
			upLimit = upLimit
		})
	end

	function SkillDevKit.ShieldRatioEffect(env, ratio)
		return ShieldRatioEffect:new({
			ratio = ratio
		})
	end

	function SkillDevKit.HPRecoverRatioEffect(env, ratio)
		return HPRecoverRatioEffect:new({
			ratio = ratio
		})
	end

	function SkillDevKit.Freeze(env)
		return StatusEffect:new({
			status = kBEFrozen
		})
	end

	function SkillDevKit.Reflection(env, value)
		return NumericEffect:new({
			effect = "+reflection",
			itemname = {
				"+a"
			},
			value = value,
			uplimit = uplimit
		})
	end

	function SkillDevKit.Taunt(env)
		return StatusEffect:new({
			status = kBETaunt
		})
	end

	function SkillDevKit.Mad(env)
		return StatusEffect:new({
			status = kBEMad
		})
	end

	function SkillDevKit.Immune(env)
		return ImmuneEffect:new()
	end

	function SkillDevKit.Curse(env)
		return CurseEffect:new()
	end

	function SkillDevKit.Offline(env)
		return OfflineEffect:new()
	end

	function SkillDevKit.Stealth(env, alpha)
		return HolyHideEffect:new({
			status = kBEStealth,
			alpha = alpha
		})
	end

	function SkillDevKit.Diligent(env)
		return StatusEffect:new({
			status = kBEDiligent
		})
	end

	function SkillDevKit.BuffIsMatched(env, buff, ...)
		local tags = {
			...
		}

		for k, v in pairs(tags) do
			if buff:isMatched(v) then
				return true
			end
		end

		return false
	end

	function SkillDevKit.ImmuneBuff(env, tagOrFilter)
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		if matchFunc == nil then
			function matchFunc(buff)
				return true
			end
		end

		return ImmuneBuffEffect:new({
			filter = matchFunc
		})
	end

	function SkillDevKit.ImmuneTrapBuffEffect(env, tagOrFilter)
		local matchFunc = makeBuffMatchFunction(env, tagOrFilter)

		if matchFunc == nil then
			function matchFunc(buff)
				return true
			end
		end

		return ImmuneTrapBuffEffect:new({
			filter = matchFunc
		})
	end

	function SkillDevKit.Provoke(env, unit)
		return ProvokeEffect:new({
			target = unit
		})
	end

	function SkillDevKit.EnergyEffect(env, value)
		return EnergyEffect:new({
			value = value
		})
	end

	function SkillDevKit.RageGainEffect(env, name, itemname, value, uplimit)
		return RageGainEffect:new({
			effect = name,
			itemname = itemname,
			value = value,
			uplimit = uplimit
		})
	end

	function SkillDevKit.DamageTransferEffect(env, trasforUnit, radio)
		return DamageTransferEffect:new({
			trasforUnit = trasforUnit,
			radio = radio
		})
	end

	function SkillDevKit.HPPeriodDamage(env, status, value, lowerLimit)
		local ldamage = value
		local llower = lowerLimit
		local actor = env["$actor"]
		local healthSystem = env.global["$HealthSystem"]
		local formationSystem = env.global["$FormationSystem"]
		local battleStatist = env.global["$Statist"]

		local function dmgFunction(battleContext, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			local damage = {
				val = buffValue,
				dotStatus = status
			}
			local result = healthSystem:performHealthDamage(nil, unit, damage, llower)

			if result and battleStatist ~= nil then
				battleStatist:sendStatisticEvent("DoPeriodDamage", {
					unit = actor,
					target = unit,
					detail = result
				})
			end

			if result and result.deadly then
				unit:setFoe(actor:getId())
				formationSystem:excludeDyingUnit(unit)
			end

			return result
		end

		local var_55_0 = {
			status = status
		}

		if type(ldamage) == "table" then
			var_55_0.value = ldamage.val or ldamage
		end

		var_55_0.callback = dmgFunction

		return (StatusEffect:new(var_55_0))
	end

	function SkillDevKit.HPPeriodRecover(env, status, value)
		local lvalue = value
		local actor = env["$actor"]
		local healthSystem = env.global["$HealthSystem"]
		local battleStatist = env.global["$Statist"]

		local function dmgFunction(battleContext, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			local unitFlagComp = unit:getComponent("Flag")

			if unitFlagComp:hasStatus(kBECurse) then
				return (healthSystem:performHealthDamage(nil, unit, buffValue, 1))
			else
				local result = healthSystem:performHealthRecovery(nil, unit, buffValue)

				if result and battleStatist ~= nil then
					battleStatist:sendStatisticEvent("DoPeriodRecover", {
						unit = actor,
						target = unit,
						detail = result
					})
				end

				return result
			end
		end

		local var_57_0 = {
			status = status
		}

		if type(lvalue) == "table" then
			var_57_0.value = lvalue.val or lvalue
		end

		var_57_0.callback = dmgFunction

		return (StatusEffect:new(var_57_0))
	end

	function SkillDevKit.AngerPeriodRecover(env, status, value)
		local lvalue = value
		local angerSystem = env.global["$AngerSystem"]

		local function dmgFunction(battleContext, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			return angerSystem:performAngerRecovery(nil, unit, buffValue)
		end

		local var_59_0 = {
			status = status
		}

		if type(lvalue) == "table" then
			var_59_0.value = lvalue.val or lvalue
		end

		var_59_0.callback = dmgFunction

		return (StatusEffect:new(var_59_0))
	end

	function SkillDevKit.AngerPeriodDamage(env, status, value)
		local lvalue = value
		local angerSystem = env.global["$AngerSystem"]

		local function dmgFunction(battleContext, unit, buffValue)
			if not unit:isInStages(ULS_Normal) then
				return
			end

			return angerSystem:performAngerDamage(nil, unit, buffValue)
		end

		local var_61_0 = {
			status = status
		}

		if type(lvalue) == "table" then
			var_61_0.value = lvalue.val or lvalue
		end

		var_61_0.callback = dmgFunction

		return (StatusEffect:new(var_61_0))
	end
end
