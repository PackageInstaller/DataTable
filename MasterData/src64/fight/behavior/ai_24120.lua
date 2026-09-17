return {
	xp = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 1000,
				condition = "nearest"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "all"
		},
		{
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	xp_manual = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 1000,
				condition = "nearest"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "all"
		},
		{
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	skill1 = {
		{
			method = "can_skill_usable",
			param = "skill1"
		},
		{
			method = "can_skill_usable",
			param = "skill2"
		},
		{
			{
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_by_condition",
					param = "nearest"
				},
				{
					param = 100,
					operator = "<=",
					method = "check_target_distance"
				},
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					method = "set_turnback_limit",
					param = true
				},
				{
					method = "lock_target_by_condition",
					param = "hp_percent_lowest"
				},
				{
					param = "skill2",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					method = "set_turnback_limit",
					param = true
				},
				{
					method = "lock_target_by_condition",
					param = "hp_percent_lowest"
				},
				{
					param = "skill1",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	attack = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "nearest"
		},
		{
			{
				{
					param = "range",
					operator = "<=",
					method = "check_target_distance"
				},
				{
					param = "attack",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					method = "move_forward",
					yield = true
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	}
}
