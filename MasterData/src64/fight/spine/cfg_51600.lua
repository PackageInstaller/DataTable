local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 37,
		animation = "attack",
		exe_tbl = {
			{
				id = 5160021,
				frame = 21
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
		totalframe = 55,
		animation = "skill",
		exe_tbl = {
			{
				id = 5160031,
				frame = 30
			},
			{
				id = 5160032,
				frame = 38,
				force = {
					{
						shotdown = false,
						time = 0.5,
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
		xpeffect = "xp_effect",
		totalframe = 97,
		animation = "xp",
		action_on_start = {
			{
				startframe = 26,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 5160061,
				frame = 63
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 97,
	bgfile = "45080_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	camera = {
		move = {
			{
				distance = 200,
				time = 0.3,
				distanceY = 0,
				totalframe = 30,
				startframe = 46
			}
		}
	}
}

return var_0_0
