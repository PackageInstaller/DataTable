local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22900_attack",
					0.6
				}
			},
			{
				id = 28110010,
				frame = 20,
				effect = {
					{
						ani = "attack1",
						name = "18110_28120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 28110011,
				frame = 15,
				effect = {
					{
						ani = "attack2",
						name = "18110_28120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 400
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
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28120_skill",
					0.6
				}
			},
			{
				frame = 24,
				id = 28120010,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "18110_28120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "self"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 100,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28120_xp",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 28130010,
				frame = 16,
				forceY = {
					{
						speed = 750
					}
				},
				shake = {
					x = 0,
					y = 15
				}
			},
			{
				id = 28130010,
				frame = 35,
				forceY = {
					{
						speed = 400
					}
				}
			},
			{
				id = 28130010,
				frame = 40,
				forceY = {
					{
						speed = 400
					}
				}
			},
			{
				id = 28130010,
				behitted = "hitdown",
				frame = 45,
				forceY = {
					{
						speed = 400
					}
				}
			},
			{
				id = 28130011,
				behitted = "hitdown",
				frame = 83,
				shake = {
					x = 0,
					y = 20
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.5,
	totalframe = 100,
	bgfile = "marry_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		mindistance = 200,
		maxdistance = 200,
		locktargetpool = "oponent"
	},
	inserteffect = {
		{
			texture = "role/28120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/28120_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 75,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 74,
				startframe = 0
			}
		},
		move = {}
	}
}

return var_0_0
