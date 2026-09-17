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
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 400,
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
					{
						param = "range",
						operator = "<=",
						method = "check_target_distance"
					},
					{
						operator = "<=",
						method = "check_target_buffcount",
						param = {
							value = 0,
							target = "self",
							buff = 112012712
						}
					},
					{
						method = "lock_target_in_area",
						param = {
							area = 120,
							condition = "all"
						}
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
						param = "range",
						operator = "<=",
						method = "check_target_distance"
					},
					{
						operator = "<=",
						method = "check_target_buffcount",
						param = {
							value = 1,
							target = "self",
							buff = 112012712
						}
					},
					{
						method = "lock_target_in_area",
						param = {
							area = 170,
							condition = "all"
						}
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
						param = "range",
						operator = "<=",
						method = "check_target_distance"
					},
					{
						operator = "<=",
						method = "check_target_buffcount",
						param = {
							value = 2,
							target = "self",
							buff = 112012712
						}
					},
					{
						method = "lock_target_in_area",
						param = {
							area = 220,
							condition = "all"
						}
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
						param = "range",
						operator = "<=",
						method = "check_target_distance"
					},
					{
						operator = "<=",
						method = "check_target_buffcount",
						param = {
							value = 3,
							target = "self",
							buff = 112012712
						}
					},
					{
						method = "lock_target_in_area",
						param = {
							area = 270,
							condition = "all"
						}
					},
					{
						param = "attack",
						yield = true,
						method = "useSkill"
					},
					type = "sequence"
				},
				type = "selector"
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
