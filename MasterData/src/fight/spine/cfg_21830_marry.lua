local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 27,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				bullet = "bullet1",
				sound = {
					"21630-attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				bullet = "bullet2",
				sound = {
					"21630-attack",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.bullet1 = {
	movingani = "run1",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "21800_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack1",
		exe_tbl = {
			{
				id = 28010001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.bullet2 = {
	movingani = "run3",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 640,
	offsetZ = 1,
	filename = "21800_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 2.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack3",
		exe_tbl = {
			{
				id = 28010002,
				frame = 1
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
var_0_0.skill1_1 = {
	{
		{
			method = "useSkill",
			param = "useskill1_1"
		}
	}
}
var_0_0.skill1_2 = {
	{
		{
			method = "useSkill",
			param = "useskill1_2"
		}
	}
}
var_0_0.skill1_3 = {
	{
		{
			method = "useSkill",
			param = "useskill1_3"
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21830-skill",
				0.6
			}
		},
		{
			id = 28020001,
			frame = 5,
			effect = {
				{
					ani = "buff1",
					name = "11810_21830_effect",
					offsetZ = 0.1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.useskill1_1 = {
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21830-skill",
				0.6
			}
		},
		{
			id = 28020101,
			frame = 5,
			effect = {
				{
					ani = "buff1",
					name = "11810_21830_effect",
					offsetZ = -1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 28020101,
			frame = 25,
			effect = {
				{
					ani = "buff1",
					name = "11810_21830_effect",
					offsetZ = -1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 45,
			id = 28020101
		}
	}
}
var_0_0.useskill1_2 = {
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21830-skill",
				0.6
			}
		},
		{
			id = 28020201,
			frame = 5,
			effect = {
				{
					ani = "buff1",
					name = "11810_21830_effect",
					offsetZ = -1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 28020201,
			frame = 25,
			effect = {
				{
					ani = "buff1",
					name = "11810_21830_effect",
					offsetZ = -1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 45,
			id = 28020201
		}
	}
}
var_0_0.useskill1_3 = {
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21830-skill",
				0.6
			}
		},
		{
			id = 28020301,
			frame = 5,
			effect = {
				{
					ani = "buff1",
					name = "11810_21830_effect",
					offsetZ = -1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 28020301,
			frame = 25,
			effect = {
				{
					ani = "buff1",
					name = "11810_21830_effect",
					offsetZ = -1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 45,
			id = 28020301
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = false,
	xpeffect = "xp_effect",
	totalframe = 102,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21830-xp",
				0.6
			}
		},
		{
			id = 28030001,
			frame = 35,
			effect = {
				{
					ani = "buff2",
					name = "11810_21830_effect",
					offsetZ = 0.1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 102,
	bgfile = "marry_bg",
	locktarget = {
		locktargetpool = "self",
		locktarget = true
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
			texture = "role/23830.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 180,
			sound = {
				"role_voice/21830_xp",
				1
			}
		}
	}
}

return var_0_0
