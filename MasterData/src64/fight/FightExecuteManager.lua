local var_0_0 = {}
local skill_manager = require("fight.skill_manager")
local FightMessage = require("fight.FightMessage")
local skill_data = require("data.skill_data")
local var_0_4 = _G.CalculateStrikeDodgeCriBlind
local var_0_5 = _G.CalculateExtraDamage

local function var_0_6(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if config._DEVELOP_MODE ~= "FIGHTDEV" then
		return
	end

	require("devtools.fight_test_bridge"):sendSnap({
		attacker = arg_1_0.index,
		defencer = arg_1_1.index,
		skillid = arg_1_2,
		damage = arg_1_3,
		re_heal = arg_1_4,
		attacker_rage = arg_1_0:getAttribute("rage"),
		attacker_modelid = arg_1_0:getAttribute("modelid"),
		attacker_attack = arg_1_0:getAttribute("damage"),
		attacker_defence = arg_1_0:getAttribute("defence"),
		defencer_rage = arg_1_1:getAttribute("rage"),
		defencer_modelid = arg_1_1:getAttribute("modelid"),
		defencer_attack = arg_1_1:getAttribute("damage"),
		defencer_defence = arg_1_1:getAttribute("defence")
	})
end

function var_0_0.runAttack(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_1:refreshExternAttribute()
	arg_2_2:refreshExternAttribute()

	local var_2_0 = assert(skill_data[arg_2_3], "skill " .. arg_2_3 .. " is nil")
	local var_2_1 = var_2_0.damagetype or MECHANICAL_DAMAGE
	local var_2_2 = FightMessage.new()

	var_2_2.damage = 0

	arg_2_1:triggerStatus("onAttack", arg_2_2, var_2_2)

	if arg_2_4.msg.doubleattack then
		arg_2_1:triggerStatus("onDoubleHit", arg_2_2, var_2_2)
	end

	arg_2_2:triggerStatus("onHitted", arg_2_1, var_2_2)
	arg_2_1:triggerStatus("onOffence", arg_2_2, var_2_2)
	arg_2_2:triggerStatus("onDefence", arg_2_1, var_2_2)
	skill_manager(arg_2_1, arg_2_2).runSkill(arg_2_3, var_2_2)

	local var_2_3, var_2_4, var_2_5, var_2_6 = var_0_4(var_2_2, var_2_1, arg_2_1, arg_2_2, 1)

	if var_2_3 then
		var_2_2.info.isBlind = true

		arg_2_2:beHitted({
			damage = 0,
			info = var_2_2.info
		})

		return
	end

	if arg_2_4.effect then
		for iter_2_0, iter_2_1 in pairs(arg_2_4.effect) do
			arg_2_2:playEffect(iter_2_1.name, iter_2_1.ani, iter_2_1.offsetX, iter_2_1.offsetY, iter_2_1.offsetZ, iter_2_1.direction)
		end
	end

	if arg_2_4.force and next(arg_2_4.force) then
		for iter_2_2, iter_2_3 in pairs(arg_2_4.force) do
			arg_2_2:playXPForce(iter_2_3.distance, arg_2_1:getDirection(), iter_2_3.time, iter_2_3.shutdown)
		end

		arg_2_1:triggerStatus("onForce", arg_2_2, var_2_2)
		arg_2_2:triggerStatus("onBeForced", arg_2_1, var_2_2)
	elseif arg_2_1:getAttribute("force") > 0 then
		local var_2_7 = arg_2_1:getAttribute("force")

		if arg_2_2:playAttackForce(var_2_7, arg_2_1:getDirection(), var_2_7 / 100 * 0.1, false) then
			arg_2_1:triggerStatus("onForce", arg_2_2, var_2_2)
			arg_2_2:triggerStatus("onBeForced", arg_2_1, var_2_2)
		end
	end

	if arg_2_4.forceY then
		arg_2_2:playForceY(arg_2_4.forceY[1].distance, arg_2_4.forceY[1].time, arg_2_4.forceY[1].speed, arg_2_4.forceY[1].shutdown)
	end

	local var_2_8 = 1 + arg_2_1:getAttribute("cri_damage_add")
	local var_2_9 = 1 - arg_2_2:getAttribute("dodge_damage_add")

	if var_2_9 < 0 then
		var_2_9 = 0
	end

	var_2_2.damage = var_2_2.damage * (var_2_6 and var_2_8 or 1) * (var_2_5 and var_2_9 or 1) * (var_2_4 and 1 + arg_2_1:getAttribute("strike_damage_add") or 1)
	var_2_2.damage = var_0_5(var_2_1, var_2_2.damage, arg_2_1, arg_2_2)

	if var_2_2.info.isRes == nil then
		local var_2_10, var_2_11 = calculate_majorattr_addition(arg_2_1, arg_2_2)

		var_2_2.damage = var_2_2.damage * var_2_11
		var_2_2.info.isRes = var_2_10
	end

	var_2_2.damage = math.round(var_2_2.damage)

	if var_2_2.damage < 0 then
		var_2_2.damage = 0
	end

	var_2_2.info.isCri = var_2_6
	var_2_2.info.isMiss = var_2_5
	var_2_2.info.isStrike = var_2_4
	var_2_2.source = arg_2_1.index

	arg_2_1:triggerStatus("onAttack2", arg_2_2, var_2_2)
	arg_2_2:triggerStatus("onHitted2", arg_2_1, var_2_2)
	arg_2_1:triggerStatus("onOffence2", arg_2_2, var_2_2)
	arg_2_2:triggerStatus("onDefence2", arg_2_1, var_2_2)

	if not arg_2_4.msg.firstattack then
		arg_2_4.msg.firstattack = true

		arg_2_1:triggerStatus("onFirstAttack", arg_2_2, var_2_2)
	end

	local var_2_12 = math.round(var_2_2.damage * (arg_2_1:getAttribute("hematophagy") + var_2_2.effect.hematophagy))

	var_2_2.heal = var_2_2.heal + var_2_12
	var_2_2.heal = math.round(var_2_2.heal)

	if var_2_12 > 0 then
		arg_2_1:triggerStatus("onHematophagy", arg_2_2, var_2_2)
	end

	var_2_2.info.beattype = 1

	arg_2_2:getRecovery({
		heal = math.round(var_2_2.re_heal),
		sourceindex = var_2_2.source
	})
	arg_2_1:getRecovery({
		heal = math.round(var_2_2.heal),
		sourceindex = var_2_2.source
	})
	var_0_6(arg_2_1, arg_2_2, arg_2_3, var_2_2.damage, var_2_2.re_heal)

	if arg_2_2:beHitted({
		damage = math.round(var_2_2.damage),
		damagetype = var_2_1,
		info = var_2_2.info,
		behitted = arg_2_4.behitted,
		sourceindex = var_2_2.source,
		immortallimit = var_2_2.effect.immortal_limit,
		ragefac = var_2_0.ragefac,
		skilltype = arg_2_4.msg.skilltype
	}) then
		arg_2_1:triggerStatus("onKill", arg_2_2)
		arg_2_1:addRageByValue(arg_2_1:getAttribute("rage_on_kill"))
	else
		if not arg_2_4.msg.doubleattack and var_2_2.doubleattack then
			arg_2_1:doDoubleAttack(arg_2_4.msg)
		end

		arg_2_2:refreshExternAttribute()
	end

	arg_2_1:refreshExternAttribute()
end

function var_0_0.runNormalSkill(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_1:refreshExternAttribute()
	arg_3_2:refreshExternAttribute()

	if arg_3_4.effect then
		for iter_3_0, iter_3_1 in pairs(arg_3_4.effect) do
			arg_3_2:playEffect(iter_3_1.name, iter_3_1.ani, iter_3_1.offsetX, iter_3_1.offsetY, iter_3_1.offsetZ, iter_3_1.direction)
		end
	end

	local var_3_0 = assert(skill_data[arg_3_3], "skill " .. arg_3_3 .. " is nil")
	local var_3_1 = var_3_0.damagetype or MECHANICAL_DAMAGE
	local var_3_2 = FightMessage.new()

	arg_3_1:triggerStatus("onNormalSkill", arg_3_2, var_3_2)
	arg_3_1:triggerStatus("onSkill", arg_3_2, var_3_2)
	arg_3_1:triggerStatus("onOffence", arg_3_2, var_3_2)
	arg_3_2:triggerStatus("onDefence", arg_3_1, var_3_2)
	skill_manager(arg_3_1, arg_3_2).runSkill(arg_3_3, var_3_2)

	local var_3_3, var_3_4, var_3_5, var_3_6 = var_0_4(var_3_2, var_3_1, arg_3_1, arg_3_2, 3)

	if var_3_3 then
		var_3_2.info.isBlind = true

		arg_3_2:beHitted({
			damage = 0,
			info = var_3_2.info
		})

		return
	end

	if arg_3_4.force then
		for iter_3_2, iter_3_3 in pairs(arg_3_4.force) do
			arg_3_2:playXPForce(iter_3_3.distance, arg_3_1:getDirection(), iter_3_3.time, iter_3_3.shutdown)
		end

		arg_3_1:triggerStatus("onForce", arg_3_2, var_3_2)
		arg_3_2:triggerStatus("onBeForced", arg_3_1, var_3_2)
	end

	if arg_3_4.forceY then
		arg_3_2:playForceY(arg_3_4.forceY[1].distance, arg_3_4.forceY[1].time, arg_3_4.forceY[1].speed, arg_3_4.forceY[1].shutdown)
	end

	local var_3_7 = 1 + arg_3_1:getAttribute("cri_damage_add")
	local var_3_8 = 1 - arg_3_2:getAttribute("dodge_damage_add")

	if var_3_8 < 0 then
		var_3_8 = 0
	end

	var_3_2.damage = var_3_2.damage * (var_3_6 and var_3_7 or 1) * (var_3_5 and var_3_8 or 1) * (var_3_4 and 1 + arg_3_1:getAttribute("strike_damage_add") or 1)
	var_3_2.damage = var_0_5(var_3_1, var_3_2.damage, arg_3_1, arg_3_2)

	if var_3_2.info.isRes == nil then
		local var_3_9, var_3_10 = calculate_majorattr_addition(arg_3_1, arg_3_2)

		var_3_2.damage = var_3_2.damage * var_3_10
		var_3_2.info.isRes = var_3_9
	end

	arg_3_1:triggerStatus("onOffence2", arg_3_2, var_3_2)
	arg_3_2:triggerStatus("onDefence2", arg_3_1, var_3_2)

	var_3_2.info.isCri = var_3_6
	var_3_2.info.isMiss = var_3_5
	var_3_2.info.isStrike = var_3_4
	var_3_2.source = arg_3_1.index
	var_3_2.info.beattype = 3

	arg_3_2:getRecovery({
		heal = math.round(var_3_2.re_heal),
		sourceindex = var_3_2.source
	})

	var_3_2.heal = var_3_2.heal + var_3_2.damage * var_3_2.effect.hematophagy

	arg_3_1:getRecovery({
		heal = math.round(var_3_2.heal),
		sourceindex = var_3_2.source
	})
	var_0_6(arg_3_1, arg_3_2, arg_3_3, var_3_2.damage, var_3_2.re_heal)

	if arg_3_2:beHitted({
		damage = math.round(var_3_2.damage),
		damagetype = var_3_1,
		info = var_3_2.info,
		behitted = arg_3_4.behitted,
		sourceindex = var_3_2.source,
		immortallimit = var_3_2.effect.immortal_limit,
		ragefac = var_3_0.ragefac,
		skilltype = arg_3_4.msg.skilltype
	}) then
		arg_3_1:triggerStatus("onKill", arg_3_2)
		arg_3_1:addRageByValue(arg_3_1:getAttribute("rage_on_kill"))
	else
		arg_3_2:refreshExternAttribute()
	end

	arg_3_1:refreshExternAttribute()
end

function var_0_0.runXP(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_1:refreshExternAttribute()
	arg_4_2:refreshExternAttribute()

	if arg_4_4.effect then
		for iter_4_0, iter_4_1 in pairs(arg_4_4.effect) do
			arg_4_2:playEffect(iter_4_1.name, iter_4_1.ani, iter_4_1.offsetX, iter_4_1.offsetY, iter_4_1.offsetZ, iter_4_1.direction)
		end
	end

	local var_4_0 = assert(skill_data[arg_4_3], "skill " .. arg_4_3 .. " is nil")
	local var_4_1 = var_4_0.damagetype or MECHANICAL_DAMAGE
	local var_4_2 = FightMessage.new()

	arg_4_1:triggerStatus("onXP", arg_4_2, var_4_2)
	arg_4_1:triggerStatus("onSkill", arg_4_2, var_4_2)
	arg_4_1:triggerStatus("onOffence", arg_4_2, var_4_2)
	arg_4_2:triggerStatus("onDefence", arg_4_1, var_4_2)
	skill_manager(arg_4_1, arg_4_2).runSkill(arg_4_3, var_4_2)

	local var_4_3, var_4_4, var_4_5, var_4_6 = var_0_4(var_4_2, var_4_1, arg_4_1, arg_4_2, 2)

	if var_4_3 then
		var_4_2.info.isBlind = true

		arg_4_2:beHitted({
			damage = 0,
			info = var_4_2.info
		})

		return
	end

	if arg_4_4.force then
		for iter_4_2, iter_4_3 in pairs(arg_4_4.force) do
			arg_4_2:playXPForce(iter_4_3.distance, arg_4_1:getDirection(), iter_4_3.time, iter_4_3.shutdown)
		end

		arg_4_1:triggerStatus("onForce", arg_4_2, var_4_2)
		arg_4_2:triggerStatus("onBeForced", arg_4_1, var_4_2)
	end

	if arg_4_4.forceY then
		arg_4_2:playForceY(arg_4_4.forceY[1].distance, arg_4_4.forceY[1].time, arg_4_4.forceY[1].speed, arg_4_4.forceY[1].shutdown)
	end

	local var_4_7 = 1 + arg_4_1:getAttribute("cri_damage_add")
	local var_4_8 = 1 - arg_4_2:getAttribute("dodge_damage_add")

	if var_4_8 < 0 then
		var_4_8 = 0
	end

	var_4_2.damage = var_4_2.damage * (var_4_6 and var_4_7 or 1) * (var_4_5 and var_4_8 or 1) * (var_4_4 and 1 + arg_4_1:getAttribute("strike_damage_add") or 1)
	var_4_2.damage = var_0_5(var_4_1, var_4_2.damage, arg_4_1, arg_4_2)

	if var_4_2.info.isRes == nil then
		local var_4_9, var_4_10 = calculate_majorattr_addition(arg_4_1, arg_4_2)

		var_4_2.damage = var_4_2.damage * var_4_10
		var_4_2.info.isRes = var_4_9
	end

	arg_4_1:triggerStatus("onOffence2", arg_4_2, var_4_2)
	arg_4_2:triggerStatus("onDefence2", arg_4_1, var_4_2)

	var_4_2.info.isCri = var_4_6
	var_4_2.info.isMiss = var_4_5
	var_4_2.info.isStrike = var_4_4
	var_4_2.source = arg_4_1.index
	var_4_2.info.beattype = 2

	arg_4_2:getRecovery({
		heal = math.round(var_4_2.re_heal),
		sourceindex = var_4_2.source
	})

	var_4_2.heal = var_4_2.heal + var_4_2.damage * var_4_2.effect.hematophagy

	arg_4_1:getRecovery({
		heal = math.round(var_4_2.heal),
		sourceindex = var_4_2.source
	})
	var_0_6(arg_4_1, arg_4_2, arg_4_3, var_4_2.damage, var_4_2.re_heal)

	if arg_4_2:beHitted({
		damage = math.round(var_4_2.damage),
		damagetype = var_4_1,
		info = var_4_2.info,
		behitted = arg_4_4.behitted,
		sourceindex = var_4_2.source,
		immortallimit = var_4_2.effect.immortal_limit,
		ragefac = var_4_0.ragefac,
		skilltype = arg_4_4.msg.skilltype
	}) then
		arg_4_1:triggerStatus("onKill", arg_4_2)
		arg_4_1:addRageByValue(arg_4_1:getAttribute("rage_on_kill"))
	else
		arg_4_2:refreshExternAttribute()
	end

	arg_4_1:refreshExternAttribute()
end

function var_0_0:attack(arg_5_1, arg_5_2)
	local var_5_0 = assert(skill_data[arg_5_2.id], "skill " .. arg_5_2.id .. " is nil")
	local var_5_1 = arg_5_2.assigned_target
	local var_5_2 = var_5_0.skilltype

	if arg_5_2.assigned_target == nil and var_5_0.exe_target == 1 or type(var_5_1) == "string" then
		local var_5_3

		if var_5_0.exe_target == 1 then
			var_5_3 = arg_5_1
		elseif var_5_0.exe_target == 5 then
			var_5_3 = FightManager.getCharacter(var_5_1)
		end

		if var_5_3 and var_5_3:canBeHit() then
			if var_5_2 == 1 then
				self:runAttack(arg_5_1, var_5_3, arg_5_2.id, arg_5_2)
			elseif var_5_2 == 2 then
				self:runXP(arg_5_1, var_5_3, arg_5_2.id, arg_5_2)
			elseif var_5_2 == 3 then
				self:runNormalSkill(arg_5_1, var_5_3, arg_5_2.id, arg_5_2)
			end
		end
	elseif type(var_5_1) == "table" then
		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			local var_5_4

			if var_5_0.exe_target == 1 then
				var_5_4 = arg_5_1
			elseif var_5_0.exe_target == 5 then
				var_5_4 = FightManager.getCharacter(iter_5_1)
			end

			if var_5_4 and var_5_4:canBeHit() then
				if var_5_2 == 1 then
					self:runAttack(arg_5_1, var_5_4, arg_5_2.id, arg_5_2)
				elseif var_5_2 == 2 then
					self:runXP(arg_5_1, var_5_4, arg_5_2.id, arg_5_2)
				elseif var_5_2 == 3 then
					self:runNormalSkill(arg_5_1, var_5_4, arg_5_2.id, arg_5_2)
				end
			end
		end
	end
end

local function var_0_7(arg_6_0, arg_6_1)
	if arg_6_0 ~= -1 then
		return arg_6_0
	end

	if not arg_6_1 then
		return arg_6_0
	end

	return arg_6_1:getAttribute("range")
end

function var_0_0:aoeAttack(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2.run_node:getStandardPosition()
	local var_7_1 = assert(skill_data[arg_7_2.id], "skill " .. arg_7_2.id .. " is nil")

	assert(var_7_1.exe_target ~= nil, "exe target of skill can not be nil, skill id is " .. arg_7_2.id)

	local var_7_2 = var_7_1.skilltype
	local var_7_3

	if var_7_1.exe_target == ALLTEAMMATE then
		var_7_3 = arg_7_1:getAllTeammate()
	elseif var_7_1.exe_target == TEAMMATE_IN_AREA_OF_SELF then
		var_7_3 = arg_7_1:getAreaTeammate(arg_7_1:getStandardPosition(), var_0_7(var_7_1.effective_left_offset, arg_7_1), var_0_7(var_7_1.effective_right_offset, arg_7_1))
	elseif var_7_1.exe_target == TEAMMATE_IN_AREA_OF_TARGET then
		local var_7_4, var_7_5 = arg_7_1:getTarget()

		if var_7_5 then
			var_7_4 = var_7_4[1]
		end

		if not var_7_4 then
			return
		end

		var_7_3 = arg_7_1:getAreaTeammate(var_7_4:getStandardPosition(), var_0_7(var_7_1.effective_left_offset, arg_7_1), var_0_7(var_7_1.effective_right_offset, arg_7_1))
	elseif var_7_1.exe_target == TEAMMATE_IN_AREA then
		local var_7_6 = arg_7_2.run_node:getModelWidth()

		var_7_3 = arg_7_1:getAreaTeammate(var_7_0, var_0_7(var_7_1.effective_left_offset, arg_7_1) + var_7_6 / 2, var_0_7(var_7_1.effective_right_offset, arg_7_1) + var_7_6 / 2)
	elseif var_7_1.exe_target == ALLOPONENT then
		var_7_3 = arg_7_1:getAllOponent()
	elseif var_7_1.exe_target == OPONENT_IN_AREA_OF_SELF then
		var_7_3 = arg_7_1:getAreaOponent(arg_7_1:getStandardPosition(), var_0_7(var_7_1.effective_left_offset, arg_7_1), var_0_7(var_7_1.effective_right_offset, arg_7_1))
	elseif var_7_1.exe_target == OPONENT_IN_AREA_OF_TARGET then
		local var_7_7, var_7_8 = arg_7_1:getTarget()

		if var_7_8 then
			var_7_7 = var_7_7[1]
		end

		if not var_7_7 then
			return
		end

		var_7_3 = arg_7_1:getAreaOponent(var_7_7:getStandardPosition(), var_0_7(var_7_1.effective_left_offset, arg_7_1), var_0_7(var_7_1.effective_right_offset, arg_7_1))
	elseif var_7_1.exe_target == OPONENT_IN_AREA then
		local var_7_9 = arg_7_2.run_node:getModelWidth()

		var_7_3 = arg_7_1:getAreaOponent(var_7_0, var_0_7(var_7_1.effective_left_offset, arg_7_1) + var_7_9 / 2, var_0_7(var_7_1.effective_right_offset, arg_7_1) + var_7_9 / 2)
	elseif var_7_1.exe_target == TEAMMATE_WITHOUT_SELF then
		var_7_3 = {}

		for iter_7_0, iter_7_1 in pairs((arg_7_1:getAllTeammate())) do
			if iter_7_1.index ~= arg_7_1.index then
				table.insert(var_7_3, iter_7_1)
			end
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_3) do
		if var_7_2 == 1 then
			self:runAttack(arg_7_1, iter_7_3, arg_7_2.id, arg_7_2)
		elseif var_7_2 == 2 then
			self:runXP(arg_7_1, iter_7_3, arg_7_2.id, arg_7_2)
		elseif var_7_2 == 3 then
			self:runNormalSkill(arg_7_1, iter_7_3, arg_7_2.id, arg_7_2)
		end
	end
end

function var_0_0:runSkill(arg_8_1, arg_8_2)
	if not arg_8_1._instance then
		return
	end

	local var_8_0 = arg_8_2.id

	if not arg_8_2.id then
		self:execute_skill_effect(arg_8_1, arg_8_2)

		return
	end

	local var_8_1 = skill_data[var_8_0]

	if skill_data[var_8_0].need_overclock and not arg_8_1:isCharacterOverClock() then
		return
	end

	if var_8_1.exe_target == OWNERSELF or var_8_1.exe_target == TARGET or var_8_1.exe_target == OPONENT_NEAREST then
		if FightManager.targetInRange(var_8_0, arg_8_1.index, arg_8_1.target) then
			self:attack(arg_8_1, arg_8_2)

			if var_8_1.addrage and var_8_1.addrage > 0 then
				arg_8_1:addRageByValue(var_8_1.addrage * (1 + arg_8_1:getAttribute("extra_skill_rage")) + arg_8_1:getAttribute("extra_skill_rage_const"))
			end
		end
	else
		self:aoeAttack(arg_8_1, arg_8_2)

		if var_8_1.addrage and var_8_1.addrage > 0 then
			arg_8_1:addRageByValue(var_8_1.addrage * (1 + arg_8_1:getAttribute("extra_skill_rage")) + arg_8_1:getAttribute("extra_skill_rage_const"))
		end
	end
end

local function var_0_8(arg_9_0, arg_9_1)
	local var_9_0 = FightManager.getCharacter(arg_9_0)

	if not var_9_0 or not var_9_0._instance then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		var_9_0:playEffect(iter_9_1.name, iter_9_1.ani, iter_9_1.offsetX, iter_9_1.offsetY, iter_9_1.offsetZ, iter_9_1.direction)
	end
end

local function var_0_9(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = FightManager.getCharacter(arg_10_1)

	if not var_10_0 or not var_10_0._instance then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		var_10_0:playForce(iter_10_1.distance, arg_10_0:getDirection(), iter_10_1.time, iter_10_1.shutdown)
	end
end

local function var_0_10(arg_11_0, arg_11_1)
	local var_11_0 = FightManager.getCharacter(arg_11_0)

	if not var_11_0 or not var_11_0._instance then
		return
	end

	var_11_0:playForceY(arg_11_1.distance, arg_11_1.time, arg_11_1.speed, arg_11_1.shutdown)
end

function var_0_0.execute_skill_effect(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2.effect and #arg_12_2.effect > 0 then
		if type(arg_12_2.assigned_target) == "table" then
			for iter_12_0, iter_12_1 in pairs(arg_12_2.assigned_target) do
				var_0_8(iter_12_1, arg_12_2.effect)
			end
		else
			var_0_8(arg_12_2.assigned_target, arg_12_2.effect)
		end
	end

	if arg_12_2.force and #arg_12_2.force > 0 then
		if type(arg_12_2.assigned_target) == "table" then
			for iter_12_2, iter_12_3 in pairs(arg_12_2.assigned_target) do
				var_0_9(arg_12_1, iter_12_3, arg_12_2.force)
			end
		else
			var_0_9(arg_12_1, arg_12_2.assigned_target, arg_12_2.force)
		end
	end

	if arg_12_2.forceY then
		if type(arg_12_2.assigned_target) == "table" then
			for iter_12_4, iter_12_5 in pairs(arg_12_2.assigned_target) do
				var_0_10(iter_12_5, arg_12_2.forceY[1])
			end
		else
			var_0_10(arg_12_2.assigned_target, arg_12_2.forceY[1])
		end
	end
end

return var_0_0
