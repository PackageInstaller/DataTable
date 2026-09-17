local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 219510010,
				frame = 15,
				sound = {
					"20520-attack",
					0.6
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		skillattackframe = 45,
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 23,
				sound = {
					"20520-skill",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "skill1"
			}
		}
	},
	usexp = {
		totalframe = 78,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"219520-xp",
					0.6
				}
			},
			{
				id = 219530010,
				frame = 30
			},
			{
				id = 219530010,
				frame = 34
			},
			{
				id = 219530010,
				frame = 38
			},
			{
				id = 219530011,
				frame = 55
			},
			{
				id = 219530012,
				frame = 70
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 78,
	bgfile = "219520_bg",
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
			texture = "role/219520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/219520_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 720,
	offsetZ = 1,
	filename = "219520_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				id = 219520010
			}
		}
	}
}

return var_0_0
