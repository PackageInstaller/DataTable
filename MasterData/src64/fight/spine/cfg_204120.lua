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
					"23320_atk",
					0.6
				}
			},
			{
				frame = 18,
				id = 204110011
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
		totalframe = 60,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23320_atk",
					0.6
				}
			},
			{
				frame = 10,
				sound = {
					"23320_atk",
					0.6
				}
			},
			{
				frame = 25,
				id = 204120011
			},
			{
				frame = 45,
				id = 204120012
			},
			{
				frame = 40,
				id = 204120013
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
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203520_xp",
					0.6
				}
			},
			{
				frame = 50,
				id = 204130011
			},
			{
				frame = 65,
				id = 204130012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "204120_bg",
	totalframe = 65,
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
			texture = "role/204120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/204120_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 110,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 110,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
