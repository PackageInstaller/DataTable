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
			{
				{
					operator = "=",
					method = "check_target_buffcount",
					param = {
						value = 0,
						target = "self",
						buff = 12692002
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 400,
						condition = "hp_lowest"
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
					param = 0.4,
					operator = "<=",
					method = "check_character_hp_percent"
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 400,
						condition = "hp_lowest"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "skill_back"
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
					operator = "=",
					method = "check_target_buffcount",
					param = {
						value = 0,
						target = "self",
						buff = 12692002
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 400,
						condition = "hp_lowest"
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
						area = 400,
						condition = "hp_lowest"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "skill_back"
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
				area = 350,
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
							operator = "=",
							method = "check_target_buffcount",
							param = {
								value = 0,
								target = "self",
								buff = 12692002
							}
						},
						{
							{
								{
									operator = ">",
									method = "random",
									param = {
										num = 5,
										range = 10
									}
								},
								{
									param = "attack",
									yield = true,
									method = "useSkill"
								}
							},
							{
								{
									param = "attack2",
									yield = true,
									method = "useSkill"
								}
							},
							type = "selector"
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
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	}
}
