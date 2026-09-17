local var_0_0 = {
	xpeffect = {},
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				bullet = "attack",
				sound = {
					"23320_atk",
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
	useskill1 = {
		totalframe = 69,
		animation = "skill",
		exe_tbl = {
			{
				frame = 18,
				sound = {
					"23320_skill",
					0.6
				}
			},
			{
				frame = 20,
				id = 23320002
			},
			{
				id = 23320001,
				frame = 29,
				shake = {
					x = 4,
					y = 0
				},
				effect = {
					{
						ani = "skill1_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 50,
				id = 23320003
			}
		}
	},
	useskill1_1 = {
		totalframe = 69,
		animation = "skill",
		exe_tbl = {
			{
				frame = 18,
				sound = {
					"23320_skill",
					0.6
				}
			},
			{
				id = 23320101,
				frame = 28,
				shake = {
					x = 4,
					y = 0
				},
				effect = {
					{
						ani = "skill1_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"23320_skill",
					0.6
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 69,
		animation = "skill",
		exe_tbl = {
			{
				frame = 18,
				sound = {
					"23320_skill",
					0.6
				}
			},
			{
				id = 23320201,
				frame = 28,
				shake = {
					x = 4,
					y = 0
				},
				effect = {
					{
						ani = "skill1_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 69,
		animation = "skill",
		exe_tbl = {
			{
				frame = 18,
				sound = {
					"23320_skill",
					0.6
				}
			},
			{
				id = 23320301,
				frame = 28,
				shake = {
					x = 4,
					y = 0
				},
				effect = {
					{
						ani = "skill1_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 164,
		animation = "xp",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"23320_xp",
					0.6
				}
			},
			{
				id = 23330001,
				frame = 28,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 31,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 45,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 46,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 58,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 59,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 76,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 77,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 85,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 86,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 102,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 103,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 111,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 112,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 124,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 125,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330001,
				frame = 130,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 23330002,
				frame = 131,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "xp_attack",
						name = "13350_23340_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.25,
	totalframe = 164,
	bgfile = "23320_bg",
	locktarget = {
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
			texture = "role/23320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23320_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 120,
				startframe = 30
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 129,
				startframe = 35,
				time = 1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "13350_23340_effect",
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
				id = 23310001,
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

return var_0_0
