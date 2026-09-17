return {
	xp = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
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
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
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
	xp1 = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
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
	xp1_manual = {
		{
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
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
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 600,
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
			{
				{
					param = 0,
					operator = "=",
					method = "check_attackcount"
				},
				{
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							param = 0.1,
							operator = ">=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_pool",
							param = "teammate"
						},
						{
							param = 0.9,
							operator = "<=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_by_condition",
							param = "hp_percent_lowest"
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
											operator = "<=",
											method = "random",
											param = {
												num = 3,
												range = 6
											}
										},
										{
											param = "attack2_1",
											yield = true,
											method = "useSkill"
										},
										type = "sequence"
									},
									{
										{
											param = "attack3_1",
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
					},
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							method = "lock_target_by_condition",
							param = "nearest"
						},
						{
							param = "range",
							operator = "<=",
							method = "check_target_distance"
						},
						{
							param = "attack1_1",
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
					operator = "%",
					method = "check_attackcount",
					param = {
						3,
						1
					}
				},
				{
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							param = 0.1,
							operator = ">=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_pool",
							param = "teammate"
						},
						{
							param = 0.9,
							operator = "<=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_by_condition",
							param = "hp_percent_lowest"
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
											operator = "<=",
											method = "random",
											param = {
												num = 3,
												range = 6
											}
										},
										{
											param = "attack2_2",
											yield = true,
											method = "useSkill"
										},
										type = "sequence"
									},
									{
										{
											param = "attack3_2",
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
					},
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							method = "lock_target_by_condition",
							param = "nearest"
						},
						{
							param = "max_range",
							operator = "<=",
							method = "check_target_distance"
						},
						{
							param = "attack1_2",
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
					operator = "%",
					method = "check_attackcount",
					param = {
						3,
						2
					}
				},
				{
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							param = 0.1,
							operator = ">=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_pool",
							param = "teammate"
						},
						{
							param = 0.9,
							operator = "<=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_by_condition",
							param = "hp_percent_lowest"
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
											operator = "<=",
											method = "random",
											param = {
												num = 3,
												range = 6
											}
										},
										{
											param = "attack2_3",
											yield = true,
											method = "useSkill"
										},
										type = "sequence"
									},
									{
										{
											param = "attack3_3",
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
					},
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							method = "lock_target_by_condition",
							param = "nearest"
						},
						{
							param = "max_range",
							operator = "<=",
							method = "check_target_distance"
						},
						{
							param = "attack1_3",
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
					operator = "%",
					method = "check_attackcount",
					param = {
						3,
						0
					}
				},
				{
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							param = 0.1,
							operator = ">=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_pool",
							param = "teammate"
						},
						{
							param = 0.9,
							operator = "<=",
							method = "check_targetpool_hp_percent"
						},
						{
							method = "lock_target_by_condition",
							param = "hp_percent_lowest"
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
											operator = "<=",
											method = "random",
											param = {
												num = 3,
												range = 6
											}
										},
										{
											param = "attack2_1",
											yield = true,
											method = "useSkill"
										},
										type = "sequence"
									},
									{
										{
											param = "attack3_1",
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
					},
					{
						{
							method = "lock_target_pool",
							param = "oponent"
						},
						{
							method = "lock_target_by_condition",
							param = "nearest"
						},
						{
							param = "max_range",
							operator = "<=",
							method = "check_target_distance"
						},
						{
							param = "attack1_1",
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
			type = "selector"
		},
		type = "sequence"
	}
}
