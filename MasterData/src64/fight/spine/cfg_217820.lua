local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 26,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 217810010,
				frame = 14
			}
		}
	},
	attack2 = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 217810010,
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
		totalframe = 50,
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
				frame = 23,
				id = 217820010
			},
			{
				frame = 24,
				id = 217820010
			},
			{
				frame = 25,
				id = 217820010
			},
			{
				frame = 26,
				id = 217820010
			},
			{
				frame = 27,
				id = 217820010
			},
			{
				id = 217820011,
				frame = 28,
				force = {
					{
						time = 0.2,
						distance = 300,
						object = "target"
					}
				}
			},
			{
				frame = 29,
				id = 217820012
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
		totalframe = 126,
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
				frame = 10,
				id = 217830010
			},
			{
				frame = 15,
				id = 217830010
			},
			{
				frame = 20,
				id = 217830010
			},
			{
				frame = 25,
				id = 217830010
			},
			{
				frame = 30,
				id = 217830010
			},
			{
				frame = 78,
				id = 217830011
			},
			{
				frame = 79,
				id = 217830012
			},
			{
				frame = 80,
				id = 217830013
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "217820_bg",
	totalframe = 126,
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
			texture = "role/217820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/217820_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {}
	}
}

return var_0_0
