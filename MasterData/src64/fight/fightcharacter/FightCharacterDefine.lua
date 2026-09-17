STANDARD_SCALE = 0.3
STANDARD_POSY = 160
ORIGIN_FIGHT_HEIGHT = 300
HPBAR_HEIGHT = 30
HITWORD_HEIGHT = 90
HPBAR_BOX_BG = "fight/UI_haemalStrandy_box.png"
HPBAR_BAR_PLAYER = "fight/UI_haemalStrandy.png"
HPBAR_BAR_ENEMY = "fight/UI_haemalStrandy2.png"
HPBAR_BAR_SUB = "fight/UI_haemalStrandy3.png"
BOSS_HPBAR_BOX_BG = "fight/life_bg1.png"
BOSS_HPBAR_FULL_BAR = "fight/life_bg2.png"
BOSS_HPBAR_FULL_BG = "fight/life_bg2a.png"
BOSS_HPBAR_HALF_BAR = "fight/life_bg3.png"
BOSS_HPBAR_HALF_BG = "fight/life_bg3a.png"
BOSS_HPBAR_QUARTER_BAR = "fight/life_bg4.png"
BOSS_HPBAR_QUARTER_BG = "fight/life_bg4a.png"
BOSS_HPBAR_SUB = "fight/life_bg5.png"
ATTR_BG = {
	wind = "public/part_bg/shuxing/feng.png",
	water = "public/part_bg/shuxing/shui.png",
	fire = "public/part_bg/shuxing/huo.png",
	light = "public/part_bg/shuxing/guang.png",
	dark = "public/part_bg/shuxing/an.png"
}
MAP_OFFSET_SIN = math.sin(75 * 3.1416926 / 180)
MAP_OFFSET_COS = math.cos(75 * 3.1416926 / 180)
MAP_POS = {
	[-100] = {
		p_z = 46,
		e_z = 45,
		_y = STANDARD_POSY - 70 * MAP_OFFSET_SIN,
		_offset = -70 * MAP_OFFSET_COS
	},
	[-80] = {
		p_z = 42,
		e_z = 41,
		_y = STANDARD_POSY - 80 * MAP_OFFSET_SIN,
		_offset = -80 * MAP_OFFSET_COS
	},
	[-60] = {
		p_z = 38,
		e_z = 37,
		_y = STANDARD_POSY - 60 * MAP_OFFSET_SIN,
		_offset = -60 * MAP_OFFSET_COS
	},
	[-50] = {
		p_z = 38,
		e_z = 37,
		_y = STANDARD_POSY - 50 * MAP_OFFSET_SIN,
		_offset = -50 * MAP_OFFSET_COS
	},
	[-40] = {
		p_z = 34,
		e_z = 33,
		_y = STANDARD_POSY - 40 * MAP_OFFSET_SIN,
		_offset = -40 * MAP_OFFSET_COS
	},
	[-30] = {
		p_z = 30,
		e_z = 29,
		_y = STANDARD_POSY - 30 * MAP_OFFSET_SIN,
		_offset = -30 * MAP_OFFSET_COS
	},
	[-20] = {
		p_z = 26,
		e_z = 25,
		_y = STANDARD_POSY - 20 * MAP_OFFSET_SIN,
		_offset = -20 * MAP_OFFSET_COS
	},
	[-10] = {
		p_z = 22,
		e_z = 21,
		_y = STANDARD_POSY - 10 * MAP_OFFSET_SIN,
		_offset = -10 * MAP_OFFSET_COS
	},
	[0] = {
		p_z = 18,
		e_z = 17,
		_offset = 0,
		_y = STANDARD_POSY
	},
	[10] = {
		p_z = 14,
		e_z = 13,
		_y = STANDARD_POSY + 10 * MAP_OFFSET_SIN,
		_offset = 10 * MAP_OFFSET_COS
	},
	[20] = {
		p_z = 14,
		e_z = 13,
		_y = STANDARD_POSY + 20 * MAP_OFFSET_SIN,
		_offset = 20 * MAP_OFFSET_COS
	},
	[30] = {
		p_z = 6,
		e_z = 5,
		_y = STANDARD_POSY + 30 * MAP_OFFSET_SIN,
		_offset = 30 * MAP_OFFSET_COS
	},
	[40] = {
		p_z = 10,
		e_z = 9,
		_y = STANDARD_POSY + 40 * MAP_OFFSET_SIN,
		_offset = 40 * MAP_OFFSET_COS
	},
	[50] = {
		p_z = 2,
		e_z = 1,
		_y = STANDARD_POSY + 50 * MAP_OFFSET_SIN,
		_offset = 50 * MAP_OFFSET_COS
	},
	[60] = {
		p_z = 6,
		e_z = 5,
		_y = STANDARD_POSY + 60 * MAP_OFFSET_SIN,
		_offset = 60 * MAP_OFFSET_COS
	},
	[80] = {
		p_z = 2,
		e_z = 1,
		_y = STANDARD_POSY + 80 * MAP_OFFSET_SIN,
		_offset = 80 * MAP_OFFSET_COS
	}
}
INIT_X, INIT_Y = 16, 16
SIZE_X, SIZE_Y = 28, 28
GAP = 4
MECHANICAL_DAMAGE = 1
ENERGY_DAMAGE = 2
HOLY_DAMAGE = 3
STATE_SEARCHING = 0
STATE_PREFIGHTING = 1
STATE_FIGHTING = 2
STATE_ENDFIGHT = 3
STATE_DIED = 4
STATE_WAITING = 5
STATE_FIGHTWIN = 6
STATE_REVIVAL = 7
STATUS_SEARCHING = STATE_SEARCHING
STATUS_PREFIGHTING = STATE_PREFIGHTING
STATUS_FIGHTING = STATE_FIGHTING
STATUS_ENDFIGHT = STATE_ENDFIGHT
STATUS_DIED = STATE_DIED
STATUS_WAITING = STATE_WAITING
STATUS_FIGHTWIN = STATE_FIGHTWIN
STATUS_REVIVAL = STATE_REVIVAL
STATUS_STR = {
	[STATUS_SEARCHING] = "searching",
	[STATUS_PREFIGHTING] = "prefighting",
	[STATUS_FIGHTING] = "fighting",
	[STATUS_ENDFIGHT] = "endfight",
	[STATUS_DIED] = "died",
	[STATUS_WAITING] = "waiting",
	[STATUS_FIGHTWIN] = "fightwin",
	[STATUS_REVIVAL] = "revival"
}
FIGHTSTATE_SEARCHING = 0
FIGHTSTATE_PREFIGHTING = 1
FIGHTSTATE_FIGHTING = 2
FIGHTSTATE_ENDFIGHT = 3
FIGHTSTATE_FAIL = 4
FIGHTSTATE_SUCCESS = 5
FIGHTSTATE_NEXT = 6
FIGHTSTATE_WAIT = 7
FIGHTSTATE_PASS_LEVEL = 8
FIGHTSTATE_REFRESH = 9
FIGHTSTATE_NEXT_CHAPTER = 10
FIGHTSTATUS_SEARCHING = FIGHTSTATE_SEARCHING
FIGHTSTATUS_PREFIGHTING = FIGHTSTATE_PREFIGHTING
FIGHTSTATUS_FIGHTING = FIGHTSTATE_FIGHTING
FIGHTSTATUS_ENDFIGHT = FIGHTSTATE_ENDFIGHT
FIGHTSTATUS_FAIL = FIGHTSTATE_FAIL
FIGHTSTATUS_SUCCESS = FIGHTSTATE_SUCCESS
FIGHTSTATUS_NEXT = FIGHTSTATE_NEXT
FIGHTSTATUS_WAIT = FIGHTSTATE_WAIT
FIGHTSTATUS_PASS_LEVEL = FIGHTSTATE_PASS_LEVEL
FIGHTSTATUS_REFRESH = FIGHTSTATE_REFRESH
FIGHTSTATUS_NEXT_CHAPTER = FIGHTSTATE_NEXT_CHAPTER
INIT_SEARCH_DISTANCE = 450
NORMAL_SEARCH_DISTANCE = 450
BOSS_SEARCH_DISTANCE = 450
BIGBOSS_SEARCH_DISTANCE = 450
ADVENTURE_SEARCH_DISTANCE = 450
EXPLORE_SEARCH_DISTANCE = 450
ARENA_SEARCH_DISTANCE = 450
EXPEDITION_SEARCH_DISTANCE = 450
BUFF_ADD_BY_PROB = 1
BUFF_ADD_BY_VALUE = 2
REGISTER_STATUS = 1
TRIGGER_STATUS = 2
ELEMENT_ADD_NUM = 0.5
OWNERSELF = 1
ALLTEAMMATE = 2
TEAMMATE_IN_AREA_OF_SELF = 3
TEAMMATE_IN_AREA_OF_TARGET = 4
TARGET = 5
ALLOPONENT = 6
OPONENT_IN_AREA_OF_SELF = 7
OPONENT_IN_AREA_OF_TARGET = 8
TEAMMATE_IN_AREA = 9
OPONENT_IN_AREA = 10
OPENENT_IN_AREA_OF_TARGET_WITHOUT_TARGET = 11
TEAMMATE_WITHOUT_SELF = 12
TEAMMATE_IN_AREA_WITHOUT_SELF = 13
OPONENT_NEAREST = 14
TEAMMATE_HPLOWEST = 15
OPONENT_HPPER_LOWEST = 16
TEAMMATE_HPPER_LOWEST = 17
OPONENT_HPLOWEST = 18
OPONENET_DAMAGELOWEST = 19
TEAMMATE_DAMAGEHIGHEST = 20
OPONENET_RANDOM_FROM_ALL = 21
TEAMMATE_RANDOM_FROM_ALL = 22
TEAMMATE_HPHIGHEST = 23
TEAMMATE_HPPER_HIGHEST = 24
OLDVERTIGO = 1
OLDEXTRA_ATTACK = 2
OLDEXTRA_DEFENCE = 3
OLDRECOVERY = 4
OLDHEMATOPHAGY = 5
OLDADD_BUFF = 6
OLDSTONE = 7
OLDCONFINE = 8
OLDSILENCE = 9
OLDADDICT = 10
OLDEXTRA_WEAK = 11
OLDEXTRA_HEAL = 12
OLDSHIELD = 13
OLDIMMORTAL = 14
OLDDEBUFF_IMMUNE = 15
OLDADD_STATUS = 16
OLDADD_STATUS_BUFF = 17
OLDEXTRA_INJURE = 18
OLDDOUBLE_ATTACK = 19
OLDHEAL_LIMIT = 20
OLDMAKE_ATTACK = 21
OLDATTACK_DEFENCE = 22
OLDCRI_PROB_CHANGE = 23
OLDDODGE_PROB_CHANGE = 24
OLDSTRIKE_PROB_CHANGE = 25
OLDCRI_DAMAGE_ADD = 26
OLDDODGE_DAMAGE_ADD = 27
OLDSTRIKE_DAMAGE_ADD = 28
OLDBLIND_PROB_CHANGE = 29
OLDDAMAGE_CHANGE = 31
OLDHP_CHANGE = 32
OLDDEFENCE_CHANGE = 33
OLDCRI_CHANGE = 34
OLDDODGE_CHANGE = 35
OLDSTRIKE_CHANGE = 36
OLDXP_CHANGE = 37
OLDATTACKSPEED_CHANGE = 38
OLDMOVINGSPEED_CHANGE = 39
OLDHEAL_RATE_CHANGE = 40
OLDCD_MINUS = 41
OLDEXTRA_ATTACK_CONST = 42
OLDEXTRA_DEFENCE_CONST = 43
OLDCLEAN_BUFF = 44
OLDCLEAN_DEBUFF = 45
OLDIMMORTAL_LIMIT = 46
OLDBKB = 47
OLDCHUNGE = 48
OLDFORCE_CHANGE = 49
OLDREFORCE_CHANGE = 50
OLDATTACKRANGE_CHANGE = 51
OLDIGNORE_DEFENCE = 52
OLDIGNORE_DODGE = 53
OLDCD_MINUS_CONST = 54
OLDCLEAN_SPECIFIC_BUFF = 55
OLDSTATUS_TRIGGER_PROB_ADD = 56
OLDSTATUS_VALUE_ADD = 57
OLDBUFF_TIME_ADD = 58
OLDBUFF_STACK_ADD = 59
OLDSTATUS_VALUE_ADD_RANDOM = 60
OLDHEAL_CONST_CHANGE = 61
OLDEXTRA_HEAL_CONST_CHANGE = 62
OLDMAKE_MECHANICAL_ATTACK = OLDMAKE_ATTACK
MAKE_ATTACK = 101
RECOVERY = 102
VERTIGO = 103
STONE = 104
CONFINE = 105
SILENCE = 106
ADDICT = 107
IMMORTAL = 108
IMMORTAL_LIMIT = 109
HEAL_LIMIT = 110
DOUBLE_ATTACK = 111
SHIELD = 112
DEBUFF_IMMUNE = 113
BKB = 114
CHUNGE = 115
CLEAN_BUFF = 116
CLEAN_DEBUFF = 117
CD_MINUS = 118
CD_MINUS_CONST = 119
ADD_BUFF = 120
ADD_STATUS = 121
ADD_STATUS_BUFF = 122
IGNORE_DEFENCE = 123
IGNORE_DODGE = 124
HEMATOPHAGY = 125
CLEAN_SPECIFIC_BUFF = 126
STATUS_TRIGGER_PROB_ADD = 127
STATUS_VALUE_ADD = 128
BUFF_TIME_ADD = 129
BUFF_STACK_ADD = 130
STATUS_VALUE_ADD_RANDOM = 131
STATUS_TYPE_VALUE_ADD = 132
STATUS_TYPE_VALUE_ADD_RANDOM = 133
MAKE_MECHANICAL_ATTACK = MAKE_ATTACK
MAKE_ENERGY_ATTACK = 134
MAKE_HOLY_ATTACK = 135
FEAR = 136
STRIKE_RATE_CHANGE = 137
CRI_RATE_CHANGE = 138
DEFENCE_RATE_CHANGE = IGNORE_DEFENCE
ALL_BUFF_TIME_CHANGE = 139
SWITCH_FLY_UNIT = 140
CHUNGE_LIMIT = 141
FROZEN = 142
RESET_SKILL_CD = 143
SUPER_IMMORTAL = 144
MAKE_ATTACK_WITH_CRI = 145
RAGE_FREE = 146
BLINK_BACK = 147
FORCE_IMMUNE = 148
GRAB = 149
TRANSFORM = 150
RAGE_LIMIT = 151
ADD_BUFF_RANDOM = 152
STEAL_ATTRIBUTE = 153
CONTRACT = 154
STATUS_TRIGGER_CD_ADD = 155
ADD_ATTR_WEAK = 156
REDUCE_ATTR_WEAK = 157
UN_SELECTABLE = 158
TRANSFER_DAMAGE = 159
FORCED_DISPLACEMENT = 160
MAX_TAKEN_DAMAGE = 161
IGNORE_MAX_DAMAGE = 162
EXTRA_ATTACK = 201
EXTRA_DEFENCE = 202
EXTRA_WEAK = 203
EXTRA_INJURE = 204
EXTRA_ATTACK_CONST = 205
EXTRA_DEFENCE_CONST = 206
ATTACK_DEFENCE_ADD = 207
ATTACK_DEFENCE_MINUS = 208
CRI_PROB_ADD = 209
CRI_PROB_MINUS = 210
DODGE_PROB_ADD = 211
DODGE_PROB_MINUS = 212
STRIKE_PROB_ADD = 213
STRIKE_PROB_MINUS = 214
CRI_DAMAGE_ADD = 215
CRI_DAMAGE_MINUS = 216
DODGE_DAMAGE_ADD = 217
DODGE_DAMAGE_MINUS = 218
STRIKE_DAMAGE_ADD = 219
STRIKE_DAMAGE_MINUS = 220
BLIND_PROB_ADD = 221
BLIND_PROB_MINUS = 222
DAMAGE_ADD = 223
DAMAGE_MINUS = 224
HP_ADD = 225
HP_MINUS = 226
DEFENCE_ADD = 227
DEFENCE_MINUS = 228
CRI_ADD = 229
CRI_MINUS = 230
DODGE_ADD = 231
DODGE_MINUS = 232
STRIKE_ADD = 233
STRIKE_MINUS = 234
XP_ADD = 235
XP_MINUS = 236
ATTACKSPEED_ADD = 237
ATTACKSPEED_MINUS = 238
MOVINGSPEED_ADD = 239
MOVINGSPEED_MINUS = 240
HEAL_RATE_ADD = 241
HEAL_RATE_MINUS = 242
FORCE_ADD = 243
FORCE_MINUS = 244
REFORCE_ADD = 245
REFORCE_MINUS = 246
ATTACKRANGE_ADD = 247
ATTACKRANGE_MINUS = 248
EXTRA_HEAL_ADD = 249
EXTRA_HEAL_MINUS = 250
EXTRA_HEAL_CONST_ADD = 251
EXTRA_HEAL_CONST_MINUS = 252
HEAL_CONST_ADD = 253
HEAL_CONST_MINUS = 254
EXTRA_MECHANICAL_ATTACK = 255
EXTRA_MECHANICAL_DEFENCE = 256
EXTRA_MECHANICAL_WEAK = 257
EXTRA_MECHANICAL_INJURE = 258
EXTRA_MECHANICAL_ATTACK_CONST = 259
EXTRA_MECHANICAL_DEFENCE_CONST = 260
EXTRA_ENERGY_ATTACK = 261
EXTRA_ENERGY_DEFENCE = 262
EXTRA_ENERGY_WEAK = 263
EXTRA_ENERGY_INJURE = 264
EXTRA_ENERGY_ATTACK_CONST = 265
EXTRA_ENERGY_DEFENCE_CONST = 266
ENERGYDEFENCE_ADD = 267
ENERGYDEFENCE_MINUS = 268
ENERGYDEFENCE_RATE_CHANGE = 269
REAL_DAMAGE_CHANGE = 270
REAL_HEAL_CHANGE = 271
EXTRA_ATTACK_RAGE_CHANGE = 272
EXTRA_ATTACK_RAGE_CHANGE_CONST = 273
GET_RAGE = 274
DEBUFF_IMMUNE_2 = 275
DEBUFF_IMMUNE_3 = 281
EXTRA_SKILL_RAGE_CHANGE = 276
EXTRA_SKILL_RAGE_CHANGE_CONST = 277
EXTRA_RECOVERY_RAGE_CHANGE = 278
EXTRA_RECOVERY_RAGE_CHANGE_CONST = 279
SKILL_CD_COUNT_CHANGE = 280
EXTRA_HEAL_EXTERN_ADD = 282
EXTRA_HEAL_EXTERN_MINUS = 283
PIERCE_CHANGE = 284
PIERCE_PERCENT_CHANGE = 285
ENERGY_PIERCE_CHANGE = 286
ENERGY_PIERCE_PERCENT_CHANGE = 287
MAX_CAUSE_DAMAGE = 288
IGNORE_MAX_CAUSE_DAMAGE = 289
MAX_CAUSE_DAMAGE_HOLY = 290
IGNORE_MAX_CAUSE_DAMAGE_HOLY = 291
MAX_CAUSE_DAMAGE_MECHANICAL = 292
IGNORE_MAX_CAUSE_DAMAGE_MECHANICAL = 293
MAX_CAUSE_DAMAGE_ENERGY = 294
IGNORE_MAX_CAUSE_DAMAGE_ENERGY = 295
ATTACKSPEED_LOCKED = 296
ATTACKSPEED_LOCKED_LIMIT = 297
MAX_ATTACKSPEED_LOCKED_LIMIT = 298
MIN_ATTACKSPEED_LOCKED_LIMIT = 299
INVALIDATE_SUPER_IMMORTAL = 300
MOCK_STATUS = 301
SUFFER_DAMAGE_CHANGE_MECHANICAL = 302
SUFFER_DAMAGE_CHANGE_ENERGY = 303
SUFFER_DAMAGE_CHANGE_HOLY = 304
DAMAGE_CHANGE_MECHANICAL = 305
DAMAGE_CHANGE_ENERGY = 306
DAMAGE_CHANGE_HOLY = 307

