local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				bullet = "attack",
				sound = {
					"21200_attack",
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
	useskill1 = {
		skillattackframe = 30,
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				frame = 9,
				effect = {
					{
						ani = "skill",
						name = "21220_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 21221001,
				sound = {
					"21200_attack",
					0.6
				}
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
	useskill1_1 = {
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				frame = 9,
				effect = {
					{
						ani = "skill",
						name = "21220_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 21221101,
				sound = {
					"21200_attack",
					0.6
				}
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
	useskill1_2 = {
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				frame = 9,
				effect = {
					{
						ani = "skill",
						name = "21220_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 21221201,
				sound = {
					"21200_attack",
					0.6
				}
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
	useskill1_3 = {
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				frame = 9,
				effect = {
					{
						ani = "skill",
						name = "21220_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 21221301,
				sound = {
					"21200_attack",
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
	usexp = {
		totalframe = 81,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21220-xp",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "xp"
			},
			{
				frame = 33,
				bullet = "xp"
			},
			{
				frame = 36,
				bullet = "xp"
			},
			{
				frame = 39,
				bullet = "xp"
			},
			{
				frame = 42,
				bullet = "xp"
			},
			{
				frame = 45,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 81,
	bgfile = "21220_bg",
	locktarget = {
		mindistance = 220,
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
			texture = "role/21220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21220_xp",
				0.6
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 63,
				startframe = 27,
				outtime = 0.1
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 63,
				startframe = 27,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "21220_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.375,
		offsetX = 0.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.66,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 21210001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "21220_effect",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.66,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 21250001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
