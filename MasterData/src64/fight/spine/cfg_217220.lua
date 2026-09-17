local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
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
				id = 217210010,
				frame = 17
			}
		}
	},
	attack2 = {
		totalframe = 30,
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
				id = 217210010,
				frame = 17
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
				frame = 20,
				id = 217220011
			},
			{
				frame = 26,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 27,
				id = 217220010
			},
			{
				frame = 27,
				id = 217220012
			},
			{
				frame = 28,
				id = 217220013
			},
			{
				frame = 49,
				id = 217220014
			}
		}
	},
	usexp = {
		totalframe = 78,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 217230010,
				frame = 29,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 38,
				id = 217230010
			},
			{
				frame = 48,
				id = 217230010
			},
			{
				frame = 58,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 58,
				id = 217230010
			},
			{
				frame = 58,
				id = 217230013
			},
			{
				frame = 68,
				id = 217230014
			},
			{
				frame = 71,
				id = 217230011
			},
			{
				frame = 72,
				id = 217230012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 78,
	bgfile = "217220_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/217220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/216420_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 200,
				time = 0.5,
				distanceY = 0,
				totalframe = 53,
				startframe = 15
			}
		}
	}
}

return var_0_0
