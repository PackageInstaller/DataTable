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
			param = "nearest"
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
			method = "lock_target_by_condition",
			param = "nearest"
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
				area = 450,
				condition = "nearest"
			}
		},
		{
			{
				{
					method = "check_unit_order",
					param = 0
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
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_fly"
					}
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
			{
				{
					method = "check_unit_order",
					param = 0
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
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_1_fly"
					}
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	skill1_2 = {
		{
			method = "check_unit_order",
			param = 0
		},
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
	skill1_3 = {
		{
			method = "check_unit_order",
			param = 0
		},
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
							method = "check_unit_order",
							param = 1
						},
						{
							method = "lock_target_in_area",
							param = {
								area = 480,
								condition = "farest"
							}
						},
						{
							param = "attack-fly",
							yield = true,
							method = "useSkill"
						},
						type = "sequence"
					},
					{
						{
							param = "attack",
							yield = true,
							method = "useSkill"
						},
						type = "sequence"
					},
					type = "selector"
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
