local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = assert

lx.define_class("BattleRandom", function(arg_1_0)
	function arg_1_0:initRandom(arg_2_1)
		var_0_2(not self._is_already_init)

		local var_2_0 = self._random:deserialize(arg_2_1)
		local var_2_1 = self._visual_random:deserialize(arg_2_1)

		self._is_already_init = true
	end

	function arg_1_0:randomOne()
		self._count = self._count + 1

		return self._random:rand_one()
	end

	function arg_1_0:randRange(arg_4_1, arg_4_2)
		self._count = self._count + 1

		return self._random:rand(arg_4_1, arg_4_2)
	end

	function arg_1_0:randomRangeDouble(arg_5_1, arg_5_2)
		self._count = self._count + 1

		return (arg_5_2 - arg_5_1) * self._random:rand(0, 100) / 100 + arg_5_1
	end

	function arg_1_0:visualRandRange(arg_6_1, arg_6_2)
		return self._visual_random:rand(arg_6_1, arg_6_2)
	end

	function arg_1_0:getRandomCount()
		return self._count
	end

	function arg_1_0:set_target(arg_8_1, arg_8_2)
		self._have_target[arg_8_2] = arg_8_1
	end

	function arg_1_0:get_target(arg_9_1)
		return self._have_target[arg_9_1]
	end
end)

function var_0_0.create(arg_10_0, arg_10_1)
	local var_10_0 = var_0_1.class("BattleRandom")

	var_10_0._is_already_init = false
	var_10_0._random = lan_random.create()
	var_10_0._visual_random = lan_random.create()
	var_10_0._have_target = {}
	var_10_0._count = 0
	var_10_0._battlefield = arg_10_1

	return var_10_0
end

return var_0_0
