return {
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 51410001,
				frame = 15,
				sound = {
					"huiwu",
					0.3
				}
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 51420001,
				frame = 23,
				shake = {
					x = 4,
					y = 0
				},
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 150,
						object = "target"
					}
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
		totalframe = 87,
		animation = "xp",
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 3,
					posx = 50
				}
			}
		},
		exe_tbl = {
			{
				frame = 25,
				id = 51430001,
				shake = {
					x = 4,
					y = 0
				}
			},
			{
				frame = 34,
				id = 51430001,
				shake = {
					x = 4,
					y = 4
				}
			},
			{
				frame = 48,
				id = 51430001,
				shake = {
					x = 4,
					y = 4
				}
			},
			{
				behitted = "hitdown",
				id = 51430001,
				frame = 62,
				forceY = {
					speed = 600
				},
				shake = {
					x = 8,
					y = 8
				}
			}
		}
	}
}
