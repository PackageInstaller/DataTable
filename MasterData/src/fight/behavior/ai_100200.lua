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
			method = "lock_target_by_attr",
			param = {
				area = 500,
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
			method = "lock_target_by_attr",
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
						cfg = "attack_fly"
					}
				},
				type = "sequence"
			},
			type = "selector"
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
			method = "lock_target_by_attr",
			param = {
				area = 150,
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
					param = "skill2",
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
						id = "skill2",
						cfg = "skill2_fly"
					}
				},
				type = "sequence"
			},
			type = "selector"
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
			method = "lock_target_by_attr",
			param = {
				area = 800,
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
								method = "lock_target_by_condition",
								param = "random"
							},
							{
								param = "attack_fly",
								yield = true,
								method = "useSkill"
							},
							type = "sequence"
						},
						{
							{
								{
									operator = "=",
									method = "check_target_buffcount",
									param = {
										value = 1,
										target = "self",
										buff = 127007300
									}
								},
								{
									param = "attack3",
									yield = true,
									method = "useSkill"
								},
								type = "sequence"
							},
							{
								{
									param = "attack1",
									yield = true,
									method = "useSkill"
								},
								type = "sequence"
							},
							type = "selector"
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
								method = "lock_target_by_condition",
								param = "random"
							},
							{
								param = "attack_fly",
								yield = true,
								method = "useSkill"
							},
							type = "sequence"
						},
						{
							{
								{
									operator = "=",
									method = "check_target_buffcount",
									param = {
										value = 1,
										target = "self",
										buff = 127007300
									}
								},
								{
									param = "attack4",
									yield = true,
									method = "useSkill"
								},
								type = "sequence"
							},
							{
								{
									param = "attack2",
									yield = true,
									method = "useSkill"
								},
								type = "sequence"
							},
							type = "selector"
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
		},
		type = "sequence"
	}
}
