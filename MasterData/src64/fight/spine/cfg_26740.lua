local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26720_attack",
					0.6
				}
			},
			{
				frame = 6,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26720_attack",
					0.6
				}
			},
			{
				frame = 6,
				bullet = "attack2"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "26740_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 26710010,
				frame = 7
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "26740_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 26710011,
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
	skillattackframe = 45,
	totalframe = 50,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26720_skill",
				0.6
			}
		},
		{
			id = 26720010,
			frame = 20,
			effect = {
				{
					ani = "skill",
					name = "26740_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 26720010,
			frame = 31,
			effect = {
				{
					ani = "skill",
					name = "26740_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 26720010,
			frame = 40,
			effect = {
				{
					ani = "skill",
					name = "26740_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 41,
			id = 26720011
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
				"26720_xp",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 26730010,
			frame = 60,
			shake = {
				x = 0,
				y = 20
			},
			effect = {
				{
					ani = "skill2",
					name = "26740_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "26740_bg",
	locktarget = {
		mindistance = 300,
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp"
		}
	},
	inserteffect = {
		{
			texture = "role/26720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26720_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 45,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.9,
				totalframe = 50,
				startframe = 40
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 50,
				startframe = 40,
				time = 0.5
			}
		}
	}
}

return var_0_0
