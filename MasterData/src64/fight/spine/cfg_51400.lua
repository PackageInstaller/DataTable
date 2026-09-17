local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 5140021,
				frame = 17
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
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 62,
		animation = "skill",
		action_on_start = {
			{
				startframe = 26,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.6
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 5140031,
				behitted = "hitdown",
				frame = 30
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
		totalframe = 114,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 5140061,
				frame = 36
			},
			{
				id = 5140061,
				frame = 48
			},
			{
				id = 5140061,
				frame = 63
			},
			{
				id = 5140062,
				frame = 85,
				forceY = {
					{
						speed = 600
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 114,
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
	}
}

return var_0_0
