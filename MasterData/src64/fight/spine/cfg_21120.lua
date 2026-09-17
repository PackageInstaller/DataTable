local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				}
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
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
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
	useskill1 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 20,
				id = 21121001,
				sound = {
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21120_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_1 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 20,
				id = 21121101,
				sound = {
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21120_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 20,
				id = 21121201,
				sound = {
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21120_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 20,
				id = 21121301,
				sound = {
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21120_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 61,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21100_xp"
				}
			},
			{
				frame = 33,
				id = 21150001,
				effect = {
					{
						ani = "skill",
						name = "21120_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21100_heal"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	totalframe = 43,
	bgfile = "21120_bg",
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
			texture = "role/21120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21120_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				startframe = 8,
				scale = 1.05,
				outtime = 0.1,
				totalframe = 21,
				intime = 0.1
			}
		},
		move = {}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "21120_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.3,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 21110001
			}
		}
	}
}

return var_0_0
