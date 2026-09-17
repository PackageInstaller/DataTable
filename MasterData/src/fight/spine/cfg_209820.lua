local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
		totalframe = 25,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 209810010,
				frame = 9
			}
		}
	},
	attack1 = {
		totalframe = 23,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 209810010,
				frame = 12
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
		totalframe = 45,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 23,
				id = 209820010
			},
			{
				frame = 24,
				id = 209820011
			}
		}
	},
	usexp = {
		totalframe = 88,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 41,
				id = 209830010
			},
			{
				frame = 48,
				id = 209830011
			},
			{
				frame = 54,
				id = 209830012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 87,
	bgfile = "209820_bg",
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
			texture = "role/209820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/209820_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 35,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 1,
				totalframe = 87,
				startframe = 35
			}
		},
		move = {
			{
				distance = 100,
				time = 0.5,
				distanceY = 0,
				totalframe = 87,
				startframe = 35
			}
		}
	}
}

return var_0_0
