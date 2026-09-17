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
				area = 600,
				condition = "all"
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
	xp_manual = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 600,
				condition = "all"
			}
		},
		{
			{
				{
					operator = "=",
					method = "check_target_buffcount",
					param = {
						value = 1,
						target = "self",
						buff = 120472002
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp_juexing"
					}
				}
			},
			{
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
			method = "set_turnback_limit",
			param = true
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 600,
				condition = "all"
			}
		},
		{
			{
				{
					operator = "=",
					method = "check_target_buffcount",
					param = {
						value = 1,
						target = "self",
						buff = 120472002
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_juexing"
					}
				}
			},
			{
				param = "skill1",
				yield = true,
				method = "useSkill"
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
					{
						{
							operator = "=",
							method = "check_target_buffcount",
							param = {
								value = 1,
								target = "self",
								buff = 120472002
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
