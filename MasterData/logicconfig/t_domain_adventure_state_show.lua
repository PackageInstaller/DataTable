-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_state_show.lua

module("logicconfig.config.t_domain_adventure_state_show", package.seeall)

local title = {
	showType = 2,
	isAdjacentUnlock = 4,
	isAdjacentFire = 5,
	isSealFatherOcc = 9,
	isBossUnlock = 10,
	isRelFatherOcc = 8,
	eventType = 1,
	isBuff = 7,
	isOccupied = 6,
	sortGroups = 3
}
local dataList = {
	{
		1,
		0,
		"SortGroups_GroundDown"
	},
	{
		1,
		0,
		"SortGroups_ChunkMask",
		[6] = {
			"Empty",
			"OccMask"
		}
	},
	{
		1,
		0,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		1,
		0,
		"SortGroups_GroundMid",
		[6] = {
			"Skin",
			"Empty"
		}
	},
	{
		1,
		0,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		1,
		0,
		"SortGroups_GroundTop"
	},
	{
		1,
		0,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		1,
		0,
		"SortGroups_EventIcon"
	},
	{
		1,
		1,
		"SortGroups_GroundDown"
	},
	{
		1,
		1,
		"SortGroups_ChunkMask",
		[6] = {
			"NotOccMask",
			"OccMask"
		}
	},
	{
		1,
		1,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		1,
		1,
		"SortGroups_GroundMid",
		[6] = {
			"Skin",
			"Empty"
		}
	},
	{
		1,
		1,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		1,
		1,
		"SortGroups_GroundTop"
	},
	{
		1,
		1,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		1,
		1,
		"SortGroups_EventIcon",
		[6] = {
			"EventIconFight",
			"Empty"
		}
	},
	{
		2,
		0,
		"SortGroups_GroundDown"
	},
	{
		2,
		0,
		"SortGroups_ChunkMask",
		[6] = {
			"Empty",
			"OccMask"
		}
	},
	{
		2,
		0,
		"SortGroups_ChunkMaskTwo",
		{
			"Empty",
			"SolveFormUnlockMask"
		},
		{
			"Empty",
			"FireMask"
		},
		{
			"Empty",
			"Over"
		},
		[8] = {
			"Over",
			"Empty"
		}
	},
	{
		2,
		0,
		"SortGroups_GroundMid",
		[6] = {
			"Skin",
			"Empty"
		}
	},
	{
		2,
		0,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		2,
		0,
		"SortGroups_GroundTop"
	},
	{
		2,
		0,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		2,
		0,
		"SortGroups_EventIcon"
	},
	{
		2,
		1,
		"SortGroups_GroundDown"
	},
	{
		2,
		1,
		"SortGroups_ChunkMask",
		[6] = {
			"NotOccMask",
			"OccMask"
		}
	},
	{
		2,
		1,
		"SortGroups_ChunkMaskTwo",
		{
			"Empty",
			"SolveFormUnlockMask"
		},
		{
			"Empty",
			"FireMask"
		},
		{
			"Empty",
			"Over"
		},
		[8] = {
			"Over",
			"Empty"
		}
	},
	{
		2,
		1,
		"SortGroups_GroundMid",
		[6] = {
			"Skin",
			"Empty"
		}
	},
	{
		2,
		1,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		2,
		1,
		"SortGroups_GroundTop"
	},
	{
		2,
		1,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		2,
		1,
		"SortGroups_EventIcon",
		[6] = {
			"EventIconSolveForm",
			"Empty"
		}
	},
	{
		3,
		0,
		"SortGroups_GroundDown"
	},
	{
		3,
		0,
		"SortGroups_ChunkMask",
		[6] = {
			"Empty",
			"OccMask"
		}
	},
	{
		3,
		0,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		3,
		0,
		"SortGroups_GroundMid"
	},
	{
		3,
		0,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		3,
		0,
		"SortGroups_GroundTop"
	},
	{
		3,
		0,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		3,
		0,
		"SortGroups_EventIcon"
	},
	{
		3,
		1,
		"SortGroups_GroundDown"
	},
	{
		3,
		1,
		"SortGroups_ChunkMask",
		[6] = {
			"NotOccMask",
			"OccMask"
		}
	},
	{
		3,
		1,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		3,
		1,
		"SortGroups_GroundMid"
	},
	{
		3,
		1,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		3,
		1,
		"SortGroups_GroundTop"
	},
	{
		3,
		1,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		3,
		1,
		"SortGroups_EventIcon",
		[6] = {
			"EventIconDispatch",
			"Empty"
		}
	},
	{
		4,
		0,
		"SortGroups_GroundDown"
	},
	{
		4,
		0,
		"SortGroups_ChunkMask",
		[6] = {
			"Empty",
			"OccMask"
		}
	},
	{
		4,
		0,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		4,
		0,
		"SortGroups_GroundMid"
	},
	{
		4,
		0,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		4,
		0,
		"SortGroups_GroundTop"
	},
	{
		4,
		0,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		4,
		0,
		"SortGroups_EventIcon"
	},
	{
		4,
		1,
		"SortGroups_GroundDown"
	},
	{
		4,
		1,
		"SortGroups_ChunkMask",
		[6] = {
			"NotOccMask",
			"OccMask"
		}
	},
	{
		4,
		1,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		4,
		1,
		"SortGroups_GroundMid"
	},
	{
		4,
		1,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		4,
		1,
		"SortGroups_GroundTop"
	},
	{
		4,
		1,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		4,
		1,
		"SortGroups_EventIcon",
		[6] = {
			"EventIconGame",
			"EventIconGame"
		}
	},
	{
		5,
		0,
		"SortGroups_GroundDown"
	},
	{
		5,
		0,
		"SortGroups_ChunkMask"
	},
	{
		5,
		0,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		5,
		0,
		"SortGroups_GroundMid",
		[10] = {
			"Skin",
			"Skin"
		}
	},
	{
		5,
		0,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		5,
		0,
		"SortGroups_GroundTop"
	},
	{
		5,
		0,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		5,
		0,
		"SortGroups_EventIcon"
	},
	{
		5,
		1,
		"SortGroups_GroundDown"
	},
	{
		5,
		1,
		"SortGroups_ChunkMask",
		[6] = {
			"NotOccMask",
			"OccMask"
		}
	},
	{
		5,
		1,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		5,
		1,
		"SortGroups_GroundMid",
		[10] = {
			"Skin",
			"Skin"
		}
	},
	{
		5,
		1,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		5,
		1,
		"SortGroups_GroundTop"
	},
	{
		5,
		1,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		5,
		1,
		"SortGroups_EventIcon",
		[6] = {
			"EventIconBoss",
			"Empty"
		}
	},
	{
		6,
		0,
		"SortGroups_GroundDown"
	},
	{
		6,
		0,
		"SortGroups_ChunkMask",
		[6] = {
			"Empty",
			"OccMask"
		}
	},
	{
		6,
		0,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		6,
		0,
		"SortGroups_GroundMid",
		[6] = {
			"Skin",
			"Empty"
		}
	},
	{
		6,
		0,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		6,
		0,
		"SortGroups_GroundTop"
	},
	{
		6,
		0,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		6,
		0,
		"SortGroups_EventIcon"
	},
	{
		6,
		1,
		"SortGroups_GroundDown"
	},
	{
		6,
		1,
		"SortGroups_Chunk"
	},
	{
		6,
		1,
		"SortGroups_ChunkMask",
		[6] = {
			"NotOccMask",
			"OccMask"
		}
	},
	{
		6,
		1,
		"SortGroups_ChunkMaskTwo",
		[5] = {
			"Empty",
			"FireMask"
		}
	},
	{
		6,
		1,
		"SortGroups_GroundMid",
		[6] = {
			"Skin",
			"Empty"
		}
	},
	{
		6,
		1,
		"SortGroups_EventBuild",
		[7] = {
			"Empty",
			"BuffIcon"
		}
	},
	{
		6,
		1,
		"SortGroups_GroundTop"
	},
	{
		6,
		1,
		"SortGroups_Tag",
		[8] = {
			"RelLock",
			"Empty"
		},
		[10] = {
			"BossLock",
			"Empty"
		}
	},
	{
		6,
		1,
		"SortGroups_EventIcon",
		[6] = {
			"EventIconEliteFight",
			"Empty"
		}
	}
}
local t_domain_adventure_state_show = {
	{
		[0] = {
			SortGroups_GroundDown = dataList[1],
			SortGroups_ChunkMask = dataList[2],
			SortGroups_ChunkMaskTwo = dataList[3],
			SortGroups_GroundMid = dataList[4],
			SortGroups_EventBuild = dataList[5],
			SortGroups_GroundTop = dataList[6],
			SortGroups_Tag = dataList[7],
			SortGroups_EventIcon = dataList[8]
		},
		{
			SortGroups_GroundDown = dataList[9],
			SortGroups_ChunkMask = dataList[10],
			SortGroups_ChunkMaskTwo = dataList[11],
			SortGroups_GroundMid = dataList[12],
			SortGroups_EventBuild = dataList[13],
			SortGroups_GroundTop = dataList[14],
			SortGroups_Tag = dataList[15],
			SortGroups_EventIcon = dataList[16]
		}
	},
	{
		[0] = {
			SortGroups_GroundDown = dataList[17],
			SortGroups_ChunkMask = dataList[18],
			SortGroups_ChunkMaskTwo = dataList[19],
			SortGroups_GroundMid = dataList[20],
			SortGroups_EventBuild = dataList[21],
			SortGroups_GroundTop = dataList[22],
			SortGroups_Tag = dataList[23],
			SortGroups_EventIcon = dataList[24]
		},
		{
			SortGroups_GroundDown = dataList[25],
			SortGroups_ChunkMask = dataList[26],
			SortGroups_ChunkMaskTwo = dataList[27],
			SortGroups_GroundMid = dataList[28],
			SortGroups_EventBuild = dataList[29],
			SortGroups_GroundTop = dataList[30],
			SortGroups_Tag = dataList[31],
			SortGroups_EventIcon = dataList[32]
		}
	},
	{
		[0] = {
			SortGroups_GroundDown = dataList[33],
			SortGroups_ChunkMask = dataList[34],
			SortGroups_ChunkMaskTwo = dataList[35],
			SortGroups_GroundMid = dataList[36],
			SortGroups_EventBuild = dataList[37],
			SortGroups_GroundTop = dataList[38],
			SortGroups_Tag = dataList[39],
			SortGroups_EventIcon = dataList[40]
		},
		{
			SortGroups_GroundDown = dataList[41],
			SortGroups_ChunkMask = dataList[42],
			SortGroups_ChunkMaskTwo = dataList[43],
			SortGroups_GroundMid = dataList[44],
			SortGroups_EventBuild = dataList[45],
			SortGroups_GroundTop = dataList[46],
			SortGroups_Tag = dataList[47],
			SortGroups_EventIcon = dataList[48]
		}
	},
	{
		[0] = {
			SortGroups_GroundDown = dataList[49],
			SortGroups_ChunkMask = dataList[50],
			SortGroups_ChunkMaskTwo = dataList[51],
			SortGroups_GroundMid = dataList[52],
			SortGroups_EventBuild = dataList[53],
			SortGroups_GroundTop = dataList[54],
			SortGroups_Tag = dataList[55],
			SortGroups_EventIcon = dataList[56]
		},
		{
			SortGroups_GroundDown = dataList[57],
			SortGroups_ChunkMask = dataList[58],
			SortGroups_ChunkMaskTwo = dataList[59],
			SortGroups_GroundMid = dataList[60],
			SortGroups_EventBuild = dataList[61],
			SortGroups_GroundTop = dataList[62],
			SortGroups_Tag = dataList[63],
			SortGroups_EventIcon = dataList[64]
		}
	},
	{
		[0] = {
			SortGroups_GroundDown = dataList[65],
			SortGroups_ChunkMask = dataList[66],
			SortGroups_ChunkMaskTwo = dataList[67],
			SortGroups_GroundMid = dataList[68],
			SortGroups_EventBuild = dataList[69],
			SortGroups_GroundTop = dataList[70],
			SortGroups_Tag = dataList[71],
			SortGroups_EventIcon = dataList[72]
		},
		{
			SortGroups_GroundDown = dataList[73],
			SortGroups_ChunkMask = dataList[74],
			SortGroups_ChunkMaskTwo = dataList[75],
			SortGroups_GroundMid = dataList[76],
			SortGroups_EventBuild = dataList[77],
			SortGroups_GroundTop = dataList[78],
			SortGroups_Tag = dataList[79],
			SortGroups_EventIcon = dataList[80]
		}
	},
	{
		[0] = {
			SortGroups_GroundDown = dataList[81],
			SortGroups_ChunkMask = dataList[82],
			SortGroups_ChunkMaskTwo = dataList[83],
			SortGroups_GroundMid = dataList[84],
			SortGroups_EventBuild = dataList[85],
			SortGroups_GroundTop = dataList[86],
			SortGroups_Tag = dataList[87],
			SortGroups_EventIcon = dataList[88]
		},
		{
			SortGroups_GroundDown = dataList[89],
			SortGroups_Chunk = dataList[90],
			SortGroups_ChunkMask = dataList[91],
			SortGroups_ChunkMaskTwo = dataList[92],
			SortGroups_GroundMid = dataList[93],
			SortGroups_EventBuild = dataList[94],
			SortGroups_GroundTop = dataList[95],
			SortGroups_Tag = dataList[96],
			SortGroups_EventIcon = dataList[97]
		}
	}
}

t_domain_adventure_state_show.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_domain_adventure_state_show
