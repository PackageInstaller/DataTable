local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29520_attack",
					0.6
				}
			},
			{
				frame = 15,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 400,
	offsetZ = 1,
	filename = "19550_29520_effect",
	initpos = {
		offsetY = 0,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 29510010,
				frame = 7
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.skill1 = {
	{
		{
			method = "useSkill",
			param = "useskill1"
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 30,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			effect = {
				{
					ani = "skill2",
					name = "19550_29520_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"29520_skill",
				0.6
			}
		},
		{
			frame = 21,
			id = 29520010,
			forceY = {
				{
					speed = 1500
				}
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 90,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"29520_xp",
				0.6
			}
		},
		{
			frame = 30,
			id = 29530011
		},
		{
			frame = 36,
			id = 29530010
		},
		{
			frame = 50,
			id = 29530010
		},
		{
			frame = 61,
			id = 29530010
		},
		{
			frame = 66,
			id = 29530010
		},
		{
			frame = 72,
			id = 29530010
		},
		{
			frame = 76,
			id = 29530010
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "29520_bg",
	locktarget = {
		mindistance = 300,
		locktarget = true
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
			texture = "role/29520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/29520_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				pos = "target",
				totalframe = 60,
				startframe = 30,
				time = 0.1
			}
		}
	}
}

return var_0_0
