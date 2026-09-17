return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 10032161,
				frame = 25,
				forceY = {
					speed = 300
				},
				effect = {
					{
						ani = "attack",
						name = "100321_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
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
	useskill1 = {
		totalframe = 40,
		animation = "skill1",
		exe_tbl = {
			{
				id = 10032171,
				frame = 15
			}
		}
	},
	useskill2 = {
		totalframe = 55,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10032181,
				frame = 24,
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 250,
						object = "target"
					}
				},
				effect = {
					{
						ani = "skill",
						name = "100321_effect",
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
		totalframe = 50,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"440100-attack1",
					1.2
				}
			},
			{
				id = 10032191,
				frame = 18,
				force = {
					{
						time = 0.4,
						shutdown = false,
						distance = 500,
						object = "target"
					}
				}
			}
		}
	}
}