function compareByoperator(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0 == "<" then
		return arg_1_1 < arg_1_2
	elseif arg_1_0 == "<=" then
		return arg_1_1 <= arg_1_2
	elseif arg_1_0 == "=" then
		return arg_1_1 == arg_1_2
	elseif arg_1_0 == ">" then
		return arg_1_2 < arg_1_1
	elseif arg_1_0 == ">=" then
		return arg_1_2 <= arg_1_1
	elseif arg_1_0 == "and" then
		return arg_1_1 and arg_1_2
	elseif arg_1_0 == "or" then
		return arg_1_1 or arg_1_2
	elseif arg_1_0 == "~=" then
		return arg_1_1 ~= arg_1_2
	elseif arg_1_0 == "%" then
		if type(arg_1_2) == "table" then
			return arg_1_1 % arg_1_2[1] == arg_1_2[2]
		else
			return arg_1_1 % arg_1_2 == 0
		end
	end
end

function initAttackSpeedScale(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 * (1 + arg_2_2) <= 30 / arg_2_0 then
		return 1 + arg_2_2
	else
		return arg_2_1 * (1 + arg_2_2) * arg_2_0 / (30 * (1 + arg_2_2))
	end
end

DEBUG_FIGHT = true

function FightLOG(...)
	if DEBUG_FIGHT then
		print(...)
	end
end

function decode_condition_str2tbl(arg_4_0)
	return fightcondition.decode(arg_4_0)
end

local function var_0_0(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = 0
	local var_5_1 = FightManager:isPvp() ~= true and arg_5_0.__cname == "PlayerCharacter" or FightManager:isPvp() == true
	local var_5_2 = FightManager:isPvp() ~= true and arg_5_1.__cname == "PlayerCharacter" or FightManager:isPvp() == true

	if var_5_1 and arg_5_3 == MAJOR_RES_TBL[arg_5_2] then
		var_5_0 = arg_5_4 and 0.8 or 1
	elseif var_5_1 and arg_5_2 == "zerosupperession" then
		if arg_5_3 == "zerosupperession" then
			var_5_0 = 0.3
		elseif arg_5_3 ~= "linkage" and arg_5_3 ~= "shiling" and arg_5_3 ~= "umaru" then
			var_5_0 = 0.3
		end
	elseif var_5_1 and arg_5_2 == "mimicry" then
		-- block empty
	elseif var_5_1 and arg_5_2 == "imaginary" and arg_5_3 == arg_5_2 then
		var_5_0 = 0.5
	elseif var_5_2 and MAJOR_RES_TBL[arg_5_3] == arg_5_2 then
		var_5_0 = -0.5
	elseif var_5_2 and arg_5_3 == "imaginary" and arg_5_3 == arg_5_2 then
		var_5_0 = -0.5
	elseif var_5_2 and arg_5_3 == "zerosupperession" and arg_5_2 ~= "linkage" and arg_5_2 ~= "shiling" and arg_5_2 ~= "umaru" then
		var_5_0 = 0
	end

	return var_5_0
end

function getMajorListInfo(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = false

	if arg_6_0.main then
		if arg_6_0.main == "imaginary" then
			var_6_1 = true
		end

		table.insert(var_6_0, arg_6_0.main)
	end

	if arg_6_0.sub then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.sub) do
			table.insert(var_6_0, iter_6_1)

			if iter_6_1 == "imaginary" then
				var_6_1 = true

				break
			end
		end
	end

	if var_6_1 == true then
		var_6_0 = {}
		var_6_0 = arg_6_1:getAttribute("imaginaryConvertAttr")

		if #var_6_0 <= 0 then
			table.insert(var_6_0, "imaginary")
		end
	end

	return var_6_0, var_6_1
end

local var_0_1 = 1

function calculate_majorattr_addition(arg_7_0, arg_7_1)
	local var_7_0 = {
		MINUS = 2,
		PLUS = 1,
		NONE = 0
	}

	if require("controller.time_check_manager"):getCurTime() < 1677945600 and FightManager:isPvp() == true then
		return var_7_0.NONE, 0
	end

	if not arg_7_0 or not arg_7_1 then
		return var_7_0.NONE, 0
	end

	local var_7_1, var_7_2 = getMajorListInfo(arg_7_0:getAttribute("allAttrs"), arg_7_0)
	local var_7_3 = getMajorListInfo(arg_7_1:getAttribute("allAttrs"), arg_7_1)
	local var_7_4 = var_7_0.NONE

	if arg_7_0.statuspool:getStatus("addattrweak") then
		local var_7_6 = false
		local var_7_7 = arg_7_1.statuspool:getStatus("addattrweak")

		if var_7_7 ~= 0 then
			-- block empty
		end

		if var_7_7 > 0 then
			for iter_7_0, iter_7_1 in pairs(var_7_3) do
				if iter_7_1 == MAJOR_RES_TBL[ATTR_ID[var_7_7]] then
					var_7_6 = true
				end
			end

			if not var_7_6 then
				table.insert(var_7_3, MAJOR_RES_TBL[ATTR_ID[var_7_7]])
			end
		elseif var_7_7 < 0 then
			for iter_7_2, iter_7_3 in pairs(var_7_3) do
				if iter_7_3 == ATTR_ID[-var_7_7] then
					table.remove(var_7_3, iter_7_2)
				end
			end
		end
	end

	local var_7_8 = {}

	for iter_7_4, iter_7_5 in pairs(var_7_1) do
		for iter_7_6, iter_7_7 in pairs(var_7_3) do
			table.insert(var_7_8, (var_0_0(arg_7_0, arg_7_1, iter_7_5, iter_7_7, var_7_2)))
		end
	end

	var_0_1 = var_0_1 + 1

	local var_7_9 = 1
	local var_7_10 = 1

	for iter_7_8, iter_7_9 in pairs(var_7_8) do
		if iter_7_9 > 0 then
			var_7_9 = var_7_9 + iter_7_9
		else
			var_7_10 = var_7_10 - iter_7_9
		end
	end

	local var_7_11 = var_7_9 / var_7_10

	if var_7_9 / var_7_10 > 1 then
		var_7_4 = var_7_0.PLUS
	elseif var_7_11 < 1 then
		var_7_4 = var_7_0.MINUS
	end

	return var_7_4, var_7_11
end

function CalculateExtraDamage(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0 == HOLY_DAMAGE then
		if arg_8_2 then
			local var_8_0 = 1 + arg_8_2:getAttribute("extra_attack")

			var_8_0 = var_8_0 > 1 and var_8_0 or 1
			arg_8_1 = arg_8_1 * var_8_0 + arg_8_2:getAttribute("extra_attack_const")

			if arg_8_2 and not arg_8_2.statuspool:getStatus("ignoremaxcausedamageholy") and arg_8_2:getAttribute("max_cause_damage_holy") > 0 and arg_8_1 > arg_8_2:getAttribute("max_cause_damage_holy") then
				arg_8_1 = arg_8_2:getAttribute("max_cause_damage_holy")
			end
		end
	elseif arg_8_0 == MECHANICAL_DAMAGE then
		local var_8_1 = 0
		local var_8_2 = 0
		local var_8_5 = arg_8_3:getAttribute("extra_defence") + arg_8_3:getAttribute("extra_mechanical_defence")

		if 0 < 0 then
			var_8_5 = 0
		end

		local var_8_6 = arg_8_3:getAttribute("extra_defence_const") + arg_8_3:getAttribute("extra_mechanical_defenceconst")

		if arg_8_2 then
			var_8_1 = arg_8_2:getAttribute("extra_attack") + arg_8_3:getAttribute("extra_injure") + arg_8_2:getAttribute("extra_mechanical_attack") + arg_8_3:getAttribute("extra_mechanical_injure")

			if var_8_1 < 0 then
				var_8_1 = 0
			end

			var_8_2 = arg_8_2:getAttribute("extra_attack_const") + arg_8_2:getAttribute("extra_mechanical_attackconst")
			var_8_5 = var_8_5 + arg_8_2:getAttribute("extra_weak")

			if var_8_5 < 0 then
				var_8_5 = 0
			end
		end

		arg_8_1 = arg_8_1 * ((1 + var_8_1 - var_8_5 < 0 or nil) and 0) + (var_8_2 - var_8_6)

		if arg_8_2 and not arg_8_2.statuspool:getStatus("ignoremaxcausedamagemechanical") and arg_8_2:getAttribute("max_cause_damage_mechanical") > 0 and arg_8_1 > arg_8_2:getAttribute("max_cause_damage_mechanical") then
			arg_8_1 = arg_8_2:getAttribute("max_cause_damage_mechanical")
		end
	elseif arg_8_0 == ENERGY_DAMAGE then
		local var_8_8 = 0
		local var_8_9 = 0
		local var_8_12 = arg_8_3:getAttribute("extra_defence") + arg_8_3:getAttribute("extra_energy_defence")

		if 0 < 0 then
			var_8_12 = 0
		end

		local var_8_13 = arg_8_3:getAttribute("extra_defence_const") + arg_8_3:getAttribute("extra_energy_defenceconst")

		if arg_8_2 then
			var_8_8 = arg_8_2:getAttribute("extra_attack") + arg_8_3:getAttribute("extra_injure") + arg_8_2:getAttribute("extra_energy_attack") + arg_8_3:getAttribute("extra_energy_injure")

			if var_8_8 < 0 then
				var_8_8 = 0
			end

			var_8_9 = arg_8_2:getAttribute("extra_attack_const")
			var_8_12 = var_8_12 + arg_8_2:getAttribute("extra_weak")

			if var_8_12 < 0 then
				var_8_12 = 0
			end
		end

		arg_8_1 = arg_8_1 * ((1 + var_8_8 - var_8_12 < 0 or nil) and 0) + (var_8_9 - var_8_13)

		if arg_8_2 and not arg_8_2.statuspool:getStatus("ignoremaxcausedamageenergy") and arg_8_2:getAttribute("max_cause_damage_energy") > 0 and arg_8_1 > arg_8_2:getAttribute("max_cause_damage_energy") then
			arg_8_1 = arg_8_2:getAttribute("max_cause_damage_energy")
		end
	end

	if arg_8_2 and not arg_8_2.statuspool:getStatus("ignoremaxcausedamage") and arg_8_2:getAttribute("max_cause_damage") > 0 and arg_8_1 > arg_8_2:getAttribute("max_cause_damage") then
		arg_8_1 = arg_8_2:getAttribute("max_cause_damage")
	end

	return arg_8_1
end

function CalculateMechanicalEnergyAddition(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0 == MECHANICAL_DAMAGE then
		local var_9_0 = 1
		local var_9_1 = 0
		local var_9_4 = 1 - arg_9_3:getAttribute("extra_mechanical_defence")

		if 1 < 0 then
			var_9_4 = 0
		end

		if var_9_4 > 1 then
			var_9_4 = 1
		end

		local var_9_5 = arg_9_3:getAttribute("extra_mechanical_defenceconst")

		if arg_9_2 then
			var_9_0 = 1 + arg_9_2:getAttribute("extra_mechanical_attack") + arg_9_3:getAttribute("extra_mechanical_injure")
			var_9_0 = var_9_0 > 1 and var_9_0 or 1
			var_9_1 = arg_9_2:getAttribute("extra_mechanical_attackconst")
			var_9_4 = var_9_4 - arg_9_2:getAttribute("extra_mechanical_weak")
		end

		arg_9_1 = arg_9_1 * var_9_0 * var_9_4
		arg_9_1 = arg_9_1 + (var_9_1 - var_9_5)
		arg_9_1 = math.round(arg_9_1)
	elseif arg_9_0 == ENERGY_DAMAGE then
		local var_9_6 = 1
		local var_9_7 = 0
		local var_9_10 = 1 - arg_9_3:getAttribute("extra_energy_defence")

		if 1 < 0 then
			var_9_10 = 0
		end

		if var_9_10 > 1 then
			var_9_10 = 1
		end

		local var_9_11 = arg_9_3:getAttribute("extra_energy_defenceconst")

		if arg_9_2 then
			var_9_6 = 1 + arg_9_2:getAttribute("extra_energy_attack") + arg_9_3:getAttribute("extra_energy_injure")
			var_9_6 = var_9_6 > 1 and var_9_6 or 1
			var_9_7 = arg_9_2:getAttribute("extra_energy_attackconst")
			var_9_10 = var_9_10 - arg_9_2:getAttribute("extra_energy_weak")
		end

		arg_9_1 = arg_9_1 * var_9_6 * var_9_10
		arg_9_1 = arg_9_1 + (var_9_7 - var_9_11)
		arg_9_1 = math.round(arg_9_1)
	end

	return arg_9_1
end

function CalculateStrikeDodgeCriBlind(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = false
	local var_10_1 = false
	local var_10_2 = false
	local var_10_3 = false

	if arg_10_1 == MECHANICAL_DAMAGE then
		if arg_10_4 == 1 and math.random() <= arg_10_2:getAttribute("blind") then
			var_10_0 = true
		else
			local var_10_4 = arg_10_2:getEffectStatus("ignore_dodge") or arg_10_0.effect.ignore_dodge
			local var_10_5 = (arg_10_2:getAttribute("strike") * 0.001 + arg_10_2:getAttribute("exe_strike")) * (1 + arg_10_2:getAttribute("strike_rate")) - arg_10_3:getAttribute("exe_strike_resistance")

			if var_10_5 < 0 then
				var_10_5 = 0
			end

			local var_10_6 = arg_10_3:getAttribute("dodge") * 0.001 + arg_10_3:getAttribute("exe_dodge")

			if var_10_6 < 0 then
				var_10_6 = 0
			end

			local var_10_7 = (arg_10_2:getAttribute("critical") * 0.001 + arg_10_2:getAttribute("exe_critical")) * (1 + arg_10_2:getAttribute("cri_rate")) - arg_10_3:getAttribute("critical_resistance")

			if var_10_7 < 0 then
				var_10_7 = 0
			end

			local var_10_8 = var_10_6 + var_10_5

			if var_10_4 then
				var_10_8 = 0
			end

			local var_10_9 = math.random()

			if var_10_9 <= var_10_5 then
				var_10_1 = true

				arg_10_2:triggerStatus("onStrike", arg_10_3, arg_10_0)
				arg_10_3:triggerStatus("onBeStriked", arg_10_2, arg_10_0)
			elseif var_10_9 <= var_10_8 then
				var_10_2 = true

				arg_10_3:triggerStatus("onDodge", arg_10_2, arg_10_0)
				arg_10_2:triggerStatus("onBeDodged", arg_10_3, arg_10_0)
			elseif var_10_9 <= var_10_7 + (var_10_6 + var_10_5) then
				var_10_3 = true

				arg_10_2:triggerStatus("onCritical", arg_10_3, arg_10_0)
				arg_10_3:triggerStatus("onBeCritied", arg_10_2, arg_10_0)
			end
		end
	elseif arg_10_1 == HOLY_DAMAGE then
		if math.random() <= arg_10_2:getAttribute("blind") then
			var_10_0 = true
		end
	elseif arg_10_1 == ENERGY_DAMAGE then
		-- block empty
	end

	return var_10_0, var_10_1, var_10_2, var_10_3
end

trigger_conditions = {
	[0] = "onHalo",
	"onAttack",
	"onHitted",
	"onDied",
	"onKill",
	"onCritical",
	"onDodge",
	"onStrike",
	"onTimer",
	"onDying",
	"onXP",
	"onOffence",
	"onRevival",
	"onDoubleHit",
	"onHematophagy",
	"onForce",
	"onBeForced",
	"onHeal",
	"onDefence",
	"onAttack2",
	"onHitted2",
	"onOffence2",
	"onDefence2",
	"onHurt",
	"onNormalSkill",
	"onCast",
	"onSkill",
	"onBeCritied",
	"onBeDodged",
	"onBeStriked",
	"onFightBegin",
	"onMechanicalDamage",
	"onEnergyDamage",
	"onMechanicalHurt",
	"onEnergyHurt",
	"onFirstAttack",
	"onDyingBeforeSheild",
	"onEnemyDied",
	"onXPCast",
	"onFightBeginFirst",
	"onDyingNoImmortal",
	"onNormalCast"
}
baseAttr = {
	[0] = {
		attr = "science_point",
		relations = {},
		proc1 = function(self)
			return self:getAttribute("science_point")
		end,
		proc2 = function(self)
			return self:getAttribute("science_point")
		end,
		proc3 = function(self)
			return self:getAttribute("science_point")
		end
	},
	[31] = {
		attr = "science_point",
		relations = {},
		proc1 = function(self)
			return self:getAttribute("science_point")
		end,
		proc2 = function(self)
			return self:getAttribute("science_point")
		end,
		proc3 = function(self)
			return self:getAttribute("science_point")
		end
	},
	[32] = {
		attr = "science_point",
		relations = {},
		proc1 = function(self)
			return self:getAttribute("science_point")
		end,
		proc2 = function(self)
			return self:getAttribute("science_point")
		end,
		proc3 = function(self)
			return self:getAttribute("science_point")
		end
	},
	{
		attr = "damage",
		proc1 = function(self)
			return self:getBasicAttribute("damage")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("damage")
		end,
		proc3 = function(self)
			return self:getAttribute("damage")
		end
	},
	{
		attr = "singlehp",
		proc1 = function(self)
			return self:getBasicAttribute("singlehp")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("singlehp")
		end,
		proc3 = function(self)
			return self:getAttribute("singlehp")
		end
	},
	{
		attr = "singlehp",
		relations = {
			"curhp"
		},
		proc1 = function(self)
			return self:getAttribute("curhp")
		end,
		proc2 = function(self)
			return self:getAttribute("curhp")
		end,
		proc3 = function(self)
			return self:getAttribute("curhp")
		end
	},
	{
		relations = {
			"hp",
			"curhp"
		},
		proc1 = function(self)
			return (self:getAttribute("singlehp") - self:getAttribute("curhp")) / self:getAttribute("singlehp")
		end,
		proc2 = function(self)
			return (self:getAttribute("singlehp") - self:getAttribute("curhp")) / self:getAttribute("singlehp")
		end,
		proc3 = function(self)
			return (self:getAttribute("singlehp") - self:getAttribute("curhp")) / self:getAttribute("singlehp")
		end
	},
	{
		attr = "attackspeed",
		proc1 = function(self)
			return self:getBasicAttribute("attackspeed")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("attackspeed")
		end,
		proc3 = function(self)
			return self:getAttribute("attackspeed")
		end
	},
	{
		attr = "movingspeed",
		proc1 = function(self)
			return self:getBasicAttribute("movingspeed")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("movingspeed")
		end,
		proc3 = function(self)
			return self:getAttribute("movingspeed")
		end
	},
	{
		attr = "defence",
		proc1 = function(self)
			return self:getBasicAttribute("defence")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("defence")
		end,
		proc3 = function(self)
			return self:getAttribute("defence")
		end
	},
	{
		attr = "critical",
		proc1 = function(self)
			return self:getBasicAttribute("critical")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("critical")
		end,
		proc3 = function(self)
			return self:getAttribute("critical")
		end
	},
	{
		attr = "strike",
		proc1 = function(self)
			return self:getBasicAttribute("strike")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("strike")
		end,
		proc3 = function(self)
			return self:getAttribute("strike")
		end
	},
	{
		attr = "spellpower",
		proc1 = function(self)
			return self:getBasicAttribute("spellpower")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("spellpower")
		end,
		proc3 = function(self)
			return self:getAttribute("spellpower")
		end
	},
	{
		attr = "exe_defence",
		proc1 = function(self)
			return self:getBasicAttribute("exe_defence")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("exe_defence")
		end,
		proc3 = function(self)
			return self:getAttribute("exe_defence")
		end
	},
	{
		attr = "exe_critical",
		proc1 = function(self)
			return self:getBasicAttribute("exe_critical")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("exe_critical")
		end,
		proc3 = function(self)
			return self:getAttribute("exe_critical")
		end
	},
	{
		attr = "exe_dodge",
		proc1 = function(self)
			return self:getBasicAttribute("exe_dodge")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("exe_dodge")
		end,
		proc3 = function(self)
			return self:getAttribute("exe_dodge")
		end
	},
	{
		attr = "exe_strike",
		proc1 = function(self)
			return self:getBasicAttribute("exe_strike")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("exe_strike")
		end,
		proc3 = function(self)
			return self:getAttribute("exe_strike")
		end
	},
	[16] = {
		attr = "hematophagy",
		proc1 = function(self)
			return self:getBasicAttribute("hematophagy")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("hematophagy")
		end,
		proc3 = function(self)
			return self:getAttribute("hematophagy")
		end
	},
	[17] = {
		attr = "healrate",
		proc1 = function(self)
			return self:getBasicAttribute("healrate")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("healrate")
		end,
		proc3 = function(self)
			return self:getAttribute("healrate")
		end
	},
	[18] = {
		relations = {
			"curhp",
			"hp"
		},
		proc1 = function(self)
			return self:getAttribute("singlehp") - self:getAttribute("curhp")
		end,
		proc2 = function(self)
			return self:getAttribute("singlehp") - self:getAttribute("curhp")
		end,
		proc3 = function(self)
			return self:getAttribute("singlehp") - self:getAttribute("curhp")
		end
	},
	[19] = {
		attr = "cri_damage_add",
		proc1 = function(self)
			return self:getBasicAttribute("cri_damage_add")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("cri_damage_add")
		end,
		proc3 = function(self)
			return self:getAttribute("cri_damage_add")
		end
	},
	[20] = {
		attr = "dodge_damage_add",
		proc1 = function(self)
			return self:getBasicAttribute("dodge_damage_add")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("dodge_damage_add")
		end,
		proc3 = function(self)
			return self:getAttribute("dodge_damage_add")
		end
	},
	[21] = {
		attr = "strike_damage_add",
		proc1 = function(self)
			return self:getBasicAttribute("strike_damage_add")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("strike_damage_add")
		end,
		proc3 = function(self)
			return self:getAttribute("strike_damage_add")
		end
	},
	[22] = {
		attr = "blind",
		proc1 = function(self)
			return self:getBasicAttribute("blind")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("blind")
		end,
		proc3 = function(self)
			return self:getAttribute("blind")
		end
	},
	[23] = {
		attr = "healpoint",
		proc1 = function(self)
			return self:getBasicAttribute("healpoint")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("healpoint")
		end,
		proc3 = function(self)
			return self:getAttribute("healpoint")
		end
	},
	[24] = {
		attr = "force",
		proc1 = function(self)
			return self:getBasicAttribute("force")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("force")
		end,
		proc3 = function(self)
			return self:getAttribute("force")
		end
	},
	[25] = {
		attr = "reforce",
		proc1 = function(self)
			return self:getBasicAttribute("reforce")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("reforce")
		end,
		proc3 = function(self)
			return self:getAttribute("reforce")
		end
	},
	[26] = {
		attr = "range",
		proc1 = function(self)
			return self:getBasicAttribute("range")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("range")
		end,
		proc3 = function(self)
			return self:getAttribute("range")
		end
	},
	[27] = {
		relations = {
			"hp",
			"curhp"
		},
		proc1 = function(self)
			return self:getAttribute("curhp") / self:getAttribute("singlehp")
		end,
		proc2 = function(self)
			return self:getAttribute("curhp") / self:getAttribute("singlehp")
		end,
		proc3 = function(self)
			return self:getAttribute("curhp") / self:getAttribute("singlehp")
		end
	},
	[28] = {
		attr = "hp",
		relations = {
			"hp"
		},
		proc1 = function(self)
			return self:getAttribute("hp")
		end,
		proc2 = function(self)
			return self:getAttribute("hp")
		end,
		proc3 = function(self)
			return self:getAttribute("hp")
		end
	},
	[29] = {
		attr = "singlehp",
		proc1 = function(self)
			return self:getBasicAttribute("singlehp") + self:getAttribute("equipsinglehp")
		end,
		proc2 = function(self)
			return self:rawGetAttribute("singlehp")
		end,
		proc3 = function(self)
			return self:getAttribute("singlehp")
		end
	},
	[30] = {
		attr = "damage",
		proc1 = function(self)
			return self:getAttribute("damage")
		end,
		proc2 = function(self)
			return self:getAttribute("damage")
		end,
		proc3 = function(self)
			return self:getAttribute("damage")
		end
	},
	[31] = {
		attr = "energydefence",
		proc1 = function(self)
			return self:getBasicAttribute("energydefence")
		end,
		proc2 = function(self)
			return self:getBasicAttribute("energydefence")
		end,
		proc3 = function(self)
			return self:getAttribute("energydefence")
		end
	},
	[32] = {
		attr = "rage",
		proc1 = function(self)
			return self:getAttribute("maxrage")
		end,
		proc2 = function(self)
			return self:getAttribute("maxrage")
		end,
		proc3 = function(self)
			return self:getAttribute("maxrage")
		end
	},
	[33] = {
		attr = "exe_critical",
		proc1 = function(self)
			return (self:getBasicAttribute("critical") * 0.001 + self:getBasicAttribute("exe_critical")) * (1 + self:getBasicAttribute("cri_rate"))
		end,
		proc2 = function(self)
			return (self:getBasicAttribute("critical") * 0.001 + self:getBasicAttribute("exe_critical")) * (1 + self:getBasicAttribute("cri_rate"))
		end,
		proc3 = function(self)
			return (self:getAttribute("critical") * 0.001 + self:getAttribute("exe_critical")) * (1 + self:getAttribute("cri_rate"))
		end
	},
	[34] = {
		relations = {},
		proc1 = function(self)
			return self.statuspool:getStatus("shield").total
		end,
		proc2 = function(self)
			return self.statuspool:getStatus("shield").total
		end,
		proc3 = function(self)
			return self.statuspool:getStatus("shield").total
		end
	}
}

setmetatable(baseAttr, {
	__index = function(arg_119_0, arg_119_1)
		local var_119_0 = {
			relations = {},
			proc1 = function(self, arg_120_1)
				arg_120_1 = arg_120_1 or 100

				return math.min(self:getBuffCount(arg_119_1), arg_120_1)
			end,
			proc2 = function(self, arg_121_1)
				arg_121_1 = arg_121_1 or 100

				return math.min(self:getBuffCount(arg_119_1), arg_121_1)
			end,
			proc3 = function(self, arg_122_1)
				arg_122_1 = arg_122_1 or 100

				return math.min(self:getBuffCount(arg_119_1), arg_122_1)
			end
		}

		arg_119_0[arg_119_1] = var_119_0

		return var_119_0
	end
})
