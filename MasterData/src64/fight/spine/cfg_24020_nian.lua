local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"240_atk",
					0.6
				}
			},
			{
				id = 24010001,
				frame = 13,
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
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
		totalframe = 62,
		animation = "skill",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				id = 24020001,
				frame = 27,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 24020001,
				frame = 37,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_1 = {
		totalframe = 62,
		animation = "skill",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				id = 24020101,
				frame = 27,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 24020101,
				frame = 37,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 62,
		animation = "skill",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				id = 24020201,
				frame = 27,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 24020201,
				frame = 37,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
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
		totalframe = 62,
		animation = "skill",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				id = 24020301,
				frame = 23,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 24020301,
				frame = 39,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "effect",
						name = "24020_effect",
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
		totalframe = 172,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 2,
				sound = {
					"240_xp",
					0.6
				}
			},
			{
				id = 24030001,
				frame = 156,
				shake = {
					x = 0,
					y = 10
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.25,
	bgfile = "14090_24020_bg",
	totalframe = 180,
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	show = {
		{
			action = "hide",
			startframe = 1,
			target = "target"
		},
		{
			action = "show",
			startframe = 141,
			target = "target"
		}
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG2"
		}
	},
	inserteffect = {
		{
			texture = "role/24020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/24020_xp"
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
