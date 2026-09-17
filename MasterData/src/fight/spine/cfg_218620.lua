local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 218610010,
				frame = 20
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
		totalframe = 49,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 218620010
			},
			{
				frame = 30,
				id = 218620011
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	usexp1 = {
		totalframe = 116,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"241_xp",
					0.6
				}
			},
			{
				id = 218630010,
				behitted = "hitdown",
				frame = 10
			},
			{
				id = 218630010,
				behitted = "hitdown",
				frame = 25
			},
			{
				id = 218630010,
				behitted = "hitdown",
				frame = 40
			},
			{
				id = 218630010,
				behitted = "hitdown",
				frame = 55
			},
			{
				frame = 95,
				id = 218630011
			},
			{
				frame = 105,
				id = 218630012
			},
			{
				frame = 110,
				id = 218630013
			},
			{
				frame = 115,
				id = 218630014
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "218620_bg",
	totalframe = 116,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/218620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/218620_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 200,
				totalframe = 10,
				startframe = 14,
				time = 0.1
			}
		}
	}
}

return var_0_0
