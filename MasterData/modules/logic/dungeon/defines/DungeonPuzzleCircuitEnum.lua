-- chunkname: @modules/logic/dungeon/defines/DungeonPuzzleCircuitEnum.lua

module("modules.logic.dungeon.defines.DungeonPuzzleCircuitEnum", package.seeall)

local DungeonPuzzleCircuitEnum = _M

DungeonPuzzleCircuitEnum.hintCount = 3
DungeonPuzzleCircuitEnum.pipeEntryClearCount = 2
DungeonPuzzleCircuitEnum.pipeEntryClearDecimal = 10
DungeonPuzzleCircuitEnum.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
DungeonPuzzleCircuitEnum.type = {
	t_shape = 7,
	corner = 6,
	capacitance = 3,
	wrong = 4,
	power1 = 1,
	straight = 5,
	power2 = 2
}
DungeonPuzzleCircuitEnum.status = {
	correct = 2,
	error = 3,
	normal = 1
}
DungeonPuzzleCircuitEnum.res = {
	[DungeonPuzzleCircuitEnum.type.power1] = {
		"bg_zhogndian_1"
	},
	[DungeonPuzzleCircuitEnum.type.power2] = {
		"bg_zhogndian"
	},
	[DungeonPuzzleCircuitEnum.type.capacitance] = {
		"bg_dianyuan_1",
		"bg_dianyuan"
	},
	[DungeonPuzzleCircuitEnum.type.wrong] = {
		"bg_yichangqu"
	},
	[DungeonPuzzleCircuitEnum.type.straight] = {
		"bg_dianlu_1",
		"bg_dianlu_1_ovr",
		"bg_dianlu_1_dis"
	},
	[DungeonPuzzleCircuitEnum.type.corner] = {
		"bg_dianlu",
		"bg_dianlu_ovr",
		"bg_dianlu_dis"
	},
	[DungeonPuzzleCircuitEnum.type.t_shape] = {
		"bg_dianlu_2",
		"bg_dianlu_2_ovr",
		"bg_dianlu_2_dis"
	}
}
DungeonPuzzleCircuitEnum.rotate = {
	[DungeonPuzzleCircuitEnum.type.straight] = {
		[28] = {
			0
		},
		[46] = {
			90
		}
	},
	[DungeonPuzzleCircuitEnum.type.corner] = {
		[24] = {
			0
		},
		[26] = {
			90
		},
		[68] = {
			180
		},
		[48] = {
			270
		}
	},
	[DungeonPuzzleCircuitEnum.type.t_shape] = {
		[246] = {
			0
		},
		[268] = {
			90
		},
		[468] = {
			180
		},
		[248] = {
			270
		}
	}
}

return DungeonPuzzleCircuitEnum
