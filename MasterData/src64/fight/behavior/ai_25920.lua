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
			method = "lock_target_by_attr",
			param = {
				area = 500,
				condition = "nearest"
			}
		},
		{
			{
				{
					param = 200,
					operator = ">=",
					method = "check_target_distance"
				},
				{
					param = "xp",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp1"
					}
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	xp_manual = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_attr",
			param = {
				area = 500,
				condition = "nearest"
			}
		},
		{
			{
				{
					param = 200,
					operator = ">=",
					method = "check_target_distance"
				},
				{
					param = "xp",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp1"
					}
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	skill1 = {
		{
			method = "can_skill_usable",
			param = "skill1"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = "range",
				condition = "all"
			}
		},
		{
			param = "skill1",
			yield = true,
			method = "useSkill"
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
