return {
	xp = {
		{
			method = "can_skill_usable",
			param = "xp"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			{
				{
					method = "lock_target_by_attr",
					param = {
						lockcondition = "self:buff120182001-self:buff120182002>0",
						condition = "all"
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 200,
						condition = "nearest"
					}
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
					method = "lock_target_in_area",
					param = {
						area = 200,
						condition = "nearest"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp2"
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
			{
				{
					method = "lock_target_by_attr",
					param = {
						lockcondition = "self:buff120182001-self:buff120182002>0",
						condition = "all"
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 200,
						condition = "nearest"
					}
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
					method = "lock_target_in_area",
					param = {
						area = 200,
						condition = "nearest"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp2"
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
			{
				{
					method = "lock_target_by_attr",
					param = {
						lockcondition = "self:buff120182001-self:buff120182002>0",
						condition = "all"
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 400,
						condition = "nearest"
					}
				},
				{
					param = "skill1",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					method = "lock_target_in_area",
					param = {
						area = 400,
						condition = "nearest"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_change"
					}
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
