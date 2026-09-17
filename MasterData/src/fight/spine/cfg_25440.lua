local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
				id = 25410001,
				sound = {
					"254_atk",
					0.6
				},
				effect = {
					{
						ani = "attack",
						name = "25440_effect",
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
		totalframe = 47,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"254_skill",
					0.6
				}
			},
			{
				id = 25420001,
				frame = 30,
				shake = {
					x = 0,
					y = 2
				},
				effect = {
					{
						ani = "attack",
						name = "25440_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.4,
						shutdown = true,
						distance = 250,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_1 = {
		totalframe = 47,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"254_skill",
					0.6
				}
			},
			{
				id = 25420101,
				frame = 30,
				shake = {
					x = 0,
					y = 2
				},
				effect = {
					{
						ani = "attack",
						name = "25440_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.4,
						shutdown = true,
						distance = 250,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 47,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"254_skill",
					0.6
				}
			},
			{
				id = 25420201,
				frame = 30,
				shake = {
					x = 0,
					y = 2
				},
				effect = {
					{
						ani = "attack",
						name = "25440_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.4,
						shutdown = true,
						distance = 250,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 47,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"254_skill",
					0.6
				}
			},
			{
				id = 25420301,
				frame = 30,
				shake = {
					x = 0,
					y = 2
				},
				effect = {
					{
						ani = "attack",
						name = "25440_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.4,
						shutdown = true,
						distance = 250,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 110,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				id = 25430001,
				frame = 1,
				sound = {
					"254_xp",
					0.6
				},
				effect = {
					{
						ani = "xp-attack",
						name = "25440_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "self"
					}
				},
				shake = {
					time = 0.2,
					x = 4,
					y = 8
				}
			},
			{
				frame = 110,
				id = 25430001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.1,
	totalframe = 110,
	bgfile = "25440_bg",
	locktarget = {
		locktargetpool = "self"
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
			texture = "role/25420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {},
	camera = {
		zoom = {}
	}
}

return var_0_0
