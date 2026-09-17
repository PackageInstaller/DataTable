local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				}
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
	filename = "28720_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 215910010,
				frame = 4
			}
		}
	}
}
var_0_0.attack_fly = {
	totalframe = 20,
	animation = "attack1_fly",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28720_attack2",
				0.6
			}
		},
		{
			id = 215910010,
			frame = 5,
			effect = {
				{
					ani = "attack_fly",
					name = "215920_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 215910010,
			frame = 10,
			effect = {
				{
					ani = "attack_fly",
					name = "215920_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 215910010,
			frame = 15,
			effect = {
				{
					ani = "attack_fly",
					name = "215920_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 215910010,
			frame = 20,
			effect = {
				{
					ani = "attack_fly",
					name = "215920_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
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
var_0_0.skill1_fly = {
	{
		{
			method = "useSkill",
			param = "use_skill1_fly"
		}
	}
}
var_0_0.useskill1 = {
	skillattackframe = 45,
	totalframe = 40,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 20,
			bullet = "skill"
		}
	}
}
var_0_0.extra.skill = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 400,
	offsetZ = 1,
	filename = "215920_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0.2,
		object = "target"
	},
	attack = {
		totalframe = 20,
		initposx = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 215920010,
				frame = 7
			},
			{
				id = 215920011,
				frame = 8
			},
			{
				id = 215920012,
				frame = 9
			}
		}
	}
}
var_0_0.use_skill1_fly = {
	skillattackframe = 45,
	totalframe = 40,
	turnbacklimit = true,
	animation = "skill_fly",
	exe_tbl = {
		{
			frame = 20,
			id = 215920010
		},
		{
			id = 215920011,
			frame = 21
		},
		{
			id = 215920012,
			frame = 22
		}
	}
}
var_0_0.usexp = {
	totalframe = 115,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28720_xp",
				0.6
			}
		},
		{
			frame = 54,
			id = 215930010
		},
		{
			frame = 55,
			id = 215930011
		},
		{
			frame = 56,
			id = 215930011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 115,
	bgfile = "215920_bg",
	locktarget = {
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
			texture = "role/215920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/28720_xp",
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

return var_0_0
