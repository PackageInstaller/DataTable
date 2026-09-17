local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				id = 26510010,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
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
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26520_skill",
					0.6
				}
			},
			{
				id = 26520010,
				frame = 26,
				effect = {
					{
						ani = "skill",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26520_xp",
					0.6
				}
			},
			{
				id = 26530010,
				frame = 12,
				effect = {
					{
						ani = "xp",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 26530010,
				frame = 17,
				effect = {
					{
						ani = "xp",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 26530010,
				frame = 21,
				effect = {
					{
						ani = "xp",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 26530010,
				frame = 27,
				effect = {
					{
						ani = "xp",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 26530010,
				frame = 35,
				effect = {
					{
						ani = "xp",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 26530010,
				frame = 41,
				effect = {
					{
						ani = "xp",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 26530011,
				frame = 64,
				behitted = "hitdown",
				effect = {
					{
						ani = "xp",
						name = "16550_26520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "26520_bg",
	locktarget = {
		maxdistance = 150,
		locktarget = true,
		mindistance = 150
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
			texture = "role/26520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26520_xp",
				1
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
