return {
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 51710001,
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
		totalframe = 44,
		animation = "skill",
		exe_tbl = {
			{
				id = 51720001,
				frame = 27,
				shake = {
					x = 2,
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
			},
			{
				id = 51720001,
				frame = 29,
				shake = {
					x = 2,
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
			},
			{
				id = 51720001,
				frame = 31,
				shake = {
					x = 2,
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
		totalframe = 75,
		animation = "xp",
		exe_tbl = {
			{
				frame = 43,
				behitted = "hitdown",
				id = 51730001,
				shake = {
					x = 0,
					y = 6
				}
			}
		}
	}
}
