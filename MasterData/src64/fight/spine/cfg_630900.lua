return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
				id = 63090021
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
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 21,
				id = 63090031
			},
			{
				frame = 22,
				id = 63090032
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
		totalframe = 25,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 16,
				id = 63090041
			},
			{
				frame = 17,
				id = 63090042
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
		turnbacklimit = true,
		totalframe = 20,
		animation = "skill3",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 450,
							time = 0.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 1,
				id = 63090051
			},
			{
				frame = 2,
				id = 63090052
			},
			{
				frame = 10,
				id = 63090053
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
		totalframe = 65,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				frame = 21,
				id = 63090061
			},
			{
				frame = 22,
				id = 63090062
			},
			{
				frame = 46,
				id = 63090063
			},
			{
				frame = 50,
				id = 63090064
			}
		}
	}
}
