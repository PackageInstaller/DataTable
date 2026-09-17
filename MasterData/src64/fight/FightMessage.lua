local var_0_0 = {
	__index = {
		init = function(arg_1_0)
			arg_1_0.damage = 0
			arg_1_0.heal = 0
			arg_1_0.re_damage = 0
			arg_1_0.re_heal = 0
			arg_1_0.source = nil
			arg_1_0.info = {
				isBlind = false,
				beattype = 0,
				isMiss = false,
				isCri = false,
				isStrike = false
			}
			arg_1_0.doubleattack = false
			arg_1_0.effect = {
				immortal_limit = false,
				ignore_dodge = false,
				ignore_defence = false,
				hematophagy = 0
			}
		end,
		initSkillMsg = function(arg_2_0, arg_2_1)
			arg_2_0.catapult = 0
			arg_2_0.hitted = {}
			arg_2_0.skilleffect = {}
			arg_2_0.doubleattack = false
			arg_2_0.isdoubleattack = false
			arg_2_0.xpUIindex = nil
			arg_2_0.skillsection = 0
			arg_2_0.skilltype = arg_2_1:find("^attack") and "attack" or arg_2_1
			arg_2_0.skillspeedscale = 1
			arg_2_0.firstattack = false
		end
	}
}

function var_0_0.new()
	local var_3_0 = {}

	setmetatable(var_3_0, var_0_0)
	var_3_0:init()

	return var_3_0
end

function var_0_0.newSkillmsg(arg_4_0)
	local var_4_0 = {}

	setmetatable(var_4_0, var_0_0)
	var_4_0:initSkillMsg(arg_4_0)

	return var_4_0
end

return var_0_0
