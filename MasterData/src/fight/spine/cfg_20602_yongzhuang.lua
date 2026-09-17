local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 29,
		animation = "attack",
		exe_tbl = {
			{
				id = 20610001,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "10660_20600_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20600_attack",
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
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20620001,
				frame = 22
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20620101,
				frame = 22
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20620201,
				frame = 22
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20620301,
				frame = 22
			}
		}
	},
	usexp = {
		totalframe = 67,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_xp"
				}
			},
			{
				frame = 37,
				id = 20632001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 67,
	bgfile = "swim_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/20602.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20620_xp"
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {}
	}
}

return var_0_0
