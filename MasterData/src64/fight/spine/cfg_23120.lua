local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 41,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23120_attack",
					0.6
				}
			},
			{
				frame = 27,
				bullet = "attack"
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
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				frame = 29,
				id = 231601001
			},
			{
				id = 23120001,
				frame = 30
			}
		}
	},
	usexp = {
		totalframe = 98,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "23120_xp1"
			},
			{
				frame = 50,
				id = 231601002
			},
			{
				frame = 52,
				id = 23150001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 97,
	bgfile = "23100_bg",
	locktarget = {
		locktargetpool = "self"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/23120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23120_xp"
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.9,
				totalframe = 50,
				startframe = 0
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "23100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.65,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 23110001
			}
		}
	}
}

return var_0_0
