local var_0_0 = {}

require("fight.fightstatus.FightStatus")
require("fight.fightstatus.FightBuff")

local trigger_manager = require("fight.trigger_manager")
local status_data = require("data.status_data")
local skill_data = require("data.skill_data")
local buff_data = require("data.buff_data")

function var_0_0:init(arg_1_1)
	self.ref = setmetatable({}, {
		__mode = "kv"
	})
	self.ref.character = arg_1_1

	self:initPool()
end

function var_0_0.initPool(arg_2_0)
	arg_2_0.pool = {
		_status = {
			bkb = false,
			addattrweak = 0,
			addict_count = 0,
			stone = false,
			immortal = false,
			disappear = false,
			confine = false,
			vertigo = false,
			impotence = false,
			fly_count = 0,
			ragefree = false,
			forceimmune_count = 0,
			superimmortal_count = 0,
			suffer_damage_change_mechanical = false,
			ignore_dodge_count = 0,
			stone_count = 0,
			invincible = false,
			heallimit_count = 0,
			silence = false,
			silence_count = 0,
			transferdamage = false,
			ignoremaxdamage = false,
			ragelimit = false,
			bkb_count = 0,
			invalidate_superimmortal = false,
			revivallimit_count = 0,
			forceimmune = false,
			ignore_dodge = false,
			invalidate_superimmortal_count = 0,
			vertigo_count = 0,
			superimmortal = false,
			confine_count = 0,
			superimmortal_count_temp = 0,
			ragefree_count = 0,
			frozen = false,
			mock_status_count = 0,
			fear_count = 0,
			antihitdown = false,
			damage_change_mechanical = false,
			immortal_count = 0,
			suffer_damage_change_mechanical_count = 0,
			ragelimit_count = 0,
			mock_status = false,
			damage_change_mechanical_count = 0,
			antihitdown_count = 0,
			fear = false,
			disappear_count = 0,
			revivallimit = false,
			invincible_count = 0,
			addict = false,
			frozen_count = 0,
			heallimit = false,
			impotence_count = 0,
			shield = {
				total = 0,
				list = {}
			}
		},
		_fightstatuslist = {},
		_statusunionprob = {},
		_conditions = {},
		_basicattr = {},
		_buffs = {
			buff = {},
			debuff = {}
		},
		_buffindex = {
			buff = {},
			debuff = {}
		},
		_statusprobaddition = {},
		_statuscdaddition = {},
		_statusvalueaddition = {
			{},
			{}
		},
		_statustypevalueaddition = {
			{},
			{}
		},
		_statusvaluerandomaddition = {
			{},
			{}
		},
		_statustypevaluerandomaddition = {
			{},
			{}
		},
		_bufftimeadd = {
			{},
			{}
		},
		_buffstackadd = {
			{},
			{}
		},
		_allbufftimefac = {
			{
				debuff = 0,
				buff = 0
			},
			{
				debuff = 0,
				buff = 0
			}
		},
		immune_debuff = {},
		immune_debuffid = {}
	}
end

function var_0_0:setStatus(arg_3_1, arg_3_2)
	self.pool._status[arg_3_1] = arg_3_2
end

function var_0_0:getStatus(arg_4_1)
	return self.pool._status[arg_4_1]
end

function var_0_0:isSuppress()
	return self.pool._status.vertigo or self.pool._status.stone or self.pool._status.addict or self.pool._status.confine or self.pool._status.fear or self.pool._status.frozen
end

function var_0_0:addStatus(arg_6_1, arg_6_2)
	self.pool._status[arg_6_1] = self.pool._status[arg_6_1] + arg_6_2

	if self.pool._status[arg_6_1] < 0 then
		self.pool._status[arg_6_1] = 0
	end
end

function var_0_0:checkStatus(arg_7_1)
	return self.pool._status[arg_7_1]
end

function var_0_0.cleanAllStatus(arg_8_0)
	return
end

function var_0_0:addImmuneDebuff(arg_9_1)
	self.pool.immune_debuff[arg_9_1] = (self.pool.immune_debuff[arg_9_1] or 0) + 1
end

function var_0_0:removeImmuneDebuff(arg_10_1)
	self.pool.immune_debuff[arg_10_1] = (self.pool.immune_debuff[arg_10_1] or 0) - 1

	if self.pool.immune_debuff[arg_10_1] <= 0 then
		self.pool.immune_debuff[arg_10_1] = nil
	end
end

function var_0_0:isImmuneDebuff(arg_11_1)
	return self.pool.immune_debuff[arg_11_1] and self.pool.immune_debuff[arg_11_1] > 0
end

function var_0_0:addImmuneDebuffID(arg_12_1)
	self.pool.immune_debuffid[arg_12_1] = (self.pool.immune_debuffid[arg_12_1] or 0) + 1
end

function var_0_0:removeImmuneDebuffID(arg_13_1)
	self.pool.immune_debuffid[arg_13_1] = (self.pool.immune_debuffid[arg_13_1] or 0) - 1

	if self.pool.immune_debuffid[arg_13_1] <= 0 then
		self.pool.immune_debuffid[arg_13_1] = nil
	end
end

function var_0_0:isImmuneDebuffByID(arg_14_1)
	return self.pool.immune_debuffid[arg_14_1] and self.pool.immune_debuffid[arg_14_1] > 0
end

local var_0_5 = {
	[ATTACKSPEED_MINUS] = true
}

function var_0_0:isImmuneDebuffByAllStatus(arg_15_1)
	while buff_data[arg_15_1]["status_add" .. 1] do
		if var_0_5[status_data[buff_data[arg_15_1]["status_add" .. 1]].status_type] then
			return self:isImmuneDebuff(status_data[buff_data[arg_15_1]["status_add" .. 1]].status_type)
		end
	end

	return false
end

function var_0_0:registerToStatusPool(arg_16_1, arg_16_2)
	if arg_16_2.basicattr then
		for iter_16_0, iter_16_1 in pairs(arg_16_2.basicattr) do
			self.pool._basicattr[iter_16_1] = self.pool._basicattr[iter_16_1] or {}
			self.pool._basicattr[iter_16_1][arg_16_1] = true
		end
	elseif arg_16_2.condition then
		self.pool._conditions[arg_16_2.condition] = self.pool._conditions[arg_16_2.condition] or {}
		self.pool._conditions[arg_16_2.condition][arg_16_1] = true
	end
