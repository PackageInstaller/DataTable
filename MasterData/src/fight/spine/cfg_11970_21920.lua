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
					"11970_21900_attack",
					0.6
				}
			},
			{
				frame = 12,
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
		skillattackframe = 45,
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"11970_21900_skill",
					0.6
				}
			},
			{
				id = 21922002,
				frame = 24
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
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				id = 21922102,
				frame = 24,
				sound = {
					"11970_21900_skill",
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
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				id = 21922202,
				frame = 24,
				sound = {
					"11970_21900_skill",
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
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				id = 21922302,
				frame = 24,
				sound = {
					"21920_skill",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 139,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"11970_21900_xp",
					0.6
				}
			},
			{
				frame = 40
			},
			{
				id = 21950001,
				frame = 48,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 56,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 64,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 72,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 80,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 88,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 96,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 104,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950001,
				frame = 112,
				shake = {
					x = 3,
					y = 3
				},
				effect = {
					{
						ani = "attack",
						name = "21900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 21950003,
				frame = 137
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 138,
	bgfile = "11970_21900_bg",
	locktarget = {
		mindistance = 240,
		locktargetpool = "oponent"
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
			texture = "role/21930.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21920_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 29,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 30,
				startframe = 0
			},
			{
				scale = 0.9,
				totalframe = 80,
				startframe = 36
			}
		},
		move = {
			{
				distanceY = 100,
				totalframe = 117,
				startframe = 0,
				time = 0.1
			},
			{
				distance = 230,
				totalframe = 80,
				startframe = 37,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "11970_21900_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 3,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		time = 0.2,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 5,
				id = 21910001
			}
		}
	}
}

return var_0_0
