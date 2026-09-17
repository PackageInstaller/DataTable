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
					"22120_attack",
					0.6
				}
			},
			{
				frame = 20,
				id = 217110010
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
		turnbacklimit = false,
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
				frame = 10,
				id = 217120011
			},
			{
				frame = 11,
				id = 217120010
			},
			{
				id = 217120012,
				behitted = "hitdown",
				frame = 15
			},
			{
				frame = 17,
				id = 217120013
			},
			{
				frame = 19,
				id = 217120014
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
		totalframe = 97,
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
				id = 217130010,
				behitted = "hitdown",
				frame = 50
			},
			{
				frame = 70,
				id = 217130011
			},
			{
				frame = 71,
				id = 217130013
			},
			{
				frame = 71,
				id = 217130012
			},
			{
				frame = 80,
				id = 217130014
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.3,
	bgfile = "217120_bg",
	totalframe = 90,
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
			texture = "role/217120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/217120_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {
		{
			totalframe = 5,
			startframe = 68,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1.2,
				anchory = 200,
				outtime = 0.3,
				totalframe = 28,
				intime = 0.2
			},
			{
				startframe = 20,
				scale = 1,
				anchory = 200,
				outtime = 0.5,
				totalframe = 28,
				intime = 0.2
			}
		},
		move = {
			{
				distanceY = 300,
				totalframe = 28,
				startframe = 0,
				time = 0.3
			},
			{
				distance = 400,
				totalframe = 28,
				startframe = 40,
				time = 0.3
			}
		}
	}
}

return var_0_0
