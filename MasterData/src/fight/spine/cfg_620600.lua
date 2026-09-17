return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
				id = 62060021
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
		animation = "skill1",
		action_on_start = {
			{
				startframe = 21,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							frame = 7
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 4,
				id = 62060031
			},
			{
				frame = 35,
				id = 62060032
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 14,
				id = 62060041
			},
			{
				frame = 27,
				id = 62060042
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill3 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				id = 62060051,
				behitted = "hitdown",
				frame = 20
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
		totalframe = 61,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				frame = 35,
				id = 62060061
			},
			{
				frame = 40,
				id = 62060061
			},
			{
				frame = 45,
				id = 62060061
			},
			{
				frame = 50,
				id = 62060061
			},
			{
				frame = 60,
				id = 62060062
			}
		}
	}
}
