return {
	xp = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 700,
				condition = "all"
			}
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
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 700,
				condition = "all"
			}
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
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
				count = 2,
				condition = "hp_percent_lowest"
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
					{
						{
							method = "lock_target_pool",
							param = "teammate"
						},
						{
							param = 0.9,
							operator = "<=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_pool",
							param = "teammate"
						},
						{
							method = "lock_target_by_condition",
							param = "hp_percent_lowest"
						},
						{
							param = "attack2",
							yield = true,
							method = "useSkill"
						}
					},
					{
						{
							param = "attack",
							yield = true,
							method = "useSkill"
						}
					},
					type = "selector"
				}
			},
			{
				{
					method = "move_forward",
					yield = true
				}
			},
			type = "selector"
		},
		type = "sequence"
	}
}
