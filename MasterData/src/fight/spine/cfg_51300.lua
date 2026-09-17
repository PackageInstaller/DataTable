local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 5130021,
				frame = 14
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				id = 5130021,
				frame = 14
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
		totalframe = 23,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 7,
				behitted = "hitdown",
				id = 5130031,
				effect = {
					{
						ani = "skill",
						name = "51300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				frame = 17,
				behitted = "hitdown",
				id = 5130031,
				effect = {
					{
						ani = "skill",
						name = "51300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
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
		totalframe = 130,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 5130061,
				behitted = "hitdown",
				frame = 30
			},
			{
				id = 5130061,
				behitted = "hitdown",
				frame = 41
			},
			{
				id = 5130061,
				behitted = "hitdown",
				frame = 53
			},
			{
				id = 5130061,
				behitted = "hitdown",
				frame = 65
			},
			{
				id = 5130062,
				frame = 112,
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
	totalframe = 130,
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
