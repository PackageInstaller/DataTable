return {
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 51210001,
				frame = 14,
				effect = {
					{
						ani = "r_attack",
						name = "attack_effect",
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				id = 51220001,
				frame = 28,
				shake = {
					x = 4,
					y = 4
				}
			},
			{
				id = 51220001,
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
		totalframe = 81,
		animation = "xp",
		exe_tbl = {
			{
				frame = 35,
				id = 51230001,
				shake = {
					x = 0,
					y = 4
				},
				effect = {
					{
						ani = "r_attack",
						name = "attack_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 56,
				id = 51230001,
				shake = {
					x = 0,
					y = 4
				},
				effect = {
					{
						ani = "r_attack",
						name = "attack_effect",
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
