local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22900_attack",
					0.6
				}
			},
			{
				id = 202910010,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "102925_202920_effect",
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
	useskill1 = {
		totalframe = 60,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202920_skill",
					0.6
				}
			},
			{
				frame = 25,
				effect = {
					{
						ani = "skill2",
						name = "102925_202920_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = -0.8,
						object = "target"
					}
				}
			},
			{
				frame = 30,
				id = 202920010
			},
			{
				frame = 45,
				id = 202920011
			}
		}
	},
	usexp = {
		totalframe = 105,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202920_xp",
					0.6
				}
			},
			{
				frame = 97,
				effect = {
					{
						ani = "xp",
						name = "102925_202920_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 103,
				id = 202930010
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfile = "102925_202920_bg",
	totalframe = 105,
	bgfileflipX = false,
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
			texture = "role/202920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/202920_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 100,
			timescale = 0.3
		}
	},
	show = {
		{
			action = "show",
			startframe = 95,
			target = "target"
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.6,
				totalframe = 95,
				startframe = 0
			}
		}
	}
}

return var_0_0
