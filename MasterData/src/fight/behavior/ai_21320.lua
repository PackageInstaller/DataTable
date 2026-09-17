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
				area = 640,
				condition = "hp_percent_lowest"
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
				area = 640,
				condition = "hp_percent_lowest"
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
			method = "can_skill_usable",
			param = "skill2"
		},
		{
			{
				{
					method = "can_skill_usable",
					param = "skill1"
				},
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					param = 0.5,
					operator = "<=",
					method = "check_targetpool_hp_percent"
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
					method = "can_skill_usable",
					param = "skill1"
				},
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_by_condition",
					param = {
						area = 640,
						condition = "hp_lowest"
					}
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
	skill1_1 = {
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
					method = "can_skill_usable",
					param = "skill1_1"
				},
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					param = 0.5,
					operator = "<=",
					method = "check_targetpool_hp_percent"
				},
				{
					method = "lock_target_by_condition",
					param = "hp_percent_lowest"
				},
				{
					param = "skill2_1",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					method = "can_skill_usable",
					param = "skill1_1"
				},
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_by_condition",
					param = {
						area = 640,
						condition = "hp_lowest"
					}
				},
				{
					param = "skill1_1",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	skill1_2 = {
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
					method = "can_skill_usable",
					param = "skill1_2"
				},
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					param = 0.5,
					operator = "<=",
					method = "check_targetpool_hp_percent"
				},
				{
					method = "lock_target_by_condition",
					param = "hp_percent_lowest"
				},
				{
					param = "skill2_2",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					method = "can_skill_usable",
					param = "skill1_2"
				},
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_by_condition",
					param = {
						area = 640,
						condition = "hp_lowest"
					}
				},
				{
					param = "skill1_2",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	skill1_3 = {
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
					method = "can_skill_usable",
					param = "skill1_3"
				},
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					param = 0.5,
					operator = "<=",
					method = "check_targetpool_hp_percent"
				},
				{
					method = "lock_target_by_condition",
					param = "hp_percent_lowest"
				},
				{
					param = "skill2_3",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					method = "can_skill_usable",
					param = "skill1_3"
				},
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_by_condition",
					param = {
						area = 640,
						condition = "hp_lowest"
					}
				},
				{
					param = "skill1_3",
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
