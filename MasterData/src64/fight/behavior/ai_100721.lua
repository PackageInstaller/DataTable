return {
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
			method = "lock_target_by_condition",
			param = "all"
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
			method = "lock_target_by_condition",
			param = "all"
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
							operator = ">",
							method = "random",
							param = {
								num = 4,
								range = 10
							}
						},
						{
							param = "attack1",
							yield = true,
							method = "useSkill"
						},
						type = "sequence"
					},
					{
						{
							{
								operator = ">",
								method = "random",
								param = {
									num = 2,
									range = 4
								}
							},
							{
								param = "attack2",
								yield = true,
								method = "useSkill"
							},
							type = "sequence"
						},
						{
							{
								param = "attack3",
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
	}
}
