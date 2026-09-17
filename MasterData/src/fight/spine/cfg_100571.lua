return {
	xpeffect = {},
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10057120,
				frame = 16,
				effect = {
					{
						ani = "attack",
						name = "100571_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = -0.3,
						object = "target"
					}
				}
			}
		}
	},
	attackfly = {
		totalframe = 30,
		animation = "attack_fly",
		exe_tbl = {
			{
				id = 10057120,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "100571_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = -0.3,
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
	skill1_fly = {
		{
			{
				method = "useSkill",
				param = "useskill1_fly"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				id = 10057130,
				frame = 15
			}
		}
	},
	useskill1_fly = {
		totalframe = 30,
		animation = "skill_fly",
		exe_tbl = {
			{
				id = 10057130,
				frame = 15,
				effect = {
					{
						ani = "skill_fly",
						name = "100571_effect",
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
	usexp = {
		totalframe = 30,
		animation = "xp",
		exe_tbl = {
			{
				id = 10057160,
				frame = 20,
				effect = {
					{
						ani = "xp",
						name = "100571_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10057161,
				frame = 21
			}
		}
	},
	attackidle = {
		totalframe = 30,
		animation = "idel_fly"
	}
}
