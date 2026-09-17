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
			method = "lock_target_in_area",
			param = {
				param = 700,
				condition = "all"
			}
		},
		{
			{
				{
					operator = "<",
					method = "check_target_buffcount",
					param = {
						value = 3,
						target = "self",
						buff = 18002048
					}
				},
				{
					param = "xp",
					yield = true,
					method = "useSkill"
				}
			},
			{
				{
					operator = ">=",
					method = "check_target_buffcount",
					param = {
						value = 3,
						target = "self",
						buff = 18002048
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp_zhen"
					}
				}
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
			method = "lock_target_in_area",
			param = {
				param = 500,
				condition = "farest"
			}
		},
		{
			param = "skill3",
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
			method = "lock_target_in_area",
			param = {
				param = 400,
				condition = "all"
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
				param = 400,
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
	}
}
