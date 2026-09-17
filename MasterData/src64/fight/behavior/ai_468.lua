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
				area = 400,
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
	skill5 = {
		{
			method = "can_skill_usable",
			param = "skill5"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 400,
				condition = "nearest"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "all"
		},
		{
			param = "skill5",
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
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	skill4 = {
		{
			method = "can_skill_usable",
			param = "skill4"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			operator = ">=",
			method = "check_targetpool_in_area",
			param = {
				center = 1,
				count = 2,
				left = 0,
				right = 200
			}
		},
		{
			param = "skill4",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	skill2 = {
		{
			method = "can_skill_usable",
			param = "skill2"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			operator = "=",
			method = "check_targetpool_in_area",
			param = {
				center = 1,
				count = 0,
				left = 0,
				right = 300
			}
		},
		{
			param = "skill2",
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
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 600,
				condition = "nearest"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "nearest"
		},
		{
			param = "skill1",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	skill3 = {
		{
			method = "can_skill_usable",
			param = "skill3"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 200,
				condition = "all"
			}
		},
		{
			param = "skill3",
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
					param = 0,
					operator = "=",
					method = "check_attackcount"
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
			},
			{
				{
					{
						param = "max_range",
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
			type = "selector"
		},
		type = "sequence"
	}
}
