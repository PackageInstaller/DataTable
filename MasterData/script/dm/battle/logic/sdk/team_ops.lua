-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/team_ops.lua

if not SkillDevKit then
	local function excludeTarget(env, target, joinReferee)
		local formationSystem = env.global["$FormationSystem"]

		if not formationSystem:expelUnit(target, env["$id"], nil, joinReferee) then
			return nil
		end

		target:setLifeStage(ULS_Kicked)

		local battleField = env.global["$BattleField"]

		if battleField then
			battleField:eraseUnit(target)
		end

		return target
	end

	local function forceFleeTarget(env, target, joinReferee)
		local formationSystem = env.global["$FormationSystem"]

		if not formationSystem:fleeUnit(target, env["$id"], true, joinReferee) then
			return nil
		end

		target:setLifeStage(ULS_Kicked)

		local battleField = env.global["$BattleField"]

		if battleField then
			battleField:eraseUnit(target)
		end

		return target
	end

	local function fleeTarget(env, target)
		local formationSystem = env.global["$FormationSystem"]

		if not formationSystem:fleeUnit(target, env["$id"]) then
			return nil
		end

		target:setLifeStage(ULS_Kicked)

		local battleField = env.global["$BattleField"]

		if battleField then
			battleField:eraseUnit(target)
		end

		return target
	end

	local function stopAffectedSkillActions(env, target)
		local executor = env["$executor"]

		executor:stopAllActions("affected", nil, function(otherEnv)
			if otherEnv == env then
				return false
			end

			local references = otherEnv["$references"]

			return references ~= nil and references[target] ~= nil
		end)
	end

	function SkillDevKit.Flee(env, duration, target)
		local target = target or env["$actor"]

		if target == nil or target:isDying() then
			return false
		end

		local unit = fleeTarget(env, target)

		if unit == nil then
			return false
		end

		stopAffectedSkillActions(env, target)

		local var_6_0 = unit:getId()
		local var_6_1 = "Flee"
		local var_6_2 = {
			dur = duration or 600,
			cell = unit:getSide()
		}

		if unit:getComponent("Flag") then
			var_6_2.flags = unit:getComponent("Flag"):getFlags() or {}
		end

		env.global:RecordEffect(var_6_0, var_6_1, var_6_2)

		return true
	end

	function SkillDevKit.ForceFlee(env, duration, joinReferee)
		local target = env["$actor"]

		if target == nil then
			return false
		end

		local unit = forceFleeTarget(env, target, joinReferee)

		if unit == nil then
			return false
		end

		local var_7_0 = unit:getId()
		local var_7_1 = "Flee"
		local var_7_2 = {
			dur = duration or 600,
			cell = unit:getSide()
		}

		if unit:getComponent("Flag") then
			var_7_2.flags = unit:getComponent("Flag"):getFlags() or {}
		end

		env.global:RecordEffect(var_7_0, var_7_1, var_7_2)

		return true
	end

	function SkillDevKit.WontDie(env, target)
		local target = target or env["$actor"]
		local formationSystem = env.global["$FormationSystem"]

		formationSystem:wontDieUnit(target)
	end

	function SkillDevKit.Expel(env, target, animation)
		if target == nil or target:isDying() then
			return false
		end

		local unit = excludeTarget(env, target)

		if unit == nil then
			return false
		end

		stopAffectedSkillActions(env, target)
		env.global.RecordEffect(env, unit:getId(), "Expelled", animation)

		return true
	end

	function SkillDevKit.ForceKick(env, target)
		local formationSystem = env.global["$FormationSystem"]

		return formationSystem:_kickUnit(target)
	end

	function SkillDevKit.Kick(env, target, joinReferee)
		joinReferee = joinReferee or false

		local unit = excludeTarget(env, target, joinReferee)

		if unit == nil then
			return false
		end

		stopAffectedSkillActions(env, target)
		env.global.RecordEffect(env, unit:getId(), "Kick", animation)

		return true
	end

	function SkillDevKit.Revive(env, hpRatio, anger, location)
		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]

		return formationSystem:revive(actor, hpRatio, anger, location)
	end

	function SkillDevKit.ReviveByUnit(env, unit, hpRatio, anger, location, owner)
		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]

		return formationSystem:reviveByUnit(actor, unit, hpRatio, anger, location, owner)
	end

	function SkillDevKit.ReviveByUnitSigleTon(env, unit, hpRatio, anger, location, owner)
		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]

		return formationSystem:reviveByUnitSigleTon(actor, unit, hpRatio, anger, location, owner)
	end

	function SkillDevKit.ReviveRandom(env, hpRatio, anger, location)
		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]

		return formationSystem:reviveRandom(actor, hpRatio, anger, location)
	end

	function SkillDevKit.Reborn(env, ratio)
		local actor = env["$actor"]

		if actor:isInStages(ULS_Dying) then
			local healthComp = actor:getComponent("Health")

			healthComp:setHp(healthComp:getMaxHp() * ratio)

			if healthComp:getHp() > 0 then
				actor:setLifeStage(ULS_Reviving)
				env.global.RecordEffect(env, actor:getId(), "reborn", {
					hp = healthComp:getHp()
				})
			end
		end
	end

	function SkillDevKit.RebornUnit(env, unit, ratio, anger, location)
		if unit:isInStages(ULS_Dead) then
			local formationSystem = env.global["$FormationSystem"]

			formationSystem:rebornUnit(unit, ratio, anger, location)
		end
	end

	function SkillDevKit.Summon(env, source, summonId, summonFactor, summonExtra, location, curHpRatio)
		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]
		local var_18_0 = {}

		if summonFactor then
			var_18_0.hpRatio = summonFactor[1] or 1
		end

		if summonFactor then
			var_18_0.atkRatio = summonFactor[2] or 1
		end

		if summonFactor then
			var_18_0.defRatio = summonFactor[3] or 1
		end

		if summonExtra then
			var_18_0.hpEx = summonExtra[1] or 0
		end

		if summonExtra then
			var_18_0.atkEx = summonExtra[2] or 0
		end

		if summonExtra then
			var_18_0.defEx = summonExtra[3] or 0
		end

		var_18_0.curHpRatio = curHpRatio or 1

		local factors = var_18_0

		return formationSystem:summon(actor, source, summonId, factors, location)
	end

	function SkillDevKit.SummonMaster(env, source, summonId, summonFactor, summonExtra, location, curHpRatio)
		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]
		local var_19_0 = {}

		if summonFactor then
			var_19_0.hpRatio = summonFactor[1] or 1
		end

		if summonFactor then
			var_19_0.atkRatio = summonFactor[2] or 1
		end

		if summonFactor then
			var_19_0.defRatio = summonFactor[3] or 1
		end

		if summonExtra then
			var_19_0.hpEx = summonExtra[1] or 0
		end

		if summonExtra then
			var_19_0.atkEx = summonExtra[2] or 0
		end

		if summonExtra then
			var_19_0.defEx = summonExtra[3] or 0
		end

		var_19_0.curHpRatio = curHpRatio or 1

		local factors = var_19_0

		return formationSystem:summonMaster(actor, source, summonId, factors, env["$id"])
	end

	function SkillDevKit.SpawnByTransform(env, player, source, location, isMarkedSummon)
		local formationSystem = env.global["$FormationSystem"]

		return formationSystem:SpawnByTransform(player, source, location, isMarkedSummon)
	end

	function SkillDevKit.SpawnAssist(env, assistId, player, cellId)
		local actor = env["$actor"]
		local formationSystem = env.global["$FormationSystem"]

		formationSystem:spawnAssist(actor, assistId, player, cellId)
	end

	function SkillDevKit.MarkSummoned(env, unit, isMarkSummon)
		if unit then
			unit:setIsSummoned(isMarkSummon)
			env.global.RecordImmediately(env, unit:getId(), "IsSummond", {
				isSummoned = isMarkSummon
			})
		end
	end

	function SkillDevKit.Suicide(env)
		local actor = env["$actor"]
		local workId = env["$id"]

		actor:setLifeStage(ULS_Dying)

		local formationSystem = env.global["$FormationSystem"]

		formationSystem:excludeDyingUnit(actor, workId)
		env.global.RecordEffect(env, actor:getId(), "Suicide")
	end

	function SkillDevKit.KillTarget(env, target)
		local workId = env["$id"]

		target:setLifeStage(ULS_Dying)

		local skillSystem = env.global["$SkillSystem"]

		skillSystem:activateSpecificTrigger(target, "DYING")
		skillSystem:activateGlobalTrigger("UNIT_DYING", {
			unit = target
		})

		local formationSystem = env.global["$FormationSystem"]
		local actor = env["$actor"]

		target:setFoe(actor:getId())
		formationSystem:excludeDyingUnit(target, workId)
		env.global.RecordEffect(env, target:getId(), "KillTarget")
	end

	function SkillDevKit.GetPlayerEnergy(env, unit)
		local player = env["$actor"]:getOwner()

		if unit then
			-- block empty
		end

		return unit:getOwner():getEnergyReservoir():getEnergy()
	end

	function SkillDevKit.ThrownKick(env, target, joinReferee)
		joinReferee = joinReferee or false

		local unit = excludeTarget(env, target, joinReferee)

		if unit == nil then
			return false
		end

		stopAffectedSkillActions(env, target)
		env.global.RecordEffect(env, unit:getId(), "ThrownKick", animation)

		return true
	end
end
