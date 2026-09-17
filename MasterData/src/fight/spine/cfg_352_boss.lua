return {
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				id = 35210001,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "35200_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "skill_begin1"
			}
		}
	},
	skill_begin1 = {
		totalframe = 20,
		nextani = true,
		animation = "run",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 60,
							posx = 100
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				id = 35220001,
				frame = 17,
				effect = {
					{
						ani = "attack",
						name = "35200_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 76,
		animation = "xp",
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 60,
					posx = 100
				}
			}
		},
		exe_tbl = {
			{
				frame = 23,
				sound = "20200_attack",
				id = 35230001,
				effect = {
					{
						ani = "attack",
						name = "35200_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 0,
					y = 4
				}
			},
			{
				frame = 37,
				sound = "20200_attack",
				id = 35230001,
				effect = {
					{
						ani = "attack",
						name = "35200_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 0,
					y = 4
				}
			},
			{
				id = 35230002,
				sound = "20200_attack",
				frame = 57,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "35200_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 6
				}
			}
		}
	}
}
