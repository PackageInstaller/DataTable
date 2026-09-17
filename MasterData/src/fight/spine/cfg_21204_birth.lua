local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
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
		totalframe = 24,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				effect = {
					{
						ani = "skill",
						name = "11250_21200_effect",
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
				frame = 14,
				id = 21220001,
				effect = {
					{
						ani = "attack",
						name = "11250_21200_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
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
		totalframe = 24,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				effect = {
					{
						ani = "skill",
						name = "11250_21200_effect",
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
				frame = 14,
				id = 21220101,
				effect = {
					{
						ani = "attack",
						name = "11250_21200_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
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
		totalframe = 24,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				effect = {
					{
						ani = "skill",
						name = "11250_21200_effect",
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
				frame = 14,
				id = 21220201,
				effect = {
					{
						ani = "attack",
						name = "11250_21200_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
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
		totalframe = 24,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				effect = {
					{
						ani = "skill",
						name = "11250_21200_effect",
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
				frame = 14,
				id = 21220301,
				effect = {
					{
						ani = "attack",
						name = "11250_21200_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
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
		totalframe = 97,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21200_xp"
				}
			},
			{
				frame = 30,
				effect = {
					{
						ani = "BG2",
						name = "21200_bg",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 31,
				bullet = "xp"
			},
			{
				frame = 40,
				bullet = "xp"
			},
			{
				frame = 49,
				bullet = "xp"
			},
			{
				frame = 58,
				bullet = "xp"
			},
			{
				frame = 67,
				bullet = "xp"
			},
			{
				frame = 76,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	bgfile = "21200_bg",
	totalframe = 96,
	bgfileflipX = true,
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
			texture = "role/21204.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21204_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 76,
			timescale = 0.1
		}
	},
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
				distance = 50,
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
	filename = "11250_21200_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.6,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
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
	maxdistance = 1000,
	movingtype = "locktime",
	speed = 1500,
	offsetZ = 1,
	filename = "11250_21200_effect",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.6,
		time = 0.1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 0,
				id = 21234001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				},
				shake = {
					x = 10,
					y = 0
				}
			}
		}
	}
}

return var_0_0
