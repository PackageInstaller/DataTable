return {
	attack = {
		totalframe = 33,
		animation = "attack",
		exe_tbl = {
			{
				id = 36110001,
				frame = 14,
				effect = {
					{
						ani = "attack",
						name = "36200_effect",
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
	useskill1 = {
		totalframe = 51,
		animation = "skill",
		exe_tbl = {
			{
				id = 36120001,
				frame = 32,
				shake = {
					x = 4,
					y = 4
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
		totalframe = 101,
		animation = "xp",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 36130001,
				frame = 60,
				shake = {
					x = 0,
					y = 8
				}
			}
		}
	}
}