end

function var_0_0:unregisterFromStatusPool(arg_17_1, arg_17_2)
	if arg_17_2.basicattr then
		for iter_17_0, iter_17_1 in pairs(arg_17_2.basicattr) do
			self.pool._basicattr[iter_17_1] = self.pool._basicattr[iter_17_1] or {}
			self.pool._basicattr[iter_17_1][arg_17_1] = nil
		end
	elseif arg_17_2.condition then
		self.pool._conditions[arg_17_2.condition] = self.pool._conditions[arg_17_2.condition] or {}
		self.pool._conditions[arg_17_2.condition][arg_17_1] = nil
	end

	self.pool._fightstatuslist[arg_17_1] = nil
end

function var_0_0:registerStatus(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if self.pool._fightstatuslist[arg_18_2 .. "_" .. arg_18_3 .. "_" .. arg_18_1] then
		self.pool._fightstatuslist[arg_18_2 .. "_" .. arg_18_3 .. "_" .. arg_18_1]:pushStatus()
	else
		self.pool._fightstatuslist[arg_18_2 .. "_" .. arg_18_3 .. "_" .. arg_18_1] = FightStatus:create(arg_18_2 .. "_" .. arg_18_3 .. "_" .. arg_18_1, arg_18_1, self.ref.character.index, arg_18_3, arg_18_4, arg_18_2)
	end
end

function var_0_0:unregisterStatus(...)
	local var_19_0 = {
		...
	}
	local var_19_1 = #var_19_0 == 3 and var_19_0[2] .. "_" .. var_19_0[3] .. "_" .. var_19_0[1] or var_19_0[1]

	if self.pool._fightstatuslist[var_19_1] then
		self.pool._fightstatuslist[var_19_1]:removeStatus()
	end
end

function var_0_0:getStatusCount(arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(self.pool._fightstatuslist) do
		if iter_20_1._id == arg_20_1 then
			var_20_0 = var_20_0 + iter_20_1:getStatusCount()
		end
	end

	return var_20_0
end

function var_0_0:registerStatusList(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if not arg_21_1.exe_type then
		return
	end

	if arg_21_1.exe_type == 0 then
		local var_21_0 = 1

		while arg_21_1["status_add" .. var_21_0] do
			local var_21_1 = {
				offset_left = arg_21_1["status_area_offset_left" .. var_21_0],
				offset_right = arg_21_1["status_area_offset_right" .. var_21_0]
			}
			local var_21_2 = {
				exetype = arg_21_1.exe_type,
				execonfig = {
					target = arg_21_1["status_target" .. var_21_0],
					area = var_21_1,
					count = arg_21_1["status_targetcount" .. var_21_0]
				}
			}

			if arg_21_1["ishalo" .. var_21_0] then
				local var_21_3

				if arg_21_1["halo_judge_type" .. var_21_0] then
					var_21_3 = trigger_manager.decode_judge_conditions(arg_21_1["halo_judge_type" .. var_21_0], arg_21_1["halo_judge_target" .. var_21_0], arg_21_1["halo_judge_param" .. var_21_0])
				end

				local var_21_4 = {}

				var_21_4.target = arg_21_1["halo_target" .. var_21_0] or arg_21_1["status_target" .. var_21_0]

				local var_21_5 = {}

				var_21_5.offset_left = arg_21_1["halo_area_offset_left" .. var_21_0] or var_21_1.offset_left
				var_21_5.offset_right = arg_21_1["halo_area_offset_right" .. var_21_0] or var_21_1.offset_right
				var_21_4.area = var_21_5
				var_21_4.influence = arg_21_1["halo_influence" .. var_21_0] or 0
				var_21_4.public_cd = arg_21_1["halo_cd" .. var_21_0]

				FightManager.registerHalo(arg_21_2 .. "@" .. arg_21_1["status_add" .. var_21_0], arg_21_1["status_add" .. var_21_0], self.ref.character.index, var_21_3, var_21_2, var_21_4)
			else
				self:registerStatus(arg_21_1["status_add" .. var_21_0], arg_21_2, arg_21_3, var_21_2)
			end

			var_21_0 = var_21_0 + 1
		end
	else
		local var_21_6 = arg_21_1.insider_cd or 0
		local var_21_7 = arg_21_1.add_type

		if arg_21_1.status_union_prob then
			self.pool._statusunionprob[arg_21_2] = arg_21_1.status_union_prob
		end

		local var_21_8 = 1

		while arg_21_1["status_add" .. var_21_8] do
			local var_21_9 = arg_21_1["status_add" .. var_21_8]
			local var_21_10 = arg_21_1["status_target" .. var_21_8]
			local var_21_11 = arg_21_1["status_targetcount" .. var_21_8]
			local var_21_12 = arg_21_1["status_prob" .. var_21_8]
			local var_21_13 = {
				offset_left = arg_21_1["status_area_offset_left" .. var_21_8],
				offset_right = arg_21_1["status_area_offset_right" .. var_21_8]
			}
			local var_21_14 = arg_21_1.status_union_prob ~= nil
			local var_21_16 = {
				exetype = arg_21_1.exe_type,
				triggertbl = (arg_21_1["status_judge_type" .. var_21_8] or nil) and trigger_manager.decode_judge_conditions(arg_21_1["status_judge_type" .. var_21_8], arg_21_1["status_judge_target" .. var_21_8], arg_21_1["status_judge_param" .. var_21_8]),
				prob = var_21_12,
				insider_cd = var_21_6,
				add_type = var_21_7,
				execonfig = {
					target = var_21_10,
					area = var_21_13,
					count = var_21_11
				},
				ishorcrux = arg_21_4,
				isunionprob = var_21_14
			}

			if arg_21_1["ishalo" .. var_21_8] then
				local var_21_17

				if arg_21_1["halo_judge_type" .. var_21_8] then
					var_21_17 = trigger_manager.decode_judge_conditions(arg_21_1["halo_judge_type" .. var_21_8], arg_21_1["halo_judge_target" .. var_21_8], arg_21_1["halo_judge_param" .. var_21_8])
				end

				local var_21_18 = {}

				var_21_18.target = arg_21_1["halo_target" .. var_21_8] or var_21_10

				local var_21_19 = {}

				var_21_19.offset_left = arg_21_1["halo_area_offset_left" .. var_21_8] or var_21_13.offset_left
				var_21_19.offset_right = arg_21_1["halo_area_offset_right" .. var_21_8] or var_21_13.offset_right
				var_21_18.area = var_21_19
				var_21_18.influence = arg_21_1["halo_influence" .. var_21_8] or 0
				var_21_18.public_cd = arg_21_1["halo_cd" .. var_21_8]

				FightManager.registerHalo(arg_21_2 .. "@" .. var_21_9, var_21_9, self.ref.character.index, var_21_17, var_21_16, var_21_18)
			else
				self:registerStatus(var_21_9, arg_21_2, arg_21_3, var_21_16)
			end

			var_21_8 = var_21_8 + 1
		end
	end
end

function var_0_0:unregisterStatusList(arg_22_1, arg_22_2, arg_22_3)
	if not arg_22_1.exe_type then
		return
	end

	local var_22_0 = 1

	while arg_22_1["status_add" .. var_22_0] do
		if arg_22_1["ishalo" .. var_22_0] then
			FightManager.unregisterHalo(arg_22_2 .. "@" .. arg_22_1["status_add" .. var_22_0], arg_22_3)
		else
			self:unregisterStatus(arg_22_1["status_add" .. var_22_0], arg_22_2, arg_22_3)
		end

		var_22_0 = var_22_0 + 1
	end
end

function var_0_0:registerPassiveskill(arg_23_1)
	local var_23_0 = skill_data[arg_23_1]

	assert(skill_data[arg_23_1] ~= nil, "passive skill " .. arg_23_1 .. " is nil")
	self:registerStatusList(var_23_0, "passive_" .. arg_23_1, self.ref.character.index)
end

function var_0_0:unregisterPassiveskill(arg_24_1)
	local var_24_0 = skill_data[arg_24_1]

	assert(skill_data[arg_24_1] ~= nil, "passive skill " .. arg_24_1 .. " is nil")
	self:unregisterStatusList(var_24_0, "passive_" .. arg_24_1, self.ref.character.index)
end

function var_0_0:registerAssist(arg_25_1)
	local var_25_0 = skill_data[arg_25_1]

	assert(skill_data[arg_25_1] ~= nil, "assist skill " .. arg_25_1 .. " is nil")
	self:registerStatusList(var_25_0, "assist_" .. arg_25_1, self.ref.character.index)
end

function var_0_0:unregisterAssist(arg_26_1)
	local var_26_0 = skill_data[arg_26_1]

	assert(skill_data[arg_26_1] ~= nil, "assist skill " .. arg_26_1 .. " is nil")
	self:unregisterStatusList(var_26_0, "assist_" .. arg_26_1, self.ref.character.index)
end

function var_0_0:registerAssistMain(arg_27_1)
	self:registerStatusList(skill_data[arg_27_1], "assist_" .. arg_27_1, self.ref.character.index, arg_27_1)
end

function var_0_0:unregisterAssistMain(arg_28_1)
	self:unregisterStatusList(skill_data[arg_28_1], "assist_" .. arg_28_1, self.ref.character.index)
end

function var_0_0:registerComponentEffect(arg_29_1)
	local var_29_0 = skill_data[arg_29_1]

	assert(skill_data[arg_29_1] ~= nil, "component skill " .. arg_29_1 .. " is nil")
	self:registerStatusList(var_29_0, "component_" .. arg_29_1, self.ref.character.index)
end

function var_0_0:unregisterComponentEffect(arg_30_1)
	local var_30_0 = skill_data[arg_30_1]

	assert(skill_data[arg_30_1] ~= nil, "component skill " .. arg_30_1 .. " is nil")
	self:unregisterStatusList(var_30_0, "component_" .. arg_30_1, self.ref.character.index)
end

function var_0_0:registerReinforceComponentEffect(arg_31_1)
	local var_31_0 = skill_data[arg_31_1]

	assert(skill_data[arg_31_1] ~= nil, "component skill " .. arg_31_1 .. " is nil")
	self:registerStatusList(var_31_0, "component_" .. arg_31_1, self.ref.character.index)
end

function var_0_0:unregisterReinforceComponentEffect(arg_32_1)
	local var_32_0 = skill_data[arg_32_1]

	assert(skill_data[arg_32_1] ~= nil, "component skill " .. arg_32_1 .. " is nil")
	self:unregisterStatusList(var_32_0, "component_" .. arg_32_1, self.ref.character.index)
end

function var_0_0:registerBuff(arg_33_1, arg_33_2)
	local var_33_0 = buff_data[arg_33_1]

	assert(buff_data[arg_33_1] ~= nil, "buff " .. arg_33_1 .. " is nil")
	self:registerStatusList(var_33_0, "buff_" .. arg_33_1, arg_33_2)
end

function var_0_0:unregisterBuff(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = buff_data[arg_34_1]

	assert(buff_data[arg_34_1] ~= nil, "buff " .. arg_34_1 .. " is nil")

	arg_34_2 = arg_34_2 or 1

	for iter_34_0 = 1, arg_34_2 do
		self:unregisterStatusList(var_34_0, "buff_" .. arg_34_1, arg_34_3)
	end
end

function var_0_0:registerBattleFieldStatus(arg_35_1)
	local var_35_0 = skill_data[arg_35_1]

	assert(skill_data[arg_35_1] ~= nil, "battle field skill " .. arg_35_1 .. " is nil")
	self:registerStatusList(var_35_0, "battlefield_" .. arg_35_1, self.ref.character.index)
end

function var_0_0:unregisterBattleFieldStatus(arg_36_1)
	self:unregisterStatusList(skill_data[arg_36_1], "battlefield_" .. arg_36_1, self.ref.character.index)
end

local var_0_6 = {
	onHurt = true,
	onBeForced = true,
	onMechanicalHurt = true,
	onHitted = true,
	onDyingNoImmortal = true,
	onEnergyHurt = true,
	onDefence2 = true,
	onDodge = true,
	onDying = true,
	onBeCritied = true,
	onDefence = true,
	onBeStriked = true
}

function var_0_0.isDefenceCondition(arg_37_0, arg_37_1)
	return var_0_6[arg_37_1] ~= nil
end

local var_0_7 = {
	onDying = true,
	onHalo = true,
	onDyingNoImmortal = true,
	onHeal = true,
	onDied = true,
	onTimer = true
}

function var_0_0.isIndependentCondition(arg_38_0, arg_38_1)
	return var_0_7[arg_38_1] ~= nil
end

function var_0_0:triggerStatus(arg_39_1, arg_39_2, arg_39_3)
	if not self.pool._conditions[arg_39_1] then
		return
	end

	if (not arg_39_2 or not arg_39_2._instance) and not self:isIndependentCondition(arg_39_1) then
		return
	end

	local var_39_0
	local var_39_1

	if self:isDefenceCondition(arg_39_1) then
		var_39_1 = self.ref.character
		var_39_0 = arg_39_2
	else
		var_39_1 = arg_39_2
		var_39_0 = self.ref.character
	end

	local var_39_2 = {}

	for iter_39_0, iter_39_1 in pairs(self.pool._statusunionprob) do
		var_39_2[iter_39_0] = iter_39_1 >= math.random()
	end

	local var_39_3 = {}

	for iter_39_2, iter_39_3 in pairs(self.pool._conditions[arg_39_1]) do
		table.insert(var_39_3, iter_39_2)
	end

	for iter_39_4, iter_39_5 in ipairs(var_39_3) do
		local var_39_4 = self.pool._fightstatuslist[iter_39_5]

		if self.pool._fightstatuslist[iter_39_5] and var_39_4:checkTriggerCondition(var_39_0, var_39_1, var_39_2) then
			var_39_4:trigger((arg_39_2 or nil) and (arg_39_2.index or nil), arg_39_3)
		end
	end
end

function var_0_0:influence_attr_chain(arg_40_1, arg_40_2)
	if not self.pool._basicattr[arg_40_1] then
		return
	end

	arg_40_2 = arg_40_2 or {}

	for iter_40_0, iter_40_1 in pairs(self.pool._basicattr[arg_40_1]) do
		if not arg_40_2[iter_40_0] then
			arg_40_2[iter_40_0] = true

			self.pool._fightstatuslist[iter_40_0]:refresh(arg_40_1, arg_40_2)
		end
	end
end

function var_0_0:refresh_statusaddition(arg_41_1)
	for iter_41_0, iter_41_1 in pairs(self.pool._fightstatuslist) do
		if iter_41_1._id == arg_41_1 then
			iter_41_1:refresh()
		end
	end
end

function var_0_0:refresh_statustypeaddition(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(self.pool._fightstatuslist) do
		if iter_42_1._statustype == arg_42_1 then
			iter_42_1:refresh()
		end
	end
end

function var_0_0:updateStatusPool(arg_43_1)
	for iter_43_0, iter_43_1 in pairs(self.pool._fightstatuslist) do
		iter_43_1:update(arg_43_1)
	end

	for iter_43_2, iter_43_3 in pairs(self.pool._buffs.buff) do
		iter_43_3:update(arg_43_1)
	end

	for iter_43_4, iter_43_5 in pairs(self.pool._buffs.debuff) do
		iter_43_5:update(arg_43_1)
	end
end

function var_0_0:updateStatusPoolOnAttack()
	for iter_44_0, iter_44_1 in pairs(self.pool._fightstatuslist) do
		iter_44_1:updateOnAttack()
	end

	for iter_44_2, iter_44_3 in pairs(self.pool._buffs.buff) do
		iter_44_3:updateOnAttack()
	end

	for iter_44_4, iter_44_5 in pairs(self.pool._buffs.debuff) do
		iter_44_5:updateOnAttack()
	end
end

function var_0_0:updateTriggerCD(arg_45_1)
	for iter_45_0, iter_45_1 in pairs(self.pool._fightstatuslist) do
		iter_45_1:updateTriggerCD(arg_45_1)
	end
end

function var_0_0:clearTriggerCD()
	for iter_46_0, iter_46_1 in pairs(self.pool._fightstatuslist) do
		iter_46_1:clearTriggerCD()
	end
end

function var_0_0:registerStatusTriggerProbAdd(arg_47_1, arg_47_2)
	self.pool._statusprobaddition[arg_47_1] = (self.pool._statusprobaddition[arg_47_1] or 0) + arg_47_2
end

function var_0_0:unregisterStatusTriggerProbAdd(arg_48_1, arg_48_2)
	if not self.pool._statusprobaddition[arg_48_1] then
		return
	end

	self.pool._statusprobaddition[arg_48_1] = self.pool._statusprobaddition[arg_48_1] - arg_48_2
end

function var_0_0:getTriggerProbAddition(arg_49_1)
	local var_49_0, var_49_1 = arg_49_1:match("([^_]+)_(%d+)")

	return self.pool._statusprobaddition[var_49_0 .. "_" .. var_49_1] or 0
end

function var_0_0:registerStatusTriggerCDAdd(arg_50_1, arg_50_2)
	self.pool._statuscdaddition[arg_50_1] = (self.pool._statuscdaddition[arg_50_1] or 0) + arg_50_2
end

function var_0_0:unregisterStatusTriggerCDAdd(arg_51_1, arg_51_2)
	if not self.pool._statuscdaddition[arg_51_1] then
		return
	end

	self.pool._statuscdaddition[arg_51_1] = self.pool._statuscdaddition[arg_51_1] - arg_51_2

	if self.pool._statuscdaddition[arg_51_1] <= 0 then
		self.pool._statuscdaddition[arg_51_1] = nil
	end
end

function var_0_0:getTriggerCDAddition(arg_52_1)
	local var_52_0, var_52_1 = arg_52_1:match("([^_]+)_(%d+)")

	return self.pool._statuscdaddition[var_52_0 .. "_" .. var_52_1] or 0
end

function var_0_0:registerStatusValueAdd(arg_53_1, arg_53_2)
	self.pool._statusvalueaddition[1][arg_53_1] = (self.pool._statusvalueaddition[1][arg_53_1] or 0) + arg_53_2

	self:refresh_statusaddition(arg_53_1)
end

function var_0_0:unregisterStatusValueAdd(arg_54_1, arg_54_2)
	if not self.pool._statusvalueaddition[1][arg_54_1] then
		return
	end

	self.pool._statusvalueaddition[1][arg_54_1] = self.pool._statusvalueaddition[1][arg_54_1] - arg_54_2

	self:refresh_statusaddition(arg_54_1)
end

function var_0_0:registerStatusExertValueAdd(arg_55_1, arg_55_2)
	self.pool._statusvalueaddition[2][arg_55_1] = (self.pool._statusvalueaddition[2][arg_55_1] or 0) + arg_55_2
end

function var_0_0:unregisterStatusExertValueAdd(arg_56_1, arg_56_2)
	if not self.pool._statusvalueaddition[2][arg_56_1] then
		return
	end

	self.pool._statusvalueaddition[2][arg_56_1] = self.pool._statusvalueaddition[2][arg_56_1] - arg_56_2
end

function var_0_0:registerStatusValueAddRandom(arg_57_1, arg_57_2, arg_57_3)
	self.pool._statusvaluerandomaddition[1][arg_57_1] = self.pool._statusvaluerandomaddition[1][arg_57_1] or {
		prob = 0,
		value = arg_57_2
	}
	self.pool._statusvaluerandomaddition[1][arg_57_1].prob = self.pool._statusvaluerandomaddition[1][arg_57_1].prob + arg_57_3
end

function var_0_0:unregisterStatusValueAddRandom(arg_58_1, arg_58_2, arg_58_3)
	if not self.pool._statusvaluerandomaddition[1][arg_58_1] then
		return
	end

	self.pool._statusvaluerandomaddition[1][arg_58_1].prob = self.pool._statusvaluerandomaddition[1][arg_58_1].prob - arg_58_3

	if self.pool._statusvaluerandomaddition[1][arg_58_1].prob <= 0 then
		self.pool._statusvaluerandomaddition[1][arg_58_1] = nil
	end
end

function var_0_0:registerStatusValueExertAddRandom(arg_59_1, arg_59_2, arg_59_3)
	self.pool._statusvaluerandomaddition[2][arg_59_1] = self.pool._statusvaluerandomaddition[2][arg_59_1] or {
		prob = 0,
		value = arg_59_2
	}
	self.pool._statusvaluerandomaddition[2][arg_59_1].prob = self.pool._statusvaluerandomaddition[2][arg_59_1].prob + arg_59_3
end

function var_0_0:unregisterStatusValueExertAddRandom(arg_60_1, arg_60_2, arg_60_3)
	if not self.pool._statusvaluerandomaddition[2][arg_60_1] then
		return
	end

	self.pool._statusvaluerandomaddition[2][arg_60_1].prob = self.pool._statusvaluerandomaddition[2][arg_60_1].prob - arg_60_3

	if self.pool._statusvaluerandomaddition[2][arg_60_1].prob <= 0 then
		self.pool._statusvaluerandomaddition[2][arg_60_1] = nil
	end
end

function var_0_0:registerStatusTypeValueAdd(arg_61_1, arg_61_2)
	self.pool._statustypevalueaddition[1][arg_61_1] = (self.pool._statustypevalueaddition[1][arg_61_1] or 0) + arg_61_2

	self:refresh_statustypeaddition(arg_61_1)
end

function var_0_0:unregisterStatusTypeValueAdd(arg_62_1, arg_62_2)
	if not self.pool._statustypevalueaddition[1][arg_62_1] then
		return
	end

	self.pool._statustypevalueaddition[1][arg_62_1] = self.pool._statustypevalueaddition[1][arg_62_1] - arg_62_2

	self:refresh_statustypeaddition(arg_62_1)
end

function var_0_0:registerStatusTypeExertValueAdd(arg_63_1, arg_63_2)
	self.pool._statustypevalueaddition[2][arg_63_1] = (self.pool._statustypevalueaddition[2][arg_63_1] or 0) + arg_63_2
end

function var_0_0:unregisterStatusTypeExertValueAdd(arg_64_1, arg_64_2)
	if not self.pool._statustypevalueaddition[2][arg_64_1] then
		return
	end

	self.pool._statustypevalueaddition[2][arg_64_1] = self.pool._statustypevalueaddition[2][arg_64_1] - arg_64_2
end

function var_0_0:registerStatusTypeValueAddRandom(arg_65_1, arg_65_2, arg_65_3)
	self.pool._statustypevaluerandomaddition[1][arg_65_1] = self.pool._statustypevaluerandomaddition[1][arg_65_1] or {
		prob = 0,
		value = arg_65_2
	}
	self.pool._statustypevaluerandomaddition[1][arg_65_1].prob = self.pool._statustypevaluerandomaddition[1][arg_65_1].prob + arg_65_3
end

function var_0_0:unregisterStatusTypeValueAddRandom(arg_66_1, arg_66_2, arg_66_3)
	if not self.pool._statustypevaluerandomaddition[1][arg_66_1] then
		return
	end

	self.pool._statustypevaluerandomaddition[1][arg_66_1].prob = self.pool._statustypevaluerandomaddition[1][arg_66_1].prob - arg_66_3

	if self.pool._statustypevaluerandomaddition[1][arg_66_1].prob <= 0 then
		self.pool._statustypevaluerandomaddition[1][arg_66_1] = nil
	end
end

function var_0_0:registerStatusTypeExertValueAddRandom(arg_67_1, arg_67_2, arg_67_3)
	self.pool._statustypevaluerandomaddition[2][arg_67_1] = self.pool._statustypevaluerandomaddition[2][arg_67_1] or {
		prob = 0,
		value = arg_67_2
	}
	self.pool._statustypevaluerandomaddition[2][arg_67_1].prob = self.pool._statustypevaluerandomaddition[2][arg_67_1].prob + arg_67_3
end

function var_0_0:unregisterStatusTypeExertValueAddRandom(arg_68_1, arg_68_2, arg_68_3)
	if not self.pool._statustypevaluerandomaddition[2][arg_68_1] then
		return
	end

	self.pool._statustypevaluerandomaddition[2][arg_68_1].prob = self.pool._statustypevaluerandomaddition[2][arg_68_1].prob - arg_68_3

	if self.pool._statustypevaluerandomaddition[2][arg_68_1].prob <= 0 then
		self.pool._statustypevaluerandomaddition[2][arg_68_1] = nil
	end
end

function var_0_0:getStatusTriggerValueAdd(arg_69_1)
	local var_69_1 = 0 + (self.pool._statusvalueaddition[1][arg_69_1] or 0) + (self.pool._statustypevalueaddition[1][status_data[arg_69_1].status_type] or 0)

	if self.pool._statusvaluerandomaddition[1][arg_69_1] and math.random() < self.pool._statusvaluerandomaddition[1][arg_69_1].prob then
		var_69_1 = var_69_1 + self.pool._statusvaluerandomaddition[1][arg_69_1].value
	end

	if self.pool._statustypevaluerandomaddition[1][status_data[arg_69_1].status_type] and math.random() < self.pool._statustypevaluerandomaddition[1][status_data[arg_69_1].status_type].prob then
		var_69_1 = var_69_1 + self.pool._statustypevaluerandomaddition[1][status_data[arg_69_1].status_type].value
	end

	return var_69_1
end

function var_0_0:getStatusExertTriggerValueAdd(arg_70_1)
	local var_70_1 = 0 + (self.pool._statusvalueaddition[2][arg_70_1] or 0) + (self.pool._statustypevalueaddition[2][status_data[arg_70_1].status_type] or 0)

	if self.pool._statusvaluerandomaddition[2][arg_70_1] and math.random() < self.pool._statusvaluerandomaddition[2][arg_70_1].prob then
		var_70_1 = var_70_1 + self.pool._statusvaluerandomaddition[2][arg_70_1].value
	end

	if self.pool._statustypevaluerandomaddition[2][status_data[arg_70_1].status_type] and math.random() < self.pool._statustypevaluerandomaddition[2][status_data[arg_70_1].status_type].prob then
		var_70_1 = var_70_1 + self.pool._statustypevaluerandomaddition[2][status_data[arg_70_1].status_type].value
	end

	return var_70_1
end

function var_0_0:getStatusRegisterValueAdd(arg_71_1)
	return 0 + (self.pool._statusvalueaddition[1][arg_71_1] or 0) + (self.pool._statustypevalueaddition[1][status_data[arg_71_1].status_type] or 0)
end

function var_0_0:getStatusExertRegisterValueAdd(arg_72_1)
	return 0 + (self.pool._statusvalueaddition[2][arg_72_1] or 0) + (self.pool._statustypevalueaddition[2][status_data[arg_72_1].status_type] or 0)
end

function var_0_0:removeShieldByID(arg_73_1)
	local var_73_0 = arg_73_1:match("buff_(%d+)")

	if var_73_0 then
		self:removeBuff(tonumber(var_73_0))
	else
		self:unregisterStatus(arg_73_1)
	end
end

function var_0_0:getAllBuffs(arg_74_1)
	if arg_74_1 == 0 then
		return self.pool._buffs.debuff
	elseif arg_74_1 == 1 then
		return self.pool._buffs.buff
	else
		local var_74_0 = {}

		for iter_74_0, iter_74_1 in pairs(self.pool._buffindex.buff) do
			table.insert(var_74_0, self.pool._buffs.buff[iter_74_1])
		end

		for iter_74_2, iter_74_3 in pairs(self.pool._buffindex.debuff) do
			table.insert(var_74_0, self.pool._buffs.debuff[iter_74_3])
		end

		return var_74_0
	end
end

function var_0_0:addBuff(arg_75_1, arg_75_2, arg_75_3, arg_75_4, arg_75_5, arg_75_6)
	local var_75_0 = buff_data[arg_75_1]

	assert(buff_data[arg_75_1], "buff " .. arg_75_1 .. " is nil")

	arg_75_6 = arg_75_6 or 1

	if var_75_0.buff_or_debuff == 0 and self.pool._status.forceimmune then
		return
	end

	if var_75_0.buff_or_debuff == 0 and var_75_0.cleanable >= 1 then
		if self.pool._status.bkb then
			return
		end

		if self:isImmuneDebuffByID(arg_75_1) then
			return
		end

		if self:isImmuneDebuff(self:getBuffStatusType(arg_75_1)) then
			return
		end

		if self:isImmuneDebuffByAllStatus(arg_75_1) then
			return
		end
	end

	local var_75_1

	if var_75_0.buff_or_debuff == 0 then
		var_75_1 = self.pool._buffs.debuff or self.pool._buffs.buff

		local var_75_2

		if var_75_0.buff_or_debuff == 0 then
			var_75_2 = self.pool._buffindex.debuff or self.pool._buffindex.buff

			if var_75_1[arg_75_1] then
				var_75_1[arg_75_1]:pushBuff(arg_75_6, arg_75_2, arg_75_3, arg_75_4, arg_75_5)

				goto label_75_0
			end
		end
	end

	var_75_1[arg_75_1] = FightBuff:create(arg_75_1, self.ref.character, arg_75_6, arg_75_2, arg_75_3, arg_75_4, arg_75_5)

	table.insert(var_75_2, arg_75_1)

	::label_75_0::
end

function var_0_0:removeBuff(arg_76_1)
	if buff_data[arg_76_1].buff_or_debuff == 0 then
		local var_76_0 = self.pool._buffs.debuff or self.pool._buffs.buff

		if buff_data[arg_76_1].buff_or_debuff == 0 then
			if var_76_0[arg_76_1] then
				var_76_0[arg_76_1]:removeAllBuff()

				var_76_0[arg_76_1] = nil

				self:removeFromBuffIndex(self.pool._buffindex.debuff or self.pool._buffindex.buff, arg_76_1)
			end
		end
	end
end

function var_0_0.removeFromBuffIndex(arg_77_0, arg_77_1, arg_77_2)
	for iter_77_0, iter_77_1 in ipairs(arg_77_1) do
		if iter_77_1 == arg_77_2 then
			table.remove(arg_77_1, iter_77_0)

			break
		end
	end
end

function var_0_0:removeBuffByCount(arg_78_1, arg_78_2)
	if not arg_78_2 then
		self:removeBuff(arg_78_1)

		return
	end

	if buff_data[arg_78_1].buff_or_debuff == 0 then
		local var_78_0 = self.pool._buffs.debuff or self.pool._buffs.buff

		if buff_data[arg_78_1].buff_or_debuff == 0 then
			local var_78_1 = self.pool._buffindex.debuff or self.pool._buffindex.buff

			if not var_78_0[arg_78_1] then
				return
			end

			if var_78_0[arg_78_1]:removeBuffByCount(arg_78_2) then
				var_78_0[arg_78_1]:removeAllBuff()

				var_78_0[arg_78_1] = nil

				self:removeFromBuffIndex(var_78_1, arg_78_1)
			end
		end
	end
end

function var_0_0:getBuffCount(arg_79_1)
	if buff_data[arg_79_1].buff_or_debuff == 0 then
		local var_79_0 = self.pool._buffs.debuff or self.pool._buffs.buff

		if var_79_0[arg_79_1] then
			do return var_79_0[arg_79_1]:getBuffCount() end

			goto label_79_0
		end
	end

	do return 0 end

	::label_79_0::
end

function var_0_0.getBuffStatusType(arg_80_0, arg_80_1)
	return status_data[buff_data[arg_80_1].status_add1].status_type
end

function var_0_0.getBuffStatusTypes(arg_81_0, arg_81_1)
	local var_81_0 = {}

	while buff_data[arg_81_1]["status_add" .. 1] do
		table.insert(var_81_0, status_data[buff_data[arg_81_1]["status_add" .. 1]].status_type)
	end

	return var_81_0
end

function var_0_0:getBuffStackAdd(arg_82_1)
	if not self.pool._buffstackadd[1][arg_82_1] then
		return 0
	end

	return self.pool._buffstackadd[1][arg_82_1]
end

function var_0_0:registerBuffStackAdd(arg_83_1, arg_83_2)
	self.pool._buffstackadd[1][arg_83_1] = (self.pool._buffstackadd[1][arg_83_1] or 0) + arg_83_2
end

function var_0_0:unregisterBuffStackAdd(arg_84_1, arg_84_2)
	self.pool._buffstackadd[1][arg_84_1] = (self.pool._buffstackadd[1][arg_84_1] or 0) - arg_84_2
end

function var_0_0:getExertBuffStackAdd(arg_85_1)
	if not self.pool._buffstackadd[2][arg_85_1] then
		return 0
	end

	return self.pool._buffstackadd[2][arg_85_1]
end

function var_0_0:registerExertBuffStackAdd(arg_86_1, arg_86_2)
	self.pool._buffstackadd[2][arg_86_1] = (self.pool._buffstackadd[2][arg_86_1] or 0) + arg_86_2
end

function var_0_0:unregisterExertBuffStackAdd(arg_87_1, arg_87_2)
	self.pool._buffstackadd[2][arg_87_1] = (self.pool._buffstackadd[2][arg_87_1] or 0) - arg_87_2
end

function var_0_0:getBuffTimeAdd(arg_88_1)
	if not self.pool._bufftimeadd[1][arg_88_1] then
		return 0
	end

	return self.pool._bufftimeadd[1][arg_88_1]
end

function var_0_0:registerBuffTimeAdd(arg_89_1, arg_89_2)
	self.pool._bufftimeadd[1][arg_89_1] = (self.pool._bufftimeadd[1][arg_89_1] or 0) + arg_89_2
end

function var_0_0:unregisterBuffTimeAdd(arg_90_1, arg_90_2)
	self.pool._bufftimeadd[1][arg_90_1] = (self.pool._bufftimeadd[1][arg_90_1] or 0) - arg_90_2
end

function var_0_0:getExertBuffTimeAdd(arg_91_1)
	if not self.pool._bufftimeadd[2][arg_91_1] then
		return 0
	end

	return self.pool._bufftimeadd[2][arg_91_1]
end

function var_0_0:registerExertBuffTimeAdd(arg_92_1, arg_92_2)
	self.pool._bufftimeadd[2][arg_92_1] = (self.pool._bufftimeadd[2][arg_92_1] or 0) + arg_92_2
end

function var_0_0:unregisterExertBuffTimeAdd(arg_93_1, arg_93_2)
	self.pool._bufftimeadd[2][arg_93_1] = (self.pool._bufftimeadd[2][arg_93_1] or 0) - arg_93_2
end

function var_0_0:getBuffTimeFac(arg_94_1)
	if arg_94_1 == 1 then
		return self.pool._allbufftimefac[1].buff
	else
		return self.pool._allbufftimefac[1].debuff
	end
end

function var_0_0:registerAllBuffTimeChange(arg_95_1, arg_95_2)
	if arg_95_1 == 1 then
		self.pool._allbufftimefac[1].buff = self.pool._allbufftimefac[1].buff + arg_95_2
	elseif arg_95_1 == 0 then
		self.pool._allbufftimefac[1].debuff = self.pool._allbufftimefac[1].debuff + arg_95_2
	else
		self.pool._allbufftimefac[1].buff = self.pool._allbufftimefac[1].buff + arg_95_2
		self.pool._allbufftimefac[1].debuff = self.pool._allbufftimefac[1].debuff + arg_95_2
	end
end

function var_0_0:unregisterAllBuffTimeChange(arg_96_1, arg_96_2)
	if arg_96_1 == 1 then
		self.pool._allbufftimefac[1].buff = self.pool._allbufftimefac[1].buff - arg_96_2
	elseif arg_96_1 == 0 then
		self.pool._allbufftimefac[1].debuff = self.pool._allbufftimefac[1].debuff - arg_96_2
	else
		self.pool._allbufftimefac[1].buff = self.pool._allbufftimefac[1].buff - arg_96_2
		self.pool._allbufftimefac[1].debuff = self.pool._allbufftimefac[1].debuff - arg_96_2
	end
end

function var_0_0:getExertBuffTimeFac(arg_97_1)
	if arg_97_1 == 1 then
		return self.pool._allbufftimefac[2].buff
	else
		return self.pool._allbufftimefac[2].debuff
	end
end

function var_0_0:registerAllExertBuffTimeChange(arg_98_1, arg_98_2)
	if arg_98_1 == 1 then
		self.pool._allbufftimefac[2].buff = self.pool._allbufftimefac[2].buff + arg_98_2
	elseif arg_98_1 == 0 then
		self.pool._allbufftimefac[2].debuff = self.pool._allbufftimefac[2].debuff + arg_98_2
	else
		self.pool._allbufftimefac[2].buff = self.pool._allbufftimefac[2].buff + arg_98_2
		self.pool._allbufftimefac[2].debuff = self.pool._allbufftimefac[2].debuff + arg_98_2
	end
end

function var_0_0:unregisterAllExertBuffTimeChange(arg_99_1, arg_99_2)
	if arg_99_1 == 1 then
		self.pool._allbufftimefac[2].buff = self.pool._allbufftimefac[2].buff - arg_99_2
	elseif arg_99_1 == 0 then
		self.pool._allbufftimefac[2].debuff = self.pool._allbufftimefac[2].debuff - arg_99_2
	else
		self.pool._allbufftimefac[2].buff = self.pool._allbufftimefac[2].buff - arg_99_2
		self.pool._allbufftimefac[2].debuff = self.pool._allbufftimefac[2].debuff - arg_99_2
	end
end

function var_0_0:cleanBuff(arg_100_1, arg_100_2)
	arg_100_1 = arg_100_1 or 1
	arg_100_2 = arg_100_2 or #self.pool._buffindex.buff

	local var_100_0 = self.pool._buffindex.buff

	while var_100_0[#self.pool._buffindex.buff] do
		if buff_data[var_100_0[#self.pool._buffindex.buff]] and arg_100_1 <= buff_data[var_100_0[#self.pool._buffindex.buff]].cleanable then
			if self.pool._buffs.buff[var_100_0[#self.pool._buffindex.buff]] then
				self.pool._buffs.buff[var_100_0[#self.pool._buffindex.buff]]:removeAllBuff()

				self.pool._buffs.buff[var_100_0[#self.pool._buffindex.buff]] = nil
			end

			table.remove(var_100_0, #self.pool._buffindex.buff)

			arg_100_2 = arg_100_2 - 1

			if arg_100_2 <= 0 then
				break
			end
		end
	end
end

function var_0_0:cleanDebuff(arg_101_1, arg_101_2)
	arg_101_1 = arg_101_1 or 1
	arg_101_2 = arg_101_2 or #self.pool._buffindex.debuff

	local var_101_0 = self.pool._buffindex.debuff

	while var_101_0[#self.pool._buffindex.debuff] do
		if buff_data[var_101_0[#self.pool._buffindex.debuff]] and arg_101_1 <= buff_data[var_101_0[#self.pool._buffindex.debuff]].cleanable then
			if self.pool._buffs.debuff[var_101_0[#self.pool._buffindex.debuff]] then
				self.pool._buffs.debuff[var_101_0[#self.pool._buffindex.debuff]]:removeAllBuff()

				self.pool._buffs.debuff[var_101_0[#self.pool._buffindex.debuff]] = nil
			end

			table.remove(var_101_0, #self.pool._buffindex.debuff)

			arg_101_2 = arg_101_2 - 1

			if arg_101_2 <= 0 then
				break
			end
		end
	end
end

function var_0_0:cleanAllBuffs(arg_102_1)
	for iter_102_0, iter_102_1 in pairs(self.pool._buffs.buff) do
		iter_102_1:removeAllBuff(arg_102_1)

		self.pool._buffs.buff[iter_102_0] = nil
	end

	self.pool._buffs.buff = {}
	self.pool._buffindex.buff = {}

	for iter_102_2, iter_102_3 in pairs(self.pool._buffs.debuff) do
		iter_102_3:removeAllBuff(arg_102_1)

		self.pool._buffs.debuff[iter_102_2] = nil
	end

	self.pool._buffs.debuff = {}
	self.pool._buffindex.debuff = {}
end

function var_0_0:cleanBuffOnRevival()
	local var_103_0 = #self.pool._buffindex.buff

	while self.pool._buffindex.buff[var_103_0] do
		if not buff_data[self.pool._buffindex.buff[var_103_0]].keep_on_revival then
			if self.pool._buffs.buff[self.pool._buffindex.buff[var_103_0]] then
				self.pool._buffs.buff[self.pool._buffindex.buff[var_103_0]]:removeAllBuff()

				self.pool._buffs.buff[self.pool._buffindex.buff[var_103_0]] = nil
			end

			table.remove(self.pool._buffindex.buff, var_103_0)
		end

		var_103_0 = var_103_0 - 1
	end

	local var_103_1 = self.pool._buffindex.debuff
	local var_103_2 = #self.pool._buffindex.debuff

	while var_103_1[var_103_2] do
		if not buff_data[var_103_1[var_103_2]].keep_on_revival then
			if self.pool._buffs.debuff[var_103_1[var_103_2]] then
				self.pool._buffs.debuff[var_103_1[var_103_2]]:removeAllBuff()

				self.pool._buffs.debuff[var_103_1[var_103_2]] = nil
			end

			table.remove(var_103_1, var_103_2)
		end

		var_103_2 = var_103_2 - 1
	end
end

function var_0_0:updateBuffs(arg_104_1)
	for iter_104_0, iter_104_1 in pairs(self.pool._buffs.buff) do
		iter_104_1:update(arg_104_1)
	end

	for iter_104_2, iter_104_3 in pairs(self.pool._buffs.debuff) do
		iter_104_3:update(arg_104_1)
	end
end

local var_0_8 = {
	__index = var_0_0
}

function var_0_8.new(arg_105_0)
	local var_105_0 = {}

	setmetatable(var_105_0, var_0_8)
	var_105_0:init(arg_105_0)

	return var_105_0
end

return var_0_8
