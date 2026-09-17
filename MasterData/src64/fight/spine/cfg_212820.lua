local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 25,
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
				id = 212810010,
				frame = 15
			}
		}
	},
	attack2 = {
		totalframe = 28,
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
				id = 212810010,
				frame = 14
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
				frame = 30,
				id = 212820010
			}
		}
	},
	usexp = {
		totalframe = 107,
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
				frame = 55,
				id = 212830010
			},
			{
				frame = 62,
				id = 212830010
			},
			{
				frame = 69,
				id = 212830010
			},
			{
				frame = 90,
				id = 212830010
			},
			{
				frame = 93,
				id = 212830011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 107,
	bgfile = "212820_bg",
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
			texture = "role/212820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/212820_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 180,
				time = 0.5,
				distanceY = 0,
				totalframe = 30,
				startframe = 40
			},
			{
				distance = 160,
				time = 0.2,
				distanceY = 0,
				totalframe = 20,
				startframe = 78
			}
		}
	}
}

return var_0_0
