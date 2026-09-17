local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack",
				sound = {
					"20300_attack",
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
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
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
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420101,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
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
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420201,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
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
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420301,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 68,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "21400_xp1"
			},
			{
				frame = 12,
				id = 21430001,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 18,
				id = 21430001,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 24,
				id = 21430001,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 30,
				id = 21430001,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 36,
				id = 21430001,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 42,
				id = 21430001,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 48,
				id = 21430001,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 54,
				id = 21430002,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 65,
	bgfile = "swim_bg",
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
			texture = "role/21403.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 2,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 60,
				startframe = 3
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 60,
				startframe = 3,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "21400_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 0.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 21410001
			}
		}
	}
}

return var_0_0
