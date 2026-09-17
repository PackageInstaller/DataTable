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
					operator = ">=",
					method = "check_target_buffcount",
					param = {
						value = 1,
						target = "self",
						buff = 12130206
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 450,
						condition = "all"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp_xp"
					}
				}
			},
			{
				{
					method = "lock_target_in_area",
					param = {
						area = 450,
						condition = "all"
					}
				},
				{
					param = "xp",
					yield = true,
					method = "useSkill"
				}
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
					operator = ">=",
					method = "check_target_buffcount",
					param = {
						value = 1,
						target = "self",
						buff = 12130206
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 450,
						condition = "all"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp_xp"
					}
				}
			},
			{
				{
					method = "lock_target_in_area",
					param = {
						area = 450,
						condition = "all"
					}
				},
				{
					param = "xp",
					yield = true,
					method = "useSkill"
				}
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
				area = 450,
				condition = "hp_lowest"
			}
		},
		{
			{
				{
					operator = ">=",
					method = "check_target_buffcount",
					param = {
						value = 1,
						target = "self",
						buff = 12130206
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_xp"
					}
				}
			},
			{
				param = "skill1",
				yield = true,
				method = "useSkill"
			},
			type = "selector"
		}
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
								buff = 12130206
							}
						},
						{
							{
								{
									param = "attack1",
									yield = true,
									method = "useSkill"
								}
							},
							type = "selector"
						}
					},
					{
						{
							{
								param = "attack2",
								yield = true,
								method = "useSkill"
							}
						},
						type = "selector"
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
