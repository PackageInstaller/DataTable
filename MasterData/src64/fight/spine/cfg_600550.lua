return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60055021,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "600550_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
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
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				id = 60055031,
				frame = 19,
				effect = {
					{
						ani = "attack",
						name = "600550_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
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
		turnbacklimit = true,
		totalframe = 35,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 6,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 125,
							time = 0.6
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 60055041,
				frame = 25,
				effect = {
					{
						ani = "attack",
						name = "600550_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	}
}
