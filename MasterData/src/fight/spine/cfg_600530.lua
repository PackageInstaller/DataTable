return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		nextani = true,
		animation = "attack",
		exe_tbl = {
			{
				id = 60053021,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "600530_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack_tui = {
		totalframe = 30,
		nextani = true,
		animation = "attack",
		exe_tbl = {
			{
				id = 60053021,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "600530_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "walk"
			}
		}
	},
	walk = {
		turnbacklimit = true,
		totalframe = 20,
		animation = "walk",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -100,
							time = 0.5
						}
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
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				id = 60053031,
				frame = 13,
				effect = {
					{
						ani = "buff",
						name = "600530_effect",
						offsetZ = 1,
						offsetY = 1,
						offsetX = 0,
						object = "self"
					}
				}
			}
		}
	}
}
